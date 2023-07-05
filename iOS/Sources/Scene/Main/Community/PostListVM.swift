import Foundation
import RxCocoa
import RxSwift

class PostListVM: BaseVM {
    private let disposeBag = DisposeBag()
    struct Input {
        let getBoards: Driver<Void>
        let selectedIndex: Signal<IndexPath>
    }
    struct Output {
        let posts: BehaviorRelay<[Posts]>
        let nextID: BehaviorRelay<Int>
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let api = Service()
        let posts = BehaviorRelay<[Posts]>(value: [])
        let nextID = BehaviorRelay<Int>(value: 0)
        let result = PublishRelay<Bool>()

        input.getBoards.asObservable()
            .flatMap { _ in
                api.getBoards()
            }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    posts.accept(data?.postList ?? [])
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)

        input.selectedIndex.asObservable()
            .subscribe(onNext: { index in
                let value = posts.value
                nextID.accept(value[index.row].id)
                result.accept(true)
            }).disposed(by: disposeBag)

        return Output(posts: posts, nextID: nextID, result: result)
    }
}

class PostSearchVM: BaseVM {
    private let disposeBag = DisposeBag()

    struct Input {
        let textInput: Driver<String>
    }
    struct Output {
        let posts: BehaviorRelay<[Posts]>
    }
    func transform(_ input: Input) -> Output {
        let api = Service()
        let posts = BehaviorRelay<[Posts]>(value: [])

        input.textInput.asObservable()
            .flatMap { text in
                api.searchPost(text)
            }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    posts.accept(data?.postList ?? [])
                default:
                    print("Nothing Searched")
                }
            }).disposed(by: disposeBag)
        return Output(posts: posts)
    }
}

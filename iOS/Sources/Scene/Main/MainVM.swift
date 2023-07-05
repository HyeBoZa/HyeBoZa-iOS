import Foundation
import RxCocoa
import RxSwift

class MainVM: BaseVM {
    private let disposeBag = DisposeBag()
    struct Input {
        let getUser: Driver<String>
        let getCategory: Driver<String>
        let selectedIndex: Signal<IndexPath>
    }
    struct Output {
        let benefits: BehaviorRelay<[Benefits]>
        let nextID: BehaviorRelay<Int>
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let api = Service()
        let benefits = BehaviorRelay<[Benefits]>(value: [])
        let nextID = BehaviorRelay<Int>(value: 0)
        let result = PublishRelay<Bool>()
        let params = Driver.combineLatest(input.getUser, input.getCategory)

        input.getUser.asObservable()
            .withLatestFrom(params)
            .flatMap { user, category in
                api.getBenefits(user, category)
            }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    benefits.accept(data?.benefitList ?? [])
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)

        input.getCategory.asObservable()
            .withLatestFrom(params)
            .flatMap { user, category in
                api.getBenefits(user, category)
            }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    benefits.accept(data!.benefitList)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)

        input.selectedIndex.asObservable()
            .subscribe(onNext: { index in
                let value = benefits.value
                nextID.accept(value[index.row].id)
                result.accept(true)
            }).disposed(by: disposeBag)

        return Output(benefits: benefits, nextID: nextID, result: result)
    }
}

class SearchVM: BaseVM {
    private let disposeBag = DisposeBag()

    struct Input {
        let getUser: Driver<String>
        let getCategory: Driver<String>
        let textInput: Driver<String>
    }
    struct Output {
        let benefit: BehaviorRelay<[Benefits]>
    }
    func transform(_ input: Input) -> Output {
        let api = Service()
        let benefit = BehaviorRelay<[Benefits]>(value: [])
        let params = Driver.combineLatest(input.getUser, input.getCategory, input.textInput)

        input.textInput.asObservable()
            .withLatestFrom(params)
            .flatMap { user, category, title in
                if user == "" && category == "" {
                    return api.searchBenenfitWithTitle(title)
                } else if category == "" {
                    return api.searchBenenfitWithUserAndTitle(user, title)
                } else if user == "" {
                    return api.searchBenenfitWithCategoryAndTitle(category, title)
                } else {
                    return api.searchBenenfit(user, category, title)
                }
            }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    benefit.accept(data?.benefitList ?? [])
                    print("benefit", benefit)
                default:
                    print("Nothing Searched")
                }
            }).disposed(by: disposeBag)
        return Output(benefit: benefit)
    }
}

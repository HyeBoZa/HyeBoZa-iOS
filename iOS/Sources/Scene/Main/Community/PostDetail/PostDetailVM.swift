//
//  PostDetailVM.swift
//  HyeBoZa-iOS
//
//  Created by 강인혜 on 2023/07/06.
//  Copyright © 2023 com.HyeBoZa. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class PostDetailVM: BaseVM {
    private let disposeBag = DisposeBag()
    struct Input {
        let getDetail: Driver<Void>
        let postID: Driver<Int>
    }
    struct Output {
        let post: PublishRelay<Posts>
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let api = Service()
        let post = PublishRelay<Posts>()
        let result = PublishRelay<Bool>()

        input.getDetail.asObservable()
            .withLatestFrom(input.postID)
            .flatMap { id in
                api.getPostDetail(id)
            }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    post.accept(data!)
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)

        return Output(post: post, result: result)
    }
}

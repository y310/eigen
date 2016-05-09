import Quick
import Nimble
import Nimble_Snapshots
import Interstellar

@testable
import Artsy

class LiveAuctionBidButtonTests: QuickSpec {

    override func spec() {

        let examples:[String: LiveAuctionBidButtonState] = [
            "trial": .Active(biddingState: .TrialUser),
            "biddable": .Active(biddingState: .Biddable(askingPrice: 45_000_00)),
            "in progress": .Active(biddingState: .BiddingInProgress ),
            "failed": .Active(biddingState: .BidNetworkFail),
            "max bidder": .Active(biddingState: .BidSuccess(isMaxBidder: true)),
            "not max bidder": .Active(biddingState: .BidSuccess(isMaxBidder: false)),
            "waiting": .Active(biddingState: .LotWaitingToOpen),
            "sold": .Active(biddingState: .LotSold),
            "closed": .InActive(lotState: .ClosedLot),
            "upcoming": .InActive(lotState: .UpcomingLot),
        ]
 
        for (_, tuple) in examples.enumerate() {

            it("has valid snapshot \(tuple.0)") {
                let subject = LiveAuctionBidButton(progressSignal: Observable(tuple.1))
                subject.frame = CGRect(x:0, y:0, width:260, height: 60)
                expect(subject) == snapshot()
            }
        }
    }
}

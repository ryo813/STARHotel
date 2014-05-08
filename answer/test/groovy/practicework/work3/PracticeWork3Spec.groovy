package practicework

import geb.spock.GebSpec
import practicework.pages.ReserveConfirmGebPage
import practicework.pages.ReserveInputGebPage
import util.CalendarUtility

class PracticeWork3Spec extends GebSpec {
    def "OneCanReserveWith1Member"() {
        when:
        ReserveInputGebPage reserveInputGebPage = browser.to ReserveInputGebPage

        // 現在のシステム日付を起点に明日以降の直近の日曜日を取得します
        Calendar immediateSunday = CalendarUtility.getImmediateDayOfWeek(Calendar.getInstance(), Calendar.SUNDAY)
        int reserveYear = immediateSunday.get(Calendar.YEAR)
        int reserveMonth = immediateSunday.get(Calendar.MONTH) + 1
        int reserveDay = immediateSunday.get(Calendar.DAY_OF_MONTH)

        // 上記で取得した直近の土曜日を使用します
        reserveInputGebPage.setReserveDate(reserveYear, reserveMonth, reserveDay)
        reserveInputGebPage.reserveTerm = "3"
        reserveInputGebPage.headCount = "1"
        reserveInputGebPage.breakfast = false
        reserveInputGebPage.planA = false
        reserveInputGebPage.planB = false
        reserveInputGebPage.guestName = "abcd"
        reserveInputGebPage.goToNext()

        then:
        ReserveConfirmGebPage reserveConfirmGebPage = browser.at ReserveConfirmGebPage

        reserveConfirmGebPage.price.text()  == "22750"
        reserveConfirmGebPage.dateFrom.text() == reserveYear + "年" + reserveMonth + "月" + reserveDay + "日"
        reserveConfirmGebPage.dateTo.text() == reserveYear + "年" + reserveMonth + "月" + (reserveDay + 3) + "日"
        reserveConfirmGebPage.daysCount.text() == "3"
        reserveConfirmGebPage.headCount.text() == "1"
        reserveConfirmGebPage.breakfast.text() == "なし"
        !reserveConfirmGebPage.existsPlanA()
        !reserveConfirmGebPage.existsPlanB()
        reserveConfirmGebPage.guestName.text() == "abcd"
        reserveConfirmGebPage.commit();
   }
}

package Model;

import java.time.Month;
import java.util.ArrayList;

/**
 *
 * @author sabry
 */
public class Timeline {

    private ArrayList<Integer> yearValues;
    private ArrayList<boolean[][]> month_day;

    public Timeline() {
        this.yearValues = new ArrayList<>();
        this.month_day = new ArrayList<>();
    }

    public Timeline(ArrayList<Event> events) {
        this.yearValues = new ArrayList<>();
        this.month_day = new ArrayList<>();
        for (int i = 0; i < events.size(); i++) {
            int y = events.get(i).getYear();
            int m = events.get(i).getMonth();
            int d = events.get(i).getDay();
            this.add(y, m, d);
        }
    }

    public Timeline(ArrayList<Integer> yearValue, ArrayList<boolean[][]> month_day) {
        this.yearValues = yearValue;
        this.month_day = month_day;
    }

    public ArrayList<Integer> getYearValue() {
        return yearValues;
    }

    public void setYearValue(ArrayList<Integer> yearValue) {
        this.yearValues = yearValue;
    }

    public ArrayList<boolean[][]> getMonth_day() {
        return month_day;
    }

    public void setMonth_day(ArrayList<boolean[][]> month_day) {
        this.month_day = month_day;
    }

    public void add(int year, int month, int day) {
        if (!yearValues.contains(year)) {
            yearValues.add(year);
            boolean arr[][] = new boolean[13][32];
            // Intialize array
            for (int i = 0; i < 13; i++) {
                for (int j = 0; j < 32; j++) {
                    arr[i][j] = false;
                }
            }

            month_day.add(arr);
        }

        int index = yearValues.indexOf(year);
        boolean arr[][] = month_day.get(index);
        arr[month][day] = true;
        month_day.set(index, arr);
    }

    int getNumberOfMonth(String month) {
        return Month.valueOf(month.toUpperCase()).getValue();
    }

    public String getNameOfMonth(int month) {
        String[] monthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
        return monthNames[month - 1];
    }
}

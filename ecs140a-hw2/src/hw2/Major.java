package hw2;

public enum Major {
    GS {
        @Override
        public String toString() {
            return "Gaming Science";
        }
    },
    HM {
        @Override
        public String toString() {
            return "Hotel Management";
        }
    },
    LA {
        @Override
        public String toString() {
            return "Lounge Arts";
        }
    },
    BE {
        @Override
        public String toString() {
            return "Beverage Engineering";
        }
    };
}
import argparse

def convert_mm_to_inches(mm):
    """Convert millimeters to inches and round to 2 decimal places."""
    return round(mm / 25.4, 2)

def convert_inches_to_mm(inches):
    """Convert inches to millimeters and round to the nearest mm."""
    return round(inches * 25.4)

def main():
    parser = argparse.ArgumentParser(description="Convert measurements between millimeters and inches.")
    parser.add_argument('measurements', type=float, nargs='+', help='Measurements to be converted')
    parser.add_argument('--to-mm', action='store_true', help='Convert inches to millimeters instead of mm to inches')
    
    args = parser.parse_args()
    
    if args.to_mm:
        # Convert inches to mm
        results = [convert_inches_to_mm(measurement) for measurement in args.measurements]
        unit = "mm"
    else:
        # Convert mm to inches
        results = [convert_mm_to_inches(measurement) for measurement in args.measurements]
        unit = "inches"
    
    for measurement, result in zip(args.measurements, results):
        print(f"{measurement} -> {result} {unit}")

if __name__ == "__main__":
    main()


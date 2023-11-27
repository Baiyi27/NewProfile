import struct

def float_to_ieee754(f):
    # Convert the float number to IEEE 754 single and double precision binary representation
    ieee754_single_bin = format(struct.unpack('!I', struct.pack('!f', f))[0], '032b')
    ieee754_double_bin = format(struct.unpack('!Q', struct.pack('!d', f))[0], '064b')
    # Convert the float number to IEEE 754 single and double precision hexadecimal representation
    ieee754_single_hex = format(struct.unpack('!I', struct.pack('!f', f))[0], '08X')
    ieee754_double_hex = format(struct.unpack('!Q', struct.pack('!d', f))[0], '016X')
    return ieee754_single_bin, ieee754_double_bin, ieee754_single_hex, ieee754_double_hex

def format_binary_string(bin_str, separator=" "):
    # Format the binary string with the specified separator
    return separator.join([bin_str[i:i+4] for i in range(0, len(bin_str), 4)])

def ieee754_to_float(bin_str):
    if len(bin_str) == 32:
        # Convert IEEE 754 single precision binary representation to float number
        ieee754_int = int(bin_str, 2)
        f = struct.unpack('!f', struct.pack('!I', ieee754_int))[0]
    elif len(bin_str) == 64:
        # Convert IEEE 754 double precision binary representation to float number
        ieee754_int = int(bin_str, 2)
        f = struct.unpack('!d', struct.pack('!Q', ieee754_int))[0]
    else:
         raise ValueError("Invalid input. Please enter a 32-bit float or 64-bit double precision bin or hex.")
    return f

def convert_float_to_ieee754():
    while True:
        user_input = input("\nDecimal(exact): ('b' to go back): ")
        if user_input.lower() == 'b':
            break

        try:
            input_float = float(user_input)
            single_bin, double_bin, single_hex, double_hex = float_to_ieee754(input_float)

            #print(f"Decimal (exact): {input_float}")
            print("32 bit float->Bin: ", format_binary_string(single_bin))
            print("64 bit double->Bin:", format_binary_string(double_bin))

            print("32 bit float->Hex: ", format_binary_string(single_hex, " "))
            print("64 bit double->Hex:", format_binary_string(double_hex, " "))

        except ValueError:
            print("Invalid input. Please enter a valid float number or 'b' to go back.")

def convert_ieee754_to_float():
    while True:
        user_input = input("format bin or hex ('b' to go back): ")
        if user_input.lower() == 'b':
            break
        try:
            # Remove spaces from the input
            input_str = user_input.replace(" ", "")

            if len(input_str) == 32:
                # Input is a single precision binary representation
                result = ieee754_to_float(input_str)
                print("32-bit float:", result)
            elif len(input_str) == 64:
                # Input is a double precision binary representation
                result = ieee754_to_float(input_str)
                print("64-bit double:", result)
            elif len(input_str) == 8:
                # Input is a single precision hexadecimal representation
                bin_repr = bin(int(input_str, 16))[2:].zfill(32)
                result = ieee754_to_float(bin_repr)
                print("32-bit float:", result)
            elif len(input_str) == 16:
                # Input is a double precision hexadecimal representation
                bin_repr = bin(int(input_str, 16))[2:].zfill(64)
                result = ieee754_to_float(bin_repr)
                print("64-bit double:", result)
            else:
                raise ValueError("Invalid input. Please enter a 32-bit float or 64-bit double precision bin or hex.")
        except ValueError as e:
            print(e)

if __name__ == "__main__":
    print("IEEE 754 Floating Point Conversion Tool")
    while True:
        print("\n1. 浮点数转换为IEEE 754格式")
        print("2. IEEE 754格式转换为浮点数")
        print("3. 退出")
        choice = input("请选择操作(1/2/3): ")

        if choice == '1':
            convert_float_to_ieee754()

        elif choice == '2':
            convert_ieee754_to_float()

        elif choice == '3':
            print("Exiting the program.")
            break

        else:
            print("Invalid selection. Please select a valid option.")

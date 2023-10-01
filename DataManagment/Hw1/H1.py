# Q1
import math as m
def primes(n):
    is_prime = [True] * n
    is_prime[0] = is_prime[1] = False
    for current in range(2, int(n ** 0.5) + 1):
        if is_prime[current]:
            for multiple in range(current * current, n, current):
                is_prime[multiple] = False
    prime_numbers = [i for i in range(2, n) if is_prime[i]]

    return prime_numbers


# q2
def factor(n):
    # Get the list of prime numbers less than or equal to n
    prime_number = primes(n)

    # Initialize an empty list to store the prime factors
    prime_factors = []

    # Iterate through the prime numbers
    for prime in prime_number:
        # While n is divisible by the current prime number, add it to the prime factors list
        while n % prime == 0:
            prime_factors.append(prime)
            n //= prime  # Update n by dividing it by the prime factor

    return prime_factors


factor(40)


#Q3 
def increasing_digits(n):
    count = 0

    for num in range(1, n + 1):
        num_str = str(num)

        increasing = all(num_str[i] <= num_str[i+1]
                         for i in range(len(num_str) - 1))

        if increasing:
            count += 1

    return count


#Q4
def stats(inits):
    mean = sum(inits) / len(inits)

    #evulate the median
    sorted_nums = sorted(inits)
    n = len(sorted_nums)
    if n % 2 == 0:
        median = (sorted_nums[n // 2 - 1] + sorted_nums[n // 2]) / 2
    else:
        median = sorted_nums[n // 2]

    # evulate the standard deviation
    variance = sum((x - mean) ** 2 for x in inits) / (len(inits) - 1)
    std_deviation = m.sqrt(variance)

    return [mean, median, std_deviation]


#Q5
def zero_triples(inits):
    result = []
    inits.sort()  # Sort the input list in ascending order

    for i in range(len(inits) - 2):
        if i > 0 and inits[i] == inits[i - 1]:
            continue
        left = i + 1
        right = len(inits) - 1

        while left < right:
            total = inits[i] + inits[left] + inits[right]

            if total == 0:
                result.append([inits[i], inits[left], inits[right]])
                left += 1
                right -= 1
                while left < right and inits[left] == inits[left - 1]:
                    left += 1
                while left < right and inits[right] == inits[right + 1]:
                    right -= 1
            elif total < 0:
                left += 1
            else:
                right -= 1

    return result

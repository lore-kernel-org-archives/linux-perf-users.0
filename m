Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB818AFC
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Jan 2025 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738304142; cv=none; b=Sss7LqZuJ6HpP5KtgGMW0tn5HJ0jmIbY9Nh5bjszLAEkWIW8xfQk5O7zzfGf+dWPye0uklVOfpgo+3Ew5dD21Gr3Xp2rP6XJPHGEaOOhnaJw6G9gFpXLTD8j6w3QXyk476FMAtDyN+Z/Ue/13+wSlgsR8WX35fPYtpQotyUn6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738304142; c=relaxed/simple;
	bh=RxxPrg6jaSQftI0po8baqZ3npfg5ASzDp596iRVcIPI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oW5tYNsqYFmkGbZqntPpLEayPcsgncMPpykNN3I8H7sz+XbP5zg1ObGCTteWEn/VyZ2mIrS61LrBptGUrM0o4vUM+eIsj306IiBOTpYRBdogJA+N4YCHgW6kDTC0ROlZk13HupFxZNkq0ZHax/pBMovaKHq4C7ga/5MNhLrvOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqbBsJjB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqbBsJjB"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2156e078563so23287315ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jan 2025 22:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738304140; x=1738908940; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xVHwhLbm4yfV8B4CCAHICTNM0t/T9DK8FHPkN0u5euM=;
        b=EqbBsJjBtmhmlxshOObeyFUaygCzeGJjHR6xVNA/tSisn2E/RM7yx2AJ9M/dgwxbjH
         Vriy9XUgeKlPV5nN3rDKPuljKGiUHVACxkjVpF0n7wfzjIMgbmvRz2ERKZbkoBGHp1J8
         z2E4003TFE4owsd8usfhflIEoc7DPRfzCqIkCjQ3/6AfPC6Gp1vEKjE7K3wHXrAULZ2l
         e4qgMmiV0h+HJi1HQxl2vkAgV4U1gDY217ir04YFkrwjMw+zZJQOLKfVKqe9VRFswa+0
         sVEgGlsAVlPjIueJ88KUNXavBEPVeAYnMrE5VQUxzMxn0ANAC6XDLvppDUtss5Q5ilmI
         Xzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738304140; x=1738908940;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xVHwhLbm4yfV8B4CCAHICTNM0t/T9DK8FHPkN0u5euM=;
        b=iEIEYkFOskVyjNZn+EpFYhkfLu7aPKHdu4mGZqOLWl3Wu0fD5qxu0bqqfu8AkX0tcI
         TPKTkpspObkP18oD5XggcQjngJMurlcMNuPpIeFOQDxdXdgIKg27LGVdlFqsI+xU3m7e
         Riy1Xih+J4DNnxKfhZkww4khKh4LfRapNWqBjeRfxdFo7t54vIv9UIGfBgorxyA7WVYT
         a44QE7XNV1qGrwMrk3dRDsjc3JaNTE09ExLddwKc1ywWUAL0t0Th+M/p3Rovjafmf12V
         ve6ruZrfmT4bHRe3HEmH+nq2eRSoe/DQi74DMBY7b2O4mO05gv/BwODGbti7xwZIvdy8
         34Mw==
X-Gm-Message-State: AOJu0YwFZWvYNaAfp+Qq/iAYlZZSREYMxggTZs0Wq1Ed+FAPhIHjZcZW
	k3aDKjZVnt4yh7bkg8bUYA/HtqCVlLxn9ERnp6ePNc+SYTuuIHFjtbdzhEFl8hvMencfVbCeGJp
	tdl1BkWPZ7Jef5S+vc/3bQPMeHeVz/Ak7
X-Gm-Gg: ASbGncvv0OjjhqHMrH6exzQHPb5V+jchKM9BR3BHDUkSIFbN1YG/Y9lfYcnNZVty9DV
	TTzl+CC4UxNXTvNaIOwOGKKJjBeDzS7taQ7qQBcgeuNZyWmpeOquYl7vH9etXkLFQfHqmdYj6eA
	==
X-Google-Smtp-Source: AGHT+IEJv9cWBoFWaIGO6gZ4zzPCqoWPxSfMF3UZ+G3aq3gKgKNTM6jWPcF9xurT/sq2ar+oE8hbVN82yqh2mVr3DKA=
X-Received: by 2002:a05:6a21:7882:b0:1e7:6f82:3217 with SMTP id
 adf61e73a8af0-1ed7a5c2316mr14082747637.3.1738304139891; Thu, 30 Jan 2025
 22:15:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marko Mijalkovic <marko.mijalkovic97@gmail.com>
Date: Fri, 31 Jan 2025 01:15:24 -0500
X-Gm-Features: AWEUYZkT9iYMWjdEo3iYTBmhyTGvktgrdRqANRg8uP7Zcdh93jK9pNbk7jqaK6I
Message-ID: <CAEt8mWaSGHTjq9VSAdQky8mjj_A7LTJoZTaZ1e1S7WkZa7sw8w@mail.gmail.com>
Subject: [BUG] perf DWARF unwinding shows incorrect call graphs on AMD Ryzen 7950X
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

When profiling a C program with nested function calls using DWARF call graphs,
perf report shows incorrect relationships in the call graph, including
impossible self-calls and skipped stack frames. This issue occurs on an
AMD Ryzen 9 7950X but not on two Intel CPUs tested (including Intel
Core i9-14900HX).

Simple reproducer code:

#include <stdint.h>

#define VOLATILE_ACCESS(x) (*(volatile typeof(x)*)&(x))

__attribute__((noinline))
void spin(void) {
    const uint64_t ITERATIONS = 1000;
    uint64_t counter = 0;

    while (counter < ITERATIONS) {
        VOLATILE_ACCESS(counter);
        counter += 1;
    }
}

__attribute__((noinline))
void merge(void) {
    for (int i = 0; i < 100; i++) {
        spin();
    }
}

__attribute__((noinline))
void merge_all(void) {
    for (int i = 0; i < 1000; i++) {
        merge();
    }
}

int main(void) {
    for (int i = 0; i < 100; i++) {
        merge_all();
    }
    return 0;
}

Build & reproduce:

1. gcc -O3 -g test.c -o test
   (Issue also reproduces with clang: clang -O3 -g test.c -o test)
2. perf record --call-graph dwarf ./test
3. perf report --percent-limit 0

Current output (kernel 6.12.10):

-   99.99%     0.00%  main     main                  [.] _start
     _start
     __libc_start_main@@GLIBC_2.34
     __libc_start_call_main
   - main
      - 99.98% merge_all
         - 98.47% merge
            + 97.94% spin
              0.52% merge        <-- impossible self-call
              0.01% merge_all    <-- impossible parent call
           1.51% spin      <-- skipped merge() stack frame
        0.01% spin         <-- skipped merge_all() and merge() stack frames

Expected call hierarchy:
main
  |- merge_all
      |- merge
          |- spin

Additional testing reveals:

1. Using '-e cycles' fixes the call graph issues unless compiled with
   -fno-omit-frame-pointer

2. With -fno-omit-frame-pointer and -e cycles, we still see skipped frames:

Build:
gcc -O3 -g -fno-omit-frame-pointer test.c -o test

Record & report:
perf record -e cycles --call-graph dwarf ./test
perf report --percent-limit 0

Output:
-   99.98%     0.13%  main     main                  [.] merge
   - 99.85% merge        <-- orphan stack?
      + spin
   - 0.11% _start
        __libc_start_main@@GLIBC_2.34
        __libc_start_call_main
        main
        merge_all
        merge
   - 0.02% merge_all     <-- orphan stack?
        merge

System details:
- CPU: AMD Ryzen 9 7950X
- Kernel: 6.12.10
- perf version: 6.12.10
- gcc version: 14.2.1 20240912 (Red Hat 14.2.1-3)
- clang version: 18.1.8

I can provide additional information or test specific scenarios if needed.

Thanks,
Marko

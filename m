Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FE8C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Oct 2021 06:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8477B610F9
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Oct 2021 06:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhJNGxt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 02:53:49 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58563 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhJNGxt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Oct 2021 02:53:49 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MoeU5-1n7WR43Cht-00p0qS; Thu, 14 Oct 2021 08:51:43 +0200
Received: by mail-wr1-f41.google.com with SMTP id o20so16155263wro.3;
        Wed, 13 Oct 2021 23:51:43 -0700 (PDT)
X-Gm-Message-State: AOAM530xIU2MsIQEIKDOBHGB4hwNCEqNhNMvGoi4lN85TYopVEW40c5q
        alNuktdfd2aVUw5q/A4otH7A1QOuxxPHwr4jQvU=
X-Google-Smtp-Source: ABdhPJyjkQmPWKvwtoJuywMTwdaB2QbiQeIa9CvSMEZ8lo+ku78lzm6zV4NgWZcj6r9FJxHxXDzR/T1V0OVEWXe/2uU=
X-Received: by 2002:a1c:2358:: with SMTP id j85mr17404148wmj.1.1634194303392;
 Wed, 13 Oct 2021 23:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211014055527.1238645-1-alistair.francis@opensource.wdc.com> <20211014055527.1238645-2-alistair.francis@opensource.wdc.com>
In-Reply-To: <20211014055527.1238645-2-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Oct 2021 08:51:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3jyJvghm0yZA=fjaZfdKamb=-wPcF2LTFaPEn-KGzhiw@mail.gmail.com>
Message-ID: <CAK8P3a3jyJvghm0yZA=fjaZfdKamb=-wPcF2LTFaPEn-KGzhiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: futex: Use a 64-bit time_t
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair23@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atish.patra@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:uaIx0SONLfYOEYGGXqs6wd7mJ4VYpvjZSTe/4OrVu+w78Iu+rLv
 3xR1og+W5spFVDC/jx0Hs696hW3pG7CAJE+QwD+t2Z1XE+4med7uDJIacbv8hEbC4uxFO7f
 fyKDFjBwiT2xLNA4WufKdpEuLuxI3+bZrDBr3plBNsy381ODD/VxH6f6wZlcjB/baGgMj4h
 goaWOQ2CpqTQTR+KLBQIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ruxhhwKyz5w=:PS+2KOXKV4ntXskPdAlJp/
 q/+g3PgHyk9Vz2AN/W3qggiVyJ1HquvPBevqFioWwt1WX7vIqBJcUy/luuV8l/k/PdP8p5jtv
 GsQB0uymTDxYrFyC/iVaz5Bd1Ta62DfOSTy7+cNWKaMtU/JPRMI9QgA7Y44VZCL7dW46pNCyp
 0LwLtg74EDalw10iwC3WU/WioKYaWFmnw6fzqm8yGIN5g0coryzf+C3JGWi44Ta/TZ6hobGkd
 EdZK13aNM2+4sSY4D7z21faCaffleVh5u/dkJJNorOF8DCjFLzCzHVGHJOrfQ4hYZFQYeO1kU
 MxpSGNRhm0Ago+dExTumEjwFetsCMs8piyj130S+zkMzeNVfvKP2Ufk56yFH0e6PRxLU/HoGf
 Den6MWWLd4lyjpp8M6/sQ/q0sFEUcZJlevle5ZCyPa9WYQEGEq945XEQtom3ymKjwRdaUmGNt
 hqpP/JQNtImyzxdyDF//d6iYXuF0PYkx9XRrwTnoU9kHlyXyl4LjUltXCDDTlIF8Q2Kz0zonh
 2BtuiISuQyjKxpzU6aV4gfXig7+Xw5b/+ZBBF9LTdeI3GDNYReCIg1IhLnEME2/iMZDNgOWRw
 PbWiglUfZ3DMZv+Z28jp+wa79DXuKmtER7NdD2skexR7D/+/8Bhn9GwjSxnZMy7KLm6m2t8kU
 4fJ59xPlRzMspW9BZ3I+neKHHAz9/9FM+HqtgWofstuhWwais6fUC0ITlbSgiolh1CNyWRLqT
 z2e+jRdKv5SYfJCWGP2oTuMRJIn074else52vP5pZgURPhSODbZX9HRczBLRr962vjrQoU4j0
 +eal1jYONDyCIZHPoSjC9OhCoLjcXCQt5Vrooj/Aa41mv8Q01gvc3U3F3VCojRDH740MQpYvC
 A9ybPaDamyuT7IvwcRFg==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 14, 2021 at 7:55 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Convert the futex selftests to only use a 64-bit time_t. On 64-bit
> architectures this isn't a functional change. On 32-bit architectures
> we now only perform 64-bit time_t syscalls (__NR_futex_time64) and
> use a struct timespec64.
>
> This won't work on kernels before 5.1, but as perf is tied to the kernel
> that's ok.
>
> This allows the tests to run and pass on RISC-V 32-bit.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

This looks correct to me, two minor comments:

> +struct timespec64 {
> +       long long tv_sec;       /* seconds */
> +       long long tv_nsec;      /* nanoseconds */
> +};

This is a bit different from the normal timespec definition, which has to
use a '__kernel_long_t' tv_nsec for POSIX compliance. The difference
is harmless, because the bit layout has the lower 32 bits in the same
position, and the kernel zeroes the upper 32 bits on the syscall boundary.

I would just use

#define timespec64 __kernel_timespec

for the same effect, since that is what __kernel_timespec is meant for.

> +#if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> +# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
> +       syscall(__NR_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
> +#else
> +# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
> +       syscall(__NR_futex_time64, uaddr, op | opflags, val, timeout, uaddr2, val3)
> +#endif

The check for x32 user space looks correct here, but as I commented in
the other patch, I would keep it simple and use futex_time64() on all 32-bit
ABIs. There are approximately zero users of x32, and they don't benefit from
being able to run new perf binaries on pre-5.1 kernels when everyone else
can't.

        Arnd

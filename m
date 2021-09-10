Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D3AC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 07:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA2F611C0
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 07:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhIJHTL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 03:19:11 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:32801 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhIJHTK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 03:19:10 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mt6x5-1nD87K0HQv-00tSjk; Fri, 10 Sep 2021 09:17:59 +0200
Received: by mail-wr1-f50.google.com with SMTP id t18so1246551wrb.0;
        Fri, 10 Sep 2021 00:17:58 -0700 (PDT)
X-Gm-Message-State: AOAM530tUllB172YTRMIlok+K9DwPJDzESBRS5jfr291t5TAj24NDZGF
        +eSNYvoOWWHXFNQzKs7x0s8ftrCu4TyvcPpa/3k=
X-Google-Smtp-Source: ABdhPJwrbgLloo2fUfV0F1y+DjeVojddJo/NGS3JE8zJBWWUwMMXJyQ7U3KAVIMfF07awE0ex7J9mnAabJtokGqgvlQ=
X-Received: by 2002:adf:f884:: with SMTP id u4mr7688308wrp.411.1631258278655;
 Fri, 10 Sep 2021 00:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210910043102.3616198-1-alistair.francis@opensource.wdc.com> <20210910043102.3616198-2-alistair.francis@opensource.wdc.com>
In-Reply-To: <20210910043102.3616198-2-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Sep 2021 09:17:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ZmoUut+rQo7zcoRyT+Nsaw7Jk_qQ3YfsHb+Bzacn_nw@mail.gmail.com>
Message-ID: <CAK8P3a3ZmoUut+rQo7zcoRyT+Nsaw7Jk_qQ3YfsHb+Bzacn_nw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf bench: Add support for 32-bit systems with
 64-bit time_t
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
X-Provags-ID: V03:K1:yLyEBWzN8orKgC7JoBJLJBeID0xZqkk3Izp6B13iX96VT+NjRGz
 JiHtrBJIPGdThHoF/rvFsi0PFmToQvYZ7W2N31mzaTNPa0IVn1lc4q4rHGYu/oebXUMIwxL
 vV6Aqy562+i28WR49fsufcQAI2vdRuEQQJiLVWToR8ZFVEcFQtG643hvNsTH+NoxVlfQjeM
 4WVC110/4FvTYyduo6Mlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DwjTfUOniio=:RDyjFFbH4Ha44B/h1oPSCY
 l+i4gK/DLmUN2WopwCVOBWDXeIGokk9g3xTYJoMG3J+NvMNc501NGJ9dzZCfkrhAZ271NRlId
 cqAyHgMCzKhURYIV9npmg6BFxbr7OJvETq2Ey3PQCG5LcxdujHSnrc+MIYMvRgBFkXRsCZ5Wk
 3pkFYDveDBQAV/q/FyM219MKoXEq20klze7hY9waS0mKH5jROdxrKowQLSFF2NLTx7m8/VPuo
 6bP1TWoTS6oOuMMyvqZadKwfj3uR3WohoVdZ92vA1gl1aTOlOXs9JKynoUdyY66TI+9cmAdK/
 05+3Ad5Z59epnoihG8m75R7pC5D5+uTTj9q91d05bb2gLnbwzkyundNvg0E+zYbkpucL3Y5Hn
 GeK6qdqNBx+6ELcSw+/DMIuDyDP8BQsRmfJIZMrIJfAcfxTMmHtRI8C72nWPC8EVUGulSyjTW
 IwxSTkHW5DnC5rL+RpY3gbqz6eqyhK2F9eEA+6wYL/gV8Z8WgoSNC5s7R/qk+25pfl2bwT1ad
 dO9LuXhvf8o7wXlhoao0UF2iGhhFKkH3wlAsZkqEL7123M+YbRkef6awjw7wq09eXpBJ3RFoT
 1ajYUUMZ9+RZOHKjTG5oAkVDjxgd9wyr9LdR2cMdt6eO5IwJLGZYW2iN6N80Gx35yCz/t4Dxa
 bJPE+Rw5I/PoftbKwPwttNPm9weqBEJSbfnrK7GkB6yVyGXKx0FImfDl4qNqSkD1P6IWmgiOj
 da0kaAlFh/POjQ74WBbAIGwjbhMWXv41gC6PtQ==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 10, 2021 at 6:31 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
> time_t and as such don't have the SYS_futex syscall. This patch will
> allow us to use the SYS_futex_time64 syscall on those platforms.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  tools/perf/bench/futex.h | 43 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
> index f80a4759ee79b..09c5596726c60 100644
> --- a/tools/perf/bench/futex.h
> +++ b/tools/perf/bench/futex.h
> @@ -27,6 +27,12 @@ struct bench_futex_parameters {
>         unsigned int nrequeue;
>  };
>
> +/* A version of 'struct timespec' with 32-bit time_t and nanoseconds.  */
> +struct __timespec32 {
> +       __kernel_long_t tv_sec;
> +       __kernel_long_t tv_nsec;
> +};

Why not use the existing __kernel_old_timespec structure definition
from the header?

> +#if defined(SYS_futex)
> +       if (sizeof(*timeout) == sizeof(struct __timespec32))
> +               return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3);
> +
> +       if (timeout && timeout->tv_sec == (long)timeout->tv_sec) {
> +               struct __timespec32 ts32;
> +
> +               ts32.tv_sec = (__kernel_long_t) timeout->tv_sec;
> +               ts32.tv_nsec = (__kernel_long_t) timeout->tv_nsec;
> +
> +               return syscall(SYS_futex, uaddr, op | opflags, val, ts32, uaddr2, val3);
> +       } else if (!timeout) {
> +               return syscall(SYS_futex, uaddr, op | opflags, val, NULL, uaddr2, val3);
> +       }
> +#endif
> +
> +       errno = ENOSYS;
> +       return -1;

Similarly, I think just using the kernel's constants like __NR_futex instead of
SYS_futex would be more appropriate here, this way you know if futex_time64
is available and don't have to do the emulation for running the binary
on pre-5.1
kernels. Perf already uses __NR_perf_event_open, __NR_getcpu, and
__NR_setns instead of the SYS_* versions.

         Arnd

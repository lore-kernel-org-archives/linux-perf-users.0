Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFACC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 08:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2BAF61139
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 08:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhIIIVi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 04:21:38 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37951 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhIIIVh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 04:21:37 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MekvT-1my8LO16EH-00aq5T; Thu, 09 Sep 2021 10:20:27 +0200
Received: by mail-wm1-f44.google.com with SMTP id e26so719355wmk.2;
        Thu, 09 Sep 2021 01:20:27 -0700 (PDT)
X-Gm-Message-State: AOAM533UIItAzGCQjF5m2mdvmPxaTfGSnkPoOr/PZqGZmX+GNcnUri6v
        MOa+QO8ua6KGPKGERI9OA/jFU5WiTlwI9IA7iwY=
X-Google-Smtp-Source: ABdhPJxw9darBRLOGU9T/Ai9xJXwVS9kDLiVsvTLI0kWLzOUQXjodmhRhtE0vr7opzWdpEFtiXs19dy520OXKdt0Xg4=
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr1514862wmp.173.1631175626890;
 Thu, 09 Sep 2021 01:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210909042543.1982893-1-alistair.francis@opensource.wdc.com>
In-Reply-To: <20210909042543.1982893-1-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Sep 2021 10:20:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Udjzy=M4Vs8pGCKdedwtv-vPRjxbTcvTL6kP=yXSs0A@mail.gmail.com>
Message-ID: <CAK8P3a1Udjzy=M4Vs8pGCKdedwtv-vPRjxbTcvTL6kP=yXSs0A@mail.gmail.com>
Subject: Re: [PATCH] perf bench: Add support for 32-bit systems with 64-bit time_t
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
X-Provags-ID: V03:K1:awyyhFsU1jYtmonLl/6tOFZIx15FM7SK7uLUD8Bq2mKIcze7Aa5
 VwIIHz/ZH0wL9MVr62zbI2uY0rFZu8I48ZUPUFkq+zcp2OWZTPag9QkTVl9pKs8Hr9qFhQW
 dsvSr+cAsqHVn5RQBt0C1qL8MX0cC8Gu6yKad53vWB5eDyLXdXjsFjVSzWhYZI1kLD1KNPB
 GuyuxHRs3tz6DIMijWjIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lxpvQd3C128=:17V+5UmY6GsGWQrIe4mqKl
 j7Nb7xIKnfpwtbee0sf7UGHlfQM2kYcvLIbPqT5JWqbeHUeRxuk+4fj3zIvlxifWVx3r9Rhds
 a6h5uYTFj/g/MhtAECv0TeQTOL9zgpnlJUnid9ITLm43W6OT54X4A2jUs1rdBw0uZ3rNGQC5K
 3XNF360tmZSFiCixMz5l6UhP+gZdvJ/NNGrPGO2jbQddFD3+GMF8H1WggvWK8hXxYOhfc2y/X
 usJ8SkF9sSz6pr/KB2KSUVU6cHWmWw/a2i+c/UbwZedTc/425Nk/zCn1pGgCzHZ9fFYbg9RQh
 RIyCP1Wz5bL92EkF392/as4/9dE5ag8a8nT0qFflg9GbC5gEttV1qjbUaYHv9vGaLe74JTjmC
 DXzijK2snMpza+CUbbBdu2ed+C1AS9mcWA8srOmmr2xarXGqDW/VgfmnOM7zXD9031PapQmlI
 LX9855lxuH5I8z1OnaGx9VUPU9desyE69ZKfHkYk+C+bHj7kNQyuRAcZ81XrZdHG1e5yw/Wkq
 XCyMbRwAGl6yrnAciTdb3IeKQpAWWys4Wu9kcv4W+T0RfKK5MVr+WMTEoRU6H5/6lHLFlG5Sb
 sHzhSWjsrRi+JF6ImXMBG9Jwp7nSG7CGdwakB5F5yOCoXYbNr45HAnwCkEzxXveWQx/ZekoYb
 m0naUgqRlq2X980GjuB0rJ2ZzlNGV7aCGbRjOj/32TWJ42knOaDG3SSBQamKsD263BlZeRr0B
 Gu43PhK9PNOI0RssLmZVupNd6NsZIlXXLEq05r/7C9QO1BafCIOFSu+xkIWfWiB4qkFXHQt1M
 kn8lb4IJLPgpMb21Y4Ex/7vdJpB9dD66xILRrnb+pNHYDtLhJCfRH7Cqx5Fhx4YS0TuqTn6Ro
 afGcb7QhBLvbKu1kCV+w==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 9, 2021 at 6:25 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
> time_t and as such don't have the SYS_futex syscall. This patch will
> allow us to use the SYS_futex_time64 syscall on those platforms.
>
> This patch does not attempt to gracefully allow 32-bit architectures
> with both SYS_futex and SYS_futex_time64 to support a 64-bit time_t.
> This patch only applies to 32-bit architectures with a 64-bit time_t.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Hi Alistair,

I know you've made this mistake before and I've pointed it out
several times. Please don't do this again, and try to fix up the
ones you already broke!

> +/**
> + * Some newer 32-bit architectures (such as RISC-V 32-bit) don't have
> + * the SYS_futex syscall and instead only have the SYS_futex_time64 call.
> + * Let's ensure that those still compile and run by just using the
> + * SYS_futex_time64 syscall. On these systems `struct timespec` will use a
> + * 64-bit time_t so the SYS_futex_time64 call will work.
> + */
> +#if !defined(SYS_futex) && defined(SYS_futex_time64)
> + #define SYS_futex SYS_futex_time64
> +#endif

This cannot work, as two system calls take different arguments: futex() takes
a __kernel_old_timespec and futex_time64() takes a __kernel_timespec.

You cannot derive anything about the ABI of the C library based on whether
the macros are defined or not. Either you convert the arguments passed into
the system call into the format expected by the kernel, or you pick the
correct system call based on sizeof(struct timespec).

       Arnd

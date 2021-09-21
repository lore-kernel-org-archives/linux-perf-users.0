Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403E1C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 08:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DEC61181
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 08:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhIUIKJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 04:10:09 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52379 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhIUIKI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Sep 2021 04:10:08 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MUok5-1mJcZC1Csb-00QgVF; Tue, 21 Sep 2021 10:08:39 +0200
Received: by mail-wr1-f43.google.com with SMTP id t8so29588364wri.1;
        Tue, 21 Sep 2021 01:08:39 -0700 (PDT)
X-Gm-Message-State: AOAM531O3Bu8Xsc1krB8Y3q5vCx+SAhQZ9GshjuaAeQTTV3sg2nIzC0b
        IZGqldQ2SKT50mhX7SrmD//2WiH8Ibs8C2qtpf0=
X-Google-Smtp-Source: ABdhPJy6gNp3mnAgyb/iPHvO2OC6clNZlGkHnTCwBMBfOS6i3DFhHXtaQsZqW3ibIVTDOgQQF2uucpdNu1A4eKHz32Y=
X-Received: by 2002:adf:f481:: with SMTP id l1mr2382016wro.411.1632211718939;
 Tue, 21 Sep 2021 01:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
 <20210917061040.2270822-2-alistair.francis@opensource.wdc.com> <72990864-5ec6-1f73-efd9-61b667a172dd@collabora.com>
In-Reply-To: <72990864-5ec6-1f73-efd9-61b667a172dd@collabora.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Sep 2021 10:08:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3x_EyCiPDpMK54y=Rtm-Wb08ym2TNiuAZgXhYrThcWTw@mail.gmail.com>
Message-ID: <CAK8P3a3x_EyCiPDpMK54y=Rtm-Wb08ym2TNiuAZgXhYrThcWTw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf bench: Add support for 32-bit systems with
 64-bit time_t
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair23@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
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
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:2yF3PfTcmCw/0IsZGBaRWPlj+IyCqMBI9CMPm79Q8KL/6PWQNo9
 Q6LCo0fJITzs+lxJO9kzln0lfLXo0yaCv3Zlm+tHbhZVMYgz+foXCkR89UenROLJ6OuOsZ5
 vF+nr+8aYJ6TwO1u+GZQrIPkpUd2ssI1GFxplKeRQrv1vNA3fyuYF61Y5Q/InADiotHilTe
 9qhDO+IWqlqcVOiNwU30Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ePN22AnODOg=:cBr3hn4Wi3cbzGIiKUDsZN
 fwb3KrAmwoPq/FgFsC3UOYZz+EuCUMqMuO5YODB+GZ2fykVq8sBtqtaeeTDsWvyE5R++7ZfNH
 ZkabrmgHpUEN68Ooo+j3a2XLf13Tvi3ruDc7mbVwkUK+g54xDbQKpLnCG5L+LDP4Vy0on+kB2
 kXogpGzWyZaf7sXr/reZr8L3p+YoDKDRnTnKZ/htxqqvnP+QjJ6N9ZN55JkUpvtaVNUpd7RWn
 imPJa+QArdHl55tH1h1QmW/lztpLbHXGDvUTV57x4/jEX7x/HV8evYIcEaG/6VgtLmUAjI7/F
 Ze1UrAbbddllgNZ83Nxv6y6cLUGuXkp2ohUT3U6taGFEMdWnGokpA3SGrtoz2bp2bW/v2I8KZ
 8KT8Hi5trlkI1EPtaTpxQHm04Gt7smBaC0Vvl9aifjifNUIOXLssXKU2wf+Vld7M8Qc4rlzql
 7l/P6fLgRLuz/NvCO/42HVsfnV/A0yC/WVCUyEBSrkJ2WKSbyfETs/vwVUNmPL4eVCfzL2p+u
 XEgDPc1OwTvrn/NU380AwM8Mj7+EKmFqqGr3l+Fmy75O1kBbjZqzTrVtqSwBWhGva0UoIqAsQ
 ttr9ynx58EOGa8KvmU6rHY/7t4QPKF18d12Nx50Po9Rmaq6vF6aRMdDmr9hU6ks2gUYp3UhK3
 lgS5rnxxdVQB3dfDi4o9pF8HXVafL2RBiRm7mEpEa9MobIdSUSE7xzCeP5R+OBkKhEjUD0Xb4
 nEuen2i+YFBw1pSy8aZHF5Bu26ZgtCnePZZHTcmCW2w0YhQhXjBg7K3+nN2A3QmbteqxDKE/A
 I32UC2mDBSKBggPvYpj7dE/o12s47wsEeS3R8Y6vUugeyhmRJTpe9tHjF1tdJrutvUDy2acgG
 X+IdfDVN31T5JlMABIfw==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 21, 2021 at 12:47 AM André Almeida
<andrealmeid@collabora.com> wrote:
>
> #if defined(__i386__) || __TIMESIZE == 32
> # define NR_gettime64 __NR_clock_gettime64
> #else
> # define NR_gettime64 __NR_clock_gettime
> #endif
>
> struct timespec64 {
>         long long tv_sec;       /* seconds */
>         long long tv_nsec;      /* nanoseconds */
> };
>
> int gettime64(clock_t clockid, struct timespec64 *tv)
> {
>         return syscall(NR_gettime64, clockid, tv);
> }
>
> Then we can just use &timeout at __NR_futex_time64 for 32bit arch and at
> __NR_futex for 64bit arch.

This is still broken when you disable CONFIG_COMPAT_32BIT_TIME,
which disables all system calls that take time32 arguments.

> This might be a simpler solution to the problem that you are facing but
> I'm not entirely sure. Also, futex's selftests do use the timeout
> argument and I think that they also won't compile in 32-bit RISC-V, so
> maybe we can start from there so we can actually test the timeout
> argument and check if it's working.

I would love to see the wrapper that Alistair wrote as part of some kernel
uapi header provided to user space. futex is used by tons of applications,
and we never had a library abstraction for it, so everyone has to do these
by hand, and they all get them slightly wrong in different ways.

We normally don't do this in kernel headers, but I think the benefits
would be far greater compared to today's situation.

      Arnd

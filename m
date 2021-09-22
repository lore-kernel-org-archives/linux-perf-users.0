Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721A0C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 11:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4875961131
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 11:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhIVL3o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:29:44 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54689 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbhIVL3n (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 07:29:43 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mf0Ru-1n3yru1oWQ-00gY3D; Wed, 22 Sep 2021 13:28:12 +0200
Received: by mail-wr1-f48.google.com with SMTP id t8so5778316wrq.4;
        Wed, 22 Sep 2021 04:28:12 -0700 (PDT)
X-Gm-Message-State: AOAM5331qTdk/wBgbOmEdQ2DwA/D/XUOXqQkyfwtcoka3Obj6KA8mdFG
        rE7Z52jJJseEXexGUnAa/ykL37DWvBcr9dC1jCQ=
X-Google-Smtp-Source: ABdhPJzt4kksrUoZmyMjHfZ1cfXQn9J73x/e0ELvJ0CKV2Dc5dZsaGo4r7nOa+BZFW/ZNbjTdCnfWEpWCsmso267J14=
X-Received: by 2002:adf:f481:: with SMTP id l1mr10127682wro.411.1632310091979;
 Wed, 22 Sep 2021 04:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
 <20210917061040.2270822-2-alistair.francis@opensource.wdc.com>
 <72990864-5ec6-1f73-efd9-61b667a172dd@collabora.com> <CAK8P3a3x_EyCiPDpMK54y=Rtm-Wb08ym2TNiuAZgXhYrThcWTw@mail.gmail.com>
 <9db8c79a-f704-84ce-360b-84335f926a48@collabora.com>
In-Reply-To: <9db8c79a-f704-84ce-360b-84335f926a48@collabora.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Sep 2021 13:27:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0w4EOsSUThTAxrARPSyt+CGJTV4V4eeNmDNdG2Qrbq9w@mail.gmail.com>
Message-ID: <CAK8P3a0w4EOsSUThTAxrARPSyt+CGJTV4V4eeNmDNdG2Qrbq9w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf bench: Add support for 32-bit systems with
 64-bit time_t
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@opensource.wdc.com>,
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
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:oKhwyJ++5qnKLB6p9FS+cu930Y5F9WXu9M133KWxH5o4nnddAFw
 rGKInGG6tM1zE9NKRl6acRsqMXT1EFfuorv4PVM7fcyePALDt6Hlh2eiitcR88zqOVIQ8CG
 vpTcA7RcCwACytMxhm7KGVASJBFZ50NYE+1A0UqfnK/BtXOLXdlqg4nFFdONyH7GIEaczYL
 xab4rcZ3XqXs9ciJng+PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lKpsXYQVrnU=:Oz8wML5xCK4WnlSzkb4BHx
 3ZfPvaFlfHHqDD5X5HtTH9ZnCCnYIu9k+eeAS4W1xV3orN43eCL4qzW89bYUeWRXY+UKg8vMp
 IITMKNbzZWlp3m/QLx1jnnx7nw9mSVIXCfWpWQ4gW/VWQ9c2x/1KOLDhID5RarbgTfSpIjofP
 hVplTfNSymacFvho43p74m+lu2UoeI9mYt6aoOhCG93I9D/DWTON4GgdFQN1Wka3r8Pf22U/x
 LSwTS+w05WEYazzZ88D2ylWBEzLMQ1JY0hMKK5BvwQTYbcWxpLYzs+RNMkXDSg/xSm6U9VyBS
 bPUGiAp7NP+o5fNofOIZ6E/4oaqlN14iyV1VW8uCtziqqSb34qOwn1cdqa7SciqBpsQv8Krbn
 ElPWabW8i4t40T8Sf8nl1O+i+uQ75UDJ0DlYrps4zoK79YTtEsT3QgadhhFCHZKlAMNZ2Hvw9
 ZlUhQvKOXubqDy9OwuG4qirK6ujPL0FyZguXeKlBjwDAbQRbpwx6LxJASeh9hZyB3j6socMHe
 NsPU4l97HAJ2Jv54V0i1Tg9LfQsKbQcUQThi90eMT89PCfeItICpYJFrPJY1pF/8+SsH4frsy
 ynjuAlOo92I03/dqwjkrF/KaOk4L4Zyfjf3mZXGr8t+fbg26iHHVPpvOnacGodUd21GxmQsJU
 lfY2NL7cgRV4Uq0lWgtXGkt3/WRGpV0VQxiXerNw3xMXnfKxXtM9Y9aeq9qm1F3l3BFOoIHT2
 z2JzcYmy8JQrCFqLEKDImCjmbOUUz4PC8RLOgT9JvcLmjK9qaQeEAMCH+MxMHjzmKSm2qn8l3
 lk2fBWG8+llYK+YK8fAtHBEVzBAwDVKp/MdeZ+6q8MnyIediOHp4GBHBLH+kmdAZJzLBEHCHE
 eLpE+ojuF9n5rMxr2VFQ==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 22, 2021 at 1:06 AM André Almeida <andrealmeid@collabora.com> wrote:
> Às 05:08 de 21/09/21, Arnd Bergmann escreveu:
> > On Tue, Sep 21, 2021 at 12:47 AM André Almeida
> > <andrealmeid@collabora.com> wrote:
> >>
> >> #if defined(__i386__) || __TIMESIZE == 32
> >> # define NR_gettime64 __NR_clock_gettime64
> >> #else
> >> # define NR_gettime64 __NR_clock_gettime
> >> #endif
> >>
> >> struct timespec64 {
> >>         long long tv_sec;       /* seconds */
> >>         long long tv_nsec;      /* nanoseconds */
> >> };
> >>
> >> int gettime64(clock_t clockid, struct timespec64 *tv)
> >> {
> >>         return syscall(NR_gettime64, clockid, tv);
> >> }
> >>
> >> Then we can just use &timeout at __NR_futex_time64 for 32bit arch and at
> >> __NR_futex for 64bit arch.
> >
> > This is still broken when you disable CONFIG_COMPAT_32BIT_TIME,
> > which disables all system calls that take time32 arguments.
> >
>
> Oh, I think my point was confusing then. My suggestion was to use only
> the futex entry points that accepts time64, and to always use
> clock_gettime that uses time64, for all platforms. Then it will work if
> we disable CONFIG_COMPAT_32BIT_TIME.

Yes, that would be ok. It does require using at least linux-5.1, but we
perf is already sort-of tied to the kernel version.

        Arnd

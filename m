Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB7FC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 07:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344031AbhKZHcp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 02:32:45 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:46441 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359187AbhKZHap (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 02:30:45 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N8oKc-1mW8px1Dz4-015uBr; Fri, 26 Nov 2021 08:27:31 +0100
Received: by mail-wm1-f46.google.com with SMTP id y196so7311768wmc.3;
        Thu, 25 Nov 2021 23:27:22 -0800 (PST)
X-Gm-Message-State: AOAM532PJ5TLi39uUBALKFdumHYVhqQ/+IjIi3R4c8D46jKXHgLKF3OO
        j1mi+rd8pH2fwpSKWhB8KmT8F/dafBnKjZ7GyG4=
X-Google-Smtp-Source: ABdhPJwK86Skrk2YmCmSiuMFmnHaqvZ1U3KPASRzBlbM0wrP/xDhUqP4iFQAlSro++uvXuH7ec3ujn7iCmdS8Z6gAaY=
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr13791114wmn.98.1637911641786;
 Thu, 25 Nov 2021 23:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com> <20211126060024.3290177-5-alistair.francis@opensource.wdc.com>
In-Reply-To: <20211126060024.3290177-5-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Nov 2021 08:27:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a18g4J9k2GaPp2-MR3AGFi31yP_CkrqZUhELFyyJr_w-w@mail.gmail.com>
Message-ID: <CAK8P3a18g4J9k2GaPp2-MR3AGFi31yP_CkrqZUhELFyyJr_w-w@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] uapi: futex: Add a futex waitv syscall
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alistair Francis <alistair23@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hDMB6BPhy7ucXmPCswZzwURCLbdvyS1tqmVFI60//t5sIbWD5/o
 zeJNlVe/9CNnd5grUHhSwsf2CvHlZuYBqaF+5h1YSrYfgakho8p7JLvQtmxSWUrLp5MsqrL
 ev59aZEgvn7ybeLsVxe1TPwN7t7VZlxNlWYFhimuCcSnHM1nECoARDHK8FfPwOBG8sGPLPz
 bFxutrLaaEIdnUTP1svbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kh0i1O50Cto=:oRppCdZj7w8e2kkmC5I3Qp
 4w2g16rmLp2ArQjMoXSbGlUv1+W1zYuZoMI79ketRD73QMmTXgUfuHHuRe9jmL4MPcV/mxP6A
 gC2qewMmZvw6DQ9qrHXx937Yy1psZ2CKIL2TdkQOKhotPds+PhgSrY4LxSr5jhStJ3FFOTgvG
 LRp4Eirdd36eBxGQEEeJVapFHluXmdDds4QRVOrl1sOnG3k0hL5uVxc/dn/Koa0TdzRii3Zpf
 Tog2IFzjBTNLH5h4vDm7CZOtzKzmGHVhDXICXtdXLYSoN9XGmAvQu3u2d4iZ59pQ9++g4LaK9
 Ve73xQNKnmuRzdhF3RKmKUQHz5r6UX7nmvOzEHXq9CyHz1c9wQV7FYa2x58Vehgycp5Ag6+oY
 Ys38sBdqb02zKjBqIE0kz0SBvvM1NI8ihglQ+tIJ+R1bZphiFCR/KP+EfPVQxGOIwTBPbTH4O
 QwMfLhBJqn3Yy3lAshDo8opYqsQnBhslQxW6xDjP/3F3cgYEJtBgRmPPrbEGMLKK8jlBP3Y6F
 pBscGM15X2wjsVjMwAEQQCWEO20PpRPHFHvs5kaWBRVrSmzW9lpoNWJv2R67N1u8Eln2RapQW
 QWcnX18YWQFIM1iskvaJXoA7R/3M9++rMMOs/yF6Chnx27cjDH8kRVc1C62PxPzn4MsXfDZDT
 QT8G14KFG6dMBtCZo5FfErRIrWhzbVD6IFSqz4/MSFx5tuFgcsQ/PCgsSCSwUfRa+ADipXEko
 FX+PuaH1RmkSzKOB8QfCqfllZuWpZQQ69Vr0eQrYnNMRihzDyarSFLKcLvWq+6EyYTP+lGSyP
 hA5+M8xcvkTEKpsLg+Dgv0mZCgAT8nqido7+kzXRzm9BZhS6xAwbhQYmAtLM3TroALNbabv0i
 oW6Q965nzYHj/uX3Mc179PwWZt2pWJbVFPH87doKVq1WnzlcbfeobMxoACL9XOCILfYKBtbjX
 47vGt9FwwC759aK3jpvCEpneI5yjY1P8Z4LIO0scmq3Oi5se6Lh2JhweEiuib/9yDdeHytS1y
 /wCcAvWSVpVvEIYFI5TWgloJRq3Xr9I4danfxOzmnJV2BbZR3j8BnTT1SzQn/bP+S1xnvdFzS
 4wlbLqqjYo6kikKzgExs0WBDJmOyoUj5Aw8KTg1vDjFF3EUhH5vxy/RacgxGA2kcEeKuCCoxi
 2c3SI=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 26, 2021 at 7:00 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> This commit adds a futex waitv syscall wrapper that is exposed to
> userspace.
>
> Neither the kernel or glibc currently expose a futex wrapper, so
> userspace is left performing raw syscalls. As the futex_waitv syscall
> always expects a 64-bit time_t this can be tricky for 32-bit systems to
> get correct.
>
> In order to avoid userspace incorrectly passing the wrong timeouts let's
> expose a public helper function that ensures the kernel is passed the
> correct timeout struct.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> +/**
> + * futex_waitv - Wait at multiple futexes, wake on any
> + * @waiters:    Array of waiters
> + * @nr_waiters: Length of waiters array
> + * @flags: Operation flags
> + * @timo:  Optional timeout for operation
> + */
> +static inline int
> +__kernel_futex_syscall_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
> +                             unsigned long flags, struct timespec *timo, clockid_t clockid)

Same thing about the mismatched function name

       Arnd

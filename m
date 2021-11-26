Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06C0C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 07:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348129AbhKZH36 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 02:29:58 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:44177 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353246AbhKZH15 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 02:27:57 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MXYEr-1n7wfs36IZ-00Z0Rr; Fri, 26 Nov 2021 08:24:43 +0100
Received: by mail-wm1-f53.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso10010827wmr.4;
        Thu, 25 Nov 2021 23:24:43 -0800 (PST)
X-Gm-Message-State: AOAM533KFagvVUpnlGiBQsRgRI6y7wlQqQ93m/ydP9SfWoWta9eS07dF
        R9ph5OtC+meHZkRmFyh998u/za3eb4rHVg6BGc8=
X-Google-Smtp-Source: ABdhPJwAO3CUAvnlu6Qda1rXtP4fAQBHSqQQusqjcnXzgpNOGFGdcJ+o5PrYCGSoHD9L6TjxioravH6C0gmOepq7z4o=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr13024587wmi.173.1637911483399;
 Thu, 25 Nov 2021 23:24:43 -0800 (PST)
MIME-Version: 1.0
References: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com> <20211126060024.3290177-3-alistair.francis@opensource.wdc.com>
In-Reply-To: <20211126060024.3290177-3-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Nov 2021 08:24:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1sFSaMGhXkKJcLKgd68xSK3MMQuySXb62sWEacwzxt=g@mail.gmail.com>
Message-ID: <CAK8P3a1sFSaMGhXkKJcLKgd68xSK3MMQuySXb62sWEacwzxt=g@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] uapi: futex: Add a futex syscall
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
X-Provags-ID: V03:K1:OZ/uSEDC0g+pvoXH7tVbdJm7+l3DzPwQ86SqhTkvYzt90ZseHNN
 5KAlBpfHSFdnl42j4nnFobsl/Zpwgd9q64tGt21cRyat3PQFaf9h1vJyKYPYkOBs+XdnsLw
 BQJIa0lxXcP1wJbx0kiUPN5SSk7LmPh5n99ofsf11dyvXOYwN/B65sGp3s5cgnAwHK8WsBo
 hhbFWEcyN5bWaWjGOsM9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4ajmlY0db98=:zqgy+sdECuRY6C+J/IRw1B
 PW4aLCqGMpcn1st28d/YXqmJc6eW72fAnweHptDED0HdU5tymMb4+PxGvhGMjc8LzmG2tMMiJ
 iXok6UVnDtQikp4AO1q/feo+nALdVTVPUBoabn6tEJmvNCSfefFB02uVZyb0X6FjCpeV7dg0G
 j6xfjDhTu3W89gHHkYYoVEja+HgTjsCMsHwcWPzbbjExiHHhyTR5a/MjrKFZpe8Z70iv/T9w6
 wNmX2m5tOW70mNzhKr4FcYnbZvn1MGRvesirV+xnfo5YzRoHzDhw4yUF+8gR5HU9bE0+esJHc
 eT05EZmGVla+t5spiabl4PHECRAtAzQoJUlnnNCkaV/ppFUWN57935ymIqToR0/lCXxeyi9bW
 pfSl6BzkcckmAD7Bgjfa/kwZSSGeAuNCZhIJy4o6cQbuEhOzPgM2AGBgXKIPdDOAQkli46lhi
 e5WF35q2gtD4/s0iZcAzf9gTwyh7dlBdVG8vi9lMQcnwgQQ6RJ0BrzmR8m7EMgcd0iMxNOIcN
 BDGlllwqZS6zNHTmkcUPCvZ8AabdavuGKzfW+1uhbIcJ8AEyLPvsudJjANjSMnjiVN2QHQ2d4
 D1RD3xQzb3Be+o5Y73hto8nrJHyjht8tJHneYPosGKi6m9t2IjsDXcCYY5gmR9vQDSkhIa3Ny
 fGv5zYKBHhdP79BjUZlpZF2On8VH8JiqPzSt1V06xmycjYKz/Ik/bgOOfAjJX3I8UAQjCpyS6
 ln46INYlbsnU/QZEklEnJPGtFH8Jr6gOQVYUhRNkevP+snkZY2Yd8M0PpG1IZHJ2DIeZt27mK
 j3n6Oh+ZEvvDKS8Xzinak9A/8WNLz9qNdsuPjwZAx75CtDWgNI=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 26, 2021 at 7:00 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> This commit adds two futex syscall wrappers that are exposed to
> userspace.
>
> Neither the kernel or glibc currently expose a futex wrapper, so
> userspace is left performing raw syscalls. This has mostly been because
> the overloading of one of the arguments makes it impossible to provide a
> single type safe function.
>
> Until recently the single syscall has worked fine. With the introduction
> of a 64-bit time_t futex call on 32-bit architectures, this has become
> more complex. The logic of handling the two possible futex syscalls is
> complex and often implemented incorrectly.
>
> This patch adds two futux syscall functions that correctly handle the

s/futux/futex/

> time_t complexity for userspace.
>
> This idea is based on previous discussions:
> https://lore.kernel.org/lkml/CAK8P3a3x_EyCiPDpMK54y=Rtm-Wb08ym2TNiuAZgXhYrThcWTw@mail.gmail.com/
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

The implementation looks correct to me, the calling conventions seem
"good enough"
to me, but I wouldn't object if someone else can suggest a better interface.

One minor detail:

> +/**
> + * futex_syscall_timeout() - __NR_futex/__NR_futex_time64 syscall wrapper
> + * @uaddr:  address of first futex
> + * @op:   futex op code
> + * @val:  typically expected value of uaddr, but varies by op
> + * @timeout:  an absolute struct timespec
> + * @uaddr2: address of second futex for some ops
> + * @val3: varies by op
> + */
> +static inline int
> +__kernel_futex_syscall_timeout(volatile uint32_t *uaddr, int op, uint32_t val,
> +                     struct timespec *timeout, volatile uint32_t *uaddr2, int val3)

The two function names do not match the respective documentation.

        Arnd

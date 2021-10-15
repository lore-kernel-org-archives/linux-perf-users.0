Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C87DC433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 08:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5729D61181
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 08:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbhJOIHU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 04:07:20 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:46279 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbhJOIHJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 04:07:09 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MS1G7-1m90m913tL-00TUQ2; Fri, 15 Oct 2021 10:04:58 +0200
Received: by mail-wr1-f41.google.com with SMTP id t2so25008771wrb.8;
        Fri, 15 Oct 2021 01:04:57 -0700 (PDT)
X-Gm-Message-State: AOAM530FHdl4QLXhJTqD7jHFvLYo8WwDJ8c22vApkju4E6AB45xJwbpY
        EaJbNWP0GXaTz3rVG/EXJJL8no6bZYgWMliTaH0=
X-Google-Smtp-Source: ABdhPJyMHuHnDGl2si8ITF+4TGXXgV0nuTwHzfeF7WqCGbb9eY4i99zzKLMdO9DWc/nq3na7Ws9y9ewKPsg0Jk/Kqqs=
X-Received: by 2002:adf:f481:: with SMTP id l1mr12016275wro.411.1634285097750;
 Fri, 15 Oct 2021 01:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211015005634.2658470-1-alistair.francis@opensource.wdc.com>
In-Reply-To: <20211015005634.2658470-1-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Oct 2021 10:04:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a28zpO5Sy78CHts=p4G5v0bhxeCJhUK41bMQ8nqYV8z_A@mail.gmail.com>
Message-ID: <CAK8P3a28zpO5Sy78CHts=p4G5v0bhxeCJhUK41bMQ8nqYV8z_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf bench futex: Use a 64-bit time_t
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
X-Provags-ID: V03:K1:svj4o8UDMApwuFcuNXj7pxpjFVchrJM1P6yD6ye98s3GpluP7I1
 i5j3G+TKfv7DebTKtAn1BWAQhkjw8hWe7ePMxxNniwZPIUqFc/gAwyo6tOd8Bo+LY7QpONE
 vYa/o/fEhPSzTEVeOJUfdNIhxAPtSFe+IwvJ0bPy3b5YZKA2uFIYUpfVO+HQwM1SuJBDXhO
 u1RtYw8ejJI1ts2C8hJqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UtxibgzrXDc=:kaJU0WtF7yMJGGqC4gavvP
 kFbd6TFVczCNzYvaKSXy2ul4uUDDT987wwM1JL2sjTCNdHGQzmOOI9YB/pMxtkxxSQ0nUs+6P
 TwaNJd4u4HV+YJ2qM7ho6RYI+Dn+0u1fqPzxR4Xa/blTDbKRqxd3Bx4tWTi+X2h48xrUaDHNz
 GIfYg+uevWUujvou3+zB3pTIGs5eVKVjWdspq2KkVHhvsPuLQXXQIPH9o7h11mPHhcWzHtRa3
 1VYwUUO3MEIxkU0BX8uLaU/MJf+EHcdpGJs4+zZN/lwQ5XFN9X6h6ra0+8FjqnD+W7XGAdpi9
 y1ais6Jxz2+95Vsz8O/ai1ZQHJN+TpRIJArK8kRJ0StUFGc60znYu8rjuNDzojjPKWVyRR3sw
 7MEP+cxgZRF9ctL5c6klSkYkY8ZM1gHN1NgZ24fj+Z61iRKEVygJiQ5FE6/R5SWBUsDhVFaW8
 HS8fxhmFPkxWSY+cd0k29k3pUgshOiH6gTSfrfSlFd5tdsuky2wq9JohkTewQDpFFKFSTRYm9
 gaNym5Nf7U/nReJbYmQ46dFn2MdcZ6/lI/RZZqvwQ0QxYDHqUUPPK6GJNqyxCZ3vBZHMxZAZ3
 EeMOOY5M/lkLFbJOkfrdj9whtCwkrpJpeWJ3c1HuWGlGHvMhQrdzqvHVyjnVsLVoLkU5SNAeK
 NegUgBurcBvBRdxXYdG3JaCSEarYlX/J8tDm07NVBxHqHuc/GLgNNX3hVKqin4YqUmAVpptk1
 l9ivL4luwONEc2j2Y4hIr+XHdCBPZWaZb4pBxg==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Oct 15, 2021 at 2:56 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Convert tools/perf to only use a 64-bit time_t. On 64-bit architectures
> this isn't a functional change. On 32-bit architectures we now only
> perform 64-bit time_t syscalls (__NR_futex_time64) and use a struct
> timespec64.
>
> This won't work on kernels before 5.1, but as perf is tied to the kernel
> that's ok.
>
> This allows us to build perf for 32-bit architectures with 64-bit time_t
> like RISC-V 32-bit.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

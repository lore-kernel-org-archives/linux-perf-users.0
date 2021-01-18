Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2F7C433E0
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 20:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7797E22B49
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 20:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437737AbhART74 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 14:59:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437748AbhART7s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 14:59:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A87EA22D49
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 19:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610999947;
        bh=RCF30Vg+Wet2xG0r5EVf+JhKfFllDWby8xnGyCy3/os=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tb+LhWWVVm/CDSo5AOmq2nZBXXcERQnH6IFdRuOpDu/Hvo/Ry1txTMD23JffiNC2S
         ySl4dNCXQjXcuepatqXeakayxAabZzFOJce6/nKB+XLG7FIS3cpIGnzBqaRKWDFm5g
         SPY7Gj3RUDwl949l/coONnPhriIPEzHF5Taco5p1zg2jEq244dKlYB6g852yuG9m2g
         b/WDzqbIbiIR1tzmWYcMqXJQZWU42/BzhQdtIUZz3rGo7XOEucliupkF5pHBq1VLxq
         RujirAW0DaXDrQ7mInJLCYYvKgkd/cNFkpkKTq4zEFERZcx2KTy5MzaFzUcCOUCL/E
         eBczurIhN7N5Q==
Received: by mail-oo1-f50.google.com with SMTP id k7so4377353ooa.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 11:59:07 -0800 (PST)
X-Gm-Message-State: AOAM533kcy9/jAKqRLcpR3l9J6OutLLivv1ez2CtnDv2C+4c4v0FUJqi
        8j+97lCXXZt0Cm+dfLdb9N4ZfVN+CDTPQF5Mw/I=
X-Google-Smtp-Source: ABdhPJzZtNhOIcSnPc2C9uk4dCBsiSFAZW0suvVs39FcXLlFxO1IdYB5x2Ivodp8tsQXHrAXohEfi6f9S0TSFB1J1ic=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr527885ooj.15.1610999946950;
 Mon, 18 Jan 2021 11:59:06 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com> <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com> <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
 <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com> <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com>
In-Reply-To: <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 18 Jan 2021 20:58:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a31ssD+FS1tAUxVHzrtUz-L9=mYCbv=ShEMci_bDdiTAg@mail.gmail.com>
Message-ID: <CAK8P3a31ssD+FS1tAUxVHzrtUz-L9=mYCbv=ShEMci_bDdiTAg@mail.gmail.com>
Subject: Re: perf tools build broken for RISCV 32 bit
To:     Emiliano Ingrassia <ingrassia@epigenesys.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Khem Raj <raj.khem@gmail.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 18, 2021 at 4:33 PM Emiliano Ingrassia
<ingrassia@epigenesys.com> wrote:
> On Mon, Jan 18, 2021 at 04:19:47PM +0100, Arnd Bergmann wrote:
> > On Mon, Jan 18, 2021 at 3:53 PM Emiliano Ingrassia <ingrassia@epigenesys.com> wrote:
> > >
> > > Hi,
> > >
> > > after some searching I found this patch from Yocto project:
> > >
> > > https://www.mail-archive.com/linux-yocto@lists.yoctoproject.org/msg01004.html.
> > >
> > > I don't know if it's ever been proposed as mainline patch.
> > >
> > > What do you think about it? Could it be the right solution?
> >
> > No. While this makes it work on rv32, it does not fix it in a
> > way that makes it work on other architectures with a time64
> > libc. If you fix it, please do it in a way that works on all architectures.
>
> Ok, I totally agree with you on this point.
>
> So, it is right to conclude that the problem is not in perf
> implementation but in the libc implementation?
> That is, for example, glibc should define SYS_futex as SYS_futex_time64
> in case of riscv 32 bit because of its support to 64 bit time_t?

Actually, there might be a somewhat less ugly workaround, if we decide
to put a correct wrapper into the exported kernel headers, e.g. adding
something along these lines to include/uapi/linux/futex.h or a new header
from the kernel:

#ifndef __KERNEL__
#include <linux/futex.h>
#include <linux/time_types.h>
#include <asm/unistd.h>
#include <sys/time.h>
#include <unistd.h>
#include <errno.h>

#define __kernel_futex __kernel_futex
typedef union __attribute__ ((__transparent_union__)) {
       const struct timespec *timeout;
       unsigned int intval;
} __kernel_futex_union;

struct __kernel_old_timespec {
       __kernel_time_t tv_sec;                 /* seconds */
       long            tv_nsec;                /* nanoseconds */
};

static inline int __kernel_futex(int *uaddr, int op, int val,
                                 __kernel_futex_union val2,
                                 unsigned *uaddr2, int val3)
{
        int cmd = op & FUTEX_CMD_MASK;
        int ret = -ENOSYS;
#ifdef __NR_futex64
        {
                if (((cmd != FUTEX_WAIT) && (cmd != FUTEX_WAIT_BITSET)) ||
                    (sizeof(time_t) == sizeof(__u64))) {
                        ret = syscall(__NR_futex64, uaddr, op, val,
                                      val2.timeout, uaddr2, val3);
                }

                if (ret != -ENOSYS && ret != -EPERM)
                        return ret;
        }
#endif
#ifdef __NR_futex
        {
                if (((cmd != FUTEX_WAIT) && (cmd != FUTEX_WAIT_BITSET)) ||
                    sizeof(time_t) == sizeof(__kernel_long_t)) {
                        ret = syscall(__NR_futex, uaddr, op, val,
                                       val2.timeout, uaddr2, val3);
                } else {
                        struct __kernel_old_timespec oldtimeout = {
                                .tv_sec  = val2.timeout->tv_sec,
                                .tv_nsec = val2.timeout->tv_nsec,
                        };
                        ret = syscall(__NR_futex, uaddr, op, val,
                                      &oldtimeout, uaddr2, val3);
                }
        }
#endif
        return ret;
}
#endif /* __KERNEL__

With this, applications can be changed to define their own

#ifdef __kernel_futex
#define futex(uaddr, futex_op, val, val2, uaddr2, val3) \
      __kernel_futex(uaddr, futex_op, val, val2, uaddr2, val3)
#else
#define futex(uaddr, futex_op, val, val2, uaddr2, val3) \
       syscall(__NR_futex, uaddr, futex_op, val, val2, uaddr2, val3)
#endif

         Arnd

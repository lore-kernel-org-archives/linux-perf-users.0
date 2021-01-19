Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39B9C10F0B
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A552820706
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbhASQ5h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jan 2021 11:57:37 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:37096 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731022AbhASQyR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jan 2021 11:54:17 -0500
Received: by mail-ed1-f43.google.com with SMTP id g1so21693930edu.4
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Jan 2021 08:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yR8dIK/orzXgYEKKZk9jPHv718gnQo3qb0FCAvKRjzM=;
        b=KCbpnmGT0Z0oXVhrPqZTzK54DJ1vBxefEFUvGKSpmeYWTf2UFFqHGEcBN/8XAb08j0
         zjDYxGJgotsmo20XSPL6mmTAhLi2r0TmZghzoqziZRh60noz1ebr1Xyl27oBoyswglaI
         OhO2ihLobDBiS+sRjVKPpWxpSQf4UArsYtzbLTKkF5no8b/Sp9XH1zpdXOZgEareVluz
         gPhyUHyap7q2kZJTyecI+jW2fsgbHEqHQLmJmXPm/FvuLsN1Q8DYJUAAeS9AGbSHFT0X
         TL+y8aQBEvcZDW80szSzoqVU6t6ksEJ1CYKKM818PvT5VSP+/ZrqxufMPCTWxhG2hhTF
         4bmQ==
X-Gm-Message-State: AOAM532aALPC4gCqtqlZTE+9a4TexeMlazfMPoFlgOEMDdSzAUIDQytE
        DaihhHRuv81fuB1jeys4wrE=
X-Google-Smtp-Source: ABdhPJyWB0y3a76XgbNNmyM8Qmx+u1nG6SA4eGTgZhSfTWNvAY2s8xTOs6CA2MUPoyPqas2el754qg==
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr4147272edu.163.1611075214073;
        Tue, 19 Jan 2021 08:53:34 -0800 (PST)
Received: from ingrassia.epigenesys.com ([2.236.81.180])
        by smtp.gmail.com with ESMTPSA id he38sm10564648ejc.96.2021.01.19.08.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:53:33 -0800 (PST)
Date:   Tue, 19 Jan 2021 17:53:31 +0100
From:   Emiliano Ingrassia <ingrassia@epigenesys.com>
To:     Arnd Bergmann <arnd@kernel.org>
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
Subject: Re: perf tools build broken for RISCV 32 bit
Message-ID: <YAcOi0l44VTtd2LS@ingrassia.epigenesys.com>
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com>
 <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com>
 <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
 <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com>
 <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com>
 <CAK8P3a31ssD+FS1tAUxVHzrtUz-L9=mYCbv=ShEMci_bDdiTAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a31ssD+FS1tAUxVHzrtUz-L9=mYCbv=ShEMci_bDdiTAg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnd,

thank you for the support.

On Mon, Jan 18, 2021 at 08:58:50PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 18, 2021 at 4:33 PM Emiliano Ingrassia
> <ingrassia@epigenesys.com> wrote:
> > On Mon, Jan 18, 2021 at 04:19:47PM +0100, Arnd Bergmann wrote:
> > > On Mon, Jan 18, 2021 at 3:53 PM Emiliano Ingrassia <ingrassia@epigenesys.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > after some searching I found this patch from Yocto project:
> > > >
> > > > https://www.mail-archive.com/linux-yocto@lists.yoctoproject.org/msg01004.html.
> > > >
> > > > I don't know if it's ever been proposed as mainline patch.
> > > >
> > > > What do you think about it? Could it be the right solution?
> > >
> > > No. While this makes it work on rv32, it does not fix it in a
> > > way that makes it work on other architectures with a time64
> > > libc. If you fix it, please do it in a way that works on all architectures.
> >
> > Ok, I totally agree with you on this point.
> >
> > So, it is right to conclude that the problem is not in perf
> > implementation but in the libc implementation?
> > That is, for example, glibc should define SYS_futex as SYS_futex_time64
> > in case of riscv 32 bit because of its support to 64 bit time_t?
>
> Actually, there might be a somewhat less ugly workaround, if we decide
> to put a correct wrapper into the exported kernel headers, e.g. adding
> something along these lines to include/uapi/linux/futex.h or a new header
> from the kernel:
>
> #ifndef __KERNEL__
> #include <linux/futex.h>
> #include <linux/time_types.h>
> #include <asm/unistd.h>
> #include <sys/time.h>
> #include <unistd.h>
> #include <errno.h>
>
> #define __kernel_futex __kernel_futex
> typedef union __attribute__ ((__transparent_union__)) {
>        const struct timespec *timeout;
>        unsigned int intval;
> } __kernel_futex_union;
>
> struct __kernel_old_timespec {
>        __kernel_time_t tv_sec;                 /* seconds */
>        long            tv_nsec;                /* nanoseconds */
> };
>
> static inline int __kernel_futex(int *uaddr, int op, int val,
>                                  __kernel_futex_union val2,
>                                  unsigned *uaddr2, int val3)
> {
>         int cmd = op & FUTEX_CMD_MASK;
>         int ret = -ENOSYS;
> #ifdef __NR_futex64
>         {
>                 if (((cmd != FUTEX_WAIT) && (cmd != FUTEX_WAIT_BITSET)) ||
>                     (sizeof(time_t) == sizeof(__u64))) {
>                         ret = syscall(__NR_futex64, uaddr, op, val,
>                                       val2.timeout, uaddr2, val3);
>                 }
>
>                 if (ret != -ENOSYS && ret != -EPERM)
>                         return ret;
>         }
> #endif
> #ifdef __NR_futex
>         {
>                 if (((cmd != FUTEX_WAIT) && (cmd != FUTEX_WAIT_BITSET)) ||
>                     sizeof(time_t) == sizeof(__kernel_long_t)) {
>                         ret = syscall(__NR_futex, uaddr, op, val,
>                                        val2.timeout, uaddr2, val3);
>                 } else {
>                         struct __kernel_old_timespec oldtimeout = {
>                                 .tv_sec  = val2.timeout->tv_sec,
>                                 .tv_nsec = val2.timeout->tv_nsec,
>                         };
>                         ret = syscall(__NR_futex, uaddr, op, val,
>                                       &oldtimeout, uaddr2, val3);
>                 }
>         }
> #endif
>         return ret;
> }
> #endif /* __KERNEL__
>
> With this, applications can be changed to define their own
>
> #ifdef __kernel_futex
> #define futex(uaddr, futex_op, val, val2, uaddr2, val3) \
>       __kernel_futex(uaddr, futex_op, val, val2, uaddr2, val3)
> #else
> #define futex(uaddr, futex_op, val, val2, uaddr2, val3) \
>        syscall(__NR_futex, uaddr, futex_op, val, val2, uaddr2, val3)
> #endif
>
>          Arnd

I would like to do a recap on what we have so far.

The goal is to compile perf for RISCV 32 bit with glibc 2.32 which has support
for 64 bit time_t. The target kernel is 5.10.7 with option COMPAT_32BIT_TIME
enabled.

Actually in kernel 5.10.7 the file include/uapi/asm-generic/unistd.h contains
the definition of futex syscall based on some macros. In particular:
|...
|#if __BITS_PER_LONG == 32 || defined(__SYSCALL_COMPAT)
|#define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _32)
|#else
|#define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _64)
|#endif
|...
|/* kernel/futex.c */
|#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
|#define __NR_futex 98
|__SC_3264(__NR_futex, sys_futex_time32, sys_futex)
|#endif
|...
|#define __NR_futex_time64 422
|__SYSCALL(__NR_futex_time64, sys_futex)
|...

So, in case of 64 bit architecture or 32 bit architecture with macro
__ARCH_WANT_TIME32_SYSCALLS defined, __NR_futex is defined and the proper
syscall associated with it.

In other cases, that is 32 bit architecture without support for time32 syscalls,
__NR_futex is not defined. __NR_futex_time64 is defined instead.

The syscall futex() expects timespec kernel structure, while futex_time32()
takes the old_timespec32 kernel structure as timer parameter.

To call futex() syscall in userspace it is necessary to use syscall() and
SYS_futex. In particular this is true in glibc which does not provide a wrapper
for it.

The userspace header file bits/syscall.h contains the needed definitions:
|...
|#ifdef __NR_futex
|# define SYS_futex __NR_futex
|#endif
|
|#ifdef __NR_futex_time64
|# define SYS_futex_time64 __NR_futex_time64
|#endif
|...

In case of architecture without __NR_futex definition nor futex() wrapper,
the syscall function should be called with SYS_futex_time64 instead of the
classic SYS_futex. This is not backward compatible and also not documented
as far as I know.

How this problem is solved in real scenarios? For example how can pthread
library, which uses futex syscall, be compiled correctly in glibc?

The solution is quite simple, glibc has a file called sysdep.h which in case of
RISCV 32 bit contains the following workarounds:
|...
|#if __WORDSIZE == 32
|
|/* Workarounds for generic code needing to handle 64-bit time_t.  */
|
|/* Fix sysdeps/unix/sysv/linux/clock_getcpuclockid.c.  */
|#define __NR_clock_getres       __NR_clock_getres_time64
|/* Fix sysdeps/nptl/lowlevellock-futex.h.  */
|#define __NR_futex              __NR_futex_time64
|...

So, in that case, __NR_futex is defined as __NR_futex_time64 and so SYS_futex is
defined and usable.

But this file can not be seen and used by userspace application.

So, what should be the right solution here?

Should the kernel export only __NR_futex and then check the timer struct
dimension and distinguish the various cases (time32 vs time64 futex)?

Or should the libc implementation take care to define SYS_futex once and for all
and then use the proper __NR_futex{_time64} based on its definition of time_t?

Considering that this is not only a problem of futex but of many others syscalls
(e.g. __NR_clock_gettime{64}, __NR_clock_settime{64}, and so on), probably
I would argue that the problem should be solved in the libc implementation
in some way.

What do you think?


Thank you, best regards.

Emiliano

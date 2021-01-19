Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1F5C433E0
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 19:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0842310B
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 19:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbhASTta (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbhASTtJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jan 2021 14:49:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9CF12313C
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Jan 2021 19:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611085696;
        bh=j6n8yI1MDAH7PE11JhncCRXL95geAhKTsTHzJxlfXcE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cxKFazurcISUU3RjW++AUJCBGOCbdk1i9YilIenQqZOtPPs/uMFXaniq32NTy23Ai
         zxKQeVgkRjwn9zqxOEcp4Lzt7co95CT0UkokTfjkc2yV7f181FygUo/zdXbq0puAIf
         CEsDWhKTyTybw75XNZugSmYPb9fQNDfzmor7gqUKJFKxpw6oFSp8KoeM0M9GqMYdUn
         8zRxau92FIwlFE6CXsWQECKFYibwJTZJg3G22JH3jGElZW8bnAh2x4kggbJsm9dGvX
         YA6w3FzY4++1LL0xMXp/wznO4WuB8jIAAfrPMLRPj03M09LC30xpaHayWkgw6y6/iv
         3PhcYIm03kjSw==
Received: by mail-oi1-f181.google.com with SMTP id p5so22485262oif.7
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Jan 2021 11:48:16 -0800 (PST)
X-Gm-Message-State: AOAM532MceYl1DIaDqFR51nlFgJ+8lcUKJxPLbcYcQxF78cEEM3IA28u
        fxq0TFgLB1W5TKguSTn1bdU3PmgX0erGA3aaBv8=
X-Google-Smtp-Source: ABdhPJybeBxNilCd4ZBKXuAiNvqyTyPxxCK2TM2HNQhG530/No1r1iG5Jr7OdvURNxVplXmrYO75E2PJ4ve8JtGQT/0=
X-Received: by 2002:aca:44d:: with SMTP id 74mr885932oie.4.1611085695958; Tue,
 19 Jan 2021 11:48:15 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com> <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com> <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
 <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com>
 <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com> <CAK8P3a31ssD+FS1tAUxVHzrtUz-L9=mYCbv=ShEMci_bDdiTAg@mail.gmail.com>
 <YAcOi0l44VTtd2LS@ingrassia.epigenesys.com>
In-Reply-To: <YAcOi0l44VTtd2LS@ingrassia.epigenesys.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 19 Jan 2021 20:47:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3q16Fds9bujhjHRwjXoc_8NJBvutNRqajMEPHb9hGdNw@mail.gmail.com>
Message-ID: <CAK8P3a3q16Fds9bujhjHRwjXoc_8NJBvutNRqajMEPHb9hGdNw@mail.gmail.com>
Subject: Re: perf tools build broken for RISCV 32 bit
To:     Emiliano Ingrassia <ingrassia@epigenesys.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Khem Raj <raj.khem@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jan 19, 2021 at 5:53 PM Emiliano Ingrassia
<ingrassia@epigenesys.com> wrote:
> On Mon, Jan 18, 2021 at 08:58:50PM +0100, Arnd Bergmann wrote:
> > On Mon, Jan 18, 2021 at 4:33 PM Emiliano Ingrassia
> > <ingrassia@epigenesys.com> wrote:
> > > On Mon, Jan 18, 2021 at 04:19:47PM +0100, Arnd Bergmann wrote:
> > > > On Mon, Jan 18, 2021 at 3:53 PM Emiliano Ingrassia <ingrassia@epigenesys.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > after some searching I found this patch from Yocto project:
> > > > >
> > > > > https://www.mail-archive.com/linux-yocto@lists.yoctoproject.org/msg01004.html.
> > > > >
> > > > > I don't know if it's ever been proposed as mainline patch.
> > > > >
> > > > > What do you think about it? Could it be the right solution?
> > > >
> > > > No. While this makes it work on rv32, it does not fix it in a
> > > > way that makes it work on other architectures with a time64
> > > > libc. If you fix it, please do it in a way that works on all architectures.
> > >
> > > Ok, I totally agree with you on this point.
> > >
> > > So, it is right to conclude that the problem is not in perf
> > > implementation but in the libc implementation?
> > > That is, for example, glibc should define SYS_futex as SYS_futex_time64
> > > in case of riscv 32 bit because of its support to 64 bit time_t?
> >
> > Actually, there might be a somewhat less ugly workaround, if we decide
> > to put a correct wrapper into the exported kernel headers, e.g. adding
> > something along these lines to include/uapi/linux/futex.h or a new header
> > from the kernel:
> >
> > #ifndef __KERNEL__
> > #include <linux/futex.h>
> > #include <linux/time_types.h>
> > #include <asm/unistd.h>
> > #include <sys/time.h>
> > #include <unistd.h>
> > #include <errno.h>
> >
> > #define __kernel_futex __kernel_futex
> > typedef union __attribute__ ((__transparent_union__)) {
> >        const struct timespec *timeout;
> >        unsigned int intval;
> > } __kernel_futex_union;
> >
> > struct __kernel_old_timespec {
> >        __kernel_time_t tv_sec;                 /* seconds */
> >        long            tv_nsec;                /* nanoseconds */
> > };
> >
> > static inline int __kernel_futex(int *uaddr, int op, int val,
> >                                  __kernel_futex_union val2,
> >                                  unsigned *uaddr2, int val3)
> > {
> >         int cmd = op & FUTEX_CMD_MASK;
> >         int ret = -ENOSYS;
> > #ifdef __NR_futex64
> >         {
> >                 if (((cmd != FUTEX_WAIT) && (cmd != FUTEX_WAIT_BITSET)) ||
> >                     (sizeof(time_t) == sizeof(__u64))) {
> >                         ret = syscall(__NR_futex64, uaddr, op, val,
> >                                       val2.timeout, uaddr2, val3);
> >                 }
> >
> >                 if (ret != -ENOSYS && ret != -EPERM)
> >                         return ret;
> >         }
> > #endif
> > #ifdef __NR_futex
> >         {
> >                 if (((cmd != FUTEX_WAIT) && (cmd != FUTEX_WAIT_BITSET)) ||
> >                     sizeof(time_t) == sizeof(__kernel_long_t)) {
> >                         ret = syscall(__NR_futex, uaddr, op, val,
> >                                        val2.timeout, uaddr2, val3);
> >                 } else {
> >                         struct __kernel_old_timespec oldtimeout = {
> >                                 .tv_sec  = val2.timeout->tv_sec,
> >                                 .tv_nsec = val2.timeout->tv_nsec,
> >                         };
> >                         ret = syscall(__NR_futex, uaddr, op, val,
> >                                       &oldtimeout, uaddr2, val3);
> >                 }
> >         }
> > #endif
> >         return ret;
> > }
> > #endif /* __KERNEL__
> >
> > With this, applications can be changed to define their own
> >
> > #ifdef __kernel_futex
> > #define futex(uaddr, futex_op, val, val2, uaddr2, val3) \
> >       __kernel_futex(uaddr, futex_op, val, val2, uaddr2, val3)
> > #else
> > #define futex(uaddr, futex_op, val, val2, uaddr2, val3) \
> >        syscall(__NR_futex, uaddr, futex_op, val, val2, uaddr2, val3)
> > #endif
> >
> >          Arnd
>
> I would like to do a recap on what we have so far.
>
> The goal is to compile perf for RISCV 32 bit with glibc 2.32 which has support
> for 64 bit time_t. The target kernel is 5.10.7 with option COMPAT_32BIT_TIME
> enabled.

I didn't think that COMPAT_32BIT_TIME was even allowed on rv32,
but it seems there is a bug in Kconfig, it should be disabled for any
architecture that does not set __ARCH_WANT_TIME32_SYSCALLS,
but this should not affect the problem at hand.

> The userspace header file bits/syscall.h contains the needed definitions:
> |...
> |#ifdef __NR_futex
> |# define SYS_futex __NR_futex
> |#endif
> |
> |#ifdef __NR_futex_time64
> |# define SYS_futex_time64 __NR_futex_time64
> |#endif
> |...
>
> In case of architecture without __NR_futex definition nor futex() wrapper,
> the syscall function should be called with SYS_futex_time64 instead of the
> classic SYS_futex. This is not backward compatible and also not documented
> as far as I know.
>
> How this problem is solved in real scenarios? For example how can pthread
> library, which uses futex syscall, be compiled correctly in glibc?

The pthread library is built as part of glibc, and it uses its own local
(architecture specific) workaround.

> The solution is quite simple, glibc has a file called sysdep.h which in case of
> RISCV 32 bit contains the following workarounds:
> |...
> |#if __WORDSIZE == 32
> |
> |/* Workarounds for generic code needing to handle 64-bit time_t.  */
> |
> |/* Fix sysdeps/unix/sysv/linux/clock_getcpuclockid.c.  */
> |#define __NR_clock_getres       __NR_clock_getres_time64
> |/* Fix sysdeps/nptl/lowlevellock-futex.h.  */
> |#define __NR_futex              __NR_futex_time64
> |...
>
> So, in that case, __NR_futex is defined as __NR_futex_time64 and so SYS_futex is
> defined and usable.
>
> But this file can not be seen and used by userspace application.

Right, this is intentional, redefining __NR_futex would break any
correctly written application that passes a __kernel_old_timespec
structure when using __NR_futex.

> So, what should be the right solution here?
>
> Should the kernel export only __NR_futex and then check the timer struct
> dimension and distinguish the various cases (time32 vs time64 futex)?
>
> Or should the libc implementation take care to define SYS_futex once and for all
> and then use the proper __NR_futex{_time64} based on its definition of time_t?
>
> Considering that this is not only a problem of futex but of many others syscalls
> (e.g. __NR_clock_gettime{64}, __NR_clock_settime{64}, and so on), probably
> I would argue that the problem should be solved in the libc implementation
> in some way.
>
> What do you think?

The fundamental problem is mixing glibc interfaces with kernel interfaces,
which is broken in many ways. You would hit a similar issue when using
__NR_stat with 'struct stat' from glibc instead of 'struct __old_kernel_stat'.

Ideally, an application would just use the kernel types when calling
the kernel interfaces, or use the libc types and call a libc-provided
function (which glibc does not provide for futex).

There is nothing that glibc or kernel could do here to fix existing
applications, they all have to be changed manually to use a correct
interface when built against a time64 glibc or musl but directly
calling low-level syscall interfaces including but not limited to futex.

rv32 is in the unfortunate position of being the first one that has a glibc
port, so it hits a lot of problems that other architectures do not.
If the applications get fixed properly, then at least they will also
work with musl-1.2 and a (will work-in-progress) glibc that will
eventually allow building with 64-bit time_t.

One thing that glibc can do to help would be to #undef all the
time32 SYS_* macros when 64-bit time_t is used, to force a
build error on broken applications that try to use the wrong types,
but this is also problematic since you sometimes want to use
the numbers for something other than calling syscall(), e.g.
in strace or seccomp.

      Arnd

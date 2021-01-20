Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4950C433E0
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 14:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A7E23383
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 14:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbhATOuQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:50:16 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33304 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732136AbhATOo6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jan 2021 09:44:58 -0500
Received: by mail-ed1-f50.google.com with SMTP id c6so18931193ede.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jan 2021 06:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8eMjzIWcZkSJ9R15USVlyJh2a1qpMpSJBvhpd1DlQpo=;
        b=YwcQ5uv07FokvGsUOBZSAq8I3hAZAMiZQjH4vFB7V+KjWALl66TbWvpF4mXUsWLOSN
         M4jrkBaB0T3knTdWhMq5nOP47enj3NxGGbEE8fF1ecYnw8fLVFQn2A3UNXKhnI5xU7h4
         zgyNHh82pIo0ZbB7ocbGhL6CyYugsddaXBXJyBByWtnJMKQBokgruxZ9qsfA15FJHMz9
         hB4agRj85J7ngzRgPuTuQyWZksoAjvmK/sF4xN9DTQe0+fC7Z+mJjFw3UU+svTxGSXBy
         kqhhNp8ZwipFnsjJzDWS0Kaj7xvBjPuIl3+cRkF7zO6Etrj+sXV7hrxhbIfjlN0+K2ZV
         qn6g==
X-Gm-Message-State: AOAM533jIqOeP2e5LWNy8I40MrIPO8o/kCp+1HB8agzQSdhIJk90bfdB
        A1xaW6rirtcBQ/7QaqPrQxk=
X-Google-Smtp-Source: ABdhPJyrmjIkOjezu9VSd5BN8qDJx4M8h3HmNr7m6odyCmABQJXyhe1t+vo17wFnEHFbepYeVBGp3w==
X-Received: by 2002:a50:d646:: with SMTP id c6mr7483866edj.177.1611153854151;
        Wed, 20 Jan 2021 06:44:14 -0800 (PST)
Received: from ingrassia.epigenesys.com ([2.236.81.180])
        by smtp.gmail.com with ESMTPSA id r22sm1273167edp.9.2021.01.20.06.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 06:44:13 -0800 (PST)
Date:   Wed, 20 Jan 2021 15:44:11 +0100
From:   Emiliano Ingrassia <ingrassia@epigenesys.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        "Maciej W. Rozycki" <macro@wdc.com>,
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
Subject: Re: perf tools build broken for RISCV 32 bit
Message-ID: <YAhBu/T02m5oFOcM@ingrassia.epigenesys.com>
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com>
 <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com>
 <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
 <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com>
 <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com>
 <CAK8P3a31ssD+FS1tAUxVHzrtUz-L9=mYCbv=ShEMci_bDdiTAg@mail.gmail.com>
 <YAcOi0l44VTtd2LS@ingrassia.epigenesys.com>
 <CAK8P3a3q16Fds9bujhjHRwjXoc_8NJBvutNRqajMEPHb9hGdNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3q16Fds9bujhjHRwjXoc_8NJBvutNRqajMEPHb9hGdNw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnd,

On Tue, Jan 19, 2021 at 08:47:59PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 19, 2021 at 5:53 PM Emiliano Ingrassia
> <ingrassia@epigenesys.com> wrote:
> > On Mon, Jan 18, 2021 at 08:58:50PM +0100, Arnd Bergmann wrote:
> > > On Mon, Jan 18, 2021 at 4:33 PM Emiliano Ingrassia
> > > <ingrassia@epigenesys.com> wrote:
> > > > On Mon, Jan 18, 2021 at 04:19:47PM +0100, Arnd Bergmann wrote:
> > > > > On Mon, Jan 18, 2021 at 3:53 PM Emiliano Ingrassia <ingrassia@epigenesys.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > after some searching I found this patch from Yocto project:
> > > > > >
> > > > > > https://www.mail-archive.com/linux-yocto@lists.yoctoproject.org/msg01004.html.
> > > > > >
> > > > > > I don't know if it's ever been proposed as mainline patch.
> > > > > >
> > > > > > What do you think about it? Could it be the right solution?
> > > > >
> > > > > No. While this makes it work on rv32, it does not fix it in a
> > > > > way that makes it work on other architectures with a time64
> > > > > libc. If you fix it, please do it in a way that works on all architectures.
> > > >
> > > > Ok, I totally agree with you on this point.
> > > >
> > > > So, it is right to conclude that the problem is not in perf
> > > > implementation but in the libc implementation?
> > > > That is, for example, glibc should define SYS_futex as SYS_futex_time64
> > > > in case of riscv 32 bit because of its support to 64 bit time_t?
> > >
> > > Actually, there might be a somewhat less ugly workaround, if we decide
> > > to put a correct wrapper into the exported kernel headers, e.g. adding
> > > something along these lines to include/uapi/linux/futex.h or a new header
> > > from the kernel:
> > >
> > > #ifndef __KERNEL__
> > > #include <linux/futex.h>
> > > #include <linux/time_types.h>
> > > #include <asm/unistd.h>
> > > #include <sys/time.h>
> > > #include <unistd.h>
> > > #include <errno.h>
> > >
> > > #define __kernel_futex __kernel_futex
> > > typedef union __attribute__ ((__transparent_union__)) {
> > >        const struct timespec *timeout;
> > >        unsigned int intval;
> > > } __kernel_futex_union;
> > >
> > > struct __kernel_old_timespec {
> > >        __kernel_time_t tv_sec;                 /* seconds */
> > >        long            tv_nsec;                /* nanoseconds */
> > > };
> > >
> > > static inline int __kernel_futex(int *uaddr, int op, int val,
> > >                                  __kernel_futex_union val2,
> > >                                  unsigned *uaddr2, int val3)
> > > {
> > >         int cmd = op & FUTEX_CMD_MASK;
> > >         int ret = -ENOSYS;
> > > #ifdef __NR_futex64
> > >         {
> > >                 if (((cmd != FUTEX_WAIT) && (cmd != FUTEX_WAIT_BITSET)) ||
> > >                     (sizeof(time_t) == sizeof(__u64))) {
> > >                         ret = syscall(__NR_futex64, uaddr, op, val,
> > >                                       val2.timeout, uaddr2, val3);
> > >                 }
> > >
> > >                 if (ret != -ENOSYS && ret != -EPERM)
> > >                         return ret;
> > >         }
> > > #endif
> > > #ifdef __NR_futex
> > >         {
> > >                 if (((cmd != FUTEX_WAIT) && (cmd != FUTEX_WAIT_BITSET)) ||
> > >                     sizeof(time_t) == sizeof(__kernel_long_t)) {
> > >                         ret = syscall(__NR_futex, uaddr, op, val,
> > >                                        val2.timeout, uaddr2, val3);
> > >                 } else {
> > >                         struct __kernel_old_timespec oldtimeout = {
> > >                                 .tv_sec  = val2.timeout->tv_sec,
> > >                                 .tv_nsec = val2.timeout->tv_nsec,
> > >                         };
> > >                         ret = syscall(__NR_futex, uaddr, op, val,
> > >                                       &oldtimeout, uaddr2, val3);
> > >                 }
> > >         }
> > > #endif
> > >         return ret;
> > > }
> > > #endif /* __KERNEL__
> > >
> > > With this, applications can be changed to define their own
> > >
> > > #ifdef __kernel_futex
> > > #define futex(uaddr, futex_op, val, val2, uaddr2, val3) \
> > >       __kernel_futex(uaddr, futex_op, val, val2, uaddr2, val3)
> > > #else
> > > #define futex(uaddr, futex_op, val, val2, uaddr2, val3) \
> > >        syscall(__NR_futex, uaddr, futex_op, val, val2, uaddr2, val3)
> > > #endif
> > >
> > >          Arnd
> >
> > I would like to do a recap on what we have so far.
> >
> > The goal is to compile perf for RISCV 32 bit with glibc 2.32 which has support
> > for 64 bit time_t. The target kernel is 5.10.7 with option COMPAT_32BIT_TIME
> > enabled.
>
> I didn't think that COMPAT_32BIT_TIME was even allowed on rv32,
> but it seems there is a bug in Kconfig, it should be disabled for any
> architecture that does not set __ARCH_WANT_TIME32_SYSCALLS,
> but this should not affect the problem at hand.

Ok, will you submit a patch for this bug?

>
> > The userspace header file bits/syscall.h contains the needed definitions:
> > |...
> > |#ifdef __NR_futex
> > |# define SYS_futex __NR_futex
> > |#endif
> > |
> > |#ifdef __NR_futex_time64
> > |# define SYS_futex_time64 __NR_futex_time64
> > |#endif
> > |...
> >
> > In case of architecture without __NR_futex definition nor futex() wrapper,
> > the syscall function should be called with SYS_futex_time64 instead of the
> > classic SYS_futex. This is not backward compatible and also not documented
> > as far as I know.
> >
> > How this problem is solved in real scenarios? For example how can pthread
> > library, which uses futex syscall, be compiled correctly in glibc?
>
> The pthread library is built as part of glibc, and it uses its own local
> (architecture specific) workaround.
>
> > The solution is quite simple, glibc has a file called sysdep.h which in case of
> > RISCV 32 bit contains the following workarounds:
> > |...
> > |#if __WORDSIZE == 32
> > |
> > |/* Workarounds for generic code needing to handle 64-bit time_t.  */
> > |
> > |/* Fix sysdeps/unix/sysv/linux/clock_getcpuclockid.c.  */
> > |#define __NR_clock_getres       __NR_clock_getres_time64
> > |/* Fix sysdeps/nptl/lowlevellock-futex.h.  */
> > |#define __NR_futex              __NR_futex_time64
> > |...
> >
> > So, in that case, __NR_futex is defined as __NR_futex_time64 and so SYS_futex is
> > defined and usable.
> >
> > But this file can not be seen and used by userspace application.
>
> Right, this is intentional, redefining __NR_futex would break any
> correctly written application that passes a __kernel_old_timespec
> structure when using __NR_futex.
>
> > So, what should be the right solution here?
> >
> > Should the kernel export only __NR_futex and then check the timer struct
> > dimension and distinguish the various cases (time32 vs time64 futex)?
> >
> > Or should the libc implementation take care to define SYS_futex once and for all
> > and then use the proper __NR_futex{_time64} based on its definition of time_t?
> >
> > Considering that this is not only a problem of futex but of many others syscalls
> > (e.g. __NR_clock_gettime{64}, __NR_clock_settime{64}, and so on), probably
> > I would argue that the problem should be solved in the libc implementation
> > in some way.
> >
> > What do you think?
>
> The fundamental problem is mixing glibc interfaces with kernel interfaces,
> which is broken in many ways. You would hit a similar issue when using
> __NR_stat with 'struct stat' from glibc instead of 'struct __old_kernel_stat'.
>
> Ideally, an application would just use the kernel types when calling
> the kernel interfaces, or use the libc types and call a libc-provided
> function (which glibc does not provide for futex).
>
> There is nothing that glibc or kernel could do here to fix existing
> applications, they all have to be changed manually to use a correct
> interface when built against a time64 glibc or musl but directly
> calling low-level syscall interfaces including but not limited to futex.
>

Here is the example futex app corrected w.r.t. all the previous
considerations:

|#include <features.h>
|#if (defined __GLIBC__) && (__GLIBC__ >= 2 && __GLIBC_MINOR__ >= 32)
|#include <asm/unistd.h>
|#include <bits/timesize.h>
|# ifndef __NR_futex
|#  if defined (__NR_futex_time64) && (__TIMESIZE == 64)
|#   define __NR_futex	__NR_futex_time64
|#  endif
|# endif
|#endif
|
|#include <unistd.h>
|#include <sys/syscall.h>
|#include <linux/futex.h>
|#include <stdint.h>
|#include <sys/time.h>
|
|static int
|futex(uint32_t *uaddr, int futex_op, uint32_t val,
|      const struct timespec *timeout, uint32_t *uaddr2, uint32_t val3)
|{
|	return syscall(SYS_futex, uaddr, futex_op, val, timeout, uaddr2, val3);
|}
|
|int main(void)
|{
|	return futex(NULL, FUTEX_WAKE, 0, NULL, NULL, 0);
|}

In this case, __NR_futex is defined only if __NR_futex_time64 is defined
and if the time_t size is 64 bit. In this way SYS_futex will be defined
only if __NR_futex is defined, without directly defining the libc macro.

This solve the problem in glibc case but is quite ugly.
About musl, the support for riscv 32 bit is on the roadmap without a
prevision about that (https://wiki.musl-libc.org/roadmap.html).

> rv32 is in the unfortunate position of being the first one that has a glibc
> port, so it hits a lot of problems that other architectures do not.
> If the applications get fixed properly, then at least they will also
> work with musl-1.2 and a (will work-in-progress) glibc that will
> eventually allow building with 64-bit time_t.

Ok, so in case of perf we probably should limit the needed patch to
riscv 32 bit architecture, unless we want to solve the problem for all
32 bit architecture with time_t 64 bit support.

How should we proceed?

>
> One thing that glibc can do to help would be to #undef all the
> time32 SYS_* macros when 64-bit time_t is used, to force a
> build error on broken applications that try to use the wrong types,
> but this is also problematic since you sometimes want to use
> the numbers for something other than calling syscall(), e.g.
> in strace or seccomp.
>
>       Arnd

Thank you, best regards.

Emiliano

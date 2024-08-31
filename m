Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D71D130D
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 00:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725064548; cv=none; b=qdcfTUtPIBLN3Frb41qfJAeJjSoMeouKYVzrJDupNZnFMvSqzwg/Qwh5ExtVvl9kiWxPK6o0/XK7mV/PjzobCpq8mMcgmdNBfwJe6Bzf45cy1R0tGkv6qDIjEPCHMf4FCLUr+hk4rjCmE3f4vuIGDVFD0FWmiCxGpFnjxu1WaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725064548; c=relaxed/simple;
	bh=plovk/jYapEGr8mMNGpLd8GmxUiQcRsfxJp5jtzmMfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hL01MfZeTIu5KdONSCiuIYi0QiRhnwkMmK2M20WCMGdB2ufVSEjmIx2W/ifg8BmGXl4naP1sXj+Kc+PZG5xnk5AcnQ9P9Pg+WiXzyf7Nwfs3MQJ2k2OnGljBxEhvKuiwrlooC6/4m6DRFIUbpl/k2yoCZqvD5coHTxHrbVXISZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ERPtlUZ6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ERPtlUZ6"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-202018541afso43335ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2024 17:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725064545; x=1725669345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y894vcm3DitxcAaj9HKcjs1N/A1O9HwiD8WV1UvOrFk=;
        b=ERPtlUZ6ma+7EUix+UJZ8xjBianS+WOHuZyaujyNj2Vxv1D0TkMHwV2o9sl0Mm97FG
         gAis8tq4BSUSDw7PiAnEEiKklJB7/gtVywq1mh31J16i1tYn65tmRAa8vphuiAt6mUqi
         qwUHaKhXpFL4yhJHrzxI5agHXVPhXbHMjdoQ0jlOkMpz77MT4hV59mJbPlO4lNQPHM2P
         rIfgV/fOfQ6n8SRE2CY9vSrLkS6yYhGbXYfa3Z3TIi+LLfxHTIXv5XoIPKo2sNbYW07L
         nySCgykMgH7rKhP1Zf5eo0CnOUiTWdQadX2UdqTvhfiGuJjn6tr+e54BvNlqA7Z+Zzme
         pTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725064545; x=1725669345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y894vcm3DitxcAaj9HKcjs1N/A1O9HwiD8WV1UvOrFk=;
        b=KHGMRmt4UkU4yrTmqk3fIbPFwIZcEPa2NmJaxm2T5/OFkMPANJ3b6aDLVBdMD8W4Eu
         tPzTOzXD8oSuO/qzeIpjZt6tR3Y/Vill2EHUHX3RG5p9hqlF0gLvggb504KRjH9W+/GP
         UeZSFKQ8ETUsheOIJkjLH+P8VKsCVVoZaRmOdxabJHcFkvyT0loGaykXoLonxZgAwpnu
         TQGz4csqGrRyrmvRETJ9UjR+sry/8ysLlhKziBOxl7htftm7+YVV7WHRV3AhQgBJcNuv
         HnZ+oN42E8VLIgZt0KSxRXikOfgfFiKdbicxVpFNyx8F3NeSrrjlTsw0MAkamsxJ7dFm
         IYeg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ2kYcJQXp8s878Evs2cTRRlEvbr8lGzlbVDOSpHeDRjmxSs/KddPXirVvapBSCBlc5QD0F9ffrAu/7dBTVDgR@vger.kernel.org
X-Gm-Message-State: AOJu0YwvzQrz1Gy8F8+UmdE+BqNRsrYhDZZcrVwtxXdUAUJL4CRGWrTE
	2YnnwBhLVux/oW7FqRFsZL9eyzJo1wjdG8hgNIsg6ezvL0PzGVjICsgiyRUFWh9y6pPf8IYzqNu
	U7CZRQjEpayqN3LRYHlx0dDAzj0Y25lnIGYGY
X-Google-Smtp-Source: AGHT+IH3Qqi9o5EsgXgOH/IeMczg6s2reVlIG784mmjHdhRL7o2JbjJNkh9YiDDm070q217kbHz4EI2eJEW48hXLZEo=
X-Received: by 2002:a17:902:f691:b0:1f3:3ede:9b0 with SMTP id
 d9443c01a7336-205454a659emr1174385ad.10.1725064544621; Fri, 30 Aug 2024
 17:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705132059.853205-1-howardchu95@gmail.com>
 <20240705132059.853205-2-howardchu95@gmail.com> <6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org>
 <ZtJWEVn8-w07Wm0q@x1>
In-Reply-To: <ZtJWEVn8-w07Wm0q@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Aug 2024 17:35:32 -0700
Message-ID: <CAP-5=fWyPN48AcVZ3jdDnDdg4t2Q6fMXFV9HVymk0ynZnKcj+A@mail.gmail.com>
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 4:30=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Aug 30, 2024 at 12:24:29PM +0200, Jiri Slaby wrote:
> > This broke NO_SYSCALL_TABLE builds. i586 in particular
> > (HAVE_SYSCALL_TABLE_SUPPORT is undefined there):
> > > gcc -fomit-frame-pointer -O2 -Wall -U_FORTIFY_SOURCE -D_FORTIFY_SOURC=
E=3D3 -fstack-protector-strong -funwind-tables -fasynchronous
> > >         perf-in.o -Wl,--whole-archive /home/abuild/rpmbuild/BUILD/too=
ls/perf/libapi/libapi.a /home/abuild/rpmbuild/BUILD/tools/pe
> > > /usr/lib/gcc/i586-suse-linux/14/../../../../i586-suse-linux/bin/ld: p=
erf-in.o: in function `cmd_trace':
> > > (.text+0x81411): undefined reference to `syscalltbl__id_at_idx'
> > > /usr/lib/gcc/i586-suse-linux/14/../../../../i586-suse-linux/bin/ld: (=
.text+0x814b2): undefined reference to `syscalltbl__id_at_idx'
> > > /usr/lib/gcc/i586-suse-linux/14/../../../../i586-suse-linux/bin/ld: (=
.text+0x8154c): undefined reference to `syscalltbl__id_at_idx'
> >
> > Should there be something like a function returning identity mapping fo=
r
> > !HAVE_SYSCALL_TABLE_SUPPORT?
>
> I'll address this later, meantime I'm adding the patch below to
> perf-tools-next, probably your fix/suggestion of an identity mapping is
> way shorter and solves the !HAVE_SYSCALL_TABLE_SUPPORT case and thus
> should go to perf-tools.
>
> Please test the patch below and see if it fixes things for you, for me,
> with this container:
>
> WARNING: image platform (linux/386) does not match the expected platform =
(linux/amd64)
> WARNING: image platform (linux/386) does not match the expected platform =
(linux/amd64)
>    110.55 almalinux:9-i386              : Ok   gcc (GCC) 11.4.1 20231218 =
(Red Hat 11.4.1-3) , clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6-5=
.el9) flex 2.6.4
> BUILD_TARBALL_HEAD=3D174899051e54ecdab06c07652a3d04ad000ab301
>
> Using https://hub.docker.com/r/almalinux/i386/tags
>
> It builds as part of my set of tools[1] (not perf specific, I use it for
> pahole as well) build containers, using gcc and clang, with/without
> various build options, and will thus be tested from now on before I push
> things upstream.
>
> - Arnaldo
>
> [1] https://github.com/acmel/linux-tools-container-builds
>
> From 174899051e54ecdab06c07652a3d04ad000ab301 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Fri, 30 Aug 2024 19:53:47 -0300
> Subject: [PATCH 1/1] perf tools: Build x86 32-bit syscall table from
>  arch/x86/entry/syscalls/syscall_32.tbl
>
> To remove one more use of the audit libs and address a problem reported
> with a recent change where a function isn't available when using the
> audit libs method, that should really go away, this being one step in
> that direction.
>
> The script used to generate the 64-bit syscall table was already
> parametrized to generate for both 64-bit and 32-bit, so just use it and
> wire the generated table to the syscalltbl.c routines.
>
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Suggested-by: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/6fe63fa3-6c63-4b75-ac09-884d26f6fb95@k=
ernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

This looks great!
Reviewed-by: Ian Rogers <irogers@google.com>
It seems strange to me that the 64-bit binary doesn't need a 32-bit
syscall table given it could start a 32-bit binary, but that's a
problem for another day.

Thanks,
Ian

> ---
>  tools/perf/Makefile.config                    |  13 +-
>  tools/perf/arch/x86/Makefile                  |   6 +-
>  .../arch/x86/entry/syscalls/syscall_32.tbl    | 470 ++++++++++++++++++
>  tools/perf/check-headers.sh                   |   1 +
>  tools/perf/util/syscalltbl.c                  |   4 +
>  5 files changed, 484 insertions(+), 10 deletions(-)
>  create mode 100644 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 4eb1fc897baf64b8..9998cd7a879206ae 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -31,14 +31,8 @@ $(call detected_var,SRCARCH)
>  ifneq ($(NO_SYSCALL_TABLE),1)
>    NO_SYSCALL_TABLE :=3D 1
>
> -  ifeq ($(SRCARCH),x86)
> -    ifeq (${IS_64_BIT}, 1)
> -      NO_SYSCALL_TABLE :=3D 0
> -    endif
> -  else
> -    ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390 mips loongar=
ch))
> -      NO_SYSCALL_TABLE :=3D 0
> -    endif
> +  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 powerpc arm64 s390 mips loong=
arch))
> +    NO_SYSCALL_TABLE :=3D 0
>    endif
>
>    ifneq ($(NO_SYSCALL_TABLE),1)
> @@ -55,8 +49,9 @@ endif
>  # Additional ARCH settings for x86
>  ifeq ($(SRCARCH),x86)
>    $(call detected,CONFIG_X86)
> +  CFLAGS +=3D -I$(OUTPUT)arch/x86/include/generated
>    ifeq (${IS_64_BIT}, 1)
> -    CFLAGS +=3D -DHAVE_ARCH_X86_64_SUPPORT -I$(OUTPUT)arch/x86/include/g=
enerated
> +    CFLAGS +=3D -DHAVE_ARCH_X86_64_SUPPORT
>      ARCH_INCLUDE =3D ../../arch/x86/lib/memcpy_64.S ../../arch/x86/lib/m=
emset_64.S
>      LIBUNWIND_LIBS =3D -lunwind-x86_64 -lunwind -llzma
>      $(call detected,CONFIG_X86_64)
> diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
> index 8952e00f9b60203a..67b4969a673836eb 100644
> --- a/tools/perf/arch/x86/Makefile
> +++ b/tools/perf/arch/x86/Makefile
> @@ -13,6 +13,7 @@ PERF_HAVE_JITDUMP :=3D 1
>  generated :=3D $(OUTPUT)arch/x86/include/generated
>  out       :=3D $(generated)/asm
>  header    :=3D $(out)/syscalls_64.c
> +header_32 :=3D $(out)/syscalls_32.c
>  sys       :=3D $(srctree)/tools/perf/arch/x86/entry/syscalls
>  systbl    :=3D $(sys)/syscalltbl.sh
>
> @@ -22,7 +23,10 @@ $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
>  $(header): $(sys)/syscall_64.tbl $(systbl)
>         $(Q)$(SHELL) '$(systbl)' $(sys)/syscall_64.tbl 'x86_64' > $@
>
> +$(header_32): $(sys)/syscall_32.tbl $(systbl)
> +       $(Q)$(SHELL) '$(systbl)' $(sys)/syscall_32.tbl 'x86' > $@
> +
>  clean::
>         $(call QUIET_CLEAN, x86) $(RM) -r $(header) $(generated)
>
> -archheaders: $(header)
> +archheaders: $(header) $(header_32)
> diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl b/tools/pe=
rf/arch/x86/entry/syscalls/syscall_32.tbl
> new file mode 100644
> index 0000000000000000..534c74b14fab5117
> --- /dev/null
> +++ b/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -0,0 +1,470 @@
> +# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> +#
> +# 32-bit system call numbers and entry vectors
> +#
> +# The format is:
> +# <number> <abi> <name> <entry point> [<compat entry point> [noreturn]]
> +#
> +# The __ia32_sys and __ia32_compat_sys stubs are created on-the-fly for
> +# sys_*() system calls and compat_sys_*() compat system calls if
> +# IA32_EMULATION is defined, and expect struct pt_regs *regs as their on=
ly
> +# parameter.
> +#
> +# The abi is always "i386" for this file.
> +#
> +0      i386    restart_syscall         sys_restart_syscall
> +1      i386    exit                    sys_exit                        -=
                       noreturn
> +2      i386    fork                    sys_fork
> +3      i386    read                    sys_read
> +4      i386    write                   sys_write
> +5      i386    open                    sys_open                        c=
ompat_sys_open
> +6      i386    close                   sys_close
> +7      i386    waitpid                 sys_waitpid
> +8      i386    creat                   sys_creat
> +9      i386    link                    sys_link
> +10     i386    unlink                  sys_unlink
> +11     i386    execve                  sys_execve                      c=
ompat_sys_execve
> +12     i386    chdir                   sys_chdir
> +13     i386    time                    sys_time32
> +14     i386    mknod                   sys_mknod
> +15     i386    chmod                   sys_chmod
> +16     i386    lchown                  sys_lchown16
> +17     i386    break
> +18     i386    oldstat                 sys_stat
> +19     i386    lseek                   sys_lseek                       c=
ompat_sys_lseek
> +20     i386    getpid                  sys_getpid
> +21     i386    mount                   sys_mount
> +22     i386    umount                  sys_oldumount
> +23     i386    setuid                  sys_setuid16
> +24     i386    getuid                  sys_getuid16
> +25     i386    stime                   sys_stime32
> +26     i386    ptrace                  sys_ptrace                      c=
ompat_sys_ptrace
> +27     i386    alarm                   sys_alarm
> +28     i386    oldfstat                sys_fstat
> +29     i386    pause                   sys_pause
> +30     i386    utime                   sys_utime32
> +31     i386    stty
> +32     i386    gtty
> +33     i386    access                  sys_access
> +34     i386    nice                    sys_nice
> +35     i386    ftime
> +36     i386    sync                    sys_sync
> +37     i386    kill                    sys_kill
> +38     i386    rename                  sys_rename
> +39     i386    mkdir                   sys_mkdir
> +40     i386    rmdir                   sys_rmdir
> +41     i386    dup                     sys_dup
> +42     i386    pipe                    sys_pipe
> +43     i386    times                   sys_times                       c=
ompat_sys_times
> +44     i386    prof
> +45     i386    brk                     sys_brk
> +46     i386    setgid                  sys_setgid16
> +47     i386    getgid                  sys_getgid16
> +48     i386    signal                  sys_signal
> +49     i386    geteuid                 sys_geteuid16
> +50     i386    getegid                 sys_getegid16
> +51     i386    acct                    sys_acct
> +52     i386    umount2                 sys_umount
> +53     i386    lock
> +54     i386    ioctl                   sys_ioctl                       c=
ompat_sys_ioctl
> +55     i386    fcntl                   sys_fcntl                       c=
ompat_sys_fcntl64
> +56     i386    mpx
> +57     i386    setpgid                 sys_setpgid
> +58     i386    ulimit
> +59     i386    oldolduname             sys_olduname
> +60     i386    umask                   sys_umask
> +61     i386    chroot                  sys_chroot
> +62     i386    ustat                   sys_ustat                       c=
ompat_sys_ustat
> +63     i386    dup2                    sys_dup2
> +64     i386    getppid                 sys_getppid
> +65     i386    getpgrp                 sys_getpgrp
> +66     i386    setsid                  sys_setsid
> +67     i386    sigaction               sys_sigaction                   c=
ompat_sys_sigaction
> +68     i386    sgetmask                sys_sgetmask
> +69     i386    ssetmask                sys_ssetmask
> +70     i386    setreuid                sys_setreuid16
> +71     i386    setregid                sys_setregid16
> +72     i386    sigsuspend              sys_sigsuspend
> +73     i386    sigpending              sys_sigpending                  c=
ompat_sys_sigpending
> +74     i386    sethostname             sys_sethostname
> +75     i386    setrlimit               sys_setrlimit                   c=
ompat_sys_setrlimit
> +76     i386    getrlimit               sys_old_getrlimit               c=
ompat_sys_old_getrlimit
> +77     i386    getrusage               sys_getrusage                   c=
ompat_sys_getrusage
> +78     i386    gettimeofday            sys_gettimeofday                c=
ompat_sys_gettimeofday
> +79     i386    settimeofday            sys_settimeofday                c=
ompat_sys_settimeofday
> +80     i386    getgroups               sys_getgroups16
> +81     i386    setgroups               sys_setgroups16
> +82     i386    select                  sys_old_select                  c=
ompat_sys_old_select
> +83     i386    symlink                 sys_symlink
> +84     i386    oldlstat                sys_lstat
> +85     i386    readlink                sys_readlink
> +86     i386    uselib                  sys_uselib
> +87     i386    swapon                  sys_swapon
> +88     i386    reboot                  sys_reboot
> +89     i386    readdir                 sys_old_readdir                 c=
ompat_sys_old_readdir
> +90     i386    mmap                    sys_old_mmap                    c=
ompat_sys_ia32_mmap
> +91     i386    munmap                  sys_munmap
> +92     i386    truncate                sys_truncate                    c=
ompat_sys_truncate
> +93     i386    ftruncate               sys_ftruncate                   c=
ompat_sys_ftruncate
> +94     i386    fchmod                  sys_fchmod
> +95     i386    fchown                  sys_fchown16
> +96     i386    getpriority             sys_getpriority
> +97     i386    setpriority             sys_setpriority
> +98     i386    profil
> +99     i386    statfs                  sys_statfs                      c=
ompat_sys_statfs
> +100    i386    fstatfs                 sys_fstatfs                     c=
ompat_sys_fstatfs
> +101    i386    ioperm                  sys_ioperm
> +102    i386    socketcall              sys_socketcall                  c=
ompat_sys_socketcall
> +103    i386    syslog                  sys_syslog
> +104    i386    setitimer               sys_setitimer                   c=
ompat_sys_setitimer
> +105    i386    getitimer               sys_getitimer                   c=
ompat_sys_getitimer
> +106    i386    stat                    sys_newstat                     c=
ompat_sys_newstat
> +107    i386    lstat                   sys_newlstat                    c=
ompat_sys_newlstat
> +108    i386    fstat                   sys_newfstat                    c=
ompat_sys_newfstat
> +109    i386    olduname                sys_uname
> +110    i386    iopl                    sys_iopl
> +111    i386    vhangup                 sys_vhangup
> +112    i386    idle
> +113    i386    vm86old                 sys_vm86old                     s=
ys_ni_syscall
> +114    i386    wait4                   sys_wait4                       c=
ompat_sys_wait4
> +115    i386    swapoff                 sys_swapoff
> +116    i386    sysinfo                 sys_sysinfo                     c=
ompat_sys_sysinfo
> +117    i386    ipc                     sys_ipc                         c=
ompat_sys_ipc
> +118    i386    fsync                   sys_fsync
> +119    i386    sigreturn               sys_sigreturn                   c=
ompat_sys_sigreturn
> +120    i386    clone                   sys_clone                       c=
ompat_sys_ia32_clone
> +121    i386    setdomainname           sys_setdomainname
> +122    i386    uname                   sys_newuname
> +123    i386    modify_ldt              sys_modify_ldt
> +124    i386    adjtimex                sys_adjtimex_time32
> +125    i386    mprotect                sys_mprotect
> +126    i386    sigprocmask             sys_sigprocmask                 c=
ompat_sys_sigprocmask
> +127    i386    create_module
> +128    i386    init_module             sys_init_module
> +129    i386    delete_module           sys_delete_module
> +130    i386    get_kernel_syms
> +131    i386    quotactl                sys_quotactl
> +132    i386    getpgid                 sys_getpgid
> +133    i386    fchdir                  sys_fchdir
> +134    i386    bdflush                 sys_ni_syscall
> +135    i386    sysfs                   sys_sysfs
> +136    i386    personality             sys_personality
> +137    i386    afs_syscall
> +138    i386    setfsuid                sys_setfsuid16
> +139    i386    setfsgid                sys_setfsgid16
> +140    i386    _llseek                 sys_llseek
> +141    i386    getdents                sys_getdents                    c=
ompat_sys_getdents
> +142    i386    _newselect              sys_select                      c=
ompat_sys_select
> +143    i386    flock                   sys_flock
> +144    i386    msync                   sys_msync
> +145    i386    readv                   sys_readv
> +146    i386    writev                  sys_writev
> +147    i386    getsid                  sys_getsid
> +148    i386    fdatasync               sys_fdatasync
> +149    i386    _sysctl                 sys_ni_syscall
> +150    i386    mlock                   sys_mlock
> +151    i386    munlock                 sys_munlock
> +152    i386    mlockall                sys_mlockall
> +153    i386    munlockall              sys_munlockall
> +154    i386    sched_setparam          sys_sched_setparam
> +155    i386    sched_getparam          sys_sched_getparam
> +156    i386    sched_setscheduler      sys_sched_setscheduler
> +157    i386    sched_getscheduler      sys_sched_getscheduler
> +158    i386    sched_yield             sys_sched_yield
> +159    i386    sched_get_priority_max  sys_sched_get_priority_max
> +160    i386    sched_get_priority_min  sys_sched_get_priority_min
> +161    i386    sched_rr_get_interval   sys_sched_rr_get_interval_time32
> +162    i386    nanosleep               sys_nanosleep_time32
> +163    i386    mremap                  sys_mremap
> +164    i386    setresuid               sys_setresuid16
> +165    i386    getresuid               sys_getresuid16
> +166    i386    vm86                    sys_vm86                        s=
ys_ni_syscall
> +167    i386    query_module
> +168    i386    poll                    sys_poll
> +169    i386    nfsservctl
> +170    i386    setresgid               sys_setresgid16
> +171    i386    getresgid               sys_getresgid16
> +172    i386    prctl                   sys_prctl
> +173    i386    rt_sigreturn            sys_rt_sigreturn                c=
ompat_sys_rt_sigreturn
> +174    i386    rt_sigaction            sys_rt_sigaction                c=
ompat_sys_rt_sigaction
> +175    i386    rt_sigprocmask          sys_rt_sigprocmask              c=
ompat_sys_rt_sigprocmask
> +176    i386    rt_sigpending           sys_rt_sigpending               c=
ompat_sys_rt_sigpending
> +177    i386    rt_sigtimedwait         sys_rt_sigtimedwait_time32      c=
ompat_sys_rt_sigtimedwait_time32
> +178    i386    rt_sigqueueinfo         sys_rt_sigqueueinfo             c=
ompat_sys_rt_sigqueueinfo
> +179    i386    rt_sigsuspend           sys_rt_sigsuspend               c=
ompat_sys_rt_sigsuspend
> +180    i386    pread64                 sys_ia32_pread64
> +181    i386    pwrite64                sys_ia32_pwrite64
> +182    i386    chown                   sys_chown16
> +183    i386    getcwd                  sys_getcwd
> +184    i386    capget                  sys_capget
> +185    i386    capset                  sys_capset
> +186    i386    sigaltstack             sys_sigaltstack                 c=
ompat_sys_sigaltstack
> +187    i386    sendfile                sys_sendfile                    c=
ompat_sys_sendfile
> +188    i386    getpmsg
> +189    i386    putpmsg
> +190    i386    vfork                   sys_vfork
> +191    i386    ugetrlimit              sys_getrlimit                   c=
ompat_sys_getrlimit
> +192    i386    mmap2                   sys_mmap_pgoff
> +193    i386    truncate64              sys_ia32_truncate64
> +194    i386    ftruncate64             sys_ia32_ftruncate64
> +195    i386    stat64                  sys_stat64                      c=
ompat_sys_ia32_stat64
> +196    i386    lstat64                 sys_lstat64                     c=
ompat_sys_ia32_lstat64
> +197    i386    fstat64                 sys_fstat64                     c=
ompat_sys_ia32_fstat64
> +198    i386    lchown32                sys_lchown
> +199    i386    getuid32                sys_getuid
> +200    i386    getgid32                sys_getgid
> +201    i386    geteuid32               sys_geteuid
> +202    i386    getegid32               sys_getegid
> +203    i386    setreuid32              sys_setreuid
> +204    i386    setregid32              sys_setregid
> +205    i386    getgroups32             sys_getgroups
> +206    i386    setgroups32             sys_setgroups
> +207    i386    fchown32                sys_fchown
> +208    i386    setresuid32             sys_setresuid
> +209    i386    getresuid32             sys_getresuid
> +210    i386    setresgid32             sys_setresgid
> +211    i386    getresgid32             sys_getresgid
> +212    i386    chown32                 sys_chown
> +213    i386    setuid32                sys_setuid
> +214    i386    setgid32                sys_setgid
> +215    i386    setfsuid32              sys_setfsuid
> +216    i386    setfsgid32              sys_setfsgid
> +217    i386    pivot_root              sys_pivot_root
> +218    i386    mincore                 sys_mincore
> +219    i386    madvise                 sys_madvise
> +220    i386    getdents64              sys_getdents64
> +221    i386    fcntl64                 sys_fcntl64                     c=
ompat_sys_fcntl64
> +# 222 is unused
> +# 223 is unused
> +224    i386    gettid                  sys_gettid
> +225    i386    readahead               sys_ia32_readahead
> +226    i386    setxattr                sys_setxattr
> +227    i386    lsetxattr               sys_lsetxattr
> +228    i386    fsetxattr               sys_fsetxattr
> +229    i386    getxattr                sys_getxattr
> +230    i386    lgetxattr               sys_lgetxattr
> +231    i386    fgetxattr               sys_fgetxattr
> +232    i386    listxattr               sys_listxattr
> +233    i386    llistxattr              sys_llistxattr
> +234    i386    flistxattr              sys_flistxattr
> +235    i386    removexattr             sys_removexattr
> +236    i386    lremovexattr            sys_lremovexattr
> +237    i386    fremovexattr            sys_fremovexattr
> +238    i386    tkill                   sys_tkill
> +239    i386    sendfile64              sys_sendfile64
> +240    i386    futex                   sys_futex_time32
> +241    i386    sched_setaffinity       sys_sched_setaffinity           c=
ompat_sys_sched_setaffinity
> +242    i386    sched_getaffinity       sys_sched_getaffinity           c=
ompat_sys_sched_getaffinity
> +243    i386    set_thread_area         sys_set_thread_area
> +244    i386    get_thread_area         sys_get_thread_area
> +245    i386    io_setup                sys_io_setup                    c=
ompat_sys_io_setup
> +246    i386    io_destroy              sys_io_destroy
> +247    i386    io_getevents            sys_io_getevents_time32
> +248    i386    io_submit               sys_io_submit                   c=
ompat_sys_io_submit
> +249    i386    io_cancel               sys_io_cancel
> +250    i386    fadvise64               sys_ia32_fadvise64
> +# 251 is available for reuse (was briefly sys_set_zone_reclaim)
> +252    i386    exit_group              sys_exit_group                  -=
                       noreturn
> +253    i386    lookup_dcookie
> +254    i386    epoll_create            sys_epoll_create
> +255    i386    epoll_ctl               sys_epoll_ctl
> +256    i386    epoll_wait              sys_epoll_wait
> +257    i386    remap_file_pages        sys_remap_file_pages
> +258    i386    set_tid_address         sys_set_tid_address
> +259    i386    timer_create            sys_timer_create                c=
ompat_sys_timer_create
> +260    i386    timer_settime           sys_timer_settime32
> +261    i386    timer_gettime           sys_timer_gettime32
> +262    i386    timer_getoverrun        sys_timer_getoverrun
> +263    i386    timer_delete            sys_timer_delete
> +264    i386    clock_settime           sys_clock_settime32
> +265    i386    clock_gettime           sys_clock_gettime32
> +266    i386    clock_getres            sys_clock_getres_time32
> +267    i386    clock_nanosleep         sys_clock_nanosleep_time32
> +268    i386    statfs64                sys_statfs64                    c=
ompat_sys_statfs64
> +269    i386    fstatfs64               sys_fstatfs64                   c=
ompat_sys_fstatfs64
> +270    i386    tgkill                  sys_tgkill
> +271    i386    utimes                  sys_utimes_time32
> +272    i386    fadvise64_64            sys_ia32_fadvise64_64
> +273    i386    vserver
> +274    i386    mbind                   sys_mbind
> +275    i386    get_mempolicy           sys_get_mempolicy
> +276    i386    set_mempolicy           sys_set_mempolicy
> +277    i386    mq_open                 sys_mq_open                     c=
ompat_sys_mq_open
> +278    i386    mq_unlink               sys_mq_unlink
> +279    i386    mq_timedsend            sys_mq_timedsend_time32
> +280    i386    mq_timedreceive         sys_mq_timedreceive_time32
> +281    i386    mq_notify               sys_mq_notify                   c=
ompat_sys_mq_notify
> +282    i386    mq_getsetattr           sys_mq_getsetattr               c=
ompat_sys_mq_getsetattr
> +283    i386    kexec_load              sys_kexec_load                  c=
ompat_sys_kexec_load
> +284    i386    waitid                  sys_waitid                      c=
ompat_sys_waitid
> +# 285 sys_setaltroot
> +286    i386    add_key                 sys_add_key
> +287    i386    request_key             sys_request_key
> +288    i386    keyctl                  sys_keyctl                      c=
ompat_sys_keyctl
> +289    i386    ioprio_set              sys_ioprio_set
> +290    i386    ioprio_get              sys_ioprio_get
> +291    i386    inotify_init            sys_inotify_init
> +292    i386    inotify_add_watch       sys_inotify_add_watch
> +293    i386    inotify_rm_watch        sys_inotify_rm_watch
> +294    i386    migrate_pages           sys_migrate_pages
> +295    i386    openat                  sys_openat                      c=
ompat_sys_openat
> +296    i386    mkdirat                 sys_mkdirat
> +297    i386    mknodat                 sys_mknodat
> +298    i386    fchownat                sys_fchownat
> +299    i386    futimesat               sys_futimesat_time32
> +300    i386    fstatat64               sys_fstatat64                   c=
ompat_sys_ia32_fstatat64
> +301    i386    unlinkat                sys_unlinkat
> +302    i386    renameat                sys_renameat
> +303    i386    linkat                  sys_linkat
> +304    i386    symlinkat               sys_symlinkat
> +305    i386    readlinkat              sys_readlinkat
> +306    i386    fchmodat                sys_fchmodat
> +307    i386    faccessat               sys_faccessat
> +308    i386    pselect6                sys_pselect6_time32             c=
ompat_sys_pselect6_time32
> +309    i386    ppoll                   sys_ppoll_time32                c=
ompat_sys_ppoll_time32
> +310    i386    unshare                 sys_unshare
> +311    i386    set_robust_list         sys_set_robust_list             c=
ompat_sys_set_robust_list
> +312    i386    get_robust_list         sys_get_robust_list             c=
ompat_sys_get_robust_list
> +313    i386    splice                  sys_splice
> +314    i386    sync_file_range         sys_ia32_sync_file_range
> +315    i386    tee                     sys_tee
> +316    i386    vmsplice                sys_vmsplice
> +317    i386    move_pages              sys_move_pages
> +318    i386    getcpu                  sys_getcpu
> +319    i386    epoll_pwait             sys_epoll_pwait
> +320    i386    utimensat               sys_utimensat_time32
> +321    i386    signalfd                sys_signalfd                    c=
ompat_sys_signalfd
> +322    i386    timerfd_create          sys_timerfd_create
> +323    i386    eventfd                 sys_eventfd
> +324    i386    fallocate               sys_ia32_fallocate
> +325    i386    timerfd_settime         sys_timerfd_settime32
> +326    i386    timerfd_gettime         sys_timerfd_gettime32
> +327    i386    signalfd4               sys_signalfd4                   c=
ompat_sys_signalfd4
> +328    i386    eventfd2                sys_eventfd2
> +329    i386    epoll_create1           sys_epoll_create1
> +330    i386    dup3                    sys_dup3
> +331    i386    pipe2                   sys_pipe2
> +332    i386    inotify_init1           sys_inotify_init1
> +333    i386    preadv                  sys_preadv                      c=
ompat_sys_preadv
> +334    i386    pwritev                 sys_pwritev                     c=
ompat_sys_pwritev
> +335    i386    rt_tgsigqueueinfo       sys_rt_tgsigqueueinfo           c=
ompat_sys_rt_tgsigqueueinfo
> +336    i386    perf_event_open         sys_perf_event_open
> +337    i386    recvmmsg                sys_recvmmsg_time32             c=
ompat_sys_recvmmsg_time32
> +338    i386    fanotify_init           sys_fanotify_init
> +339    i386    fanotify_mark           sys_fanotify_mark               c=
ompat_sys_fanotify_mark
> +340    i386    prlimit64               sys_prlimit64
> +341    i386    name_to_handle_at       sys_name_to_handle_at
> +342    i386    open_by_handle_at       sys_open_by_handle_at           c=
ompat_sys_open_by_handle_at
> +343    i386    clock_adjtime           sys_clock_adjtime32
> +344    i386    syncfs                  sys_syncfs
> +345    i386    sendmmsg                sys_sendmmsg                    c=
ompat_sys_sendmmsg
> +346    i386    setns                   sys_setns
> +347    i386    process_vm_readv        sys_process_vm_readv
> +348    i386    process_vm_writev       sys_process_vm_writev
> +349    i386    kcmp                    sys_kcmp
> +350    i386    finit_module            sys_finit_module
> +351    i386    sched_setattr           sys_sched_setattr
> +352    i386    sched_getattr           sys_sched_getattr
> +353    i386    renameat2               sys_renameat2
> +354    i386    seccomp                 sys_seccomp
> +355    i386    getrandom               sys_getrandom
> +356    i386    memfd_create            sys_memfd_create
> +357    i386    bpf                     sys_bpf
> +358    i386    execveat                sys_execveat                    c=
ompat_sys_execveat
> +359    i386    socket                  sys_socket
> +360    i386    socketpair              sys_socketpair
> +361    i386    bind                    sys_bind
> +362    i386    connect                 sys_connect
> +363    i386    listen                  sys_listen
> +364    i386    accept4                 sys_accept4
> +365    i386    getsockopt              sys_getsockopt                  s=
ys_getsockopt
> +366    i386    setsockopt              sys_setsockopt                  s=
ys_setsockopt
> +367    i386    getsockname             sys_getsockname
> +368    i386    getpeername             sys_getpeername
> +369    i386    sendto                  sys_sendto
> +370    i386    sendmsg                 sys_sendmsg                     c=
ompat_sys_sendmsg
> +371    i386    recvfrom                sys_recvfrom                    c=
ompat_sys_recvfrom
> +372    i386    recvmsg                 sys_recvmsg                     c=
ompat_sys_recvmsg
> +373    i386    shutdown                sys_shutdown
> +374    i386    userfaultfd             sys_userfaultfd
> +375    i386    membarrier              sys_membarrier
> +376    i386    mlock2                  sys_mlock2
> +377    i386    copy_file_range         sys_copy_file_range
> +378    i386    preadv2                 sys_preadv2                     c=
ompat_sys_preadv2
> +379    i386    pwritev2                sys_pwritev2                    c=
ompat_sys_pwritev2
> +380    i386    pkey_mprotect           sys_pkey_mprotect
> +381    i386    pkey_alloc              sys_pkey_alloc
> +382    i386    pkey_free               sys_pkey_free
> +383    i386    statx                   sys_statx
> +384    i386    arch_prctl              sys_arch_prctl                  c=
ompat_sys_arch_prctl
> +385    i386    io_pgetevents           sys_io_pgetevents_time32        c=
ompat_sys_io_pgetevents
> +386    i386    rseq                    sys_rseq
> +393    i386    semget                  sys_semget
> +394    i386    semctl                  sys_semctl                      c=
ompat_sys_semctl
> +395    i386    shmget                  sys_shmget
> +396    i386    shmctl                  sys_shmctl                      c=
ompat_sys_shmctl
> +397    i386    shmat                   sys_shmat                       c=
ompat_sys_shmat
> +398    i386    shmdt                   sys_shmdt
> +399    i386    msgget                  sys_msgget
> +400    i386    msgsnd                  sys_msgsnd                      c=
ompat_sys_msgsnd
> +401    i386    msgrcv                  sys_msgrcv                      c=
ompat_sys_msgrcv
> +402    i386    msgctl                  sys_msgctl                      c=
ompat_sys_msgctl
> +403    i386    clock_gettime64         sys_clock_gettime
> +404    i386    clock_settime64         sys_clock_settime
> +405    i386    clock_adjtime64         sys_clock_adjtime
> +406    i386    clock_getres_time64     sys_clock_getres
> +407    i386    clock_nanosleep_time64  sys_clock_nanosleep
> +408    i386    timer_gettime64         sys_timer_gettime
> +409    i386    timer_settime64         sys_timer_settime
> +410    i386    timerfd_gettime64       sys_timerfd_gettime
> +411    i386    timerfd_settime64       sys_timerfd_settime
> +412    i386    utimensat_time64        sys_utimensat
> +413    i386    pselect6_time64         sys_pselect6                    c=
ompat_sys_pselect6_time64
> +414    i386    ppoll_time64            sys_ppoll                       c=
ompat_sys_ppoll_time64
> +416    i386    io_pgetevents_time64    sys_io_pgetevents               c=
ompat_sys_io_pgetevents_time64
> +417    i386    recvmmsg_time64         sys_recvmmsg                    c=
ompat_sys_recvmmsg_time64
> +418    i386    mq_timedsend_time64     sys_mq_timedsend
> +419    i386    mq_timedreceive_time64  sys_mq_timedreceive
> +420    i386    semtimedop_time64       sys_semtimedop
> +421    i386    rt_sigtimedwait_time64  sys_rt_sigtimedwait             c=
ompat_sys_rt_sigtimedwait_time64
> +422    i386    futex_time64            sys_futex
> +423    i386    sched_rr_get_interval_time64    sys_sched_rr_get_interval
> +424    i386    pidfd_send_signal       sys_pidfd_send_signal
> +425    i386    io_uring_setup          sys_io_uring_setup
> +426    i386    io_uring_enter          sys_io_uring_enter
> +427    i386    io_uring_register       sys_io_uring_register
> +428    i386    open_tree               sys_open_tree
> +429    i386    move_mount              sys_move_mount
> +430    i386    fsopen                  sys_fsopen
> +431    i386    fsconfig                sys_fsconfig
> +432    i386    fsmount                 sys_fsmount
> +433    i386    fspick                  sys_fspick
> +434    i386    pidfd_open              sys_pidfd_open
> +435    i386    clone3                  sys_clone3
> +436    i386    close_range             sys_close_range
> +437    i386    openat2                 sys_openat2
> +438    i386    pidfd_getfd             sys_pidfd_getfd
> +439    i386    faccessat2              sys_faccessat2
> +440    i386    process_madvise         sys_process_madvise
> +441    i386    epoll_pwait2            sys_epoll_pwait2                c=
ompat_sys_epoll_pwait2
> +442    i386    mount_setattr           sys_mount_setattr
> +443    i386    quotactl_fd             sys_quotactl_fd
> +444    i386    landlock_create_ruleset sys_landlock_create_ruleset
> +445    i386    landlock_add_rule       sys_landlock_add_rule
> +446    i386    landlock_restrict_self  sys_landlock_restrict_self
> +447    i386    memfd_secret            sys_memfd_secret
> +448    i386    process_mrelease        sys_process_mrelease
> +449    i386    futex_waitv             sys_futex_waitv
> +450    i386    set_mempolicy_home_node         sys_set_mempolicy_home_no=
de
> +451    i386    cachestat               sys_cachestat
> +452    i386    fchmodat2               sys_fchmodat2
> +453    i386    map_shadow_stack        sys_map_shadow_stack
> +454    i386    futex_wake              sys_futex_wake
> +455    i386    futex_wait              sys_futex_wait
> +456    i386    futex_requeue           sys_futex_requeue
> +457    i386    statmount               sys_statmount
> +458    i386    listmount               sys_listmount
> +459    i386    lsm_get_self_attr       sys_lsm_get_self_attr
> +460    i386    lsm_set_self_attr       sys_lsm_set_self_attr
> +461    i386    lsm_list_modules        sys_lsm_list_modules
> +462    i386    mseal                   sys_mseal
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 672421b858ac1a7f..714c78e5da07c163 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -172,6 +172,7 @@ check lib/ctype.c                 '-I "^EXPORT_SYMBOL=
" -I "^#include <linux/export.h>" -B
>  check lib/list_sort.c                '-I "^#include <linux/bug.h>"'
>
>  # diff non-symmetric files
> +check_2 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl arch/x86/entry=
/syscalls/syscall_32.tbl
>  check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry=
/syscalls/syscall_64.tbl
>  check_2 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/=
kernel/syscalls/syscall.tbl
>  check_2 tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel=
/syscalls/syscall.tbl
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 0dd26b991b3fb513..7c15dec6900d8aaa 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -18,6 +18,10 @@
>  #include <asm/syscalls_64.c>
>  const int syscalltbl_native_max_id =3D SYSCALLTBL_x86_64_MAX_ID;
>  static const char *const *syscalltbl_native =3D syscalltbl_x86_64;
> +#elif defined(__i386__)
> +#include <asm/syscalls_32.c>
> +const int syscalltbl_native_max_id =3D SYSCALLTBL_x86_MAX_ID;
> +static const char *const *syscalltbl_native =3D syscalltbl_x86;
>  #elif defined(__s390x__)
>  #include <asm/syscalls_64.c>
>  const int syscalltbl_native_max_id =3D SYSCALLTBL_S390_64_MAX_ID;
> --
> 2.46.0
>

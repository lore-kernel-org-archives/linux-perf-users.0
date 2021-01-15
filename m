Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324DBC43331
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Jan 2021 11:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C167224F9
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Jan 2021 11:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbhAOLOp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Jan 2021 06:14:45 -0500
Received: from mail-ej1-f50.google.com ([209.85.218.50]:36251 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbhAOLOo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Jan 2021 06:14:44 -0500
Received: by mail-ej1-f50.google.com with SMTP id l9so7018642ejx.3;
        Fri, 15 Jan 2021 03:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fYfrPYooDlKQvChf2iGvBkaRlU3LPV6MR7txq90KWBk=;
        b=I/7l33RhaKERqtzhytN8bySpnRlA2Yatp0A6HZOPb34vOEtqlWGIrLdUZSd7Hu1aQk
         gyV9xfTW2FvC4SXbhRcEj6PABL/e9MaNDqaNAd/tZdR0TkQAn0J0dA6FKqLP9f9XoPBT
         nb/A8wMypfp7cSq89rF3WSHqQRMTMUPTngP5n//wW7deXcNRd5nHJpjnGIEvpZB8wPaM
         sLnAXCrNSsieqk6j1HeXklBhmrC3pxPNWgOZnUzfP23LJb8Ihf8ovyBC2QAAijPQM2pt
         JtRc1C+LJPROr3qwSaJsIHPvQ7mLx9MHX6pRlGEugaRtBVnlnKacfY/GARNiGDceJ530
         v3Qg==
X-Gm-Message-State: AOAM530hZVVZALCcP5ys4zDywz1PiG1EpLo/kp/bjygrd3djkVYotHmJ
        FbbtGTAs8lc82Svf3XsgnSU=
X-Google-Smtp-Source: ABdhPJz/USrPF/RnaYPh8VMLYj/NOiiXy0R/L0GyNNeU3PSQ1tpBDFVjKd7vCzVI1c+o9LoXFFcYYg==
X-Received: by 2002:a17:906:cec7:: with SMTP id si7mr8201024ejb.123.1610709242119;
        Fri, 15 Jan 2021 03:14:02 -0800 (PST)
Received: from ingrassia.epigenesys.com ([2.236.81.180])
        by smtp.gmail.com with ESMTPSA id o13sm3409869edr.94.2021.01.15.03.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 03:14:01 -0800 (PST)
Date:   Fri, 15 Jan 2021 12:13:59 +0100
From:   Emiliano Ingrassia <ingrassia@epigenesys.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf tools build broken for RISCV 32 bit
Message-ID: <YAF499fI3dLgKjri@ingrassia.epigenesys.com>
References: <YACPie55ArIHu3mI@ingrassia.epigenesys.com>
 <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnd,

thank you for the quick reply and support.

On Thu, Jan 14, 2021 at 08:16:28PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 14, 2021 at 7:38 PM Emiliano Ingrassia
> <ingrassia@epigenesys.com> wrote:
> >
> > Hi,
> >
> > When building perf for RISCV 32 bit (v5.10.7) I got the following
> >
> > | In file included from bench/futex-hash.c:29:
> > | bench/futex.h: In function ‘futex_wait’:
> > | bench/futex.h:37:10: error: ‘SYS_futex’ undeclared (first use in this function); did you mean ‘SYS_tee’?
> >
> > This issue is similar to the one reported in https://lkml.org/lkml/2019/4/19/631
> >
> > I found that patching tools/arch/riscv/include/uapi/asm/unistd.h as following:
> >
> >  #ifdef __LP64__
> >  #define __ARCH_WANT_NEW_STAT
> >  #define __ARCH_WANT_SET_GET_RLIMIT
> > +#else
> > +#define __ARCH_WANT_TIME32_SYSCALLS
> >  #endif /* __LP64__ */
> >
> > solved the problem.
> >
> > I also found that a similar patch for arch/riscv/include/uapi/asm/unistd.h
> > was removed in commit d4c08b9776b3, so probably this is not the right way(?).
>
> In short, it won't work, as rv32 does not provide the time32 syscalls.
> Your patch will make the application build, but it will not be able to
> call futex().
>
> You will in fact run into a related problem on any 32-bit architecture
> if CONFIG_COMPAT_32BIT_TIME is disabled, or if you pass a non-NULL
> timeout parameter and build with a time64-enabled libc.
>

I'm using glibc 2.32 which supports 64 bit time_t on RISCV 32.

In particular, searching for __NR_futex in glibc RISCV source code I got:

sysdeps/unix/sysv/linux/riscv/rv32/arch-syscall.h: #define __NR_futex_time64 422
sysdeps/unix/sysv/linux/riscv/sysdep.h: #define __NR_futex __NR_futex_time64
sysdeps/unix/sysv/linux/riscv/rv64/arch-syscall.h: #define __NR_futex 98

but in the generated bits/syscall.h, included in bench/futex.h, I found:

#ifdef __NR_futex
# define SYS_futex __NR_futex
#endif

#ifdef __NR_futex_time64
# define SYS_futex_time64 __NR_futex_time64
#endif

So the problem is that userspace applications can't see the definition
of __NR_futex which is in sysdep.h, but there are no problems in calling
futex() libc wrapper because glibc syscall.c includes that header.

A possible fix for the perf tool would be to use futex() libc wrapper
in tools/perf/bench/futex.h instead of syscall(), but, if I understand correctly,
there are some drawbacks that does not permit it.

So what should be the right solution?

> The fix in the application is to call either __NR_futex or __NR_futex64
> depending on the definition of time_t in the C library. I would recommend
> doing it like
>
> #ifdef __NR_futex
> #define do_futex (sizeof(time_t) == sizeof(__kernel_long_t)) ? \
>          __NR_futex : __NR_futex_time64
> #else
> #define do_futex __NR_futex
> #done
>
>        Arnd

Where should be this fix applied? To perf code?

Thank you,

Emiliano

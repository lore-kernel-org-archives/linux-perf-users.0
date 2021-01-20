Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7637C433E6
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6AB2336D
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 15:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390280AbhATPb5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jan 2021 10:31:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390937AbhATPaB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jan 2021 10:30:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4F6E233E2
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jan 2021 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611156559;
        bh=7WmsTvnAxPUyLnSy+7idacbviQ2ZXQ9V63K2VAQXPPQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=njosop8oX4+mLBzQ4sXl8FUyNqfAJnAZG/nYjpjD4PCTQXjAbXaRtCcfP4/TrBbrQ
         Fg0gYdC8Nmd40f8PSxwlk56RVL/XRcUW8J4jpXc+lDq8pEFZcvTgRuAUyuidc4uB7e
         h4gP4kgAFoGCzzxQCDicr6dtdIrkA96TB8DIa1Qokb7Z2b+G9NREWBYV4/52XvxUv5
         alTYs0iX5OeOEOr1ApcS8Y3H+KVGZV91rCrfCnU9aEJb0K2RAtMBiq6PPzu8G+kGSh
         QTagLesvb4XUG/uuT+C8J6kRG2vZtB1pS+CHc0hdgFwOeiNRsG33j/EVnblJRwFgut
         GDCYIcRnzoy1A==
Received: by mail-oi1-f172.google.com with SMTP id d203so25404241oia.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jan 2021 07:29:19 -0800 (PST)
X-Gm-Message-State: AOAM532wDREPe+uSjO+cJGmQXTJNnB9eaVSAy86gNUD1o+UjS+ruNV32
        qjXyNlnN7jErS83cMW2U52JZsPB27eLMKl1Ete8=
X-Google-Smtp-Source: ABdhPJwZiFp47TofXx52OGFpz+dwnvNbLq2R0G7FqMR3WLWTVDTOq+qhS0F0eCIyFj2IT4PmtXzzeqiaRUH9oYlE4BI=
X-Received: by 2002:aca:44d:: with SMTP id 74mr3252962oie.4.1611156558930;
 Wed, 20 Jan 2021 07:29:18 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com> <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com> <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
 <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com>
 <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com> <CAK8P3a31ssD+FS1tAUxVHzrtUz-L9=mYCbv=ShEMci_bDdiTAg@mail.gmail.com>
 <YAcOi0l44VTtd2LS@ingrassia.epigenesys.com> <CAK8P3a3q16Fds9bujhjHRwjXoc_8NJBvutNRqajMEPHb9hGdNw@mail.gmail.com>
 <YAhBu/T02m5oFOcM@ingrassia.epigenesys.com>
In-Reply-To: <YAhBu/T02m5oFOcM@ingrassia.epigenesys.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 20 Jan 2021 16:29:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2y9BC9JDXoJVTi0+TcDvYH-nb27K4r2SybmL-zrxfBtw@mail.gmail.com>
Message-ID: <CAK8P3a2y9BC9JDXoJVTi0+TcDvYH-nb27K4r2SybmL-zrxfBtw@mail.gmail.com>
Subject: Re: perf tools build broken for RISCV 32 bit
To:     Emiliano Ingrassia <ingrassia@epigenesys.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jan 20, 2021 at 3:44 PM Emiliano Ingrassia
<ingrassia@epigenesys.com> wrote:
> On Tue, Jan 19, 2021 at 08:47:59PM +0100, Arnd Bergmann wrote:
> > On Tue, Jan 19, 2021 at 5:53 PM Emiliano Ingrassia
> >
> > I didn't think that COMPAT_32BIT_TIME was even allowed on rv32,
> > but it seems there is a bug in Kconfig, it should be disabled for any
> > architecture that does not set __ARCH_WANT_TIME32_SYSCALLS,
> > but this should not affect the problem at hand.
>
> Ok, will you submit a patch for this bug?

Sure, will do.
>
> Here is the example futex app corrected w.r.t. all the previous
> considerations:
>
> |#include <features.h>
> |#if (defined __GLIBC__) && (__GLIBC__ >= 2 && __GLIBC_MINOR__ >= 32)
> |#include <asm/unistd.h>
> |#include <bits/timesize.h>
> |# ifndef __NR_futex
> |#  if defined (__NR_futex_time64) && (__TIMESIZE == 64)
> |#   define __NR_futex  __NR_futex_time64
> |#  endif
> |# endif
> |#endif

This is broken on musl (which does not define __GLIBC__), on kernels
running with CONFIG_COMPAT_32BIT_TIME disabled (which may
define __NR_futex, but always returns -ENOSYS), and on any future glibc
with 64-bit time_t on anything other all existing architectures (which
define __NR_futex but expect an incompatible argument). It may also
be broken on rv32 if we end up adding support for futex() in the future,
as has been discussed as a possible workaround.

> > rv32 is in the unfortunate position of being the first one that has a glibc
> > port, so it hits a lot of problems that other architectures do not.
> > If the applications get fixed properly, then at least they will also
> > work with musl-1.2 and a (will work-in-progress) glibc that will
> > eventually allow building with 64-bit time_t.
>
> Ok, so in case of perf we probably should limit the needed patch to
> riscv 32 bit architecture, unless we want to solve the problem for all
> 32 bit architecture with time_t 64 bit support.

No, whatever you do should be written to work on all 32-bit
architectures. It would be crazy to add a special case for one
architecture when it's easier to fix it properly.

What was wrong with the helper function I suggested?

       Arnd

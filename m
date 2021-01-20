Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01E3C433DB
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 15:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F2C2336D
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 15:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbhATPqt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jan 2021 10:46:49 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:40767 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391030AbhATPqY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jan 2021 10:46:24 -0500
Received: by mail-ed1-f44.google.com with SMTP id h16so26294096edt.7
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jan 2021 07:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8npPzXaATwxK016zxLKvFcL2C31VtLU9BeTG1ZdXM04=;
        b=gwTT+5vk9x3P1j1yCLEC8F3R47OqsOMUhkLlEAJLUOJx3xqq5KPB3wBdz0LA2sWCQE
         D6uq/0o5sqK/NvM9u4d+IzaP9lQ5P+x3CGs/JsQOibv9uzo16uDHjvFPzOd2NQqPmwDE
         nU0ZyHPPhGvA1XRwCWufoqttm/47nUw+7w3DnHGMb6pQ+jI+f27z9eIQGAcQvomrytty
         WKBU55v6eIfNo6Vv967kOmXmMOU8rfEUrVSmbhT+asSqxhDg7qrdMWB72LOlGzEMLE3l
         xrblcA3K3TTsKPysPvxfwjmO2LauNMg8FccfIoy/w/8vJ+NIIi5td6F5sYV3eaBO9Loi
         ZU9Q==
X-Gm-Message-State: AOAM530p52XS3xD0XJgJCW3J7WKogGa3Kmj8+Z7YfaEmecMeguEfvdX5
        JgWotG+o4D16tjGVCqVJ2+0=
X-Google-Smtp-Source: ABdhPJwRhqN/SYqQRc2xxIscQex7MJ1sKYwOUH73vead+FtsFy9ZP1yJNwaJP6kaWCs7ArcPynXN+w==
X-Received: by 2002:a05:6402:70f:: with SMTP id w15mr8012388edx.121.1611157541439;
        Wed, 20 Jan 2021 07:45:41 -0800 (PST)
Received: from ingrassia.epigenesys.com ([2.236.81.180])
        by smtp.gmail.com with ESMTPSA id i13sm1346237edu.22.2021.01.20.07.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 07:45:40 -0800 (PST)
Date:   Wed, 20 Jan 2021 16:45:38 +0100
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
Message-ID: <YAhQIksHO+xM7wEO@ingrassia.epigenesys.com>
References: <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com>
 <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
 <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com>
 <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com>
 <CAK8P3a31ssD+FS1tAUxVHzrtUz-L9=mYCbv=ShEMci_bDdiTAg@mail.gmail.com>
 <YAcOi0l44VTtd2LS@ingrassia.epigenesys.com>
 <CAK8P3a3q16Fds9bujhjHRwjXoc_8NJBvutNRqajMEPHb9hGdNw@mail.gmail.com>
 <YAhBu/T02m5oFOcM@ingrassia.epigenesys.com>
 <CAK8P3a2y9BC9JDXoJVTi0+TcDvYH-nb27K4r2SybmL-zrxfBtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2y9BC9JDXoJVTi0+TcDvYH-nb27K4r2SybmL-zrxfBtw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnd,

On Wed, Jan 20, 2021 at 04:29:02PM +0100, Arnd Bergmann wrote:
> On Wed, Jan 20, 2021 at 3:44 PM Emiliano Ingrassia
> <ingrassia@epigenesys.com> wrote:
> > On Tue, Jan 19, 2021 at 08:47:59PM +0100, Arnd Bergmann wrote:
> > > On Tue, Jan 19, 2021 at 5:53 PM Emiliano Ingrassia
> > >
> > > I didn't think that COMPAT_32BIT_TIME was even allowed on rv32,
> > > but it seems there is a bug in Kconfig, it should be disabled for any
> > > architecture that does not set __ARCH_WANT_TIME32_SYSCALLS,
> > > but this should not affect the problem at hand.
> >
> > Ok, will you submit a patch for this bug?
>
> Sure, will do.
> >
> > Here is the example futex app corrected w.r.t. all the previous
> > considerations:
> >
> > |#include <features.h>
> > |#if (defined __GLIBC__) && (__GLIBC__ >= 2 && __GLIBC_MINOR__ >= 32)
> > |#include <asm/unistd.h>
> > |#include <bits/timesize.h>
> > |# ifndef __NR_futex
> > |#  if defined (__NR_futex_time64) && (__TIMESIZE == 64)
> > |#   define __NR_futex  __NR_futex_time64
> > |#  endif
> > |# endif
> > |#endif
>
> This is broken on musl (which does not define __GLIBC__), on kernels
> running with CONFIG_COMPAT_32BIT_TIME disabled (which may
> define __NR_futex, but always returns -ENOSYS), and on any future glibc
> with 64-bit time_t on anything other all existing architectures (which
> define __NR_futex but expect an incompatible argument). It may also
> be broken on rv32 if we end up adding support for futex() in the future,
> as has been discussed as a possible workaround.

I agree on this. It was just an example on howto get __NR_futex defined
in this specific case. Sure is broken in general.

>
> > > rv32 is in the unfortunate position of being the first one that has a glibc
> > > port, so it hits a lot of problems that other architectures do not.
> > > If the applications get fixed properly, then at least they will also
> > > work with musl-1.2 and a (will work-in-progress) glibc that will
> > > eventually allow building with 64-bit time_t.
> >
> > Ok, so in case of perf we probably should limit the needed patch to
> > riscv 32 bit architecture, unless we want to solve the problem for all
> > 32 bit architecture with time_t 64 bit support.
>
> No, whatever you do should be written to work on all 32-bit
> architectures. It would be crazy to add a special case for one
> architecture when it's easier to fix it properly.
>
> What was wrong with the helper function I suggested?

Sorry, I was just trying to have a more clear picture of the problem.

I'm totally fine with the helper function you proposed. About that,
should such approach be used for every time64 syscall for which is known
that there is no libc wrapper?

>
>        Arnd

Thank you, best regards.

Emiliano

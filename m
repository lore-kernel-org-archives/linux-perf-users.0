Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171E4C433E0
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE71823122
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 17:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390912AbhATR6e (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:58:34 -0500
Received: from mail-ej1-f41.google.com ([209.85.218.41]:39942 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390729AbhATR5r (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jan 2021 12:57:47 -0500
Received: by mail-ej1-f41.google.com with SMTP id gx5so15505865ejb.7
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jan 2021 09:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BHAPM9Dxt3bNuZfvaRuSHvsdmz04Kmra1nM09Sf0o4Y=;
        b=teMXrXWQ6qbOOuUUu3FhxryfmxU5YX7T9b7VdB0d/W+1TVsYnss9efyeRELeRFyLhr
         JtM1zHtqjiZvEGY+vS57PhNNoqF9VCVnD0dZ/mfOantYDUidE4b0Sl8lZ053Q4GFSji8
         v8WFJ2t1ex9ygpdUjK6markBJ4nQm2Y52wgCoehhE3dGX4MtIFH9/oz9PW7U0hrHX0il
         +1VhtUyjW1FfWym1zkWLYudEnxxQftCVRMxOLs7/2XiJvIWatZNGyB//QIVs6/Q7ujqS
         KDPtODoU/2gv+iabTsHqg9+Ao9INt8utDmrGDkuF7hhiRs7w3wDmGOGIKQvsPOwY6AJj
         LRfw==
X-Gm-Message-State: AOAM530kAQQOfPMd9AlUcSyzsQTBNNuMnSnmtPqBdKFEHaFk94PuZ+rG
        t2PBr2LP99nEA9scclPn7CM=
X-Google-Smtp-Source: ABdhPJwXJLAslAIXHmYQ2he1zQEFscB4L1gD5Ge9bjghqpyayQEBdkyUrw5/JuG9JsoGEkMTprQjyw==
X-Received: by 2002:a17:906:7689:: with SMTP id o9mr7029872ejm.324.1611165419627;
        Wed, 20 Jan 2021 09:56:59 -0800 (PST)
Received: from ingrassia.epigenesys.com ([2.236.81.180])
        by smtp.gmail.com with ESMTPSA id q2sm1486500edn.91.2021.01.20.09.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:56:58 -0800 (PST)
Date:   Wed, 20 Jan 2021 18:56:55 +0100
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
Message-ID: <YAhu579mXEZQc8ma@ingrassia.epigenesys.com>
References: <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
 <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com>
 <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com>
 <CAK8P3a31ssD+FS1tAUxVHzrtUz-L9=mYCbv=ShEMci_bDdiTAg@mail.gmail.com>
 <YAcOi0l44VTtd2LS@ingrassia.epigenesys.com>
 <CAK8P3a3q16Fds9bujhjHRwjXoc_8NJBvutNRqajMEPHb9hGdNw@mail.gmail.com>
 <YAhBu/T02m5oFOcM@ingrassia.epigenesys.com>
 <CAK8P3a2y9BC9JDXoJVTi0+TcDvYH-nb27K4r2SybmL-zrxfBtw@mail.gmail.com>
 <YAhQIksHO+xM7wEO@ingrassia.epigenesys.com>
 <CAK8P3a1Kjy14Pxf4_1SOYA5cy1bSYhhxW9_5LefNzJ2dRTJ29g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Kjy14Pxf4_1SOYA5cy1bSYhhxW9_5LefNzJ2dRTJ29g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnd,

On Wed, Jan 20, 2021 at 05:03:30PM +0100, Arnd Bergmann wrote:
> On Wed, Jan 20, 2021 at 4:45 PM Emiliano Ingrassia
> <ingrassia@epigenesys.com> wrote:
> > > > > rv32 is in the unfortunate position of being the first one that has a glibc
> > > > > port, so it hits a lot of problems that other architectures do not.
> > > > > If the applications get fixed properly, then at least they will also
> > > > > work with musl-1.2 and a (will work-in-progress) glibc that will
> > > > > eventually allow building with 64-bit time_t.
> > > >
> > > > Ok, so in case of perf we probably should limit the needed patch to
> > > > riscv 32 bit architecture, unless we want to solve the problem for all
> > > > 32 bit architecture with time_t 64 bit support.
> > >
> > > No, whatever you do should be written to work on all 32-bit
> > > architectures. It would be crazy to add a special case for one
> > > architecture when it's easier to fix it properly.
> > >
> > > What was wrong with the helper function I suggested?
> >
> > Sorry, I was just trying to have a more clear picture of the problem.
> >
> > I'm totally fine with the helper function you proposed. About that,
> > should such approach be used for every time64 syscall for which is known
> > that there is no libc wrapper?
>
> We have previously discussed adding generated wrappers for every
> syscall, but my suggestion to have an inline function in one of the kernel
> headers was not very popular at the time.
>
> I think futex() is very much a special case here because this is the
> only[1] thing that gets called directly by a number of applications through
> syscall(). All the other time32 system calls have wrappers that are
> provided by any C library, which will just use the correct syscall number
> to match the arguments, or do a conversion if needed.
>
> Most of the packages that use the other __NR_* macros need them
> for something other than calling them (e.g. strace), so a wrapper does
> not help.
>
>       Arnd
>
> [1] technically, there is also io_{p,}getevents, but that is usually abstracted
> through libaio, and only that needs to be fixed. I checked
> https://pagure.io/libaio/commits/master, which seems to be the upstream
> but I do not see a fix in there, so this version is currently broken on 32-bit
> architectures with musl-1.2 as well as on rv32 with glibc. Distros may
> have already fixed this in their downstream copies.
>
>         Arnd

That's OK with me.

Please, when you'll propose the patch cc me so I can test and give you my review.
About this, will you also patch perf to use __kernel_futex()?

Thank you, best regards.

Emiliano

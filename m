Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33642C433DB
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06878233A1
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 16:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391110AbhATQEj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:04:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733226AbhATQE2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jan 2021 11:04:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 724DE233A2
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jan 2021 16:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611158627;
        bh=T0E6+mqakN4V9vWo8X1ljtTe+kN6yus7W9b1XzynuwM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SrLoCkiCGaNFYbjas36sYatWF5/YwK4EjiIhWAUUpJ+Apy0cHpDZaYo1Qp5ivJFmI
         rtBsUbqbm9eOQGZeTEV3H7YU/59qHVHmxdsUNRbzOL0kpxP0uFuwCgjbzObzIJn4UG
         66BTYrf475a/8CuI9nnfKxACUsO2xlofj/qXVy+gUhpqSPbvQsMn97O0hc0wAwOATj
         31ChqIXGptr/EMxHVe5+tSzcFzTAWc71nGZtby9E78w7eljp3MU9k9jk2D/zCEO4yL
         PYWU+aEyQwSWXAspeQKcG/rWS6q3UfwpCuESSO64r1GQgGvYdTqR6OQP89Eu5fdBsO
         7f/9eTAxLWVuA==
Received: by mail-ot1-f48.google.com with SMTP id d1so3317012otl.13
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jan 2021 08:03:47 -0800 (PST)
X-Gm-Message-State: AOAM531z9Wjld/OgEFch7EzDU1HLwOQ6M2Knqq0UAM3sib3ln6kWbl1m
        qQLLd26j33Wi8gsngXnlfAFyuwUwrQx0CB8cnMg=
X-Google-Smtp-Source: ABdhPJxaRbbNCHdD3JOd3u35/vAqUKVfGKWCfXkdtpwBgrfo502SBbYLtn9isLPcnVFeKsBmrqxPppHoV64aP1QpSf0=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr7491016otq.305.1611158626717;
 Wed, 20 Jan 2021 08:03:46 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com> <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
 <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com>
 <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com> <CAK8P3a31ssD+FS1tAUxVHzrtUz-L9=mYCbv=ShEMci_bDdiTAg@mail.gmail.com>
 <YAcOi0l44VTtd2LS@ingrassia.epigenesys.com> <CAK8P3a3q16Fds9bujhjHRwjXoc_8NJBvutNRqajMEPHb9hGdNw@mail.gmail.com>
 <YAhBu/T02m5oFOcM@ingrassia.epigenesys.com> <CAK8P3a2y9BC9JDXoJVTi0+TcDvYH-nb27K4r2SybmL-zrxfBtw@mail.gmail.com>
 <YAhQIksHO+xM7wEO@ingrassia.epigenesys.com>
In-Reply-To: <YAhQIksHO+xM7wEO@ingrassia.epigenesys.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 20 Jan 2021 17:03:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Kjy14Pxf4_1SOYA5cy1bSYhhxW9_5LefNzJ2dRTJ29g@mail.gmail.com>
Message-ID: <CAK8P3a1Kjy14Pxf4_1SOYA5cy1bSYhhxW9_5LefNzJ2dRTJ29g@mail.gmail.com>
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

On Wed, Jan 20, 2021 at 4:45 PM Emiliano Ingrassia
<ingrassia@epigenesys.com> wrote:
> > > > rv32 is in the unfortunate position of being the first one that has a glibc
> > > > port, so it hits a lot of problems that other architectures do not.
> > > > If the applications get fixed properly, then at least they will also
> > > > work with musl-1.2 and a (will work-in-progress) glibc that will
> > > > eventually allow building with 64-bit time_t.
> > >
> > > Ok, so in case of perf we probably should limit the needed patch to
> > > riscv 32 bit architecture, unless we want to solve the problem for all
> > > 32 bit architecture with time_t 64 bit support.
> >
> > No, whatever you do should be written to work on all 32-bit
> > architectures. It would be crazy to add a special case for one
> > architecture when it's easier to fix it properly.
> >
> > What was wrong with the helper function I suggested?
>
> Sorry, I was just trying to have a more clear picture of the problem.
>
> I'm totally fine with the helper function you proposed. About that,
> should such approach be used for every time64 syscall for which is known
> that there is no libc wrapper?

We have previously discussed adding generated wrappers for every
syscall, but my suggestion to have an inline function in one of the kernel
headers was not very popular at the time.

I think futex() is very much a special case here because this is the
only[1] thing that gets called directly by a number of applications through
syscall(). All the other time32 system calls have wrappers that are
provided by any C library, which will just use the correct syscall number
to match the arguments, or do a conversion if needed.

Most of the packages that use the other __NR_* macros need them
for something other than calling them (e.g. strace), so a wrapper does
not help.

      Arnd

[1] technically, there is also io_{p,}getevents, but that is usually abstracted
through libaio, and only that needs to be fixed. I checked
https://pagure.io/libaio/commits/master, which seems to be the upstream
but I do not see a fix in there, so this version is currently broken on 32-bit
architectures with musl-1.2 as well as on rv32 with glibc. Distros may
have already fixed this in their downstream copies.

        Arnd

Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F13C433E0
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 14:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F38722472
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 14:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392767AbhAROl1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 09:41:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393042AbhAROka (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 09:40:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 905CA22472
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610980782;
        bh=VPzGVhb/xmTKYhV9u64hgtgCfzjaN+lHOFwpPwHZj+o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DF4K5yfqNVsJiVq0+6zPlU3Zqc27sqyPL7G8/E0PBStVk3mVDUtSO2kyGmH9jKSsf
         UZo3yu5Z83jw3OVxES5mZ/q0zPIQJ3dNCp4Y+1WerraiKYmiCMqZkg3Gull0j/RlPi
         o43FdGaAi/LmlUNekHOrHNByeAPHBBuLmgtPJIzznIGMxWubQACJruJbda65gfFdKa
         KC7d9Odln0aepatdOlAhj5vNgWF3pHPj8IW9uA/XVaJoDsid9kIWyaquvZXYzeongk
         Yk1RXEoWHv9qsMrSC33V62hs7dr3X4vGD5LIaQc8gROSRqL03HLaDgNk8//p7jnYTN
         26pWpyX4+Lrtw==
Received: by mail-ot1-f44.google.com with SMTP id 36so4893333otp.2
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 06:39:42 -0800 (PST)
X-Gm-Message-State: AOAM530vpoOPvTrR51uFCbj82fyEqtk8P0EulDmCLubQS25yvwKPS0ck
        kjmT8gCPYoV/L1M8JTMXAS1ovgfVNgicZeMvSDE=
X-Google-Smtp-Source: ABdhPJymYpL4T1hYZIbEYM0YzaM5Gp2JUDaCl3I64iNrQ/ovsxvo5OfxjLTebJFEvMoinhbrTs1Pu2w28dl3ZXffpTg=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr2376050otq.305.1610980781810;
 Mon, 18 Jan 2021 06:39:41 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com> <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com>
In-Reply-To: <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 18 Jan 2021 15:39:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1iiEsHaGDHGpzcAnU+_F37E07WXGYkYNw8osgWfBEjLA@mail.gmail.com>
Message-ID: <CAK8P3a1iiEsHaGDHGpzcAnU+_F37E07WXGYkYNw8osgWfBEjLA@mail.gmail.com>
Subject: Re: perf tools build broken for RISCV 32 bit
To:     Emiliano Ingrassia <ingrassia@epigenesys.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 18, 2021 at 3:25 PM Emiliano Ingrassia
<ingrassia@epigenesys.com> wrote:
> On Mon, Jan 18, 2021 at 12:56:11PM +0100, Arnd Bergmann wrote:
> > On Mon, Jan 18, 2021 at 12:35 PM Emiliano Ingrassia
> > <ingrassia@epigenesys.com> wrote:
> > > |#if __WORDSIZE == 32
> > > |/* Workarounds for generic code needing to handle 64-bit time_t.
> > > |...
> > > |/* Fix sysdeps/nptl/lowlevellock-futex.h.  */
> > > |#define __NR_futex              __NR_futex_time64
> > >
> > > a possible solution to fix the build of perf tool on RISCV 32 bit could
> > > be the following patch to file tools/arch/riscv/include/uapi/asm/unistd.h:
> > > |+
> > > |+#ifndef __NR_futex
> > > |+#define __NR_futex __NR_futex_time64
> > > |+#endif
> > >
> > > What do you think about it? Could it be a correct solution?
> >
> > No, that would be much worse: __NR_futex must only ever point
> > to the system call that takes the old timespec argument. If you define
> > something like this, it breaks applications that try to do the right thing.
>
> OK, but what should be the right solution for RISCV 32 bit in this case?
> Is it a problem in the libc implementation or in RISCV/perf implementation?

The problem is in perf, along with as any other application that wants to
use futex on a 32-bit architecture with 64-bit time_t.

I already said what the application needs to do in order to get the
right system call, in the absence of a wrapper that is part of every
C library.

       Arnd

Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A43C433E0
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 15:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D6A22AAA
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 15:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391536AbhARPqh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 10:46:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392972AbhARPpe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 10:45:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8E4722AAA
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610984692;
        bh=67nLFE5AmxugLi7OTthMEVCLi+nGmM3/wm4pbG7MKjc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GVMDyZGPtMFYHHBDBZ1dSfRMhVNoJSKfEgC4PIrHzgFStWcsq1zvoQnykbXrI79Ve
         Cq9gFp3Ct232qVN2KoRzWc8E9I7ShUxY5AfEF01mhWdBH/a90rWVGUh31NHbN6xU2F
         hhQFrBzRwEZX4B+JcPDgjr672C20PR2bePC86v+UidoPQuVwvDDTxi1LnM1jiW9s8q
         cKGuVJssUIZEw7PE9pqObe3/NfDeW7lyG10LJaj3KOTDA+oCL6mV9wCEBgFF+TekeH
         G9A1r7cQRRlIplIMPmBW3eCrjnSVvGAsTBau7DVWyaZ/XJFi1PMZY/PmdaArS2m80G
         j34tQH7nA9Hkg==
Received: by mail-oo1-f43.google.com with SMTP id k9so4190812oop.6
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 07:44:52 -0800 (PST)
X-Gm-Message-State: AOAM530hbCCkIlWwevOT9+rKeKJ+6uVUft9Ei3gjVGVuU4qYNyKNtlBa
        tlR08pXbkzQgMchFgauoe94Cx1azBg+jPoNaxXA=
X-Google-Smtp-Source: ABdhPJxfdyHTlw2D1MTVrSNUaL6uMgo9j0u4U+64x6/vTLh/QLL01y588LIhpSoOFfnBKNBniRWuC7Hx90LEZC7Gbqk=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr17390481ooj.15.1610984692180;
 Mon, 18 Jan 2021 07:44:52 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com> <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
 <YAWaQVBM84CaY1B2@ingrassia.epigenesys.com> <YAWg6KQt6hAtIR6O@ingrassia.epigenesys.com>
 <CAK8P3a3Vc4wrLvrfwkHd6HCMohk07Yi6P_jKaC_5AybCMBNjPA@mail.gmail.com> <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com>
In-Reply-To: <YAWqS9YZ0rpXPoSN@ingrassia.epigenesys.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 18 Jan 2021 16:44:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0kOi55Dg-P-v+GcKdoLY6VOvv5Lj63X1=vL9LDR=Fe9A@mail.gmail.com>
Message-ID: <CAK8P3a0kOi55Dg-P-v+GcKdoLY6VOvv5Lj63X1=vL9LDR=Fe9A@mail.gmail.com>
Subject: Re: perf tools build broken for RISCV 32 bit
To:     Emiliano Ingrassia <ingrassia@epigenesys.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 18, 2021 at 4:33 PM Emiliano Ingrassia
<ingrassia@epigenesys.com> wrote:

> Ok, I totally agree with you on this point.
>
> So, it is right to conclude that the problem is not in perf
> implementation but in the libc implementation?

No, libc does not provide a futex abstraction, and the SYS_* macros
just refer to the low-level interfaces that operate on kernel types rather
than libc types. An application that uses them must pass the
correct types.

> That is, for example, glibc should define SYS_futex as SYS_futex_time64
> in case of riscv 32 bit because of its support to 64 bit time_t?

As I explained, SYS_futex would refer to the time32 syscall, which
does not exist on rv32, redefining it to a different syscall would lead to
data corruption as well.

If you call futex_time64, you have to pass a __kernel_timespec structure,
while the old futex call must take a __kernel_old_timespec structure.
Depending on the architecture, only one of the two syscalls might be
available, and if you pass a timespec defined by libc, you have to
know which of the two syscalls that corresponds to, or convert
the arguments when calling it.

      Arnd

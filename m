Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1665C433E0
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 11:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C5A222BB
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 11:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391285AbhARL5L (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 06:57:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390542AbhARL5I (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 06:57:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECD472253A
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 11:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610970988;
        bh=JVM80W+fymfbwoI6tay/eFJQL7831mFGf1yuQbfxWvk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kjq5SwyDEHjqwxTRYIP0zNNBr6syJFWWXMyopp2FxWLcZsDI/k5S/dijLPMYnYjB2
         LWOwi+jCgKwxOPgviUcCv9pHCr44pqfAGtP4MCJpuknGLXp/ibGmd2iGlBpNAoEntV
         qz3lxpHxr14i6WJAV6Zm9rq5yZk8pBwR53sWX+Qdku7HeXeToJbdTmkPzH4goFRI6/
         2N+FQQvmGZ+oLiMdfy1HyQu9BxxvvcHj80gzDp1CC98IwiHqW58zghtfCtdezzYQ8F
         v3JWwJ9FPxQtsX9ixQzOsoe4ZgKon5LtgYnWEyd1d9HP3n31/DY1npCsc/E92U1Tyo
         YX2mmoSBXLOCA==
Received: by mail-oo1-f47.google.com with SMTP id x203so4025275ooa.9
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 03:56:27 -0800 (PST)
X-Gm-Message-State: AOAM532whhZlgi2pKT64q/1AHaGfe/shTuaA4UxNJUevsSW6KrFs39SG
        TNR6xv04g5Z/X+kY1Pp7k8gH1lj6yegSiV5yKwc=
X-Google-Smtp-Source: ABdhPJxfqdWijgVOnCrL8Z9jbQVL0B2EVdcpBuXAKF0kmQXD1fh/UGblt3pM346jJYlkpzQmCQuX1niqKYgCTqhpvLs=
X-Received: by 2002:a4a:2cc9:: with SMTP id o192mr16937018ooo.66.1610970987256;
 Mon, 18 Jan 2021 03:56:27 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
 <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com>
In-Reply-To: <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 18 Jan 2021 12:56:11 +0100
X-Gmail-Original-Message-ID: <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
Message-ID: <CAK8P3a33i2r0xx==3hTW32pc_Sm33EMDXYAS4PtEaEV8DX4s_A@mail.gmail.com>
Subject: Re: perf tools build broken for RISCV 32 bit
To:     Emiliano Ingrassia <ingrassia@epigenesys.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 18, 2021 at 12:35 PM Emiliano Ingrassia
<ingrassia@epigenesys.com> wrote:
> |#if __WORDSIZE == 32
> |/* Workarounds for generic code needing to handle 64-bit time_t.
> |...
> |/* Fix sysdeps/nptl/lowlevellock-futex.h.  */
> |#define __NR_futex              __NR_futex_time64
>
> a possible solution to fix the build of perf tool on RISCV 32 bit could
> be the following patch to file tools/arch/riscv/include/uapi/asm/unistd.h:
> |+
> |+#ifndef __NR_futex
> |+#define __NR_futex __NR_futex_time64
> |+#endif
>
> What do you think about it? Could it be a correct solution?

No, that would be much worse: __NR_futex must only ever point
to the system call that takes the old timespec argument. If you define
something like this, it breaks applications that try to do the right thing.

       Arnd

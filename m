Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B25C433DB
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 11:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA0222CB1
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jan 2021 11:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390386AbhARLgs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 06:36:48 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:36209 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390315AbhARLgm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 06:36:42 -0500
Received: by mail-ej1-f49.google.com with SMTP id l9so17499619ejx.3
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jan 2021 03:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=22uanx9EjnQBRBNnKDA8nFkzRE1bySJQ4yOweDiaQTY=;
        b=MsJA0uE9AiBGtOf76r1sH7iTu6h1MunvRVJiGJhEh/g40iYKmqkGjz9ccGKUA+oMl9
         0CUNPRZvOjGMVaoa2/3v/+E0jco6yMgxieZ+fNAzVLLHp7ID0IQtijFXcLv/6mBb3Kae
         uWVk4LOpD6W4+HY8jUewHerdv7v4tGhXksxHAAdWLshIkCM8hPhdxKYb39YVmmj+IGRm
         4tnXrqKX177qSYiVSVaHylNcurF3CimgW+YvhzjHfd6ltNMV2845nv/g2TGqORsyBemh
         0Onnkxu0RUKmShMwybAGkC90lJYL3Hkq2Uwuh1UDqDX8wPFLzUG+BppQK0fQEoQPTP0s
         Wafg==
X-Gm-Message-State: AOAM5305hPgUOAWWLWTIdq7vpOABo8fhxVPu2MKii/ATWuHgRl9rmf12
        vMvqKIn1JsvzfemCcLmfhZs=
X-Google-Smtp-Source: ABdhPJytr9xcaXlkWN+c/a7D86A0b2+xKocTgih6FEWmxisHsZVlt5WPOZjK2sG4+Tpz2mPnLUK13g==
X-Received: by 2002:a17:906:890:: with SMTP id n16mr15800893eje.195.1610969758882;
        Mon, 18 Jan 2021 03:35:58 -0800 (PST)
Received: from ingrassia.epigenesys.com ([2.236.81.180])
        by smtp.gmail.com with ESMTPSA id j3sm9326991eja.2.2021.01.18.03.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 03:35:58 -0800 (PST)
Date:   Mon, 18 Jan 2021 12:35:56 +0100
From:   Emiliano Ingrassia <ingrassia@epigenesys.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: perf tools build broken for RISCV 32 bit
Message-ID: <YAVynNqAwBt5GzQT@ingrassia.epigenesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0dJnKiX5minsUNdAcNnxPvZkyK363f1ibj_x0L2MQiPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnd,

sorry for my mistake. Effectively glibc does not provide a wrapper for
futex syscall, so its usage is obviously not a solution.

Following what can be found in glibc riscv sysdep.h file:

|#if __WORDSIZE == 32
|/* Workarounds for generic code needing to handle 64-bit time_t.
|...
|/* Fix sysdeps/nptl/lowlevellock-futex.h.  */
|#define __NR_futex              __NR_futex_time64

a possible solution to fix the build of perf tool on RISCV 32 bit could
be the following patch to file tools/arch/riscv/include/uapi/asm/unistd.h:
|+
|+#ifndef __NR_futex
|+#define __NR_futex __NR_futex_time64
|+#endif

What do you think about it? Could it be a correct solution?

Best regards,

Emiliano

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

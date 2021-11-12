Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FFAC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 18:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5C461051
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 18:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhKLSqx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 13:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:32774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhKLSqx (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Nov 2021 13:46:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F226660F93;
        Fri, 12 Nov 2021 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636742642;
        bh=Q2XwPleDqO3CUL0FkKR4p4mlnp9cjPqM0gfUzQcf9gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YCkai8TKgLRFkdUZf/CdqB+/JIVqTdK1/y/hUg7rzU6FryEvoebHxV8b981Z4p6cm
         yZBl1hAiA2r1NGkxhti2fAjgKKThLWgm2pPDXSLwZQ427B+84Mw+1Ho30wKwzly5lR
         K2esZmt9pBq22k/f1FmOqDReWNbBlqVgnrBW2XU7fv5U+r3plN0F6hbPzaS2O2SzGd
         gTr3wEAyKkTD06YvcRkdHKFR7RxIMnlFV+FYGEe4WucYW514NoBXT6KquCd5Mucska
         VCGgg0XZtMyir/HrsOdrZmm/7R/rlfq1I0aO7s9Bl1H8G2otM7lwixowO/xskxpVDi
         RpHJmP1UfoqWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9DD84410A1; Fri, 12 Nov 2021 15:43:58 -0300 (-03)
Date:   Fri, 12 Nov 2021 15:43:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ma Xinjian <xinjianx.ma@intel.com>
Cc:     irogers@google.com, alexander.shishkin@linux.intel.com,
        daniel@iogearbox.net, jolsa@redhat.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, mark.rutland@arm.com, mingo@redhat.com,
        mpetlan@redhat.com, namhyung@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, peterz@infradead.org,
        sedat.dilek@gmail.com, philip.li@intel.com
Subject: Re: [PATCH 2/2] perf clang: Fixes for more recent LLVM/clang
Message-ID: <YY617g/Gr+hXWJu5@kernel.org>
References: <1fcb636d-71ab-12e8-aa7f-c7ca4f89a5ed@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fcb636d-71ab-12e8-aa7f-c7ca4f89a5ed@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Nov 12, 2021 at 06:24:44PM +0800, Ma Xinjian escreveu:
> Hi
> 
> We build perf with clang also recently, but unlucky that failed with
> following errors:
> 
> 
> ```
> In file included from /usr/lib/llvm-7/include/llvm/ADT/STLExtras.h:21,
>                  from /usr/lib/llvm-7/include/llvm/ADT/StringRef.h:13,
>                  from /usr/lib/llvm-7/include/clang/Basic/Version.h:20,
>                  from test-clang.cpp:2:
> /usr/lib/llvm-7/include/llvm/ADT/SmallVector.h: In instantiation of 'void
> llvm::SmallVectorTemplateBase<T, true>::push_back(const T&) [with T =
> clang::driver::OffloadUnbundlingJobAction::DependentActionInfo]':
> /usr/lib/llvm-7/include/clang/Driver/Action.h:579:61:   required from here
> /usr/lib/llvm-7/include/llvm/ADT/SmallVector.h:313:11: error: 'void*
> memcpy(void*, const void*, size_t)' writing to an object of type 'struct
> clang::driver::OffloadUnbundlingJobAction::DependentActionInfo' with no
> trivial copy-assignment; use copy-initialization instead
> [-Werror=class-memaccess]
>      memcpy(this->end(), &Elt, sizeof(T));
>      ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /usr/lib/llvm-7/include/clang/Driver/Driver.h:15,
>                  from test-clang.cpp:6:
> /usr/lib/llvm-7/include/clang/Driver/Action.h:549:10: note: 'struct
> clang::driver::OffloadUnbundlingJobAction::DependentActionInfo' declared
> here
>    struct DependentActionInfo final {
>           ^~~~~~~~~~~~~~~~~~~
> cc1plus: all warnings being treated as errors
> ```
> 
> llvm version: 7
> rootfs: Debian10
> kernel: v5.8 v5.11 v5.15
> reproduce:
> $ cd linux/tools/perf
> $ make LIBCLANGLLVM=1 ARCH= EXTRA_CFLAGS='-fno-omit-frame-pointer
> -fsanitize=undefined -fsanitize=address'
> 
> Would you please kindly point out what's wrong with our steps? Or can you
> give us your command to make perf with clang?

This is just for building it with clang embedded, is that strictly
required?

I.e. you can still use perf to build bpf by calling clang, etc.

Or are you trying to _build_ perf using clang?

To build perf with clang:

⬢[acme@toolbox perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ; 
⬢[acme@toolbox perf]$ make -C tools/perf CC=clang O=/tmp/build/perf

End result:

⬢[acme@toolbox perf]$ perf -v
perf version 5.15.gf8b114cfd541

⬢[acme@toolbox perf]$ readelf -wi /tmp/build/perf/perf | grep -m5 DW_AT_producer
    <c>   DW_AT_producer    : (indirect string, offset: 0x0): clang version 13.0.0 (https://github.com/llvm/llvm-project e8991caea8690ec2d17b0b7e1c29bf0da6609076)
    <a6b>   DW_AT_producer    : (indirect string, offset: 0x0): clang version 13.0.0 (https://github.com/llvm/llvm-project e8991caea8690ec2d17b0b7e1c29bf0da6609076)
    <76f0>   DW_AT_producer    : (indirect string, offset: 0x0): clang version 13.0.0 (https://github.com/llvm/llvm-project e8991caea8690ec2d17b0b7e1c29bf0da6609076)
    <823d>   DW_AT_producer    : (indirect string, offset: 0x0): clang version 13.0.0 (https://github.com/llvm/llvm-project e8991caea8690ec2d17b0b7e1c29bf0da6609076)
    <121a8>   DW_AT_producer    : (indirect string, offset: 0x0): clang version 13.0.0 (https://github.com/llvm/llvm-project e8991caea8690ec2d17b0b7e1c29bf0da6609076)
⬢[acme@toolbox perf]$

- Arnaldo

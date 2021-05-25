Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21B4C2B9F8
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 15:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBA461249
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 15:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhEYPGA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 May 2021 11:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhEYPF7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 May 2021 11:05:59 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05484C061574
        for <linux-perf-users@vger.kernel.org>; Tue, 25 May 2021 08:04:28 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o27so30673662qkj.9
        for <linux-perf-users@vger.kernel.org>; Tue, 25 May 2021 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khU4iaS6Na4W6atMcRo3OSUoU5Ql5/4Uc8V3esaLajE=;
        b=OqdPD+NJhqXnoKqA7hSUAo3PdNuzcL0D4dt1kUgJEuQVdRImBlucQc6j82hepLgpUV
         o93/WXB/0xkORZdyJrSR5kp01ZXg2nLptjIPm9dpvc49jwqJwx0GdOV2CT1g17rFcjAa
         r8t4Tp0jkIrEnsY4rAoK9Q8Gx8Rxz6vhM1FDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khU4iaS6Na4W6atMcRo3OSUoU5Ql5/4Uc8V3esaLajE=;
        b=Uxs+khClMtOD28FF8DOxE9tSehJQsxAC5SqNggRu29znrGK7fhiZ43Fs9ShH7pMlPi
         b45YxxoVRUAGrcGA2WHkjtkRYQiGTDGBUWc3Bi1ShPlTR5evzpKr958P4uBi4lbn1ORu
         Rdg2ksoganchR6ieZIGhfa573YNW8kG8jaNc6t0StX1zGUIJSNDZxoGELdl/HRukJoqE
         JR34ANaSODoDfWC9HcP4UTGEt+N0Ip7d2a4+fuSfBdyCYkLpMCXvLWpio44vvB0Vp2ez
         ga/wXVjUWO0zgYxNCqqUCEBNlDEoXKdFL1HW5pxQnKHnt6x0bfGSjiZGVtuHCJ7m6VM2
         SxoQ==
X-Gm-Message-State: AOAM530zPZSWFh+k9Ur/YHCYXtOCAk5pTBV4+5AyX0TmWqAVal0fXxSZ
        nUswnwgTqm2p/iWG2dUO6nDiNiCh05T2dQ==
X-Google-Smtp-Source: ABdhPJxB6MBbylgFl2Oj87AeOAV/qArO3Xt9JwrM4oQQNcbPYXDRW/QxOly1ecTJBlfklYaFyoMJ+g==
X-Received: by 2002:a37:ae86:: with SMTP id x128mr36355995qke.427.1621955066707;
        Tue, 25 May 2021 08:04:26 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id t17sm12018810qto.92.2021.05.25.08.04.25
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 08:04:25 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id w1so32159475ybt.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 May 2021 08:04:25 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr43342321ybp.476.1621955065162;
 Tue, 25 May 2021 08:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210507205513.640780-1-dianders@chromium.org>
In-Reply-To: <20210507205513.640780-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 May 2021 08:04:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VwhMQ3wV0AsB1cbb3j6q3WzJS=DftUc0MRbTKi8uBs6g@mail.gmail.com>
Message-ID: <CAD=FV=VwhMQ3wV0AsB1cbb3j6q3WzJS=DftUc0MRbTKi8uBs6g@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: perf: Make compat tracing better
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Seth LaForge <sethml@google.com>,
        Ricky Liang <jcliang@chromium.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Catalin / Will,

On Fri, May 7, 2021 at 1:55 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> The goal for this series is to improve "perf" behavior when 32-bit
> userspace code is involved. This turns out to be fairly important for
> Chrome OS which still runs 32-bit userspace for the time being (long
> story there).
>
> I won't repeat everything said in the individual patches since since
> they are wordy enough as it is.
>
> Please enjoy and I hope this isn't too ugly/hacky for inclusion in
> mainline.
>
> Thanks to Nick Desaulniers for his early review of these patches and
> to Ricky for the super early prototype that some of this is based on.
>
>
> Douglas Anderson (3):
>   arm64: perf: perf_callchain_user() compat support for
>     clang/non-APCS-gcc-arm
>   arm64: perf: Improve compat perf_callchain_user() for clang leaf
>     functions
>   arm64: perf: Add a config option saying 32-bit thumb code uses R11 for
>     FP
>
>  arch/arm64/Kconfig                 |  12 ++
>  arch/arm64/kernel/perf_callchain.c | 329 +++++++++++++++++++++++++----
>  2 files changed, 305 insertions(+), 36 deletions(-)

While this isn't massively urgent, I'd like to confirm that this is on
your plate to eventually review and/or land. If it's not, do you have
any suggestions for how I should proceed?

Thanks!

-Doug

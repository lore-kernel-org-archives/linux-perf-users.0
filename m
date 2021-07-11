Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EF2C07E96
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 08:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE506120D
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 08:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhGKIKz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jul 2021 04:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhGKIKz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jul 2021 04:10:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0438EC0613E5
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 01:08:07 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c15so7373742pls.13
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uoCCXZXvrI1rDzjVf/fCu+A/YGEVLGhBR8+AmTK+J0g=;
        b=nkvEfNPrkZ14CAZBB2c+ZcblrbsE5/lHUZQ+id/905lrUSb8SJuMEfca56Cj7l6bfn
         6Od72UoVGjRaARvUzTksn2P5XKXAGpkhRH6VKfVMDNu4u3X4s90iKLz65HWTHcsN96C4
         pX6IO61HhJKP6TOZERzHkmM3UbZ4t6IqK+MCAHT2w+U5+n/Pv+J+Yr4RGFRBoaAgm6/g
         y0wh4QlPWBmxec+EeyLFVTPZXw2o3wObzm52+2wWR6fHFLB3N/45RzZcCWm4Nyuv7eIE
         kuQ66P/wu+fKbF+w1grRW/9doUyh6RxU67MacmvQoDB79CtaGArSlOHFacde8WJSzj/3
         Ps8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uoCCXZXvrI1rDzjVf/fCu+A/YGEVLGhBR8+AmTK+J0g=;
        b=MuHzsHK8FBr5FGPQw9Ele6TE4YgCSSrgDMmB0y/7SyaCxM96lW5+5uFWuNZMX0Thxv
         DiEdaV055HkzwQofHZDHzWAeebQozKhSgAXI5in+laBhsRdCU/t+C/Q+zUipstdbvO7I
         a6253Bvvspaq8P/1bFgJ3FMCYkwa+rA6hmjDQ9Q61hNqSlY6LKEbrDHcbDPqVZBPgd2L
         N4pNA93x49XEwMsnhogOr4f/VW57qpnm0Rlxn8vChZGnoO8PsYgyqnDlU6Oay09j91bM
         g3KfI5w/23GoD9QeNed0o48/dEUSmKe+UFmfybDo/fG7GwSpKZaloZZ5vs0W3rqYjTWF
         tBTA==
X-Gm-Message-State: AOAM530KhtIBupdVXuflpvB3C/di7rPFEdOoMhs+pvoECoIhmtP2m6m7
        iVN/UzzKKB/Gmual8BrrMRjI2Q==
X-Google-Smtp-Source: ABdhPJy9WSM9plj/arZagBkfTvNz3p9NQ5BVrKge1/+AbtvvWIAeYCdVgS7pN1pwU3FJzkhcbfHF5A==
X-Received: by 2002:a17:90a:9f06:: with SMTP id n6mr8060917pjp.219.1625990887376;
        Sun, 11 Jul 2021 01:08:07 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.131.71.237])
        by smtp.gmail.com with ESMTPSA id b19sm10319016pjh.29.2021.07.11.01.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 01:08:06 -0700 (PDT)
Date:   Sun, 11 Jul 2021 16:08:00 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 07/10] perf: Cleanup for
 HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
Message-ID: <20210711080800.GD273828@leoy-ThinkPad-X240s>
References: <20210704071644.107397-1-leo.yan@linaro.org>
 <20210704071644.107397-8-leo.yan@linaro.org>
 <86cd5d3d-2441-2f8e-28ab-54802e47c68b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cd5d3d-2441-2f8e-28ab-54802e47c68b@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Adrian,

On Sat, Jul 10, 2021 at 03:36:53PM +0300, Adrian Hunter wrote:
> On 4/07/21 10:16 am, Leo Yan wrote:
> > Since the __sync functions have been dropped, This patch removes unused
> > build and checking for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT in perf tool.
> > 
> > Note, there have a test for SYNC_COMPARE_AND_SWAP and the test file is
> > located in build/feature/test-sync-compare-and-swap.c.  Since there
> > still has several components using the sync functions, it's deliberately
> > to not be removed.
> 
> I don't quite follow that.  If they aren't using the feature test
> macro, then why keep the feature test?

There are files are still using __sync_xxx_compare_and_swap() functions,
e.g. in the folder tools/testing/selftests/bpf.  On the other hand,
after drop __sync functions from perf, there have no any Makefile check
the feature 'feature-sync-compare-and-swap'.  So it's safe to remove the
feature test.

Sorry for confusion.  Will drop the feature test in new patch set.

Thanks,
Leo

Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E60C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 10:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9B1610A6
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 10:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhINKGq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhINKGp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Sep 2021 06:06:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C95C061574
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Sep 2021 03:05:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso1759949pjj.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Sep 2021 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z1muzdOPWzB0ytDKcRa+QFyNrcjjCHiCUrUvKj8zYFM=;
        b=ZV9YpuPTdGrvhLZWC7YTDjzQ+oyE4Tnvnl2GIQvc69ojO1KtUMsUfiP9jbd3N04ASM
         JSv+PVbTCW622AwkynaZ0Dj/sHs9nNGOzTgnmEOuguzXMzE+UMuDLtnQA+7BM07LZfB6
         q5TmSMD1rnsXyGKCFILbsVrXFHZn1SlA0lfUa4GVO25uojNy0n+O0Y7EMjBj8B0HaVFX
         0r81qzhcYX1QCmSPgFTKdnq6ytpycu4hgs/q7/XFqfX/4g8tGPY2dALaQtmcn44vk8I+
         DPDSduio6Ba8YeMc1isvG99CxKGYwUeAoBDymzxWpAI2oHcMj/2uqQduBfu6/o7PUv61
         NS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z1muzdOPWzB0ytDKcRa+QFyNrcjjCHiCUrUvKj8zYFM=;
        b=cAw3toRRgy/+gImYrMgfSEk1QVpepOLuBOZQ3dRhzVVddbc1L3qsbzj/QCLAfMm919
         d4Vh+4QVekZMehPe8gS0RD3EKTBMC6QZ/pUtjQnjkvMgLrT483sH+SmSByXfB9z2qZeM
         ZTOKz7hu9wa92UJMMrk1VpncLTt/t1rJhpD1n5MIC8WbHbWx5IZ9NlYjFCCNVIgzptc2
         pS84VNnldV/naPwa+/fX1HNibeXe6V/H8hZsgKoZfBzLSJMWyGbd/gdfONiYDkG1MZBf
         QcrW5pcUcz6ayarEgC/nnSI0OV7xctJW2U0T6OHp4c0hB5xuZCfp6CAAjzAmgk/whQRO
         +unw==
X-Gm-Message-State: AOAM532fv6z7YtyEDJjynLiZnbKZDALKQSSA2Hc5DWDSza/Mt2MTqv2o
        x8DGu3G2Y107aF3FAHqrHOfYig==
X-Google-Smtp-Source: ABdhPJw9bLFl5o1rEO6GGn86+0NLilPqU7PnCPV4PRYgtLRqPF5710VvVQ1ig7++JmoZFGHm1n8mQQ==
X-Received: by 2002:a17:90a:b392:: with SMTP id e18mr1151791pjr.205.1631613927864;
        Tue, 14 Sep 2021 03:05:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.224])
        by smtp.gmail.com with ESMTPSA id d5sm1082133pjs.53.2021.09.14.03.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 03:05:27 -0700 (PDT)
Date:   Tue, 14 Sep 2021 18:05:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v5 4/9] perf/x86: Add compiler barrier after updating BTS
Message-ID: <20210914100517.GC1538480@leoy-ThinkPad-X240s>
References: <20210809111407.596077-1-leo.yan@linaro.org>
 <20210809111407.596077-5-leo.yan@linaro.org>
 <20210829105657.GC14461@leoy-ThinkPad-X240s>
 <YUBwqGuQskkw328z@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUBwqGuQskkw328z@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Peter,

On Tue, Sep 14, 2021 at 11:51:36AM +0200, Peter Zijlstra wrote:
> On Sun, Aug 29, 2021 at 06:56:57PM +0800, Leo Yan wrote:
> > Hi Peter, or any x86 maintainer,
> > 
> > On Mon, Aug 09, 2021 at 07:14:02PM +0800, Leo Yan wrote:
> > > Since BTS is coherent, simply add a compiler barrier to separate the BTS
> > > update and aux_head store.
> > 
> > Could you reivew this patch and check if BTS needs the comipler
> > barrier in this case?  Thanks.
> 
> Yes, a compiler barrier is sufficient.
> 
> You want me to pick it up?

Maybe other maintainers are more suitable than me to answer this :)

Yeah, I think it's great if you could pick it.

Thanks,
Leo

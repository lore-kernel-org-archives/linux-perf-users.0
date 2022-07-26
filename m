Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B846C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jul 2022 01:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiGZBGY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Jul 2022 21:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbiGZBGS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jul 2022 21:06:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C747027CFA
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Jul 2022 18:06:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z18so3653681edb.10
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Jul 2022 18:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=thz9dxDFuSYqJODD5f5c1QcTHNUerc3dCgd6VzMTNUU=;
        b=oXmTyriMkdqorU5Eg9Tws9vQBtvkCsmHM9/p03uYCH15r+CwIWZhfkIC77YqZsQx9p
         KnD9kP9K5a6jO8QftVh1WYxOo90r8Lryc9aLE3006UUD3/i+DVhnkscEXIIh17uPl71c
         CMExZNYmAgwmToTNjecSecTipYfdK1f4W/YOvoi4psaBNbBZQxnLF3DJkYPcRk6fzac5
         kt8HgCWem2OG8z7U/YVCcN33meN2q3mzUPiP84hs3i1aIiKbWMN5yoJe5wLVs+7a6tfJ
         JxnvfBNMWU9mPPnYjiSqEWyFH6yEGE7Wef65bnCBAT+30rlpvZiYHBLcsC1BC1uzrN8t
         OM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=thz9dxDFuSYqJODD5f5c1QcTHNUerc3dCgd6VzMTNUU=;
        b=icPjcrEUBFWYRzFkbAd0IBeiVSrc5zE4SODVkn3lR61Lrye+PfhrYT6AK5jOxi4wqD
         BH9ZViFYqkAthuxwIl0b+kJJr1aTGvduzliWXal6H22XyuKJ0Pktlr4LeL3cLU13QRAJ
         DofgoiwMxy6OR8e2w6HN4eK0hcFiZflpG91UkCuvBhDdcyuyAk5eV+H4eKsW2wwb3fwS
         7wOuRVh2tuaFWwawEWhSUe+PRPyTOHfa+j8SEzrhxIC+kTxuvFvgNQaOapKsdgC7yy4a
         mwWddtIcg7+syygKz9Ho+KgvADUUQezH3vY34lOBkvq2aMJENsRk6xIkYz5hFGGwa75w
         eXMw==
X-Gm-Message-State: AJIora9wpJdGIdl8/zKYpUvjBwM94sH+Ty87T5VkPMG4vQkSl4ouVqFt
        1OrpLMwOksqp4kLBsLupgO8eAQ==
X-Google-Smtp-Source: AGRyM1sirez8JaDsUjTPMqZyKbVbQ6f40aB9QttdiSybXDlwbnLl7Gzunq2EajS8Tj2HL3gStT4/YQ==
X-Received: by 2002:a05:6402:42cb:b0:43b:e8eb:cbc1 with SMTP id i11-20020a05640242cb00b0043be8ebcbc1mr10583652edc.414.1658797576269;
        Mon, 25 Jul 2022 18:06:16 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.97.243])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090653c400b0072fd6e9f707sm1843498ejo.100.2022.07.25.18.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 18:06:15 -0700 (PDT)
Date:   Tue, 26 Jul 2022 09:06:10 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Fangrui Song <maskray@google.com>,
        Chang Rui <changruinj@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf symbol: Correct address for bss symbols
Message-ID: <20220726010610.GC36862@leoy-ThinkPad-X240s>
References: <20220724060013.171050-1-leo.yan@linaro.org>
 <20220724060013.171050-2-leo.yan@linaro.org>
 <Yt7hGepLBAJJuvII@kernel.org>
 <20220726005307.GA36862@leoy-ThinkPad-X240s>
 <2A971E59-21F0-4DD2-9E62-F1E7F481C8AF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2A971E59-21F0-4DD2-9E62-F1E7F481C8AF@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 25, 2022 at 10:04:58PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> >Do want me to proceed for adding test case? 
> 
> Yes, go ahead, that will be really nice of you to add it :)

Get it, will do it.

Thanks,
Leo

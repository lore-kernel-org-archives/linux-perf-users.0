Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC0BC00140
	for <linux-perf-users@archiver.kernel.org>; Mon,  1 Aug 2022 01:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbiHABxI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 31 Jul 2022 21:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiHABxI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 31 Jul 2022 21:53:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3586712085
        for <linux-perf-users@vger.kernel.org>; Sun, 31 Jul 2022 18:53:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y13so3767364ejp.13
        for <linux-perf-users@vger.kernel.org>; Sun, 31 Jul 2022 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yTvm3wwagmTX69a1KC3CUigiKtFCy3zwt67VVBZyDak=;
        b=GPqW1cTLq5YaJ7qIRYRVxx9+6cQZp1Moby7K1w3+gO0s7t18ND9NWqsag2/40InWoK
         frmyFWE9D6dlG3SRq6yPU3uRZ9Q6Wgx273hlmzeamoXLcqIvI15Emjaa07ckgKpiRLy7
         ujzHufZKrkUfcQgC1OCDvBe0/DZ3tumedxGlufI5ZEkC0creBoIhLcJ4S8mBx+bEeJ3b
         RuW3SvhyOFWT12JUy0oJkTlk7gJmkS6hBfklSHiVGI/06hRu3m+H5kE4AtoI95230Gjo
         Q9Z3vxklJJXLUUQeeu9FJHY2xA46Tb2LU2FiI8cN/JFuHu6BJu4FQTuNjaog7wmZq5Ul
         giLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yTvm3wwagmTX69a1KC3CUigiKtFCy3zwt67VVBZyDak=;
        b=WTrA1aQSOP1t9A/RNAYh2epOFHwW+zO6T/J3KKnIwmm6vs2jefZUTfphKISb49v7t8
         oP53Y7J2tsVT8Dkd7Udzw847OEdmzOkKnQGEM08mLbEtTIDPKOIURCUC1grfDgjI7awA
         HqF5XzDZ5YBOJ1uuXJE705U6WgYEB5xmyyyTtsoEl+6QOT1ktl234kUVyMRfdbMwtPgq
         KMO13zyhncmhQuNFEoBRRQMh5w/KjNm1dTAl3ro6CoI1JW2hEwPFugf1uoKnLo6ofhv9
         5v5ghvItvOzyCdP8r2DYCJUO0vnREdcglU7n+fhjjNpor5d8slXqfDCD+nq3Jb9GpSxa
         Ai7g==
X-Gm-Message-State: AJIora8+F3OTuh7CjSPsFG1vPyRcm0GcHJSsBt338hsEaooZba2Mwe/5
        uDcLxlG5KVjB2yLrTNPAQNxv2Q==
X-Google-Smtp-Source: AGRyM1sYxTmAAq2ftLjn15qJjzoPeYDwFeWVqT5gRbWJYURnOvZmEA+/36cenRUMOT6AnJ4ECGUniw==
X-Received: by 2002:a17:906:7950:b0:72f:d4a4:564d with SMTP id l16-20020a170906795000b0072fd4a4564dmr10730422ejo.479.1659318785656;
        Sun, 31 Jul 2022 18:53:05 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.98.208])
        by smtp.gmail.com with ESMTPSA id b1-20020a05640202c100b0043cf2e0ce1csm6043374edx.48.2022.07.31.18.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 18:53:05 -0700 (PDT)
Date:   Mon, 1 Aug 2022 09:52:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf symbol: Fail to read phdr workaround
Message-ID: <20220801015259.GA101027@leoy-ThinkPad-X240s>
References: <20220731164923.691193-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731164923.691193-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Jul 31, 2022 at 09:49:23AM -0700, Ian Rogers wrote:
> The perf jvmti agent doesn't create program headers, in this case
> fallback on section headers as happened previously.
> 
> Fixes: 882528d2e776 ("perf symbol: Skip symbols if SHF_ALLOC flag is not set")

It's good to change fix tag as:
Fixes: 2d86612aacb7 ("perf symbol: Correct address for bss symbols")

I saw stable kernel maintainers have back ported patch "perf symbol:
Correct address for bss symbols" for stable kernel branches, the
suggested fix tag would allow this patch to be landed on stable kernels
as well.

I think I need to manually send the patch "perf symbol: Skip symbols
if SHF_ALLOC flag is not set" to stable kernel mailing list, this
patch missed fix tag.

> Signed-off-by: Ian Rogers <irogers@google.com>

With updating fix tag:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

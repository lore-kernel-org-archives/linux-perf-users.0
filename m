Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3F1C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Mar 2022 10:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbiCOKRo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiCOKRn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Mar 2022 06:17:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9BF5005B
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Mar 2022 03:16:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e24so28117630wrc.10
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Mar 2022 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5HNQ6qNf61XTnW5s+xAEpy8op4YxmYPG4BM4/UV3FJc=;
        b=SJqUmKeA7Og5a/Dmd6Rmx5JgMctxHS7164zrbCxqv+0QilWnY2OS6xrL3Nv/tInsHI
         77D+4T8LEGTy7a6Cjw0oSMO3gPZ23IJpT770/nc5kMdXr2jnaCidVXgr8qkFogQD90Hu
         4na6v+1xKEVIiItoNhNFnchuN2hVH64rzRwUHwVqbRbuUpeaGI9eC5GtuVL+haJ5C+GS
         AD38bmnxbCZmgojshQplzGMZqCL2nyvVr9v8P5nWgZ3AAURsx1EB8/COEjGoHynD5GXQ
         8Qu/1nioaMgmou1PpIL2LlvuIo6fx5J3KWykHKpYejB9VfrQ+MJn+CtLCzywDgnKxW/2
         p5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5HNQ6qNf61XTnW5s+xAEpy8op4YxmYPG4BM4/UV3FJc=;
        b=ia6XTuF/0rWcpjaAGPFtg1c0D4maaxhiQCMDB23CabgRsw0KTN2ia0WdrvTDTV++K3
         cAIvlmjNJvgLp1Lrhj5UlJGvBFsudlpg0WypPernfJ9ljcWS2bbKdJV3ONVQbTPxNgZt
         9ubBuPJ8/K+mkwwDnMbsWxOHdwKAqU917VJIk43GT5V6epxslNzHVyjvyGtyVAQj8PlF
         sxGsoMLcWQu31pdPTIE5OGxFakVhpnTwG8z3Yne7u9C0OEE0QalRslGaiN/9KgrkJPPe
         RmHdK9qEoLejMxITayBKV7yRwBsRFvKOL0dHr2vRjveyEXHcBmUrjmaxqS+rzAfmz3cg
         VVAQ==
X-Gm-Message-State: AOAM531QU+sACyzmYvrA0QNR38nj7thLOA2egTU/RxvfWFBR6U8ONQrc
        PbKMVnaOOzsVyF+IrUQb7HyCcg==
X-Google-Smtp-Source: ABdhPJz/aev8N6y31pAB6UzIcsBQYymcmpENQuaKADJHBV2VVawSzGAuLQLya8kx1ZvcesYAenAWhg==
X-Received: by 2002:a5d:64a6:0:b0:1f9:e22f:5f8d with SMTP id m6-20020a5d64a6000000b001f9e22f5f8dmr19925814wrp.530.1647339390511;
        Tue, 15 Mar 2022 03:16:30 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b00389a1a68b95sm3821778wmq.27.2022.03.15.03.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 03:16:29 -0700 (PDT)
Date:   Tue, 15 Mar 2022 11:16:26 +0100
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
Message-ID: <YjBnet2813sEGjZY@google.com>
References: <20220310093844.982656-1-sesse@google.com>
 <586de5fc-858b-2693-1986-5c77e8c0e3d0@intel.com>
 <YiuKAk7SaXP7B7Ee@google.com>
 <ba2c49da-22c5-06ea-e953-82211b953ca8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba2c49da-22c5-06ea-e953-82211b953ca8@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 14, 2022 at 06:24:19PM +0200, Adrian Hunter wrote:
> Perhaps changing it something like below.  What do you think?

I think the structure looks good, but I'm not sure about updating
e.g. ptq->last_cy_insn_cnt in both functions? Does that make sense?

I ran this and found something strange: I've started getting some hits
(very small amounts, e.g. 0.14%) on instructions that are not branches.
How can that happen?

/* Steinar */

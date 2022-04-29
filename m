Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC82C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Apr 2022 09:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356590AbiD2Jc3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Apr 2022 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356591AbiD2Jc1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Apr 2022 05:32:27 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F0FC614D
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Apr 2022 02:29:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id z16so6463250pfh.3
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Apr 2022 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w4FjUf2amMnNtUM3V1WSRpaIR/soCAC2c85qDmCjOYc=;
        b=K9CnZU+/0z9xMzif3fRMoJjXJkuNq60CeRCRh5VLytY8yubdi+yIuv9aOsW3irFnFK
         D28P474QuFLWnSyWnni4h4y8V6RBhIkSKhB90CZ6BPN9WNJcdLmDs7a2YFeDs1rzXuBP
         8UAE9YTkek0MIqooOekEHuPW+QtULxUAD52NZO7Bs4wp5rRNjnK+bJrTgqV6Ylbe+k29
         8uAKdmscOwhXM1f+1vN+W+gL0drUieSfVqbX9Xgh3sR7EQiR8VAXfqfe/7Pmbft8zRr8
         1uHHRxNeqNygwy/mIkmgzmGvewkrVf2z+yyBskQeEFEn2UBFkAHCpS0xXFrWKz//h2Y1
         D1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w4FjUf2amMnNtUM3V1WSRpaIR/soCAC2c85qDmCjOYc=;
        b=3GD/dTBlY/CribxWqjyTJ/LbZd7zCNzWAyttid4vU0WEsnOGYdV+o9qDz5wpkXchAg
         WfT6K9/2u2HganObpZnIJiFOwut59x0JlyYuwpfRBa6g5aVyIyzSAKh/4rQEf6ZE24OJ
         kjeT0tIkJHlgKz3sRQlmq1552HB6etjYYE76+mXZND4VSDaEHJGilVWuvtbqzGobZJ/3
         3saueLm+yzP7z2FjnkKnRlM39fRVFRax7nj1/TQt0+Av0OwXTCFwLkMFsSLEJ2vWIaQi
         L/lTyuWknooVZCAbUEZkBwqjB+zNIl8FLkzpaUlYQWbAyBRd7zB63bgW1cbeyIm4vL0g
         HkoA==
X-Gm-Message-State: AOAM53180ws8YeKSL6Y6dAgujmfIz3iIL9XET22V7+gBMwu99sRRmKzT
        l9qsDVkY9bEkGDGOqVxWyTk3hA==
X-Google-Smtp-Source: ABdhPJw6HNqq1pkJWNK3hVs7G1xGbJlSodfksqf+r/oPYZLoq5I18X82UBuTNvWz71NQQyjUIxIU9w==
X-Received: by 2002:a65:4c0c:0:b0:3c1:5bb1:6701 with SMTP id u12-20020a654c0c000000b003c15bb16701mr8682654pgq.136.1651224549581;
        Fri, 29 Apr 2022 02:29:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.180.65])
        by smtp.gmail.com with ESMTPSA id i127-20020a62c185000000b0050d4869918csm2345460pfg.216.2022.04.29.02.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 02:29:09 -0700 (PDT)
Date:   Fri, 29 Apr 2022 17:28:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Ali Saidi <alisaidi@amazon.com>,
        Nick.Forrington@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v5 2/5] perf: Add SNOOP_PEER flag to perf mem data struct
Message-ID: <20220429092859.GA645492@leoy-ThinkPad-X240s>
References: <c17dedde-6ba8-db9b-4827-32477f039764@linux.intel.com>
 <20220422212249.22463-1-alisaidi@amazon.com>
 <20220423063805.GA559531@leoy-ThinkPad-X240s>
 <8e09af67-a416-4ead-b406-6c8b998de344@linux.intel.com>
 <20220424114302.GB978927@leoy-ThinkPad-X240s>
 <b4aaf1ed-124d-1339-3e99-a120f6cc4d28@linux.intel.com>
 <20220427161908.GE562576@leoy-ThinkPad-X240s>
 <9923422f-2dd3-9951-5814-ab3972e67758@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9923422f-2dd3-9951-5814-ab3972e67758@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 27, 2022 at 03:29:31PM -0400, Liang, Kan wrote:

[...]

> > It's a bit difficult for me to make decision is because now SNOOPX_FWD
> > is not used in the file util/mem-events.c, so I am not very sure if
> > SNOOPX_FWD has the consistent usage across different arches.
> 
> No, it's used in the file util/mem-events.c
> See perf_mem__snp_scnprintf().

Right.  Actually I mean FWD flag is not for statistics.

> > On the other hand, I sent a patch for 'peer' flag statistics [1], you
> > could review it and it only stats for L2 and L3 cache level for local
> > node.
> 
> If it's for the local node, why don't you use the hop level which is
> introduced recently by Power? The below seems a good fit.
> 
> PERF_MEM_LVLNUM_ANY_CACHE | PERF_MEM_HOPS_0?
> 
> /* hop level */
> #define PERF_MEM_HOPS_0		0x01 /* remote core, same node */
> #define PERF_MEM_HOPS_1		0x02 /* remote node, same socket */
> #define PERF_MEM_HOPS_2		0x03 /* remote socket, same board */
> #define PERF_MEM_HOPS_3		0x04 /* remote board */
> /* 5-7 available */
> #define PERF_MEM_HOPS_SHIFT	43

Thanks for reminding.  I have considered HOPS flags during the
discussion with Ali for the flags, you could see PERF_MEM_HOPS_0 is for
"remote core, same node", this could introduce confusion for Arm
Neoverse CPUs.  Another thinking is how we consume the flags in perf c2c
tool, perf c2c tool uses snoop flag to find out the costly cache
conherency operations, if we use PERF_MEM_HOPS_0 that means we need to
extend perf c2c tool to support two kinds of flags: snoop flag and hop
flag, so it would introduce complexity for perf c2c code.

If we step back to review current flags, we can see different arches
have different memory model (and implementations), it is a bit painful
when we try to unify the flags.  So at current stage, I prefer to use
PEER flag for Arm arches, essentially it's not too bad that now we
introduce one bit, and later we may consider to consolidate memory
flags in more general way.

Thanks,
Leo

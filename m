Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633EAC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Jul 2022 00:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiGUA1b (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jul 2022 20:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiGUA1a (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jul 2022 20:27:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9F9655A7
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 17:27:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b11so346538eju.10
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 17:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bCLRjsvYtRZeZNV9Bm912X2zs0KkM1GXJxaEZhHa5nE=;
        b=HqMfVkkMPd0BQ06k135notIHxmB0/Wr0NhajRsDIE/q1frPsEfF5cN+9ONCxbxnP5D
         L8vG6ozVaqzhR98wdBJ3ap2Woe6/8AyIcyHIqcCkGQsZp0YnD/5meOUjRNixzqOjEsrm
         d/lKXf7c5DfoJp5ahmT4ImNt6nj3COLZ/j8d2YdNhuQT9yJuWBKYKaVpVcTGqOkAjErr
         JywaPH9o2dDwLwd+A389tgG/QBjfKvEBom4Q3mTtorlMiVxiWY1B5JAsdRHtRvHIhipA
         47niDJYvv3ly9eHuFjYat0VcT4Y9bv9RcCdGmOeneOm8kczIQeq3nCZeSyVMZGTxjNBw
         u/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bCLRjsvYtRZeZNV9Bm912X2zs0KkM1GXJxaEZhHa5nE=;
        b=jjbMV9Nh2v0KePOeVyKUPCyyOvfZ1pHhSigyRwhzMrtwvF/bmiWIwEPuktzMQIJYyo
         UX0UZsY091FBYOgkpmfTEcfgvg3wGYCWktKo7T10czjFFFCQi0AAcFYAElYPSWbVAzye
         +Emvn4r9NBuI6OiMDRsadQGkaIUubUq0RB+66BqZ3lqn5yCwy3IGN3tgh1SOIUe/RWBK
         j0vFxZgLrb4I+7rq/QtVfIa4fgZMONn8yUexNg62DWO5F9Kn6cO+CUT38LtRbYr/4RC9
         CxFZAgm0Sr3Zv/E1MOJIdJKwy2viRU2q8doPwSq5ka+g4sfekGkFDnOOg3J7HHZ9iGfJ
         MPtQ==
X-Gm-Message-State: AJIora/QQ9O2pzxOfagFblRl0owf0EBab/rTrwOnfQHfe5BOv8QaAo0y
        ecS/UrNA+t/wPdPSUhVfAcSurQ==
X-Google-Smtp-Source: AGRyM1vgRhqQv3LgmIHebxs9JwPcvjq22yU0EnYatlVT11ojjmDMODN5Id2uFmWBXjUd5sSDsbQ2ig==
X-Received: by 2002:a17:906:7e43:b0:72b:52de:b039 with SMTP id z3-20020a1709067e4300b0072b52deb039mr38326269ejr.198.1658363246662;
        Wed, 20 Jul 2022 17:27:26 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.97.246])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090623ea00b0072ab06bf296sm213886ejg.23.2022.07.20.17.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 17:27:25 -0700 (PDT)
Date:   Thu, 21 Jul 2022 08:27:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH v5 01/17] perf: Add SNOOP_PEER flag to perf mem data
 struct
Message-ID: <20220721002719.GA29595@leoy-ThinkPad-X240s>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
 <20220604042820.2270916-2-leo.yan@linaro.org>
 <YthNXweIEdNfcoX1@kernel.org>
 <YthNmcOJOZitcsjD@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YthNmcOJOZitcsjD@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 20, 2022 at 03:46:49PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jul 20, 2022 at 03:45:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Sat, Jun 04, 2022 at 12:28:04PM +0800, Leo Yan escreveu:
> > > From: Ali Saidi <alisaidi@amazon.com>
> > > 
> > > Add a flag to the perf mem data struct to signal that a request caused a
> > > cache-to-cache transfer of a line from a peer of the requestor and
> > > wasn't sourced from a lower cache level.  The line being moved from one
> > > peer cache to another has latency and performance implications. On Arm64
> > > Neoverse systems the data source can indicate a cache-to-cache transfer
> > > but not if the line is dirty or clean, so instead of overloading HITM
> > > define a new flag that indicates this type of transfer.
> > > 
> > > Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > > Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
> > 
> > Hey, any knews about this going upstream? PeterZ?
> 
> Just took a look and it isn't in tip/master.

Yeah, this patch is not picked by maintainers.

I confirmed that this patch can be applied cleanly on tip/master
branch.  Peter.Z, could you pick this patch?

Thanks,
Leo

Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A90C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Dec 2021 02:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhLJCpU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Dec 2021 21:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbhLJCpT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Dec 2021 21:45:19 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C61C0617A1
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Dec 2021 18:41:45 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b13so5340868plg.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Dec 2021 18:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dFG7VYxOjOhYsJP9kRd1FAhsC4PsRRF5GAY8mdFTZRM=;
        b=rxJNo4UA9nxX87sU2qN90MyRWnQgEHaoIhBxk1DZKAHId3hzlzTWqNJR3f/Gr/3424
         DZ7vRbAb0Xdk0HJCAAWj4uR15ye6g42FwaRo/jwN2fMMAvKgXkqtwUBn1wMZ8boqHGSg
         g2DIRvJfky+Qk8v5AxhUDZ7FqKbVIrDqAKBBhx1EsGYbsiEPZCnTJ44xCcRzBqEu8d2a
         pu2lrwJSSj+bw3l/r9kSut4g3qaZIhXdvLbZa+xmS4OW7HYRRIjCIOmuyDkIhIyPUqAn
         j5ZAboTTPU3rbch5vyTUMfBuX7TCfFvJjJzV+egP9mPSkqXCvpjwSUfSL5yh7Pu6zF1t
         qmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dFG7VYxOjOhYsJP9kRd1FAhsC4PsRRF5GAY8mdFTZRM=;
        b=m0oF7rau7am1fIxUgxyl0f1sMk+rxTpYKMNwIp7JV4RVC0jpH+ulu4F+TWZe0BpTK5
         m8oh6QqoapL+uvbQyTfDy/XlYkH0wmw0gtW/pdh+zF2Ugen2GAaQfWgVPkloBZwtvl2p
         D9A9bpK6u4XUg+1AkE6LRk/nuMhQY/GkAgYGZ9Ysaonl12ZjnMIP4aHrqelF/5ecNIbv
         DzBs3z61CghlVRcrVqnmSQ5/lFgPMJ+USLYlJHLpAiqCc72j2u/AHOICGHX1PNUjn4i2
         buvjx40LSiFrWvUIeCxYWyuftv8pVFU74ywS7hgoEqj+3exr9myYt5gfds41yP0DuWf9
         qtrw==
X-Gm-Message-State: AOAM532B4fFjmoIx566SsF0mcu7QwNQm9P7aI8eCKr2y3aAsyZOYQ2vm
        a81baZuqdVcC9tKp2ckAGIZaQQ==
X-Google-Smtp-Source: ABdhPJzDWrnfuGRgQ582cyYFqozMeJSSnnLc3b5V2TPA8BmgS8UyV++OmfEZtD7RGD9trEB6e5BvYA==
X-Received: by 2002:a17:902:d703:b0:144:e012:d550 with SMTP id w3-20020a170902d70300b00144e012d550mr71056986ply.38.1639104104911;
        Thu, 09 Dec 2021 18:41:44 -0800 (PST)
Received: from leoy-ThinkPad-X240s (216.24.179.124.16clouds.com. [216.24.179.124])
        by smtp.gmail.com with ESMTPSA id z14sm1075784pfh.60.2021.12.09.18.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 18:41:44 -0800 (PST)
Date:   Fri, 10 Dec 2021 10:41:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf cs-etm: Update deduction of TRCCONFIGR register
 for branch broadcast
Message-ID: <20211210024137.GB622826@leoy-ThinkPad-X240s>
References: <20211208160907.749482-1-james.clark@arm.com>
 <20211208160907.749482-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208160907.749482-3-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Dec 08, 2021 at 04:09:07PM +0000, James Clark wrote:
> Now that a config flag for branch broadcast has been added, take it into
> account when trying to deduce what the driver would have programmed the
> TRCCONFIGR register to.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/include/linux/coresight-pmu.h | 2 ++
>  tools/perf/arch/arm/util/cs-etm.c   | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> index 4ac5c081af93..6c2fd6cc5a98 100644
> --- a/tools/include/linux/coresight-pmu.h
> +++ b/tools/include/linux/coresight-pmu.h
> @@ -18,6 +18,7 @@
>   * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
>   * directly use below macros as config bits.
>   */
> +#define ETM_OPT_BRANCH_BROADCAST 8

I checked ETMv3 architecture spec (ARM IHI 0014Q), its bit 8 is "branch
output" for all branch address outputting.  I am not sure if it is the
same thing between ETMv3's "branch output" and ETMv4's "branch
broadcasting", but it makes sense for me to use bit 8 as an unified
config bit to control these two options for ETMv3 and ETMv4
respectively.

Just note, I understand this patch set is to enable branch broadcasting
for entire memory region rather than using any comparators (see
TRCBBCTLR) to limit branch broadcasting ranges.  This is fine for me and
we could enable ranges later.

Reviewed-by: Leo Yan <leo.yan@linaro.org>

>  #define ETM_OPT_CYCACC		12
>  #define ETM_OPT_CTXTID		14
>  #define ETM_OPT_CTXTID2		15
> @@ -25,6 +26,7 @@
>  #define ETM_OPT_RETSTK		29
>  
>  /* ETMv4 CONFIGR programming bits for the ETM OPTs */
> +#define ETM4_CFG_BIT_BB         3
>  #define ETM4_CFG_BIT_CYCACC	4
>  #define ETM4_CFG_BIT_CTXTID	6
>  #define ETM4_CFG_BIT_VMID	7
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 293a23bf8be3..c7ef4e9b4a3a 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -527,6 +527,9 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
>  	if (config_opts & BIT(ETM_OPT_CTXTID2))
>  		config |= BIT(ETM4_CFG_BIT_VMID) |
>  			  BIT(ETM4_CFG_BIT_VMID_OPT);
> +	if (config_opts & BIT(ETM_OPT_BRANCH_BROADCAST))
> +		config |= BIT(ETM4_CFG_BIT_BB);
> +
>  	return config;
>  }
>  
> -- 
> 2.28.0
> 

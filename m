Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B1DC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 09:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiERJ5y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 05:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiERJ5o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 05:57:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431853150E
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 02:57:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a11so1688971pff.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tc9+bvqYCqMUSJXb0nfQvcyKgjqV7Ocz6lWJsoBLOyQ=;
        b=am+ErBo1ZB0G/hYVBrcfY1g1WCS12VRPKU0MqxO1eFPOZMnO1PfcYkLY3tknTliDWw
         wBxg3LqZeg3ef3iGmyHkqn5SkRzAY1N5efuwoM7Ks+s38oDEoUJ05k6XRmLMQkuXE23j
         Ts51nH6G6UDl9pi4Jy0PmG8h/z4mbK/jT4Qi/3K+KzA3bYHCZ9R60zq74x+5dZidSzJ/
         eWrgC3XfDdl4Mzm+4qDElEQJiU4NCV3owan7qspY8A0AndODbOwqRy2U50Dzxc/nU3as
         5QpBsthosbzuJM2zWM2vnv8Db49i3VEpNpZVfEub7knFMi3uWBTIiRIJdYAeOvh0dkuN
         GJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tc9+bvqYCqMUSJXb0nfQvcyKgjqV7Ocz6lWJsoBLOyQ=;
        b=aNs6KNFDAdUwjiceqSBQ+2PSRMA02mzUlbDA7TOZ40YwTSKjgaZDTfwLgKWLw0wblY
         enr24Cgrgc1a6zrjpgoviNn0iwdkAkgCjQs/uo2ow/Y2Pg073gUyk6RDkdSryEceN6k/
         xF95FNvfwr1ptDRj/vYwkruz5ftekqMkchemFqQKZoVtaNNVPMBkM4Zw3oNFvd/Cg+hK
         zhEDVZRMI28RRxcF1EjlMjVqbTNyvJOdADUger5uVtrOY7AKPiYN+hVzdmOVqDsqvcNd
         q8i+D5IbNiar6TeFLz7QyjNxznnfq2bcz2MT2563dhCgULG8A0ttMRPF2OaA7z548F7a
         WOvQ==
X-Gm-Message-State: AOAM532ycz8+3A42vA3WG8CfJSf9LmDv6IsOODhwVmqrA7HNLihETQ5Y
        PzFxExBVom2659KU/STGxoGKxA==
X-Google-Smtp-Source: ABdhPJwxN17DvvwgA27WGHd/CQU6EzFpAzCAl1BFGWWAOX6ggp1eIFb0ryL4HktPXI/Dtai14vWbIA==
X-Received: by 2002:a63:5a01:0:b0:3d8:22cb:9224 with SMTP id o1-20020a635a01000000b003d822cb9224mr22960915pgb.548.1652867863321;
        Wed, 18 May 2022 02:57:43 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([137.184.121.66])
        by smtp.gmail.com with ESMTPSA id s26-20020a056a001c5a00b005180ea859d7sm1419223pfw.123.2022.05.18.02.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 02:57:42 -0700 (PDT)
Date:   Wed, 18 May 2022 17:57:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org, german.gomez@arm.com,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] perf tools: arm64: Add support for VG register
Message-ID: <20220518095735.GB430350@leoy-ThinkPad-X240s>
References: <20220517102005.3022017-1-james.clark@arm.com>
 <20220517102005.3022017-5-james.clark@arm.com>
 <20220517131952.GE153558@leoy-ThinkPad-X240s>
 <ca02e8f5-04bd-01ff-7b57-0fd08a1e2359@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca02e8f5-04bd-01ff-7b57-0fd08a1e2359@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 18, 2022 at 10:44:57AM +0100, James Clark wrote:

[...]

> >> +	if (getauxval(AT_HWCAP) & HWCAP_SVE)
> >> +		attr.sample_regs_user |= SMPL_REG_MASK(PERF_REG_ARM64_VG);
> >> +
> >> +	/*
> >> +	 * Check if the pmu supports perf extended regs, before
> >> +	 * returning the register mask to sample.
> >> +	 */
> >> +	if (attr.sample_regs_user != PERF_REGS_MASK) {
> >> +		event_attr_init(&attr);
> >> +		fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
> >> +		if (fd != -1) {
> >> +			close(fd);
> >> +			return attr.sample_regs_user;
> >> +		}
> >> +	}
> > 
> > Just curious, since we can know SVE is supported from reading
> > auxiliary value, can we directly return the register mask as below?
> > 
> >   PERF_REGS_MASK | SMPL_REG_MASK(PERF_REG_ARM64_VG);
> 
> I was trying to cover the case where the system supports SVE, but
> the kernel doesn't have my changes to add the VG register yet.
> 
> Technically I could just attempt to open the event without checking
> for SVE first and see if it works or not. But I preferred to be
> explicit so it's obvious why we're doing that.

Understand; LGTM.

Reviewed-by: Leo Yan <leo.yan@linaro.org>

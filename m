Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CD7C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 14:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiEROBY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 10:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbiEROBL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 10:01:11 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56844D8C
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 07:01:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id a19so2220273pgw.6
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 07:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ar6rolDwLMeiHKbJnDClgLyagtpYgq995PIhqINQJmI=;
        b=OsMbFN6UrvDrNN0x3SKeFWq+SxjRL/JJpZp5yIY6ZSFLP/OrjvnIkq76NgNLjqw0H1
         pVMF3pduSoX5BUlY/plgpl9vArHTEoNhG3AcgJsqmaE/Ef1/JRwUlIfxyeToS8EwgHNZ
         jvA+PAEmfSQmXlUs6nqrKgO9iabtZofxGUd3sN7BqRr8cvkCAyPE1rWhLzEh2nUSjgi+
         QCvShooGOHp5rSaAd4RKvDQhFQiP091GC1mPvwq8Z5jvXtmKj5L8CHqGpKkw5+IGuoug
         Ur+KQec0ZrywjGfIpKPP/+6tCdc038aYFc4xi7TKo1kT/muZPLafdJFTZzoBahgOMPUY
         SSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ar6rolDwLMeiHKbJnDClgLyagtpYgq995PIhqINQJmI=;
        b=OXHwORsnfQ6RQ8I/fHxGyr+1c1jt/9FZEbG7LVqXqVzRzsxGetSWlAAUgsee221SL9
         zb725o7N5q6+HA1URTMSArPXJlTRKeZr9zgjRHR/EAuBFeeXsN8Fb18v+XyHH0IsHdf6
         eUekQwhsJik9hOdeJwhmnsJ5T2+Pl/jd0dUbOxZxxxMdxJ1OyUiUYU6WWSaKr1gj5B4M
         PUbmrNBbOr/dUSX+5oNGWpo00e884CDEHeGxot/mXAIjSdLSzSJuEdfibF8inZY2MwV0
         CpuzJoX5uqcVIOSwUW9hbzMniq/sDTdWgrf2jRaI1d3GB1Y0PI5LkmJ6C+EX6vblcNFV
         CtwA==
X-Gm-Message-State: AOAM531cIdVc554Hr+myiL/MAj0NeM4taBWlNED4bN0R9ZRdYKZ4SbEZ
        rdvsu2ZtDWRm2lAFCazeB0eKFw==
X-Google-Smtp-Source: ABdhPJx3TNLz5f+9W529D5xXMinFWX+KMP0uI3fcwFLjPjaV6R9V5Bp4DSPFyvBx/r/K6tv6GzEI0g==
X-Received: by 2002:a63:4e62:0:b0:398:cb40:19b0 with SMTP id o34-20020a634e62000000b00398cb4019b0mr24001969pgl.445.1652882464989;
        Wed, 18 May 2022 07:01:04 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([137.184.121.66])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090302cd00b0015e8d4eb244sm1685310plk.142.2022.05.18.07.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 07:01:04 -0700 (PDT)
Date:   Wed, 18 May 2022 22:00:56 +0800
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
Subject: Re: [PATCH v2 2/4] perf tools: Use dynamic register set for Dwarf
 unwind
Message-ID: <20220518140056.GC430350@leoy-ThinkPad-X240s>
References: <20220517102005.3022017-1-james.clark@arm.com>
 <20220517102005.3022017-3-james.clark@arm.com>
 <20220517110322.GC153558@leoy-ThinkPad-X240s>
 <8f48b4d3-b463-a858-c0fc-0d503eee42dd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f48b4d3-b463-a858-c0fc-0d503eee42dd@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 18, 2022 at 02:25:38PM +0100, James Clark wrote:
> 
> 
> On 17/05/2022 12:03, Leo Yan wrote:
> > On Tue, May 17, 2022 at 11:20:03AM +0100, James Clark wrote:
> >> Architectures can detect availability of extra registers at
> >> runtime so use this more complete set for unwinding. This
> >> will include the VG register on arm64 in a later commit.
> >>
> >> If the function isn't implemented then PERF_REGS_MASK is
> >> returned and there is no change.
> >>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> > 
> > This patch looks good to me:
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > 
> > Just curious, do you think should update the test (e.g.
> > arch/arm64/tests/dwarf-unwind.c) to use arch__user_reg_mask()?
> 
> I don't think so because the normal set of registers is manually
> loaded in tools/perf/arch/arm64/tests/regs_load.S so it wouldn't
> include this pseudo register. Also there is no SVE in the call
> chain of the test so it would never have an effect.
> 
> I could add a new test for SVE, but it depends on getting the
> libunwind changes through first so will have to come later.

It makes sense to add new SVE test later, thanks for clarification.

So this patch series looks good for me.

Leo

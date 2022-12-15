Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2E4C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Dec 2022 01:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLOBoL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Dec 2022 20:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLOBoK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Dec 2022 20:44:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4B12D1CA
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Dec 2022 17:44:05 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so1177048pjm.2
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Dec 2022 17:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WmAkvDBKMNNGormxiR/sVMbcrKMt/tgyZJoKB0gFsB0=;
        b=ijXibnLuHzRzsqBDk+Xk86VZwXDIofKPWnvJrpJv5mIoZ1MCKwUyISd4IpTz6xhsB3
         DAse7DyLkBtjgJ2Mf8YzyfA9h6QaR8xrcN4fz0VHgaMqCg4DjmIUI5/EYqX3M0I7T6TX
         GGhS2V6XP5u5EVFXbu2f/kkDc3MQ8pRkmO4AAa/WdVE1TuW+AkdRMn0xDk51qeOke2Qi
         dvzDkj1Oe+dsEwezKfilIZLsILhVJFfUbTj9j5fxlohHdkySCJYM7bOYVmRrMDq0AqRY
         5jrDvk1pxjB7k/XzrPyAQgrQBncj3JbAjDmak6pkT9Uav/gvIWQN53ruIigm1x64DuE9
         Ed4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmAkvDBKMNNGormxiR/sVMbcrKMt/tgyZJoKB0gFsB0=;
        b=mNelhj0LbTPaDuBvElV45cYFF802KF59GcLVnj/9Jf41E+V4bmoX/kgc5qaywc8rv5
         dUlx5es1KCNEUivXjtJKUO2P3HAinPtvc2R319Xmsh7xXd23xsSczZjn/82WsIjMd9Ia
         MUqVTzLZq91SRgreBVCfxAbJEwquwRatA5jjm9LhE7axXOv7+FXmL4VkQR3cvVBOCh2b
         f1dhH76veK0dAoozVyF/wsb25t9fvNxbl1TxGIJLds5FqoNEFVmTzFN9oJqpRvE7iFYb
         LJMbUe0OGAFZ3N7XSei8bnI7yiQhk6x2gjT6K7nbqOdBmVdJVuTDPEkZ7ZEWLIz63vF2
         MqDA==
X-Gm-Message-State: ANoB5pnV811lRKvlqjQ7OIGNgMAwX6njC1RPfZph3iIW1n4DgXIHq7YM
        Z7T+909GqB0IujahpHSXG1DOdQ==
X-Google-Smtp-Source: AA0mqf7+pQUOfbHT3BZLML0xqnDfuCi4zbmc2bJpy7XuurL1h+qED3gKG8yW2nFnqm74YWJZtVP6ZA==
X-Received: by 2002:a17:90a:384e:b0:212:de1a:3505 with SMTP id l14-20020a17090a384e00b00212de1a3505mr27535065pjf.28.1671068645033;
        Wed, 14 Dec 2022 17:44:05 -0800 (PST)
Received: from leoy-yangtze.lan ([152.70.116.104])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090a910d00b00218b47be793sm1979303pjo.3.2022.12.14.17.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 17:44:04 -0800 (PST)
Date:   Thu, 15 Dec 2022 09:43:55 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kevin Nomura <nomurak@google.com>
Subject: Re: [PATCH] perf stat: Do not delay the workload with --delay
Message-ID: <Y5p723KMYBI2W6vs@leoy-yangtze.lan>
References: <20221212230820.901382-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212230820.901382-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Dec 12, 2022 at 03:08:20PM -0800, Namhyung Kim wrote:
> The -D/--delay option is to delay the measure after the program starts.
> But the current code goes to sleep before starting the program so the
> program is delayed too.  This is not the intention, let's fix it.
> 
> Before:
> 
>   $ time sudo ./perf stat -a -e cycles -D 3000 sleep 4
>   Events disabled
>   Events enabled
> 
>    Performance counter stats for 'system wide':
> 
>        4,326,949,337      cycles
> 
>          4.007494118 seconds time elapsed
> 
>   real	0m7.474s
>   user	0m0.356s
>   sys	0m0.120s
> 
> It ran the workload for 4 seconds and gave the 3 second delay.  So it
> should skip the first 3 second and measure the last 1 second only.  But
> as you can see, it delays 3 seconds and ran the workload after that for
> 4 seconds.  So the total time (real) was 7 seconds.
> 
> After:
> 
>   $ time sudo ./perf stat -a -e cycles -D 3000 sleep 4
>   Events disabled
>   Events enabled
> 
>    Performance counter stats for 'system wide':
> 
>        1,063,551,013      cycles
> 
>          1.002769510 seconds time elapsed
> 
>   real	0m4.484s
>   user	0m0.385s
>   sys	0m0.086s
> 
> The bug was introduced when it changed enablement of system-wide events
> with a command line workload.  But it should've considered the initial
> delay case.  The code was reworked since then (in bb8bc52e7578) so I'm
> afraid it won't be applied cleanly.
> 
> Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
> Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Reported-by: Kevin Nomura <nomurak@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F163EC46467
	for <linux-perf-users@archiver.kernel.org>; Sat,  7 Jan 2023 04:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjAGENi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Jan 2023 23:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjAGENf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2023 23:13:35 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C227265AC5
        for <linux-perf-users@vger.kernel.org>; Fri,  6 Jan 2023 20:13:33 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c9so2480699pfj.5
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jan 2023 20:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQWRT1zBbVg0y6fDKie0cz1a4q8VBI/6TX+VABGDkME=;
        b=vIlp3hGlUgxO+71HJ2g378GGa+buP7WDuMBWGRVmbYzXw2Yd9hhZY/hdbd6p4KgTH7
         WcPCX1la83FBHfkilnVFcYNL8jYLAGSdGYwfzc1iahjr1xu8DiGbXYIdoPOJ8EZcXk5m
         O1XdKJsdPSg6UYeyhTEUlcXpLW7jBu47Vi98EI0TKFdfFnD4+3Qb64SZ4KQcoidsNXHn
         hTcBuidAnuaeyFI8cKthdoN7fy4k5Mq9g096qDVpJzygKjwV/yY2JNuywh+ueoNcuP+C
         SG3t1FA5a8Mh0wFCAc2aPq+pJieax42WIXJssn3qJymf4KeEcPKO9+Cz2lpaSE/A0krc
         JwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQWRT1zBbVg0y6fDKie0cz1a4q8VBI/6TX+VABGDkME=;
        b=mTNWXn87KoknUVZ12cyy3a2bBPlvm3vWrySQ1aEfCX7AjhFhtyRYTKiaF5Z2Fc77gW
         FTbCV3z6sVn1PfYzlkAI9Wr7/Io5d50RNuIfmGVO77Bbb2bunusUR8OZ8EHL6H3Ip4s5
         J539UconysxmSab0Ufw95mdPY0RpZxBD9Rbhn/rtbM7Gsb4vcOilIhmGRBwN7QSReZ+c
         yiMBkAATICfvMxIw9Ka3H7t79yYQuWtuGw/XwoOqyTaWSNshiuRhylhwQNcX89Qhzdth
         9D6GYNxzn2C4LMyrVrDkKaqR92dFbmxj5E2nqvU8dTZ/UAnatECgJq9DeOh59/JnrP+w
         p7aw==
X-Gm-Message-State: AFqh2kpGLCdyYNfCao0sYcRYbtjV9nCznX40biZtfjJXGgZY+bwEwtvP
        T01z6bgpkSM2b7uYKQ+Gu+Q5xQ9wOKCcswTn3PKcVIh+
X-Google-Smtp-Source: AMrXdXu4U4OwAfGRjWZiIXdg7FSe2JV8uBpjlvoWNFSk3JLNv/MSecSCsdBWPYHriG6Fp0QdOKAEPw==
X-Received: by 2002:a05:6a00:2410:b0:580:ea08:5277 with SMTP id z16-20020a056a00241000b00580ea085277mr62634481pfh.16.1673064813083;
        Fri, 06 Jan 2023 20:13:33 -0800 (PST)
Received: from leoy-yangtze.lan ([152.70.116.104])
        by smtp.gmail.com with ESMTPSA id p62-20020a622941000000b0058130f1eca1sm1790211pfp.182.2023.01.06.20.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 20:13:32 -0800 (PST)
Date:   Sat, 7 Jan 2023 12:13:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [BUG] perf kmem: Broken because of missing tracepoints
Message-ID: <Y7jxZZ+jVrldfcPx@leoy-yangtze.lan>
References: <b5f82509-41d7-7598-6ec2-fcfa74c7ddaa@amd.com>
 <Y7b6cmRE/+5HJLCa@kernel.org>
 <Y7ewMG+0YKp9pgud@leoy-yangtze.lan>
 <c4c5c3cb-f1a8-84ee-0dc8-8be0d63c820d@amd.com>
 <Y7haGk30muVMjRhF@kernel.org>
 <Y7heE/e+g9IbefmO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7heE/e+g9IbefmO@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 06, 2023 at 02:44:51PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > > > Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > > > Fixes: 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of tracepoints")
> 
> But I'm removing this Fixes: tag (leaving the reference in the 1st
> commit log message paragraph tho), and removing the term "ABI", as AFAIK
> tracepoints can change and tools have to adapt, right?
> 
> Lemme see...
> 
> Documentation/bpf/bpf_design_QA.rst
> 
> Q: Are tracepoints part of the stable ABI?
> ------------------------------------------
> A: NO. Tracepoints are tied to internal implementation details hence they are
> subject to change and can break with newer kernels. BPF programs need to change
> accordingly when this happens.

Okay, it's fine for me to remove the term "ABI" in commit log.

But I am confused for removing Fixes tag, this leads us to have no
chance to backport this patch to any stable kernel branches, right?

> ---
> 
> 
> 
> > > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > 
> > > Thanks Leo. A quick test shows it fixes the issue.
> > > 
> > > Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > 
> > Thanks, applied.
> 
> And I retract that, we need to query for the existence of these
> tracepoints and use it if available, as we expect a new perf tool to
> work on an older kernel, one where the removed tracepoints may be
> available.
> 
> Leo, can you try to rework this?

Sure, will respin the patch.

Thanks a lot for the suggestion and Ravi's testing.

Leo

> If you look at tools/perf/builtin-sched.c it queries for the existence
> of:
> 
> static bool schedstat_events_exposed(void)
> {
>         /*
>          * Select "sched:sched_stat_wait" event to check
>          * whether schedstat tracepoints are exposed.
>          */
>         return IS_ERR(trace_event__tp_format("sched", "sched_stat_wait")) ?
>                 false : true;
> }
> 
>         /*
>          * The tracepoints trace_sched_stat_{wait, sleep, iowait}
>          * are not exposed to user if CONFIG_SCHEDSTATS is not set,
>          * to prevent "perf sched record" execution failure, determine
>          * whether to record schedstat events according to actual situation.
>          */
>         const char * const schedstat_args[] = {
>                 "-e", "sched:sched_stat_wait",
>                 "-e", "sched:sched_stat_sleep",
>                 "-e", "sched:sched_stat_iowait",
>         };
>         unsigned int schedstat_argc = schedstat_events_exposed() ?
>                 ARRAY_SIZE(schedstat_args) : 0;
> 
> So its something along those lines.
> 
> Thanks,
> 
> - Arnaldo

Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28FDC2B9F4
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 12:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C490961477
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 12:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhF1MOz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Jun 2021 08:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbhF1MOu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Jun 2021 08:14:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BD6C061574
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Jun 2021 05:12:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id kt19so2057188pjb.2
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Jun 2021 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2xcGOgP/yg1u7n803j0UADdqFly0YaxV+TsFk8YNqGg=;
        b=q0XtAxQCldYUjMpu+SY9e/g2ItjBE0+iCawDmqpGlnW9tg1QZoxU1EerpByITcNWpo
         dYYERIGvOrhKWkz68obNn4RVU/T6Vn7ARfiLc9xK8sI+djcHH8LTkBtwf1IuK3ZX9q7m
         TfVz9UOi881d1rqWEIxZpFFpPdzqknoSGGszEtdO9IDm8V2EjYmJ4EZlHK8WK5EfIbKi
         HTtzL7Md3RkabxkmtU+Hd5AG+oheb+jkOs+1F+sEO/uncvw8yS53OsiNeDoXMguaZMcB
         yBGuqzS5L70IluQiN3qJ8EUc75jnbvDeTnDufd3tJ1hKp4lnAXQAxofN2vkO8GRPJwUi
         gEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2xcGOgP/yg1u7n803j0UADdqFly0YaxV+TsFk8YNqGg=;
        b=aWMLCmrlQDc99/6gQUzt98FZXAL088RY3PCvbcrhsasyvuJznDdcnk+8CmFji/7AlB
         bE6UGKHIrXRekvy7dv5x8yx024h2T3ylnk4EiYKM7M6TAMC1+5vC9SopG9FKi7pfjLcT
         YJBUyDR9+/cVVfJSWKOMcXad4DJyAuOcjiKwP4RdIWQEfsd6cAyrE/ruIhLjNHm4ywHE
         FMgQmZvtlGwI4yinyOpGenqvqWqTBatG20YoGu1DVi7jSMFpd3ynXrCVNHA13riEVsF2
         N4wNQEc3XOPgbt+ADGdwcC0RYSLGyDbUMimGuuDyN1BiCWnde4YaVCNBZRP9uGeg33lB
         9VKA==
X-Gm-Message-State: AOAM532CsABjzALVFKKk8+D88n7SjvSYdwsYWGAUF7//JENRadbiFlGV
        vZvvHUXefDjzEStu+lvH4EPK6w==
X-Google-Smtp-Source: ABdhPJy3t88iPCr1uRgXPIlJRE1hWIf9EVjMlvHN4QcQ52KFGeWoAA5vxIvilcuwAN6yuVxJVewSOw==
X-Received: by 2002:a17:902:e04f:b029:eb:66b0:6d08 with SMTP id x15-20020a170902e04fb02900eb66b06d08mr22425677plx.50.1624882343334;
        Mon, 28 Jun 2021 05:12:23 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id b22sm6140182pfp.20.2021.06.28.05.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:12:22 -0700 (PDT)
Date:   Mon, 28 Jun 2021 20:12:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] perf arm-spe: Don't wait for PERF_RECORD_EXIT
 event
Message-ID: <20210628121217.GD200044@leoy-ThinkPad-X240s>
References: <20210519071939.1598923-1-leo.yan@linaro.org>
 <20210519071939.1598923-6-leo.yan@linaro.org>
 <369fd454-d94d-daa1-ead4-b42645ec4282@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <369fd454-d94d-daa1-ead4-b42645ec4282@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 25, 2021 at 02:25:15PM +0100, James Clark wrote:
> 
> 
> On 19/05/2021 08:19, Leo Yan wrote:
> > When decode Arm SPE trace, it waits for PERF_RECORD_EXIT event (the last
> > perf event) for processing trace data, which is needless and even might
> > cause logic error, e.g. it might fail to correlate perf events with Arm
> > SPE events correctly.
> > 
> > So this patch removes the condition checking for PERF_RECORD_EXIT event.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/arm-spe.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index 5c5b438584c4..58b7069c5a5f 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -717,11 +717,7 @@ static int arm_spe_process_event(struct perf_session *session,
> >  					sample->time);
> >  		}
> >  	} else if (timestamp) {
> > -		if (event->header.type == PERF_RECORD_EXIT) {
> > -			err = arm_spe_process_queues(spe, timestamp);
> > -			if (err)
> > -				return err;
> > -		}
> > +		err = arm_spe_process_queues(spe, timestamp);
> >  	}
> >  
> >  	return err;
> > 
> 
> For the whole set:
> Reviewed-by: James Clark <james.clark@arm.com>
> Tested-by: James Clark <james.clark@arm.com>

> I see a big improvement in decoding involving multiple processes because the timestamps are now
> correlated with the comm and mmap events.
> 
> For example perf-exec samples are visible right before the exec is done, and on an
> application that forks, samples are visible from all processes. For example:
> 
>    perf record -e arm_spe// -- bash -c "stress -c 1"
>    perf script
> 
>    perf-exec  4502 [003] 259755.050409:          1    l1d-access:  ffff80001014b840 sched_clock+0x40 ([kernel.kallsyms])
>    perf-exec  4502 [003] 259755.050409:          1    tlb-access:  ffff80001014b840 sched_clock+0x40 ([kernel.kallsyms])
>    perf-exec  4502 [003] 259755.050409:          1        memory:  ffff80001014b840 sched_clock+0x40 ([kernel.kallsyms])
>    perf-exec  4502 [003] 259755.050411:          1    tlb-access:  ffff800010120fb8 __rcu_read_lock+0x0 ([kernel.kallsyms])
>    bash  4502 [003] 259755.050411:          1   branch-miss:  ffff8000105b2a40 memcpy+0x80 ([kernel.kallsyms])
>    bash  4502 [003] 259755.050411:          1    tlb-access:                 0 [unknown] ([unknown])
>    ...
>    stress  4502 [003] 259755.051468:          1    l1d-access:  ffff800010259a24 __vma_adjust+0x1f4 ([kernel.kallsyms])
>    stress  4502 [003] 259755.051468:          1    tlb-access:  ffff800010259a24 __vma_adjust+0x1f4 ([kernel.kallsyms])
>    stress  4502 [003] 259755.051468:          1        memory:  ffff800010259a24 __vma_adjust+0x1f4 ([kernel.kallsyms])
> 
> Previously samples were only attributed to 'stress', which was obviously wrong.

Thanks a lot for the review and testing, James!

Hi Arnaldo, I confirmed this patch set can be cleanly applied on
the latest acme/perf/core branch, so could you pick up this patch
set?

Thanks,
Leo

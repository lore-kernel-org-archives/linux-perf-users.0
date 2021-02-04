Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88063C433DB
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Feb 2021 10:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4762B64F5E
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Feb 2021 10:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhBDKaX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Feb 2021 05:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbhBDK2W (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Feb 2021 05:28:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9BC0613D6
        for <linux-perf-users@vger.kernel.org>; Thu,  4 Feb 2021 02:27:42 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x9so1526620plb.5
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Feb 2021 02:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G/PRvHQZrJ2T0S5zQcr1fWGqwCCoQCVYV/jaTCOn8d0=;
        b=AaROb4Qkt5DadaqNo3VHDxW+laTgQhtPAZcGa4e/GJ9RmlumsmZYCz8JI/vYmLUPXY
         sJJPZsvN9sgNELRBXGBQ7Xq/WVfzUnFN9mQ2G6qfD+e7kNBGL42FafgJodOQOB5mTtcS
         2wgBKdGM9/DJHv3t/P9b0BmdK2ZJMMelRPTs9kFFMQ+5TNJOHzg5aZ0c7c00SwHyHd02
         ClXFsYPNuywuUF9SpWP0f82JQJBhfr6A6I0jbmdgDUZCDTMJHY3iO1+GH/FpR/fUZ6B/
         08MtAHXNyQRzg3bLgzrxBnr4Bn/Ms9Wv9ZIVtzyXfD2uscb/iwJ1Jn4+5vDBUFI8fJr+
         hAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G/PRvHQZrJ2T0S5zQcr1fWGqwCCoQCVYV/jaTCOn8d0=;
        b=aUYkjlGn1+Le72Ucgr4v0LV6NGzHr2AAbGfOm5SocbAFaWKTnr3FVHrCwTDqEBN4Wr
         hVIhDcbJQva3VMuGefQnAkO+Gpc9zZk5xXdqNxfLHNl8kaxec2is97KLl0WAL4PRQhUP
         5xg5gIijVG5/sJV5SMjx8QcniGwlfjSof6YvmW2EL4XjDpzM355273507SccxZwKcq39
         p8HmrgzjtTOB/YI0h6bB/iqGtm81tJtQsGWi8EyZ8GjNGMaIJRv7RV9NPkJ/JevKf2dV
         vwxkuL/Ou9h5mJtTxR4PfMP0ny8GQX90FaeCfxY91rL6VkeAKtVAod7Ad6hfFscsoU9F
         xnaQ==
X-Gm-Message-State: AOAM533Kw1fIVVy+Ri+0KBD/3MnWoHwWg28YYyU0XJpEvTvA8AK6Fna7
        7a3QqEQwTrRAvRz9oYowoph03Q==
X-Google-Smtp-Source: ABdhPJwaSt7ygFKX/J3ebl3olIlpP3LP3D2hL7qTQ60yEQJ6/9tWDOJXUk3Qj69t9zanX6XBWmbICQ==
X-Received: by 2002:a17:902:a60b:b029:df:ec2e:6a1d with SMTP id u11-20020a170902a60bb02900dfec2e6a1dmr7383555plq.27.1612434461599;
        Thu, 04 Feb 2021 02:27:41 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.131.71.236])
        by smtp.gmail.com with ESMTPSA id 199sm5400572pfc.112.2021.02.04.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 02:27:40 -0800 (PST)
Date:   Thu, 4 Feb 2021 18:27:34 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 8/8] perf arm-spe: Set thread TID
Message-ID: <20210204102734.GA4737@leoy-ThinkPad-X240s>
References: <20210119144658.793-1-james.clark@arm.com>
 <20210119144658.793-8-james.clark@arm.com>
 <20210131120156.GB230721@leoy-ThinkPad-X240s>
 <cb7c6deb-e4a1-95fa-b0d2-e4405f644e63@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb7c6deb-e4a1-95fa-b0d2-e4405f644e63@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Feb 01, 2021 at 07:40:45PM +0200, James Clark wrote:
> 
> On 31/01/2021 14:01, Leo Yan wrote:
> > Option 1: by merging patches 07/08 and 08/08, we can firstly support PID
> > tracing for root namespace, and later we can extend to support PID
> > tracing in container (and in VMs).
> > 
> > Option 2: we can use the software method to establish PID for SPE
> > trace, which can base on kernel's events PERF_RECORD_SWITCH /
> > PERF_RECORD_SWITCH_CPU_WIDE and check context switch ip.
> > 
> > To be honest, I am a bit concern for option 1 for later might
> > introduce regression when later support PID for containers (and VMs).
> > If you have a plan for option 1, I think it's good to record current
> > limitation and the plan for next step in the commit log, so we can merge
> > this patch at this time and later extend for containers.
> > 
> > Otherwise, we need to consider how to implement the PID tracing with
> > option 2.  If it is the case, we should firstly only merge patches
> > 01 ~ 06 for data source enabling.  How about you think for this?
> 
> In my opinion we should do option 1 and use what is there at the moment. That
> gets users 90% of the functionality right now.
> 
> I plan to look at option 2 at some point, and it can always be added on top of
> option 1 or replace what is there. But I don't know when I would get to it or
> how long it will take.

Firstly, sorry for long replying.

Have offline discussion with James and I took time to look into Intel PT
implementation for PID tracing.

AFAICT, for tracing root namespace, the option 1 with using CONTEXTIDR is
the most reliable way for Arm SPE; at beginning I thought option 2 is
better choice for Arm SPE, but after went through Intel PT's code, I think
Arm SPE cannot achieve the same result with Intel PT, this is caused by
its "statistical" character.

Let me explain why Arm SPE has problem with the option 2.  If we want to
enable option 2 by using perf context switch events and switch_ip
approach, it uses below logic:

  Step1: when event PERF_RECORD_SWITCH or PERF_RECORD_SWITCH_CPU_WIDE
  is coming, invokes below functions.  So it tells the "machine"
  context that the process is switched to new one; at this step, it
  simply caches the new PID/TID into the "machine" context.  But the
  samples doesn't really set the new value.

    intel_pt_context_switch()
      `> machine__set_current_tid()

  Step2: when detect the branch instruction's target address equals
  to the address of symbol "__switch_to", this means the the CPU
  really switches context to the next process in the low level code,
  afterwards it will retrieve the cached TID/PID from the "machine"
  context and set the correct PID for "ptq->pid" (see
  intel_pt_sample_set_pid_tid_cpu()), then "ptq->tid" is
  used for synthesizing samples.

Arm SPE has the problem for step2, due to the trace uses statistical
approach, it doesn't trace the complete branch instructions, so it
cannot promise to capture all branches for the symbol "__switch_to".
If we only use the events PERF_RECORD_SWITCH /
PERF_RECORD_SWITCH_CPU_WIDE, then it will lead to the coarse result
for PID tracing.

For this reason, seems to me it's pragmatic to use CONTEXTIDR for
PID tracing at current stage, at least it can allow the root domain
tracing works accurately.  But this will leave the issue for tracing
PID in non root namespace, we need to figure out solution later.

Hi Mark.R, Al, do you have any comments for this?

Thanks,
Leo

> >> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> > 
> > Besides for techinical question, you could add your "Co-developed-by"
> > tags for patches 06, 07, 08/08, which you have took time to refin them.
> > 
> > Thanks you for kindly efforts.
> > 
> > [1] https://lore.kernel.org/patchwork/patch/1353286/
> > 
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Cc: Jiri Olsa <jolsa@redhat.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> Cc: John Garry <john.garry@huawei.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Cc: Al Grant <al.grant@arm.com>
> >> Cc: Andre Przywara <andre.przywara@arm.com>
> >> Cc: Wei Li <liwei391@huawei.com>
> >> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
> >> Cc: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  tools/perf/util/arm-spe.c | 75 ++++++++++++++++++++++++++-------------
> >>  1 file changed, 50 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> >> index 27a0b9dfe22d..9828fad7e516 100644
> >> --- a/tools/perf/util/arm-spe.c
> >> +++ b/tools/perf/util/arm-spe.c
> >> @@ -223,6 +223,46 @@ static inline u8 arm_spe_cpumode(struct arm_spe *spe, u64 ip)
> >>  		PERF_RECORD_MISC_USER;
> >>  }
> >>  
> >> +static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
> >> +				    struct auxtrace_queue *queue)
> >> +{
> >> +	struct arm_spe_queue *speq = queue->priv;
> >> +	pid_t tid;
> >> +
> >> +	tid = machine__get_current_tid(spe->machine, speq->cpu);
> >> +	if (tid != -1) {
> >> +		speq->tid = tid;
> >> +		thread__zput(speq->thread);
> >> +	} else
> >> +		speq->tid = queue->tid;
> >> +
> >> +	if ((!speq->thread) && (speq->tid != -1)) {
> >> +		speq->thread = machine__find_thread(spe->machine, -1,
> >> +						    speq->tid);
> >> +	}
> >> +
> >> +	if (speq->thread) {
> >> +		speq->pid = speq->thread->pid_;
> >> +		if (queue->cpu == -1)
> >> +			speq->cpu = speq->thread->cpu;
> >> +	}
> >> +}
> >> +
> >> +static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
> >> +{
> >> +	int err;
> >> +	struct arm_spe *spe = speq->spe;
> >> +	struct auxtrace_queue *queue;
> >> +
> >> +	err = machine__set_current_tid(spe->machine, speq->cpu, tid, tid);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	queue = &speq->spe->queues.queue_array[speq->queue_nr];
> >> +	arm_spe_set_pid_tid_cpu(speq->spe, queue);
> >> +	return 0;
> >> +}
> >> +
> >>  static void arm_spe_prep_sample(struct arm_spe *spe,
> >>  				struct arm_spe_queue *speq,
> >>  				union perf_event *event,
> >> @@ -431,6 +471,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
> >>  static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
> >>  {
> >>  	struct arm_spe *spe = speq->spe;
> >> +	const struct arm_spe_record *record;
> >>  	int ret;
> >>  
> >>  	if (!spe->kernel_start)
> >> @@ -450,6 +491,11 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
> >>  		if (ret < 0)
> >>  			continue;
> >>  
> >> +		record = &speq->decoder->record;
> >> +		ret = arm_spe_set_tid(speq, record->context_id);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >>  		ret = arm_spe_sample(speq);
> >>  		if (ret)
> >>  			return ret;
> >> @@ -500,6 +546,10 @@ static int arm_spe__setup_queue(struct arm_spe *spe,
> >>  
> >>  		record = &speq->decoder->record;
> >>  
> >> +		ret = arm_spe_set_tid(speq, record->context_id);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >>  		speq->timestamp = record->timestamp;
> >>  		ret = auxtrace_heap__add(&spe->heap, queue_nr, speq->timestamp);
> >>  		if (ret)
> >> @@ -552,31 +602,6 @@ static bool arm_spe__is_timeless_decoding(struct arm_spe *spe)
> >>  	return timeless_decoding;
> >>  }
> >>  
> >> -static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
> >> -				    struct auxtrace_queue *queue)
> >> -{
> >> -	struct arm_spe_queue *speq = queue->priv;
> >> -	pid_t tid;
> >> -
> >> -	tid = machine__get_current_tid(spe->machine, speq->cpu);
> >> -	if (tid != -1) {
> >> -		speq->tid = tid;
> >> -		thread__zput(speq->thread);
> >> -	} else
> >> -		speq->tid = queue->tid;
> >> -
> >> -	if ((!speq->thread) && (speq->tid != -1)) {
> >> -		speq->thread = machine__find_thread(spe->machine, -1,
> >> -						    speq->tid);
> >> -	}
> >> -
> >> -	if (speq->thread) {
> >> -		speq->pid = speq->thread->pid_;
> >> -		if (queue->cpu == -1)
> >> -			speq->cpu = speq->thread->cpu;
> >> -	}
> >> -}
> >> -
> >>  static int arm_spe_process_queues(struct arm_spe *spe, u64 timestamp)
> >>  {
> >>  	unsigned int queue_nr;
> >> -- 
> >> 2.28.0
> >>

Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D54C433B4
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Apr 2021 12:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851E3611AC
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Apr 2021 12:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhDOMkZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhDOMkY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Apr 2021 08:40:24 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6D9C061756
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Apr 2021 05:40:00 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b26so10835553pfr.3
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Apr 2021 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qHBUjFRmsEeOYPlQQPLg6xTAMgdhf1Iy5nFWfOda9F8=;
        b=xdrPhpNmqth/Odu0CxkbvNliBLFVdumJ6LwaTZDxR492ERXvk2fSNpE5m7PuuAaDfe
         p//Z+yxMcIVE6RafsPFE9BWzDfkqD/x5unY5YV4U0H3knh66AYjfyaRXuGT/qRVZWxrR
         55TR0hyUUxqGb+b9ZWz+jpbHqrKwbSKBypFwenkxvmnhY2viwsXBfo33kvG8AF8bk4qq
         xdnLrImUyMHv593PuVdXK55ztOVZAfVhrfv2Df3pYgLZnL9y+5XYiRCX1mHkwp0xPfyN
         yFLqjo8iRoqUcQyo37qBM3WI4DQG8xHPgY4y+frKnKjCcZv51L+E1KngixT5fpVEKgi4
         XJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qHBUjFRmsEeOYPlQQPLg6xTAMgdhf1Iy5nFWfOda9F8=;
        b=DPQw8nk7Z9LZVZcis5t9zSsB0ytj64FWwyx1bOuGX2y7xj5OjZZ4cmcMGkM71Xxs4W
         tjz7d7oUxrnMro0ljdP8dmWfPBw0m76ifVLNvmVuMhF4NsXwLQNDh8jeJ3v5mRDOcMyQ
         suKEq4koQy/NPHxSGjkhqEBXXCr9VY1psdfZnqsrUrr9qIVpyAmXge5320pnrHodtGYM
         fg7j2scpkNeYXouIhZ9NbF5gbmcuyihTutdJ9WIesxz8+nfuAMFX+mXwYHMuBmpcJ7du
         3q/wFcFu2GhXCKwKgXevhrWwfGaEy4WGoN6XdnV7Adrh6wa/JGhYfuAenkE4sEeHwSNi
         697A==
X-Gm-Message-State: AOAM533M5hGvukZ4NliqtnUFe0zxl9yakp2kawo7/I+nsxsdNfIQ+1Vr
        2/D75cuXNqHYYQbOlMPvrVQ2KQ==
X-Google-Smtp-Source: ABdhPJxgbk0ONbpJokQpAAIPSGD0ZPu2o/+xcyjFE2CKce0EU5QlYvB0VRytYNdOFP6CmExBTV5qPA==
X-Received: by 2002:a62:1615:0:b029:243:fec5:6618 with SMTP id 21-20020a6216150000b0290243fec56618mr2991175pfw.35.1618490399390;
        Thu, 15 Apr 2021 05:39:59 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id z17sm2482812pjn.47.2021.04.15.05.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 05:39:58 -0700 (PDT)
Date:   Thu, 15 Apr 2021 20:39:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
Message-ID: <20210415123953.GB1011890@leoy-ThinkPad-X240s>
References: <20210414143919.12605-1-james.clark@arm.com>
 <20210414143919.12605-2-james.clark@arm.com>
 <06e1cc2e-1108-81cd-59e4-79277807b80c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06e1cc2e-1108-81cd-59e4-79277807b80c@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 14, 2021 at 05:41:46PM +0300, James Clark wrote:
> Hi,
> 
> For this change, I also tried removing the setting of PERF_SAMPLE_TIME in cs_etm__synth_events(). In theory, this would remove the sorting when opening the file, but the change doesn't affect when the built-in events are saved to the inject file. Resulting in events like MMAP and COMM with timestamps, but the synthesised events without. This results in the same issue of the synthesised events appearing before the COMM and MMAP events. If it was possible to somehow tell perf to remove timestamps from built-in events, removing PERF_SAMPLE_TIME would probably be the right solution, because we don't set sample.time.
> 
> For Arm v8.4 we will have the kernel time in the etm timestamps, so an if can be added to switch between this behaviour and the next (more correct) one depending on the hardware. 
> 
> On the subject of timestamps, but not related to this change, some combinations of timestamp options aren't working. For example:
> 
>     perf record -e cs_etm/time,@tmc_etr0/u --per-thread
> or  perf record -e cs_etm/@tmc_etr0/u --timestamp --per-thread
> 
> These don't work because of the assumption that etm->timeless_decoding == --per-thread
> and kernel timestamps enabled (/time/ or --timestamp) == etm timestamps enabled (/timestamp/), which isn't necessarily true.
> 
> This can be made to work with a few code changes for cs_etm/time,timestamp/u --per-thread, but cs_etm/time/u --per-thread could be a bit more work. Changes involved would be using "per_cpu_mmaps" in some places instead of etm->timeless_decoding, and also setting etm->timeless_decoding based on whether there are any etm timestamps, not kernel ones. Although to search for any etm timestamp would involve a full decode ahead of time which might not be feasible (or maybe just checking the options, although that's not how it's done in cs_etm__is_timeless_decoding() currently).

Confirm for one thing:

For the orignal perf data file with "--per-thread" option, the decoder
runs into the condition for "etm->timeless_decoding"; and it doesn't
contain ETM timestamp.

Afterwards, the injected perf data file also misses ETM timestamp and
hit the condition "etm->timeless_decoding".

So I am confusing why the original perf data can be processed properly
but fails to handle the injected perf data file.

Thanks,
Leo

> Or, we could force /time/ and /timestamp/ options to always be enabled together in the record stage. 
> 
> 
> Thanks
> James
> 
> On 14/04/2021 17:39, James Clark wrote:
> > The following attribute is set when synthesising samples in
> > timed decoding mode:
> > 
> >     attr.sample_type |= PERF_SAMPLE_TIME;
> > 
> > This results in new samples that appear to have timestamps but
> > because we don't assign any timestamps to the samples, when the
> > resulting inject file is opened again, the synthesised samples
> > will be on the wrong side of the MMAP or COMM events.
> > 
> > For example this results in the samples being associated with
> > the perf binary, rather than the target of the record:
> > 
> >     perf record -e cs_etm/@tmc_etr0/u top
> >     perf inject -i perf.data -o perf.inject --itrace=i100il
> >     perf report -i perf.inject
> > 
> > Where 'Command' == perf should show as 'top':
> > 
> >     # Overhead  Command  Source Shared Object  Source Symbol           Target Symbol           Basic Block Cycles
> >     # ........  .......  ....................  ......................  ......................  ..................
> >     #
> >         31.08%  perf     [unknown]             [.] 0x000000000040c3f8  [.] 0x000000000040c3e8  -
> > 
> > If the perf.data file is opened directly with perf, without the
> > inject step, then this already works correctly because the
> > events are synthesised after the COMM and MMAP events and
> > no second sorting happens. Re-sorting only happens when opening
> > the perf.inject file for the second time so timestamps are
> > needed.
> > 
> > Using the timestamp from the AUX record mirrors the current
> > behaviour when opening directly with perf, because the events
> > are generated on the call to cs_etm__process_queues().
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> > Co-developed-by: Al Grant <al.grant@arm.com>
> > Signed-off-by: Al Grant <al.grant@arm.com>
> > ---
> >  tools/perf/util/cs-etm.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index c25da2ffa8f3..d0fa9dce47f1 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -54,6 +54,7 @@ struct cs_etm_auxtrace {
> >  	u8 sample_instructions;
> >  
> >  	int num_cpu;
> > +	u64 latest_kernel_timestamp;
> >  	u32 auxtrace_type;
> >  	u64 branches_sample_type;
> >  	u64 branches_id;
> > @@ -1192,6 +1193,8 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
> >  	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
> >  	event->sample.header.size = sizeof(struct perf_event_header);
> >  
> > +	if (!etm->timeless_decoding)
> > +		sample.time = etm->latest_kernel_timestamp;
> >  	sample.ip = addr;
> >  	sample.pid = tidq->pid;
> >  	sample.tid = tidq->tid;
> > @@ -1248,6 +1251,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
> >  	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
> >  	event->sample.header.size = sizeof(struct perf_event_header);
> >  
> > +	if (!etm->timeless_decoding)
> > +		sample.time = etm->latest_kernel_timestamp;
> >  	sample.ip = ip;
> >  	sample.pid = tidq->pid;
> >  	sample.tid = tidq->tid;
> > @@ -2412,9 +2417,10 @@ static int cs_etm__process_event(struct perf_session *session,
> >  	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
> >  		return cs_etm__process_switch_cpu_wide(etm, event);
> >  
> > -	if (!etm->timeless_decoding &&
> > -	    event->header.type == PERF_RECORD_AUX)
> > +	if (!etm->timeless_decoding && event->header.type == PERF_RECORD_AUX) {
> > +		etm->latest_kernel_timestamp = sample_kernel_timestamp;
> >  		return cs_etm__process_queues(etm);
> > +	}
> >  
> >  	return 0;
> >  }
> > 

Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C63B1BD
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065799; cv=none; b=eKImh5aEOH4OFnGhtQp8Z2oYtLIi+7xhpy8sZZz6kGpFFVi7E8hITx2f9DTPl9/iCE0SAghMXXOIxh4yZnVJ3U/wrtZGZhB9eQcNJHLnWBFasNyr0oqyLQfR2EeaBTP69FAPi5p+t8BMRVMkJoPSNnULD5udkOA6OCObRFabzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065799; c=relaxed/simple;
	bh=XqbIykPgC0wsn7luA0GubxUiyYApOPY3tKLQ3OfihFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyNQBGKVBUCV6mVamQ6WwhTZNd6zEX13Aep/a2HL2vYc2fCm/FF4yyeVD8nhdIwe+Dxx+14NpPiYr/LQQLr61av51zYpnEsK0nyOmyuFK62w4DWT2mE3rTBpFHnBpi+tRHEyYFQ6FUQik9SRO1u90t2YGpTVbvF+RS2o25zwgUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Si3A/7Kp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Si3A/7Kp"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1712a04ddaso800305866b.2
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787065796; x=1787670596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Np9yEDd+Fd0yibinPh7hdB9+c/izEVyAROGDkoU/Abk=;
        b=Si3A/7KpBvxtjhjC5o20itkNcHONtT07Y5miL+ramkFVE3+Px4+9/BeNIk14KDWJXo
         cSh6XouS6Z/aJJXaywU6ke3gHabQVRjOb/Vk3lZG711MAKGHwhrO2/7e1duUVZ21iNJ+
         pZq9WHeBYrlt7gfrfdRFn+TgPOXFY4yVVwQeqJhJMZ91caPRqhJbX+WN4K8atWvfXD7V
         WPrR/ht5oUQs/sFpOXXrXXLKXSlc3xsP/9TlvPK3/GzJOEVHdW8OunxCAwDC2jJ1DEXP
         mjtvdkJSTlh7HttuByv7XPDVMjjwhhEqg0fMpOAV/VQ7ag8bSfSVuQnSDADvO7flSkqf
         8Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065796; x=1787670596;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Np9yEDd+Fd0yibinPh7hdB9+c/izEVyAROGDkoU/Abk=;
        b=dneGeajfVFayNfFgHfgUpthEPnUDgZMifqGInF716SFFe6XgSwCmAlDGMGZ7F0nAsj
         DgB4MQ6f6O8D35CoMwQuLMaFwGzYI0WiRPXXGg9LTDkGrf7tBHdaIVvqxqRzCc+4dsJM
         W1TUbx3wtV1T/1wQY35EBgpR1gaS9pIIGStCLmVRP53b6/jzFPG8pdFkw/Afi4Pg3VmC
         y3dwnA2PCSx6toDP+++LDkF592n+ZijIsGfuq9tH7LUCeoH6M32jxuLeExQiLfCVgHMo
         BCAJNrH5hl8pHk0etVSGn9ZrXdXIXHYHzCt1oGl9fvMsGzEYDtCHpbGr434Fu0SZ/S9G
         2xsQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1UZn8zSbSBadeCyGxvaw8aiDvW0AR3xuXHL/eU7fPy1CshUHq1oxoZ0L+dU5Zrfm0hiq1u92JA5n2v23DSRBx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5FvafiyJK9tc1zqrOHC0nq6GuQ1bh53Wfl+1d0QAEHayaD4hm
	HAJaP5YPz/DF/BTxq3y8jRjVhHwUrD8CAyFvkATm6whcYnMGPBz/3D4Ba9olH4BbcNk=
X-Gm-Gg: AR+sD10gYhGSWdKqZh10zoUV0Wl2XcPKnPbHYPvyGlENBFK89mjr4jdQn0BQCaQu4Pp
	RUY4VO0gvCN78CgGOw2+m7Qee6mspf9bVmGCEaDNCEqAJleGSBVJQzN/Hp55phxBQ6EiiPgjwJf
	b20P5lqKLniaQtpYdsgB/DWxmirDOBCI6W39Clb4MnsP/+GY3PyBDWDx40O7cTknzot9bTjRNNY
	+cTjVAPiXVZ9ehpC7hvTL75wTUfhQhv1Zcq/K4NUgwPlpMII94Abh0FIoO+XxV2bOWeoPGgHH7M
	ITuCqymJ+98I86c/XKW/cHVUO6vZzvedU3FdUqraXTceSrqTT6vBqpp/3dC2LtJapbskwkXDi08
	Ccvj6MWM7dvNw1KrbQKTnfTVCO7pS6lYIQYcZlZQbJG2iTz+mrgTymdB/DiHqvMYPOW/jFmDe+j
	PkIpVvgWUf1MjypUBJnUmy3GTYc4AQNgxcuyNUo9yk3c0UHMIbR8gJhGeppHIylxw35w==
X-Received: by 2002:a05:6938:a08d:20b0:c21:49df:1650 with SMTP id a640c23a62f3a-c2149df299fmr965482666b.8.1787065795586;
        Tue, 18 Aug 2026 08:09:55 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fea1e64sm211199866b.21.2026.08.18.08.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 08:09:55 -0700 (PDT)
Message-ID: <f40e4f98-d6eb-44d6-8229-0afdfcc0caf6@linaro.org>
Date: Tue, 18 Aug 2026 16:09:53 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] perf cs-etm: Add branch history to existing
 samples
To: Amir Ayupov <aaupov@fb.com>
Cc: linux-doc@vger.kernel.org, Mike Leach <mike.leach@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-perf-users@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>
References: <cover.1787005265.git.aaupov@fb.com>
 <454bc49f51eeef9f758fc2d2c7af75889d8aff46.1787005265.git.aaupov@fb.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <454bc49f51eeef9f758fc2d2c7af75889d8aff46.1787005265.git.aaupov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/08/2026 23:22, Amir Ayupov wrote:
> Implement --itrace=L for CoreSight ETM: decode timestamped trace up to
> each existing PMU sample and attach the branch history that led to it.
> The sample keeps its own ip, callchain and event identity, and a sample
> that already carries a branch stack is left alone.
> 
> Samples are correlated with the trace by time, so this requires virtual
> ETM timestamps that are correlated to perf time; timeless decoding is
> rejected. The decode loop, which the previous patch left on its own in
> cs_etm__process_timestamped_queues(), grows a timestamp argument and
> stops once the decode frontier reaches it, so on return the
> thread stack holds the branches that executed before the sample and none
> that executed after. Attaching then reduces to the same
> thread_stack__br_sample_late() call intel-pt uses.
> 
> No explicit sample-to-queue matching is needed:
> thread_stack__br_sample_late() keys on the thread, and the thread stack
> is already emptied whenever the decoder reports a discontinuity. The one
> case that was not covered is a queue whose trace runs out: flush the
> thread stack there too, otherwise samples recorded after the last trace
> would pick up stale history.
> 
> Take the branch history when attaching it rather than leaving it in the
> thread stack. With AUX pause and resume, a pause sample ends a completed
> trace window and that window belongs to the sample. Execution while AUX
> is paused is not traced, so retaining the window would let a later sample
> reuse branches from before the untraced gap. Consuming it ensures that a
> sample with no newly decoded trace gets an empty branch stack instead.
> 
> As with intel-pt, the internal reconstruction ring is kept deeper than
> the requested output depth to cover branches decoded between the sampled
> ip and the point at which the sample time was recorded, so --itrace=L<n>
> can actually return n entries. Kernel-inclusive trace gets the same
> conservative 1024-entry headroom that intel-pt uses.
> 
> Assisted-by: Devmate:GPT-5.6
> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> ---
>   tools/perf/util/cs-etm.c       | 185 +++++++++++++++++++++++++++++++--
>   tools/perf/util/thread-stack.c |  17 +++
>   tools/perf/util/thread-stack.h |   1 +
>   3 files changed, 195 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 4d895f11deb7f..00407a80933e1 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -72,6 +72,11 @@ struct cs_etm_auxtrace {
>   	bool use_callchain;
>   
>   	int num_cpu;
> +	/* Output depth requested with --itrace=L<n> */
> +	unsigned int br_stack_sz;
> +	/* Internal reconstruction depth, see cs_etm__br_stack_init() */
> +	unsigned int br_stack_sz_plus;> +	struct branch_stack *br_stack;
>   	u64 latest_kernel_timestamp;
>   	u32 auxtrace_type;
>   	u32 branches_filter;
> @@ -91,6 +96,7 @@ struct cs_etm_traceid_queue {
>   	u64 kernel_start;
>   	union perf_event *event_buf;
>   	unsigned int br_stack_sz;
> +	unsigned int br_stack_sz_plus;
>   	struct branch_stack *last_branch;
>   	struct ip_callchain *callchain;
>   	struct cs_etm_packet *prev_packet;
> @@ -141,7 +147,8 @@ struct cs_etm_queue {
>   };
>   
>   static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
> -static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
> +static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm,
> +					      u64 timestamp);
>   static int cs_etm__flush_timestamped_queues(struct cs_etm_auxtrace *etm);
>   static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
>   					   pid_t tid);
> @@ -165,6 +172,7 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
>   #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
>   #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
>   #define SINK_UNSET ((u32) -1)
> +#define MAX_TIMESTAMP (~0ULL)
>   
>   static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
>   {
> @@ -674,7 +682,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>   		if (!tidq->last_branch)
>   			goto out_free;
>   
> -		tidq->br_stack_sz = etm->synth_opts.last_branch_sz;
> +		tidq->br_stack_sz = etm->br_stack_sz;
> +		tidq->br_stack_sz_plus = etm->br_stack_sz_plus;
>   	}
>   
>   	if (etm->synth_opts.callchain) {
> @@ -794,7 +803,7 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>   	struct cs_etm_packet *tmp;
>   
>   	if (etm->synth_opts.branches || etm->synth_opts.last_branch ||
> -	    etm->synth_opts.instructions) {
> +	    etm->synth_opts.add_last_branch || etm->synth_opts.instructions) {
>   		/*
>   		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
>   		 * the next incoming packet.
> @@ -963,7 +972,7 @@ static int cs_etm__flush_events(struct perf_session *session,
>   	if (ret)
>   		return ret;
>   
> -	ret = cs_etm__process_timestamped_queues(etm);
> +	ret = cs_etm__process_timestamped_queues(etm, MAX_TIMESTAMP);
>   	if (ret)
>   		return ret;
>   
> @@ -1060,6 +1069,7 @@ static void cs_etm__free(struct perf_session *session)
>   		zfree(&aux->metadata[i]);
>   
>   	zfree(&aux->metadata);
> +	zfree(&aux->br_stack);
>   	zfree(&aux);
>   }
>   
> @@ -1597,7 +1607,8 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
>   	u64 from, to;
>   	int size;
>   
> -	if (!etm->synth_opts.branches && !etm->synth_opts.instructions)
> +	if (!etm->synth_opts.branches && !etm->synth_opts.instructions &&
> +	    !etm->synth_opts.add_last_branch)
>   		return;
>   
>   	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet))
> @@ -1614,7 +1625,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
>   				    tidq->prev_packet->flags, from, to, size,
>   				    etmq->buffer->buffer_nr + 1,
>   				    etmq->etm->use_callchain,
> -				    tidq->br_stack_sz, 0);
> +				    tidq->br_stack_sz_plus, 0);
>   	} else {
>   		thread_stack__set_trace_nr(tidq->frontend_thread,
>   					   tidq->prev_packet->cpu,
> @@ -2817,7 +2828,8 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
>   	return ret;
>   }
>   
> -static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
> +static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm,
> +					      u64 timestamp)
>   {
>   	int ret = 0;
>   	unsigned int cs_queue_nr, queue_nr;
> @@ -2831,6 +2843,9 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
>   		if (!etm->heap.heap_cnt)
>   			break;
>   
> +		if (etm->heap.heap_array[0].ordinal >= timestamp)
> +			break;
> +
>   		/* Take the entry at the top of the min heap */
>   		cs_queue_nr = etm->heap.heap_array[0].queue_nr;
>   		queue_nr = TO_QUEUE_NR(cs_queue_nr);
> @@ -2878,8 +2893,25 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
>   		 * No more auxtrace_buffers to process in this etmq, simply
>   		 * move on to another entry in the auxtrace_heap.
>   		 */
> -		if (!ret)
> +		if (!ret) {
> +			/*
> +			 * The trace for this physical queue is exhausted. Drop
> +			 * branch history for every trace ID it carried so that
> +			 * samples arriving later cannot pick up entries decoded
> +			 * before the gap.
> +			 */
> +			if (etm->synth_opts.add_last_branch) {
> +				struct int_node *inode;
> +
> +				intlist__for_each_entry(inode, etmq->traceid_queues_list) {
> +					int idx = (int)(intptr_t)inode->priv;
> +
> +					tidq = etmq->traceid_queues[idx];
> +					thread_stack__flush(tidq->frontend_thread);
> +				}
> +			}
>   			continue;
> +		}
>   
>   		ret = cs_etm__decode_data_block(etmq);
>   		if (ret)
> @@ -3011,6 +3043,116 @@ static int cs_etm__process_switch_cpu_wide(struct cs_etm_auxtrace *etm,
>   	return 0;
>   }
>   
> +static bool cs_etm__tracing_kernel(struct cs_etm_auxtrace *etm,
> +				   struct perf_session *session)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(session->evlist, evsel) {
> +		if (evsel->core.attr.type == etm->pmu_type &&
> +		    !evsel->core.attr.exclude_kernel)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int cs_etm__br_stack_init(struct cs_etm_auxtrace *etm,
> +				 struct perf_session *session)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(session->evlist, evsel) {
> +		/*
> +		 * Only timestamped events can be matched against the decoded
> +		 * trace, so do not advertise a branch stack on any other.
> +		 */
> +		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
> +			continue;

Do you not also want to check for the coresight virtual timestamp option 
here for the same reason? Although I do see that checked somewhere else 
below.

> +		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK))
> +			evsel->synth_sample_type |= PERF_SAMPLE_BRANCH_STACK;
> +	}
> +
> +	/*
> +	 * Additional branch stack depth to cater for the branches decoded
> +	 * between the sampled ip and the point at which the sample time was
> +	 * recorded. Those are trimmed by thread_stack__br_sample_late(), so

How does the trimmer know what branches came after an IP? I could 
understand trimming between two timestamps, but not between one IP and 
one timestamp.

> +	 * the extra depth keeps the requested output depth achievable. If
> +	 * kernel space is not traced, only the branch into the kernel needs
> +	 * to be accounted for.
> +	 */

I'm not sure if this description is missing something, but I can't 
understand why this needs to be done. Or how kernel tracing affects it.

> +	if (cs_etm__tracing_kernel(etm, session))
> +		etm->br_stack_sz_plus += 1024;
> +	else
> +		etm->br_stack_sz_plus += 1;
> +
> +	etm->br_stack = zalloc(sizeof(struct branch_stack) +
> +			       etm->br_stack_sz * sizeof(struct branch_entry));
> +	if (!etm->br_stack)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/*
> + * Add decoded branch history to an existing sample. The sample keeps its own
> + * ip, callchain and event identity; only an absent branch stack is filled in.
> + */
> +static int cs_etm__process_sample(struct cs_etm_auxtrace *etm,
> +				  struct perf_session *session,
> +				  struct perf_sample *sample)
> +{
> +	struct machine *machine = &session->machines.host;
> +	struct thread *thread;
> +	int err;
> +
> +	if (!etm->synth_opts.add_last_branch || sample->branch_stack ||
> +	    !sample->ip || !sample->time || sample->time == (u64)-1)
> +		return 0;
> +
> +	/* Adding branch history to existing samples supports the host only */
> +	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
> +	    sample->cpumode == PERF_RECORD_MISC_GUEST_USER)
> +		return 0;
> +
> +	err = cs_etm__update_queues(etm);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Decode every queue up to this sample's time. Afterwards the thread
> +	 * stack holds the branches that executed before the sample, and
> +	 * nothing that executed after it.
> +	 */
> +	err = cs_etm__process_timestamped_queues(etm, sample->time);
> +	if (err)
> +		return err;
> +
> +	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
> +	if (!thread)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Take the branch history rather than copying it. The trace window
> +	 * belongs to the sample that ends it, so once it has been attached a
> +	 * later sample with nothing newly decoded finds an empty stack rather
> +	 * than being given an earlier window's branches. That is the common
> +	 * case whenever the trace is duty cycled, by AUX pause/resume or by
> +	 * ETM strobing.
> +	 */
> +	thread_stack__br_sample_late(thread, sample->cpu, etm->br_stack,
> +				     etm->br_stack_sz, sample->ip,
> +				     machine__kernel_start(machine));
> +	thread_stack__br_stack_consume(thread, sample->cpu);
> +
> +	if (etm->br_stack->nr)
> +		sample->branch_stack = etm->br_stack;

How does this work? We have a queue for each CPU, and decoding happens 
in parallel (kind of), but when a Perf sample arrives we just attach the 
stack from the global br_stack? Shouldn't we look at the CPU of the 
sample and use cs_etm__get_queue() to get the right queue and branch stack?

Maybe it's not functionally different if br_stack always happens to be 
set from the queue related to the last Perf sample, but it would be 
nicer to not have to assume.

You might want to check "[PATCH 00/14] perf cs-etm: Per-thread mode 
fixes and snapshot wrap support" because it changes to a per-CPU queue 
even for per-thread mode which could help.

> +
> +	thread__put(thread);
> +
> +	return 0;
> +}
> +
>   static int cs_etm__process_event(struct perf_session *session,
>   				 union perf_event *event,
>   				 struct perf_sample *sample,
> @@ -3049,6 +3191,9 @@ static int cs_etm__process_event(struct perf_session *session,
>   	case PERF_RECORD_SWITCH_CPU_WIDE:
>   		return cs_etm__process_switch_cpu_wide(etm, event);
>   
> +	case PERF_RECORD_SAMPLE:
> +		return cs_etm__process_sample(etm, session, sample);
> +

Don't we want to generalise this and process trace up to the timestamp 
of _any_ event. Can we move the cs_etm__process_timestamped_queues() 
call into cs_etm__process_event().

Surely we want to always decode up to any event if coresight virtual 
timestamps are enabled? That way we access the right mmaps too and the 
decode order doesn't change depending on the branch stack options.

>   	case PERF_RECORD_AUX:
>   		/*
>   		 * Record the latest kernel timestamp available in the header
> @@ -3752,11 +3897,34 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>   
>   	etm->use_thread_stack = etm->synth_opts.thread_stack ||
>   				etm->synth_opts.last_branch ||
> +				etm->synth_opts.add_last_branch ||
>   				etm->synth_opts.callchain;
>   
>   	etm->use_callchain = etm->synth_opts.thread_stack ||
>   			     etm->synth_opts.callchain;
>   
> +	if (etm->synth_opts.last_branch || etm->synth_opts.add_last_branch) {
> +		etm->br_stack_sz = etm->synth_opts.last_branch_sz;
> +		etm->br_stack_sz_plus = etm->br_stack_sz;
> +	}
> +
> +	if (etm->synth_opts.add_last_branch) {
> +		/*
> +		 * Existing samples are matched to decoded trace by time, so
> +		 * the trace must carry timestamps that are correlated to perf
> +		 * time and the queues must be decoded in time order.
> +		 */
> +		if (etm->timeless_decoding || !etm->has_virtual_ts) {
> +			pr_err("CS ETM Trace: --itrace=L requires virtual timestamped trace\n");
> +			err = -EINVAL;
> +			goto err_free_queues;
> +		}
> +
> +		err = cs_etm__br_stack_init(etm, session);
> +		if (err)
> +			goto err_free_queues;
> +	}
> +
>   	err = cs_etm__synth_events(etm, session);
>   	if (err)
>   		goto err_free_queues;
> @@ -3812,6 +3980,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>   	auxtrace_queues__free(&etm->queues);
>   	session->auxtrace = NULL;
>   err_free_etm:
> +	zfree(&etm->br_stack);
>   	zfree(&etm);
>   err_free_metadata:
>   	/* No need to check @metadata[j], free(NULL) is supported */
> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> index 1360f44421ef8..2713a2ad70b69 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -614,6 +614,23 @@ void thread_stack__sample_late(struct thread *thread, int cpu,
>   	}
>   }
>   
> +/*
> + * Branch history belongs to the sample that ends the trace window, so a
> + * decoder that attaches it to an existing sample should take it rather than
> + * copy it. A later sample with no newly decoded trace then finds an empty
> + * branch stack instead of the previous window's branches.
> + */
> +void thread_stack__br_stack_consume(struct thread *thread, int cpu)
> +{
> +	struct thread_stack *ts = thread__stack(thread, cpu);
> +
> +	if (!ts || !ts->br_stack_rb)
> +		return;
> +
> +	ts->br_stack_pos = 0;
> +	ts->br_stack_rb->nr = 0;
> +}
> +
>   void thread_stack__br_sample(struct thread *thread, int cpu,
>   			     struct branch_stack *dst, unsigned int sz)
>   {
> diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
> index b3cd09beb62f0..2aec292bd1bcb 100644
> --- a/tools/perf/util/thread-stack.h
> +++ b/tools/perf/util/thread-stack.h
> @@ -88,6 +88,7 @@ void thread_stack__sample(struct thread *thread, int cpu, struct ip_callchain *c
>   void thread_stack__sample_late(struct thread *thread, int cpu,
>   			       struct ip_callchain *chain, size_t sz, u64 ip,
>   			       u64 kernel_start);
> +void thread_stack__br_stack_consume(struct thread *thread, int cpu);
>   void thread_stack__br_sample(struct thread *thread, int cpu,
>   			     struct branch_stack *dst, unsigned int sz);
>   void thread_stack__br_sample_late(struct thread *thread, int cpu,


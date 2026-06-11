Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3691F309EE2
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168499; cv=none; b=bnrgIOZN4ygTjFh8XcypPLeylRtYk0e2JPNKKtAtZw7UAM1PJTf5RKiYR71Fq1yNvYzMWPQfex0A0LO0nlQpbmLfGxqqMvCvjRRZiZ0X3yPXogveTUIDqy6iuvE/hI0pbYPwFQGXwT+G5KZBh/enPiOb1vWgLCRibcQlAc3HCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168499; c=relaxed/simple;
	bh=s7jR6iMmWhlqK78Tp/5a6ci8NkEtexNKxWV3FzW+eNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDE/2ILruKbR6drknM9RN4QDa/MFpECzeFL/vY2lS/Xp/WzFFZV7nHCL1IQEFoaG65PNchFbOvwNBomBZxiaAU5odGp4ETUTFV/tisjKOOPPoDB+X3OC8+8RjhvTbs7ZEKPin+PeVSwsqJCyyIFACdHtLvcfBR8c5Z2kB57OCKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KAuaQEKN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAuaQEKN"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68d232e119dso12383527a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 02:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781168495; x=1781773295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x4jYOI1ytBaH/KvrNBwszKXOejxemu3+HMwBrWYzf4Q=;
        b=KAuaQEKNGQBJylWnRCR8vZJ4iY/DXxUMqIWiJO/NE0CobQ1obV+WS+jqND9F3a5EB0
         dB5owBsTrjlAUnAt9fORExxBfEUYrvsdtP/gZSlg+srSZxx8D7A/R46zjUElzlO9duFw
         Qb6qw37pBAgeDOwv+7vOpVlz6G80NXz7wD3lVCImmACepBzrqt3aXv18/dV69uImWYem
         w70H/0cXaSBaDJlcvhSdwWya9Spso6SFe3suuAqfJS8XPCskoW2oOlOpJEwQvFRO+M6O
         FkVw7mXu3t+3d7h8hMkn4EtrJVG9AfHVnEwYkqgSyr2W8zHzzotjQjjgJBTzd2Grl2Nc
         D60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168495; x=1781773295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4jYOI1ytBaH/KvrNBwszKXOejxemu3+HMwBrWYzf4Q=;
        b=T56E2LAKhI8d1faZ0yuYWqP6EYmuLgSqma0eP5HRm0KriXrRRAJR1Z+dGyJ0WNR9zY
         CKVBvwVbZUyMywlyEel+1mwrun7FrlMzkqG4ZMAck/Aw6R4LJZseKhWzqyFsaEtcM5s6
         CwOC4yLi8UIXFsDaPbzNvDRTXxndTANRJIg2xPWyR4ydZR3WYjlJMWCKwDcGKvm7wUNa
         8DLCEE846BLAq0wNgBxZifZZPBoBafThGIvrX8/95UFAj8kFF9rdnw8bzLiFeyMYx57z
         Qpf2RzGEMLcz4NZWTlkGjbazmh07i9tc2K2/uBfoZZeocBQZOHwYqoprKsdKhhoUC/+R
         3/7g==
X-Forwarded-Encrypted: i=1; AFNElJ9HlQ3dgSs8zgh8KYVkAkvFxH6OpI5e8YpZOKt5VSdmi3+v53HBPZAvAvWeZ99Kc8VFUP3piZf2ZP7HA4lsuO4s@vger.kernel.org
X-Gm-Message-State: AOJu0YxHS1VbrpZZn3NcSGpwsRH2bFzRQCNZEqq/1paZ7zmCFN+sckoz
	59JKwBWz6WGIhJGluSH7Y6v0tO06aStmz+PMXHol2zNSasFmZyM6zRqNqVgyqK1Vyao=
X-Gm-Gg: Acq92OEbZT5wwtTKpKzZvFk6MkeTQj4KJ20meJ6L9v2Mzm+ITLJs9K+Ip9ObFCHyYtR
	a5alq3g3sIS/g/NNgoMKc38lTqQiFy1FDKhQAFAEfKPCkI0160FNyodOjAxF0RJj60VRvnJ4www
	uiF7/yiUC7dHCQL0d1zpisjWygcfq/9smuc+YEfWric2iiT1u/FjgAfjA3KnsXAy1Y/HJHkenmb
	lAXCunVDrwdayerr0ATIr2Cby0tQb3IIMQhCBdMZShD8pFn+Lt1UNY4Pd3naBbVLQgMwAxZqDIz
	UXKDnaED1/Wvx0tDoS65ZJ2GTRoEKckZrnicrjED5PcZwL768AdFPcLGRfrxMc0xXuTOte045vd
	KFSGnQ2fKOtp2sqEale04CpZYw9fnGlrDI/3Z2VOlUpPqKRN/P4elMhn6jK8BEqXY1D4IPx1YCl
	A5SzBaAiITI+IGWMFc9vzl+81gYUs5JbFZEgETix4=
X-Received: by 2002:a05:6402:913:b0:662:ac7e:aac9 with SMTP id 4fb4d7f45d1cf-6930e2d0326mr857408a12.20.1781168495474;
        Thu, 11 Jun 2026 02:01:35 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65b4d988sm10647298a12.25.2026.06.11.02.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 02:01:35 -0700 (PDT)
Message-ID: <896279e2-eded-4388-afb9-0a633404928b@linaro.org>
Date: Thu, 11 Jun 2026 10:01:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/8] perf cs-etm: Use thread-stack for last branch
 entries
To: Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>,
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v7-0-1ba770c862ae@arm.com>
 <20260611-b4-arm_cs_callchain_support_v1-v7-4-1ba770c862ae@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v7-4-1ba770c862ae@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/06/2026 8:56 am, Leo Yan wrote:
> CS ETM maintains its own circular array for last branch entries, with
> local helpers to update, copy and reset the branch stack. This
> duplicates logic already provided by the common code.
> 
> Record taken branches with thread_stack__event() and synthesize
> PERF_SAMPLE_BRANCH_STACK data with thread_stack__br_sample(). This
> removes the private last_branch_rb buffer and its position tracking.
> 
> This also makes the branch history state belong to the thread rather
> than the trace queue. That is a better fit for CoreSight traces where
> a trace queue can effectively be CPU scoped, while call/return history
> is per thread.
> 
> Keep the buffer number updated via thread_stack__set_trace_nr(), which
> is used when exporting samples to Python scripts. Pass callstack=false
> for now; synthesized callchains are added by a later patch.
> 
> The output should remain same, except that be->flags.predicted is no
> longer set. Since CoreSight trace does not provide branch prediction
> information, clearing the flag avoids confusion.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>


Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/util/cs-etm.c | 159 ++++++++++++++---------------------------------
>   1 file changed, 46 insertions(+), 113 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 4127120459418389ca7aabb9a49dead2b50e7533..8798bf0471faf3b1813780b45c588263ff6b4416 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -84,10 +84,9 @@ struct cs_etm_auxtrace {
>   struct cs_etm_traceid_queue {
>   	u8 trace_chan_id;
>   	u64 period_instructions;
> -	size_t last_branch_pos;
>   	union perf_event *event_buf;
> +	unsigned int br_stack_sz;
>   	struct branch_stack *last_branch;
> -	struct branch_stack *last_branch_rb;
>   	struct cs_etm_packet *prev_packet;
>   	struct cs_etm_packet *packet;
>   	struct cs_etm_packet_queue packet_queue;
> @@ -644,9 +643,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>   		tidq->last_branch = zalloc(sz);
>   		if (!tidq->last_branch)
>   			goto out_free;
> -		tidq->last_branch_rb = zalloc(sz);
> -		if (!tidq->last_branch_rb)
> -			goto out_free;
> +
> +		tidq->br_stack_sz = etm->synth_opts.last_branch_sz;
>   	}
>   
>   	tidq->event_buf = malloc(PERF_SAMPLE_MAX_SIZE);
> @@ -656,7 +654,6 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>   	return 0;
>   
>   out_free:
> -	zfree(&tidq->last_branch_rb);
>   	zfree(&tidq->last_branch);
>   	zfree(&tidq->prev_packet);
>   	zfree(&tidq->packet);
> @@ -939,7 +936,6 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
>   		thread__zput(tidq->decode_thread);
>   		zfree(&tidq->event_buf);
>   		zfree(&tidq->last_branch);
> -		zfree(&tidq->last_branch_rb);
>   		zfree(&tidq->prev_packet);
>   		zfree(&tidq->packet);
>   		zfree(&tidq);
> @@ -1299,57 +1295,6 @@ static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
>   	return ret;
>   }
>   
> -static inline
> -void cs_etm__copy_last_branch_rb(struct cs_etm_queue *etmq,
> -				 struct cs_etm_traceid_queue *tidq)
> -{
> -	struct branch_stack *bs_src = tidq->last_branch_rb;
> -	struct branch_stack *bs_dst = tidq->last_branch;
> -	size_t nr = 0;
> -
> -	/*
> -	 * Set the number of records before early exit: ->nr is used to
> -	 * determine how many branches to copy from ->entries.
> -	 */
> -	bs_dst->nr = bs_src->nr;
> -
> -	/*
> -	 * Early exit when there is nothing to copy.
> -	 */
> -	if (!bs_src->nr)
> -		return;
> -
> -	/*
> -	 * As bs_src->entries is a circular buffer, we need to copy from it in
> -	 * two steps.  First, copy the branches from the most recently inserted
> -	 * branch ->last_branch_pos until the end of bs_src->entries buffer.
> -	 */
> -	nr = etmq->etm->synth_opts.last_branch_sz - tidq->last_branch_pos;
> -	memcpy(&bs_dst->entries[0],
> -	       &bs_src->entries[tidq->last_branch_pos],
> -	       sizeof(struct branch_entry) * nr);
> -
> -	/*
> -	 * If we wrapped around at least once, the branches from the beginning
> -	 * of the bs_src->entries buffer and until the ->last_branch_pos element
> -	 * are older valid branches: copy them over.  The total number of
> -	 * branches copied over will be equal to the number of branches asked by
> -	 * the user in last_branch_sz.
> -	 */
> -	if (bs_src->nr >= etmq->etm->synth_opts.last_branch_sz) {
> -		memcpy(&bs_dst->entries[nr],
> -		       &bs_src->entries[0],
> -		       sizeof(struct branch_entry) * tidq->last_branch_pos);
> -	}
> -}
> -
> -static inline
> -void cs_etm__reset_last_branch_rb(struct cs_etm_traceid_queue *tidq)
> -{
> -	tidq->last_branch_pos = 0;
> -	tidq->last_branch_rb->nr = 0;
> -}
> -
>   static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
>   					 struct cs_etm_traceid_queue *tidq,
>   					 struct cs_etm_packet *packet, u64 addr)
> @@ -1419,38 +1364,6 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
>   	return addr;
>   }
>   
> -static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
> -					  struct cs_etm_traceid_queue *tidq)
> -{
> -	struct branch_stack *bs = tidq->last_branch_rb;
> -	struct branch_entry *be;
> -
> -	/*
> -	 * The branches are recorded in a circular buffer in reverse
> -	 * chronological order: we start recording from the last element of the
> -	 * buffer down.  After writing the first element of the stack, move the
> -	 * insert position back to the end of the buffer.
> -	 */
> -	if (!tidq->last_branch_pos)
> -		tidq->last_branch_pos = etmq->etm->synth_opts.last_branch_sz;
> -
> -	tidq->last_branch_pos -= 1;
> -
> -	be       = &bs->entries[tidq->last_branch_pos];
> -	be->from = cs_etm__last_executed_instr(tidq->prev_packet);
> -	be->to	 = cs_etm__first_executed_instr(tidq->packet);
> -	/* No support for mispredict */
> -	be->flags.mispred = 0;
> -	be->flags.predicted = 1;
> -
> -	/*
> -	 * Increment bs->nr until reaching the number of last branches asked by
> -	 * the user on the command line.
> -	 */
> -	if (bs->nr < etmq->etm->synth_opts.last_branch_sz)
> -		bs->nr += 1;
> -}
> -
>   static int cs_etm__inject_event(struct cs_etm_auxtrace *etm, union perf_event *event,
>   			       struct perf_sample *sample, u64 type)
>   {
> @@ -1614,6 +1527,42 @@ static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
>   		return etm->latest_kernel_timestamp;
>   }
>   
> +static bool cs_etm__packet_has_taken_branch(struct cs_etm_packet *packet)
> +{
> +	if (packet->sample_type == CS_ETM_RANGE &&
> +	    packet->last_instr_taken_branch)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
> +				    struct cs_etm_traceid_queue *tidq)
> +{
> +	u64 from, to;
> +	int size;
> +
> +	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet))
> +		return;
> +
> +	if (etmq->etm->synth_opts.last_branch) {
> +		from = cs_etm__last_executed_instr(tidq->prev_packet);
> +		to = cs_etm__first_executed_instr(tidq->packet);
> +
> +		size = cs_etm__instr_size(etmq, tidq, tidq->prev_packet, from);
> +
> +		/* Enable callchain so thread stack entry can be allocated */
> +		thread_stack__event(tidq->frontend_thread, tidq->prev_packet->cpu,
> +				    tidq->prev_packet->flags, from, to, size,
> +				    etmq->buffer->buffer_nr + 1, false,
> +				    tidq->br_stack_sz, 0);
> +	} else {
> +		thread_stack__set_trace_nr(tidq->frontend_thread,
> +					   tidq->prev_packet->cpu,
> +					   etmq->buffer->buffer_nr + 1);
> +	}
> +}
> +
>   static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>   					    struct cs_etm_traceid_queue *tidq,
>   					    struct cs_etm_packet *packet,
> @@ -1644,8 +1593,11 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>   
>   	cs_etm__copy_insn(etmq, tidq, packet, &sample);
>   
> -	if (etm->synth_opts.last_branch)
> +	if (etm->synth_opts.last_branch) {
> +		thread_stack__br_sample(tidq->frontend_thread, tidq->packet->cpu,
> +					tidq->last_branch, tidq->br_stack_sz);
>   		sample.branch_stack = tidq->last_branch;
> +	}
>   
>   	if (etm->synth_opts.inject) {
>   		ret = cs_etm__inject_event(etm, event, &sample,
> @@ -1836,14 +1788,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>   
>   	tidq->period_instructions += tidq->packet->instr_count;
>   
> -	/*
> -	 * Record a branch when the last instruction in
> -	 * PREV_PACKET is a branch.
> -	 */
> -	if (etm->synth_opts.last_branch &&
> -	    tidq->prev_packet->sample_type == CS_ETM_RANGE &&
> -	    tidq->prev_packet->last_instr_taken_branch)
> -		cs_etm__update_last_branch_rb(etmq, tidq);
> +	cs_etm__add_stack_event(etmq, tidq);
>   
>   	if (etm->synth_opts.instructions &&
>   	    tidq->period_instructions >= etm->instructions_sample_period) {
> @@ -1902,10 +1847,6 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>   		u64 offset = etm->instructions_sample_period - instrs_prev;
>   		u64 addr;
>   
> -		/* Prepare last branches for instruction sample */
> -		if (etm->synth_opts.last_branch)
> -			cs_etm__copy_last_branch_rb(etmq, tidq);
> -
>   		while (tidq->period_instructions >=
>   				etm->instructions_sample_period) {
>   			/*
> @@ -1936,8 +1877,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>   			generate_sample = true;
>   
>   		/* Generate sample for branch taken packet */
> -		if (tidq->prev_packet->sample_type == CS_ETM_RANGE &&
> -		    tidq->prev_packet->last_instr_taken_branch)
> +		if (cs_etm__packet_has_taken_branch(tidq->prev_packet))
>   			generate_sample = true;
>   
>   		if (generate_sample) {
> @@ -1985,10 +1925,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>   	    etmq->etm->synth_opts.instructions &&
>   	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
>   		u64 addr;
> -
> -		/* Prepare last branches for instruction sample */
> -		cs_etm__copy_last_branch_rb(etmq, tidq);
> -
>   		/*
>   		 * Generate a last branch event for the branches left in the
>   		 * circular buffer at the end of the trace.
> @@ -2020,7 +1956,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>   
>   	/* Reset last branches after flush the trace */
>   	if (etm->synth_opts.last_branch)
> -		cs_etm__reset_last_branch_rb(tidq);
> +		thread_stack__flush(tidq->frontend_thread);
>   
>   	return err;
>   }
> @@ -2044,9 +1980,6 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
>   	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
>   		u64 addr;
>   
> -		/* Prepare last branches for instruction sample */
> -		cs_etm__copy_last_branch_rb(etmq, tidq);
> -
>   		/*
>   		 * Use the address of the end of the last reported execution
>   		 * range.
> 


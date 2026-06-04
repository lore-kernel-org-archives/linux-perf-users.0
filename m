Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF5472772
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582171; cv=none; b=fUy14/u5d3A5xtG2+FjqE6Ec6kTCkvZS2N2l0voutJQh65i4BUROXolV2kcEUP3Thb0AFq1GCmhb1iQj3CaqzCf605wJfgAhVSiahMjX8+TM03okotaeoxZpAPGmE0f7k31YW98e5BXqfy6tN/52GMcQsA9NxkHwg3q+5GP2Z/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582171; c=relaxed/simple;
	bh=jce8qCy7PaTEi1g3Pg3p3RD4Uf43nSfsgmSFixccB+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxBtSVjYZmL8zt0O5cE8LSRP27Ug3ngrysO+n1Pow8z/7HXkwbUrbaSaCzKgtDSo3CMZo5xKuUkVva0GdOgzZ0GeR2WnQthpNpEFgAtKNB3CbjPV1rMEXBXA2D41GOGX/YIVbWAF2U2Yp8F7uhrzMw4ZDaVCsmhQUu/cd3QXwTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wL3QQwrs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wL3QQwrs"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bec423a5265so117101766b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 07:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780582168; x=1781186968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7H62lkepc/bbz/eunS89UDg8NP+iYX29m8Vp+gdTFV8=;
        b=wL3QQwrssj025OphND8RGUz52Km8VF1S0yC8ohOrc3twCsoA9WRRVA12Uc4lt6app8
         tCvRBMkvQPq45/Vd3RgNdW20MnGu7nq5icT/fdMereNZ4UdVMMu93awrzy6/av4sDvSp
         k6YeB8DfpQ+pplGcAxlHr7IWhQAPHOAe4eQGujLfA2WgDsZ5CaNjmUDdHGy3023miQXv
         7sFsiwqdnoh/gHbn3Wr4YElXxIHuY8CYf/udHte9NrUZ9FHeufFXdjhwyRoRxIXVqzh+
         neFuBUyHnpzesZ0ZFFtuQoSpuCkiZbQcVxL1z6Gzlale96UkNPthqo7zEl2jWqRnPAV4
         hcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582168; x=1781186968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7H62lkepc/bbz/eunS89UDg8NP+iYX29m8Vp+gdTFV8=;
        b=i/HFq1S/e7wCUn1RHR/ZWxbHsieGZAe3UaXda6f0C6IwEqA+x/Vc5fSyQPH+ccT3GU
         ltgEwqMFZtkrVvxbATNMCUadWsQdrkvqKzeJBVlwyGWbvD7Ds8vzoAt5zK1yCvZzBpEt
         xZS5ZPFUlgIMJqnfIeHsWCnKxg/76b6pwnuuxHRD1+noyisok4drGfcBsMo0+fHDT+DN
         +/LHusbuaNqA/m77WBO2g/5UysvfxelOd5QVlF/n/GsbOTKSRgUsdKlnWxtLVfNxNED5
         GeW+DCx1KuEpyOqY7Hspt5qqzkLDdrCeauKC5V0FyzoEdl9xmdFgjNc14ieyF7jlObZP
         kQtA==
X-Forwarded-Encrypted: i=1; AFNElJ8FwrykIze2opwQVthUcvrPRVvzGrlP7Y2uSqmyj1hEC496hJuwBSc43t2Po8YYTdWTmGNVsJMmbz1Qa6DESmZs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd8VznBjM2pUwVz7MP55NzuWakQrpnwXpFaIITfCJVjsL21SGJ
	2QSIsfNBbPXh1BEkXL/GFlBgSlYhVsJ9jpKYhG6SB1xJyMUZ2whjlDAzHj9fqmu7w3A=
X-Gm-Gg: Acq92OGdmshurSflvi1YSaU7Fro+5B498sfFBnsdnqHRngO+5qjC2fZK9K/jbmfD5IN
	C0bGWaYRpHcu8j33nxFmgA7QOAr/zOMwau+OD/B6APokQyLBXlTiZJz4c+q20L0kiRUuaM12pxq
	7vdZ1rFku22MJ5gz9AcWSpEE8bWTzS0vprr3wU91U48+WO6R1bfL76Us875VSBcCRSeIuYro/MU
	5ktabbe0a4EvDmLfi61zgtppKxGcs76n+LGhKUAn4+jfPKyLgdHXXIVJwMkOod3bOj3WRieZ/ER
	No2MayBMnW2AXK7J7vp4WqU0A9F3+4B1LcRn6xRbqohFB8+OGAT5XzcyurNbv7PWdS5WcWUweo4
	JwseZFlwEAit8IlzEhdSGC9GDjowJqLTXh3ci+R9uXnrwnb5DQZtMG3MmvTQvjmtaCgrbnmr5JZ
	O0eHsEwrW3GyHtEhUWq2/VA4CckjIGtDL0zBjK4Gk=
X-Received: by 2002:a17:906:c145:b0:beb:2de3:1ba1 with SMTP id a640c23a62f3a-bf0a8433d98mr476181266b.11.1780582168216;
        Thu, 04 Jun 2026 07:09:28 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559fe77csm306402266b.63.2026.06.04.07.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:09:27 -0700 (PDT)
Message-ID: <9d1e0448-27d7-42d3-aaa3-2d09489f18d9@linaro.org>
Date: Thu, 4 Jun 2026 15:09:26 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] perf cs-etm: Use thread-stack for last branch
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
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
 <20260526-b4-arm_cs_callchain_support_v1-v6-3-f9f49f53c9dd@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-3-f9f49f53c9dd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/05/2026 5:59 pm, Leo Yan wrote:
> CS ETM maintains its own circular array for last branch entries, with
> local helpers to update, copy and reset the branch stack. This duplicates
> logic already provided by the common code.
> 
> Record branch with thread_stack__event() and synthesize branch stack
> with thread_stack__br_sample(). This removes the local last_branch_rb
> buffer and position tracking. Keep the buffer number updated via
> thread_stack__set_trace_nr(), which is used when exporting samples to
> Python scripts.
> 
> The output should remain same, except that be->flags.predicted is no
> longer set. Since CoreSight trace does not provide branch prediction
> information, clearing the flag avoids confusion.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 152 +++++++++++++----------------------------------
>   1 file changed, 41 insertions(+), 111 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 5bff8811d61e423463b7bd4e20d599d5b5307a1a..398ab3b7a429d402cc8e5f6cccb35c0b7c253732 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -83,14 +83,13 @@ struct cs_etm_auxtrace {
>   struct cs_etm_traceid_queue {
>   	u8 trace_chan_id;
>   	u64 period_instructions;
> -	size_t last_branch_pos;
>   	union perf_event *event_buf;
>   	struct thread *thread;
>   	struct thread *prev_packet_thread;
>   	ocsd_ex_level prev_packet_el;
>   	ocsd_ex_level el;
> +	unsigned int br_stack_sz;
>   	struct branch_stack *last_branch;
> -	struct branch_stack *last_branch_rb;
>   	struct cs_etm_packet *prev_packet;
>   	struct cs_etm_packet *packet;
>   	struct cs_etm_packet_queue packet_queue;
> @@ -635,9 +634,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
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
> @@ -647,7 +645,6 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>   	return 0;
>   
>   out_free:
> -	zfree(&tidq->last_branch_rb);
>   	zfree(&tidq->last_branch);
>   	zfree(&tidq->prev_packet);
>   	zfree(&tidq->packet);
> @@ -941,7 +938,6 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
>   		thread__zput(tidq->prev_packet_thread);
>   		zfree(&tidq->event_buf);
>   		zfree(&tidq->last_branch);
> -		zfree(&tidq->last_branch_rb);
>   		zfree(&tidq->prev_packet);
>   		zfree(&tidq->packet);
>   		zfree(&tidq);
> @@ -1281,57 +1277,6 @@ static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
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
>   					 u8 trace_chan_id, u64 addr)
>   {
> @@ -1400,38 +1345,6 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
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
> @@ -1579,6 +1492,37 @@ static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
>   		return etm->latest_kernel_timestamp;
>   }
>   
> +static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
> +				    struct cs_etm_traceid_queue *tidq)
> +{
> +	u64 from, to;
> +	int size;
> +
> +	if (!tidq->prev_packet->last_instr_taken_branch)
> +		return;
> +
> +	if (tidq->prev_packet->sample_type != CS_ETM_RANGE ||
> +	    tidq->packet->sample_type != CS_ETM_RANGE)
> +		return;
> +
> +	if (etmq->etm->synth_opts.last_branch) {
> +		from = cs_etm__last_executed_instr(tidq->prev_packet);
> +		to = cs_etm__first_executed_instr(tidq->packet);
> +
> +		size = cs_etm__instr_size(etmq, tidq->trace_chan_id,
> +					  tidq->prev_packet->isa, from);
> +
> +		/* Enable callchain so thread stack entry can be allocated */
> +		thread_stack__event(tidq->thread, tidq->prev_packet->cpu,
> +				    tidq->prev_packet->flags, from, to, size,
> +				    etmq->buffer->buffer_nr + 1, true,
> +				    tidq->br_stack_sz, 0);
> +	} else {
> +		thread_stack__set_trace_nr(tidq->thread, tidq->prev_packet->cpu,
> +					   etmq->buffer->buffer_nr + 1);
> +	}
> +}
> +
>   static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>   					    struct cs_etm_traceid_queue *tidq,
>   					    u64 addr, u64 period)
> @@ -1608,8 +1552,12 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>   
>   	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
>   
> -	if (etm->synth_opts.last_branch)
> +	if (etm->synth_opts.last_branch) {
> +		thread_stack__br_sample(tidq->thread, tidq->packet->cpu,
> +					tidq->last_branch,
> +					tidq->br_stack_sz);
>   		sample.branch_stack = tidq->last_branch;
> +	}
>   
>   	if (etm->synth_opts.inject) {
>   		ret = cs_etm__inject_event(etm, event, &sample,
> @@ -1798,14 +1746,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
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

Would it be cleaner to call this whenever a branch sample is generated? 
Seems like the conditions for calling thread_stack__event() and 
cs_etm__synth_branch_sample() are slightly different (ignoring the fact 
that branches are only generated when the user asks for them).

Maybe the conditions should be different, but maybe a comment why or if 
they're the same, a shared function for the conditions would help.

For example, we don't push a branch to the stack for 
CS_ETM_DISCONTINUITY, but we do generate a branch sample from 0.

>   
>   	if (etm->synth_opts.instructions &&
>   	    tidq->period_instructions >= etm->instructions_sample_period) {
> @@ -1864,10 +1805,6 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
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
> @@ -1947,10 +1884,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
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
> @@ -1982,7 +1915,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>   
>   	/* Reset last branches after flush the trace */
>   	if (etm->synth_opts.last_branch)
> -		cs_etm__reset_last_branch_rb(tidq);
> +		thread_stack__flush(tidq->thread);
>   
>   	return err;
>   }
> @@ -2006,9 +1939,6 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
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


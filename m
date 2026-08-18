Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B63812FB
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063891; cv=none; b=dIx1F6K9CtLDt/Zb6JFiPmfI4lU5c5FG8CWtmkYs/1UJb2JbWiBW6SoFq8slyP+3USTYDzVUODfJRoH32Ef2JPsjcbHCSZAyyP+MnS/8/26kvJGgs6XFGxb5Nqx1KxTT/vtIvfgeysQtlpp/HukzWUnNRJPbhBdxVNjB0V5MBtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063891; c=relaxed/simple;
	bh=tjL8BaWm1gTid39qOTqJeyEPgMwXjFccZqsIrZYvl94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8FkPMyfjFwY9wSO7UaslZ+q76Q4guIyoNwZsApU58G2NNalHwl2+CzXMPY9if7RE+Yh3B90Ir5RS03XvoXLr61BfcrmoSdXFbFVkxkE6YD3MlRApH2aUqmhLpa02TT97ZXXavZPmEbD5tKfeZPp9RYv1fV6B8/MwAtNZp5tAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gJnv39BZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJnv39BZ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954dff6536so35367065e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787063888; x=1787668688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lK/sGdx2GchoWjuY7/UAUK1Wnr5nxXmBgtlEaIgFQCk=;
        b=gJnv39BZKIb9OEctta35VIJoP7biLzyvF4xrl9ND87ajpSQuLO3S6smGK3/y6HDXkp
         JHC1SSjxBsGNHvKtAq62yFLkYbV1Khw0Db/yx2WOYdg0k897feNDFGdl3UHtNlKzyqEE
         vPHXk2pbWTHnKbY14XklwNHPux3o487zvnUUTl2l41w6E7z1R6iOQ6EWFZj7gD9hVAAc
         QxwVeu6hvl/UCgcxAzgpyRtgGZPhfPX1CQQ/Wn7n4TgMM3luyChMiLRZ/ndpd/OHC/ws
         2HWf5szq5Rptx0g1L2rDlN4EQkIrkKHQJcUj1FDbxzw8YKYDHkXLs/G7rDUI3oT4FMas
         cY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063888; x=1787668688;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lK/sGdx2GchoWjuY7/UAUK1Wnr5nxXmBgtlEaIgFQCk=;
        b=PBnvHTvSuOMudue7x6gyG//g73FhGbJdNrxCHLff1mvPJH1xdPi840NZjvK3aijag+
         WxRqPs9Ojeml5w9kYCNGNxEYN9MI/g0uA1m3u7oSucXe8YYD6p7sh0bl3/WZzJFH1l6B
         4PCK5utPLYy7/X52FhbMKbJ+ZxYqJnadashhGQzgfE/OL020J2kPcB/+QfvEDWwOz+WY
         W5Qz3DybBKHr3GMAhncMW4YHJrVHskBaREiwUGjLGXvQvVbL6CVYCCvwYg4757VoYPZq
         Q1QSK20CAMX0sVjgH4nnX1qL2Smg8BPgB2DpYDdfe3I7aLn+8LmsTrUAFMVgLu5d7noo
         Ma8w==
X-Forwarded-Encrypted: i=1; AHgh+RrV/nWtmnydnenpfO3erHNaOjAX5g+PRwIXDX1eyF+8ivQvtJs8X5zVI2EH9k5KBD4R67XYfVhE90ycZRMlVxaj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm3l7QEnpHF51WCAI5UVk1L3mTy40s1mp24iPAnokMMBsxcaFt
	9I0iI8aEFDVHTBEdOSj+pNk7p7oFhPFna/IV54ZK9O4QRdUOd2rB1dEm8PULvp75aQM=
X-Gm-Gg: AR+sD12oI6uaZOyZX1LKFc1nfqT4sXhXTLHiTlMOKGb3C/hKt4qfHTLqydKXKFRod81
	k2Tg6HJTyAFKriz7gdKH/4jN1X/3S9P4L24DVwUFRX8PEmJT5x8GLy6+HProf7RiEIj8wKRZ3WO
	Sx7p2M0C3VHqHtyx8a2wUYp2briB+y97GISs9Awus/PEKVMzZB9BvvLx+Q+bgHHcNCDc1Ure5Ez
	Dx08kXxiuPvf6gRMSS5ds/6Z+UcM2IFiF9B1VLYdXKMKeyHCuohslFyxAkE+k9G+GUHHO8BLkLA
	otomXt/3Tt2WWWNuM5Jh4fVNg9zC41I0H/dlqvzpWSkyAKf/dGD+Myz5t4PdL5ko+dsS85VPzGS
	eBu3ebkXJeNf7h1HU3MfhNN2fGh9d97OJhs6CgkkhlBkhYG0EDPrjoBa14L09cDVkz3yBSFiUK/
	DEGeZErAU7/NLgNz2KhGPB/gInYg07IeIrF+oMFfAXebWAjpBcmgJGMx1zR2oqzG4/vbsGWDkcN
	BWM
X-Received: by 2002:a05:600c:8714:b0:499:8704:242c with SMTP id 5b1f17b1804b1-499878ca13bmr616077415e9.0.1787063887786;
        Tue, 18 Aug 2026 07:38:07 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm264146625e9.0.2026.08.18.07.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 07:38:07 -0700 (PDT)
Message-ID: <18a23572-5383-4b21-ba7c-ebafa8d0f08c@linaro.org>
Date: Tue, 18 Aug 2026 15:38:06 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] perf cs-etm: Split up
 cs_etm__process_timestamped_queues()
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
 <ac33d12949419373516ca02f2972c7e0af01c069.1787005265.git.aaupov@fb.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ac33d12949419373516ca02f2972c7e0af01c069.1787005265.git.aaupov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/08/2026 23:22, Amir Ayupov wrote:
> cs_etm__process_timestamped_queues() currently does three things: it seeds
> the auxtrace heap with one entry per queue, it decodes until the heap is
> empty, and it then walks every traceID queue to flush whatever is left in
> the branch stacks. That is fine while the only caller is
> cs_etm__flush_events(), which runs once, but it does not survive the
> function being called repeatedly.
> 
> Seeding cannot be repeated because a queue that still holds a heap slot
> would be seeded again, adding duplicate entries and growing the heap
> without bound. Flushing cannot be repeated either, because ending a block
> finalises state that later trace still needs.
> 
> Move both out. Seeding becomes cs_etm__update_queues(), gated on
> queues.new_data so it only runs when new AUX data has been queued, with
> etmq->on_heap tracking whether a queue currently occupies a heap slot;
> this mirrors intel_pt_update_queues() and intel_pt_queue::on_heap.
> Flushing becomes cs_etm__flush_timestamped_queues(). What remains is the
> decode loop on its own, which a later patch can then drive incrementally.
> 
> No functional change: the sole caller performs the same three steps in the
> same order.
> 
> Assisted-by: Devmate:GPT-5.6
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

LGTM but I'd still like to run the test.

> ---
>   tools/perf/util/cs-etm.c | 71 ++++++++++++++++++++++++++++++++++------
>   1 file changed, 61 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 114b3cd2da495..4d895f11deb7f 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -136,9 +136,13 @@ struct cs_etm_queue {
>   	 */
>   	struct intlist *own_traceid_list;
>   	u32 sink_id;
> +	/* Whether this queue currently occupies a slot in etm->heap */
> +	bool on_heap;
>   };
>   
> +static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
>   static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
> +static int cs_etm__flush_timestamped_queues(struct cs_etm_auxtrace *etm);
>   static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
>   					   pid_t tid);
>   static int cs_etm__get_data_block(struct cs_etm_queue *etmq);
> @@ -939,6 +943,8 @@ static int cs_etm__flush_events(struct perf_session *session,
>   	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>   						   struct cs_etm_auxtrace,
>   						   auxtrace);
> +	int ret;
> +
>   	if (dump_trace)
>   		return 0;
>   
> @@ -953,7 +959,15 @@ static int cs_etm__flush_events(struct perf_session *session,
>   		return cs_etm__process_timeless_queues(etm, -1);
>   	}
>   
> -	return cs_etm__process_timestamped_queues(etm);
> +	ret = cs_etm__update_queues(etm);
> +	if (ret)
> +		return ret;
> +
> +	ret = cs_etm__process_timestamped_queues(etm);
> +	if (ret)
> +		return ret;
> +
> +	return cs_etm__flush_timestamped_queues(etm);
>   }
>   
>   static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
> @@ -1330,6 +1344,8 @@ static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
>   	 */
>   	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
>   	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
> +	if (!ret)
> +		etmq->on_heap = true;
>   out:
>   	return ret;
>   }
> @@ -2767,23 +2783,30 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
>   	return 0;
>   }
>   
> -static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
> +/*
> + * Seed the heap with one entry from each queue that is not already
> + * represented in it, so that decoding proceeds in time order across all
> + * queues. Only queues that have newly queued data need to be considered.
> + */
> +static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
>   {
>   	int ret = 0;
> -	unsigned int cs_queue_nr, queue_nr, i;
> -	u8 trace_chan_id;
> -	u64 cs_timestamp;
> -	struct auxtrace_queue *queue;
> +	unsigned int i;
>   	struct cs_etm_queue *etmq;
> -	struct cs_etm_traceid_queue *tidq;
> +
> +	if (!etm->queues.new_data)
> +		return 0;
> +
> +	etm->queues.new_data = false;
>   
>   	/*
>   	 * Pre-populate the heap with one entry from each queue so that we can
> -	 * start processing in time order across all queues.
> +	 * start processing in time order across all queues. Skip queues that
> +	 * already occupy a heap slot, otherwise they would be added twice.
>   	 */
>   	for (i = 0; i < etm->queues.nr_queues; i++) {
>   		etmq = etm->queues.queue_array[i].priv;
> -		if (!etmq)
> +		if (!etmq || etmq->on_heap)
>   			continue;
>   
>   		ret = cs_etm__queue_first_cs_timestamp(etm, etmq, i);
> @@ -2791,6 +2814,19 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
>   			return ret;
>   	}
>   
> +	return ret;
> +}
> +
> +static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
> +{
> +	int ret = 0;
> +	unsigned int cs_queue_nr, queue_nr;
> +	u8 trace_chan_id;
> +	u64 cs_timestamp;
> +	struct auxtrace_queue *queue;
> +	struct cs_etm_queue *etmq;
> +	struct cs_etm_traceid_queue *tidq;
> +
>   	while (1) {
>   		if (!etm->heap.heap_cnt)
>   			break;
> @@ -2807,6 +2843,7 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
>   		 * to process it.
>   		 */
>   		auxtrace_heap__pop(&etm->heap);
> +		etmq->on_heap = false;
>   
>   		tidq  = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
>   		if (!tidq) {
> @@ -2874,7 +2911,21 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
>   		 */
>   		cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
>   		ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
> +		if (ret)
> +			goto out;
> +		etmq->on_heap = true;
>   	}
> +out:
> +	return ret;
> +}
> +
> +/* Flush any branch stack entries left over once all trace is decoded */
> +static int cs_etm__flush_timestamped_queues(struct cs_etm_auxtrace *etm)
> +{
> +	int ret = 0;
> +	unsigned int i;
> +	struct cs_etm_queue *etmq;
> +	struct cs_etm_traceid_queue *tidq;
>   
>   	for (i = 0; i < etm->queues.nr_queues; i++) {
>   		struct int_node *inode;
> @@ -2893,7 +2944,7 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
>   				return ret;
>   		}
>   	}
> -out:
> +
>   	return ret;
>   }
>   


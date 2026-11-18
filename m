Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021816;
	b=h54HU60QnmZ1PtMJiNoR0kswTBMDF4vEfCOy+LVCNEOMJhlylPX7SqrRzJj2pjUVbXwD
	 orntgq7byY/pmRqRY6dyNWGutS/Eh/GCMZgacnJSogi2vUQ3iF5bG+U5hx9lYRyJnfDCL
	 Ou217H2bemxqD/P1ZF6opKfd26oA0QeHSyypozhUxHY7EoN6e/u3MwfbyzUyMN32l/CHp
	 RKXFeULodWr86DVTppzR69AEgNaYfcoWz++iRVmASwQ4D/xJnjn966AzNfzbkYhQFVjcr
	 pZEFtpI5xLLflKaRi6TTcfwiwjO9KnL8UvbcwJN/qXtCtOAO7daMnf/0xeidVwLCQyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021816;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AYiTPeRlYGM8Ennnq1xOD71FBGU+cxDIWpCAepa9W6I=;
	b=KcpGn9Ud0Mpy+L6GeUg7C/Va7iizz82IY3arBesHF21pq4WBg4sURPzgCsEfj+yQaRLa
	 RsHzhLi2aQteNyi97ATQidxvlnhoPIV+4JDItmJ/rDspMC95aDNzJqyXJ4chLo1DhZnaz
	 Olm3UUeYcIGPdB9F6pEOzgwdvadg+CXV3x3YOtrfMN5eqwd1fIOgMbvHgla2FxoR3j3+I
	 7csck+ERlBf6Fm93fr5lzb9oY1DPkk6TzliwFEwEYov+nXrQfTMgIILiWygkyEg64/+P8
	 PGKXWs5tEUKiGYfeyOOtQDEc9ZV7aPkqO0uHgt8jbMmzuODmUNEU7sJtqpqI6WQjjgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5d76je8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BE4606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5d76je8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5C71F000C5;
	Wed, 18 Nov 2026 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795021815;
	bh=AYiTPeRlYGM8Ennnq1xOD71FBGU+cxDIWpCAepa9W6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C5d76je8wcbqxoDYtF1u4kBRha70GJhszdgL3wkKsZ8enLRGAWdUHUiZiT89/57nt
	 fngOKppoinYc2LWfFtk/EFIQWh0wfASN8OODmoGvYrqkIVj/HZgXswx9gtDGudyVQC
	 N3NYKExEfqqMHjpA4Tynr/GpGhmdofbokEm5uerhcYzrdSaoP47aIdsO+KhFPw3sVH
	 naOn9vWIfqqP3ox12ZOs7zu5Vp/6/tRtA3kBN07YpWvi4pwOFslc4Xk6gqrBAzwpVF
	 i7R6/AWjMa+oU7OrC0ictYCSHJmVFhTx13hXo+bDR6/K9PvrGI89hIUr8gtdkzu4FP
	 7KioPDHVyeYPw==
Message-ID: <sashiko-outbox-221583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/34] perf cs-etm: Decode in order of Perf samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-17-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-17-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 17:10:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf cs-etm: trace decoding fails when PERF_SAMPLE_TIME is
  absent
- [Medium] perf cs-etm: premature next-buffer load in cs_etm__pop_heap()
  before flush
--

commit 11ab0fc2c585444dee0fab0f3ef2be954d8f75a6
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Decode in order of Perf samples

This commit replaces the separate timestamped, timeless, and per-thread
CoreSight ETM decode paths with a unified heap-ordered decode driven by
Perf event timestamps.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index b746d1215e0a0..5c98c7960f823 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
[ ... ]
> @@ -960,21 +952,19 @@ static int cs_etm__flush_events(struct perf_session=
 *session,
>  	struct cs_etm_auxtrace *etm =3D container_of(session->auxtrace,
>  						   struct cs_etm_auxtrace,
>  						   auxtrace);
> +	int ret;
> +
>  	if (dump_trace || auxtrace__dont_decode(session))
>  		return 0;
> =20
>  	if (!tool->ordered_events)
>  		return -EINVAL;
> =20
> -	if (!etm->has_timestamps) {
> -		/*
> -		 * Pass tid =3D -1 to process all queues. But likely they will have
> -		 * already been processed on PERF_RECORD_EXIT anyway.
> -		 */
> -		return cs_etm__process_timeless_queues(etm, -1);
> -	}
> +	ret =3D cs_etm__pop_heap(etm, MAX_TIMESTAMP);
> +	if (ret)
> +		return ret;
> =20
> -	return cs_etm__process_timestamped_queues(etm);
> +	return cs_etm__flush_queues(etm);
>  }
[ ... ]
> @@ -1321,75 +1311,77 @@ static int cs_etm__setup_queue(struct cs_etm_auxt=
race *etm,
[ ... ]
> +static int cs_etm__push_queue(struct cs_etm_queue *etmq, u64 time)
> +{
> +	int ret;
> +
> +	if (!etmq || etmq->on_heap)
> +		return 0;
> +
> +	while (!etmq->on_heap) {
>  		ret =3D cs_etm__get_data_block(etmq);
>  		if (ret <=3D 0)
> -			goto out;
> +			return ret;
> +		if (!etmq->etm->has_virtual_ts && etmq->buffer->time > time)
> +			return 0;
> =20
> -		/*
> -		 * Run decoder on the trace block.  The decoder will stop when
> -		 * encountering a CS timestamp, a full packet queue or the end of
> -		 * trace for that block.
> -		 */
> -		ret =3D cs_etm__decode_data_block(etmq);
> +		ret =3D cs_etm__add_to_heap(etmq);
>  		if (ret)
> -			goto out;
> +			return ret;
> +	}
> =20
> -		/*
> -		 * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
> -		 * the timestamp calculation for us.
> -		 */
> -		cs_timestamp =3D cs_etm__etmq_get_sort_timestamp(etmq, &trace_chan_id);
> +	return 0;
> +}
[ ... ]
> @@ -2895,11 +2743,21 @@ static int cs_etm__process_timestamped_queues(str=
uct cs_etm_auxtrace *etm)
>  		queue =3D &etm->queues.queue_array[queue_nr];
>  		etmq =3D queue->priv;
> =20
> +		/* Don't go further than the trace timestamp or collection time */
> +		if (etm->has_virtual_ts) {
> +			if (etm->heap.heap_array[0].ordinal >=3D timestamp)
> +				break;
> +		} else {
> +			if (etmq->buffer->time >=3D timestamp)
> +				break;
> +		}
> +
>  		/*
>  		 * Remove the top entry from the heap since we are about
>  		 * to process it.
>  		 */
>  		auxtrace_heap__pop(&etm->heap);
> +		etmq->on_heap =3D false;
> =20
>  		tidq  =3D cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
>  		if (!tidq) {
> @@ -2913,7 +2771,7 @@ static int cs_etm__process_timestamped_queues(struc=
t cs_etm_auxtrace *etm)
>  		}
> =20
>  		/*
> -		 * Packets associated with this timestamp are already in
> +		 * Packets associated with this timestamp, if any, are already in
>  		 * the etmq's traceID queue, so process them.
>  		 */
>  		ret =3D cs_etm__process_traceid_queue(etmq, tidq);
> @@ -2925,7 +2783,7 @@ static int cs_etm__process_timestamped_queues(struc=
t cs_etm_auxtrace *etm)
>  		 * move on to the next timestamp, fetching a new auxtrace_buffer
>  		 * if need be.
>  		 */
> -refetch:
> +get_data_block:
>  		ret =3D cs_etm__get_data_block(etmq);
>  		if (ret < 0)
>  			goto out;
> @@ -2937,37 +2795,28 @@ static int cs_etm__process_timestamped_queues(str=
uct cs_etm_auxtrace *etm)
>  		if (!ret)
>  			continue;
> =20
> -		ret =3D cs_etm__decode_data_block(etmq);
> -		if (ret)
> -			goto out;
> -
> -		cs_timestamp =3D cs_etm__etmq_get_sort_timestamp(etmq, &trace_chan_id);
> -
> -		if (!cs_timestamp) {
> -			/*
> -			 * Function cs_etm__decode_data_block() returns when
> -			 * there is no more traces to decode in the current
> -			 * auxtrace_buffer OR when a timestamp has been
> -			 * encountered on any of the traceID queues.  Since we
> -			 * did not get a timestamp, there is no more traces to
> -			 * process in this auxtrace_buffer.  As such empty and
> -			 * flush all traceID queues.
> -			 */
> -			cs_etm__clear_all_traceid_queues(etmq);
> -
> -			/* Fetch another auxtrace_buffer for this etmq */
> -			goto refetch;
> -		}
> -
>  		/*
> -		 * Add to the min heap the timestamp for packets that have
> -		 * just been decoded.  They will be processed and synthesized
> -		 * during the next call to cs_etm__process_traceid_queue() for
> -		 * this queue/traceID.
> +		 * Add the next timestamp or decoded packets to the min heap.
> +		 * Packets will be processed and synthesized during the next call
> +		 * to cs_etm__process_traceid_queue() for this queue/traceID.
>  		 */
> -		cs_queue_nr =3D TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
> -		ret =3D auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
> +		ret =3D cs_etm__add_to_heap(etmq);
> +		if (ret)
> +			goto out;
> +		if (!etmq->on_heap)
> +			goto get_data_block;
>  	}

[Severity: Medium]
Does loading the next auxtrace_buffer via cs_etm__get_data_block() here
corrupt the state needed to flush the previous buffer's final packet and
cause premature decoding of future AUX buffers?

When the last CS_ETM_RANGE packet of an auxtrace_buffer is processed,
cs_etm__sample() swaps it into tidq->prev_packet with any unsampled
period_instructions remaining.  Unlike the removed timeless decoder loops,
which called cs_etm__end_block() at the end of each buffer before fetching
the next one, cs_etm__pop_heap() immediately calls cs_etm__get_data_block()
when etmq->buf_len reaches 0.  When the next buffer is loaded,
cs_etm__get_trace() replaces etmq->buffer, wipes all thread branch stacks
via cs_etm__flush_all_stack(), and in per-thread mode overwrites
tidq->frontend_thread and tidq->decode_thread with the new buffer's TID.
When the new buffer's initial CS_ETM_DISCONTINUITY packet later calls
cs_etm__flush(), the previous buffer's final instruction and branch samples
are synthesized with the new buffer's timestamp, thread, and cleared call
stack.

In addition, when !etm->has_virtual_ts, both cs_etm__push_queue() and this
loop call cs_etm__get_data_block() before checking whether the next buffer's
time is beyond the current Perf event timestamp, and cs_etm__pop_heap() does
not check etmq->buffer->time > timestamp at all before calling
cs_etm__add_to_heap(), decoding the start of the next AUX buffer before
intervening MMAP and COMM records have been processed (a later patch in this
series, commit "perf cs-etm: Find timestamps by searching ahead", adds the
timestamp check via cs_etm__insert_heap_queue(), but still calls
cs_etm__get_data_block() before that check and before flushing the previous
buffer).

[ ... ]
> @@ -3049,6 +2898,8 @@ static int cs_etm__process_event(struct perf_sessio=
n *session,
>  	struct cs_etm_auxtrace *etm =3D container_of(session->auxtrace,
>  						   struct cs_etm_auxtrace,
>  						   auxtrace);
> +	bool has_sample_time =3D sample->time && sample->time !=3D (u64)-1;
> +	int ret =3D 0;
> =20
>  	if (dump_trace || auxtrace__dont_decode(session))
>  		return 0;
> @@ -3059,34 +2910,71 @@ static int cs_etm__process_event(struct perf_sess=
ion *session,
>  	}
> =20
>  	switch (event->header.type) {
> -	case PERF_RECORD_EXIT:
> +	case PERF_RECORD_ITRACE_START:
> +		ret =3D cs_etm__process_itrace_start(etm, event);
> +		if (ret)
> +			return ret;
> +
>  		/*
> -		 * Don't need to wait for cs_etm__flush_events() in per-thread mode to
> -		 * start the decode because we know there will be no more trace from
> -		 * this thread. All this does is emit samples earlier than waiting for
> -		 * the flush in other modes, but with timestamps it makes sense to wait
> -		 * for flush so that events from different threads are interleaved
> -		 * properly.
> +		 * Start decoding for this CPU on trace start. Timestamps in the
> +		 * trace will prevent decoding from going further ahead than
> +		 * Perf events.
>  		 */
> -		if (etm->per_thread_decoding && !etm->has_timestamps)
> -			return cs_etm__process_timeless_queues(etm,
> -							       event->fork.tid);
> +		if (has_sample_time && etm->has_virtual_ts) {
> +			ret =3D cs_etm__push_heap(etm, sample);
> +			if (ret)
> +				return ret;
> +		}
>  		break;
[ ... ]
> +	case PERF_RECORD_AUX:
> +		/*
> +		 * Start decoding after AUX to support !etm->has_virtual_ts
> +		 * because mmaps for that buffer must be available at this
> +		 * point. Push all queues so that they are ordered between each
> +		 * other, rather than waiting for their own AUX records which
> +		 * would be too late.
> +		 */
> +		if (etm->has_timestamps && !etm->has_virtual_ts)
> +			ret =3D cs_etm__push_heap_all(etm);
> +		else if (has_sample_time)
> +			ret =3D cs_etm__push_heap(etm, sample);
> +
> +		if (ret)
> +			return ret;
> +		break;
> =20
>  	default:
>  		break;
>  	}
> =20
> +	if (has_sample_time)
> +		return cs_etm__pop_heap(etm, sample->time);
> +
>  	return 0;
>  }

[Severity: Medium]
Does this skip all trace decoding when analyzing a perf.data file recorded
without PERF_SAMPLE_TIME (such as per-thread recordings created by older
perf binaries without -T)?

When PERF_SAMPLE_TIME is not set, __evsel__parse_sample() sets sample->time
to (u64)-1 (which equals MAX_TIMESTAMP), so has_sample_time is false for
every event and cs_etm__queue_aux_fragment() sets buffer->time to (u64)-1.
As a result, queues are never pushed during cs_etm__process_event() when
etm->has_virtual_ts or !etm->has_timestamps, and cs_etm__flush_events()
calls cs_etm__pop_heap(etm, MAX_TIMESTAMP) without pushing them first.
Even when etm->has_timestamps && !etm->has_virtual_ts pushes the queues on
PERF_RECORD_AUX, cs_etm__pop_heap(etm, MAX_TIMESTAMP) immediately hits
etmq->buffer->time >=3D timestamp (~0ULL >=3D ~0ULL) and breaks out without
decoding any trace data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D17

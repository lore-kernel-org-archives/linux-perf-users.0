Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021295;
	b=b8l51tSWlKJfuZwPGZr110GHBO+pYHkbvLjfaaE4UuhvenCsMztxNhjSLuD5hh22gXhK
	 hO5JEepQDx1K34ByoC85XJxSMOc9vz4ZC9aERBEwOs+Qy6qo3rPhcFb7R+uY+BFQKNFV9
	 PyCcw0V7cclJe9o0R045VpQbtwTLjs1ZT86q6JAoYEpM0bF5PYB0NNGC7Iy9ykQ6+/tc4
	 60rTG6efRSPkE8Lp+4m4Tzp7X6cPjiPN0mds3C/dgi+um55/VnVhdnHGWpABgNY/uopka
	 OXcH/HCfsMfaRjuo7oZziB1z/2r7wff2x79yZiy8yZ3QIgW4fHv9LuIb/n0Q2NzZrxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021295;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LPdHXh8RpUm/k9VOOmvJhjcCl4YIqrwt7XE8L/Xf3AI=;
	b=bRPTjx+eyiOq37oKsTTLB89wtKrZhK2vIkbo13yZ5kxamWaGLtJYS9FL0lm3Uf1e1ECD
	 +r58B7Kthq11m8Y/U0R8OJlnfOUU0Kc41+Pb+PeuoArGcoArySKs48Cxfeqv6zF+mF8XN
	 R/yYLxHGi3CS6WzX/DdWliahL4tdmVlGVQ7Y96LhK6U36O0xUcBEgiy1uN6mcpEDufGBj
	 lBiwK7BPEd6AZa4s3pbO4UvrhhTM7MFqJ0CjEN5/mdm1z7PtT7TWidLbodXL7YYKfL8Im
	 yrJbULEKX02t0inEjeWgiHZLyBk92LWQWEbEL6gS2ncDPNOYyddYdEXiFgDHbL8pVXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiPNqWhX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E82606A330
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiPNqWhX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128BE1F000C6;
	Wed, 18 Nov 2026 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795021295;
	bh=LPdHXh8RpUm/k9VOOmvJhjcCl4YIqrwt7XE8L/Xf3AI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WiPNqWhXP8sp5F+yFL9PXqAXJRy+PckXP2D4GsdrMex4O+PbBeHlBjwWU8Y8K28Nz
	 GDTJ0tFG0cRCmVhH+Y2FCHfpSdpHXGzKJzykRXE/5Rp5OovpCHW5qOWlMaZernKvvJ
	 YN8qTNZwczquLyZwJXz7b9gi144Ys7fy0FO27vQBYxrAd+gnABG/CPJoi1U8sF8xI6
	 MHUn36rCYF1LVoyUfnTSuVzqbxPCpk5Ow97LJHGHuBu4BRf7bN/5sYC0D4Zv1F7San
	 irbbSqwqU6PFEOsq+oVNBGV8Kl3bBB/BqWiKmPoxDulPUB42vyWsFXCyE7QCLwaF7R
	 03k7PsZdqBh9g==
Message-ID: <sashiko-outbox-221574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 29/34] perf cs-etm: Find timestamps by searching ahead
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-29-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-29-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 17:01:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf cs-etm: heap stall and dropped queues in non-virtual
  timestamp mode
--

commit 95d787db531b56fc0f9104f4d25589c7638920b3
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Find timestamps by searching ahead

This commit uses the packet-only timestamp decoder to search ahead for
the next timestamp on context packets and trace discontinuities, and
reorders packets so timestamps are delivered before context changes or
after discontinuities flush earlier samples.

> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf=
/util/cs-etm-decoder/cs-etm-decoder.c
> index 56de6c76de68b..b7ed7847f209b 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
[ ... ]
> @@ -869,16 +884,130 @@ int cs_etm_decoder__process_data_block(struct cs_e=
tm_packet_decoder *decoder,
[ ... ]
> +static int cs_etm_decoder__reorder_packet(struct cs_etm_packet_decoder *=
decoder,
> +					  const struct cs_etm_buffer *buffer,
> +					  struct cs_etm_traceid_ctxt *tidc)
> +{
> +	u64 timestamp;
> +	int ret;
> +
> +	if (tidc->packet->sample_type !=3D CS_ETM_CONTEXT &&
> +	    tidc->packet->sample_type !=3D CS_ETM_DISCONTINUITY)
> +		return 0;
> +
> +	/*
> +	 * ETM always emits a timestamp after a context or trace discontinuity
> +	 * so search for it and give it to the frontend first.
> +	 */
> +	ret =3D cs_etm_decoder__search_timestamp(decoder, buffer, decoder->pack=
et_index, &timestamp);
> +	if (ret)
> +		return ret;
> +
> +	decoder->pending =3D tidc;
> +	decoder->pending_packet =3D *tidc->packet;
> +	decoder->pending_packet.timestamp =3D max(decoder->timestamp, timestamp=
);
> +	if (tidc->packet->sample_type =3D=3D CS_ETM_CONTEXT) {
> +		/* Publish the timestamp before allowing the context to be applied. */
> +		decoder->timestamp =3D decoder->pending_packet.timestamp;
> +		tidc->packet->sample_type =3D CS_ETM_TIMESTAMP;
> +	} else {
> +		/* Let the discontinuity flush preceding samples at the old time. */
> +		decoder->pending_packet.sample_type =3D CS_ETM_TIMESTAMP;
> +	}
> +	return 0;
> +}
[ ... ]
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index d275d37011659..5a704dfeebd34 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
[ ... ]
> @@ -1215,68 +1180,74 @@ static int cs_etm__setup_queue(struct cs_etm_auxt=
race *etm,
[ ... ]
> -static int cs_etm__push_queue(struct cs_etm_queue *etmq, u64 time)
> +static int cs_etm__insert_heap_queue(struct cs_etm_queue *etmq, u64 time)
>  {
>  	int ret;
> =20
>  	if (!etmq || etmq->on_heap)
>  		return 0;
> =20
> -	while (!etmq->on_heap) {
> +	if (!etmq->buf) {
>  		ret =3D cs_etm__get_data_block(etmq);
>  		if (ret <=3D 0)
>  			return ret;
> +	}
> +
> +	while (1) {
>  		if (!etmq->etm->has_virtual_ts && etmq->buffer->time > time)
>  			return 0;
> =20
> -		ret =3D cs_etm__add_to_heap(etmq, NULL);
> -		if (ret)
> +		ret =3D cs_etm__decode_packet(etmq, &etmq->tidc);
> +		if (ret < 0)
>  			return ret;
> +		if (etmq->tidc)
> +			return cs_etm__add_to_heap(etmq, etmq->tidc->packet->timestamp);
> +
> +		/* Drain buffered decoder output before fetching another AUX buffer. */
> +		ret =3D cs_etm__get_data_block(etmq);
> +		if (ret <=3D 0)
> +			break;
>  	}
> =20
> -	return 0;
> +	if (!ret)
> +		etmq->buf =3D NULL;
> +	return ret;
>  }
[ ... ]
> @@ -2580,11 +2558,11 @@ static int cs_etm__process_traceid_ctxt(struct cs=
_etm_queue *etmq,
>  static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
>  {
[ ... ]
>  		/* Take the entry at the top of the min heap */
> -		cs_queue_nr =3D etm->heap.heap_array[0].queue_nr;
> -		queue_nr =3D TO_QUEUE_NR(cs_queue_nr);
> -		trace_chan_id =3D TO_TRACE_CHAN_ID(cs_queue_nr);
> +		queue_nr =3D etm->heap.heap_array[0].queue_nr;
> +		cs_timestamp =3D etm->heap.heap_array[0].ordinal;
>  		queue =3D &etm->queues.queue_array[queue_nr];
>  		etmq =3D queue->priv;
> =20
>  		/* Don't go further than the trace timestamp or collection time */
> -		queue_time =3D etm->has_virtual_ts ? etm->heap.heap_array[0].ordinal :
> +		queue_time =3D etm->has_virtual_ts ? cs_timestamp :
>  						   etmq->buffer->time;
>  		if (queue_time >=3D timestamp)
>  			break;
[ ... ]
> -add_to_heap:
> -		/* Schedule the next decode step after consuming the current packet. */
> -		ret =3D cs_etm__add_to_heap(etmq, tidc);
> +		ret =3D cs_etm__insert_heap_queue(etmq, timestamp);
>  		if (ret)
>  			goto out;
> -		if (!etmq->on_heap)
> -			goto get_data_block;
>  	}
>  out:
>  	return ret;

[Severity: Medium]
Does this stall earlier queues and drop queues from the min-heap when
decoding with non-virtual hardware timestamps (etm->has_timestamps &&
!etm->has_virtual_ts)?

On PERF_RECORD_AUX, cs_etm__insert_heap_all() decodes each queue's initial
CS_ETM_DISCONTINUITY packet.  In cs_etm_decoder__reorder_packet(), the
discontinuity branch leaves decoder->timestamp at 0 and defers the
searched-ahead timestamp to decoder->pending_packet, so every queue enters
etm->heap with ordinal 0.  Once a queue with an earlier AUX collection time
pops its discontinuity packet and re-enters the heap with a non-zero
CoreSight timestamp, any unpopped queue whose etmq->buffer->time >=3D
timestamp remains at the top of the min-heap at ordinal 0 and causes
cs_etm__pop_heap() to break out of the loop, blocking the earlier queue
until timestamp reaches the later queue's buffer->time.

Also, cs_etm__pop_heap() passes timestamp rather than MAX_TIMESTAMP to
cs_etm__insert_heap_queue().  When a queue advances to its next AUX buffer
with etmq->buffer->time > timestamp in non-virtual timestamp mode,
cs_etm__insert_heap_queue() returns 0 without re-inserting the queue into
etm->heap, dropping it from cross-queue timestamp ordering until the next
PERF_RECORD_AUX event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D29

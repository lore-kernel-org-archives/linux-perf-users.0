Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020700;
	b=aMOph0A05lTwMZdi4BubhcAeYm9tvuY29wt30yvVcP0w1tG0M1VsEGLriMbDBfyanC8e
	 QWrsNIl1EvQNJgdcMIiBjggfOo1GhIJHNLURkFqNhe8K6a6dMY554WihYSPAptpNqSmM7
	 AdlBogcE0edlZdEgO77EP0Ci4bElqXXEDfjkul5ux1MhUSnF9/JnFz2Wr5eAyKCtrdl8W
	 6r6iZH5o037gfyAR76QM9hdyLY1rHWox4KJRJvqTC9INAVvNouI49A1AGg5xGAyBDXVi1
	 J9wKFQznSndwJ+nuVkUjo1OdXy0wdvwHUPPv9r9BejBeixknfmtQwtwJGRKrMrDKxwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020700;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UU3gVRa9AzsXNLVmtATgttxJBxhVTwt6Q9AlxzreP9c=;
	b=zp/5BTO2qtE31qFAewFWRYAaqvgLtanul4ZA+CTrawz3lTwdEj+UJUjQJzZDhDUMAjbW
	 2r6TgEOdjUCaEitD6dI2YVOfGFuI1WqXc7H3Yyet5FAxnsoBMuX2ORFeEE4kDMMDJuzx2
	 o8DQjG1BmXmVhaa4rfBmpPH3va+S0hfQq4CEQdlDHojmQ6klyQnVEN31/uUD2gr3ApI9n
	 FyO8FTLRdTEpEEgOczdRZtoIJQ3NDg6mvgeGln5ggB1HHyLeLlRSAb/4oSCBTbHY0mDel
	 ZZFQYWc59m7yZeavmGe4vy3BOqKo4djAHiMHweHvqpqR6rBgF988Yo9vqkbUSrwwBWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxKtZezj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7860A2633
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxKtZezj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823141F000C8;
	Wed, 18 Nov 2026 16:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020700;
	bh=UU3gVRa9AzsXNLVmtATgttxJBxhVTwt6Q9AlxzreP9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bxKtZezjjw1oIJUE1WhmN35eXrYplGMao/jSy6N2R4OT9TPf23ByL/KGRGZlhKeae
	 bCqHOSt3nyLz1xzFFsP1O+t+sIYuP2O2VSeh2zfMIvEkC53298Oji8D64Xz4ExrHzg
	 YyjOnzrh3ZEh+5UX8cVqHu34mGpAmSNw1QlZuGgidf3WBtNUFHIF035LTsK2jUn6Zm
	 aNI6h8hdTsStDrOYkPwvPjrqkPM3EBbNAU7OtrraeG7qDu/cKP0QGbT8Pk//bscUVQ
	 ZbuMBoMFL0f7EzdYt7/clcDSnce9LA+wjC1LWdFT6FDpUeHd9TsritdcCih1b54i5z
	 U1WVKuLz0eVww==
Message-ID: <sashiko-outbox-221567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/34] perf cs-etm: Use time from Perf samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-15-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-15-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:51:38 +0000
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
- [Medium] perf cs-etm: uninitialized pointer deref in
  cs_etm__queue_aux_fragment()
- [Medium] perf cs-etm: unvalidated (u64)-1 sample time in
  cs_etm__queue_aux_fragment()
--

commit 3c88e19ea9cd0c9b777217d6c7decbf883a6a671
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Use time from Perf samples

This commit records the sample timestamp from each PERF_RECORD_AUX event on
its auxtrace_buffer and uses it in place of latest_kernel_timestamp when
virtual trace timestamps are unavailable or disabled.  It also replaces
timeless_decoding with has_timestamps.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 4252d25c991d8..ca3878a3b74e0 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1625,10 +1637,14 @@ static inline u64 cs_etm__resolve_sample_time(str=
uct cs_etm_queue *etmq,
>  	struct cs_etm_auxtrace *etm =3D etmq->etm;
>  	struct cs_etm_packet_queue *packet_queue =3D &tidq->packet_queue;
> =20
> -	if (!etm->timeless_decoding && etm->has_virtual_ts)
> +	if (etm->has_virtual_ts)
>  		return packet_queue->cs_timestamp;
> -	else
> -		return etm->latest_kernel_timestamp;
> +
> +	/*
> +	 * Timestamps were disabled or no virtual TS. All samples are assigned
> +	 * the kernel time from when the trace block was emitted.
> +	 */
> +	return etmq->buffer->time;
>  }

[ ... ]

> @@ -1897,10 +1913,7 @@ static int cs_etm__synth_events(struct cs_etm_auxt=
race *etm,
>  	attr.sample_type =3D evsel->core.attr.sample_type & PERF_SAMPLE_MASK;
>  	attr.sample_type |=3D PERF_SAMPLE_IP | PERF_SAMPLE_TID |
>  			    PERF_SAMPLE_PERIOD;
> -	if (etm->timeless_decoding)
> -		attr.sample_type &=3D ~(u64)PERF_SAMPLE_TIME;
> -	else
> -		attr.sample_type |=3D PERF_SAMPLE_TIME;
> +	attr.sample_type |=3D PERF_SAMPLE_TIME;
> =20
>  	attr.exclude_user =3D evsel->core.attr.exclude_user;
>  	attr.exclude_kernel =3D evsel->core.attr.exclude_kernel;

[ ... ]

> @@ -3076,15 +3089,6 @@ static int cs_etm__process_event(struct perf_sessi=
on *session,
>  	case PERF_RECORD_SWITCH:
>  		return cs_etm__process_switch(etm, sample);
> =20
> -	case PERF_RECORD_AUX:
> -		/*
> -		 * Record the latest kernel timestamp available in the header
> -		 * for samples so that synthesised samples occur from this point
> -		 * onwards.
> -		 */
> -		if (sample->time && (sample->time !=3D (u64)-1))
> -			etm->latest_kernel_timestamp =3D sample->time;
> -		break;
> =20
>  	default:
>  		break;

[Severity: Medium]
Does dropping the sample->time !=3D (u64)-1 check propagate (u64)-1 into
synthesized samples when PERF_SAMPLE_TIME is not set on the cs_etm evsel?

__evsel__parse_sample() initializes sample->time to (u64)-1 and only
updates it when PERF_SAMPLE_TIME is present in sample_type.  For
recordings without PERF_SAMPLE_TIME (such as perf record --no-timestamp)
decoded without virtual timestamps, cs_etm__queue_aux_fragment() now
stores (u64)-1 in buffer->time and cs_etm__resolve_sample_time() assigns
it to every synthesized sample, which produces bogus timestamps in perf
script and causes ordered_events__queue() to reject perf inject --itrace
output with -ETIME.

[ ... ]

> @@ -3287,6 +3274,7 @@ static int cs_etm__queue_aux_fragment(struct perf_s=
ession *session, off_t file_o
>  		/* Old per-thread files have no CPU (before v6.4) */
>  		int queue_idx =3D sample->cpu =3D=3D (u32)-1 ? 0 : sample->cpu;
>  		struct cs_etm_queue *etmq =3D cs_etm__get_queue(etm, queue_idx);
> +		struct auxtrace_buffer *buffer;
> =20
>  		if (!etmq)
>  			return -EINVAL;
> @@ -3306,10 +3294,12 @@ static int cs_etm__queue_aux_fragment(struct perf=
_session *session, off_t file_o
>  		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64
>  			  " tid: %d cpu: %d\n", frag_size, frag_start, sample->tid, sample->c=
pu);
>  		err =3D auxtrace_queues__add_event(&etm->queues, session, &auxtrace_fr=
agment,
> -						 file_offset, NULL);
> +						 file_offset, &buffer);
>  		if (err)
>  			return err;
> =20
> +		buffer->time =3D sample->time;

[Severity: Medium]
Can buffer->time =3D sample->time dereference an uninitialized pointer when
CPU filtering (-C / --cpu) is active?

auxtrace_queues__add_event() -> auxtrace_queues__add_buffer() returns 0
without writing to *buffer_ptr when the AUX record's CPU is excluded by
filter_cpu():

tools/perf/util/auxtrace.c:auxtrace_queues__add_buffer() {
	if (filter_cpu(session, buffer->cpu))
		return 0;
    ...
}

Because buffer is not initialized to NULL and checked before writing
buffer->time, any PERF_RECORD_AUX event for a filtered-out CPU
dereferences the uninitialized stack pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D15

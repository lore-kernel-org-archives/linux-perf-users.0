Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954C7359A65
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016384; cv=none; b=dELhHed+LkbJW0TBlOp2EICnNdyP4hSddr177lO1NTPAlTjLF5gn17246+UHpoig6Z1/rRTGXaJ1NUorr78wF9jw03bLt/Np5zoE2HU6xCRZ7RDSuzsxA4e0O1vjhz1Pv/Z16Sb785jCgIJCCc5QY/LmE0k+MObG5RXdkKTVjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016384; c=relaxed/simple;
	bh=deBy3hMXqhBwwPR5pLwrpIAbN23736OASFvjBB0Z04c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lddbQ9Oi/827AsywU4J3GB503LtjdaTjD86J04huAuMatfYZgRTd4DPR623cSYfCh5e4Re+WSiuqQFVqg5Q2eTheSJ7aCckk1q2TAB7lIeLsFyEB46TCg95FF6zdvcd2dBiFjbUSkZPNOy3jC/pb54Fn9/mNBxQmQQMsgmBXME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEt857gj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEt857gj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A3F1F00893;
	Tue,  9 Jun 2026 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781016383;
	bh=i4CTH0jZv+ji3AnEm5T4cVAOpVfu4XCTqq9oVJO6Zow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aEt857gj2NU/kIvPZf1mXLySN32NBdB62By8SS3LoLa2bqjZwRNaYT5SEgF2Vwofm
	 Y94XDtQEz74HtR/gopWPhs4Ycd+WpSEKAtBNvBxKLc1IJXNyC3ewdTLfQ6++ZZWJZa
	 rBxH3SdDOxriA3OtbL8EXvub0nNBOQnv73Cnoeo4qeADEMRBWCP1GvBPG+1SvPX8KV
	 YRpeZMMRvS3iKeGdP4zs+br5FALbuBYm1+RWm+MFm8Fu0SwsZDMCYDuV6ZMJ6ty/Hc
	 U26OWF6ApMAMaWwz2b0V4jF3k/YwyrIJBW5WOATMC8lOEcHLQ5Dlf++ObskMhbXZdi
	 nu638PGzQ4gWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/19] perf cs-etm: Queue context packets for
 frontend
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-1-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-1-44f9fb9e5c42@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 14:46:22 +0000
Message-Id: <20260609144623.11A3F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The dummy branch sample generated for CS_ETM_DISCONTINUITY packe=
ts will now be misattributed to the host's user space (PERF_RECORD_MISC_USE=
R) even when tracing a guest, because its `el` field is hardcoded to `ocsd_=
EL_unknown`.
--

commit fd2f91c5aeb50268fe7509b8158aa03f25f00def
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Queue context packets for frontend

This commit adds CS_ETM_CONTEXT packets to keep context changes ordered with
the packet stream and avoid mismatches when synthesizing samples from
cached packets. It separates frontend and backend memory access functions
and relies on the packets' exception level and thread ID directly, rather
than tracking them separately in the traceid_queue.

Closes: https://lore.kernel.org/linux-perf-users/20260515021135.1729028-1-a=
aupov@meta.com/

> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf=
/util/cs-etm-decoder/cs-etm-decoder.c
> index dee3020ceaa91..26940f1f1b0bf 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -402,6 +402,8 @@ cs_etm_decoder__buffer_packet(struct cs_etm_queue *et=
mq,
>  	packet_queue->packet_buffer[et].flags =3D 0;
>  	packet_queue->packet_buffer[et].exception_number =3D UINT32_MAX;
>  	packet_queue->packet_buffer[et].trace_chan_id =3D trace_chan_id;
> +	packet_queue->packet_buffer[et].el =3D ocsd_EL_unknown;
> +	packet_queue->packet_buffer[et].tid =3D -1;

[ ... ]

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 40c6ddfa8c8d9..5e92359f51a7c 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1649,15 +1685,15 @@ static int cs_etm__synth_branch_sample(struct cs_=
etm_queue *etmq,
> =20
>  	event->sample.header.type =3D PERF_RECORD_SAMPLE;
>  	event->sample.header.misc =3D cs_etm__cpu_mode(etmq, ip,
> -						     tidq->prev_packet_el);
> +						     tidq->prev_packet->el);

[Severity: Medium]
Does this code misattribute dummy branch samples generated for
CS_ETM_DISCONTINUITY packets?

When cs_etm_decoder__buffer_packet() creates a new packet, it initializes
packet_buffer[et].el to ocsd_EL_unknown. Because CS_ETM_DISCONTINUITY
packets do not update this field, they retain ocsd_EL_unknown as their
exception level.

Previously, tidq->prev_packet_el tracked the exception level across these
events. By removing tidq->prev_packet_el and relying directly on
tidq->prev_packet->el, cs_etm__cpu_mode() will receive ocsd_EL_unknown
when processing a discontinuity.

Since cs_etm__last_executed_instr() returns an ip of 0 for discontinuities,
cs_etm__cpu_mode() evaluates the combination of ocsd_EL_unknown and ip=3D0 =
as
PERF_RECORD_MISC_USER.=20

Could this incorrectly attribute discontinuities occurring inside guest VMs
to the host's user space, polluting the perf data with inaccurate statistic=
s?

>  	event->sample.header.size =3D sizeof(struct perf_event_header);
> =20
>  	/* Set time field based on etm auxtrace config. */
>  	sample.time =3D cs_etm__resolve_sample_time(etmq, tidq);
> =20
>  	sample.ip =3D ip;
> -	sample.pid =3D thread__pid(tidq->prev_packet_thread);
> -	sample.tid =3D thread__tid(tidq->prev_packet_thread);
> +	sample.pid =3D thread__pid(tidq->frontend_thread);
> +	sample.tid =3D thread__tid(tidq->frontend_thread);
>  	sample.addr =3D cs_etm__first_executed_instr(tidq->packet);
>  	sample.id =3D etmq->etm->branches_id;
>  	sample.stream_id =3D etmq->etm->branches_id;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-james-cs-c=
ontext-tracking-fix-v4-0-44f9fb9e5c42@linaro.org?part=3D1

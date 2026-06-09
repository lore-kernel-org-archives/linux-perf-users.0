Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C33FFAC1
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016817; cv=none; b=XYkt+dYOWmJPhGouSdgwsq1/IDY2CdsZwtDiqlySBp4eXugsDrw+qJ6Iy/kPpTTccPsXzlyo7S3NmO24pMJLbbBpSbC3DFDBB5rmdkuYDZUVbW8yE3BdhaU8LPfTxKkQ0eLNm7UKdXVeZHChbQZ5vpIHQxZptFNN8xc49Fe2Uw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016817; c=relaxed/simple;
	bh=y+/mYP3N8D0bGqyGJvHzJbSH9wcOWomXXshmplHAeC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UxptbeX6e7oyAvu9lGPiFxFQQkLivwEFcZkffjXZLzm9d/RbwGkQTC9vL3+uzNTOmap1Dg/BLObj1ubIUwPsvzpvtZSWGNV5tqC2ZFmtBEpIh3+aD8bYAh4jnFddrgsNPUFYqLlSaqJRqtLJcKD3gAu76WHj5st8ag1DWZBTLXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWiCWM0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWiCWM0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DB11F00893;
	Tue,  9 Jun 2026 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781016816;
	bh=tfZmMN0wuOGZW/0rKEwZoEgLjfvKtRVILEhmCG8t1i4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gWiCWM0/tEKckU0zrFEI7FJ3goGQ+ySjHLezGew8K6pn48sEybaNwOnXJztsppQxX
	 E8swgT1iHBOSA153m4Y5vB2sbXxBm8xRPFXLeMO3eFDXiUv15B8OgS8c+PA7lxAifi
	 G8GyMUB7eWFXHDWhJjufYSuXnUVPQ1LNfVzXTak5nMmdu4IWbJLq0+JvcNHglJ/B8H
	 3WlB2l64NAPXmRPY1MEs3oo0kroPkSCrqSOMPgzgobv43LcFeRLTBZvCqF4q9f6ybU
	 JoHHd8MWFfK5MvGgZp8AFahWrJnCPJgYP8vwHdx0zrckCotpFjvX0tfQ/PcncmAn/e
	 Vbxp+anSyreIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/19] perf test cs-etm: Remove asm_pure_loop test
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-7-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-7-44f9fb9e5c42@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 14:53:34 +0000
Message-Id: <20260609145335.A5DB11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removing `tidq->prev_packet_thread` causes samples belonging to =
`prev_packet` to be attributed to the wrong thread if a context packet was =
processed in between.
--

commit fd2f91c5aeb50268fe7509b8158aa03f25f00def
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Queue context packets for frontend

PE_CONTEXT elements update the context ID and exception level, but the
decoder may still have prior packets cached for frontend processing.
Updating the context immediately in the decoder backend can make those
cached packets get consumed with the wrong thread or EL state. Add a
CS_ETM_CONTEXT packet carrying the TID and EL to the frontend.

Closes: https://lore.kernel.org/linux-perf-users/20260515021135.1729028-1-a=
aupov@meta.com/

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

[Severity: Medium]
If a context packet was processed just before this, frontend_thread has
already been updated to the new thread. Does using frontend_thread here
instead of tracking the thread that actually executed prev_packet cause the
branch sample to be attributed to the wrong thread?

>  	sample.addr =3D cs_etm__first_executed_instr(tidq->packet);
>  	sample.id =3D etmq->etm->branches_id;
>  	sample.stream_id =3D etmq->etm->branches_id;

[ ... ]

> @@ -1959,7 +1993,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>  		addr =3D cs_etm__last_executed_instr(tidq->prev_packet);
> =20
>  		err =3D cs_etm__synth_instruction_sample(
> -			etmq, tidq, addr,
> +			etmq, tidq, tidq->prev_packet, addr,
>  			tidq->period_instructions);

[Severity: Medium]
When flushing the trace, an instruction sample is generated for prev_packet.
However, cs_etm__synth_instruction_sample unconditionally uses
frontend_thread. If a context packet was the last processed packet, could
this lead to misattribution of the sample to the new thread?

>  		if (err)
>  			return err;

[ ... ]

> @@ -2469,6 +2501,19 @@ static int cs_etm__process_traceid_queue(struct cs=
_etm_queue *etmq,
>  			 */
>  			cs_etm__sample(etmq, tidq);
>  			break;
> +		case CS_ETM_CONTEXT:
> +			/*
> +			 * Update context but don't swap packet. Keep the
> +			 * previous one for branch source address info, if
> +			 * tracing the kernel the context packet will be emitted
> +			 * between two ranges.
> +			 */
> +			ret =3D cs_etm__etmq_update_thread(etmq, tidq->packet->el,
> +							 tidq->packet->tid,
> +							 &tidq->frontend_thread);

[Severity: Medium]
When CS_ETM_CONTEXT updates frontend_thread without swapping packets, won't
prev_packet still contain the execution range of the old thread? Since the
frontend_thread is updated immediately, could any subsequent samples
generated for prev_packet be attributed to the wrong thread?

> +			if (ret)
> +				goto out;
> +			break;
>  		case CS_ETM_EXCEPTION:
>  		case CS_ETM_EXCEPTION_RET:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-james-cs-c=
ontext-tracking-fix-v4-0-44f9fb9e5c42@linaro.org?part=3D7

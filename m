Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040E282F35
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016758; cv=none; b=g25HdJsH+3ThTNSNjqFSisirG6hPcBJYkvA3mGoaWpUMIu8NTqX5uMnJiW9HbVMubu94hjc9hv1KBAFBdNP86TpNmaHsMALFv4SYxmyGNiG7NP3NWMdYpgCwoRqCFG2zDxXw18xr8MWfNeCr5rQ7QK5CUqRxjU0aEa4U9wB4vQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016758; c=relaxed/simple;
	bh=x+dYfS/3r6Fj1P1qrV5g+DfMuKpRCmbsus7wDydAT8o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M123IAazGnKsKqOMFyvWVPhvoXKyURNTQBaLbFXkgK6jtyM+Gx6gXmQBUezKk9Osbwxzhlh6OXJquWSAeBgBRnBhLTGuBT3Qac+bA6rureb4/spRfndRmx4lLs/VRHFxcFiHhwoWHtBtESxxF0vq1z86ly/0K9OnDtBwlOEKzLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxbsz+kM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxbsz+kM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01F51F00893;
	Tue,  9 Jun 2026 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781016757;
	bh=Jog/rRPkDEyIBXfvGEiISJ1r9V52fsbjrVEcYwGytak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gxbsz+kMyWLv1410mCF9KsukjY1qU75XUDANCyKG7e+yoSUH0xwda5wFY2mFdWTjm
	 9fuRjOBqRdMO0zvD22tEuXk2M39CGXAEfb0zBv8mQPE6Ci4Il63afNdEsYSzwAxv6s
	 Z+j+X4JIcYagwLfyYs8NY7uLCAqJ951U5FoA6hr5Dv5QgcV6Eql6iGVlBi+AN34w/U
	 quv3RAyoPr2yi1xkUJdlbOnoxDrXp0Q8HAvp0eXsHtk+//Xxc5+sRh01OJRtYKTOcF
	 rMkwgp5JndLfjLgkEdaH+nhMBGREe3ZryQ4nUps4Gx0Q+glkCMfFDpIJmdY9PSyJDX
	 +FJIHHiUhHwpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/19] perf test cs-etm: Replace unroll loop thread
 with deterministic decode test
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-6-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-6-44f9fb9e5c42@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 14:52:35 +0000
Message-Id: <20260609145236.E01F51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect thread attribution for branch samples spanning context=
 switches.
--

commit fd2f91c5aeb50268fe7509b8158aa03f25f00def
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Queue context packets for frontend

PE_CONTEXT elements update the context ID and exception level, but the
decoder may still have prior packets cached for frontend processing.
Updating the context immediately in the decoder backend can make those
cached packets get consumed with the wrong thread or EL state.

Link: https://lore.kernel.org/linux-perf-users/20260515021135.1729028-1-aau=
pov@meta.com/

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
Will this correctly attribute branch samples spanning context switches?

When a CS_ETM_CONTEXT packet marks a context switch between two execution
ranges, the branch connecting them is executed by the outgoing thread.

Because the incoming thread replaces the previous thread in
tidq->frontend_thread before branch synthesis, doesn't this inaccurately
attribute the branch execution to the incoming thread instead of the actual
executing outgoing thread?

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
If the CS_ETM_CONTEXT packet updates the frontend_thread here to the incomi=
ng
thread while preserving the prev_packet, won't the subsequent branch synthe=
sis
wrongly use this updated thread for the old packet?

> +			if (ret)
> +				goto out;
> +			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-james-cs-c=
ontext-tracking-fix-v4-0-44f9fb9e5c42@linaro.org?part=3D6

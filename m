Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FED22ACFA
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482741; cv=none; b=ODvOpLRafAwhhVrzLiZmyyZbn1S7Z7O2oEJw1tWbAdeJeKoVy6OJ6HracrKumNZWSgrL9ar0JXpmsUOd1D0YOZ0109u5kABng11WpHQulnRR3THSKk2oY4hjyKTYpJxBfs/adrzdygQuD/HsH5ZT5oBJiH1+EnjkH2o4Oo8S6Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482741; c=relaxed/simple;
	bh=T8/dcI5V9+LVACQRaGJJ016lBXv6WQ7HPvZoEUNSxxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cT+52h53PO+hu1VnxU4uj6JKpWtbFwJyJ73mY+spoKjKkF3g5U2pFKJreN3k411Lwe3Vdd8DI/6oHF16urk9JmMramnTwErYj6nU0uPkmsYziGfGe6oBKg1kidP5CE/OfFAFYzMyp6H+eD4jZGjT+Nj0ELpkHf9O0YxFhbVxoy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=METGR8cW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="METGR8cW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633D61F00893;
	Wed,  3 Jun 2026 10:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780482739;
	bh=avpR8HPfluqMaoXK4kJFlGMgUe6zS39pd6f3nm8Cf2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=METGR8cWWrU2jxOhPudQk4llFphO1HBTbzJ05qIyheHuxupDQT13k9BX3URTS2J8c
	 u4OohNtM1inuhEGtAx5sabDzMVS9rODYnMzdVzz4Tbb4sFRW/kWc4L8DShLS5wIQtq
	 Maz3MhCgzXLFZWOCOxxKp5qAoe5Y8yVsMN5uCguvxlZC2sYf4CG+ki6smyAsVjcUUr
	 Vvje3jhIBYHXVVbcouUgaRToBGC6Ccmj529GjZ7GMTD9odFNLTKTYHSGFHO6kAGXm3
	 UPbaxV+jOMpjO4rl2YHnxPlsVJVSmqEBUj4nDWQAu4rOqKtq8JtOGDQKRvWHIwd3a9
	 +ytaR7G8PT9Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/19] perf cs-etm: Queue context packets for
 frontend
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-1-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-1-c392945d9ed5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:32:19 +0000
Message-Id: <20260603103219.633D61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Removing `prev_packet_thread` breaks branch sample cross-context=
 instruction decoding when transitions cross machine boundaries (e.g., hype=
rvisor to guest).
- [Medium] `cs_etm__synth_instruction_sample()` ignores its new `packet` ar=
gument and hardcodes `tidq->packet`, causing instruction copying to fail du=
ring trace flush.
--

commit 588f2ae34f926c74679fbf78b98515da3192e351
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Queue context packets for frontend

This commit adds a CS_ETM_CONTEXT packet carrying the TID and exception
level to the frontend, keeping context changes ordered with the packet stre=
am.
It separates the memory access functions for the frontend and decoder backe=
nd,
and removes tracking for the previous packet's thread.

Link: https://lore.kernel.org/linux-perf-users/20260515021135.1729028-1-aau=
pov@meta.com/

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 40c6ddfa8c8d9..ce570913669c1 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1158,6 +1151,30 @@ static u32 cs_etm__mem_access(struct cs_etm_queue =
*etmq, u8 trace_chan_id,
>  	return ret;
>  }
> =20
> +static u32 cs_etm__frontend_mem_access(struct cs_etm_queue *etmq,
> +				       struct cs_etm_traceid_queue *tidq,
> +				       struct cs_etm_packet *packet,
> +				       u64 address, size_t size, u8 *buffer)
> +{
> +	return __cs_etm__mem_access(etmq, address, size, buffer, 0, packet->el,
> +				    tidq->frontend_thread);
> +}

[Severity: Medium]
Will this mix the previous packet's exception level with the newly updated
frontend thread?

When tracing virtualized environments, an exception return from a hypervisor
to a guest causes a machine context change. The decoder emits a context
packet which updates the frontend thread to the guest thread before
generating the branch sample for the hypervisor's execution range.

By passing the newly updated frontend thread to the memory access function
while using the previous packet's exception level, the map lookup could
look up the host kernel address in the guest's map group, causing the
lookup to fail and result in missing instruction bytes.

[ ... ]

> @@ -1579,6 +1614,7 @@ static inline u64 cs_etm__resolve_sample_time(struc=
t cs_etm_queue *etmq,
> =20
>  static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  					    struct cs_etm_traceid_queue *tidq,
> +					    struct cs_etm_packet *packet,
>  					    u64 addr, u64 period)
>  {
>  	int ret =3D 0;

[ ... ]

> @@ -1604,7 +1640,7 @@ static int cs_etm__synth_instruction_sample(struct =
cs_etm_queue *etmq,
>  	sample.cpu =3D tidq->packet->cpu;
>  	sample.flags =3D tidq->prev_packet->flags;
>  	sample.cpumode =3D event->sample.header.misc;
> =20
> -	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
> +	cs_etm__copy_insn(etmq, tidq, tidq->packet, &sample);

[Severity: Medium]
Does this ignore the newly added packet argument?

The function signature was updated to accept a packet argument so it can
process the previous packet during a flush. However, the function body
still hardcodes tidq->packet for sample.cpu and in the call to
cs_etm__copy_insn().

When called from a flush, tidq->packet is typically a discontinuity or
empty packet. This could cause cs_etm__copy_insn() to bail out early and
silently drop the instruction bytes for the flushed sample.

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
Does the removal of the previous packet thread tracking break cross-context
branch samples?

By using the newly updated frontend thread instead of the previous packet
thread here, it appears a branch sample from the previous context could be
misattributed to the new thread when transitions cross machine boundaries.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-james-cs-c=
ontext-tracking-fix-v3-0-c392945d9ed5@linaro.org?part=3D1

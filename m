Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1013F58EB
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796416; cv=none; b=LlRo3mfcjhzLT7DTRzKPUDk4PJKIuceCfUAYNM2E9Zdb+uCA4IxcXHtdbAgdVxqr08ccupsahqikyD9+0uBYlwHfKHhIYDx9Lspg+TCbu8G33yzL/b5WaJdiHqlUJ/+viXIYIBwnOWwJSfEf1PWZ2quFI6FVzh6oGmnppcfFA5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796416; c=relaxed/simple;
	bh=xkA8iD74FBcQMvYlgirbV7TOcamdJ4oK/cEhHER7XzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cGyyZ+/+/9ua7NXJL4UkK/9sJ81ALD/wUR9+GypBovdQHnGk/AB9kb90a5BwufWfxYgrCAAVDQ3gcjjIL5WWRmvgoOqPOBGn2KR1+udeY+eUTqxTWIOeX94bI4Ahy3uCjfPZ3VI4/ksC+4AoDp58XeZqI8cGJJ5OVfXMfocDOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWaDsN5E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWaDsN5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34971F000E9;
	Tue, 26 May 2026 11:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779796409;
	bh=BGAIrqDVvaH6tC3gSAhvwugU4mlex5p23X20E51lQlI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZWaDsN5E7JnRiRKQPT2lkzZqrM86FMzqXzz57idyBg6DSIaxdwVOrX04VDnDcdb7+
	 2BMsxfvlo6jkgJQYiQBDq0XeXaFIduDJjp8QbPUq9MNT/wltwM4d2oBpF/E9sdp3rb
	 dkljisY+D7mDyQP7pqEzQc98p8VlwhZUK9gX490Gm7pezPBa76xwJQqIZo6HIS6Ui2
	 C+zGIk3h7mjYvW3hUjad4qAUDNJ+A59W9J8L/ZMkiPjVjhkvWZONqzoyzOUjKteNVj
	 7RKL6p+2vJwjp8Qm//Ox2gqfv0wNQd6LePAXxb++HR6TIc33CcC6isGLhDDDJfT2hM
	 YE/ZcET/L06tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf cs-etm: Queue context packets for frontend
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526-james-cs-context-tracking-fix-v1-1-ebd602e18287@linaro.org>
References: <20260526-james-cs-context-tracking-fix-v1-1-ebd602e18287@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 11:53:28 +0000
Message-Id: <20260526115328.E34971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] CS_ETM_CONTEXT packets fail to act as branch sample boundaries bec=
ause they are not swapped into prev_packet, causing dead code, missing boun=
daries, and misattributed samples.
- [High] Helper functions do not handle CS_ETM_CONTEXT, which would lead to=
 invalid address reads and leakage of CS_ETM_INVAL_ADDR if context packets =
were correctly processed as boundaries.

Pre-existing issues:
- [High] Dereferencing a potentially NULL thread pointer during memory acce=
ss under memory pressure.
--

commit a4e7b7904659c1a9053158e048dc4b6daf7453f5
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Queue context packets for frontend

Add a CS_ETM_CONTEXT packet carrying the TID and EL to the frontend to keep
context changes ordered. Separate memory access functions for decoding and
frontend. Treat context packets as boundaries for branch sample generation.

Reported-by: Amir Ayupov <aaupov@meta.com>
Closes: https://lore.kernel.org/linux-perf-users/20260515021135.1729028-1-a=
aupov@meta.com/

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1083,9 +1083,10 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *et=
mq, u64 address,
>  	}
>  }
> =20
> -static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_i=
d,
> -			      u64 address, size_t size, u8 *buffer,
> -			      const ocsd_mem_space_acc_t mem_space)
> +static u32 __cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan=
_id,
> +				u64 address, size_t size, u8 *buffer,
> +				const ocsd_mem_space_acc_t mem_space,
> +				bool is_decoder)
>  {

[ ... ]

> +	if (is_decoder) {
> +		el =3D tidq->decode_el;
> +		thread =3D tidq->decode_thread;
> +	} else {
> +		el =3D tidq->frontend_el;
> +		thread =3D tidq->frontend_thread;
> +	}

[ ... ]

>  	map__load(al.map);
> =20
> -	len =3D dso__data_read_offset(dso, maps__machine(thread__maps(tidq->thr=
ead)),
> +	len =3D dso__data_read_offset(dso, maps__machine(thread__maps(thread)),
>  				    offset, buffer, size);

[Severity: High]
This isn't a bug introduced by this patch, but if the fallback allocation in
machine__idle_thread() fails under memory pressure and returns a NULL point=
er,
could thread__maps(thread) cause a null pointer dereference here?

[ ... ]

> @@ -1874,7 +1920,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>  		bool generate_sample =3D false;
> =20
>  		/* Generate sample for tracing on packet */
> -		if (tidq->prev_packet->sample_type =3D=3D CS_ETM_DISCONTINUITY)
> +		if (tidq->prev_packet->sample_type =3D=3D CS_ETM_DISCONTINUITY ||
> +		    tidq->prev_packet->sample_type =3D=3D CS_ETM_CONTEXT)
>  			generate_sample =3D true;

[Severity: High]
If a context packet were correctly swapped into prev_packet, generate_sample
would be true and cs_etm__synth_branch_sample() would be called.

Looking at cs_etm__synth_branch_sample(), it calls
cs_etm__last_executed_instr(tidq->prev_packet), which doesn't seem to handle
context packets and would return CS_ETM_INVAL_ADDR. Additionally,
cs_etm__copy_insn() doesn't appear to exempt context packets.

Could this lead to invalid address reads and out-of-bounds memory accesses?
Do we need to add exemptions for context packets in these helper functions
similar to how we handle discontinuity packets?

[ ... ]

> @@ -2451,6 +2499,9 @@ static int cs_etm__process_traceid_queue(struct cs_=
etm_queue *etmq,
>  			 */
>  			cs_etm__sample(etmq, tidq);
>  			break;
> +		case CS_ETM_CONTEXT:
> +			cs_etm__etmq_set_frontend_tid_el(etmq, tidq);
> +			break;
>  		case CS_ETM_EXCEPTION:
>  		case CS_ETM_EXCEPTION_RET:

[Severity: High]
Because the context packet case breaks out of the switch here, we never rea=
ch
the cs_etm__packet_swap() call at the end of cs_etm__sample().

Does this mean the context packet is overwritten on the next iteration and
tidq->prev_packet never actually becomes a context packet? If so, this would
make the new boundary check in cs_etm__sample() unreachable dead code.
Should context packets also trigger a packet swap?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-james-cs-c=
ontext-tracking-fix-v1-0-ebd602e18287@linaro.org?part=3D1

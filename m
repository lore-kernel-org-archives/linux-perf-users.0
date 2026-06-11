Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291BA3A75A6
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190690; cv=none; b=Qx8UTn7TybIvI4orBzkYRleww4G67ZIuXFVKeZWTn2re/ujr4DMBKGNgJqoD00TE0fMwdueG6CS+e113QDCQW8PWDmex3R79sEDysVvG3y72yG1BKzKb73Pbx6rlo8YIpMkq0HCz2DsAUAwx3nl0Gk9jb++x7IoPC6eHP0KoQgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190690; c=relaxed/simple;
	bh=3Ed5geoa0X8MXiLiall0jIHqAA3thWNVSdsKi+S4fiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I9cBsVfzWSnqe0s4bTmIWmj8aoQi8GPMYtUIjb1C2bO7A0cWKDF/o2VsZ6XVJrkjeORxhQosmYHuEjy/j0V78rJqt8XsV/Qfzk4LYL39uPzwGKEtboBOFkoBCl0RKcZeyXv52oq7uDIQhqes3egh60aT6Q7UHcsCc9rL3135VTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kd85RP84; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kd85RP84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993C71F00893;
	Thu, 11 Jun 2026 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781190688;
	bh=L4JdWl7aEYDwlFOIJTRGoG8Vy4U2YLii43Todra5TYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kd85RP84ca4mB89U5HRSvA31VwkLHQ5yWupb3LCmG75RlgJNYDshMTtTgJCTqmAqT
	 6m/s1tFrezukUK9kdAs8CyhJTjbh5Zw5crG0c4eEo6QgOisUdLuWNlkM0qqSdEsM7v
	 P9zJ/J+epQAH1aGNlAIRSx5qEIXfh5G0UWvTmwWqo3FGKfEihPlmK/yz3Gvx81knbp
	 ZMYmcGeVhU1vAzp1TfViKXU9NHnLhgICFY89yFiw8Z3wVCHywL40of1SjGE08fVEWn
	 Kdprnh7SUxYiT+i43/Lb+XcITTkbP0a0bchjX1KjRM8g8QZeHOM1l5gD8hE6UVWLzP
	 7jrTGCI2DJPdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/8] perf cs-etm: Support call indentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v8-6-737948584fea@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v8-6-737948584fea@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 15:11:28 +0000
Message-Id: <20260611151128.993C71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cs_etm__packet_swap() is missing the etm->use_thread_stack condi=
tion, which breaks callindent when basic tracing options are disabled.
--

commit 0a18549301f4498325c22df50ff20dde5b1f2489
Author: Leo Yan <leo.yan@linux.dev>

perf cs-etm: Support call indentation

The perf script callindent is derived from call stack in thread context,
CS ETM ignores the requirement for callindent without pushing and poping
call stack.

Enable thread-stack when either itrace thread-stack support or last branch
entries are requested, allocate the branch stack storage accordingly, and
feed taken branches to thread_stack__event() whenever thread-stack state
is needed.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 7069b4990e610..830618763d8b1 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
[ ... ]
> @@ -1545,7 +1547,7 @@ static void cs_etm__add_stack_event(struct cs_etm_q=
ueue *etmq,
>  	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet))
>  		return;
> =20
> -	if (etmq->etm->synth_opts.last_branch) {
> +	if (etmq->etm->use_thread_stack) {

[Severity: Medium]
When callindent is requested but basic synthesis options are disabled
(for example, using --itrace=3De), could cs_etm__packet_swap() fail to
swap the packets?

If etm->use_thread_stack is set, but branches, last_branch, and instructions
are disabled, it appears the packet swap is skipped:

tools/perf/util/cs-etm.c:cs_etm__packet_swap() {
	if (etm->synth_opts.branches || etm->synth_opts.last_branch ||
	    etm->synth_opts.instructions) {
		/*
		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
		 * the next incoming packet.
		 */
		tmp =3D tidq->packet;
		tidq->packet =3D tidq->prev_packet;
		tidq->prev_packet =3D tmp;
	}
}

Would this leave tidq->prev_packet zero-initialized, causing
cs_etm__packet_has_taken_branch() to always return false and break
callindent functionality?

>  		from =3D cs_etm__last_executed_instr(tidq->prev_packet);
>  		to =3D cs_etm__first_executed_instr(tidq->packet);
> =20
> @@ -1554,7 +1556,8 @@ static void cs_etm__add_stack_event(struct cs_etm_q=
ueue *etmq,
>  		/* Enable callchain so thread stack entry can be allocated */
>  		thread_stack__event(tidq->frontend_thread, tidq->prev_packet->cpu,
>  				    tidq->prev_packet->flags, from, to, size,
> -				    etmq->buffer->buffer_nr + 1, false,
> +				    etmq->buffer->buffer_nr + 1,
> +				    etmq->etm->use_callchain,
>  				    tidq->br_stack_sz, 0);
>  	} else {
>  		thread_stack__set_trace_nr(tidq->frontend_thread,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-b4-arm_cs_=
callchain_support_v1-v8-0-737948584fea@arm.com?part=3D6

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753112FB97D
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245518; cv=none; b=XquhCy8sHNRq8OBmpur2a3iF0SgLUDWLgVHL5SFQTfaTOqQt6RDf3Szdk4B+KQ7uIz/69aoi3QidcfMh7IKF1D/3Oy8Ep8txcplOCCHtEzuMBQuCr0yECMKdLjAG47ZXKHKRq0LHIHb/kJQ8sanXCV+N24wgYysPenwqo3XVumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245518; c=relaxed/simple;
	bh=pOQv/kPPr0hb5Uubi/nDVmZ1dSltCbNVebQFObxzInc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AiGHufjHds0/i/Lhz+ulwz/hqlvjD7A0zTUkNX8I+8ZwgkBgznj8Lxx9NmEzpeDrSWiZXRc3yNE+cuLlJsAj8EFwp9idYeI0rBaOb2E3WcFsHt2zeAfDGzKqg76zrct16b3czlfQCQ9eFEIBQ6MRv1aqMqEnsbrqcXWhJayZ7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTgspFsL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTgspFsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77221F000E9;
	Tue, 23 Jun 2026 20:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782245517;
	bh=5scCo+KHHS2AeNF8gRlc3Yqw08UJmgolDUG4PymRalE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lTgspFsLiB+oPmgNgroW80Zsod0k1HBRmImxi+LWrGVShR1GA2+jlHq1Xg41QCAib
	 xoUX/UKlfVzTRLqH6VuMUPgV2phkmZEjmZaczkDOpKFKzlGz0UOSZyKGflwSHbIBp9
	 WiQwoOaRYyjuiqokHfPr0SevVxCS6GNH0vQMAwdVhUgwiJfL2JmQjjAzkqhTG8yYsA
	 EmFvybgTUE4Q/0+3J38mKpHM4uA/GFGDoKCm08BGIOfpIm+4j7i5iO+uRrQCFvwkVe
	 T/hj8j2NvFLYjDOb8WWd1pOeCUQAV6KjxS0yQXDTto5JyaAF4EwZ+6QxEzXQbbbMfT
	 P49q4Nh+icMdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/8] perf cs-etm: Support call indentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v7-6-1ba770c862ae@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v7-6-1ba770c862ae@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:11:56 +0000
Message-Id: <20260623201156.E77221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] cs_etm__packet_swap improperly bypasses packet swapping when only =
thread_stack is requested, breaking call indentation.

Pre-existing issues:
- [High] Incorrect CPU used to fetch the branch stack in `cs_etm__synth_ins=
truction_sample`.
--

commit 75bb53812475ad4dde7bad4012f3997de1cd7ce0
Author: Leo Yan <leo.yan@linux.dev>

perf cs-etm: Support call indentation

This commit enables thread-stack support when either itrace thread-stack
support or last branch entries are requested. It allocates the branch stack
storage accordingly and feeds taken branches to thread_stack__event() to
maintain call depth for branch samples.

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

[Severity: High]
If a user runs perf script -F +callindent and disables other sample types
(for example, using --itrace=3De), etm->synth_opts.thread_stack becomes true
while branches, last_branch, and instructions remain false.

When this happens, does cs_etm__packet_swap() bypass packet swapping?
Looking at cs_etm__packet_swap() in tools/perf/util/cs-etm.c:

	if (etm->synth_opts.branches || etm->synth_opts.last_branch ||
	    etm->synth_opts.instructions) {
		/* Swap PACKET with PREV_PACKET ... */
		tmp =3D tidq->packet;
		tidq->packet =3D tidq->prev_packet;
		...

If use_thread_stack isn't checked here, tidq->prev_packet remains
zero-initialized, which means cs_etm__packet_has_taken_branch() will always
evaluate to false. Does cs_etm__packet_swap() need to be updated to check
etm->use_thread_stack so that thread_stack__event() can be called properly?

>  		from =3D cs_etm__last_executed_instr(tidq->prev_packet);
>  		to =3D cs_etm__first_executed_instr(tidq->packet);
> =20
[ ... ]
> @@ -1955,7 +1958,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>  	cs_etm__packet_swap(etm, tidq);
> =20
>  	/* Reset last branches after flush the trace */
> -	if (etm->synth_opts.last_branch)
> +	if (etm->use_thread_stack)
>  		thread_stack__flush(tidq->frontend_thread);
> =20
>  	return err;

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem with how the
branch stack is fetched during a trace flush.

In cs_etm__synth_instruction_sample(), the code hardcodes tidq->packet->cpu
instead of using the local packet parameter:

	if (etm->synth_opts.last_branch) {
		thread_stack__br_sample(tidq->frontend_thread,
					tidq->packet->cpu,
					tidq->last_branch, tidq->br_stack_sz);
		...

If cs_etm__flush() calls cs_etm__synth_instruction_sample() with
tidq->prev_packet as the packet argument, and exactly one packet was
processed before the flush, tidq->packet will still hold the initial
zero-allocated prev_packet struct.

Would this cause tidq->packet->cpu to evaluate to 0, resulting in
thread_stack__br_sample() fetching the branch stack for CPU 0 instead of
the actual CPU of the packet?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-b4-arm_cs_=
callchain_support_v1-v7-0-1ba770c862ae@arm.com?part=3D6

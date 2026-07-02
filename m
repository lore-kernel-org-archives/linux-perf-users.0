Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D629136351
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783023082; cv=none; b=DvFVtg+NDeI0YiWoA5cH9Q8KFGy6IofiUVhnmdF6bZsgPKY6QAJpT+0FZitVCk1WLo1GnAH4hfW7soDo9hITmPqI7e8a+VlFA5TkuTSP34i3GxJ2zhKvbg51sfjfV2NDQX5kuPbW5zH3CtsDvl+o0sCXK3q9SNxQmE9U46i0P54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783023082; c=relaxed/simple;
	bh=cnVcVTIrM9iryZ0S0DsrCpL/4oTHFk0d9GYFvJ5W2iw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jsf1D1VfX4EdB3DFss+NSLyGTQNAmQ/W0n6l6CUfTTFny+1XnTu7u94+3K2PtgT0HU8/bpZvCSXpIQ80f5K6aEtQoAztnAs4/ZvnTj2qtoS67JUN8+X3kBA56P81kRbMPkKNDWC0De+PEB5zaV/V3aGpShJ3XxJk8jPYn66Dc+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuDOiXNL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuDOiXNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EB61F000E9;
	Thu,  2 Jul 2026 20:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783023081;
	bh=BTYGAAfXw3/DkUSdxPdhfR5mtktWbamA43GaPWO58G4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YuDOiXNLrdeztrQ0pbTg6Bw9muMc8zzFnkmTpGpIbSK4hfkwDQFdxFeXD35aDe08L
	 oNrUMSGnQ+AAEaI0PLhHt8Xy83uzt2o9bIRnxGJbLBjW92+HQkx/K0y6FJI7sjvljR
	 bjUzjVLzZY6g1c54CWGHgb66DlC2AicxkBi/3VLi5A6xZOU+Pn1rT5BMi4r5VWFD+u
	 FoEEDXjXk1+uyIvHQJW3qQTUipS9FcvFWT2emkpIc68srw+qal6fIHIgqIR/sk6caW
	 Z5aoXYR7L61qzq1QikhCTzSoFstRanIYW1LEZKjEkfzgmy4UjvmcE4JUAHw6OtIf/L
	 Ldk0DN/p1QX9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 7/9] perf cs-etm: Support call indentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260702-b4-arm_cs_callchain_support_v1-v11-7-846abbf600d7@arm.com>
References: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
 <20260702-b4-arm_cs_callchain_support_v1-v11-7-846abbf600d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 20:11:20 +0000
Message-Id: <20260702201121.28EB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Unnecessary branch stack allocation and processing overhead when=
 only callstack tracking is requested

Pre-existing issues:
- [High] NULL pointer dereference when handling allocation failure in cs_et=
m__etmq_get_traceid_queue()
--

commit ea165568a98c0d21041d7e227f70d2a087a6d03d
Author: Leo Yan <leo.yan@linux.dev>

perf cs-etm: Support call indentation

The perf script callindent is derived from call stack in thread context.
This patch enables thread-stack when either itrace thread-stack support
or last branch entries are requested, allocating the branch stack storage
accordingly, and feeding taken branches to thread_stack__event().

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 996317687ce7b..f76648fa67681 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -656,7 +658,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_q=
ueue *etmq,
>  	if (!tidq->prev_packet)
>  		goto out_free;
> =20
> -	if (etm->synth_opts.last_branch) {
> +	if (etm->use_thread_stack) {
>  		size_t sz =3D sizeof(struct branch_stack);
> =20
>  		sz +=3D etm->synth_opts.last_branch_sz *

[ ... ]

> @@ -1572,7 +1574,7 @@ static void cs_etm__add_stack_event(struct cs_etm_q=
ueue *etmq,
>  	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet))
>  		return;
> =20
> -	if (etmq->etm->synth_opts.last_branch) {
> +	if (etmq->etm->use_thread_stack) {
>  		from =3D cs_etm__last_executed_instr(tidq->prev_packet);
>  		to =3D cs_etm__first_executed_instr(tidq->packet);
> =20
> @@ -1581,7 +1583,8 @@ static void cs_etm__add_stack_event(struct cs_etm_q=
ueue *etmq,
>  		/* Enable callchain so thread stack entry can be allocated */
>  		thread_stack__event(tidq->frontend_thread, tidq->prev_packet->cpu,
>  				    tidq->prev_packet->flags, from, to, size,
> -				    etmq->buffer->buffer_nr + 1, false,
> +				    etmq->buffer->buffer_nr + 1,
> +				    etmq->etm->use_callchain,
>  				    tidq->br_stack_sz, 0);

[Severity: Medium]
Does this code unnecessarily allocate and process branch stacks when only
call stack tracking is requested?

When callindent is requested without last branch entries,
synth_opts.thread_stack is true while synth_opts.last_branch is false.

Coupling the allocation of tidq->last_branch and tidq->br_stack_sz to
use_thread_stack rather than synth_opts.last_branch seems like it could
cause thread_stack__event() to perform unneeded branch stack ring buffer
updates on every executed branch.

[ ... ]

This is a pre-existing issue, but looking at cs_etm__etmq_get_traceid_queue=
()
in tools/perf/util/cs-etm.c:

cs_etm__etmq_get_traceid_queue() {
    ...
    inode =3D intlist__findnew(traceid_queues_list, trace_chan_id);
    if (!inode)
        goto out_free;
    ...
out_free:
    ...
    intlist__remove(traceid_queues_list, inode);
    free(tidq);
    ...
}

[Severity: High]
Can this sequence cause a null pointer dereference?

If memory allocation fails inside intlist__findnew(), it returns null into
inode. The code immediately jumps to the out_free label and calls
intlist__remove() with the null inode.

Since intlist__remove() unconditionally attempts to remove the node, this
looks like it would crash when trying to access the internal rb_node.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-b4-arm_cs_=
callchain_support_v1-v11-0-846abbf600d7@arm.com?part=3D7

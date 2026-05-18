Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692371E376C
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779133560; cv=none; b=MTHlE4clJLuYWprePR3+gZDOz1Di1AWy3A5lqmraPko7WX0UJexOkt1FfPsAZ04k7ChXHLVvIjTdHSMTr46GVrKDoAWmlN8cv12Ko1xoQy06NeYoq4FQMqhStC4S7mvDXTm8mL0i2EAc1X8xuggGohjZFfq3eW0wjP2RDDDy6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779133560; c=relaxed/simple;
	bh=jjzG7Ju+bhuupvyKoU2AQ7SMx4Bni/5ACwy1l2PBIlg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S8B53kH5EjqKtufg5+MsClwKXXW0oQMUegrtvNQYhFulE38AuxcJMPNZewbt+bF5ZZT5Lk4ronefqeI3ZOhw/948Tm/iXcnSqvdzgDg/kedu2tz3fLX++6/wHL8z4QLqn43QyEyLaoS9cYac+JbRBCuYako36w9ZMTL1jTIwnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEK9Dkr6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEK9Dkr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D7BC2BCB7;
	Mon, 18 May 2026 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779133560;
	bh=jjzG7Ju+bhuupvyKoU2AQ7SMx4Bni/5ACwy1l2PBIlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fEK9Dkr6rWi7VtC5uB1d018dqB9G8UhzhTJF6nrde26XHJ4FsqeY/amUjThog+vC6
	 H8DmAyrmIsbm3CI4e7asrJbHzMM3LsPubh7Y0NpzBaL5b1io9Qj8gyePadPqqfyqyC
	 W4jrlgmbaR8o3hQ2EZ6JcNbrmEpbqoCDd+QQJAHNlDZXj7ThsQxOAL7H09tx2Ob6wO
	 XhL6aeIMlXJOKpKrnC4ZYh5Ma/pSjHqXEUXDI+61eGIGFZRF+FdyI/sNCqqjC2OJor
	 AF3AE0bsDISWDPk+E9Z1x0RjNddvhQr9zKr4CHyeveUWxL9mcYYUpjhPKJiy/bgNi1
	 yn1j/v/l0R8Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] perf inject: Fix itrace branch stack synthesis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518184939.2901713-3-irogers@google.com>
References: <20260518184939.2901713-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 19:45:59 +0000
Message-Id: <20260518194559.D8D7BC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a reliable NULL pointer dereference in `int=
el_pt_do_synth_pebs_sample` when branch stack injection is requested via `p=
erf inject --itrace=3DL`.
--

commit 2c77e921627255ed5c1e2aee4ca756b993e7acc3
Author: Ian Rogers <irogers@google.com>

perf inject: Fix itrace branch stack synthesis

When using "perf inject --itrace=3DL" to synthesize branch stacks from AUX =
data,
this commit fixes several issues, including missing PERF_SAMPLE_BRANCH_STACK
flags, incorrect sample types early in __cmd_inject, and other validation a=
nd
memory problems in sample repiping.

> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index dd2637678b405..7153b48cfe63a 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c

[ ... ]

> @@ -2505,7 +2505,7 @@ static int intel_pt_do_synth_pebs_sample(struct int=
el_pt_queue *ptq, struct evse
>  		intel_pt_add_xmm(intr_regs, pos, items, regs_mask);
>  	}
> =20
> -	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> +	if ((sample_type | evsel->synth_sample_type) & PERF_SAMPLE_BRANCH_STACK=
) {
>  		if (items->mask[INTEL_PT_LBR_0_POS] ||
>  		    items->mask[INTEL_PT_LBR_1_POS] ||
>  		    items->mask[INTEL_PT_LBR_2_POS]) {
> 			intel_pt_add_lbrs(ptq->last_branch, items);
> 		} else if (pt->synth_opts.last_branch) {
> 			thread_stack__br_sample(ptq->thread, ptq->cpu,
> 						ptq->last_branch,
> 						pt->br_stack_sz);
> 		} else {
> 			ptq->last_branch->nr =3D 0;
> 		}
> 		sample.branch_stack =3D ptq->last_branch;
> 	}

Could this lead to a NULL pointer dereference when running perf inject
--itrace=3DL?

When branch stack injection is requested, pt->synth_opts.add_last_branch is
true, but pt->synth_opts.last_branch and pt->synth_opts.other_events remain
false. This bypasses the allocation of ptq->last_branch in
intel_pt_alloc_queue(), leaving it as NULL.

Simultaneously, intel_pt_br_stack_init() sets the PERF_SAMPLE_BRANCH_STACK
flag in evsel->synth_sample_type for all evsels. By checking
(sample_type | evsel->synth_sample_type) & PERF_SAMPLE_BRANCH_STACK,
execution is forced into this branch stack handling block for PEBS samples.

Inside this block, the code dereferences ptq->last_branch either in
intel_pt_add_lbrs() or by assigning ptq->last_branch->nr =3D 0. Since
ptq->last_branch is NULL, this leads to a segmentation fault.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518184939.2901=
713-1-irogers@google.com?part=3D2

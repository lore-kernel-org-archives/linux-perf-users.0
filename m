Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7E3B5E01
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855303; cv=none; b=QTnB/WNDe2MDOzTFarlfqYRayLXbqIOPMVbaUng58ULjtdmDJGwWrqLobC3fnFRZItR6U4Qmvzo3DciW4IKSHRyi2GZVspHQKri3S8hI7j42F1rmqMsVBUkDh1+KanVob4z3mHOcuG2EDcu9U6hxWfdQiu2dq/dSGOr27OPnsW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855303; c=relaxed/simple;
	bh=25tcDRZkK+mFxNilVn1xQxgnSN+/VEfPACtFkilv0E8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MAJzKKoyoJ+8dRv78cDPCuyLkqV4/EwPiVDmxocLUmjChYuXFxKjRFbD5KyBcGWWmiVs2r9v6vJybI9gV/T1I0gzhcWR0mYA6GYrJkm+1ooU5tIZ28rXC+nJDqGykvEVOW581wjPNO7F3WTKIbDQQyqVDcVgvEQp6XpGwnybpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R22rcYL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R22rcYL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8428A1F00A3A;
	Tue,  8 Sep 2026 08:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788855301;
	bh=5Fe6G7XTQrrt3NaCpnMF5irRG1Ls/+ZSxCCqt57cAjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R22rcYL0rKC7DERVKsogzDWuoQ7NgGeNtxY6YO8opENnxNpI1tZUw9fIvKftk5t3r
	 KRXVug3PjcIkwTbtOnVjME9F2FAiMQAs0x2jSFBT5CoHvyst6wRels9s3Y3kkQTADa
	 jA/g1fV4KA4Y0qzPr8EPsfyokNKwK2BOogjZyv0MzJgX7NQcCd/b0EVxVYpDAli0xP
	 wktJ0adGaF+8xbIfOHU+pmNNYByiumeax3+wQLn4iydP70FjSBSA4KiFBwa3KRl4sg
	 Hh/VxqQmW8/amy3Mr5ne8c7sI0vPfJnFaNhUc3KC2eBYAqXoIaDJWmY0k3SQMmQHsG
	 2p6xmJK40GYRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 08:15:01 +0000
Message-Id: <20260908081501.8428A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ABI Breakage / Overly Broad Restriction on Precise Sampling with U=
ser Stacks
--

commit 4f30379fa3ce88165bf1e61c1c825c26d5810b23
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Disable precise sampling for PERF_SAMPLE_STACK_USER

This commit disables precise sampling (PEBS/IBS) when PERF_SAMPLE_STACK_USER
is requested. It attempts to prevent DWARF unwinding failures caused by skid
between the PEBS/IBS register snapshot and the user stack at PMI return.

Closes: https://lore.kernel.org/all/CAPu-DQqF0aF6=3DGS8Z6KKWeeX_V5LiXeKU_rJ=
QZC+uGg8zuTPNw@mail.gmail.com/
Fixes: c5ebcedb566e ("perf: Add ability to attach user stack dump to sample=
")

> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 3531f9c23b8c9..c67b659d64e2a 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -327,6 +327,9 @@ static int perf_ibs_init(struct perf_event *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
> =20
> +	if (!x86_pmu_allow_sample_user_stack(event, true))
> +		return -EINVAL;

[Severity: High]
Does this change unconditionally reject AMD IBS events when user stacks are
requested, since the second parameter is hardcoded to true?

Returning -EINVAL to sys_perf_event_open for configurations that were
previously valid breaks backward compatibility. Userspace applications
relying on AMD IBS with PERF_SAMPLE_STACK_USER might now fail unexpectedly.

> +
>  	/* handle exclude_{user,kernel} in the IRQ handler */
>  	if (event->attr.exclude_host || event->attr.exclude_guest ||
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index d1af33d96d0a3..a26ea8baea731 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -596,6 +596,9 @@ int x86_pmu_hw_config(struct perf_event *event)
>  		/* There's no sense in having PEBS for non sampling events: */
>  		if (!is_sampling_event(event))
>  			return -EINVAL;
> +
> +		if (!x86_pmu_allow_sample_user_stack(event, false))
> +			return -EINVAL;

[Severity: High]
Can this break existing perf setups for Intel PEBS events?

Tools issuing commands like perf record -e cycles:pp --call-graph dwarf
rely on precise_ip and PERF_SAMPLE_STACK_USER. Rejecting this setup with
-EINVAL prevents previously accepted workflows from functioning.

>  	}
>  	/*
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index eae24bb35dc14..ca52597cc39a1 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h

[ ... ]

> @@ -1273,6 +1273,25 @@ static inline bool is_counter_pair(struct hw_perf_=
event *hwc)
>  	return hwc->flags & PERF_X86_EVENT_PAIR;
>  }
> =20
> +static inline bool
> +x86_pmu_allow_sample_user_stack(struct perf_event *event, bool ibs)
> +{
> +	if (!(event->attr.sample_type & PERF_SAMPLE_STACK_USER))
> +		return true;
> +
> +	/*
> +	 * PERF_SAMPLE_STACK_USER needs to return the user stack and
> +	 * user registers to user space when the PMI exits. Since the skid
> +	 * from the PEBS/IBS sample and PMI delivery, the PEBS/IBS register
> +	 * snapshot (especially IP/SP/BP) can diverge from the user stack
> +	 * at PMI return. That mismatch breaks DWARF unwinding.
> +	 *
> +	 * Therefore, disable precise sampling for PERF_SAMPLE_STACK_USER
> +	 * and permit only PMI-based sampling for this case.
> +	 */
> +	return !(event->attr.precise_ip || ibs);

[Severity: High]
Is the assumption about skid accurate for kernel-space profiling?

When profiling a syscall or with exclude_user=3D1, the user-space stack and
registers are frozen upon kernel entry, meaning there is zero skid between
them.=20

By unconditionally banning precise sampling with user stacks, does this
unintentionally prevent the valid use-case of precisely profiling kernel
events while still capturing accurate user callgraphs?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908075102.5407=
15-1-dapeng1.mi@linux.intel.com?part=3D2

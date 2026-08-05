Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16214478861
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945492; cv=none; b=Sc8+Ln69GBizCgA2lIWe9LgYbJjO4k+DUXeCDHd9NkLhlyHUa8n64PeqXACwTO+G+cf/F2NWXjGF7ZTcn5f7rwn80dzTs2ipgyuAbIBqQlh8GGX9BVuR5keUA7VNo3b5HQTYKQmfaFBw70+iz885WepwP+wV6UskDApSX39q+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945492; c=relaxed/simple;
	bh=syC5sDQXvkbGdDJ4JMeJuMD7gwX0OYuokSTQaNiU0E0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VY8T7ca46Q3WpJdrGKm8R6E1R3hzM8PpT/QF8e/qYtQ7w9hOeqthZv8vlFz2Rhsp8li8LntxSU4LqOzJT/GwIhOVJy8uA0hYNB6KaRKvAtbvvFMTonVwHQJ2/pun6KV6vU7jfgofnzyJwTyPjmY9u9t02HeQvQUcRM/Y8TexlRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmB1Fypo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmB1Fypo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2A11F000E9;
	Wed,  5 Aug 2026 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785945490;
	bh=cZ2AO/CTu6FcuKOJmVWhp/ogCRPiAf/fhHEhQe1NxuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kmB1Fypo1iwjvvtArq9UNJzYtcrwRUpExuKabAqkPC89BioQRjUIqJtiBK/uge/q4
	 X12TGbiwLpQ3spmykwagxcruGWQ4NOyvdoMWX3/3sJJVY7la2UpxiIARkYg6+JiHh6
	 szYsK3jUbqyWnsJd6aXiXdB4P7B+oMJC6iSaEdQvdTB9MojXSqoXzfdvYPB9ba3VaS
	 JgXk8MbJ+ZU2796z1Ymu3NlLo+inJtj/w+iVWaCzxmrcu37epnjtbUvVv3wrayF5qi
	 2f2rr6KSBWMRfhjtsz3JG5jcHaQUyAl4jrKQ8TzRx7AFhNAgIT5vdeQqRc8Hti3nZd
	 n1ucl8/b7pahQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf: arm_spe: Add support for a 'software' discard
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805-james-spe-software-discard-v1-3-0ff0e44c4c92@linaro.org>
References: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
 <20260805-james-spe-software-discard-v1-3-0ff0e44c4c92@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:58:09 +0000
Message-Id: <20260805155810.7E2A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Writes to control-plane system registers (`SYS_PMBPTR_EL1` and `SY=
S_PMBLIMITR_EL1`) lack an immediate `isb()` synchronization barrier, violat=
ing ARM64 architectural invariants.
- [Medium] User-triggerable allocations for the software discard buffer lac=
k `__GFP_ACCOUNT`, allowing a user to bypass memory cgroup limits.
--

--- Patch [3]: [PATCH 3/3] perf: arm_spe: Add support for a 'software' disc=
ard mode ---
commit af3311701234ae1a3b87d9c00cb9f6f3748862b7
Author: James Clark <james.clark@linaro.org>

perf: arm_spe: Add support for a 'software' discard mode

This patch implements a software discard mode for ARM SPE. It falls back
to writing to a single driver-allocated page and not emitting aux records=20
when hardware discard support is unavailable.

> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c

[ ... ]

> +static int arm_spe_pmu_alloc_discard_buf(struct perf_event *event)
> +{
> +	int node =3D (event->cpu =3D=3D -1) ? -1 : cpu_to_node(event->cpu);
> +	int nr_pages =3D ARM_SPE_DISCARD_BUF_SIZE / PAGE_SIZE;
> +	struct arm_spe_pmu_sw_discard_buf *buf;
> +	struct page **pglist;
> +	int i;
> +
> +	if (event->parent) {

[ ... ]

> +		return 0;
> +	}
> +
> +	buf =3D kzalloc_node(sizeof(*buf), GFP_KERNEL, node);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	buf->page =3D alloc_pages_node(node, GFP_KERNEL, 0);
> +	if (!buf->page)
> +		goto out_free_buf;
> +
> +	pglist =3D kvmalloc_array(nr_pages, sizeof(*pglist), GFP_KERNEL);

[Severity: Medium]
Should these GFP_KERNEL allocations include __GFP_ACCOUNT?=20

Since this memory is allocated on behalf of a user process creating an=20
SPE event, omitting __GFP_ACCOUNT could allow a container to allocate=20
kernel memory without being charged, potentially bypassing memory limits.

> +	if (!pglist)
> +		goto out_free_page;

[ ... ]

> @@ -617,10 +698,26 @@ static u64 arm_spe_pmu_next_off(struct perf_output_=
handle *handle)
> -static void arm_spe_pmu_begin_discard(struct perf_output_handle *handle,
> -				      struct perf_event *event)
> +static void arm_spe_pmu_begin_discard(struct perf_output_handle *handle,
> +				      struct perf_event *event)
>  {
> -	u64 limit;
> +	struct arm_spe_pmu *spe_pmu =3D to_spe_pmu(event->pmu);
> +	struct arm_spe_pmu_sw_discard_buf *discard_buf =3D event->pmu_private;
> +	u64 base, limit;
> +
> +	if (spe_pmu->features & SPE_PMU_FEAT_HW_DISCARD) {
> +		limit =3D FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
> +		limit |=3D PMBLIMITR_EL1_E;
> +	} else {
> +		base =3D (u64) discard_buf->base;
> +		limit =3D base + ARM_SPE_DISCARD_BUF_SIZE;
> +		limit |=3D PMBLIMITR_EL1_E;
> +		write_sysreg_s(base, SYS_PMBPTR_EL1);
> +
> +		/*
> +		 * Track the event so we can access the discard buffer through
> +		 * event->pmu_private. perf_aux_output_begin() normally handles
> +		 * this, but we can do it manually if that's not being used.
> +		 */
> +		handle->event =3D event;

[Severity: High]
Does this write to SYS_PMBPTR_EL1 require an immediate isb() synchronization
barrier?=20

Without it, the subsequent memory store (handle->event =3D event) might exe=
cute
while the CPU pipeline is operating under an architecturally undefined stat=
e.

> +	}
> =20
> -	limit =3D FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
> -	limit |=3D PMBLIMITR_EL1_E;
> +	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
> +}

[Severity: High]
Is an isb() barrier also missing after this write to SYS_PMBLIMITR_EL1?=20

Because it is at the very end of arm_spe_pmu_begin_discard(), the function
return and any subsequent conditional branches in the caller will execute=20
before the pipeline state is synchronized.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-james-spe-=
software-discard-v1-0-0ff0e44c4c92@linaro.org?part=3D3

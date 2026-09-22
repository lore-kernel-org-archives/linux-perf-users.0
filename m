Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1D27473
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040606; cv=none; b=Z8WfBvgeYmNQtkwJv1IwfSp1qOTwNDvCeMXsqXkcj56AjTCMtTWq5xU4x4R6EsW63n/WR3R1SMzT7yYYnRLy823LkBdI0nz7uAA1aohhLaiNFaIl3rOBWtkpLlTeQnBrsyP5MzdiG8mbj0/uewQkw79J9EhIlg4AXZDHM2cSma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040606; c=relaxed/simple;
	bh=mnsRbAU/ALfLqY9VunujzXp//LSK/MyRTZUyl6eTyMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R7gwirspiJQvnq6S8rQEjdxSjBQc/QpoOj0tUwtAxSgNgoJk8+052G9MByrVV91pn9ILcal91kN95A1u7ozYgSL2rvqBgdkbNWCUK9yHyJR0WHmKeBUP4/MkNtNTZI5kqyx1HmSDZSHffxRya4cXANXcjQJp5huszAplMw90PYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXCF/6+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXCF/6+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30B91F000FF;
	Tue, 22 Sep 2026 01:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040604;
	bh=qPYVOVD8cnq9ij8bnzsrmotzdFUNjrnSZ0eX1qE6hUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lXCF/6+xOcH5wGfbDW2u+fRkjJdu8AGYt+8AqbURQkwdoobxVM5AYSG7ffYHcQt4A
	 iKk1kG9OUZHV8f3H9JA9PajIy3pgskVud6Q59Z6GBVAeuRIZWWTpr7p6G6RxWViJSw
	 h0cb9qjO9bcQkYcdGvVu5PFa56B8u47JicwklinBMB6Ly6RjxwaCj8h8g0dxiiayfJ
	 wi392WHQGfg0NDoIPuwJGT5HjX45+toXg4aTtXYKhViJkaVF+NUe86SlOd8124Ps22
	 aoZzNqFaFBtOmtkoWt+ndP+Zw3Q5nt23u92eVYmfFINs7LpMBonMC5mtgxav8NxGeh
	 /EUW/cAlbYljQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/hw_breakpoint: publish constraints_initialized
 with release semantics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921-mb-hw-breakpoint-v1-1-59aa06e1acf9@vt.edu>
References: <20260921-mb-hw-breakpoint-v1-1-59aa06e1acf9@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:30:04 +0000
Message-Id: <20260922013004.B30B91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: incorrect function name in memory barrier comment
--

commit 663e001a0e49d6fb96e95a7c75fb6d384e54fc61
Author: Jaidev Shastri <jaidevshastri@vt.edu>

perf/hw_breakpoint: publish constraints_initialized with release semantics

This commit updates the constraints_initialized flag to be written with
smp_store_release() and read with smp_load_acquire(). This ensures proper
memory ordering when __reserve_bp_slot() and hw_breakpoint_is_used() access
the breakpoint slot tables.

>     init_breakpoint_slots() fills __nr_bp_slots[], cpu_pinned and
>     tsk_pinned_all and then sets constraints_initialized with a plain sto=
re.

[Severity: Medium]
Does the commit message reference the wrong function here? The diff shows t=
he
store to constraints_initialized is actually happening in init_hw_breakpoin=
t()
rather than init_breakpoint_slots().

> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 789add0c185a0..8532c8a35b839 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -577,7 +577,8 @@ static int __reserve_bp_slot(struct perf_event *bp, u=
64 bp_type)
>  	int weight;
> =20
>  	/* We couldn't initialize breakpoint constraints on boot */
> -	if (!constraints_initialized)
> +	/* Pairs with the smp_store_release() in init_breakpoint_slots(). */

[Severity: Medium]
Does this comment misidentify the function containing the pairing store? As
seen below in the diff, the smp_store_release() is located in
init_hw_breakpoint().

> +	if (!smp_load_acquire(&constraints_initialized))
>  		return -ENOMEM;
> =20
>  	/* Basic checks */

[ ... ]

> @@ -897,7 +898,8 @@ bool hw_breakpoint_is_used(void)
>  {
>  	int cpu;
> =20
> -	if (!constraints_initialized)
> +	/* Pairs with the smp_store_release() in init_breakpoint_slots(). */

[Severity: Medium]
Similarly, does this comment also misidentify the pairing function?

> +	if (!smp_load_acquire(&constraints_initialized))
>  		return false;
> =20
>  	for_each_possible_cpu(cpu) {

[ ... ]

> @@ -1017,7 +1019,8 @@ int __init init_hw_breakpoint(void)
>  	if (ret)
>  		return ret;
> =20
> -	constraints_initialized =3D true;
> +	/* Pairs with the smp_load_acquire() in the slot reservation paths. */
> +	smp_store_release(&constraints_initialized, true);
> =20
>  	perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-hw-brea=
kpoint-v1-1-59aa06e1acf9@vt.edu?part=3D1

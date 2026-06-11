Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0543DA5D
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195418; cv=none; b=lsx6rXimvM6HZA2QUANEILj9ZrOnuWEg4PWSuBYipGXFvrkzBPGTrdKuW6BlHhpE2I1Jh0qgz27GhMZAeKZ+H3D9h9iIXfqXV7NFbAsxn5gvzWYJ+mmuY/KbX8kiy5wzm2N3Jn9ULk9IrO/OAiRy6MFQcgSvdEIeltSYFKMA3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195418; c=relaxed/simple;
	bh=jqikidRWTwFcf+nbITcsEJgWqEXt/+6FSZx42dEdLNg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DskXzBaLZM4RW8Gn5tnfdOvKSxBWV9Fz6QUvHc+Z0oBIuw4E+Q2YpJ40bdfxcozvQMuHoich81420jut/uMPIVEPUM7G5Kk8sWBdST7LThKG+vRIw9z+IM958S+n/syqFQkJM41KU9Qs+9qfQ+DUSpUdQb3FYFjDXpExoaflWIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlXGXAm/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlXGXAm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1322A1F00893;
	Thu, 11 Jun 2026 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781195417;
	bh=HGTEw8IY8C69ZcyYaTpORbWIrMnyt7xJKAmnqhmuXPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NlXGXAm/ilt2X1Gr8YXIn6gaFn8osOMNkJEImRg84sayTXJBj9hBuHsFHFxpjvynC
	 Jhs4h6VoQXeBnwBCuhyw9mCejWCpTqdYlDnzqDdXFYPjjYzeDzmspxlMqgPH63VtwF
	 trhvMms5jpukTiz/Y9E6BI0P7dvHlmTHBFzTA8SAK7lAGIOfwnHTEIcHT0bdNnNKdt
	 iOcXXMewGEpBHDQuyeUKXQ/H12LbXuvx0i64fCF251GgCV2L0AbkQfrEW7Z9jFaLpO
	 w5TWvir450E9UMjHDyEfmrI3tSp/bTeriFZBthCx45GMCXNKLfvL6Gfg/Xf11N2Qdj
	 UnttVOYbjP8Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 6/8] perf/x86/intel/uncore: Introduce PMU flags and
 broken state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611160033.66760-7-zide.chen@intel.com>
References: <20260611160033.66760-7-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 16:30:16 +0000
Message-Id: <20260611163017.1322A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removal of `box->cpu =3D -1` introduces a race condition where c=
oncurrent `perf_event_open` can install events on an offlining CPU during m=
igration.
--

commit 90f307cb2cce79d442ba12ad2d9b5ba2c1d5018e
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Introduce PMU flags and broken state
   =20
This commit replaces the boolean 'registered' field in intel_uncore_pmu with
an unsigned long 'flags' field. It introduces a PMU_BROKEN flag to track box
setup failures, which is sticky and clears only on module reload or reboot.
Broken PMUs are skipped in CPU hotplug and box allocation paths.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 06ef89f6ccc28..feb8c3b0076b2 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c

[ ... ]

> @@ -1507,7 +1526,8 @@ static void uncore_change_type_ctx(struct intel_unc=
ore_type *type, int old_cpu,
[ ... ]
>  		WARN_ON_ONCE(box->cpu !=3D -1 && box->cpu !=3D old_cpu);
> -		box->cpu =3D -1;
>  		cpumask_clear_cpu(old_cpu, &pmu->cpu_mask);
> -		if (new_cpu < 0)
> +		if (new_cpu < 0) {
> +			box->cpu =3D -1;
>  			continue;
> +		}
> =20
> -		if (!uncore_die_has_box(type, die, pmu->pmu_idx))
> +		/* An inactive box doesn't need migration. */
> +		if (box->cpu =3D=3D -1)
>  			continue;
>  		uncore_pmu_cancel_hrtimer(box);
>  		perf_pmu_migrate_context(&pmu->pmu, old_cpu, new_cpu);

[Severity: Medium]
Does removing the temporary assignment of box->cpu =3D -1 before the
perf_pmu_migrate_context() call introduce a race condition with concurrent
sys_perf_event_open() calls?

During the CPU offline process in uncore_change_type_ctx(), old_cpu is still
marked as online. If a user concurrently calls sys_perf_event_open(),
uncore_pmu_event_init() locklessly reads box->cpu. Since it is no longer
temporarily set to -1, it sees old_cpu and sets event->cpu =3D old_cpu.

If sys_perf_event_open() acquires the CPU's context mutex just after
perf_pmu_migrate_context() has finished and unlocked it, the core perf code
will successfully install the new event into old_cpu's context after the
migration has completed. When old_cpu fully offlines, this stranded event is
forcefully killed, leaving the user with a dead event even though the sysca=
ll
succeeded.

Previously, setting box->cpu =3D -1 prevented this by safely rejecting such
concurrent open requests with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611160033.6676=
0-1-zide.chen@intel.com?part=3D6

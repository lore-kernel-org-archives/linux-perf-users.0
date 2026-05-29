Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8336A361
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047285; cv=none; b=cSWDmoE/WcBRmJHEUKNWJ6PXeHjDTLPEx483hgyLJAz3XbucXb6HEyj1+ecCnpaGUSXVMhM1onPEBFx4jQi4JOgUWeNzA9SnSH05hXX4KIzUGNQa3PSlQkiCNailDwuAxbxWBwnJsW+nMnC9IU6KJRobmny9U9/piW2wXIGhl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047285; c=relaxed/simple;
	bh=7Q+FCBIp16WsPF57pT76VpMbU+gRlBYBxSXtdHXRYO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UVejP4aTOrCs5CWZvnIOQTT08rEQ40VcyVBQHQxpMerIqXyx/i/XY/IzxESvgJE6NSOwecf8zIl70wvatCd9k1bYPUiXGyifH7pAr6SLL6rRu+v200qL9a3lxWBIflJgbBZAHPzPsFSG4F5CVJFZCrLl4nEfPrvZON5Z5vCoDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrhAmfFy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrhAmfFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23531F00898;
	Fri, 29 May 2026 09:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780047283;
	bh=8oR9o8FwcbyZwYoF6k/LFIqtk9/5xjbYV+IFczFEk0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DrhAmfFyF0l19gwgitFPuKX84wcL7e5js2aw7ZlG736Lt79gvB4sUuburoho+laux
	 TL6FI32WMl5+9IgfBrjFU+NSxIgREc4wdwiOVZWNtz7yk/sdiIyt0E6lImK4urhJrC
	 d20RsaryyTVKaatmOgU/1Ej75FiZDZM8I/5KOpEcF0smaRjhZXTlk70LwR2O3C73Nx
	 +Q/vyXrGWUS/F7cwbImjB/kVKEKYiHEUVsNK2Ii0I91H3wQKqqTjX3xDz6LSul/V+k
	 HG9k/zpAw7tOWj6shGGTBxBxECcFx96FlVyY2DbcErhnZBJemo6plqFbs5u8BauYAt
	 8gYw3w6S/8uZg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 22/23] perf/x86: Activate back-to-back NMI detection
 for arch-PEBS induced NMIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-23-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-23-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 09:34:43 +0000
Message-Id: <20260529093443.D23531F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Using the `BIT()` macro for shifts >=3D 32 on 32-bit architectur=
es causes undefined behavior, defeating the back-to-back NMI detection for =
fixed counters.
--

commit 67718335973298488df3db65888b9d78109347ad
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Activate back-to-back NMI detection for arch-PEBS induced NMIs

This commit modifies the PEBS handlers to return the count of actually proc=
essed
events. This activates back-to-back NMI detection in the PMI handler, avoid=
ing
the "suspicious NMI" warning that occurs when multiple back-to-back NMIs are
triggered by PEBS events.

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 8a653edce392a..e0d3076277026 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
[ ... ]
> @@ -3198,6 +3201,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs=
 *iregs, struct perf_sample_d
>  		if ((counts[bit] =3D=3D 0) && (error[bit] =3D=3D 0))
>  			continue;
> =20
> +		events_bitmap |=3D BIT(bit);
>  		event =3D cpuc->events[bit];

[Severity: Medium]
Will this shift cause undefined behavior on 32-bit architectures?

Since bit can be greater than or equal to 32 for fixed counters (where
INTEL_PMC_IDX_FIXED is 32), using the BIT() macro on 32-bit x86 kernels
results in a shift by 32 or more bits on an unsigned long, which is undefin=
ed
behavior in C.

In practice, this typically results in a modulo shift that aliases fixed
counters to general-purpose counters, causing hweight64(events_bitmap) to
under-report the number of unique events handled.=20

This could defeat the back-to-back NMI detection and fail to suppress the
"suspicious NMI" warning for fixed counters on 32-bit systems.

Should this use BIT_ULL(bit) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D22

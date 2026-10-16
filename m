Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8D3793B0
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185943; cv=none; b=A38oaPS5LqM7oG5atANIpYJ0Hmt7vFFN1ru57W/K44/shvS7rvBzM6JeoTFimlNMN5v+83g79V7hwkRhILEYKPCpZQS/u5vnDC2CgrswYMROQxo9LouGgXS/upwKKEb0056/j8C8rilk2pM2P6BHBaZfiOp62Ey1+Ga8A+QVl0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185943; c=relaxed/simple;
	bh=YIpbGU4PuXm5JB420B4zM2GPI2F63WBp669YENaJfhM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QIJVBPRk08im0z2CJRuanSV/X1th4S8bOSxH2Vvz1W/Raq3088F5z1Rm8jRDjtb7HC/o+JBX7t80PPTOH6K9yxalbXMFVoYi3ZjiPf5Dipe2PAclsHCZ8kuy273CoZLjubZUfw+RP4flX1wfNRYI8jSg1e/qB9VMrcMypksyz+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eracZg66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eracZg66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02D31F000C4;
	Fri, 16 Oct 2026 21:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185942;
	bh=2Z0ZSuPwcl3SbNbR4LYDQ3qyFTnRxK3lw+9rrG/a/0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eracZg66Y2KFxT8taZBI3iohQuj8ykWSwBB9DMrqeNFOgOpxL2ZzANYHJViBpCtxt
	 i5adqEY1ChiWNBCLEynEeDIcpFLWsGVDtryaixtb4/P+430WcvCfrDr7MLf0v26lUC
	 b6F0Sb00NwwJkk9FpcLNveLsqM215ZsnMT80wwDjw9QVvqjy8MJbDuqkKOz1oSnb6m
	 oxHirnuP4DnWa3teYGmDlgW5bIyoEeEIknv55bTnzxQio8Ze/dcm1Tnrrr+GkqIxqD
	 BgR3oWNFzfNixf73LdyeyfW+fcIWeZ63qphKE3q2Z/8v5/UIpJuyreUKtP2hboOOOm
	 XYz5eMXtfpl6Q==
Message-ID: <sashiko-outbox-174965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/21] perf test attr: Ignore the core PMU type perf
 puts in 'config'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-9-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:25:41 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since
> commit 55bcf6ef314a ("perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CA=
CHE")
> in v5.13, and arm_pmu opted in with
> commit 5c816728651a ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capabili=
ty")
> in v6.6, the kernel can
> be told which core PMU a legacy type event is meant for, with its type in
> the top 32 bits of 'config', see
> perf_pmus__supports_extended_type(), which __parse_events_add_numeric()
> does for HARDWARE and HW_CACHE events, but only when there is more than
> one core PMU, i.e. on heterogeneous machines, where asking for one event
> ends up being one event per core PMU:
>=20
>   $ perf stat -e cycles -a -- sleep 1
> [ ... ]
> keeping what these expectations mean on machines with a single core PMU:
> which of the PMUs is counting is not what we're asking here.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D8


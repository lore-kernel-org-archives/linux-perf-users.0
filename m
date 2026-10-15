Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE851AEDD
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065668; cv=none; b=BjDlAEwJM7aQWWTHwPOhpPjyXNnlbZW6a0SnRDFdBu1MA5jVQ65f1Zm/WhRS2+qZ+JnJT/HUBFcMw5dhE05fOIV5VFCOaDHv97xxgcNJRtPgvdzYuAPvJVkL1VHELVA3NjVmNN7hsa4H47ynXxxsnLdU2SdzfKPP6Eo5E8ZmvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065668; c=relaxed/simple;
	bh=39OzpIzuqP2HzCosMCMK52y/xKNL203nLXsgmGp+t/8=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=fKNkDOTBaB7yxdUiU0IAFsZwjwWYsvFljPEbmBxAs/v9VGY+OsCH6EPhbjxzAx8/m1Cp/4Ul3tH7HiQ2YJnYhcqnniJRNrrR1I5m+hynHR3zITdxwZQdAo4dTyK99cTLprlfDUGYI07us9nUa+q7wCFg3JjKw/pFgBUfKTiXPFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlAGW6YR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlAGW6YR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E61D1F000C4;
	Thu, 15 Oct 2026 12:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792065665;
	bh=39OzpIzuqP2HzCosMCMK52y/xKNL203nLXsgmGp+t/8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FlAGW6YRldu4OE+kJlP3Sq6+Zi6ogvNL21B6OEUx4My25ogek+ZNlq2Lu/Lf6TLpj
	 Tl6cPYe/PvEPfLTFLwafRWiHEdPVN/XbGg09TfMg/tKsSnaUwsxkiKZA6C8KIOpqtu
	 XuyEPeI8AC0GAR8uXoYjfjHJlZ0KR6YcjUD+GvJFoYZXrFwmC8Qr4f1gbdPriMlvq7
	 TdD0L3AEdac4WGq9jNpXEcOZ1n18/t7+7/EjILL3SftYIhH/+MRXbVxWaEGHzTHKUq
	 zN/37j6xKwZB/rFc7fiGiFpdt9DO8vnd2LykO9r6YUrq/7x65VS1viM36Hz0/2QsoS
	 n6yeB9YeqnspA==
Message-ID: <sashiko-outbox-172778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf/x86/amd/lbr: Limit branch snapshots to
 valid entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <21b52422864cea9f768ddee6be48102954cef984.1792064123.git.sandipan.das@amd.com>
References: <cover.1792064123.git.sandipan.das@amd.com>
 <21b52422864cea9f768ddee6be48102954cef984.1792064123.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:01:04 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The branch snapshot callback used by bpf_get_branch_snapshot() copies
> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr are
> invalid, but they end up reaching BPF programs.
>=20
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> amd_pmu_lbr_read() skips reading the registers, so that a stale count
> is never reused.
>=20
> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software e=
vents")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792064123.gi=
t.sandipan.das@amd.com?part=3D1


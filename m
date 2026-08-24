Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC583EC83C
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561194; cv=none; b=H52YQkilDDbT2JQ82T0opyzb0qVb+o0/hdLfCAiY1tmwx7ESssc6mYjN8Nnf5Y15YUjQaPzvq1fnLMz8I12QDnZQ0a7/5RmVs7OQAApxq4MSO+GICmBRCQEsGtnu7ECqc3fm0e51S9VA4BCyblZRrxOqw7B9RIeRlDQQba4SlJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561194; c=relaxed/simple;
	bh=L8l0L1CXS+k42BIqRK7c/s8VnIYQd5/BFJO6Vqe6noI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cKe3uNCQA4gCw9u75Lb/6kkR7DqsfKKLRRt5MamFaM88UId/L6SazJbAOc7IK/U2883OypjC8o7I56KYGMt+6+yH0/Mut5RsSgyxMB6r2Xc6OvWZxdIqI9tzwMPDXyqkerUoNRgkRX7C0AyCtly5MLjdvopYJE1KDo7pJw4YOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXsDEbx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXsDEbx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3D21F000E9;
	Mon, 24 Aug 2026 08:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561187;
	bh=L8l0L1CXS+k42BIqRK7c/s8VnIYQd5/BFJO6Vqe6noI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KXsDEbx5pUgEoCmAnnGWkOUoYQ7DgmulEYLImMsuZf2sHGrcc41zENy0Rf5jqjSm/
	 GJcsbmkCiODQKhgKyROyNjxRRWJ8Z5i9TBaLmPe20BQBcPY0LDbajEfdGzfJ6LOahI
	 0opvlc15v481uAEy8DNmqu6YIxXy088GAcAhEI44oSX66APNtXHj5pP9gQpWyWY4cE
	 m0A1Vs8S5lU9bLao6yxNxn/nWqvEQBfT1iaepvfSGEDIGdWmib9nuo/WF9iV17+Gx5
	 IyLJpnbPnIATmejeSzt31BNlraCOkzpFe8NxU5pBnC/n8NEXtD1hlQ2MRV+nCojwvN
	 j2tKsxDaSzpHg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 09/23] perf/x86/intel: Centralize
 PERF_PMU_CAP_EXTENDED_REGS updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-10-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-10-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:46:27 +0000
Message-Id: <20260824084627.AF3D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> PERF_PMU_CAP_EXTENDED_REGS is currently updated in multiple paths:
> intel_ds_pebs_init() and __intel_update_pmu_caps() for adaptive and
> architectural PEBS. This split makes the capability flow harder to
> reason about and is awkward for upcoming XSAVES-based SIMD register
> sampling, which also needs consistent capability setup and validation.
>=20
> Refactor the update logic into a single helper,
> __intel_update_pmu_xregs_caps(), so adaptive and architectural PEBS
> share one implementation.
>=20
> Call this helper from intel_update_pmu_caps() to keep PMU capability
> handling centralized in one place and avoid duplicated or conflicting
> updates.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D9


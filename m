Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5613E3D88E0
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530385; cv=none; b=Sy0zGJWLsXdME2jQeTjTBbAR+ffPL1V5e/ZkBHvXk5OcziqUcu9laOq1Wq5ed7mz0o8EqQz6vVSvE0hgIsxCgpGrIlWyGWrnsCWRkn/3P3kwrhDmF5lPNyPJBAmEDK1ApZ+bGE8XnpXsFNrWSM+x4BeZ5BhFPoMxaDFGfVdRakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530385; c=relaxed/simple;
	bh=oKc1WHNgUfeAq0lFwVAjE5fq3rsFutg+SrluZ4sXpWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IVxVoQdH3oMASMmtxbIjUg5T1alRqXA8vd22DluRGknN7SITJ0WrQ4D1B9JojV1MoGypcqIpYHHWUzXiMFuZSabn7W+OK5aj2ZDY4qsLmYJyljGXqK+V33Vs7kTgbyH40n246iL5eF5QrJdUH11QsxvcZ8DxvuRwdz0hxbzDH/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYKycGZn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYKycGZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2EB1F0155A;
	Fri,  4 Sep 2026 13:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530384;
	bh=oKc1WHNgUfeAq0lFwVAjE5fq3rsFutg+SrluZ4sXpWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gYKycGZnorg6hX4+i4KGmbeYdOfyDGSncqBmN6gGQ6BR0mTmrjv84ufBXoRAKn2Fp
	 mLx8yFL1lAYfS3k0+3cSxl/tSlOkAx5HUlwfbtsKIu13ckIf0iDUu7yVHuHdMeQVHE
	 x+9Pzt4nkxOH7vV3FNhL4iyyQ0vtldnDLl5MLGwnywW+CJ0Fsi3BcCL14bOCpFBVpf
	 fCR06U4gv3Cj/1yAqxOCD4lGH/3wmmZTR7Ko9JWBDeeR6o9jk6jVt+2eGMekNxHO90
	 DT68VxB/FLF1EY/WTbW0favrtfPlX30KBNrQlQUZRlLTthaaYPVpUX4yNtLDx9DzPS
	 uQaowM8hyq9jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf evlist: don't restrict uncore events to PMU CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nia Su" <nia.su@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904-perf-evlist-uncore-cpu-b4-v1-1-604b55c025ee@sifive.com>
References: <20260904-perf-evlist-uncore-cpu-b4-v1-1-604b55c025ee@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:59:43 +0000
Message-Id: <20260904135943.CD2EB1F0155A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The PMU CPU map has different semantics for core and uncore PMUs.
>=20
> For core PMUs, pmu_cpus contains the CPUs on which the event can be
> opened. Intersect the user-requested CPU map with the PMU CPU map to
> reject CPUs unsupported by the PMU.
>=20
> For uncore PMUs, pmu_cpus is just the default CPU to open the event on,
> not the set of CPUs it can only be opened on. The user-requested CPU may
> override the default and be used directly, and the driver can redirect
> the event to the appropriate control CPU.
>=20
> Currently, __perf_evlist__propagate_maps() intersects the user-requested
> CPU map with pmu_cpus for all PMUs. If the user-requested CPU is not in
> pmu_cpus, the intersection becomes empty and the evsel is removed before
> perf_event_open() is called.
>=20
> Skip the intersection when evsel->requires_cpu is true, which is set for
> uncore PMUs. is_pmu_core is also false for other non-core PMUs, so
> gating on it would have loosened this check for them too. Core PMUs
> continue to be restricted to their PMU CPU map.
>=20
> requires_cpu can also be set for BPF counters regardless of PMU type,
> but only when has_user_cpus is false, so this guard has no effect there
> today.
>=20
> Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with thr=
eads/processes")
>=20
> Assisted-by: Claude Sonnet 5
> Signed-off-by: Nia Su <nia.su@sifive.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-perf-evlis=
t-uncore-cpu-b4-v1-1-604b55c025ee@sifive.com?part=3D1


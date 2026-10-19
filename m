Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5393E5EFE
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420956; cv=none; b=dEN11G81a9uhZDikHKjmchDVMxGVObsOyPEHxHDK4f3/kLEeQUnCMxRzN6knBhCyHWlYsiPGCr4NnyTWGRqi4Ojk4DiWKGrygukgh5HEB+FbjJo2uQbNh6v7zuzRpUUpzdIxgkSyMaS3eFAKVYOVwulvgViiySl84D3bt4mdXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420956; c=relaxed/simple;
	bh=3mnOC1uw4swwBntG/tXC2vQ669Ouh0cjDNsGlVO3a1E=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UNMqvjbFa+lFJ7WjZamP4QCBqOLlDF+7CjJyZKRgs7tOcQfJfXkHCGKbeyCUIxH4d4+bomirrnfr8DJT473KCDYODXST8R/2NLt9tFSKsuBNjR9YPHieAN4oqyu54QUQNDShMSmhUU20TbSpZb6p2qgLWnZ+itL/zmWtRSA9zME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyoYEcna; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyoYEcna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604B61F000C4;
	Mon, 19 Oct 2026 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420955;
	bh=3mnOC1uw4swwBntG/tXC2vQ669Ouh0cjDNsGlVO3a1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cyoYEcna3UgfAoGHfvRYiIuve6R5SnAWbn/h3VKEGH+VpRfWXVu1JhrwkQGtsuxup
	 vtci2hKExkjjiNXjklEiO3MQqsNZp9KGwCzNbZmdTbl7UcvUSW/gF1M6uYEO+gf1lY
	 HIaQ89vDQH9StxocHp9Chvy7DLJJkwPgQD2TlGU/vuPQQzMr4LPmKXMHgL34qz4R83
	 QGLdfViAN8xK6g1KQ3MSjhEDyYjLXLv0solyvBNEJQ9GLvXLb0hrkcEL2au5otjtX5
	 dFoKzTFKRBPJkJ8Owxxi6j6dsaU5ZGIF0OH4l/4Ix0zgils4CFJ+2qRHpRwGirhtLI
	 aqjZK5sTgYSyA==
Message-ID: <sashiko-outbox-177476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] perf/core: Fix kernel register info leak
 via hardware skid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019135441.1420968-208-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-208-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:42:35 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>=20
> [ Upstream commit 166f10836a653dfa280d4335603b52f685b8b1ef ]
>=20
> An unprivileged hardware perf event using exclude_kernel=3D1 can leak ker=
nel
> register data to user space via PERF_SAMPLE_REGS_INTR or PERF_SAMPLE_IP.
> Due to hardware skid, a PMI may trigger after the CPU has already entered
> kernel space (Ring 0), bypassing the perf_allow_kernel() privilege
> barrier.
>=20
> This security vulnerability is severely exacerbated by upcoming support
> for SIMD register sampling via XSAVES, which could expose sensitive kernel
> FPU states (such as active cryptographic keys).
>=20
> Fix this by ensuring that sampled register data is dropped if the event's
> exclude_kernel attribute is set but the PMI catches the CPU in kernel mod=
e.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/all/20260529085613.CCAFB1F00893@smtp.kernel=
.org/
> Link: https://patch.msgid.link/20260616044654.3468742-8-dapeng1.mi@linux.=
intel.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-208-sashal@kernel.org?part=3D1


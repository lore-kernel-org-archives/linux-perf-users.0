Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972743;
	b=tTmIY4pe4NxvBnXa/Ho0cSYVDgPWsq2+2zCPs+QlV2zjylSZG/T/xRgvwfBCeS85LiZa
	 TW1st17HsnqcKVhsWrt84Mrv8DFO2aTHKrS/2Cf79EgKsWzjVWh2/1wHHlFrFncdX3hno
	 rVHmoLYU3DivAwjCA8GQ9Axv71ZHrF5hTmeGJFvLEcy71z5n6/BJvvmucVy8g46Gu03t/
	 WKHijLDvoAu3tugmHlmNcYqIPHi/mDiFhk4h85HFDlGmoYVuzsEIf2CltZ5xolX+VsxqS
	 QgcbwZbEto8PYzHbFmi913+2r67Ftqe4cYwb8uramHjVbwHitgRi8TCQU94+hvOkKoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972743;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yYGnOWLxDth4nHPbBUoCG4SnW+iYKCy7jc8QNFQ2qoc=;
	b=TRHL09poJDKMOZPNbBrCDat2P54ypjs44ScgQ9ArADoMHJ8rguhU5fVrN2/q20y//riy
	 uGWjulkONfSbfzkOoT6dcgT1G2+T7czpUB5dL9VGwfb+IrFGlaIjwjRN9YI0EDcnLZaAN
	 vZjE7TAzw2G0BIZUsIJzf3Jonl4WkBAkpfaiutYrsKjBYlrKYuDd5Zd4jaLgib0JnwiL3
	 xXNVskAeEB0WBF9LwlV9ADvRjsOjwsN0htoQBeoDKHPcy3bWkyeMNZ9leCdbTAsKPlGXP
	 14GKaAetY3KoI43FvWOn+O77N/Y06/asR6p9GXeJQzEsXMcIPsw+MlbyPpWheyp4vaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYvdLglr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07755606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYvdLglr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283B81F000C4;
	Wed, 18 Nov 2026 03:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794972742;
	bh=yYGnOWLxDth4nHPbBUoCG4SnW+iYKCy7jc8QNFQ2qoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bYvdLglr5exOdQhY7i7Kh43XvmzSVGKFLCTEVBC4JtIIwq0VlgU6U557/T1DPU7Al
	 rO+Qp24vGDdYhaDXUmj+Ky9gQdGqCPcMwUy4uN2A5CxlYx/IuVUqkU92atsdKnHYJG
	 augXhikVTDRlycBrZRM422Ukm71ABkum6K71TqSER8uqgs+SldzOPn5baG17b8aUkm
	 FvlwL0LCMjX+7jLE/ZkXFFwWk3ZMQS+9+vRHrrejb/UxgqJhAi1VoXaCEiEzEEpV33
	 ol3qA5Dfk3VmT0osipuvRncgowzQJTF1FZ7Qb177J967fvEOsMJquM/C/mT6VVrlTa
	 h/B6qJ+PMeNJA==
Message-ID: <sashiko-outbox-220014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 11/24] perf/x86/intel: Allow LBR read helpers to
 operate on explicit stacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-12-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-12-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:32:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The LBR read helpers currently assume the default stack,
> cpuc->__lbr_stack, and therefore cannot be reused for other LBR
> stacks that may be in use. Extend the *_lbr_read() helpers to take
> an explicit LBR stack argument, so they can operate on any LBR stack
> instead of only the default one.
>=20
> Do the same for intel_pmu_store_lbr() and intel_pmu_lbr_filter(), and
> pass the LBR counters array explicitly as well, since it is filtered
> together with the stack.
>=20
> No functional change intended.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D11


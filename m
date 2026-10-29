Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250102;
	b=TABtIyM3/XvSRGJScY9zI5ODsavxKBYSJ/tNxIG0UHKoZVdtmgKc8BnDb1IYHCISc/LC
	 uEC9FLoA9e7dc8FehdA+uxiRXNgm40yWJ4uG+qM5Ml956mDZTlTrzY8Io/Mu4HJ33Zqgi
	 XH4/LTkc2DhSpYMSSZiBpUjV6gv2I2eJaiZGAjJI4jisCXChdBbLtroqwWLPMzAL20RVf
	 Vt/LXTqC8YGD8cwlUBWDafBC/0YttSIlGRoAfKRkUp82GpOA18VQdcW8mE6Hq63AlBkW6
	 eTar0V3LoL6b4jGcd2rVazMRxlEiiA01MmcP4Cpzq82KIunMyKtF7JMeSR6ZStsqn4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250102;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cc7vffQbTM372dVKfnNVZ/LhPdM1m5y0fr8DxdSs880=;
	b=bes3SsmMVMlR0ujxgVno0pw2ZYQ8XrK4WU0+RWpghhRmJVHtTO5fOtvzR7+VxAwsCwYX
	 MsnewHSzGb1duMcvPrNUbPOIt/RYyPG2ErmsjCjay2+e9POnFgszXcphctm89y9TjSzwJ
	 +1YmG4njw9Z8bKjvQpWktoXsDDtZN+A3sk4N8pEVkUPd6B+Oq5NVpfDlUMKZUP0SeVRGg
	 8GKqIJK5Lyh48KR2XjvV1fE0hlSO0w/pFsy4NjP9FItPW6P7UB0hdMjL85MPg4NUhwpsX
	 i20tatAvL51Gfs1BFi2VsZ5EgC9yLsn2FtN1WzUQ+XwHTdvxZ7Abi8FvHazTscRLM2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Os8yD0rg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42F606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Os8yD0rg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAEE1F01825;
	Thu, 29 Oct 2026 05:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250101;
	bh=cc7vffQbTM372dVKfnNVZ/LhPdM1m5y0fr8DxdSs880=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Os8yD0rg9ibmJ0iKEgk0u+uYht4DCptXqw3VS3cJ+OXAgFnFuJAMRUNdrMNPczhlg
	 7LICJGnlcaEs8oIJFqjvrdCxaBcMxNnBEyhXT7iLNavrKcbMVT5FMKn07f7uFDQegJ
	 TCUKIN3nMOZdFk86NA4JCkliqkNaVVuT1QQjmBUGneFFetO7UBerT5n79NQR9ozMFX
	 uG9hRJCtmwkcrwhhduFW1jCG/AAs9RqVlBCfHvvU2cmZN1ayZLzPyWhGRRSf2SWXvb
	 WRADAzYIjOa0KdrkG3wn7sDZseAfo/2+y/yEpSS1nkft+sK7+a8DTaGrIGjiNJMxY7
	 amMmM+j856ZMw==
Message-ID: <sashiko-outbox-188723@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 12/18] perf/x86/intel: Always snapshot live hardware
 LBR state for BPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-13-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-13-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:01:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __intel_pmu_snapshot_branch_stack() is intended to capture the current
> live hardware LBR state for the BPF path. However, that snapshot is
> currently skipped when all LBR users are PEBS events.
>=20
> BPF LBR snapshotting now uses its own dedicated LBR stack, so there is
> no longer a risk of clobbering the shared default LBR stack. As a
> result, always snapshot the live hardware LBR state for the BPF path.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D12


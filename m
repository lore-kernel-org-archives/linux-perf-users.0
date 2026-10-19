Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428472;
	b=a7pwsXr7vN3R6CLPUJeClO5DpDLfP5kYwvFa/f8vM0HaQ8ukt2a2Zk1Ph5dRGmO+kYFi
	 H9cErbagNqM6reiccvuhYDOUqZ/iw9msfmMmW8T8V11c6Zy+JBEGnnd8N6h6xs/80tgui
	 Q3BgWhbVURMenq4ml/RrT0X7UjgZ/BUu/6En7g5MWkyyLKWajz5BptangLkcmF9wAqrsG
	 RLEMhqukApABAIr8T4Tt0vIk2GnmFlxjq9mlmLj1YmFF0dQCwubMZmYEviYa58xEIGpFA
	 K8ysalPeE11mhuIyD1JUu4PHSY01E4RSp7MRQy3BWbt7lESbiRjDtHTXBlPthMS+h2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428472;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QIxZsSOtxOA43UiCMOYvMC4bP7vCQ+kMftM9tu0os1M=;
	b=jhNqUgdw7FT/GQDR368l1jib9sp+cu39weBT4LFXGSIA7RVNc7gQpj2gu93/BV0zWgki
	 pU6VS3/qM4/au+Dn4+INhEHXGaeqGnazoUvaHq6mwS0/lvX2LnGf70DHVJ6XyTrUhakwR
	 HGZv6IokaaBxtT2K0u0DOi7z06Rd7R6nuCh5Z+vSRfI6U3g6/5Ci50AgxeWXjWp4BqlyH
	 wBrMuMhlWxzJcxKisDMENE8/m5hDzQW880LIn0s5fBx0FKGjDDHdFhf4dojp0sSZjLxiD
	 zUkKqXkN3fjWDIwWyIId6RI9V866iqFKJOo1LRe3VdO5ZjsnACW+PVXAx8YizNE/3Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5zwtZwu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDD9606A325
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5zwtZwu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4441F000C5;
	Mon, 19 Oct 2026 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428471;
	bh=QIxZsSOtxOA43UiCMOYvMC4bP7vCQ+kMftM9tu0os1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c5zwtZwu3Id1AOefpuPAijUduTMz3exh3aJKV6khmoiNTgb7SO8ytD4hjkjxZms1m
	 9iEdG6h2dBiWYPgXSS+u1/7ptQO+bs2KuxPwfneY52NTMGlC+juASQvcgE750nPW0z
	 NoNPzWDiytNX8bNVthaKVwLOSdreCZtzfdb440FUqJ2OMLJzZ+PJnRaPS2yDiZ6Y4F
	 DgK5icWlgwzB0L+oBHWcJ0V9mSbtZ5U3Bo5/izxPFfQe76NT8kVsyHcwRIdOH1yLje
	 wYBQXjiLaYDGw8bdInhebhSz8r5T/fCYWOULZkTmcEVhXAQJ9hYa7qs9upCgTV/YFt
	 1depglRR9mJWg==
Message-ID: <sashiko-outbox-177937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] perf jevents: Add support for NVIDIA Tegra410
 PCIE-TGT PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019164241.403644-5-bwicaksono@nvidia.com>
References: <20261019164241.403644-1-bwicaksono@nvidia.com>
 <20261019164241.403644-5-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:47:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add alias support for NVIDIA Tegra410 PCIE-TGT PMU events and metrics.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019164241.4036=
44-1-bwicaksono@nvidia.com?part=3D4


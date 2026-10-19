Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428459;
	b=3dq/JThgslkDanA05hIG+AovEG4VkwNbiVfcXP4/+CnqJI8E5rgNPpnCtIgguyMgusfk
	 ojV91F6n99kYOEboohTUBYx5eaJzolPtc0N6hUiWUYlibTPpHLpjB6+WGZT5hUgKPA4aF
	 VdY/CmyrYjUJ5kDzFNZKcZ69rXv4FnkSchjeIcdp57d9B7sBvgr4YwBsXT+tZBMjmuTJT
	 n+Mk26alH+B7nlTQTmn8MFShESBVq5tkPcBKc6NGwXRuQkZUN75D6Ghoj7vt/f3be1hQM
	 1iKa3PNctGMdD4TrDJ+3TQ3nnwfN/TetLZcngz1XDYsqL9T7bpgnhicQJNLuMz+/M0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f0MHQpJlt+o8iclDZnhc/oxlJxCMUfCO3MSuFBr21j0=;
	b=NccR82xccRcWqUJ1yPetq56JfsSUAlc81F86+/f60ynr9U0gxx45xLSOKMMqKzOPRgFx
	 58+BCE6yOutjZ5OV/vS9T6lRSqXoNSvWfwWM1EBQ58KFBoxFETmoBEWz9JbzCwRpTGgXZ
	 Kb7XJoyDlmuHFFd3sC3NTSshYyXhbZN4yK+ouUue4QdBxDVURBVCeWBHsaUHve+ZZ85iw
	 w8cf7kBf98wa687yIcO9Ncky/TNHqACepw9qdD4rcHtOZ6gys2HPOZyKR7nFmLd8rRodW
	 iBwJyoZpBdwT3FHMbQ+zJ8UQXszNSe4vBc4aKH/kww+tcJ68qfp7NXZTBav6CExvSvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHjWBfJB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F2B606A319
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHjWBfJB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A16E1F000C5;
	Mon, 19 Oct 2026 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428459;
	bh=f0MHQpJlt+o8iclDZnhc/oxlJxCMUfCO3MSuFBr21j0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bHjWBfJBKPcYhzsSCoM56OgS6Fa0elac3nBzn9gX6320fEbkevOIFV5uGnQBy22qb
	 ZZoQvgFc+NWndbUXbDqfrwJdQWmctGvqWX/s5QC3G1bs5cAIuuy0Hc7JMztxfetP3N
	 i9xpEmr1rOwZaKP8BRz6vgqL58UiolURH6370N27x6cT5XipHBHYTd9o8nVjHg1SOr
	 jGuUGejQsYXZyP2pplphkmADsncnRsO/eupGm2rfhw5hytAX2+1DLTM+n7hh9sMS+j
	 fQrjTGbf58zxBMfhURDEYabqm7S4N0oBDIm6f9qbpgLbn3eFcfXIc1Te/juZKbTfhh
	 ukzuZ4wRVfEdA==
Message-ID: <sashiko-outbox-177934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] perf jevents: Add support for NVIDIA Tegra410 CPU
 Memory Latency PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019164241.403644-6-bwicaksono@nvidia.com>
References: <20261019164241.403644-1-bwicaksono@nvidia.com>
 <20261019164241.403644-6-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:47:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add alias support for NVIDIA Tegra410 CPU Memory Latency PMU events.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019164241.4036=
44-1-bwicaksono@nvidia.com?part=3D5


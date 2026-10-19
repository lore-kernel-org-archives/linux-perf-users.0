Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428471;
	b=4PX69p7lefLjOlJlMFWiYqw/5v3lXhYHYQxSIaCExDLDa8dt0XVbcOK+xTzWerUshh0s
	 Cqikt8t/qvT+2Qm3+0QUEBD7wYsdgJPc8I/Xzub8uRFDPZkp59Zvp1noosYNfhCpu8fgs
	 yxkqMtHJ7j4OmRLGNwq5cZdt1p0EgY2ZN5R+TjX8Ec+AfKcMnM9p8zVcrexKh5wzV3S01
	 ilqdExAQkM4sRTfhZIgjAVmxJbANnVglLkxDQDyRl2vCT7thKRnem3i7FC625QxApHwew
	 r+RLABZYDg2S9kIwMjFIWNb1Xh/ObpYTfZr1YXg0WhAj0jaNPFHNApdnQIrfFU6KYdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428471;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gjyFXTCEsPRlbIsbWsjCr3KJGRVAphm/U1ujOfJL/cw=;
	b=p9qldOxevNtN8ySNhCNEabRSUh+2a2cbk4oXJ4Ho6ExDVpXH1yo3r21ZPRTq0eVXi9ze
	 guLgYFqO50ml/0unRdy96gM5KETxiU13baDPFd9zL8H1ZdHqYBow9H+vxJslwaTo+NIQ5
	 4CA0y86QtED0xsRtcMlmGWHii6X0+KanconRa+QuayLsd1pE03Ecv5bvAaZ9BIgKW+aiy
	 VzejdkXWDF/2Z0XDMQbo9ocL6odgxscrF+TcuSFcqT49FG+7k9Qv1neehHWNU0pl72xTu
	 UffK8ec5YT84samrI7VqpdUjYSyqHy7igDBk7WdMWBrB5C9Zo2px5R7pp9E/6CgNicQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EXP86+rF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2F606A324
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EXP86+rF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8B51F000CA;
	Mon, 19 Oct 2026 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428470;
	bh=gjyFXTCEsPRlbIsbWsjCr3KJGRVAphm/U1ujOfJL/cw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EXP86+rFBBJA0kppk9HmULjpuFbjVL2kDEH73bZhiWQWOID5Oe3THlbv8ByfHK3R9
	 dn3FNnw7i51GjobgsfH39wgdecc2gKLk/B+fb/NYp0AleCTRxOpt5c95xbOrfKpj24
	 8xztJT0L/U1lNfB/1aN6P67dciUVqB89by2sDsrnch2eY8wb53x0xetJIAHtCQoMNB
	 lz1K+EdDJXgiCeXO9U956aPWrr4VSTV7cbjTehfxlhajTAZmInPcKWJb6LgeAuBp+1
	 RREz7gBbaxYHelp3daGU+zgnW+lk813jRuhm7pIpqaCJhL7BLOx3FU3jHs4pZhjd2z
	 VE0We9+uY1KwQ==
Message-ID: <sashiko-outbox-177936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] perf jevents: Process model files before sys
 subdirectories
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019164241.403644-2-bwicaksono@nvidia.com>
References: <20261019164241.403644-1-bwicaksono@nvidia.com>
 <20261019164241.403644-2-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:47:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> jevents walks each directory in name order, mixing files and
> subdirectories. When it reaches a sys/ directory inside a model
> directory, process_one_file() flushes the model's pending tables and
> switches the pending table name to the sys table. After the walk
> returns from sys/, nothing switches it back, so model JSON files whose
> names sort after "sys" (for example tlb.json) are added to the sys
> table. Sys tables are only matched by Compat against uncore PMU
> identifiers, so these core events are lost: perf list doesn't show
> them and perf stat rejects them.
>=20
> Visit the files of a directory before its subdirectories, so that all
> of a model's JSON files are added to the model's table before a sys/
> subdirectory is processed. The generated pmu-events.c is unchanged for
> the existing event directories.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019164241.4036=
44-1-bwicaksono@nvidia.com?part=3D1


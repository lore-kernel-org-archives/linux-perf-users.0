Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941116;
	b=DTSaiARP7NBbwKfXYl4TYxZGevxhov4jf5g8+2hCsL4FK8AEg34vUExqWehMyCamip8L
	 JTtiw68ErujgjVS2HxukEbM6sw+r5Aamqlx+pgG2dFqvOzaus5l4Nq0NxSEDeHWHkbKco
	 M2qav8l5y/ECEfs5IkT3L+hFoRjhQtcHDzy65IcJeyUvebTkfWjawdRziAZNhCUCsyB4Z
	 UYGqHwu/QD7m2zVNkzTH1YUjYoad6psHs6gFsWoN+eS0rbSHk1POUACSmhVDDozCVz4WA
	 9Spg99xvQfhUfw1A4fuwg/5ebQgDvtXZMhH1fPts0ZcFZNMwOOu8/auPxRnGf1Ax3FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941116;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GP4RUtDJs9Bf7BNNXYP6fUS8NpO+lqNbUQA487eN+sY=;
	b=tt7QgIsv9PUpym3ZSvds8ujzzML5qQA3CBtPeeAu7SFqCkHDpFFHL+QopmEBW6Nby8Lz
	 mZwKI2gAD4Ih3ZibQyBSvusIDjS6y8PXQzWRqtHwfL0M9Iq+UPhxHqJD1XtpU1ytbBoWN
	 lrCGJ9+RLWRsNL8gGkvEYIilVA0gyzXUs5c+n72KfZEFBe3URMlvDHMme0DkqQBXduTzI
	 OYesbYsWqb8kKCsbhkyEZXNe8D6vO1KSIsljkKOptnh4keyWVK/vGwQNVh2yC29uuL4sj
	 VIHiPoNp9H8rlt5qmU13qIEowvA14kD4Fvtuas1nql3eM2sliK6ystzYoVpOE8uhxww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6UlwhAM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00D0606A328
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6UlwhAM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4EB1F008A1;
	Fri,  6 Nov 2026 04:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941115;
	bh=GP4RUtDJs9Bf7BNNXYP6fUS8NpO+lqNbUQA487eN+sY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H6UlwhAMI0j1FGTW4gfTrZk+dDwi12NEHDjrfrR+al7DJVMS+I1XAs990hnshjdtq
	 0gfbu2dBAwfia5IXdtJxppB8r2f9WGrzqSkQI6JYD+b16GrJUsc5vC17MQzNbAq5AP
	 ljwwuf3A8xifdnFFk6HKJUT2I5mgD09HlIuKE8xv7vrzfKypxHZP2NL5fPLSCh+das
	 fxmDokks/m5oBZ4zCHuLlHzyjihUSOnaeLK2bizhlBSHAdURsWzmMCjAuVkIrTac2l
	 aDtYGSYqcQUtNaFi3kYyN7Y6WWPIMeiLhZCE8lhc/vi7gygiausIfJ9NqJftpcjazR
	 quh85LbwrWSWA==
Message-ID: <sashiko-outbox-200782@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 09/20] perf/x86/intel: Keep LBR frozen throughout PMI
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-10-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-10-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:58:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> For the platforms which has 4+ PMU version, streamline LBR freeze is
> supported. The PERF_GLOBAL_STATUS.LBR_FRZ bit is set to freeze LBR once
> a PMU counter overflow. However, the current PMI handler clears the LBR
> freeze bit too early, allowing branch operations that occur during PMI
> handling to be recorded into the LBR stack.
>=20
> This can pollute or overwrite the intended branch snapshot, especially
> when bpf_get_branch_snapshot() is invoked from bpf_overflow_handler().
> In that case, branches recorded while processing the PMI are mixed into
> the original LBR data.
>=20
> Defer unfreezing until after PMI handling completes so the LBR remains
> frozen for the entire PMI path and no branch activity from the handler
> is recorded.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
> Fixes: 425507fa5f32 ("perf/x86/intel/lbr: Optimize v4 LBR unfreezing")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D9


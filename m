Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423067;
	b=xe4eDt6ZW56uXrhn2NZ4RT9c+BuETKGsqw7oeXpz5khKEOp+EdqFehB4tkzH+PChd9fD
	 p3J1rKCgHp8lKZdXgXXJbnlM+FV8jv5zTrqDbiGk3GUPw9klff5EeoQqZ74/UyjNk0rSG
	 bQwn94agOf5fGq3GzwqXO1EFItBzfUN081Eajjto1DwHUw92sG2gFzBtAXIC1EuJ6zcDV
	 7ejB1SwuSaZ1fO6lNnXXgKrpz6IMiLZkaJxkeWo3aqKBHdU5u85tW3IEjgb+1t9O1QICS
	 vk+H7ecMkMOwQxUL0exBoBzjUWvxRwoswMm/y9HzhEScDKdiGRXN6qsoGaSLshM6GAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423067;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sKPZteKV6Beqmao7zTB48lVrecw5khKAPY2Z4geM8IU=;
	b=2tnsnv+gVZzRhjDh0BHQaS+T9vWFS9fkL9d/9smRLFcm15A8GRYGukf8TTiBGnkzXOeD
	 j9qiX9RyvRb97h+tfwOLu7LYldXAR1buNFroNmGI6SHvhSAU4MWYaKoet9+M72CSwnwlX
	 rRhf04FeMXtZx619enSDqehuuVajVMucJYsU4o+WJ/rvnZ/zyF8D+la/O2AKfvfMXVofI
	 st+4xiiOMHoEwlcXoaXwecCm/UAyXgYlLS6atftqogTwfDlmogNUrIW0KhZeX5HpJPTrk
	 /XJHS9A+3X0Ym+64mqfAeEM5Kv4Ge0A8ufEg/6HfxqSpmmy4uRWKq9nWu4O/sc2gH/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ar0Gp8h7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA6560A2623
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ar0Gp8h7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB091F000C4;
	Mon, 19 Oct 2026 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423066;
	bh=sKPZteKV6Beqmao7zTB48lVrecw5khKAPY2Z4geM8IU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ar0Gp8h7Z+0M0ZrNoDogdIJeMewK3b/bctAvdXhnqILm9YLnQ60xj1W1hWTVZiOF5
	 tDnJhDFASRX93wCjme+p9tlPAowZwDyZ1B86S8ZcsOt40jdilUKx81eyzjjVbQPMvf
	 NsYJrYNsJcHWP4sCtpWSCTi9Eo9SBXyGOHbVWEyPVZUyG8ujZXwvEg1kzz3K4hqu61
	 rCnTiQzAn4+7MW6+nVy9eeh7FN1+7dM3PQT1AXgUp3f130AxDf6D0VQeDxDnl5hQ2G
	 ZOlYd/gbFRvjz2jTfbHBWHQUdhxg6WM/78ncexSibAiPPAPLBzLsqa9fOt8MZXVjcl
	 DeTbu1hx9XkHQ==
Message-ID: <sashiko-outbox-177670@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] perf/x86: Unregister PMI handler on
 PMU init failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019135441.1420968-428-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-428-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:17:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>=20
> [ Upstream commit 91787047b1dc52b1fee68b07f79af70aae5fce47 ]
>=20
> Fix an NMI handler leak in init_hw_perf_events(). When PMU
> initialization fails after register_nmi_handler(), the error path
> exits without calling unregister_nmi_handler(), leaving a stale
> NMI_LOCAL "PMI" handler registered. Add the missing call before
> clearing x86_pmu state.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Zide Chen <zide.chen@intel.com>
> Link: https://patch.msgid.link/20260717080342.1879573-2-dapeng1.mi@linux.=
intel.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-428-sashal@kernel.org?part=3D1


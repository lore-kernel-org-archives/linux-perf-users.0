Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740191;
	b=ygWHjDKuureY09k1R4sL3S0WIlPY0MA7B8JQpGUpRO2VP8LcJhsE1RK2AGMgSoKRWEkf
	 edFsGoh6yP4IvNfUpfW3lB2Kwtxb+Kq3boVYD0wWAlEuzCh3XIajOxph7vwJ2QwP04zot
	 Z+jtzEN8GA/goNknF6naJJX9wwugCGNVQ+uVEcNWl8xD3B9c3dMGFMOqgBVgq41pkL8iN
	 ON3Z61yU3oghV8UOiz+q73SVBMrO0kIX1OqU8R3pAeRVpGr9sYxWDES9ZUOH41WgoZBXL
	 mi/XQUUH0VNF6u+5awY4tamDZ78j1lkNd5HD5+3+9yIlIlMIA5VjX+Z8Iij6r8OcOug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740191;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DqQaapSKV5YFe34iSBTf36phnM+WBGl8E/wmW8aQDc0=;
	b=N/J0CjvRA0lbvMgAFz9iPfqs1cT3WmQkm9G8n963QesUOVbSjaht03Ge67Qm99oXNdSD
	 8Fjl649v/VHWZOyZDXw3W+cs4Dekq1wJrE1CgAYWJHfMObO06+oO314tsoAJ+cA8Y+WZ1
	 cLqknLJl2CBjWR27CQLADyliNVMsKMhxpTy9nuSQGj2ncDHKrYV9Y0WngvirA0rjbRVES
	 TkzCnHLCzM9jPaTBTsG5kELMSkenDiQyzxUj6H8hY9bsYatwbgPmd4idC40QQ7ky9DNMH
	 6e9BD93E6tNr1zTPwgNIQoF7cInd+b/zsdILTRlfNWrRfhnVNCmWGVrXnYGAy9W0UFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="him/4bWr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C4606A322
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=him/4bWr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9ED1F01825;
	Fri, 23 Oct 2026 07:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740191;
	bh=DqQaapSKV5YFe34iSBTf36phnM+WBGl8E/wmW8aQDc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=him/4bWrQwG0jrIT1cYTTg61tZJO+C7UlOin1qgSGc2XZfpqJcZiUnh5VtuXiaLH/
	 csP8TF1nUvAIp8DZYClRxiq9nLHHimwqNBaHc5DZclS1xU+zLzKTCWsBrrRgRK2GwI
	 HDmzpX1dZ8Eso2vQ/vb37vGp6PIG/QhzTPzOgGYUzSglg8Qx8DMRmToOR2YtmIlRLI
	 SgbsDku/nq0hSyWk/EVtgQHQ//VptqRz74WqBby/pHRNrorUrvxgzbeAdBvUSZd15K
	 t/WoUWJ77jwAVJT1OOFrpWEq5SLrZno6Y+jGhiHaraEdnme4jfu+3SB+jsVnmhjzte
	 DsiNLuNHYOcZw==
Message-ID: <sashiko-outbox-182407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/11] perf tools: Add HEADER_BOOT_ID feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023071141.134149-2-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
 <20261023071141.134149-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:23:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Save /proc/sys/kernel/random/boot_id in the perf.data header and
> struct perf_env so post-processing tools can identify if it's the
> same kernel boot on which the data was recorded.
>=20
> Assisted-by: LLM
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023071141.1341=
49-1-namhyung@kernel.org?part=3D1


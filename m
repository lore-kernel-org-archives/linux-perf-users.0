Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948874;
	b=penBAcZJqiaIkFRxsHuUhzIsvVyAORDL2YgaWBRBR74fVD6StgJ07gG++UahKFau5K11
	 RSobcIwhoNdrxxzr3xlZZJCpftfN5PBUmgyJzXwpC3NYDiejIzTPDraA81K0V35u4E2LT
	 WbIqlg3nS2ggBIFPqdG5nKq/cQapiAalIUBBKB/S3O/FDC43fg8hlgwC/9h+taxyceU20
	 BNb0ce2k1NS1VFKoVG91qQgOjDPt37z55UOHn5sDPzvlUdjXgM91u7qVSH5XU+EP4XVD1
	 d/bcWwT3+cJiypheM6B/bRPyPINjuohI+2+dd6AJXzHZhfAiYXGKRXGZb8ZCvPlppZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948874;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3rpAH2I+FUnhMIPT1GEYoVwvjcQuB1qX8frTDgOa6o8=;
	b=Q2YJlktss3iwyEqDIJYF/GLc5HQysYm7NQWXyDE/DbkDFqLC0M/pNDTDKU0hKA3R1EF/
	 zEzl/1ujKvXp5FPIvGbm2JiZRcXqD+LtiuOd77HluDbNPfhHAfO7qTIkVFHntuMCSWoPx
	 lmq2PB3ZOJiEnyTitUqh2OnV1l8gKBMJUncY3cbGwsvIi+kSR5r8pPIkrBFCIigLWr8sO
	 mnNcPXPBYcyMvbBfq2gNBRuNeSgnEO2+3Ln2oX3pXT9gSldwQH3Dkss/erdXzBMML8G3U
	 YI7or42ggbcu1tboNJjP3A+3QHX/rigQdcp1CXDDX2cMsh6wDjKJUD/uVkQ5B0mOw1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3rkSkLa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A89606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3rkSkLa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3328F1F0089F;
	Fri,  6 Nov 2026 07:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793948873;
	bh=3rpAH2I+FUnhMIPT1GEYoVwvjcQuB1qX8frTDgOa6o8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T3rkSkLaB0rHBpkblM9qO9ne7unaJviQqPEpk1darW/VU1lq5vgKBOQ8980+VdZ4i
	 WCYvBE4V7eY8568Ux2LNa1vu5LptfuEBQkwODlwZxT1sb+p/5bk5ABgvrthLR9Ngfa
	 RzaVna7u89RYY/qEICFQgvZd5kQEmvY2AuApTgFTe30yx2IzNyG18wBE0/wLt0fHZU
	 zjRVHbaqNEtRf7LwG5QgT1ZD72B4hz2oSMK5kM90tJSp8odLFEyT7cEPeognCrftqV
	 EsAEGM7PCMLN7E1qevLTG+di9/oPCkIc24H7ebBuidW/uCNUjgP86ZFWKgoapDZUO9
	 sgQjE4CP8pxNg==
Message-ID: <sashiko-outbox-200957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 11/20] perf dso: Use DEFINE_MUTEX for
 dso__data_open_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-12-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:07:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace _dso__data_open_lock and its pthread_once() initialization
> wrapper dso__data_open_lock() with DEFINE_MUTEX(dso__data_open_lock).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D11


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707480;
	b=fCDeXN+ChP3hzX7JHm8bkjRHpHIrBES16SDxxnuk6l0TDwLlmOWB4FubhEjkfs7wGi7l
	 E/XPwMxjMSWwDazdeu+DpPaeWLkmb6kAH4dWplBjYi0bYutg0uOE0vBYA54Dy5hwjzly6
	 NAkH9MWPvNcjd+3JyVBbxfPUJxifX3ABnV4RgQOtknWm8k1ursAwRCFeorQR2SSp2No/P
	 j0eqAj15t/UplqlUQ68SqZsvqEQ7uboXTv4cXZhWilq+KiDL/ggWJWEn+o9+kyQ1TnSyr
	 Ce8s9aCn8Kno8q2fVN4QgPGQLMmF0buAdYemQc9YiRUcB/5AEWZ9txHhehD8lQM+rFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707480;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KHGIisqwH/Bl2cAuHSE+gjX9x1MrmovzS6BlPHWz/D0=;
	b=sYXyA4/FFZKp/+UUJcqkhE64awpV3sZO712BnwnWtzsfdjmHnqy89fta1jh7TXYOF4w7
	 4WkPWvz8B1/2Obwv9DixP1qisQnW+Iqny6iiD32uIlUT6gmnP8HFLLNDMNUfNrO5/21AH
	 /gpJYHqMO8OOTQRKLscrBj36RIDnppla39VbakAkyhmd+kimcP2EZqZvWabIC1VcDAyez
	 AOLa48D5W8P5YlGI57vIQksvADdwh6YAcguTiTaGcnDiXJjMtzgmINHiNxUF4vZ4lEoE4
	 8yE2DKUOQdr9RxIniBu6nMF8tsZe2i3cpPjTfj+VNCFfA2e4JJeu7kpnt1Iy1O32TDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLdxNACp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F5606A323
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 01:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLdxNACp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58AC1F000C4;
	Sun, 15 Nov 2026 01:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707479;
	bh=KHGIisqwH/Bl2cAuHSE+gjX9x1MrmovzS6BlPHWz/D0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLdxNACpRYPKYkzycNX3QZZheTkjv5i8A8Ls6gGI0JGIbYGMKcza5DZ6SGV/jjJ76
	 d9d5bv3B7liZ2WmaAjmaWwevys3fLRvvmd52etqHnsxDPGpb8T0pOTXQxF0RJ0W1Ag
	 vM9IeQNMfBNEBnsL3HgEKNSXU+DYnozGTiEaa3cxixme3N7l0ClNpqhEtjyNcSiHe0
	 X9DovzSBSECPQSvwDKG8H8X4Pi292ghyqfGjwLC2qx8+pu7GVYS7fXr4AOARjm6/pU
	 HqinJZY2fCHlFJMwPzZeOWkJ6A7C8NhyLYqpr47mk1EDx2r10176WK2LVV3QwGssj9
	 fNFRysWd79O+A==
Message-ID: <sashiko-outbox-215175@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/12] perf tests: Fix the Intel PT virtual LBR check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115014102.2879372-11-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
 <20261115014102.2879372-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 01:51:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The record this check uses writes aux samples, and with the single data
> page the other tests ask for they are lost:
>=20
>   Warning: Processed 29 samples and lost 100.00%
>=20
> so no branches are decoded and the check fails with "Failed with virtual
> lbr".  Record with 4 data pages and 128 auxtrace pages: the same trace
> decodes 64 branches and still fits the mlock budget.
>=20
> Require the python perf module to provide session, not just to be
> importable: a perf whose python bindings are not found can pick up an
> unrelated module and fail with
>=20
>   Error processing events: module 'perf' has no attribute 'session'
>=20
> instead of skipping the subtest.
>=20
> Detected building perf on fedora:44 on the runner with Intel PT hardware,
> where the subtest failed with "Failed with virtual lbr" in the container,
> and with the python error when run as root on the same machine.
>=20
> Fixes: 915d6b14dc0c ("perf test: Migrate Intel PT virtual LBR test to Pyt=
hon API")
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115014102.2879=
372-1-acme@kernel.org?part=3D10


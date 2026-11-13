Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601607;
	b=YhmK9H0ITpsB5PFH+JFlA0K4ToeiUBZCnols8xQKXuVIjwiXNCMRzvy0BMwW++CRoTL5
	 70Wt8dhOYBQpZ5roYb2gW2ibgGEh0IlVdsJqG4KMB95Qkd9uI/ZxtS6wunDd8Y1Uvh60m
	 FMmdKTO7cuYlQsjUHloIJ5/LRTtES7VCRWTvT3eblQGt0hOMgH9tE6rbaqbXda5MRuZLB
	 OimjLqJrQtB5HL1bWoEMp0byIXwKCyCascr7K/H4VdRkJp188RsRMqx55rjqlFFZYi9Ab
	 yHCWYhjIgo0MVRV16N+M/viJEcFzc0nLZxN3iM3I3gQ3t5FaLDfOZG52qPi5MBmDz3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601607;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FmwKn+0132XfM1jT4Ty31E/2s2Qpm1Pe2Dnkt3JBbyk=;
	b=eecPtRFAaVvCnIUyFTLzEIPPWOEMOPRqF+Z9fBGaUTZZGNWY053zJv9hzqbKD38BvzBI
	 o8jusldYo3MEaAMhqST4OpW3EiDh0/eC6roXn+morlWBOqgUdg8mvtOa4FUNJeRGlJI7W
	 zSlAf1KUlreB/36Bgf5Ed5HdeuHBt7CMbFOXN2rcq4JkaLr5nkL9fmQxgG8vADrVNrgew
	 8qQBWOmZ+g3BdrKWk4LMYfd/E8aABL5BbJJeiaeg2fHZ+Lyg4SaZZd8JABQE6OOkbI3b/
	 fk3OWlNREJ+W2ouMT1DfIstlBgy6YMp7Jdo97NadSFscCG9J79slIUtbW475M2Vl7DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVPsi2Ox;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041D606A8A5
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVPsi2Ox
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D641F000CC;
	Fri, 13 Nov 2026 20:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601607;
	bh=FmwKn+0132XfM1jT4Ty31E/2s2Qpm1Pe2Dnkt3JBbyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVPsi2OxiwYbyj6yS3lC+zAzC8MfJSABVE4KbQZhJG1YNPbVpyz7i1sWrF6q3Itnw
	 74Ppbxoc1a/7SXXhJDdAavkMVu9sAcFoAs+/y6l3jEgqbIzjLL6q1xtDfJM7WRLP/J
	 +3ZK2ItZMHgrCAFMwWdOROcMEnqSJ0tRD14Y5WG3u1saqPvNjlGENCO6qoMoQgcDg1
	 4vYCGp+QXZI90aBXtQdwoTTlw+Vnkog7Lar37ozFRZSRMSwVJsJR85xQtxzSFgAbXv
	 q8EtH2/LDhCh2v/iTTPkjE4etqndSNm2FwnjsNdCXwzeNl5Q9/oN0N/poVvUgXJYq+
	 cYpTmShdZMM6A==
Message-ID: <sashiko-outbox-213640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/11] perf tests: Exercise data type resolution from
 a register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113200850.2803460-6-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
 <20261113200850.2803460-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:26:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> At -O2 a struct pointer lives in a register and DWARF describes it with
> a register location, while the unoptimized workloads the data type tests
> profile keep their variables on the stack.
>=20
> Build a workload with a noinline function that gets the pointer from a
> volatile global, which keeps it in a register, and check that its three
> member accesses are resolved from that location.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113200850.2803=
460-1-acme@kernel.org?part=3D5


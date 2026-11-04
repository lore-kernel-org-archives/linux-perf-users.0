Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827191;
	b=q2Xz9Bgs9XGzySFZdaM6ryoWEVtVefeQKuQTbWNkrEUqH2/E69snPJIKhFYpxlvlZ7lh
	 2w1l7HbRbU/2TsQIGwupHnsvv07tzWyFgf9wJWriFFCC/1lohv70MBl69BtqgZnPqVUUv
	 7sJ5r9X3mF9cwrigxJhJLgfbFj81MlWQaDLPi02eTT7nxnFUjJk3bibI6OsUAEkxhnN6P
	 Kh/U24YFrf1MgWYkVs/1ft7khD3OhDeg8uDR/R3/xjEskmRSr8ATmrawsdGCKbt/1pOiL
	 t6gQ8SEjPUbWH7kQ0iGUGEqoGm2r2HVA6GRTDpdgeE0Ok7cA/g3CUJUyVtoxTxI8dmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827191;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CJ4jopF8YWJlYP770Cs5eVWgDtLEa7B1ZmFeN/USPw0=;
	b=aJXU53EvdXlUP0lSKzPyYPSEpBS1u+lllDcyhWz3IXVZzcrI8qWC102A6kFvHdMLRzyx
	 +zSqXrlUCOmfbyBb1L8WdU4suLSDFLHBajHSpR9MsmuwOD6a+dXeTi0c1L2efzAEKo7u6
	 ok8PJbN1ouxY1usq++Z/gMVzHVU2Y7a5oVS36DNpb1qWrG1P9uIisp2ejKOCTP/OUb3yz
	 sZonVPxEIklZO9U+93B837m/5tKzCKlK1NbzgWD//3j6OPgkHUAAnDpBUCyl61kobHDqk
	 2edsTjKCq+9NGGm5iFgxc67gbdovdPhNa5AxXihX1nqAkcsFm80KP1qq+6qFn3c8PSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PK+b3Owu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40491606B2C1
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PK+b3Owu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CF31F00A17;
	Wed,  4 Nov 2026 21:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827191;
	bh=CJ4jopF8YWJlYP770Cs5eVWgDtLEa7B1ZmFeN/USPw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PK+b3OwuALB+JTBVZi3Af9SY7YmH5P1Zuw1RcBhAxd9bY+fAwSh7kqSK9v4cftUHe
	 tSK7/GywHb9Lhc/VIUBRsCFwYi7Jp1WA72OYxQMD0+w+Q4X3VQivDTDv54SReyK3Pn
	 4bxrbAP03QIclF9Il1i/YB20lWpiWooyN2n1+ibIrQXfx2ayVo6IpFbrIp0J1wTEht
	 e63U5h+XjZDX5+f0LCBsKpW+UyYOxXljy3qrvefZ+s2Lc1xevnkdpcGv+62Z/RBmdd
	 +uVPyw0Fte3F+vBgxzf/+m9ajoxBqaif0oTm4cl6o1hs/Qe7LaNnK3TduJhEZfA/Cr
	 md4nR9vKh7Iug==
Message-ID: <sashiko-outbox-198095@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/19] perf dsos: Ensure DSOs in auxtrace, machine,
 and symbol are in dsos
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-10-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:19:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Place the DSOs created in addr_filter__resolve_syms(),
> machine__process_ksymbol_register(), and maps__split_kallsyms() into a
> dsos collection so that all DSOs that may have data fds opened or be
> referenced by maps belong to a dsos collection.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D9


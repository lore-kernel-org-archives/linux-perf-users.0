Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884471;
	b=N+6ES4UneUyOw9ETvK3Xy+arZpbC0v3S4Ba1CLFvhrhTJEMC8m+jumK1jffu6AOUYL3u
	 YCat5u1kiFhpyyp/hmp6/XvI3TMV4z20TRf6JLL23e0Ts97fSDDPLTtKNcG3K0fIAzy7t
	 RHnXw8SsIO7dbsZzY1E3WB7rbN6sAFcxmzFAQVkiI5Zp/5bFra8uMCadTaFRHww25MtUo
	 vnDrA+XOcJx6AylltpTK2cQDadwsXddynFN/g3iDNy4ROqjDopzyPoQauO7bNAiIcMyUD
	 IhlxLGuC0VyeFtbFn/nE7VdWYjesrL+eVkIZDLrVWiC+t0paJXF6dSSjtNzIQbPRFSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884471;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zNuy0Kcx3fLrYXyQumCV+mtIQlg12KikOaPMryCLbWk=;
	b=pjYy9C35scEE6iRNAzPz2umnT+Fecl0Y9ohLheQH2kAjWJQMKWnrC4kGY83I79c74nua
	 LYVSV5buW/+yZ9ncYeTHDTYaVMbNp+sSawWmFjU2LHe3n68NPkowuYSr+vhao/cWTf9RL
	 kgn57fZnTy5Qs0Exg8cBbNjRFYV4syCnUaCr7M0+w1gs6odjOJri29rnv9k8zwEOb5cSW
	 T3DxE/zSQVBsShB/DEQYwXS6hXTzBIEBavTikcwW8zugiRg/X6cJWrSgvCCY+QtMGzsm/
	 ig08c1g6qQU21qsdlnYUOxg/+oPm8iouJDAdVK+OgvAxMInHgvEXFbbu5XNBGBr9WyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mtcbI/wW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF0D606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtcbI/wW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7A11F000C7;
	Tue, 17 Nov 2026 03:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884470;
	bh=zNuy0Kcx3fLrYXyQumCV+mtIQlg12KikOaPMryCLbWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mtcbI/wWN9m/d0I972jAsyYt8RPS7u+rkTU1++XsUUNUK/SXmzLfz3skFrDpvGXcv
	 ZMKfmD00oja7+dQUAgT3Yv5xqcoatPML3u2YEhCGQGVrkT8SNDzLIdeXNhQDCPSRdH
	 z9thEclva0XCEMaHug3UI6ZnOwP//eBCcnYgtyC/620j3SMFCOuRemx2OfCeZ+fnER
	 aH/5W2313jOIBebVE+72Npg6ffIjlEiETHB4bdctUyBK8YOPB0+KAfqddLjOCLg9WZ
	 1yZjB8D8yet39b2DUf9HRB1WahRPtwR0vDr3b/O9S52whM0MJygICC+zzqdJidetmr
	 gNpKK9uL8tn2Q==
Message-ID: <sashiko-outbox-218107@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/12] perf annotate-data: Count flexible array
 accesses for the whole struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117025305.3958882-6-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
 <20261117025305.3958882-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:01:09 +0000
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
> The per-member percentage sums the histogram entries in the member's
> own [offset, offset + size) range.  A flexible array member is resolved
> past the end of its struct, so the struct row only covered its declared
> size and showed 0.00% while the member row showed 100.00% and the
> header said N samples.
>=20
> Take a member's extent as the end of its last child as well, so the
> struct counts what was resolved past it.  Union members all start at
> offset 0, so a plain union keeps its size; a member that is itself a
> struct with a flexible array extends the union too.  The TUI browser
> accounts the members the same way, use the extent there as well.
>=20
> Extend tests/shell/data_type_flex_array.sh to check that the accesses
> count for the struct in the percent, samples and period columns.
>=20
> Fixes: aaca646915a1bb53 ("perf annotate-data: Adjust type offset for flex=
-array")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117025305.3958=
882-1-acme@kernel.org?part=3D5


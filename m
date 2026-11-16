Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873302;
	b=z6g/eZ6ZsBgc0SizV6phdk1kTlNrB8+xju8iOW7XJI/YJxUlj+i+k99uBSulriqqUSoJ
	 Ybac9iGhxZaOiqRZPUccszP7WHhTeOHZowinophhmLW2VgiaZ8GmuvkumdBKRq/VyVhZn
	 uoZ+8FQBsHl1mUgcTdJliTB+gXrTTuHvquRij390CidoRtCO4Br7S9818hrAQGWQWYsO7
	 g8l+eplC1KGWzHV1iovX6ZsNRUcFYsQ4kPRi6s9rjYNs4vDV5E+7f7BF99PR7uMhEcgS4
	 9hVLA/JkkQTckhF8xaCwHWW7es/elBd6illh/M1D0dXDlN27wskEKw1+PCFe5HX1h6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873302;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=abFCMoQhgsqPVonJqFZEo0m8wmoGahVfLLFao2akKpY=;
	b=3zie9OhhXihpTDknHlKCxuvHACVkAq6W/GZlFhCKrbfFhiGragcOcPSYDkYSYDtUvl07
	 10WDs4+cxTswp+UFUslJ2exjcSA0DotKs78OXLBWE7Ar1liiJiSMFtwi+RMtwDMLKxivO
	 QRCY+Qmbd/HPsr+pmAWJ39+B5LLn50irqwYCK7h8gdxYQLlxNuDc8ZPvp41ULrX9Y6VqY
	 2v6W7c65MuL21pyr+t/YqQ6TSRnMX+QPbI483r2iOqXdd7+aFeEKPAlAud4hiTiPip7VU
	 nU14BfB8C3SGnMsWje61G0ZC0bY1EJ4ijsss9/c9WoCpsvYgEQGgy0FdacXUMxILMJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mL5B6LB9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A01606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mL5B6LB9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AD91F000C4;
	Mon, 16 Nov 2026 23:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873302;
	bh=abFCMoQhgsqPVonJqFZEo0m8wmoGahVfLLFao2akKpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mL5B6LB9u5/QbGg++OScPMFahtUZwxsrDrPJks01SgQdni1KKRbjAo4jQoe9mbZq3
	 i1d0juVbLU2XGOdGRXxJcL/mvkb05K1bOaMuzkRrtLRoqpIhIxkzSs/7fTF05y//xa
	 9bvJuZPxkuXueNpPsfLbCRASvijQ60A6AxEblLes8vVfKStlDK3td0iDAkJQKTf9yR
	 xoQ8oZL9nfPAWZO/oumRqu09FJeMmhgqrFrr5aM0PFaGXloCHOuTDm2sJZMAto3WOf
	 0yL/cqfoh5Squx4CDJik5cKskkJ8MQZPhVJ5dQRBRY5Lg6gQbVHTJRrx2vw6sWZWO0
	 95QSBfJV3sQ5g==
Message-ID: <sashiko-outbox-217938@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/12] perf annotate-data: Count flexible array
 accesses for the whole struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116234659.3950531-6-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
 <20261116234659.3950531-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:55:01 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116234659.3950=
531-1-acme@kernel.org?part=3D5


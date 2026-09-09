Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C013C1D7A;
	Wed,  9 Sep 2026 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986957; cv=none; b=ZSjw4j0LNIA2Z2MosqmCuKS7V8kL9CGcf2LI6m6neXfH6yptS0QT2cfHpTbqaie45I3ENJmG/6RnUF/xxES7Dsvi4Mfh5EDtDIXjuHVkT/Nl53MPczYAFVXLyNXK+a4Lr6KC+AA+nW7jGTnDEIHiA32cicKYbCY8Dz+c7hpgoBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986957; c=relaxed/simple;
	bh=TUuGgzMCj9vUCJJtGVvWaqAjTrW2USfCMA7XOFSPJhU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O0lS+gNeLs1+llrzPRuJ6ijx532vuy2XLEofzNMsdCmDFnjNR9YFKNtBgsB/0PyY9A0oeI6UZFy3qIuFPWKFo9mlUPEFZDOEEbBmoF4UcrWNDUP7PMwvuIsvPhwuE97ABU9yElxEjE8ulWtavl06srnQfYO2+QdqxRK2fTfcy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxfcygCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxfcygCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4781F000FF;
	Wed,  9 Sep 2026 20:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986952;
	bh=TUuGgzMCj9vUCJJtGVvWaqAjTrW2USfCMA7XOFSPJhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GxfcygCJ7j4JDk4Hx4yWVUUvsfUVkSN+x0l/iITL6bTQvdHluZBS260+R82WNO1Ty
	 RN1HA0SilCwwlmwwT4meJhJ27PqW+kOU51SiRyWNVmC0y/TWBmp0PK6C6oA9T7uEzX
	 9Cdlg55mgKnkBj94vlGGu+mIOCJi76Vy3W71GIxpOKGE0JpMzIhWj4qxdtgMuJ8KNT
	 6ASUsLXG7wmTh+ct+y0BVs+feBzK9U0gMFfoIoCUYalygdtm53DUM/jEHwzB0W/ED2
	 kqoKF8Nq+noI3YOTfHo3dugnAvxFZBINM+jlLp7jDKJX7Eh+SgVKE+fvlm3c8jKfnm
	 tqcDeCGCdzyaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] tools build: Add explicitly sequenced -lzstd to
 libbfd feature fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260909204122.1993010-2-irogers@google.com>
References: <20260909204122.1993010-1-irogers@google.com>
 <20260909204122.1993010-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 20:49:11 +0000
Message-Id: <20260909204911.BF4781F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Distributions like Fedora currently ship a statically compiled binutils
> libbfd that natively depends on zstd to decompress sections (e.g.
> undefined reference to 'ZSTD_decompress').
>=20
> Extend the testing cascade in tools/build/feature/Makefile to natively
> probe for '-lz -lzstd' when the basic fallback variants fail. This adds
> the generic framework for referencing static binutils across all tools.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909204122.1993=
010-1-irogers@google.com?part=3D1


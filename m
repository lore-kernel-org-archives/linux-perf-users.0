Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C8363C59
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404173; cv=none; b=huypFlK59KT+n/q6/alF57cj5Ow/CmWxYcj+hZeOaTyS/ncKSNGmS9IwTOng3vxTbdbmdMaptZJZHMdCSG6v9Dx8vXk/EsJVEEk+StUZQ4hyEuN84ckiKGkfmubIDFFojUr/RdVkS/yUdqC1S7ExFxRFmBNqleTj0JjDpJdWzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404173; c=relaxed/simple;
	bh=wytbsIgrEcVNFWYVn9PU3Lc67hqHBeZHGji+FB4nggA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=audipled1SouEg/uyZJtIKf5y6xw2azR3n9q2Y/0s5K4I9UZE+K9xGAKeuaznjl0JKc8gY+iJffF31mxyyJ/M0Ge1M1ovgRjLN3yu3Uufqzu0OlwFimQcIjFoeNA+Sjab+LqpZp0HxMJ9N6OPynXPvGj4UuXUXRI1FhTYad778g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaBz3Mu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaBz3Mu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88AE1F000FF;
	Sat, 26 Sep 2026 06:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404172;
	bh=QP9hRW02j/uzyDRiKf76FKq/4f7fKSW2LcjiyP4ls34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NaBz3Mu16dXVZR/fAKfxYWT5TmvRy8ubu7QzluuQnslPkalk085DdcpVSIloVrFpX
	 eqy7oHkXElzJJCEpaG+aZEMvkdz1Yqnyw6SLspEmniAlAUxX4KsWxv71ONs1Pg82j+
	 ATs+U1VR3KMXInihJ6YwWzfaXZhcpZE8Kq5BfjMDse+rywLIKEMCZCOyUFqfRdeCxE
	 8dFiWFcV3SwCIo16gonhIlZLOY7N8ie4LxVOp6mcYd6Ljm5UlQ9y9IIiHDqEdupby6
	 NO2IpOpGCIwtXUXlvN+1UXG3CPPQafuA6m3qDlgjLsYPQpC/tf6sCgti3w6onYmXHf
	 QK/g9VIuHUN9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/49] perf python: Port mem-phys-addr to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-18-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:29:31 +0000
Message-Id: <20260926062931.C88AE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port mem-phys-addr.py to a standalone script in tools/perf/python/
> using the perf.session API to read perf.data files and profile physical
> memory access types against /proc/iomem.
>=20
> Improvements compared to the legacy script:
> - Parse the full indentation hierarchy of /proc/iomem into a parent-child
>   tree of frozen IomemEntry dataclasses (instead of only top-level
>   indent-0 ranges), resolving physical addresses to the most specific
>   sub-range (such as Kernel code/data/bss inside System RAM) and rolling
>   child counts up into parent totals.
> - Support profiling multiple memory events in a single perf.data session
>   (keyed by evsel name) instead of assuming a single global event.
> - Add argparse CLI options (-i/--input and --iomem to allow supplying an
>   offline /proc/iomem snapshot from a target system).
>=20
> Add a shell test (test_mem_phys_addr_python.sh) to verify the standalone
> script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D17


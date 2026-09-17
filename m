Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03753E4116
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621193; cv=none; b=UEb1AAgVxpRjRFTyS/eCm7SgxKsbYXOWMkcBGa1iJNyn9QU6J06/8xWbFGuQ3mEBw1VzsnLnmEeTbHGwDcnDUQFNn5l4UjUxb7OPH7zR8vF9wM82GNgai1dwphe6nyxe4Bw2OCudZJ4RWTbLBrWizD228uIKA1eTIG2AO6BxkZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621193; c=relaxed/simple;
	bh=fnMg8JpHBFdnDFfec25STurje/UepLCngFrapA2a/f4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S0btktxrFnsWcXFian3sSNtgDwezqrfAzITbHg7KdOeZwd5TX7bTPApq3oMdqPxScwNG5X7gF7tqfvPVbAng9H6Vc3Rw+AWObZaVSBpid9utBaLxwE5HtphuoBxQ8yKIC119Xyb55X0prfx2n7/0ubj2Sr29vmD3FB4lf/MgP50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGbmmdkv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGbmmdkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48921F000FF;
	Thu, 17 Sep 2026 04:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789621190;
	bh=TaY5RewuTDN4p7NuFucgfb7xSifLJs8QdTCzh29zp+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gGbmmdkvb9yxGhKrxzFELCMFTx2hBoQGy4Xlefb3WXCfyD1R6t8MoGO0WDd73L2VG
	 4G5Cj5dqhfNMatyUkQ2DaH4ssMhBA+rdmMKuCTvBLEQXWwys1pbxgfwls/wfixvCsn
	 ftYyDunHU/fOkbxDyrIG3VdrHxEUp1CCwsBON/kqLlFzQgQz9a0mRkuTRVoVBh1hQT
	 1zpE1R0SeRVp7/xZmrVPxUwljgOvASCbj/NvkwEZX4NNYxaTuqMJ29ix0ZQ7+AER4L
	 VtsvLWGiYiAH/ZcIaIov2s+vxJwYWfyV5cSy8pUzti2OZgzVKV1pjFfDvhVOsuUEsR
	 KwotFhngpNA/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/11] perf dso: missing POSIX headers string.h and
 limits.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917045326.63601-5-irogers@google.com>
References: <20260917045326.63601-1-irogers@google.com>
 <20260917045326.63601-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:59:50 +0000
Message-Id: <20260917045950.C48921F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko reported:
>=20
>   When building the perf tool on a system using the musl C library,
>   compilation of tools/perf/util/dso.c fails because it utilizes
>   standard string operations and the PATH_MAX macro without explicitly
>   including <string.h> and <limits.h>.
>=20
>   Functions like dso__read_binary_type_filename() allocate arrays
>   sized by PATH_MAX and perform string manipulations using strncpy(),
>   strlen(), and strdup(). While glibc implicitly exposes these POSIX
>   definitions via other included standard library headers such as
>   <stdlib.h>, musl enforces strict header dependency
>   boundaries. Consequently, these macros and functions remain
>   undeclared during preprocessing, resulting in a fatal compiler
>   error.
>=20
> Add the header files and use git clang-format to sort.
>=20
> Reported-by: sashiko-bot@kernel.org
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917045326.6360=
1-1-irogers@google.com?part=3D5


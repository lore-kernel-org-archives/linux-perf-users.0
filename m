Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578339B4BF
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977892; cv=none; b=djViT5DBWRejd5QH5SioiwWmfpHCHKMV23RLtmG1fpyG6BDepO5fUwTUx6x4JjuRx8pHOmh6T5YFokY/ouPiUDGI/hJKb6DJOQ4ZaKKh3I01jciu1DimTnj03GFykCEyrp1juunZvFgY6GhkPQY4EirTyC5lhL7AXqot0ln0W7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977892; c=relaxed/simple;
	bh=7jetbiHdyZF5EQY8HewCDvfmgCucNopFYXPWkbobmaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qz6LxplDdGAjyOgnOzOuEZkQoCBEyM1WvL1tD92lsR3hT2AxQCRWiEeeyv6T1qHchb/9fNe7tuRsYrp1gb4yTiAtUPAk8aK/CEf/X1qWwwx9/SUV6mU3b43oA3Kp5yKp4P9QrJHnm1Chwh9HBnhN0jIwFbugb3GGH+Ci5q5G8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URI77q51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URI77q51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C988C1F000FF;
	Wed,  9 Sep 2026 18:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788977891;
	bh=l/GEI69K642c1erAtPk9NS9SfqpVUQ6xrBIGYbLQwlM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=URI77q51zSBlcyPTzsbff4YU6fLyCZQe8MM4NribN7KZvl140o9updZlAlmdQSaag
	 ImjbHCsFvMdCLPZY5s3VQpWUg4VvaSMm67VI2JnQ7iycKdM2mMkXm6VmC3wUPJodM2
	 rL0RAySncENH4U0gh/pE8R4mC4AGL8GQSWAnkEIrrL0/0hG4m3TlK46R5URbOyJ1i4
	 9yVmq1KgO+3rPKM75KgbxrR1mWPMOFLt6dQWotUwRjfxR/uHVLf7jzmXHFEmczvQh4
	 Oa7m2ascALhYwjas9kPx5wTmZmRpoJPKMq1rz3xLpmbo2aegBAEwWR7Hibfm/nfW2M
	 cH5Y9YOUy1HcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] tools build: Add explicitly sequenced -lzstd to
 libbfd feature fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260909181030.1870496-1-irogers@google.com>
References: <20260909181030.1870496-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 18:18:10 +0000
Message-Id: <20260909181810.C988C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added fallback feature test 'libbfd-liberty-z-zstd' is=
 never executed, making the new libbfd zstd fallback condition dead code an=
d failing to fix the link error.
--

commit 5475f00ff10a072611b6ed7d2a3b54cfea18c571
Author: Ian Rogers <irogers@google.com>

tools build: Add explicitly sequenced -lzstd to libbfd feature fallback

This commit extends the build feature testing cascade to probe for -lz -lzs=
td
when basic libbfd fallback variants fail. This aims to natively support
recent distributions that ship statically compiled binutils with zstd
dependencies.

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
[ ... ]
> @@ -905,6 +905,8 @@ ifdef BUILD_NONDISTRO
>      EXTLIBS +=3D -lbfd -lopcodes -liberty
>    else ifeq ($(feature-libbfd-liberty-z), 1)
>      EXTLIBS +=3D -lbfd -lopcodes -liberty -lz
> +  else ifeq ($(feature-libbfd-liberty-z-zstd), 1)
> +    EXTLIBS +=3D -lbfd -lopcodes -liberty -lz -lzstd

[Severity: Medium]
Is the feature-libbfd-liberty-z-zstd check actually executed?

It looks like $(call feature_check,libbfd-liberty-z-zstd) is missing from
the BUILD_NONDISTRO feature checks earlier in tools/perf/Makefile.config.
Without the feature check being called to trigger the evaluation, will this
conditional always evaluate to false and act as dead code, leaving the build
still failing on systems requiring the zstd fallback?

>    endif
> =20
>    CFLAGS +=3D -DHAVE_LIBBFD_SUPPORT

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909181030.1870=
496-1-irogers@google.com?part=3D1

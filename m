Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2623BB699;
	Wed, 13 May 2026 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708412; cv=none; b=iI5O3m5KMxX/UHjt+QBKQ3s3M0I7ANloWTuqmcnGE19BO+D5EK6RliLJzwSyYhWvE6CYa7u2RY0KqEIEuJ0zoLke4VVBZjyUo1C8O3YvDAruPcmr/TJ3fjVdE8NWNJpT2F3aifOwsZoEWDjo6aVrp/2Dqa57XHtUXuQaQ5vwd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708412; c=relaxed/simple;
	bh=cbfovNGF89sVDuNC/GhSlOseeN9bTKu0cefZn5InWWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y9WyQ6pqe1DjTk7JDOqewoeG96dBvtMEoAUxAaHm5hOkZNaK8G52mEm+ysary8OmAgm3ocAaotDEjMdnLWB9FAWJztOspwo841P1hK5es0e6J36P6+mZOTi49eus/JPKRKShmXxdggKcdvhNzgDVsRxSF9PGcYpzt+H+VKfoJNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO4Ml/xc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO4Ml/xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96DCC19425;
	Wed, 13 May 2026 21:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778708411;
	bh=cbfovNGF89sVDuNC/GhSlOseeN9bTKu0cefZn5InWWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nO4Ml/xcxZkvvwPK/m19G0Lbxb/EJS0GEaJWNbYfDRu2w2+zKkjgfyO8qXxWTIvNk
	 p86+j2l+IlbnvXPT6arEzJDpyrvB20rvgcUyK8uI6elL3LgjRtUhiOGJadRnwk4czp
	 tIScmpiPh6Bo/fOOj9HjP1vVZbEKQ35QSAvkANc2WcjRo9psu6rRNDYZ7za932+3HP
	 WxJ3ZHYHQWyBaVW5oqcf1WK+9DKHJFKj3Yeomb9O5YgfE4g1G1L9IX9jYm1pqgV/32
	 z74O8PRdkKck1NR41m+eaWPYp2xtMvIKy1MF16APlA/eEHGiu6nT9iOMZ2SkiEPij6
	 9K3LcVdHK1LSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/14] tools build: Integrate libdebuginfod into
 test-all fast path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260512053539.3410189-12-irogers@google.com>
References: <20260512053539.3410189-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 21:40:11 +0000
Message-Id: <20260513214011.C96DCC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Short-circuiting `feature_check` prevents necessary re-evaluatio=
n of features falsely assumed present by `test-all`, causing fatal build fa=
ilures.
- [Low] Unconditionally adding `-ldebuginfod` to `BUILD_ALL` breaks the `te=
st-all` fast path even when explicitly disabled via `NO_LIBDEBUGINFOD=3D1`.
--

commit 53a01ad9ae3a2bcd156b498b52efecdd21be5e21
Author: Ian Rogers <irogers@google.com>

tools build: Integrate libdebuginfod into test-all fast path

This commit bundles libdebuginfod into test-all.c to avoid an individual
feature check sub-make fork. It short-circuits feature_check in
Makefile.feature to skip evaluations when a feature was pre-detected.

> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 2f192d3bf61b9..d8febe5d58005 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -8,7 +8,9 @@ endif
> =20
>  feature_check =3D $(eval $(feature_check_code))
>  define feature_check_code
> -  feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D"$(=
CC)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))"=
 CXXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=3D"$=
(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURE=
S)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
> +  ifeq ($(feature-$(1)),)
> +    feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D"=
$(CC)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1)=
)" CXXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=3D=
"$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATU=
RES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
> +  endif
>  endef

Does this short-circuit prevent the necessary evaluation of features omitted
from test-all?

When test-all.bin successfully compiles, Makefile.feature sets all features=
 in
FEATURE_TESTS to 1. If features like libbfd or libcpupower are intentionally
omitted from test-all.c, they are falsely assumed present.

By skipping the evaluation when feature-$(1) is already set, the explicit
correction is missed. Could this cause fatal linker errors on systems that
lack these libraries?

[ ... ]

> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 704c687ed3ad1..dc828523b50ad 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -115,7 +115,7 @@ __BUILD =3D $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $=
(patsubst %.bin,%.c,$(@F)) $(
>    BUILD_BFD =3D $(BUILD) -DPACKAGE=3D'"perf"' -lbfd -ldl
>    BUILD_ALL =3D $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=3D2=
 -ldw -lelf -lnuma -lelf -lslang \
>  	      $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -ldl -lz -llzma -lzstd \
> -	      $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null)
> +	      $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null) -ldebu=
ginfod
> =20
>  __BUILDXX =3D $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bi=
n,%.cpp,$(@F)) $(LDFLAGS)

Will adding -ldebuginfod unconditionally here break the test-all fast path
even when NO_LIBDEBUGINFOD=3D1 is explicitly passed?

If a system lacks libdebuginfod-dev but the build is correctly configured to
opt out, it appears BUILD_ALL will still attempt to link against -ldebuginf=
od
and fail, forcing a slow fallback to individual feature tests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512053539.3410=
189-1-irogers@google.com?part=3D11

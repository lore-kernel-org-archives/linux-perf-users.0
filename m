Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB811A08A3
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024898; cv=none; b=s6UN3HKuhX26gHyR8zubCb54K+6SdXJb0obaZnFOkUEzwHOjfQgBXBr9yR0B1kLWzvTkSjV90SjZA2f7Sp434ZFRkPJA8mqPXZQ4y4mM6524LDBBzsUEgih5S2vDpWjGgcneT8+AkGZF11XIG7/p9hkPk5b1GOpuJrrJ/+RB5QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024898; c=relaxed/simple;
	bh=p5RuJhuGPlcdo6SwobIIbxx56B558av2IjLSUbN+6Zc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XiOhwBhh0izm6LO3+5/nOvKnR0hTLKpSVk7IwUsY8dHZgRgFrsiKNBHQJ8s5s6jX65Tnz/f2dAceanzR+F+kzma7IR0XspoauACaiZdj9dZog5Y0FgYiEMavUcK6C+GFCX/4lhoe4snGo2+ag/ne/Fld64rgVSYliF/CbRFFxvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/ll3gjC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/ll3gjC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C503E1F00893;
	Tue,  9 Jun 2026 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781024896;
	bh=cuGbe6bSeG9xcVJmhZNmHtISjFxZeYcCofq/AX8gbqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/ll3gjCGVJIOIYkBhsCA5t17JnaSMYYlgWvEaK5e1rCYNUGWTDfT5sNVsZrlDlsL
	 yHvTvNn+J2zt3d2x17C53DLZa18Ei3g0sTd1rD0solV0HyBLpTNmgnSyz/A00/JcoD
	 0idTUlksNLmZtdLVlb9mwCVrtkdJlexwFs7/rZIEw4CCP+usgMzw13INJ9P6Zbk7BF
	 /PDnQEiBPL8b4cgeOQurcnK9VHdAY/lehxnp6xv6+7oEb+na8hZFnFJdLXWn5YphC5
	 vSGIylm1dZLYh9q6HxS/rUdwLqoamPaGfg1InZ2c5Vyagi6gq52Luqsa/+v0sMEubY
	 7yXzEyWtWFdGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf build: Add libnvme feature detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609165726.786694-2-irogers@google.com>
References: <20260609165726.786694-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 17:08:16 +0000
Message-Id: <20260609170816.C503E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The libnvme feature test hardcodes the `-lnvme` compiler flag, allo=
wing the test to pass even if `pkg-config` is missing or fails to locate `l=
ibnvme.pc` (provided the library is in a standard system path). However, `t=
ools/perf/Makefile.config` strictly relies on the output of `pkg-config --l=
ibs-only-l libnvme` to populate `EXTLIBS`. This mismatch causes the build s=
ystem to enable NVMe PMU support based on the successful feature test, but =
then fail during the final linking stage of the `perf` executable due to mi=
ssing `-lnvme` flags, resulting in undefined references to libnvme function=
s.
--

commit a99ed0c67b6c2d89a762f7be2b57899a90210460
Author: Ian Rogers <irogers@google.com>

perf build: Add libnvme feature detection

Introduce a feature check for libnvme so that we can conditionally compile
the NVMe PMU driver. This checks for the availability of the libnvme headers
and library using pkg-config.

> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 62909a9c799d3..fd00e0be60690 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile

[ ... ]

> @@ -147,6 +147,9 @@ $(OUTPUT)test-libcap.bin:
>  $(OUTPUT)test-libelf.bin:
>  	$(BUILD) -lelf
> =20
> +$(OUTPUT)test-libnvme.bin:
> +	$(BUILD) -lnvme

[Severity: Low]
Does hardcoding the -lnvme flag here bypass the pkg-config requirement?

If libnvme is installed in standard paths but its pkg-config file is missing
or pkg-config is absent, this feature test will still pass.

> +
>  $(OUTPUT)test-eventfd.bin:
>  	$(BUILD)

[ ... ]

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 6e7b15fab2ecc..79c4ad10bc181 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config

[ ... ]

> @@ -1060,6 +1060,18 @@ ifndef NO_CAPSTONE
>    endif
>  endif
> =20
> +ifndef NO_LIBNVME
> +  $(call feature_check,libnvme)
> +  ifeq ($(feature-libnvme), 1)
> +    CFLAGS +=3D -DHAVE_LIBNVME_SUPPORT $(shell $(PKG_CONFIG) --cflags li=
bnvme)
> +    LDFLAGS +=3D $(shell $(PKG_CONFIG) --libs-only-L libnvme)
> +    EXTLIBS +=3D $(shell $(PKG_CONFIG) --libs-only-l libnvme)

[Severity: Low]
Since EXTLIBS relies strictly on pkg-config here, will the build fail during
final linking if the feature test succeeded using the hardcoded -lnvme flag?

If pkg-config doesn't return the required flags, the perf executable would
encounter undefined references instead of gracefully falling back to a build
without NVMe PMU support.

> +    $(call detected,CONFIG_LIBNVME)
> +  else
> +    msg :=3D $(warning No libnvme found, disables NVMe PMU support, plea=
se install libnvme-dev/libnvme-devel);
> +  endif
> +endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609165726.7866=
94-1-irogers@google.com?part=3D1

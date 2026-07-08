Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083E1A9F82
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 05:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783486994; cv=none; b=ihHQvDXMO9OavagcN/BOnrAzAsmD1EIot469gqL+xtDxZtGzwhocYHWHQeNXFAbYO2ZIeHGhvSHHOuB2/AkxlxbSb/6ttA7DakcOEC0w23VZ4eYS1Z3uwyzOGjLtSBOJUQYudwLiHnpgg4vH93wj0WtAhafC94fyX1E3Md9yxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783486994; c=relaxed/simple;
	bh=0s7BJ+FxK/YFD3+S83bx6PCvXT8fkgxarVDsfVtsuLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DkpLCmv1j9/6hJnolNQI8vZ5/qSVdYUCmVZt6XOKjUaur4f7mRKMnJ/BhcLyLdjHIMeRRb4/ORad9mIHiygurqalpTpWIT1OhRO/vm9dc0ZWbrkAR0Nj5iQl1RGkEnzM4AWepNJrm2MUxvbx7uKzVKw4fQKzHigo+LcyHss8eYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVV6TEmP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVV6TEmP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4005F1F000E9;
	Wed,  8 Jul 2026 05:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783486993;
	bh=bdKcydcJ5OaDmKzHwgJ7cgxHKCy8madTwla4XzbMNic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OVV6TEmPRse02mXvSAngaAIX7CMrX/87CsH1l+vNXtExE9phbGLd2gkb855KK2Kai
	 LPJAtF4qgnQZ+dI03u8PF6JGxP1185W4PpXfTvfCH3/rwbodAxFd00hkJUoekkmNTr
	 CUUpCoOeGboZzrDCur57pvjrmKGQ6IwfA8/H32RAVUZ2NFgqnChmmtd1OPA0AEQQq8
	 4rbQ+srTmYFfSitNNYDLVsMGmDo8BB7+uGa+PR6hbXJzxKbvRvXiLavXl+AV3ZNIOm
	 U5Q/kKW5dmku6lskF9O1xJnF2QDHGrDJMleAemSIq+I8QbS9AChMDtlqVD9heDhY9T
	 EZfPW9syMcKtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf build: Apply EXTRA_CXXFLAGS to C++ builds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Trevor Allison" <tallison@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260708045606.43649-3-tallison@redhat.com>
References: <20260708045606.43649-1-tallison@redhat.com>
 <20260708045606.43649-3-tallison@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 05:03:12 +0000
Message-Id: <20260708050313.4005F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] C++ feature detection tests do not receive `EXTRA_CFLAGS`, causi=
ng a structural mismatch between feature detection and actual build compila=
tion flags.
- [Low] Injecting `EXTRA_CFLAGS` into `CXXFLAGS` breaks C++ builds when C-s=
pecific flags are present.
--

--- Patch [2]: [PATCH 2/3] perf build: Apply EXTRA_CXXFLAGS to C++ builds -=
--
commit 4b2b9e4dd8644e0e1fa95ec876a875596e1e9178
Author: Trevor Allison <tallison@redhat.com>

perf build: Apply EXTRA_CXXFLAGS to C++ builds

The commit initializes CXXFLAGS in tools/perf/Makefile.config with both
EXTRA_CXXFLAGS and EXTRA_CFLAGS so that C++ objects receive the same builder
flags as the rest of perf.

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 0ba307e78fe1f..052a6cc7942f9 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -17,6 +17,7 @@ detected     =3D $(shell echo "$(1)=3Dy"       >> $(OUT=
PUT).config-detected)
>  detected_var =3D $(shell echo "$(1)=3D$($(1))" >> $(OUTPUT).config-detec=
ted)
> =20
>  CFLAGS :=3D $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNIN=
GS))
> +CXXFLAGS :=3D $(EXTRA_CXXFLAGS) $(EXTRA_CFLAGS)

[Severity: Low]
Could this cause a build regression if EXTRA_CFLAGS contains C-only flags?

If EXTRA_CFLAGS contains flags that are only valid for C/ObjC (such as
-Wstrict-prototypes), applying them to C++ files causes compiler warnings.
With -Werror enabled, this results in a build failure.

[Severity: Medium]
Does this create a mismatch between feature detection and the main build?

While CXXFLAGS here receives EXTRA_CFLAGS, the C++ feature detection tests =
in
tools/build/Makefile.feature still only use:

CXXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))"

If EXTRA_CFLAGS contains mandatory compiler flags like --sysroot or -m32,
the C++ feature detection tests will fail without EXTRA_CFLAGS. This causes
false negatives where the perf binary silently lacks supported features,
despite the main build succeeding.

>  HOSTCFLAGS :=3D $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708045606.4364=
9-1-tallison@redhat.com?part=3D2

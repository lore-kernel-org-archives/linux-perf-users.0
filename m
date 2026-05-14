Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45325175A68;
	Thu, 14 May 2026 00:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718539; cv=none; b=RyeFZJ2EfZEphzKeatOh7IDH/164EiKUT37nflk1WuPhqzipOi/Buzzf1VjQzsN9HfL2jTMbrMp5SOY7u26VV2lZsswbTfnry5u4zFTdzorC6fleC23qcU0InrlF7U+TUiL1UCV/gIqkRLQAPn5oV7bYoOS/1oNv2/CuvjAuU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718539; c=relaxed/simple;
	bh=uTNCscIH+UVpiddHOv+LK5aSVRb2mKzbK3LuxFUgYZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W2MW5bXM+0DmcUeAyMx5GARUVoaEHUXeq6DWOuch4bT1mraVpZFEsNm7+FWpS7oyTN3HpX2d9qdGb06ABrmAOfcc6Mz/JX7kCz/hJMnuZcZGuononYY/sn0oWJnO1xWgbPrLCtOFXLtETazPhaAZZJtFGyO4nE3nx7CVVnUVoDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqK47f6u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqK47f6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4120C19425;
	Thu, 14 May 2026 00:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778718539;
	bh=uTNCscIH+UVpiddHOv+LK5aSVRb2mKzbK3LuxFUgYZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aqK47f6ugYua0X9dhK19ZYJ7wcZg12G1WRnbTos8f8gucTYYFamAFjrhGWBQ+1e0i
	 mD1WI2EzWnI2BcA02fI7eXC20FUU/kGq0qMOdBbHa805BTvnmGrQOs9YCLCr0e7Z+X
	 g4AWhtZdqmA6ZUl4g7RHc9OXG/Tq5OmnlheBfK6eYnPsWdB3IzduWXSBzJmkHjzBps
	 87pLw5B2uqYPeWGVsUDQ8a8KEnNC/TnfyGDEZp70DrkGwshBXBQiQ7+dw3YZU/jCIt
	 z4YMALlOgiJrZnUimH4UGAd4eaPnmi9XXw8Wq8MyVGZ1K2CGSkgskZ0tL1bnOGOEOB
	 0XmrubRAsu8pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/18] tools scripts: Short-circuit CC_NO_CLANG
 compiler probe in Makefile.include
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260512174638.120445-5-irogers@google.com>
References: <20260512174638.120445-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:28:58 +0000
Message-Id: <20260514002858.F4120C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Exporting `CC_NO_CLANG` across sub-makes breaks cross-compilation =
when target and host compilers differ (e.g., CC=3Dgcc and HOSTCC=3Dclang).
- [Medium] The empty check `ifeq ($(CC_NO_CLANG),)` blindly trusts the user=
's external shell environment, introducing build fragility.
--

commit fd712ba4b295d8ef072e15714d284857b59a5cfa
Author: Ian Rogers <irogers@google.com>

tools scripts: Short-circuit CC_NO_CLANG compiler probe in Makefile.include

This commit wraps the CC_NO_CLANG evaluation in a conditional check and exp=
orts
it. This caching prevents Make from re-executing the compiler probe multiple
times during incremental builds.

> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index 41971a68972dd..3c7803122ae21 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
[ ... ]
> @@ -74,7 +74,10 @@ $(call allow-override,CXX,$(CROSS_COMPILE)g++)
>  $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
>  endif
> =20
> +ifeq ($(CC_NO_CLANG),)

Does this empty check run the risk of blindly trusting the external shell
environment? If CC_NO_CLANG happens to be exported in the user's shell,
the probe is completely skipped. Would checking the origin of the variable,
such as using ifeq ($(origin CC_NO_CLANG), undefined), prevent this from
causing unintended build misconfigurations?

>  CC_NO_CLANG :=3D $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang=
__"; echo $$?)
> +endif
> +export CC_NO_CLANG

Could exporting CC_NO_CLANG cause regressions during cross-compilation
when CC and HOSTCC use different compilers?

Many tools build host components by invoking sub-makes with an overridden
compiler, like CC=3D"$(HOSTCC)" in tools/objtool or libsubcmd. Because
CC_NO_CLANG is exported here, these sub-makes will inherit the parent's
cached value and skip their own compiler probes.

If CC=3Dgcc and HOSTCC=3Dclang, the sub-make will inherit CC_NO_CLANG=3D1,
which incorrectly appends GCC-specific flags (like -Wstrict-aliasing=3D3)
for the Clang build, potentially breaking it. Conversely, if CC=3Dclang
and HOSTCC=3Dgcc, sub-makes might inherit CC_NO_CLANG=3D0 and attempt
to use Clang-specific flags like --target=3D with GCC.

> =20
>  ifneq ($(LLVM),)
>  HOSTAR  ?=3D $(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512174638.1204=
45-1-irogers@google.com?part=3D4

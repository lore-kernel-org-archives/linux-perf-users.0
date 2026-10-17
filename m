Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84043126DF;
	Sat, 17 Oct 2026 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247530; cv=none; b=O4oXf/BNPQyTmaCuqwPrVn54EMl0aXKlKRLa2J1smhseV8d8kISAvWXNFPLTzSEZAHGJMVEEbkQRLhyIsxxZCLVaihAiE0j9dBehkBP7QqndOSgT/m5SAK5ylrvD8UuHTNLAsCP+EWx65Ii6imuNVRgmtDvTJOKIeeso7BecGHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247530; c=relaxed/simple;
	bh=8cL+xjq4TM9dRjFXLE135UJBbaL7j6l0UPQsoHsnjT4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SoMq5GMbhZhBfvwxYpoL+ebL6bVUDuOtlRGkqCJp2sNppJMrg3EKR5XmnTe51RbteiXkd/76dX9UPCtHWaixd4cRBeu+kTEIkEG8OsD+0FKT+Mi4FZ7VksYPVcckjiklrXiqSjnFuItw8Z39KK9ChADljJ/BRN+HsufRo+aFprc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8wL4MZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8wL4MZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96341F000C4;
	Sat, 17 Oct 2026 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247529;
	bh=ozkNDGENTUz+if4ze2cc+MzzLYi29NFRUQgpC8NiQqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J8wL4MZwqiU5lYYV+9VYyIgsIjOFht1GdAIDfXsCqYWyl01TU1iS184u1rWRrYSwO
	 xJ0SCH264QTan73eUpoipCZJ/QXm1r6ru4jIBzZ/gSlfFFQ3ncQjOc7SIFLzULEXbr
	 WN7EcwaiT4Qsma9pmwfPtwtYbRtw+RwjceJLO5s8L73IRUQ5mcqcleEfWS3RWPaF/c
	 PeMZfpYoy6Gnj2BYpW6WaJDAtDoX55dAljys2/8CZeGhJl5HALqIij5H48GeQsBGAh
	 BqRpdD4kGFuFE/l9mTQJMPYt3UtCYFwU5LD9JuYRctOuaNeVETVKerf7lqNp41gInV
	 JSI86lu9Wj+Hg==
Message-ID: <sashiko-outbox-175552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/7] kbuild: factor the userspace ABI flags out
 into KBUILD_USERABI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Cc: "Shuah Khan" <shuah@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Andrew Morton" <akpm@linux-foundation.org>
In-Reply-To: <20261016143143.3613501-2-sashal@kernel.org>
References: <20261016143143.3613501-1-sashal@kernel.org>
 <20261016143143.3613501-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:32:08 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kbuild: KBUILD_USERABI omitted from SBOM environment allowlist
--

commit 907dedf7b95c5c493b503479d22886e4a895a2f8
Author: Sasha Levin <sashal@kernel.org>

kbuild: factor the userspace ABI flags out into KBUILD_USERABI

This commit factors out the userspace ABI flags into a new KBUILD_USERABI
variable and exports it. This allows programs built outside of kbuild's
userprogs to be compiled for the same ABI without inheriting other flags.

> diff --git a/Makefile b/Makefile
> index 7c855e6fe5448..8c94aff229b21 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -650,7 +650,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE=
 RESOLVE_BTFIDS LEX YACC AW
>  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD TAR
>  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS KBUILD_P=
ROCMACROLDFLAGS LDFLAGS_MODULE
> -export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
> +export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS KBUILD_USERABI

[Severity: Low]
Does this new exported variable also need to be added to the SPDX SBOM
environment allowlist?

Currently, KBUILD_USERCFLAGS and KBUILD_USERLDFLAGS are explicitly tracked
in KERNEL_BUILD_VARIABLES_ALLOWLIST in scripts/sbom/sbom/environment.py:

scripts/sbom/sbom/environment.py:
KERNEL_BUILD_VARIABLES_ALLOWLIST =3D [
    ...
    "KBUILD_USERCFLAGS",
    "KBUILD_USERLDFLAGS",
    ...
]

Leaving KBUILD_USERABI off this list means its value will not be captured
in the SPDX SBOM generated by scripts/sbom, resulting in incomplete build
metadata documentation for the userspace ABI configuration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016143143.3613=
501-1-sashal@kernel.org?part=3D1

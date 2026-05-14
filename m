Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6E33F4121
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741942; cv=none; b=YY6fdQajvbi2rQH7LU+vEGmIx+JEJY60GEuF7qtyXE2mlI/Ndco8MH0JOnbOh1jxhQmHdaH473AwWJniXRkhmm4VyUJjyITojF2a33Aw/Sg9qdw/dju14LamwKOSWRMY4bwFB/8oahZf/xJgijrYCNPGvCDMxfjtbRm+zkfU8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741942; c=relaxed/simple;
	bh=9HNdOCRSvhOkZ/sDHQhFnd98/2T1hv2V8ggdpzTi6kA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=czvNJXqMpasi8QHeiSdC1hcnXTnyX/FeoLfW0C2tJpibnZkihz3Upp7qeTGD/kLOvjykR+1hpR3Utyi6pqcl5yyTMVO9dl1Cs7Kq/TTeB5PFcxA1cBfBznKjaF8LGzdpYpJw9dn+rwBc9aTQzrSOufBxUpNtDyOCaRkmId6vqoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFmOAkIb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFmOAkIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D1CC2BCB7;
	Thu, 14 May 2026 06:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778741941;
	bh=9HNdOCRSvhOkZ/sDHQhFnd98/2T1hv2V8ggdpzTi6kA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AFmOAkIbI62Gg3UZjuBuV45ydc8ykec4e2j3Wt4UKdp/swvSn78eJCAxcZsAJYRgV
	 J8Cy/YA0/jislpM76zxIbExjNlWUk4onbL0JMb+BpEf/XhpVj/qqWIjmQ4/X7P9PcD
	 TZ8s/38BUUPuyR+5dPQeRWErDDPMxTerYpWE4VzxcWS8WdOpUkx884Fr62FlSRuffd
	 YDz8M3lCmb4n8l7dm8EOJ16MGmaAVDKJYuaKE8jZduc/VSt+pCQOWAhHKA2oUhaA8G
	 ZwWh8ugKWQe3r3ny7Xwz8jFTMPf516W6rGoz8jJJMGkZ1ty5Qg3QCaXPYwgxAbEgXB
	 1nug3wCaG/Dzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf build: Fix cross-arch build failures by
 isolating auxtrace objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Guan" <guanli.oerv@isrc.iscas.ac.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260513154851.1085334-2-guanli.oerv@isrc.iscas.ac.cn>
References: <20260513154851.1085334-2-guanli.oerv@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 06:59:01 +0000
Message-Id: <20260514065901.78D1CC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Linker errors on non-x86 architectures due to missing `tpebs` =
variables.
- [High] Loss of cross-architecture hardware trace decoding.
- [High] Linker errors on x86_64 when building with `NO_AUXTRACE=3D1`.
- [High] CoreSight (CS_ETM) trace decoding broken on 32-bit `arm`.
- [Low] Use of undefined macros for preprocessor guards.
- [Low] Signature mismatch and undefined behavior for `insn_decode` weak st=
ub.
--

commit beae63268ca91077cb9cb1a3341f8277e45cb290
Author: Li Guan <guanli.oerv@isrc.iscas.ac.cn>

perf build: Fix cross-arch build failures by isolating auxtrace objects

This commit isolates architecture-specific hardware tracing drivers from the
generic perf build process. It conditionally links objects based on exported
feature flags and introduces weak stub functions for gracefully handling
omitted drivers.

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 333ddd0e4bd81..c4c0d79242d5d 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config

[ ... ]

> @@ -107,6 +107,27 @@ ifeq ($(SRCARCH),loongarch)
>    endif
>  endif
> =20
> +ifndef NO_AUXTRACE
> +  ifeq ($(SRCARCH),x86)
> +    $(call detected,CONFIG_PERF_INTEL_PT)
> +    $(call detected,CONFIG_PERF_AMD_PT)
> +  endif
> +
> +  ifeq ($(SRCARCH),arm64)
> +    $(call detected,CONFIG_PERF_ARM_SPE)
> +    $(call detected,CONFIG_PERF_HISI_PTT)
> +    $(call detected,CONFIG_PERF_CS_ETM)
> +  endif

Does this omit CoreSight support on 32-bit arm builds? CoreSight trace
decoding is natively supported on 32-bit arm via tools/perf/arch/arm/, but
this explicitly restricts the feature flag solely to arm64.

[ ... ]

> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 70cc91d00804d..79ade6066df9d 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build

[ ... ]

> @@ -132,21 +132,21 @@ perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
>  perf-util-y +=3D kvm-stat-arch/
>  perf-util-y +=3D lock-contention.o
>  perf-util-y +=3D auxtrace.o
> -perf-util-y +=3D intel-pt-decoder/
> -perf-util-y +=3D intel-pt.o
> -perf-util-y +=3D intel-bts.o
> -perf-util-y +=3D arm-spe.o
> -perf-util-y +=3D arm-spe-decoder/
> -perf-util-y +=3D hisi-ptt.o
> -perf-util-y +=3D hisi-ptt-decoder/
> -perf-util-y +=3D s390-cpumsf.o
> +perf-util-$(CONFIG_PERF_INTEL_PT) +=3D intel-pt-decoder/
> +perf-util-$(CONFIG_PERF_INTEL_PT) +=3D intel-pt.o
> +perf-util-$(CONFIG_PERF_INTEL_PT) +=3D intel-bts.o
> +perf-util-$(CONFIG_PERF_ARM_SPE) +=3D arm-spe.o
> +perf-util-$(CONFIG_PERF_ARM_SPE) +=3D arm-spe-decoder/
> +perf-util-$(CONFIG_PERF_HISI_PTT) +=3D hisi-ptt.o
> +perf-util-$(CONFIG_PERF_HISI_PTT) +=3D hisi-ptt-decoder/
> +perf-util-$(CONFIG_PERF_S390_CPUMSF) +=3D s390-cpumsf.o

Will this break the ability to decode hardware traces across different
architectures?

A core feature of perf is analyzing traces like ARM SPE on non-native
hosts like x86. Omitting these objects entirely on non-native
architectures would cause cross-architecture decoding to silently fall back
to the weak stubs and fail.

[ ... ]

> @@ -168,7 +168,7 @@ perf-util-y +=3D clockid.o
>  perf-util-y +=3D list_sort.o
>  perf-util-y +=3D mutex.o
>  perf-util-y +=3D sharded_mutex.o
> -perf-util-y +=3D intel-tpebs.o
> +perf-util-$(CONFIG_PERF_INTEL_PT) +=3D intel-tpebs.o

Could this cause linker errors on non-x86 architectures?=20

The builtin-stat.c file unconditionally references the tpebs_recording and
tpebs_mode global variables defined in intel-tpebs.o. If this file is
conditionally compiled only for x86, non-x86 builds will likely fail with
undefined references during the final linking stage.

> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index a224687ffbc1b..f6e426c3c56e1 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c

[ ... ]

> @@ -2960,3 +2961,72 @@ bool auxtrace__evsel_is_auxtrace(struct perf_sessi=
on *session,
> =20
>  	return session->auxtrace->evsel_is_auxtrace(session, evsel);
>  }
> +
> +/*
> + * Stub functions for architecture-specific features to support cross-pl=
atform building.
> + * These weak symbols are overridden by strong symbols when the correspo=
nding
> + * architecture-specific code is compiled in.
> + */
> +#ifndef HAVE_ARCH_X86_64_SUPPORT
> +int __weak intel_pt_process_auxtrace_info(union perf_event *event __mayb=
e_unused,

Will this lead to unresolved symbols on 64-bit x86 if NO_AUXTRACE=3D1 is se=
t?

The HAVE_ARCH_X86_64_SUPPORT macro is defined unconditionally for x86_64
builds. If NO_AUXTRACE=3D1 skips compiling the strong definitions, this
preprocessor guard will also skip the weak stubs, leaving unconditional
callers with missing symbols.

[ ... ]

> +int __weak insn_decode(void *insn __maybe_unused, const void *kaddr __ma=
ybe_unused,
> +		       int len __maybe_unused, int mode __maybe_unused)
> +{
> +	return -EOPNOTSUPP;
> +}

Is the signature for insn_decode correct here?

The callers in tools/perf/util/sample.c expect the first parameter to be
struct insn *insn rather than void *insn. Calling a function via a
declaration with mismatched pointer types is undefined behavior in C. A
forward declaration for struct insn might be needed instead.

> +#endif
> +
> +#ifndef HAVE_ARCH_ARM64_SUPPORT
> +int __weak arm_spe_process_auxtrace_info(union perf_event *event __maybe=
_unused,
> +					 struct perf_session *session __maybe_unused)

Are the HAVE_ARCH_ARM64_SUPPORT and HAVE_ARCH_S390_SUPPORT macros defined
anywhere in the tree?

These preprocessor guards do not appear to exist, which would mean these
weak stubs are compiled unconditionally on all architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513154851.1085=
334-1-guanli.oerv@isrc.iscas.ac.cn?part=3D1

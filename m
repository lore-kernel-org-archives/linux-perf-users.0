Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599706;
	b=Ikea3ZfVdCuNAMG1Bc5SOrKB0TOY71wL0c0KbEAnw9pkeWM6aSlPpsfBwbkmZx6Qxg5n
	 08r3/rKbOeYZGvP9blskQ9QUmsj60F/u2hpUkAhuvXuJWY4t0sf28XocsKWX1ldQzBS9m
	 qOhbFknfGcFVzzRZw9TtcvywkU2OO8a7PoqNGjryGb3b7762faw0zUjC7H84vn4expE9U
	 bEojDVTF2+qmyKSqHIuA1K7dHhQ3LlwG0vQ/6dEDr/DxYBfaVLY/caUyGEq4hS2tTRMV6
	 5IKMpLdvMuRZi/LAlpWIVIJ/5jZRrkj/HZkmu88X5v+gXt59tAl1IgwDec8ZSIGcS0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599706;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y4RuN1+dNqcla+xS/Ujiv0frSIHiJi3KBVCO24UjAp8=;
	b=gHB+J929JrGSCN26lJmDqeOypIfwMb5l+FEcEj0yrbbKleKTYYaGEVVJFFhXShi9w53h
	 0f+hucE1ZHd3G9IDJ/nnbUjI5xZ4fxblrMEx7DHQt8u8VF4XMqhukRo6HC3ps5zFJ8PVa
	 xLsX5NmQ9kC5xVPetz5qAIVD1nqYvN3XYxSWsisKPVbBLJxV7ceyorc7iq7UzZHcQN0a+
	 npLLVxeUJOIysQjT0MsR/rdH4qzXClRuHQkahtYllUa0vmxDyVjNwBlSOAccHpty3BpCJ
	 S8h6Kv4T7mH5YHulR2IDEASjws3PJeIGIvwHziQd/9Jfnay88HFmVdzvaCjmVheZEGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfcasOi2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7497160A380C;
	Fri, 13 Nov 2026 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfcasOi2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298291F000C7;
	Fri, 13 Nov 2026 19:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599706;
	bh=Y4RuN1+dNqcla+xS/Ujiv0frSIHiJi3KBVCO24UjAp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WfcasOi2P06JKREGTACYnCPyxsbfVYZ+jii1muG/ojebX+znmMY5mhcmoUn5eR90f
	 1LR2IdQeWBk2m979++1gosN47Z8ApMvUvum2aiMDxj/nk20DtegVDGGK71Shokxce3
	 KrMJKGqAyRwfH9utH3sZZgK3ihAnOkurBm1UU40kkbiH16Iv3n2iCDVyodo2Dw/ZLp
	 eiw/kCo5jH0epsjYq5u2aRhoEnXc27ZlSXxDT4KQQvNdNYweBQiM0k85fH2FVkTdsF
	 ObNVfnxFLkctUyq/QgXvY/Yce8T2BO4+XV5uvfen6h+rV0CTkT3a9rhITAv06lfSN2
	 vlOx+YNZZL0pw==
Message-ID: <sashiko-outbox-213586@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] tools: build perf in tools_build
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Cc: "Shuah Khan" <shuah@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Andrew Morton" <akpm@linux-foundation.org>, "Thorsten
 Leemhuis" <linux@leemhuis.info>
In-Reply-To: <20261112195427.3411746-5-sashal@kernel.org>
References: <20261112195427.3411746-1-sashal@kernel.org>
 <20261112195427.3411746-5-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:55:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] tools: missing python-config and Python 3.9 check in
  TOOLS_BUILD_PERF_LIBS
- [Medium] tools: TOOLS_BUILD_PERF_LIBS probe mismatches tools/perf
  pkg-config and link checks
--

commit c19562a2a39be79f326367f65fd8b1eb86f840c4
Author: Sasha Levin <sashal@kernel.org>

tools: build perf in tools_build

This commit adds CONFIG_TOOLS_BUILD_PERF and CONFIG_TOOLS_BUILD_PERF_MINIMAL
to build tools/perf as part of tools_build.

> diff --git a/tools/Kconfig b/tools/Kconfig
> index 04896e6b0ca51..ab1e15beb9fe3 100644
> --- a/tools/Kconfig
> +++ b/tools/Kconfig
> @@ -60,6 +60,30 @@ config TOOLS_BUILD_IIO
>  	help
>  	  Build tools/iio (lsiio, iio_event_monitor, iio_generic_buffer).
> =20
> +config TOOLS_BUILD_PERF
> +	bool "perf"
> +	help
> +	  Build tools/perf. As in a standalone perf build, optional
> +	  features are enabled when the libraries they need are installed.
> +
> +# What perf does not build without, unless it is built with MINIMAL=3D1
> +config TOOLS_BUILD_PERF_LIBS
> +	def_bool $(success,command -v $(CROSS_COMPILE)pkg-config || command -v =
pkg-config) && \
> +		 $(success,echo 'int main(void) { return 0; }' | $(CC) $(CLANG_FLAGS) =
$(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) `$(CROSS_COMPILE)pkg-config --cfla=
gs --libs libtraceevent 2>/dev/null || pkg-config --cflags --libs libtracee=
vent` -include libelf.h -include trace-seq.h -x c - -o /dev/null -lelf)

[Severity: Medium]
Can TOOLS_BUILD_PERF_LIBS evaluate to y when tools/perf feature detection f=
or
libtraceevent or libelf will fail?

During a cross-build where $(CROSS_COMPILE)pkg-config is installed on the h=
ost
but target libtraceevent.pc is missing, $(CROSS_COMPILE)pkg-config fails and
the || fallback runs the host pkg-config, returning host flags, whereas
tools/perf/Makefile.perf uses $(CROSS_COMPILE)pkg-config exclusively when
present.  Conversely, when $(CROSS_COMPILE)pkg-config is absent,
tools/perf/Makefile.perf exports PKG_CONFIG_LIBDIR for the target multiarch
directories, while the Kconfig check runs host pkg-config with no
PKG_CONFIG_LIBDIR set.

In addition, because pkg-config runs inside backticks without an explicit
-ltraceevent on the compiler command line, a failing pkg-config expands to =
an
empty string and still succeeds if trace-seq.h is in the include path.
Passing --libs before -x c - and compiling an empty main() without calling
symbols such as elf_begin() or trace_seq_init() also succeeds with static
archives even when transitive dependencies required by tools/build/feature/
checks are missing.

> +
> +config TOOLS_BUILD_PERF_MINIMAL
> +	bool "Build perf with all optional features disabled" if TOOLS_BUILD_PE=
RF_LIBS && !COMPILE_TEST
> +	depends on TOOLS_BUILD_PERF
> +	default !TOOLS_BUILD_PERF_LIBS || COMPILE_TEST

[Severity: Medium]
Does building perf with CONFIG_TOOLS_BUILD_PERF_MINIMAL=3Dn fail when
python3-config is missing or Python is older than 3.9?

Without MINIMAL=3D1 (which sets NO_JEVENTS=3D1), x86_64 and arm64 perf buil=
ds
enable jevents generation:

tools/perf/Makefile.config:
    ...
    override PYTHON_CONFIG :=3D $(call get-executable-or-default,PYTHON_CON=
FIG,$(PYTHON_AUTO))
    override PYTHON :=3D $(call get-executable-or-default,PYTHON,$(subst -c=
onfig,,$(PYTHON_CONFIG)))
    ...
    ifneq ($(NO_JEVENTS),1)
      NO_JEVENTS :=3D 0
      ifndef PYTHON
        $(error ERROR: No python interpreter needed for jevents generation.=
 Install python or build with NO_JEVENTS=3D1.)
      else
        ifneq ($(PYTHON_39_GOOD), 1)
          $(error ERROR: Python interpreter needed for jevents generation t=
oo old (older than 3.9). Install a newer python or build with NO_JEVENTS=3D=
1.)
        endif
      endif
    endif

Because Makefile.config derives PYTHON from PYTHON_CONFIG (python3-config or
python-config, typically packaged in python3-dev / python3-devel rather than
the base python3 package) and TOOLS_BUILD_PERF_LIBS does not check for it or
Python >=3D 3.9, TOOLS_BUILD_PERF_MINIMAL defaults to n and the perf build
aborts when pkg-config, libelf, and libtraceevent are installed without
python3-config.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112195427.3411=
746-1-sashal@kernel.org?part=3D4

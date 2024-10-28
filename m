Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B111F7556;
	Mon, 28 Oct 2024 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152166; cv=none; b=GSTdbDrNbbrHSZVPuvyGJSmOtL9bOWF88z3dStoLHaWSyzUJr+OZqw9vxGEp4Ljc42zvRGW+isX+sOz6CKE0+qVSl2T0tXjXzvCxb2dYpukSWmBndSjPNfn0rl7egvgRHOF6tpSYp/dG1a55eUq5c/j/N5K8E7ZvPIcXtfuHUWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152166; c=relaxed/simple;
	bh=Sa9pC74MYlIxPuqpUeDKI2DO7YzIwZ3JUA+BHF+eQew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpGz0hBti8AGaJf1y14TbLXmy8TqBDWaiU2DObYse6p3cFjRznpAVQRYulezxluGlFjV8JfreUZYGoPm8EM6S9ME8ldo87wqdMLPrkENlhP7bV02t9TrhshJ1g0xTz+CHV1VKMeGqSDMh3GLK2ASgcRNFIzhtSb0Ih/KgbVN6Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ6WbC5x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ6WbC5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDD2C4CEC3;
	Mon, 28 Oct 2024 21:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152165;
	bh=Sa9pC74MYlIxPuqpUeDKI2DO7YzIwZ3JUA+BHF+eQew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZ6WbC5xuufnGi6HQ/jhKP7J6sjIrJbSuUPM/7nT9XqgPH1BPmttHEdvGdEWKAFEc
	 InIRBkT1/LmZbT36COBTBPnsWTJXS/CknQztAlRwmGkOVotPgwlVShwWGexj9/x9xw
	 ljOvsNtoy4xVAYeiz4N7L7bd+MpdX6tjf5/1wWIwNInAfNGiqZ2o/LEU+3+LAc5RKa
	 1enjmojVF6mHnPjFt4FmTORguThDZvcRBqBdAvhTfWQtpNYHHf/LjADO1I838P1ZMY
	 /lrXF3zbzM06Z0loHeGxuJbYSe+Bud2sL4xmVCSj55W5rs+p8r+7lhjhjGtkN5z5rM
	 0G3o18EW3qMDw==
Date: Mon, 28 Oct 2024 18:49:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf build: Make libunwind opt-in rather than opt-out
Message-ID: <ZyAG4kSqZk8Fpu1A@x1>
References: <20241028193619.247727-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241028193619.247727-1-irogers@google.com>

On Mon, Oct 28, 2024 at 12:36:19PM -0700, Ian Rogers wrote:
> Having multiple unwinding libraries makes the perf code harder to
> understand and we have unused/untested code paths.
 
> Perf made BPF support an opt-out rather than opt-in feature. As libbpf
> has a libelf dependency, elfutils that provides libelf will also
> provide libdw. When libdw is present perf will use libdw unwinding
> rather than libunwind unwinding even if libunwind support is compiled
> in.
 
> Rather than have libunwind built into perf and never used, explicitly
> disable the support and make it opt-in.

Looks ok and testing it does what is advertised:

⬢ [acme@toolbox perf-tools-next]$ ldd ~/bin/perf | grep libunwind
⬢ [acme@toolbox perf-tools-next]$ perf check feature libunwind
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT
⬢ [acme@toolbox perf-tools-next]$

Since I have libunwind-devel installed:

Auto-detecting system features:
<SNIP
...                               libunwind: [ on  ]
<SNIP

If I uninstall libunwind-devel, just to complete the cycle, even this
patch not touching that part:

Auto-detecting system features:
<SNIP>
...                               libunwind: [ OFF ]
<SNIP>

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Closes: https://lore.kernel.org/linux-perf-users/CAP-5=fUXkp-d7gkzX4eF+nbjb2978dZsiHZ9abGHN=BN1qAcbg@mail.gmail.com/
> ---
> v2: update build tests.
> ---
>  tools/perf/Makefile.config | 4 ++++
>  tools/perf/Makefile.perf   | 2 +-
>  tools/perf/tests/make      | 6 +++---
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index b93ed2b7623f..707d7355ff18 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -91,6 +91,10 @@ ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390 csky riscv loon
>    NO_LIBDW_DWARF_UNWIND := 1
>  endif
>  
> +ifneq ($(LIBUNWIND),1)
> +  NO_LIBUNWIND := 1
> +endif
> +
>  ifeq ($(LIBUNWIND_LIBS),)
>    NO_LIBUNWIND := 1
>  endif
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index b4dee7c20ed1..d74241a15131 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -52,7 +52,7 @@ include ../scripts/utilities.mak
>  #
>  # Define NO_LIBELF if you do not want libelf dependency (e.g. cross-builds)
>  #
> -# Define NO_LIBUNWIND if you do not want libunwind dependency for dwarf
> +# Define LIBUNWIND if you do not want libunwind dependency for dwarf
>  # backtrace post unwind.
>  #
>  # Define NO_BACKTRACE if you do not want stack backtrace debug feature
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index a5040772043f..a7fcbd589752 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -81,7 +81,7 @@ make_no_gtk2        := NO_GTK2=1
>  make_no_ui          := NO_SLANG=1 NO_GTK2=1
>  make_no_demangle    := NO_DEMANGLE=1
>  make_no_libelf      := NO_LIBELF=1
> -make_no_libunwind   := NO_LIBUNWIND=1
> +make_libunwind      := LIBUNWIND=1
>  make_no_libdw_dwarf_unwind := NO_LIBDW_DWARF_UNWIND=1
>  make_no_backtrace   := NO_BACKTRACE=1
>  make_no_libcapstone := NO_CAPSTONE=1
> @@ -121,7 +121,7 @@ make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX3
>  
>  # all the NO_* variable combined
>  make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_GTK2=1
> -make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1
> +make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
>  make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
>  make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
>  make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
> @@ -153,7 +153,7 @@ run += make_no_gtk2
>  run += make_no_ui
>  run += make_no_demangle
>  run += make_no_libelf
> -run += make_no_libunwind
> +run += make_libunwind
>  run += make_no_libdw_dwarf_unwind
>  run += make_no_backtrace
>  run += make_no_libcapstone
> -- 
> 2.47.0.163.g1226f6d8fa-goog

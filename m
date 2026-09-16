Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776BA4D9548;
	Wed, 16 Sep 2026 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580159; cv=none; b=crwllaZ6UJhTdJt7SayoUP/bqRf3nPHdxKLko4sN+RXxZOadp42vnMVdsAE/6AjJ2MLtB9hn5cFnv+uAh8JIrEDlV+EW9tHcD07vQonLEZJ+g0cTAkWdOaSZrDnFhmJ9gpAlh2dOS+kyrPSYusCFpJep7xUzJiDyfcWvtgzBftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580159; c=relaxed/simple;
	bh=UzgvU2D3N1Tr0bxLinAWdJFu7EBcDYSy2p6JXSjXsqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFRJV3HOKHf/hvNeTCD87TsbfD0KClYM4l5c1PX01If5AhedNaQYaw025bbd4euGOFuovVW14ycjpR+Au5/e29RYvtJj3MU1HsLhs2S41h1CBMMbAews42OeLOLTrDlPODqx/+HpbUcV0PAnafhHh1tPF9krLWvxk5wECcrkdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jldI7fg0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jldI7fg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EBD1F000FF;
	Wed, 16 Sep 2026 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580150;
	bh=lz/TQhxBzEP+HHtTRuAb4x/tXjOKPhiKUxO/kKdETtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jldI7fg0Kx5LIGgnzSj+RmvhUaOG9wTr2+hHs9t4M+7lz6G6b5/xfQhFYdN8Nxv+w
	 LOSaLjWq2tC4oSNQsaDaljrtbIQRaKxTZuYtXvWdhLwG+TLf90E3729/wGsHEYZa/X
	 tXUTZ6a4rZ2IL9zAp7U5kOW9h2Vkojau7SJnkdFoKC2fHzwXssfgIRfyuFKYu35wyi
	 CvXRVK5qlVb8ji2+oNaKub6lH3XykwA8yDacdHN1dU9ELS1ak79hQoOMtpE/gzie/J
	 kkKeNHLwmNgo05L5zTFVCqTSZWpYnpFaz+uDjLGmnqZbqOE7WnA74/6tViQ8n1ks7u
	 ET/b7tTREnMRg==
Date: Wed, 16 Sep 2026 10:35:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 0/9] perf build: Fix builds with clang and BUILD_NONDISTRO
Message-ID: <aqrTdAVfVkzltJct@google.com>
References: <20260916061218.3061216-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916061218.3061216-1-irogers@google.com>

On Tue, Sep 15, 2026 at 11:12:09PM -0700, Ian Rogers wrote:
> Several perf build configurations are broken, and stayed broken because
> the build test suite doesn't cover them.
> 
> Three of them fail outright:
> 
>   $ make CC=clang BUILD_NONDISTRO=1
>   util/libbfd.c:56:1: error: mutex 'bfd_mutex' is still held at the end
>   of function [-Werror,-Wthread-safety-analysis]
> 
>   $ make BUILD_NONDISTRO=1 NO_DEMANGLE=1
>   util/symbol.c:2714: error: 'DMGL_PARAMS' undeclared
> 
>   $ make CC=clang-19
>   *** Specify CROSS_COMPILE or add CLANG_TARGET_FLAGS for x86_64
> 
> A fourth is worse for being silent. "make CC=clang" appends clang's
> --target= and -fintegrated-as to CXX, but CXX is only set to clang++ by
> "make LLVM=1", so it is still g++ and rejects both. Feature tests are
> allowed to fail, so nothing is reported: the build succeeds and just
> quietly drops libllvm and C++ demangling support.
> 
>   $ make CC=clang && grep LIBLLVM .config-detected
>   (nothing, whereas a gcc build reports CONFIG_LIBLLVM=y)
> 
> The patches are grouped as:
> 
>   1-2  Fix the two build failures, in libbfd.c and symbol.c.
>   3-4  Include the headers that are used directly rather than relying
>        on other headers to drag them in. No functional change.
>   5-7  Fix the clang handling in Makefile.config: don't give clang's
>        flags to a non-clang CXX, and use the CC that was asked for
>        instead of hard coding "clang" when picking the target triple
>        and when testing the compiler version.
>   8    Remove three build test entries left behind by the removal of
>        the options they tested. None of them define what to build, so
>        each silently repeats "make_pure" and the suite spends six
>        builds appearing to cover options that no longer exist.
>   9    Add build tests for the configurations above, so they don't
>        break again. As a build that loses a feature still succeeds,
>        the clang tests also check that libLLVM is still built in.
> 
> Testing:
> 
>  - 13 build configurations (gcc, clang, versioned clang, LLVM=1,
>    BUILD_NONDISTRO, NO_DEMANGLE, NO_LIBDW, NO_LIBELF, DEBUG, asan,
>    refcount checking) pass, where two failed before the series.
>  - Every patch builds on its own, so the series stays bisectable.
>  - Each fix was confirmed by reintroducing the bug and checking that
>    the test added in patch 9 fails:
> 
>      CXX flags given to g++     make_clang             fails on libLLVM
>      libbfd thread safety       make_clang_nondistro   fails to compile
>      symbol.c demangling        make_nondistro_no_demangle  likewise
> 
> Ian Rogers (9):
>   perf libbfd: Fix the clang -Wthread-safety build failure
>   perf symbol: Fix the build when demangling with libbfd
>   perf libbfd: Include the headers that are used
>   perf pmu: Include the headers that are used
>   perf build: Only pass clang flags to CXX when CXX is clang
>   perf build: Use the given CC rather than clang in clang builds
>   perf build: Check the version of the compiler that is used
>   perf build: Remove leftovers of removed build options
>   perf test: Add build tests for clang and libbfd demangling

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/Makefile.config | 13 +++++++---
>  tools/perf/Makefile.perf   |  3 ---
>  tools/perf/tests/make      | 50 ++++++++++++++++++++++++++++++++++----
>  tools/perf/util/Build      |  2 +-
>  tools/perf/util/libbfd.c   | 41 ++++++++++++++++++++++++++-----
>  tools/perf/util/libbfd.h   |  9 +++++++
>  tools/perf/util/pmu.c      |  5 +++-
>  tools/perf/util/symbol.c   | 18 +++++++++++---
>  8 files changed, 119 insertions(+), 22 deletions(-)
> 
> 
> base-commit: 91b0782fc9e9d2f0a40b5256146e014802fdbb36
> -- 
> 2.55.0.1032.g73a4cd73de-goog
> 

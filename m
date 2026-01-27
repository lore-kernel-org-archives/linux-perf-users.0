Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352FA3624C5;
	Tue, 27 Jan 2026 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533969; cv=none; b=DkNAB4TXJ5Yj/PD16hpSuAlw4UXHXZvO4W2NotowDsMqTNw689qvIw8HYReOtS/uC/q1SHEMGwSqXLzv9kwbNE27TfUzNEG58fjjGZObl03qkPNbxoByCWhZ3dKpARGEji8+/LjX0qH0/cgPJ1mrgWfAvAuj+rnsZ79U9EOjbWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533969; c=relaxed/simple;
	bh=es7Lzi+GLpreS3paNVEOSrq0wFpglPAFO/+T/8F9y4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfsB5GR6NpBg8Uzo0msXmTtGp+xCkVtC79r0yrYslKz5VW13okDXiKKPl1MEkhzbjR/qk1KDgImMPl8VGhl7x7XxF80dvnOwpgIKKOPnjOeOAOxWbSLhiFFxsi09tbjTreL+tHiqkY8C7D+Gp7mxuM+T9Cp51m1TXt4qYtAkAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgA2EBOW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgA2EBOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C49C116C6;
	Tue, 27 Jan 2026 17:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769533968;
	bh=es7Lzi+GLpreS3paNVEOSrq0wFpglPAFO/+T/8F9y4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgA2EBOWzd4zlvhbfAZOHLgja7/mlc+pOtcKyw7PGj8HKRHlW25GFZb+/thcTdEz4
	 JtRGWBiCe8OBRGnsfnVK2Bu5Bzyb/CVAd6fPY33kN5dMXtlJoCPbvIAR1sEWLd1tT6
	 u2JDC2Dow3V+Yt2JthmvwYNOQonOUcBsM3TKnixAqax3umM69h4nFU7J57RcE2GEfu
	 N7y8YTQV/AGUbzICEPuvx8Dq5ZkTXI/+GYui+62HH1jE27ywVEMnhFV4Bvqmbh0msk
	 O+IUeyy0KMEPU9l4pfW9uAyJKj6V3XWsP06J49DsSBllwWjRFOLdJ7RkYXl6OGT4vb
	 wqKCQHGD6iN6A==
Date: Tue, 27 Jan 2026 14:12:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v9 0/3] Capstone/llvm dlopen support
Message-ID: <aXjyDUjim64yqI4N@x1>
References: <20260127062302.544809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127062302.544809-1-irogers@google.com>

On Mon, Jan 26, 2026 at 10:22:59PM -0800, Ian Rogers wrote:
> Linking against libcapstone and libLLVM can be a significant increase
> in dependencies and file size if building statically. The dependencies
> are also quite cumbersome if bringing perf into a distribution. For
> something like `perf record` the disassembler and addr2line
> functionality of libcapstone and libLLVM won't be used. These patches
> support dynamically loading these libraries using dlopen and then
> calling the appropriate functions found using dlsym. Using dlopen
> allows libcapstone and libLLVM to be installed separately to perf and
> when that's done the performance will improve as separate commands for
> objdump and addr2line won't be invoked.
> 
> The patch series adds perf_ variants of the capstone/llvm functions
> that will either directly call the function or (NO_CAPSTONE=1 and
> NO_LIBLLVM=1 cases) use dlopen/dlsym to discover and then call the
> function. To support the function signatures when
> HAVE_LIBCAPSTONE_SUPPORT and HAVE_LIBLLVM_SUPPORT aren't defined
> prototypes generated using pahole are given. This avoids requiring
> libcapstone or libLLVM for the sake of the header files. It also
> avoids having a build where neither dlopen or dynamic linking against
> libcapstone or libLLVM is supported. There are other possibilities in
> how to organize this, but the chosen approach was done so for the
> simplicity and cleanliness of the code.
> 
> The addr2line LLVM functionality is written in C++. To avoid linking
> against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
> the C++ code with the libLLVM dependency will be built into a
> libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
> would extend their C API to avoid this.
> 
> v9: Rebase.

Thanks, applied locally, will test this after lunch.

- Arnaldo

> v8: Rebase down to 3 patches. Update commit and cover messages.
> v7: Refactor now the first 5 patches, that largely moved code around,
>     have landed. Move the dlopen code to the end of the series so that
>     the first 8 patches can be picked improving capstone/LLVM support
>     without adding the dlopen code. Rename the cover letter and
>     disassembler cleanup patches.
> v6: Refactor the libbfd along with capstone and LLVM, previous patch
>     series had tried to avoid this by just removing the deprecated
>     BUILD_NONDISTRO code. Remove the libtracefs removal into its own
>     patch.
> v5: Rebase and comment typo fix.
> v4: Rebase and addition of a patch removing an unused struct variable.
> v3: Add srcline addr2line fallback trying LLVM first then forking a
>     process. This came up in conversation with Steinar Gunderson
>     <sesse@google.com>.
>     Tweak the cover letter message to try to address Andi Kleen's
>     <ak@linux.intel.com> feedback that the series doesn't really
>     achieve anything.
> v2: Add mangling of the function names in libperf-llvm.so to avoid
>     potential infinite recursion. Add BPF JIT disassembly support to
>     LLVM and capstone. Add/rebase the BUILD_NONDISTRO cleanup onto the
>     series from:
>     https://lore.kernel.org/lkml/20250111202851.1075338-1-irogers@google.com/
>     Some other minor additional clean up.
> 
> Ian Rogers (3):
>   perf capstone: Support for dlopen-ing libcapstone.so
>   perf llvm: Support for dlopen-ing libLLVM.so
>   perf llvm: Mangle libperf-llvm.so function names
> 
>  tools/perf/Makefile.config         |  13 ++
>  tools/perf/Makefile.perf           |  24 ++-
>  tools/perf/tests/make              |   2 +
>  tools/perf/util/Build              |   2 +-
>  tools/perf/util/capstone.c         | 285 +++++++++++++++++++++++++----
>  tools/perf/util/llvm-c-helpers.cpp | 120 +++++++++++-
>  tools/perf/util/llvm-c-helpers.h   |  24 ++-
>  tools/perf/util/llvm.c             | 273 ++++++++++++++++++++++++---
>  8 files changed, 660 insertions(+), 83 deletions(-)
> 
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

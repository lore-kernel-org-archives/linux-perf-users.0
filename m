Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994027F00F;
	Wed,  1 Oct 2025 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343581; cv=none; b=W5iGOwjsj8ZDI8W6/iv8IRzLZ0SYqruMEQIFV2FJH6sMv57ABcml8lcPRD0Bt2NgqDgtWHqVxeiAB9zK78pEIxAI21vZ7fmbLhudrInQsIaV5DVp98ze/fSuYhhvTx0i/P1WxvXLBUuQAKcGsrZhzPwYbKq2RLuqkxhdDdZOq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343581; c=relaxed/simple;
	bh=gR2gKrymd+GBEb2ZZasTzLPiQr1yNDrh2ELftZdrnFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgH9FgnHXlT2E6dFzqZUgjUxUR5tKFDCOAq4v2BtImassn5qWOlJy8knpr0EDkgWQGKv3NQ/A5I6FIrPxRJVSDxVVBFkkyb2qOwvxtVp2ppToqx54GcCag44HUtMxYeskSbiv+2ou0QCgx/f6zjNvAa1u/OBfirNtx+yIXoFeM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DD4B16F8;
	Wed,  1 Oct 2025 11:32:50 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23ADB3F66E;
	Wed,  1 Oct 2025 11:32:58 -0700 (PDT)
Date: Wed, 1 Oct 2025 19:32:56 +0100
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/8] perf build: Support building with Clang
Message-ID: <20251001183256.GS7985@e132581.arm.com>
References: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
 <aN044EY-Ds9-E6iz@x1>
 <20251001152217.GQ7985@e132581.arm.com>
 <aN1yNKxXLnMtQczW@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN1yNKxXLnMtQczW@x1>

On Wed, Oct 01, 2025 at 03:25:56PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> It was in all alpine versions I have containers to test on:
> 
> toolsbuilder@five:~$ grep FAIL dm.log.old/summary 
>    3    71.85 almalinux:9-i386              : FAIL clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6-5.el9)
>    5    78.60 alpine:3.16                   : FAIL gcc version 11.2.1 20220219 (Alpine 11.2.1_git20220219) 
>    6    59.77 alpine:3.17                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
>    7    56.89 alpine:3.18                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r10) 
>    8    60.86 alpine:3.19                   : FAIL gcc version 13.2.1 20231014 (Alpine 13.2.1_git20231014) 
>    9    60.18 alpine:3.20                   : FAIL gcc version 13.2.1 20240309 (Alpine 13.2.1_git20240309) 
>   10    64.58 alpine:3.22                   : FAIL gcc version 14.2.0 (Alpine 14.2.0) 
>   11    63.36 alpine:edge                   : FAIL gcc version 14.2.0 (Alpine 14.2.0) 
> toolsbuilder@five:~$
> 
>   GEN     /tmp/build/perf/python/perf.cpython-312-x86_64-linux-musl.so
> make: Leaving directory '/git/perf-6.17.0-rc6/tools/perf'
> + rm -rf /tmp/build/perf
> + mkdir /tmp/build/perf
> + make 'ARCH=' 'CROSS_COMPILE=' 'EXTRA_CFLAGS=' -C tools/perf 'O=/tmp/build/perf' 'CC=clang'
> make: Entering directory '/git/perf-6.17.0-rc6/tools/perf'
>   BUILD:   Doing 'make -j28' parallel build
> Makefile.config:494: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
> make[1]: *** [Makefile.perf:289: sub-make] Error 2
> make: *** [Makefile:76: all] Error 2
> make: Leaving directory '/git/perf-6.17.0-rc6/tools/perf'
> + exit 1
> toolsbuilder@five:~
> $
> 
> lemme try to reapply those patches and get the
> tools/perf/feature/test-libelf.make.output and
> tools/perf/feature/test-glibc.make.output files.

That is fine.  I have reproduced at my side, will look into.

Thanks,
Leo

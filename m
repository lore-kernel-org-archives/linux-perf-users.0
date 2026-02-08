Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812E2C21D0
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Feb 2026 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770561568; cv=none; b=Oii/T1nJGl87N/2FkqSVrDtpmHf4UrNRxAvmkafsPaavq+AAnN75LC6u9VhnNQ8PCCo9HCPEP/bRAYFlrZrMtnNJ9mh+gxfa6k/RREBbmeTOH4AhyPVKTofiDSxIHco0/o5hbKUU3Gw+d+O3/uxX8ba6fAN0+5wqmsRjK1u7seQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770561568; c=relaxed/simple;
	bh=dyRXTWLcxybI0AP+CCqd39NCshKbuQDX7Ivhx0e29JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmAqppSAoBBIJxW+03RrAWllJ6YsLbrQHR9oUfjSVMubnN0zQVVf87gX3MH9YmDk9b8Na5ZS2s3Ref+yE3B4qh/8UUZnsjAZfrUaST4N8uP3Q90VfCwGCON9QRRjkNm+AIXNsZJ+CHhfqhwyo1PJ+DDo0IaX8xF4KMWj2XY3eoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gorr5YOh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gorr5YOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101B4C4CEF7;
	Sun,  8 Feb 2026 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770561567;
	bh=dyRXTWLcxybI0AP+CCqd39NCshKbuQDX7Ivhx0e29JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gorr5YOh8tLwvweJDayVgXc3q87SmiJEXxV71gdmkbNOZZaLfJYIJzy1PCeX7L0W7
	 XD/3M1wPM/DGXa/SXQRdydac1YVeXan4A/SjuRi+yG22P+dvhvMFllkCpI3Fw7a+NW
	 DbeYU9uEdtw7elfslhxJ07u7RavCnjNwadoqytJN1yqR9cYRcgJ6+TssMaQoCBZIRN
	 zsZfPngNp/zbWpYFs6luNGIRtvroNc0bZXRreLpbMe1EV5Zkb4LcB/CeycuY6393pA
	 fcZmfcTrgabSrhbqRSt06PVdgFnq/d8BY2yx9g73HaLaZ85xjnmgs6LfyxJzASWuyx
	 3QVWj84CdvfZQ==
Date: Sun, 8 Feb 2026 11:39:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>
Subject: Re: [RFC PATCH v2 0/4] Test annotate with data type profiling
Message-ID: <aYigHLZtXooznMB7@x1>
References: <20260208122227.3524-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260208122227.3524-1-9erthalion6@gmail.com>

On Sun, Feb 08, 2026 at 01:22:22PM +0100, Dmitrii Dolgov wrote:
> Add shell tests for data type profiling, including C and rust.
> 
> To support the rust test, a new workload with rust code was introduced.
> To build it only when rust is actually available, also add a feature
> test for rust compiler and guard everything behind it.
> 
> Changes in v2:
> - Switched to use mem record.
> - Fixed the build issue with a custom output.
> - Separated patches for the workload and tests.
> - Added new test for C code.
> - Added a feature test for rust compiler.

Thanks, tested it, everything working as advertised:

⬢ [acme@toolbx perf-tools-next]$ m
make: Entering directory '/home/acme/git/linux/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl

Auto-detecting system features:
...                  libdw: [ on  ]
...                  glibc: [ on  ]
...                 libelf: [ on  ]
...                libnuma: [ on  ]
... numa_num_possible_cpus: [ on  ]
...              libpython: [ on  ]
...            libcapstone: [ on  ]
...              llvm-perf: [ on  ]
...                   zlib: [ on  ]
...                   lzma: [ on  ]
...                    bpf: [ on  ]
...                 libaio: [ on  ]
...                libzstd: [ on  ]
...             libopenssl: [ on  ]
...                   rust: [ on  ] <-------------------------

  INSTALL libsubcmd_headers
<SNIP>

⬢ [acme@toolbx perf-tools-next]$ perf record perf test -w code_with_type
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.162 MB perf.data (4036 samples) ]
⬢ [acme@toolbx perf-tools-next]$ perf report --stdio --dso perf -s srcfile,srcline | head -20
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 4K of event 'cpu/cycles/Pu'
# Event count (approx.): 5337677712
#
# Overhead  Source File        Source:Line
# ........  .................  ..............................................................
#
    25.53%  cmp.rs             cmp.rs:1903
    16.66%  code_with_type.rs  code_with_type.rs:15
    14.48%  ub_checks.rs       ub_checks.rs:68
    11.16%  range.rs           range.rs:204
     6.39%  range.rs           range.rs:0
     4.61%  range.rs           range.rs:849
     3.78%  code_with_type.rs  code_with_type.rs:13
     3.51%  code_with_type.rs  code_with_type.rs:21
     2.89%  range.rs           range.rs:764
⬢ [acme@toolbx perf-tools-next]$ grep -m1 'model name' /proc/cpuinfo
model name	: AMD Ryzen 9 9950X3D 16-Core Processor
⬢ [acme@toolbx perf-tools-next]$ uname -a
Linux toolbx 6.18.8-200.fc43.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jan 30 20:23:28 UTC 2026 x86_64 GNU/Linux
⬢ [acme@toolbx perf-tools-next]$

  root@number:~# perf test 'perf data type profiling tests'
   83: perf data type profiling tests                                  : Ok
  root@number:~# perf test -vv 'perf data type profiling tests'
   83: perf data type profiling tests:
  --- start ---
  test child forked, pid 125028
  Basic Rust perf annotate test
  Basic annotate test [Success]
  Pipe Rust perf annotate test
  Pipe annotate test [Success]
  Basic C perf annotate test
  Basic annotate test [Success]
  Pipe C perf annotate test
  Pipe annotate test [Success]
  ---- end(0) ----
   83: perf data type profiling tests                                  : Ok
  root@number:~#

Thanks, applied to perf-tools-next,

- Arnaldo

- Arnaldo
 
> Dmitrii Dolgov (4):
>   tools/build: Add a feature test for rust compiler
>   perf test workload: Add code_with_type test workload
>   perf tests: Test annotate with data type profiling and rust
>   perf tests: Test annotate with data type profiling and C
> 
>  tools/build/Makefile.build                    | 14 ++++
>  tools/build/Makefile.feature                  |  6 +-
>  tools/build/feature/Makefile                  |  7 ++
>  tools/build/feature/test-rust.rs              |  4 +
>  tools/perf/Makefile.config                    | 11 +++
>  tools/perf/Makefile.perf                      |  2 +-
>  tools/perf/builtin-check.c                    |  1 +
>  tools/perf/tests/builtin-test.c               |  4 +
>  tools/perf/tests/shell/data_type_profiling.sh | 84 +++++++++++++++++++
>  tools/perf/tests/tests.h                      |  4 +
>  tools/perf/tests/workloads/Build              |  5 ++
>  tools/perf/tests/workloads/code_with_type.c   | 46 ++++++++++
>  tools/perf/tests/workloads/code_with_type.rs  | 23 +++++
>  tools/scripts/Makefile.include                |  2 +
>  14 files changed, 210 insertions(+), 3 deletions(-)
>  create mode 100644 tools/build/feature/test-rust.rs
>  create mode 100755 tools/perf/tests/shell/data_type_profiling.sh
>  create mode 100644 tools/perf/tests/workloads/code_with_type.c
>  create mode 100644 tools/perf/tests/workloads/code_with_type.rs
> 
> 
> base-commit: 36a1b0061a584430277861fe5d8bd107aef26137
> -- 
> 2.52.0
> 

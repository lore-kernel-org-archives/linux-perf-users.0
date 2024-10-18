Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3918C03B;
	Fri, 18 Oct 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271751; cv=none; b=h9wsUwWWmwcpi50IQylfRIHC5ETg4b+5VrFlM740b/UqrUD/V4RiLXLy422dXL+NnvBSYBcGZJofYaNLl87BKa84pzS1lDsPHNNQsLveGBBaic/+7TOq1uroZpO8VFEuO4j3Q8yQ/4M5Dom0UQSsggWlDELUO10bEGCDPIRwvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271751; c=relaxed/simple;
	bh=PxV2+YSoG3L+9FeMerajwARE0bW9TZdVPVKJTc27WUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV6KOK6yfiK1ATZjYvZX7RUszWHoPCpfUr8J48KB6WxZTM/OJkOu7Ob1s7QfF1Gd5Eif6vFISRQnW/rPi7BoJn8FMzYp3zixhQzW7ZB55xnkaAIu2Kp1Jat0ZlXwsSJwmzN0Mm820h2ZeDNZagPjGZG5eurYYQQdNFfYMD74RXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbvFbEbb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbvFbEbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB06C4CEC3;
	Fri, 18 Oct 2024 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729271751;
	bh=PxV2+YSoG3L+9FeMerajwARE0bW9TZdVPVKJTc27WUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cbvFbEbbpWMa6AqYecZ4p4hhtkMqbi/BuKtCX7EzVu6UN5hpx7MAEsWF2Gr9jo015
	 9nBZlci6FFMUYSRTJ4b9ruiX2a1ibXh4lk1H5FrzfJSKnPjL51aWEQN4HhDIs60CvH
	 ooFkj/EEeSpTaGpGL3R3XnNhWeU1yIvJq0aCkRT4j/0KjK2ZQElfa9R5fmeuCF/cvj
	 qPmahqoIHpnGBm1zzdqgDXJUv/0/RSUdospo9VsssVBKS/HUPpG+pkwzVZx3CaT2uF
	 z4i+X/yDN05FzTEIw+UsYoCQvFw2+S0oTNrLriybVne3LifqGaEVnce0680oMLG+fT
	 e7mMlDJtITQJA==
Date: Fri, 18 Oct 2024 10:15:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Kajol Jain <kjain@linux.ibm.com>, Atish Patra <atishp@rivosinc.com>,
	Shenlin Liang <liangshenlin@eswincomputing.com>,
	Anup Patel <anup@brainfault.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Dima Kogan <dima@secretsauce.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 00/11] Libdw/dwarf build clean up
Message-ID: <ZxKXxKji_LhtLLpu@google.com>
References: <20241017001354.56973-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017001354.56973-1-irogers@google.com>

On Wed, Oct 16, 2024 at 05:13:43PM -0700, Ian Rogers wrote:
> These patches were originally on top of:
> https://lore.kernel.org/lkml/20240924003720.617258-1-irogers@google.com/
> where it was pointed out that a lot of the libdw conditional
> compilation was due to features that have now been standard for 10 or
> 15 years. The patches remove the conditional compilation assuming the
> features are in libdw where the feature test is expanded to check
> there pressence. The patch series is now on top of:
> https://lore.kernel.org/lkml/20241016235622.52166-1-irogers@google.com/
> 
> In the Makefile code, and for `perf record --call-graph`, dwarf tends
> to mean unwind or libdw support for dwarf things. To make it clearer
> when dwarf really just means libdw numerous build variables and
> defines are renamed.
> 
> There is some tech debt in the changes as perf check still reports the
> values using the old name and for features that are no longer
> tested. This can be cleanup for another day.
> 
> v3: Move PERF_HAVE_DWARF_REGS cleanup to follow up patch series. Add
>     build fix from patch series these changes are on top of.
> v2: Instead of renaming PERF_HAVE_DWARF_REGS to PERF_HAVE_LIBDW_REGS,
>     remove it.
> 
> Ian Rogers (11):
>   perf build: Fix LIBDW_DIR
>   perf build: Rename NO_DWARF to NO_LIBDW
>   perf build: Remove defined but never used variable
>   perf build: Rename test-dwarf to test-libdw
>   perf build: Combine libdw-dwarf-unwind into libdw feature tests
>   perf build: Combine test-dwarf-getlocations into test-libdw
>   perf build: Combine test-dwarf-getcfi into test-libdw
>   perf probe: Move elfutils support check to libdw check
>   perf libdw: Remove unnecessary defines
>   perf build: Rename HAVE_DWARF_SUPPORT to HAVE_LIBDW_SUPPORT
>   perf build: Rename CONFIG_DWARF to CONFIG_LIBDW

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/build/Makefile.feature                  | 11 +---
>  tools/build/feature/Makefile                  | 24 ++------
>  tools/build/feature/test-all.c                | 16 +-----
>  tools/build/feature/test-dwarf.c              | 11 ----
>  tools/build/feature/test-dwarf_getcfi.c       |  9 ---
>  tools/build/feature/test-dwarf_getlocations.c | 13 -----
>  tools/build/feature/test-libdw-dwarf-unwind.c | 14 -----
>  tools/build/feature/test-libdw.c              | 56 +++++++++++++++++++
>  tools/perf/Documentation/perf-check.txt       |  6 +-
>  tools/perf/Makefile.config                    | 47 +++++-----------
>  tools/perf/Makefile.perf                      |  2 +-
>  tools/perf/arch/arm/Makefile                  |  2 +-
>  tools/perf/arch/arm/util/Build                |  2 +-
>  tools/perf/arch/arm64/Makefile                |  2 +-
>  tools/perf/arch/arm64/util/Build              |  2 +-
>  tools/perf/arch/csky/Makefile                 |  2 +-
>  tools/perf/arch/csky/util/Build               |  2 +-
>  tools/perf/arch/loongarch/Makefile            |  2 +-
>  tools/perf/arch/loongarch/util/Build          |  2 +-
>  tools/perf/arch/mips/Makefile                 |  2 +-
>  tools/perf/arch/mips/util/Build               |  2 +-
>  tools/perf/arch/powerpc/Makefile              |  2 +-
>  .../perf/arch/powerpc/annotate/instructions.c |  4 +-
>  tools/perf/arch/powerpc/util/Build            |  4 +-
>  tools/perf/arch/riscv/Makefile                |  2 +-
>  tools/perf/arch/riscv/util/Build              |  2 +-
>  tools/perf/arch/s390/Makefile                 |  2 +-
>  tools/perf/arch/s390/util/Build               |  2 +-
>  tools/perf/arch/sh/Makefile                   |  2 +-
>  tools/perf/arch/sh/util/Build                 |  2 +-
>  tools/perf/arch/sparc/Makefile                |  2 +-
>  tools/perf/arch/sparc/util/Build              |  2 +-
>  tools/perf/arch/x86/Makefile                  |  2 +-
>  tools/perf/arch/x86/annotate/instructions.c   |  2 +-
>  tools/perf/arch/x86/util/Build                |  2 +-
>  tools/perf/arch/xtensa/Makefile               |  2 +-
>  tools/perf/arch/xtensa/util/Build             |  2 +-
>  tools/perf/builtin-annotate.c                 |  2 +-
>  tools/perf/builtin-check.c                    |  6 +-
>  tools/perf/builtin-probe.c                    | 14 ++---
>  tools/perf/builtin-report.c                   |  4 +-
>  tools/perf/util/Build                         | 12 ++--
>  tools/perf/util/annotate-data.h               |  8 +--
>  tools/perf/util/debuginfo.h                   |  6 +-
>  tools/perf/util/disasm.c                      |  4 +-
>  tools/perf/util/disasm.h                      |  4 +-
>  tools/perf/util/dwarf-aux.c                   |  6 --
>  tools/perf/util/dwarf-aux.h                   | 54 ------------------
>  tools/perf/util/genelf.c                      |  4 +-
>  tools/perf/util/genelf.h                      |  2 +-
>  tools/perf/util/include/dwarf-regs.h          |  6 +-
>  tools/perf/util/probe-event.c                 |  4 +-
>  tools/perf/util/probe-finder.c                |  6 --
>  tools/perf/util/probe-finder.h                |  6 +-
>  54 files changed, 154 insertions(+), 259 deletions(-)
>  delete mode 100644 tools/build/feature/test-dwarf.c
>  delete mode 100644 tools/build/feature/test-dwarf_getcfi.c
>  delete mode 100644 tools/build/feature/test-dwarf_getlocations.c
>  delete mode 100644 tools/build/feature/test-libdw-dwarf-unwind.c
>  create mode 100644 tools/build/feature/test-libdw.c
> 
> -- 
> 2.47.0.105.g07ac214952-goog
> 

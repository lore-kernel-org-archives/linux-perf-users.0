Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8502D46D0;
	Tue,  3 Feb 2026 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129764; cv=none; b=fA3ovBDPoDkO/Wz5KF/6/Czbdz949wRvzVsBaOgzaK0kLe88CgZLCqeZhmbNlu/p/SVI4BTzYsJ8Iv6ldX0OOMwzGJjlLcGEAshvjDrcqL8W6a0wjKJ5xBOiYcEqaDiDfaRRAGpjY8PQwVF1um3PV3K+JHZUwiRRhu9L43LQ4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129764; c=relaxed/simple;
	bh=5ezdefhGyTXcbjuTpqXROio3/fvSXh9q7JAF4cMtYiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1wIJNpPKDFvNi5arH9zZnNYPWVxkiHR1DVVjCoO9MmVUpy80dp9jPx/eZ2bvj2wwdpEJatSXhB5z1pgWCHw/DJkRcwzgXikwFkTBB0A5SNxgFMxHl9Gm5Nijv9QOdeSvb3aBADRv4wdd2BvOPVollhZYtufz1iaVx7W+LwiGxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPJ3309d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPJ3309d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CC1C116D0;
	Tue,  3 Feb 2026 14:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770129764;
	bh=5ezdefhGyTXcbjuTpqXROio3/fvSXh9q7JAF4cMtYiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPJ3309dmaWJP+2oPYosTZ8pHHHNaWduhQLA6Y1f2PFNkz5zGqmiRSrPnKMWMNTvl
	 gQq38H6X9pL2JP83mWhHokUuv0ddj1LEaWfZOXSq5QnqjTMqhzpu5HOHFawV5qWxk2
	 kGaDsgcA6sRmuP+5wXBw35FvNpAjt8q4DHZZWbQ7bEfEeGTs/G18M1e1rrAxLymKBj
	 N4ypTDLIO2EuoaW1fiocyST0Hba2gmCqn3AsIVvFsUko88G5fGRqe3+uas/vf3jzON
	 zWMhPYcWtexyipq7u4afqy1tB2pHnOxFoTRWvh5JN0FruWPJRIs+DBhIpjZ7JYVlz1
	 bz2en7O0FYuEg==
Date: Tue, 3 Feb 2026 11:42:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Shimin Guo <shimin.guo@skydio.com>, Yunseong Kim <ysk@kzalloc.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Blake Jones <blakejones@google.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	Aditya Bodkhe <aditya.b1@linux.ibm.com>,
	Chun-Tse Shao <ctshao@google.com>, Andi Kleen <ak@linux.intel.com>,
	Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/6] perf Cross platform KVM support
Message-ID: <aYIJYVp6T4ClBw0M@x1>
References: <20260131200224.1296136-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131200224.1296136-1-irogers@google.com>

On Sat, Jan 31, 2026 at 12:02:18PM -0800, Ian Rogers wrote:
> The existing perf kvm code is using the arch directory, which means a
> data file can only be processed on the same machine type that it was
> recorded. Switch to using the ELF machine of the session at runtime to
> set up the KVM support, making it cross-architectural. So that the ELF
> machine number is available early in initialization add it to the perf
> data file header.
> 
> v2: Wire up the perf data header to have the e_machine and allow early
>     initialization of the KVM operations based upon it.
> v1: https://lore.kernel.org/lkml/20260128074106.788156-1-irogers@google.com/

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Ian Rogers (6):
>   perf test kvm: Add stat live testing
>   perf kvm stat: Remove use of the arch directory
>   perf kvm: Wire up e_machine
>   perf session: Add e_flags to the e_machine helper
>   perf header: Add e_machine/e_flags to the header
>   perf thread: Don't require machine to compute the e_machine
> 
>  tools/perf/Makefile.config                    |   4 -
>  tools/perf/arch/arm64/Makefile                |   1 -
>  tools/perf/arch/arm64/util/Build              |   1 -
>  tools/perf/arch/loongarch/Makefile            |   1 -
>  tools/perf/arch/loongarch/util/Build          |   1 -
>  tools/perf/arch/powerpc/Makefile              |   1 -
>  tools/perf/arch/powerpc/util/Build            |   1 -
>  tools/perf/arch/riscv/Makefile                |   1 -
>  tools/perf/arch/riscv/util/Build              |   2 -
>  tools/perf/arch/s390/Makefile                 |   1 -
>  tools/perf/arch/s390/util/Build               |   1 -
>  tools/perf/arch/x86/Makefile                  |   1 -
>  tools/perf/arch/x86/util/Build                |   1 -
>  tools/perf/builtin-kvm.c                      |  73 +++---
>  tools/perf/builtin-report.c                   |   4 +-
>  tools/perf/builtin-script.c                   |   6 +-
>  tools/perf/tests/shell/kvm.sh                 |  30 ++-
>  tools/perf/util/Build                         |   3 +-
>  tools/perf/util/env.h                         |   3 +
>  tools/perf/util/evsel.c                       |   6 +-
>  tools/perf/util/evsel.h                       |   1 +
>  tools/perf/util/header.c                      |  33 +++
>  tools/perf/util/header.h                      |   1 +
>  tools/perf/util/kvm-stat-arch/Build           |   6 +
>  .../kvm-stat-arch}/arm64_exception_types.h    |   0
>  .../kvm-stat-arch}/book3s_hcalls.h            |   0
>  .../kvm-stat-arch}/book3s_hv_exits.h          |   0
>  .../kvm-stat-arch/kvm-stat-arm64.c}           |  43 ++--
>  .../kvm-stat-arch/kvm-stat-loongarch.c}       |  48 ++--
>  .../kvm-stat-arch/kvm-stat-powerpc.c}         |  61 ++---
>  .../kvm-stat-arch/kvm-stat-riscv.c}           |  42 ++--
>  .../kvm-stat-arch/kvm-stat-s390.c}            |  38 ++--
>  .../kvm-stat-arch/kvm-stat-x86.c}             |  44 ++--
>  .../kvm-stat-arch}/riscv_trap_types.h         |   2 +-
>  tools/perf/util/kvm-stat.c                    | 215 +++++++++++++++++-
>  tools/perf/util/kvm-stat.h                    |  70 ++++--
>  .../scripting-engines/trace-event-python.c    |   8 +-
>  tools/perf/util/session.c                     |  62 ++++-
>  tools/perf/util/session.h                     |   2 +-
>  tools/perf/util/thread.c                      |   5 +
>  40 files changed, 606 insertions(+), 217 deletions(-)
>  create mode 100644 tools/perf/util/kvm-stat-arch/Build
>  rename tools/perf/{arch/arm64/util => util/kvm-stat-arch}/arm64_exception_types.h (100%)
>  rename tools/perf/{arch/powerpc/util => util/kvm-stat-arch}/book3s_hcalls.h (100%)
>  rename tools/perf/{arch/powerpc/util => util/kvm-stat-arch}/book3s_hv_exits.h (100%)
>  rename tools/perf/{arch/arm64/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-arm64.c} (62%)
>  rename tools/perf/{arch/loongarch/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-loongarch.c} (77%)
>  rename tools/perf/{arch/powerpc/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-powerpc.c} (78%)
>  rename tools/perf/{arch/riscv/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-riscv.c} (57%)
>  rename tools/perf/{arch/s390/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-s390.c} (77%)
>  rename tools/perf/{arch/x86/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-x86.c} (88%)
>  rename tools/perf/{arch/riscv/util => util/kvm-stat-arch}/riscv_trap_types.h (96%)
> 
> -- 
> 2.53.0.rc1.225.gd81095ad13-goog
> 

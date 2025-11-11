Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D1A2D23B6;
	Tue, 11 Nov 2025 06:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842092; cv=none; b=Vik2ISjNuiuKXGMM4L9Nq93Yg0zJJsHO4degR3KuKo8swrPcxGv2BrTd3ulrL+nf29FesV88lwCHj5gctjfyJSInRc49Sqd+X+h+jhFfSwx8teCNSHBAPmsv1zre3rxnSY3sFTFvb1Y9Tkg157hEkhc8dvmzxijl1K00iW6xgK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842092; c=relaxed/simple;
	bh=k7wFx6MjrFcR6/FtvmfZIp+aQtZ9Y2PcluLwPu/v1QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMMi3pzpQWqMHYQgpaStX1HeQxLwbNbELG4gGsdPkfo9mQW0wyGNB0B3i4bVNYCHnEGIo4nj7vUFoKnXwWrDFo0Eyjgedsvs3ykienZjX2/vWbAlPuKadCemSbqx8bKYd9NI/6AlyItR/Qaup/x29ZhFB0HNkOP3R4U59Z8fhdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6F6eP3W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6F6eP3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA0DC113D0;
	Tue, 11 Nov 2025 06:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762842091;
	bh=k7wFx6MjrFcR6/FtvmfZIp+aQtZ9Y2PcluLwPu/v1QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6F6eP3WRt2Jp4oRQev1gKvFuUmhPAdSrb0w+rNpfsvBoSOqZadOEQnlBiBPsvD8y
	 JIRoA3UD1urExImdDUdqYMOs2iCCnjDojm/JugbqUU+m8gAVtse0Ab0+cCIpwjfaaP
	 Cg+poDl12QCKyl5VLzacozfE7Ay8IYfiH+f9xZ+T2QN1N2w8HoW1QzztmnFR0XZQKe
	 V9c5Sop3LNeqI2lYTZLTkQkdBMVlVickzAn8fgyTmyn0S1xS3ktrFQaXgAwYoRTt2e
	 3AQWrTA0FbdtbWIkmvFZ7J8FVxD1ztI7y8KDq9E+Jkyq1myOpj8vnoQ3gPWD9K3DGZ
	 G/74RsUZlQ76g==
Date: Mon, 10 Nov 2025 22:21:27 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Tomas Glozar <tglozar@redhat.com>, Quentin Monnet <qmo@kernel.org>,
	Yuzhuo Jing <yuzhuo@google.com>,
	Blake Jones <blakejones@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>, Zecheng Li <zecheng@google.com>,
	tanze <tanze@kylinos.cn>, Gabriele Monaco <gmonaco@redhat.com>,
	GuoHan Zhao <zhaoguohan@kylinos.cn>,
	Markus Elfring <Markus.Elfring@web.de>,
	Colin Ian King <colin.i.king@gmail.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/5] Remove NO_AUXTRACE build option
Message-ID: <aRLV50z1L9A3YRFF@google.com>
References: <20251110013152.3099080-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251110013152.3099080-1-irogers@google.com>

Hi Ian,

On Sun, Nov 09, 2025 at 05:31:47PM -0800, Ian Rogers wrote:
> Switch the __get_cpuid feature for intel-pt to use the provided cpuid
> function in perf, this removes the need for NO_AUXTRACE when the
> feature detection fails. Remove the now unnecessary feature
> detection. Remove NO_AUXTRACE as it just builds a more broken version

Can you please elaborate what the broken part is?

Thanks,
Namhyung


> of perf and isn't guarding dependencies on any libraries, etc. Clean
> up headers files for auxtrace.h.
> 
> This was prompted by needing to make a v2 patch set of:
> https://lore.kernel.org/lkml/20251107170712.2302714-1-irogers@google.com/
> due to a broken NO_AUXTRACE configuration.
> 
> Ian Rogers (5):
>   perf intel-pt: Use the perf provided "cpuid.h"
>   perf build: Don't add NO_AUXTRACE if missing feature-get_cpuid
>   tool build: Remove __get_cpuid feature test
>   perf build: Remove NO_AUXTRACE build option
>   perf auxtrace: Remove errno.h from auxtrace.h and fix transitive
>     dependencies
> 
>  tools/build/Makefile.feature                  |   2 -
>  tools/build/feature/Makefile                  |   4 -
>  tools/build/feature/test-all.c                |   5 -
>  tools/build/feature/test-get_cpuid.c          |   8 -
>  tools/perf/Documentation/perf-check.txt       |   1 -
>  tools/perf/Makefile.config                    |  13 --
>  tools/perf/Makefile.perf                      |   2 -
>  tools/perf/arch/arm/annotate/instructions.c   |   1 +
>  tools/perf/arch/arm/util/Build                |   2 +-
>  tools/perf/arch/arm/util/auxtrace.c           |   1 +
>  tools/perf/arch/arm/util/pmu.c                |   2 -
>  tools/perf/arch/arm64/annotate/instructions.c |   1 +
>  tools/perf/arch/arm64/util/Build              |  19 +-
>  tools/perf/arch/arm64/util/arm-spe.c          |   1 +
>  tools/perf/arch/arm64/util/hisi-ptt.c         |   1 +
>  tools/perf/arch/powerpc/util/Build            |   2 +-
>  tools/perf/arch/powerpc/util/auxtrace.c       |   2 +-
>  tools/perf/arch/s390/util/Build               |   2 +-
>  tools/perf/arch/s390/util/auxtrace.c          |   1 +
>  tools/perf/arch/x86/tests/Build               |   4 +-
>  tools/perf/arch/x86/tests/arch-tests.c        |   4 -
>  tools/perf/arch/x86/tests/intel-pt-test.c     |   6 +-
>  tools/perf/arch/x86/tests/topdown.c           |   1 +
>  tools/perf/arch/x86/util/Build                |   6 +-
>  tools/perf/arch/x86/util/intel-pt.c           |   4 +-
>  tools/perf/arch/x86/util/pmu.c                |   2 -
>  tools/perf/arch/x86/util/topdown.c            |   1 +
>  tools/perf/bench/evlist-open-close.c          |   1 +
>  tools/perf/bench/futex.c                      |   1 +
>  tools/perf/bench/pmu-scan.c                   |   1 +
>  tools/perf/bench/synthesize.c                 |   1 +
>  tools/perf/builtin-check.c                    |   1 -
>  tools/perf/builtin-inject.c                   |  15 --
>  tools/perf/builtin-mem.c                      |   1 +
>  tools/perf/builtin-record.c                   |  36 ---
>  tools/perf/builtin-script.c                   |  12 -
>  tools/perf/tests/hwmon_pmu.c                  |   1 +
>  tools/perf/tests/make                         |   4 +-
>  tools/perf/tests/parse-metric.c               |   1 +
>  tools/perf/tests/pfm.c                        |   1 +
>  tools/perf/ui/hist.c                          |   1 +
>  tools/perf/util/Build                         |  24 +-
>  tools/perf/util/annotate-data.c               |   2 +-
>  tools/perf/util/arm-spe-decoder/Build         |   2 +-
>  tools/perf/util/auxtrace.h                    | 221 +-----------------
>  tools/perf/util/bpf-filter.h                  |   2 +
>  tools/perf/util/bpf-trace-summary.c           |   1 +
>  tools/perf/util/bpf_counter_cgroup.c          |   1 +
>  tools/perf/util/bpf_ftrace.c                  |   3 +-
>  tools/perf/util/bpf_map.c                     |   1 +
>  tools/perf/util/cgroup.c                      |   1 +
>  tools/perf/util/cs-etm-decoder/Build          |   2 +-
>  tools/perf/util/drm_pmu.c                     |   1 +
>  tools/perf/util/evswitch.c                    |   1 +
>  tools/perf/util/hisi-ptt-decoder/Build        |   2 +-
>  tools/perf/util/intel-pt-decoder/Build        |   8 +-
>  tools/perf/util/intel-tpebs.c                 |   1 +
>  tools/perf/util/kvm-stat.h                    |   1 +
>  tools/perf/util/mmap.c                        |   1 +
>  tools/perf/util/pfm.c                         |   1 +
>  tools/perf/util/powerpc-vpadtl.c              |   1 +
>  tools/perf/util/stat-shadow.c                 |   1 +
>  tools/perf/util/synthetic-events.h            |  15 --
>  63 files changed, 77 insertions(+), 391 deletions(-)
>  delete mode 100644 tools/build/feature/test-get_cpuid.c
> 
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB117BB0F;
	Sat, 16 Nov 2024 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731786431; cv=none; b=QSwW6DUJabUpTB+cEaPVjjztJs45cNyPEFS7Fsr7g8gUNvhUDTUWnPO/QDOTSisI1aLoQzrw8823Xbt1nFzI020ea9jMN3hyogUzemJfOmaiFIahwtqhKk4VyM+1f/gqbrC3RnL51HoN3Q6xsLIafgmaf55JLMsW4OhsD/LZiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731786431; c=relaxed/simple;
	bh=A4qVV9tDRxaJPJNkj5ZNN9jdW4qqoLjHW6sCHUJGmwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTD61FZ/6k4Cj5sZ1PIRKWsr9u9c+478QNQjp2Gs5fcz50aTElBY2IULXVmgBhpyZeHaEqlgUQQzEfrr9GSfxR1jPaOqXzACQepUVR48yusHYOIKqOLUbxmL17qjAXiMu1v4sNEWank/9rSDyJQjuXDVQAlkHZnFm/FkWhhjUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lijy5qYM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lijy5qYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3692FC4CEC3;
	Sat, 16 Nov 2024 19:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731786429;
	bh=A4qVV9tDRxaJPJNkj5ZNN9jdW4qqoLjHW6sCHUJGmwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lijy5qYMACLMDKO9zLfN0EkUShWwPvHiK09RgoEfqUrA8nMuZ7wyyw/8HkACqdJ+S
	 TJUHv8WjeYrvvCtGH+bVLgQ1Agx3sMYv7duG84oLFfVYvH45N0x/W0iugVmeJVF2QA
	 t9Xr3baoXf3AIxJqQmaooeMHwalOVSm7qArFZ2Ou2vlXcBBT3BlUwWWKELqs14CO0W
	 80v3SUgVLwghFBhUbEQ7g2fe3Sss95jMEYnw3d8uyVLMtkg+lZxd1IpNzLg4974WOK
	 M/XemHAqU5tdfQnwUWQdbx4bwRg/FqYNYv3qwat4mMhVEYwj6ReOMEpMQZiqtv3EXr
	 bYq4/SrnQZ+WQ==
Date: Sat, 16 Nov 2024 16:47:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Xu Yang <xu.yang_2@nxp.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ben Zong-You Xie <ben717@andestech.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dima Kogan <dima@secretsauce.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/8] Refactor cpuid and metric table lookup code
Message-ID: <Zzj2usdkgdyZ9Z8I@x1>
References: <20241107162035.52206-1-irogers@google.com>
 <215ca9a2-0a63-4d0c-8402-5cb1f2bb0794@linaro.org>
 <ZzdsCWpAULCe839R@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzdsCWpAULCe839R@x1>

On Fri, Nov 15, 2024 at 12:43:05PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Nov 15, 2024 at 03:35:55PM +0000, James Clark wrote:
> > 
> > 
> > On 07/11/2024 4:20 pm, Ian Rogers wrote:
> > > Xu Yang <xu.yang_2@nxp.com> reported issues with the system metric
> > > lookup:
> > > https://lore.kernel.org/linux-perf-users/20241106085441.3945502-1-xu.yang_2@nxp.com/
> > > These patches remove a lot of the logic relating CPUIDs to PMUs so
> > > that the PMU isn't part of the question when finding a metric table.
> > > For time reasons, it doesn't go as far as allowing system metrics
> > > without a metric table as a metric table is needed for metrics to
> > > refer to other metrics, and the refactoring of that resolution is a
> > > hassle.
> > > 
> > > Ian Rogers (7):
> > >    perf header: Move is_cpu_online to numa bench
> > >    perf header: Refactor get_cpuid to take a CPU for ARM
> > >    perf arm64 header: Use cpu argument in get_cpuid
> > >    perf header: Avoid transitive PMU includes
> > >    perf header: Pass a perf_cpu rather than a PMU to get_cpuid_str
> > >    perf jevents: Add map_for_cpu
> > >    perf pmu: Move pmu_metrics_table__find and remove ARM override
> > > 
> > > Xu Yang (1):
> > >    perf jevents: fix breakage when do perf stat on system metric
> > > 
> > >   tools/perf/arch/arm64/util/arm-spe.c     | 14 +---
> > >   tools/perf/arch/arm64/util/header.c      | 73 ++++++++++-----------
> > >   tools/perf/arch/arm64/util/pmu.c         | 20 ------
> > >   tools/perf/arch/loongarch/util/header.c  |  4 +-
> > >   tools/perf/arch/powerpc/util/header.c    |  4 +-
> > >   tools/perf/arch/riscv/util/header.c      |  4 +-
> > >   tools/perf/arch/s390/util/header.c       |  6 +-
> > >   tools/perf/arch/x86/util/auxtrace.c      |  3 +-
> > >   tools/perf/arch/x86/util/header.c        |  5 +-
> > >   tools/perf/bench/numa.c                  | 53 +++++++++++++++
> > >   tools/perf/builtin-kvm.c                 |  4 +-
> > >   tools/perf/pmu-events/empty-pmu-events.c | 39 ++++++-----
> > >   tools/perf/pmu-events/jevents.py         | 39 ++++++-----
> > >   tools/perf/pmu-events/pmu-events.h       |  2 +-
> > >   tools/perf/tests/expr.c                  |  5 +-
> > >   tools/perf/util/env.c                    |  4 +-
> > >   tools/perf/util/expr.c                   |  6 +-
> > >   tools/perf/util/header.c                 | 82 ++++++++----------------
> > >   tools/perf/util/header.h                 | 23 +++----
> > >   tools/perf/util/pmu.c                    | 25 --------
> > >   tools/perf/util/pmu.h                    |  2 -
> > >   tools/perf/util/probe-event.c            |  1 +
> > >   22 files changed, 189 insertions(+), 229 deletions(-)
> > > 
> > 
> > Reviewed-by: James Clark <james.clark@linaro.org>
> 
> Thanks for reviewing James, I'm doing a round of tests to push what I
> have in tmp.perf-tools-next to perf-tools-next so that it gets test
> merged on linux-next and later today I'll escape from the holiday and
> take a last look on this series, apply and test.

Applied locally, pushing to tmp.perf-tools-next as I'm still testing the
hwmon case, building it on an 32-bit ARM machine:

processor	: 3
model name	: ARMv7 Processor rev 4 (v7l)
BogoMIPS	: 38.40
Features	: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32 
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

Hardware	: BCM2835
Revision	: a020d3
Serial		: 00000000783939e0
Model		: Raspberry Pi 3 Model B Plus Rev 1.3

- Arnaldo

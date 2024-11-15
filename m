Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969592F29;
	Fri, 15 Nov 2024 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685388; cv=none; b=HupIaeqEY2X3VRHqUc9ma3kcHQQoVVYba+69x7/HkXEjxTo3V9GmK4Vrb8GK1b2A8OBFvF75Ji0Wv868csnYLV90ePFGPE/GySGsO1EtdAloRvsG4s/s2b0hjNUGsI/Jfe78PvhBR3Loy3sNQYxIJaBHZ2EJFF64VzX4Zdk916A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685388; c=relaxed/simple;
	bh=/dcFxhHKBWLL34nz7gEKNRpldABlavWv3YKIJYlie4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTZTHV9IWyw99jSGnU5GOx36MR6J8CO5c29UmM5I2HSL8Yo9NwSGbfQbMtMxthEMLHvZu2AFMmFwIuE97E+G+wb5Af0TcK2CmfB2/sXNkDJPoyi4pVgXi8nkFWju10ZQ0DzhzaeDhgSk1NVS1B+psrC+YyBxJp2qmb8m8eG7dDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm1PMV7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm1PMV7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7FBC4CECF;
	Fri, 15 Nov 2024 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731685388;
	bh=/dcFxhHKBWLL34nz7gEKNRpldABlavWv3YKIJYlie4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qm1PMV7mxCVMp40wyrDL58hCCRzwWaEgCxfDMIQCylAkVlFcaqG1PQjKLkYZ6T4w6
	 PtrbyzmY7Cr+ZCdNByLnjTLya3JOwjOUvKFYKJSssn4qvV3m6aVcopLdRF4dOe1plP
	 KiUnUk70zxZU1VrcbybGJoZHHZXv1tVy+Akx3aZkmpsfa9Ts+RLnyLg/pG7GT7ckII
	 nXdO4J9hI0hHh6rRSUMdn9ybG5cO2a8tvRxWI1yBwVKP8olyJbokl1crJTE9P7Gndk
	 2v0KRcW1+Mmueo1wMvdR7lEN9Y71VQKa9jw6CORkFBmpD8dUp87BNaMYrqS0UtiRDm
	 qLeAuWMKjMXBQ==
Date: Fri, 15 Nov 2024 12:43:05 -0300
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
Message-ID: <ZzdsCWpAULCe839R@x1>
References: <20241107162035.52206-1-irogers@google.com>
 <215ca9a2-0a63-4d0c-8402-5cb1f2bb0794@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215ca9a2-0a63-4d0c-8402-5cb1f2bb0794@linaro.org>

On Fri, Nov 15, 2024 at 03:35:55PM +0000, James Clark wrote:
> 
> 
> On 07/11/2024 4:20 pm, Ian Rogers wrote:
> > Xu Yang <xu.yang_2@nxp.com> reported issues with the system metric
> > lookup:
> > https://lore.kernel.org/linux-perf-users/20241106085441.3945502-1-xu.yang_2@nxp.com/
> > These patches remove a lot of the logic relating CPUIDs to PMUs so
> > that the PMU isn't part of the question when finding a metric table.
> > For time reasons, it doesn't go as far as allowing system metrics
> > without a metric table as a metric table is needed for metrics to
> > refer to other metrics, and the refactoring of that resolution is a
> > hassle.
> > 
> > Ian Rogers (7):
> >    perf header: Move is_cpu_online to numa bench
> >    perf header: Refactor get_cpuid to take a CPU for ARM
> >    perf arm64 header: Use cpu argument in get_cpuid
> >    perf header: Avoid transitive PMU includes
> >    perf header: Pass a perf_cpu rather than a PMU to get_cpuid_str
> >    perf jevents: Add map_for_cpu
> >    perf pmu: Move pmu_metrics_table__find and remove ARM override
> > 
> > Xu Yang (1):
> >    perf jevents: fix breakage when do perf stat on system metric
> > 
> >   tools/perf/arch/arm64/util/arm-spe.c     | 14 +---
> >   tools/perf/arch/arm64/util/header.c      | 73 ++++++++++-----------
> >   tools/perf/arch/arm64/util/pmu.c         | 20 ------
> >   tools/perf/arch/loongarch/util/header.c  |  4 +-
> >   tools/perf/arch/powerpc/util/header.c    |  4 +-
> >   tools/perf/arch/riscv/util/header.c      |  4 +-
> >   tools/perf/arch/s390/util/header.c       |  6 +-
> >   tools/perf/arch/x86/util/auxtrace.c      |  3 +-
> >   tools/perf/arch/x86/util/header.c        |  5 +-
> >   tools/perf/bench/numa.c                  | 53 +++++++++++++++
> >   tools/perf/builtin-kvm.c                 |  4 +-
> >   tools/perf/pmu-events/empty-pmu-events.c | 39 ++++++-----
> >   tools/perf/pmu-events/jevents.py         | 39 ++++++-----
> >   tools/perf/pmu-events/pmu-events.h       |  2 +-
> >   tools/perf/tests/expr.c                  |  5 +-
> >   tools/perf/util/env.c                    |  4 +-
> >   tools/perf/util/expr.c                   |  6 +-
> >   tools/perf/util/header.c                 | 82 ++++++++----------------
> >   tools/perf/util/header.h                 | 23 +++----
> >   tools/perf/util/pmu.c                    | 25 --------
> >   tools/perf/util/pmu.h                    |  2 -
> >   tools/perf/util/probe-event.c            |  1 +
> >   22 files changed, 189 insertions(+), 229 deletions(-)
> > 
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks for reviewing James, I'm doing a round of tests to push what I
have in tmp.perf-tools-next to perf-tools-next so that it gets test
merged on linux-next and later today I'll escape from the holiday and
take a last look on this series, apply and test.

- Arnaldo

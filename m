Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B258258CCB;
	Thu, 15 May 2025 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333112; cv=none; b=JiQIq27XmuCrIvVQTcF1bLHOezVsX5urOTXMG1aPlDXiq6UrfmOu/PYGpN704SoSp9Q3TI2bjBoAiUg4plKqgf2JrzvSMDJgbVnV3Fq+sOceyK1tTHv7nCNmUHkzCgq66zyKGKGnxYxfDy3UwNOvDeiiI6rGZwvrUtIVszCYrE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333112; c=relaxed/simple;
	bh=8QKeFt2r4eXB7eFWHeo1FaHEXWdnjvRBJxlqCxzpVz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVzUMSFV58i7vGzGd28dUg5sECgOKA0mu3ErCk+oQ6MqmSBCvIT3H5PaHWG58/hcJ25WZg0RpRVAU5tgDRrmVU7RjbxQ+sMh+lecnnwsOlLjM7HW5MCE73Uo0PcJnnPiWMeZVv+S0qLhTI31CThPNyPc51OTcCQm0TVm+rGNDbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4O4j9vo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4O4j9vo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BA9C4CEE7;
	Thu, 15 May 2025 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747333111;
	bh=8QKeFt2r4eXB7eFWHeo1FaHEXWdnjvRBJxlqCxzpVz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4O4j9voAFs0ls3gBZbPTn32hW+THu7aQAIXbVEbhZ47ghpYCPxb8c8uzaCrX0IlH
	 XbsLH5z1/sttOEwIQHBlyK01l5ulNZ36bxSwYql/g4Nhrsi//t3Sj9ZNDSo1PLWciR
	 JHRa4Gi4p4YY6937rKZ0YBjcea9YkiS1fgmTXIjHc/kNdCLpZ1ZPNGh4q3M8vXg8Iq
	 7V/KTeJ5pgy4G5hUdk2e/tUJDFLwoMs96lNQ0cTi5QX6enDvlRYGn5ztH/GgWpbRhQ
	 PLQAQz1hqDjJCLprQl5v6e70i3snENciCFmbV6g6O0MR+TUiXatjkQuV6vyvO0Gd2W
	 UhZgRTPWWwpFA==
Date: Thu, 15 May 2025 15:18:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Weilin Wang <weilin.wang@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on graniterapids
Message-ID: <aCYv9KBA0fYlT143@x1>
References: <20250515043818.236807-1-irogers@google.com>
 <aCYTG12gSmv0OtXN@x1>
 <aCYTaveeziFiF3kw@x1>
 <CAP-5=fWBdCVSM_QLcLJ66g+LC0ykrJbZA6mQUsH_++xLormFzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWBdCVSM_QLcLJ66g+LC0ykrJbZA6mQUsH_++xLormFzQ@mail.gmail.com>

On Thu, May 15, 2025 at 10:02:44AM -0700, Ian Rogers wrote:
> On Thu, May 15, 2025 at 9:16 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, May 15, 2025 at 01:15:26PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, May 14, 2025 at 09:38:18PM -0700, Ian Rogers wrote:
> > > > On graniterapids the cache home agent (CHA) and memory controller
> > > > (IMC) PMUs all have their cpumask set to per-socket information. In
> > > > order for per NUMA node aggregation to work correctly the PMUs cpumask
> > > > needs to be set to CPUs for the relevant sub-NUMA grouping.
> > >
> > > I'm blindly applying it as I can't test these changes, and I think this
> > > is bad.
> >
> > In the end the only review/action I could do was to turn:
> >
> > Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
> >
> > Into:
> >
> > Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumasks for sub-NUMA clusters
> >
> > :-(
> >
> > Besides the build tests, etc.
> 
> It isn't the easiest to test. Let me add Weilin Wang on v3 as I think
> she has a graniterapids and could hopefully provide a tested-by tag
> :-)

But, one more review action, will wait for v2:

         make_refcnt_check_O: cd . && make EXTRA_CFLAGS=-DREFCNT_CHECKING=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.HAAu6nXJ16 DESTDIR=/tmp/tmp.NpycD5uTsi
cd . && make EXTRA_CFLAGS=-DREFCNT_CHECKING=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.HAAu6nXJ16 DESTDIR=/tmp/tmp.NpycD5uTsi
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
  diff -u tools/include/linux/bits.h include/linux/bits.h
  diff -u tools/include/vdso/unaligned.h include/vdso/unaligned.h
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
Makefile.config:968: No libllvm 13+ found, slower source file resolution, please install llvm-devel/llvm-dev
Makefile.config:1147: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

  GEN     /tmp/tmp.HAAu6nXJ16/common-cmds.h
<SNIP>
  CC      /tmp/tmp.HAAu6nXJ16/arch/x86/util/pmu.o
  TEST    /tmp/tmp.HAAu6nXJ16/pmu-events/empty-pmu-events.log
  GEN     /tmp/tmp.HAAu6nXJ16/pmu-events/pmu-events.c
  CC      /tmp/tmp.HAAu6nXJ16/arch/x86/tests/hybrid.o
  CC      /tmp/tmp.HAAu6nXJ16/arch/x86/tests/intel-pt-test.o
  CC      /tmp/tmp.HAAu6nXJ16/util/block-info.o
  CC      /tmp/tmp.HAAu6nXJ16/util/block-range.o
  CC      /tmp/tmp.HAAu6nXJ16/util/build-id.o
  CC      /tmp/tmp.HAAu6nXJ16/tests/pmu.o
  MKDIR   /tmp/tmp.HAAu6nXJ16/ui/browsers/
  CC      /tmp/tmp.HAAu6nXJ16/ui/browsers/annotate-data.o
  CC      /tmp/tmp.HAAu6nXJ16/bench/futex-wake.o
  CC      /tmp/tmp.HAAu6nXJ16/arch/x86/util/kvm-stat.o
  CC      /tmp/tmp.HAAu6nXJ16/builtin-help.o
  MKDIR   /tmp/tmp.HAAu6nXJ16/ui/tui/
  MKDIR   /tmp/tmp.HAAu6nXJ16/ui/tui/
  CC      /tmp/tmp.HAAu6nXJ16/ui/tui/setup.o
  CC      /tmp/tmp.HAAu6nXJ16/ui/browsers/hists.o
  CC      /tmp/tmp.HAAu6nXJ16/ui/tui/util.o
arch/x86/util/pmu.c: In function ‘gnr_uncore_cha_imc_adjust_cpumask_for_snc’:
arch/x86/util/pmu.c:249:42: error: ‘struct perf_cpu_map’ has no member named ‘map’
  249 |                         adjusted[pmu_snc]->map[idx].cpu = cpu.cpu + cpu_adjust;
      |                                          ^~
  CC      /tmp/tmp.HAAu6nXJ16/builtin-buildid-list.o
make[8]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:86: /tmp/tmp.HAAu6nXJ16/arch/x86/util/pmu.o] Error 1
make[8]: *** Waiting for unfinished jobs....
  CC      /tmp/tmp.HAAu6nXJ16/arch/x86/tests/bp-modify.o
  LD      /tmp/tmp.HAAu6nXJ16/scripts/python/Perf-Trace-Util/perf-util-in.o


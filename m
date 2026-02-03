Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB91A394486;
	Tue,  3 Feb 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130211; cv=none; b=gxoBpqYRD0xT0LNj7pCfO0UeOfwtZXThUM/nek3jDOZcsFk03WHVt4J+5ZJKg7klZqpgos+zdjZIBm/VXPOT7avo910A1GK8oKckW48nLp+Tf5f9L/f8+GdQgCF9xavJ4meRns/7/rb/naiWZWPGU9wNW/vpncplfs9amzy+T6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130211; c=relaxed/simple;
	bh=Q8456P1VQOVFCApAUqH6izNa32QsSi8SAdkhVUDOFV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiDe5Mncrj6mdDGZs5TlsWuj3rDWptx3NeZeGKVbUoK7BszSbPCjYug7rCuSzMtRHqZcu3ZXLH7dvT6clZE4wQi9Aj3rUiB4DTTeFreJ3LZ1O2iDeIhwX8x4ASlmy4vMNwq5AbAfI76RYEVDCkc3u/FsXFPFJP2OSvYQdHGrSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAtOghhz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAtOghhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6896C116D0;
	Tue,  3 Feb 2026 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770130211;
	bh=Q8456P1VQOVFCApAUqH6izNa32QsSi8SAdkhVUDOFV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAtOghhzJiAujmyWb62cEXmbg90mVJqthG0jWGM6uAyNVQaNzKe2NYQaQh9MVSOnM
	 TAGYcCqMfqpVHRS2ECuIEvHcbzWi8HgmevBQ/DmLLIWVnLtaFgAUgac2Ej1yta6/DB
	 gR8BL3xdk34grwyxNJ8hjcI3gEdKbtVo4b3+ebanUVmgXgXJTKHgZEYTlebRTqMr4Z
	 hoN6lSozbJpQbXFNC+DbviZ7x4dsAEsSjAZ6xLvn0rlSXjJclg/0uKhJLDT96iKaO8
	 CkEcghgp8T0R9rIdDdRziq0Uzt0teVvA9qkYAOdyUjiLNb2lQ1BzwHhTszSeqHT7dv
	 KQ8CJFTTjN1uQ==
Date: Tue, 3 Feb 2026 11:50:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf build: Reduce pmu-events related copying and
 mkdirs
Message-ID: <aYILIOanehkzQx0M@x1>
References: <20260203051327.2836070-1-irogers@google.com>
 <CAP-5=fXV48R6rrpWnTwBHqFuOTF1BSL=0CGBSj4=8JZ5wAMT5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXV48R6rrpWnTwBHqFuOTF1BSL=0CGBSj4=8JZ5wAMT5Q@mail.gmail.com>

On Mon, Feb 02, 2026 at 10:27:25PM -0800, Ian Rogers wrote:
> On Mon, Feb 2, 2026 at 9:13 PM Ian Rogers <irogers@google.com> wrote:
> >
> > When building to an output directory the previous code would remove
> > files and then copy the source files over. Each source file copy would
> > have a rule to make its directory. All json for every architecture was
> > considered a source file. This led to unnecessary copying as a file
> > would be deleted and then the same file copied again, unnecessary
> > directory making, and copying of files not used in the build. A
> > side-effect would be a lot of build messages.
> >
> > This change makes it so that all computed output files are created and
> > then compared to all files in the OUTPUT directory. By filtering out
> > the files that would be copied, unnecessary files can be determined
> > and then deleted - note, this is a phony target which would remake the
> > pmu-events.c if always depended upon, and so the dependency is
> > conditional on there being files to remove. This has some overhead as
> > the $(OUTPUT)/pmu-events is "find" over rather than just "rm -fr", but
> > the savings from unnecessary copying, etc. should make up for this new
> > make overhead. The copy target just does copying but has a dependency
> > on the directory it needs being built, avoiding repetitive mkdirs. The
> > source files for copying only consider the JEVENTS_ARCH unless the
> > JEVENTS_ARCH is all. The metric json is only generated if appropriate,
> > rather than always being generated and jevents.py deciding whether or
> > not to use the files. The mypy and pylint targets are fixed as
> > variable names had changed but the rules not updated.
> >
> > The line count of a build with "make -C tools/perf O=/tmp/perf clean all"
> > prior to this change was 2181 lines, after this change it is 1596
> > lines. This is a reduction of 585 lines or about 27%.
> >
> > The generated pmu-events.c for JEVENTS_ARCH "x86" and "all" were
> > validated as being identical after this change.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> I just wanted to add a note on testing this change. You can see the
> rules run by say building JEVENTS_ARCH=arm64 and then switching to
> JEVENTS_ARCH=x86. The first build will copy the arm64 json to the
> OUTPUT directory, the second will find the arm64 json shouldn't be in
> the OUTPUT directory and remove it while copying/generating in all the
> x86 json.

I'm getting this warning even after a 'make -C tools/ clean':

pmu-events/Build:136: warning: overriding recipe for target '/tmp/build/perf-tools-next/pmu-events/arch/common/common/legacy-cache.json'
pmu-events/Build:44: warning: ignoring old recipe for target '/tmp/build/perf-tools-next/pmu-events/arch/common/common/legacy-cache.json'


Everytime I build with:

⬢ [acme@toolbx perf-tools-next]$ alias m
alias m='rm -rf ~/libexec/perf-core/ ; make CORESIGHT=1 -k O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf test import && cat /tmp/build/$(basename $PWD)/feature/test-all.make.output'
⬢ [acme@toolbx perf-tools-next]$

- Arnaldo

 
> ```
> $ make -C tools/perf O=/tmp/perf3 JEVENTS_ARCH=arm64 clean all
> ...
>  MKDIR   /tmp/perf3/pmu-events/arch/common/common
>  MKDIR   /tmp/perf3/pmu-events/arch/test/test_soc/sys
>  MKDIR   /tmp/perf3/pmu-events/arch/test/test_soc/cpu
>  COPY    /tmp/perf3/ <- pmu-events/arch/test/arch-std-events.json
>  MKDIR   /tmp/perf3/pmu-events/arch/arm64
>  MKDIR   /tmp/perf3/pmu-events/arch/arm64/hisilicon/hip08
>  MKDIR   /tmp/perf3/pmu-events/arch/arm64/hisilicon/hip09/sys
>  MKDIR   /tmp/perf3/pmu-events/arch/arm64/cavium/thunderx2
>  COPY    /tmp/perf3/ <- pmu-events/arch/arm64/recommended.json
>  MKDIR   /tmp/perf3/pmu-events/arch/arm64/thead/yitian710/sys
>  MKDIR   /tmp/perf3/pmu-events/arch/arm64/ampere/ampereone
>  MKDIR   /tmp/perf3/pmu-events/arch/arm64/ampere/emag
>  MKDIR   /tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex
> ...
>  GEN     /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/extra-metrics.json
>  GEN     /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/extra-metrics.json
>  GEN     /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/extra-metrics.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/common/common/legacy-hardware.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/test/test_soc/sys/uncore.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/test/test_soc/cpu/metrics.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/test/test_soc/cpu/uncore.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/test/test_soc/cpu/other.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/test/test_soc/cpu/cache.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/test/test_soc/cpu/branch.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/arm64/mapfile.csv
>  COPY    /tmp/perf3/ <- pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
>  ...
>  TEST    /tmp/perf3/pmu-events/empty-pmu-events.log
>  GEN     /tmp/perf3/pmu-events/pmu-events.c
> ...
> $ make -C tools/perf O=/tmp/perf3 JEVENTS_ARCH=x86 all
>  MKDIR   /tmp/perf3/pmu-events/arch/x86
>  MKDIR   /tmp/perf3/pmu-events/arch/x86/elkhartlake
>  MKDIR   /tmp/perf3/pmu-events/arch/x86/rocketlake
>  MKDIR   /tmp/perf3/pmu-events/arch/x86/broadwellde
> ...
>  GEN     /tmp/perf3/pmu-events/arch/x86/amdzen1/extra-metrics.json
>  GEN     /tmp/perf3/pmu-events/arch/x86/amdzen2/extra-metrics.json
>  GEN     /tmp/perf3/pmu-events/arch/x86/amdzen3/extra-metrics.json
>  GEN     /tmp/perf3/pmu-events/arch/x86/amdzen4/extra-metrics.json
>  GEN     /tmp/perf3/pmu-events/arch/x86/amdzen5/extra-metrics.json
>  GEN     /tmp/perf3/pmu-events/arch/x86/amdzen6/extra-metrics.json
>  GEN     /tmp/perf3/pmu-events/arch/x86/amdzen1/extra-metricgroups.json
>  GEN     /tmp/perf3/pmu-events/arch/x86/amdzen2/extra-metricgroups.json
> ...
>  COPY    /tmp/perf3/ <- pmu-events/arch/x86/mapfile.csv
>  COPY    /tmp/perf3/ <- pmu-events/arch/x86/elkhartlake/ehl-metrics.json
>  RM      /tmp/perf3/pmu-events/arch/arm64/mapfile.csv
> /tmp/perf3/pmu-events/arch/arm64/sbsa.json
> /tmp/perf3/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json
> /tmp/perf3/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json
> /tmp/per
> f3/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json
> /tmp/perf3/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json
> /tmp/perf3/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
> /tmp/perf3/pmu-events/arch/arm64/freescale/imx93/sy
> s/metrics.json /tmp/perf3/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
> /tmp/perf3/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
> /tmp/perf3/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json
> /tmp/perf3/pmu-events/arch/
> arm64/freescale/imx8mn/sys/metrics.json
> /tmp/perf3/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
> /tmp/perf3/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
> /tmp/perf3/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json /tmp/
> perf3/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json
> /tmp/perf3/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
> /tmp/perf3/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53
> /branch.json /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53/cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53/other.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-
> a53/bus.json /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a53/extra-metrics.json
> /tmp/perf3/pmu-events/arc
> h/arm64/arm/cortex-a73/etm.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/branch.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/instruction.json
> /tmp/perf3/pmu-events
> /arch/arm64/arm/cortex-a73/mmu.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/pipeline.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/memory.json
> /tmp/perf3/pmu-events/
> arch/arm64/arm/cortex-a73/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a73/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/ll_cache
> .json /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/spec_operation.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/l3_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/stall.json
> /tmp/perf3/pmu-events/arch/arm64/arm/ne
> overse-v1/tlb.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/general.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/retired.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/metrics.json
> /tmp/perf3/pmu-events/arch/arm64
> /arm/neoverse-v1/spe.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/l1i_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/fp_operation.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/bus.json
> /tmp/perf3/pmu-events/
> arch/arm64/arm/neoverse-v1/l1d_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/sve.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/exception.json
> /tmp/perf3/p
> mu-events/arch/arm64/arm/neoverse-v1/l2_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v1/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a
> 75/etm.json /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/branch.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cort
> ex-a75/mmu.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/pipeline.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/corte
> x-a75/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a75/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/branch.json
> /tmp/perf3/pmu
> -events/arch/arm64/arm/cortex-a65-e1/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/ifu.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/pipeline.j
> son /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-
> a65-e1/dpu.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a65-e1/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
> /tmp/perf3/pmu-events/
> arch/arm64/arm/cmn/sys/metric.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/branch.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/pipeline.json
> /tmp/perf3/p
> mu-events/arch/arm64/arm/cortex-a510/cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/trace.json /tmp/perf3
> /pmu-events/arch/arm64/arm/cortex-a510/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a510/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neove
> rse-v3/ll_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/spec_operation.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/stall.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/general.json
> /tmp/perf3/pmu-events/arc
> h/arm64/arm/neoverse-v3/tlb.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/retired.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/brbe.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
> /tmp/perf3/pmu-events
> /arch/arm64/arm/neoverse-v3/spe.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/l1i_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/fp_operation.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/bus.json /tmp/perf3/
> pmu-events/arch/arm64/arm/neoverse-v3/l1d_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/sve.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/exception.json /
> tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/l2_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-v3/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/a
> rm/cortex-a77/branch.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a77/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a77/cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a77/pipeline.json
> /tmp/perf3/pmu-events/arc
> h/arm64/arm/cortex-a77/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a77/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a77/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a77/extra-metricgroups.json
> /tmp/perf3
> /pmu-events/arch/arm64/arm/cortex-a77/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57
> -a72/cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json
> /tmp/perf3/pmu-events/arch/ar
> m64/arm/cortex-a57-a72/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a57-a72/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/ll_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/spec_op
> eration.json /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/l3_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/stall.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/tlb.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neover
> se-n1/general.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/retired.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/spe.json
> /tmp/perf3/pmu-events/arch/arm64/arm
> /neoverse-n1/l1i_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/l1d_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/memory.json
> /tmp/perf3/pmu-events/arch
> /arm64/arm/neoverse-n1/l2_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n1/extra-metrics.
> json /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/ll_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/l3_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/spec_operation.json
> /tmp/perf3/pmu-events/arch/arm64/arm/
> neoverse-n3/stall.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/tlb.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/general.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/retired.json
> /tmp/perf3/pmu-events/arch/arm64
> /arm/neoverse-n3/metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/spe.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/l1i_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/fp_operation.json
> /tmp/perf3/pmu-eve
> nts/arch/arm64/arm/neoverse-n3/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/l1d_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/sve.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/trace.json
> /tmp/perf3/pmu-
> events/arch/arm64/arm/neoverse-n3/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/l2_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/extra-metricgro
> ups.json /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n3/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/branch.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/arm/
> cortex-x1/cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/pipeline.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cor
> tex-x1/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x1/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/branch.json
> /tmp/perf3/pmu-even
> ts/arch/arm64/arm/cortex-x2/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/pipeline.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/bus.json
> /tmp/perf3/pmu-ev
> ents/arch/arm64/arm/cortex-x2/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/trace.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-x2/extra-metricgroups.json
> /tmp
> /perf3/pmu-events/arch/arm64/arm/cortex-x2/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/branch.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/ca
> che.json /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/
> extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a34/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/branch.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/instruction.json
> /tmp/perf3/pmu-events
> /arch/arm64/arm/cortex-a55/cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/pipeline.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/bus.json
> /tmp/perf3/pmu-event
> s/arch/arm64/arm/cortex-a55/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a55/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/spe
> c_operation.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.json
> /tmp/perf3/pmu-events/arc
> h/arm64/arm/neoverse-n2-v2/tlb.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json
> /tmp/p
> erf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/spe.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1i_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/fp_operation.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse
> -n2-v2/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/sve.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/trace.json
> /tmp/perf3/pmu-events/arch/arm
> 64/arm/neoverse-n2-v2/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/extra-metricgroups
> .json /tmp/perf3/pmu-events/arch/arm64/arm/neoverse-n2-v2/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a35/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a35/branch.json
> /tmp/perf3/pmu-events/arch/arm64/ar
> m/cortex-a35/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a35/cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a35/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a35/exception.json
> /tmp/perf3/pmu-events/arch/arm64/
> arm/cortex-a35/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a35/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/branch.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/instruction.json /tmp
> /perf3/pmu-events/arch/arm64/arm/cortex-a710/cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/pipeline.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/trace.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/memory.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a710/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/co
> rtex-a710/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/branch.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/cache.json
> /tmp/perf3/pmu-events/ar
> ch/arm64/arm/cortex-a76/pipeline.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/memory.json
> /tmp/perf3/pmu-even
> ts/arch/arm64/arm/cortex-a76/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a76/extra-metrics.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/branch.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/instructi
> on.json /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/cache.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/pipeline.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/bus.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/mem
> ory.json /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/exception.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/extra-metricgroups.json
> /tmp/perf3/pmu-events/arch/arm64/arm/cortex-a78/extra-metrics.json
> /tmp/perf3/pmu-events/arch
> /arm64/fujitsu/a64fx/branch.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/cache.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/other.json
> /tmp/perf3/pmu-events/ar
> ch/arm64/fujitsu/a64fx/pipeline.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/bus.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/sve.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json
> /tmp/perf3/pmu-events/arch/arm
> 64/fujitsu/a64fx/memory.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/a64fx/exception.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/spec_operation.json
> /tmp/perf3/pmu-e
> vents/arch/arm64/fujitsu/monaka/l3_cache.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/stall.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/tlb.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/general.json
> /tmp/perf3/pmu
> -events/arch/arm64/fujitsu/monaka/retired.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/gcycle.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/cycle_accounting.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/pipeline.jso
> n /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/l1i_cache.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/core-imp-def.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu
> /monaka/l1d_cache.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/sve.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/trace.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/energy.json
> /tmp/perf3/pmu-events/arch/arm64/fujit
> su/monaka/memory.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/exception.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/l2_cache.json
> /tmp/perf3/pmu-events/arch/arm64/fujitsu/monaka/hwpf.json
> /tmp/perf3/pmu-events/arch/arm64
> /common-and-microarch.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/branch.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/cache.json
> /tmp/perf3/pmu-ev
> ents/arch/arm64/ampere/ampereonex/mmu.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/intrinsic.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/spe.json /tmp
> /perf3/pmu-events/arch/arm64/ampere/ampereonex/pipeline.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/bus.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereo
> nex/memory.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereonex/exception.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/emag/branch.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/emag/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/amp
> ere/emag/clock.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/emag/cache.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/emag/intrinsic.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/emag/pipeline.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/em
> ag/bus.json /tmp/perf3/pmu-events/arch/arm64/ampere/emag/memory.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/emag/exception.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/branch.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampere
> one/instruction.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/cache.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/intrinsic.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> /tmp/perf3/pmu-events/arch/
> arm64/ampere/ampereone/spe.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/bus.json
> /tmp/perf3/pmu
> -events/arch/arm64/ampere/ampereone/memory.json
> /tmp/perf3/pmu-events/arch/arm64/ampere/ampereone/exception.json
> /tmp/perf3/pmu-events/arch/arm64/thead/yitian710/sys/ali_drw.json
> /tmp/perf3/pmu-events/arch/arm64/thead/yitian710/sys/metri
> cs.json /tmp/perf3/pmu-events/arch/arm64/recommended.json
> /tmp/perf3/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
> /tmp/perf3/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json
> /tmp/perf3/pmu-events/arch/arm64/hisilicon
> /hip08/uncore-l3c.json
> /tmp/perf3/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> /tmp/perf3/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
> /tmp/perf3/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
> /tmp/perf3/pmu-event
> s/arch/arm64/hisilicon/hip08/uncore-ddrc.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/x86/elkhartlake/memory.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/x86/elkhartlake/frontend.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/x86/elkhartlake/virtual-memory.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/x86/elkhartlake/pipeline.json
> ...
>  COPY    /tmp/perf3/ <- pmu-events/arch/x86/knightslanding/uncore-cache.json
>  COPY    /tmp/perf3/ <- pmu-events/arch/x86/knightslanding/cache.json
>  GEN     /tmp/perf3/pmu-events/test-empty-pmu-events.c
>  TEST    /tmp/perf3/pmu-events/empty-pmu-events.log
>  GEN     /tmp/perf3/pmu-events/pmu-events.c
>  CC      /tmp/perf3/pmu-events/pmu-events.o
>  LD      /tmp/perf3/pmu-events/pmu-events-in.o
> ...
> ```
> 
> Thanks,
> Ian

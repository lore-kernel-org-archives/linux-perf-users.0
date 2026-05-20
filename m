Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C1313277;
	Wed, 20 May 2026 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307222; cv=none; b=BzrIrVym8Mcy6UAYskfXuWN7FejJTKxM91BjfPh5H4d4xM0yw1uRowpwgeZ/jOk82sll5B+K4+fHgPm0F9JZTyMEaYPGRTF31d1Vhcm2bTaHqzzdPJQlr1ecmm31WmwulUU7uiYrtVUgAJUP5McWYxXXBpF2crfM3H6H6Pi10NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307222; c=relaxed/simple;
	bh=XbTQeDOfzO8KcBwlz+t8SkDFII6lPL8Cbp6BYKW3Udo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1Qfsn3jo/gLdym/jTKZa9rMpgZHo3ziGi6q/TqGMCxB4GakQxGVwSe6kbJueA/GFeLun2R3O7t5gnb0/C/cXcsyESvraS92iOmwWqHc6WtR5E0ZyLN1gkT1qvCopWibNhHp2WpH0UiyL7+EIus4ePpsx1daH2IL4UBn/CZTsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joxogbJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joxogbJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3EB1F000E9;
	Wed, 20 May 2026 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307221;
	bh=VXHQc7Ph0tFNwnHzMY73U4whG7s9KlSqgZzYms9NpgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=joxogbJpv7w8i1lNPNU3aCKWhQkFzZ69ivftMYZQxQfsZ5IZFo+9jvsuA6I4PFL3b
	 BHNZ9FzJ/6QZC3XDQMqlE6iRpXjY7bzPIJCNmTIBZkc4JJfOsDeEGEFh6xlfZbQPIP
	 l1TBanYy8HFxggHnHA7WSWR7qkfQrfo6h+iki5DvVkU2mFN3/ilYMQwV6gYIwCh/j1
	 PrEJWSS4ucBUVnK4tEbhSh6fY7JVRsVVs6iE5aWBX0/KC4rTNbmxIPQXRSxrTBCrxX
	 3fAxm0EEqRwAGdFavHWD2X17Ve2eyOj/BaNfiG3WV8hRtpfOLyymqeQ7AO5lfTIUJo
	 CXd0kYCX8brjw==
Date: Wed, 20 May 2026 17:00:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, 9erthalion6@gmail.com,
	adrian.hunter@intel.com, alex@ghiti.fr,
	alexandre.chartre@oracle.com, andrii@kernel.org,
	ankur.a.arora@oracle.com, aou@eecs.berkeley.edu,
	bpf@vger.kernel.org, collin.funk1@gmail.com, costa.shul@redhat.com,
	daniel@iogearbox.net, dapeng1.mi@linux.intel.com, dsterba@suse.com,
	eddyz87@gmail.com, howardchu95@gmail.com, james.clark@linaro.org,
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev,
	memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com,
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org,
	pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me,
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com,
	tglozar@redhat.com, thomas.falcon@intel.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v7 00/14] perf build: Reduce build time by nearly half
Message-ID: <ag4S0uVCP-yK8Zoq@x1>
References: <20260518044740.2526802-1-irogers@google.com>
 <20260518154638.2798789-1-irogers@google.com>
 <agyrebq2hdayDIyg@google.com>
 <agyw0IoPccrjYq2q@x1>
 <CAP-5=fVX+_oYzuanMwoia6PqtoRrK_K0zO1A+qG8Xp+fueETjw@mail.gmail.com>
 <agz91_n-ohXQxQqv@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agz91_n-ohXQxQqv@google.com>

On Tue, May 19, 2026 at 05:18:31PM -0700, Namhyung Kim wrote:
> On Tue, May 19, 2026 at 11:53:08AM -0700, Ian Rogers wrote:
> > On Tue, May 19, 2026 at 11:49 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, May 19, 2026 at 11:27:05AM -0700, Namhyung Kim wrote:
> > > > On Mon, May 18, 2026 at 08:46:24AM -0700, Ian Rogers wrote:
> > > > > This patch series refactors Kbuild internals, BPF skeleton generation,
> > > > > Python AST pre-computation, and foundational tooling dependencies across
> > > > > the perf tool build system. By eliminating umbrella target synchronization
> > > > > barriers, decoupling static library prerequisites, parallelizing single-core
> > > > > script generators, and eradicating redundant feature checks, this series
> > > > > unlocks absolute theoretical peak multi-core concurrency during Kbuild startup.
> > > > >
> > > > > On a 28-core build workstation (make -j28 all from scratch), clean build
> > > > > latency improves by over 44%:
> > > > >
> > > > >   Before:
> > > > >     real    0m29.006s
> > > > >     user    2m46.019s
> > > > >     sys     0m30.610s
> > > > >
> > > > >   After:
> > > > >     real    0m16.091s
> > > > >     user    2m40.135s
> > > > >     sys     0m25.740s
> > > > >
> > > > > Saving 12.9 full seconds time per clean build. Furthermore, nothing to
> > > > > build incremental builds are improved by nearly 7x:
> > > > >
> > > > >   Before:
> > > > >     real    0m11.528s
> > > > >     user    0m9.633s
> > > > >     sys     0m6.965s
> > > > >
> > > > >   After:
> > > > >     real    0m1.717s
> > > > >     user    0m1.682s
> > > > >     sys     0m0.960s
> > > > >
> > > > > Summary of Patches:
> > > > >
> > > > > 1: Fast-Path Feature Detection
> > > > >   - Refactors test-clang-bpf-co-re.bin and test-bpftool-skeletons.bin feature
> > > > >     checks to group shell pipelines within curly braces and redirect both stdout
> > > > >     and stderr to .make.output before touching $@ purely upon success
> > > > >     (> $(@:.bin=.make.output) 2>&1 && touch $@). Grouping the pipeline ({ cmd1 | cmd2; })
> > > > >     ensures that compiler stderr is successfully captured in .make.output rather
> > > > >     than escaping to the parent shell. This perfectly matches standard Kbuild
> > > > >     feature check conventions and ensures the target files are touched on disk
> > > > >     purely upon success, allowing Kbuild to cache positive detections and avoid
> > > > >     continuous sub-make re-evaluations during incremental builds. Adds
> > > > >     test-bpftool-skeletons.bin to the clean FILES list and explicit source
> > > > >     prerequisite test-clang-bpf-co-re.c.
> > > >
> > > > I think patch 1 can be separated and needs Ack/Review from BPF folks.
> > > >
> > > > >
> > > > > 2-4: Flattening Umbrella Prepare Barriers
> > > > >   - builtin-trace embedded inclusions and pmu-events generation are completely
> > > > >     decoupled from the sequential "prepare" umbrella target, eliminating Make
> > > > >     AST double-parsing overhead and unchoking parallel compilation barriers.
> > > > >
> > > > > 5-7: Decoupling & Pre-generating BPF Skeletons
> > > > >   - BPF skeleton rules are extracted out of Makefile.perf into bpf_skel.mak.
> > > > >   - Decouples bpftool bootstrap from top-level static libbpf dependencies,
> > > > >     attaching bpf-skel-prepare directly to the umbrella prepare target. This
> > > > >     allows Make to pre-compile bpftool and dump vmlinux.h in the background at
> > > > >     build startup, removing the 7-second serialization bottleneck before BPF
> > > > >     object compilation.
> > > > >   - Ensures benchmark skeleton intermediate .bpf.o files are cleanly removed
> > > > >     during make clean, and adds bpf-skel-prepare to .PHONY.
> > > > >
> > > > > 8-9: Foundational Linkage Optimization
> > > > >   - Moves static libsymbol library prerequisites out of the prepare step.
> > > > >   - Eliminates redundant libbpf sub-make feature checks during static builds.
> > > > >
> > > > > 10-11: jevents.py Concurrency & Deduplication
> > > > >   - Splits the massive 2.8 MB big_c_string literal out of pmu-events.c into a
> > > > >     dedicated pmu-events-string.c compilation unit. This slices C compilation
> > > > >     latency in half by compiling string and struct tables simultaneously across
> > > > >     separate CPU cores while preserving zero dynamic ELF relocations. Adds
> > > > >     pmu-events-string.c to .gitignore, declares extern const char big_c_string[];
> > > > >     locally inside output_string_file and output_file when split to prevent linkage
> > > > >     conflicts with empty-pmu-events.c, defers file closures to ensure identical
> > > > >     timestamps, and uses canonical Make 4.0 @: dependency chaining.
> > > > >   - Pre-populates jevents.py JSON ASTs and metric formulas in parallel across
> > > > >     all available CPU cores using ProcessPoolExecutor (accelerating Python
> > > > >     execution by 11x, from 3.3s down to ~290ms). Moves _init_worker to top-level
> > > > >     scope to ensure clean pickling under spawn multiprocessing start methods.
> > > > >
> > > > > 12: Out-of-Tree Incremental Rebuild Fix
> > > > >   - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to prevent
> > > > >     Make from continuously re-executing script installation rules on already
> > > > >     built out-of-tree builds.
> > > > >
> > > > > 13-14: AST Parsing Optimization & Shell Fork Eradication
> > > > >   - Converts ZENS, ARMS, and INTELS in pmu-events/Build from recursive assignment
> > > > >     (=) to simply expanded assignment (:=) and replaces model_name/vendor_name
> > > > >     with pure GNU Make string functions. This guarantees Make executes directory
> > > > >     probing shell forks exactly once during AST parsing and evaluates path macros
> > > > >     purely in memory, completely eradicating over 7,800 redundant sub-processes
> > > > >     during out-of-tree build evaluation.
> > > > >   - Converts llvm-config shell queries in Makefile.config from recursive assignment
> > > > >     (=) to simply expanded assignment (:=). This eliminates ~185 redundant sub-processes
> > > > >     that were previously executed across object compilation dependency checks.
> > > > >
> > > > > Changes since v6:
> > > > >   - Rebase/resend as last series failed to apply by Sashiko.
> > > > >
> > > > > Ian Rogers (14):
> > > > >   tools build: Fix feature checks to touch target files on success
> > > > >   perf trace beauty: Make beauty generated C code standalone .o files
> > > > >   perf build: Decouple pmu-events from prepare umbrella target
> > > > >   perf build: Remove empty archheaders target
> > > > >   perf build: Move BPF skeleton generation out of Makefile.perf
> > > > >   perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
> > > > >   perf build: Pre-generate BPF skeleton tooling during umbrella prepare
> > > > >     phase
> > > > >   perf build: Move libsymbol dependency out of prepare step
> > > > >   perf build: Remove redundant libbpf feature check for static builds
> > > > >   perf pmu-events: Split big_c_string storage into standalone
> > > > >     compilation unit
> > > > >   perf pmu-events: Parallelize JSON and metric pre-computation in
> > > > >     jevents.py
> > > > >   perf build: Prefix SCRIPTS with output directory to fix continuous
> > > > >     rebuilds
> > > > >   perf pmu-events: Convert recursive shell assignments and macros to
> > > > >     Make built-ins
> > > > >   perf build: Convert llvm-config shell queries to simply expanded
> > > > >     variables
> > > >
> > > > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > > So this is for 2-14? I haven't checked if 1 can be left out of an
> > > initial merge by me.
> > 
> > I believe you are correct. Patch 1 is completely independent because
> > it is the only change in tools/build; everything else is in
> > tools/perf.
> 
> Actually it goes to the patch 1 as well.  But we can take 2-14 in the
> perf tree first.

Ok, lets go with 2-14, we can look at 1 later.

- Arnaldo

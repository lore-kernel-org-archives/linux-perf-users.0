Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4D3A6F12
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578600; cv=none; b=CuM2HSwLRDMgEA44pw7qzzNhW7h797wO0YDLJTz4XD7Su4cKzR1kR1hizeX+G5gEp+Xic2pJ1RRCB3bzO7XQWwTUREWA/YoeYCUTLjZWBQN8c3DrIkeaV+NYFLpFBt+doRQTrL+D+aN06ERsJc8+nz7jY4z7j9z+zDuWoQ8yDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578600; c=relaxed/simple;
	bh=tm0NVwwbouUOW/ov7c8L4ich1p+zJor/SPJKdx8NRLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=FSCApOkGn+omQWcZlKYXbUgWwBotVY8f60iPG7ojNTgdFy5nz/H1YWDXsA6NHPlCJqB0cEM76lT1tPbDOEMOOUW/iqnGw2cXbed0u6rPEQaC0tnCg9GIEbxeTcRIj0I3jK/UH+OY7vga4x3xUdXdAFyMpgWEnU2SdaPj/O+q0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gT3Ayfnt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gT3Ayfnt"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48909558b3aso54671475e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778578597; x=1779183397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4TuJODOI+QkiUVtzRDrKwuK4f3bx4sDE+Z5ULvd9uEM=;
        b=gT3Ayfnt9c90ULVLYRvtPOvQl6BYM64/KPpNKLrkx/nTVsWttxhNwi/ryJbcEONbTs
         i79d6J8EMnICeYSK1FrQNpK3dBTDj1k5s/aIRuSiKZp6QTEQr9TAUHv4pxDuaLG+oDpt
         bBXshMDBNllkdU4wTf+5RFECGMk5lbFJT5P2ZP6EKWLZiCZ48hhJoBF/+oWsilZPhD+X
         IzX9sBwIG/gfitV6iMZwcaiZIIZEP2BfNsRkVO0BPfVmNhokXc+mKYXO03Mptg1r/f6R
         B9FEoQ4MdbqvgKEaw7hgKaT79SGrVZoco33ONgmwKPGN+sCIe8dQcK9uTutfvVr7PJge
         GesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578597; x=1779183397;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TuJODOI+QkiUVtzRDrKwuK4f3bx4sDE+Z5ULvd9uEM=;
        b=koPzOPxiC/tL2PgM65pbrGMTFaf8lU8PYJAI5Wl1sM45Kfvd2Zf61RGHZw6qEN3KLZ
         AgCgsryh/XFLyEnPB59fexYMZ4Esn07N52XvXRC5C3E4FhpWy0/3jRRadgYc1tbScyu0
         VVb1yI0mo9dpA0qEzPsuB1qnwodJN60zIY/TfA6Lf3mhJEhCRdRpQGmXl69jS5uUfv/8
         jAONpp1K5JEGnjct/CFAELuWOj7gqOUDoI/uqAUKOGsEBVEF6bGd9b8n3BXJiFIk+CNl
         y1iUf/YyEhzt2PiGrR+F9TA+RcXts6qFHoKgD+muc3pugippAIjOhsI+FRSHj1MW6vTM
         xG/w==
X-Forwarded-Encrypted: i=1; AFNElJ+WmFmrK9BVzJpQZm73gPvg9ShQt7QcAy3A+7N7gPUw0wk2dALwG9HxxQsYVSxC8daTxL5hep/vdJBtmaQBlUoq@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQhWujNxyEHCSa5S3huMeQ1lF5rl05w2hAfAooVU0QLOcQVhZ
	nVF0Ql4EXHVBGsqnditI93ItuNAW3Q4Y6rSzG4/WoIWBUxr56Kg098vUAQ40rNBfx3g=
X-Gm-Gg: Acq92OHxDrv4QhmQJYbwrFLDtUBgijOPwcCshX2zAiNQbWzRVoQ/J7AxgVZD98KmaAf
	xw9o6Yg4mwO7QktoUh36ZjCr4gtPkoPFkEVK4SQq4/AOsMPR72lGzOSV+szE2jypwsjZ9y862lp
	TZBmUcTP1zK1AcspNejtfQPC35h/B/kRL5wuldvgreycI38CdqToh6zGdK/mzJ0ggETz5FHYqf6
	tQjht03kdlp9n1NGJsE/0DKHkcZFui4P0DYT3road3cjuEJlItW/T3adZbLwtiHJGo3Plu66bo1
	EI1dtuijR4fXRZkfriDfGi6kME8EKXcN3HyyJVqk3yFAXuSxaKT980+8Agf0Dh44pw8JVY0Sruj
	Dyj44VfFSEnwal3HNY7TNCMInCr0KvP0BO8nUReeWG1SNt01KRu/IO4hEdEV/uWZ6O8M0pOHIMq
	kgBflLgHNJ68w7iqUi7b79TYmiPqzhsGnKNLzWOdk=
X-Received: by 2002:a05:600c:c494:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-48e51f32c35mr435745135e9.13.1778578596689;
        Tue, 12 May 2026 02:36:36 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e9052c9fesm68487945e9.1.2026.05.12.02.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:36:36 -0700 (PDT)
Message-ID: <3c42ab2a-7698-4459-b1e1-9441a0bf4d9b@linaro.org>
Date: Tue, 12 May 2026 10:36:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/14] perf build: Reduce build time by one third
To: Ian Rogers <irogers@google.com>
References: <20260512053539.3410189-1-irogers@google.com>
Content-Language: en-US
Cc: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
 Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>,
 Dmitrii Dolgov <9erthalion6@gmail.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Yuzhuo Jing <yuzhuo@google.com>, Leo Yan <leo.yan@arm.com>,
 Ankur Arora <ankur.a.arora@oracle.com>, Markus Mayer <mmayer@broadcom.com>,
 Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Thomas Falcon <thomas.falcon@intel.com>,
 Ricky Ringler <ricky.ringler@proton.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/05/2026 6:35 am, Ian Rogers wrote:
> This patch series refactors many aspects of the perf build aiming to
> better encapsulate BPF code generation, remove serial build code and
> gain build parallelism. The prepare step that blocks the parallel
> build is reduced to a core 6 smaller dependencies. BPF skeletons are
> made regular dependencies on the targets that use them. Feature tests
> and dependencies are reorgnized. The jevents.py script processes json
> files in parallel and allows the big_c_string to be compiled
> separately.
> 
> On a 28-core build workstation (make -j28 all from scratch), clean build
> latency improves by over 36%:
> 
>    Before:
>      real    0m29.006s
>      user    2m46.019s
>      sys     0m30.610s
> 
>    After:
>      real    0m18.498s
>      user    2m32.922s
>      sys     0m27.623s
> 

I also get similar numbers, even when using ccache:

Before:

   real    0m29.584s
   user    0m48.993s
   sys     0m20.466s

After:

   real    0m18.322s
   user    0m49.995s
   sys     0m17.077s

Tested-by: James Clark <james.clark@linaro.org>

> Summary of Patches:
> 
> 1: bpftool Bootstrap Optimization
>    - Exempts bpftool bootstrap from non-essential feature tests (LLVM, libbfd,
>      libcap), saving 1.1s of sub-make fork overhead during Kbuild startup.
> 
> 2-4: Flattening Umbrella Prepare Barriers
>    - builtin-trace embedded inclusions and pmu-events generation are completely
>      decoupled from the sequential "prepare" umbrella target, eliminating Make
>      AST double-parsing overhead and unchoking parallel compilation barriers.
> 
> 5-8: Decoupling & Pre-generating BPF Skeletons
>    - BPF skeleton rules are extracted out of Makefile.perf into bpf_skel.mak.
>    - Decouples bpftool bootstrap from top-level static libbpf dependencies,
>      attaching bpf-skel-prepare directly to the umbrella prepare target. This
>      allows Make to pre-compile bpftool and dump vmlinux.h in the background at
>      build startup, removing the 7-second serialization bottleneck before BPF
>      object compilation.
> 
> 9-11: Foundational Linkage & Fast-Path Feature Detection
>    - Eliminates redundant libbpf sub-make feature checks during static builds.
>    - Integrates libdebuginfod directly into test-all.c, allowing Make to skip
>      individual feature check sub-make forks during AST parsing on fully
>      configured workstations.
> 
> 12-13: jevents.py Concurrency & Deduplication
>    - Splits the massive 2.8 MB big_c_string literal out of pmu-events.c into a
>      dedicated pmu-events-string.c compilation unit. This slices C compilation
>      latency in half by compiling string and struct tables simultaneously across
>      separate CPU cores while preserving zero dynamic ELF relocations.
>    - Pre-populates jevents.py JSON ASTs and metric formulas in parallel across
>      all available CPU cores using ProcessPoolExecutor (accelerating Python
>      execution by 11x, from 3.3s down to ~290ms).
> 
> 14: Out-of-Tree Incremental Rebuild Fix
>    - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to prevent
>      Make from continuously re-executing script installation rules on already
>      built out-of-tree builds.
> 
> Ian Rogers (14):
>    bpftool build: Restrict feature tests during bootstrap compilation
>    perf trace beauty: Make beauty generated C code standalone .o files
>    perf build: Decouple pmu-events from prepare umbrella target
>    perf build: Remove empty archheaders target
>    perf build: Move BPF skeleton generation out of Makefile.perf
>    perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
>    perf build: Move static libbpf dependency out of prepare step
>    perf build: Pre-generate BPF skeletons during umbrella prepare phase
>    perf build: Move libsymbol dependency out of prepare step
>    perf build: Remove redundant libbpf feature check for static builds
>    tools build: Integrate libdebuginfod into test-all fast path
>    perf pmu-events: Split big_c_string storage into standalone
>      compilation unit
>    perf pmu-events: Parallelize JSON and metric pre-computation in
>      jevents.py
>    perf build: Prefix SCRIPTS with output directory to fix continuous
>      rebuilds
> 
>   tools/bpf/bpftool/Makefile                    |   5 +
>   tools/build/Makefile.feature                  |   6 +-
>   tools/build/feature/Makefile                  |   2 +-
>   tools/build/feature/test-all.c                |   5 +
>   tools/perf/Build                              |   2 +
>   tools/perf/Makefile.config                    |   6 +-
>   tools/perf/Makefile.perf                      | 427 +-----------------
>   tools/perf/bench/Build                        |   6 +
>   .../bpf_skel/bench_uprobe.bpf.c               |   0
>   tools/perf/bench/uprobe.c                     |   2 +-
>   tools/perf/bpf_skel.mak                       | 110 +++++
>   tools/perf/builtin-trace.c                    |  30 +-
>   tools/perf/pmu-events/Build                   |  15 +-
>   tools/perf/pmu-events/jevents.py              |  56 ++-
>   tools/perf/trace/beauty/Build                 | 280 ++++++++++++
>   tools/perf/trace/beauty/arch_errno_names.c    |   2 +
>   tools/perf/trace/beauty/arch_errno_names.sh   |   2 +-
>   tools/perf/trace/beauty/beauty.h              |  60 +++
>   tools/perf/trace/beauty/eventfd.c             |   6 +-
>   tools/perf/trace/beauty/fsconfig.c            |   5 +
>   tools/perf/trace/beauty/futex_op.c            |   6 +-
>   tools/perf/trace/beauty/futex_val3.c          |   6 +-
>   tools/perf/trace/beauty/mmap.c                |  24 +-
>   tools/perf/trace/beauty/mode_t.c              |   6 +-
>   tools/perf/trace/beauty/msg_flags.c           |   8 +-
>   tools/perf/trace/beauty/open_flags.c          |   1 +
>   tools/perf/trace/beauty/perf_event_open.c     |  22 +-
>   tools/perf/trace/beauty/pid.c                 |   5 +-
>   tools/perf/trace/beauty/sched_policy.c        |   8 +-
>   tools/perf/trace/beauty/seccomp.c             |  12 +-
>   tools/perf/trace/beauty/signum.c              |   6 +-
>   tools/perf/trace/beauty/socket_type.c         |   6 +-
>   .../perf/{util => trace/beauty}/syscalltbl.c  |   0
>   .../perf/{util => trace/beauty}/syscalltbl.h  |   0
>   tools/perf/trace/beauty/tracepoints/Build     |  22 +
>   tools/perf/trace/beauty/waitid_options.c      |   8 +-
>   tools/perf/util/Build                         |  17 +-
>   tools/perf/util/bpf-trace-summary.c           |   2 +-
>   tools/perf/util/env.c                         |   4 +-
>   tools/perf/util/env.h                         |   1 +
>   40 files changed, 700 insertions(+), 491 deletions(-)
>   rename tools/perf/{util => bench}/bpf_skel/bench_uprobe.bpf.c (100%)
>   create mode 100644 tools/perf/bpf_skel.mak
>   create mode 100644 tools/perf/trace/beauty/fsconfig.c
>   rename tools/perf/{util => trace/beauty}/syscalltbl.c (100%)
>   rename tools/perf/{util => trace/beauty}/syscalltbl.h (100%)
> 


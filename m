Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A230F957
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887942; cv=pass; b=aNLNpt6JzJlm1MBvujewP5kT0p8oUK6YXWJNF286m7SIPMyDDVYOob9gq4M7bTE1GyagVYupGlPztfz70UDBife2P106Lh1gICUXOV1lyc55m7tefZXALNBvjQAqYB78jcpOLINUg8EXVWoGhACiWrmMVhvcTyvVa094DQ6FP7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887942; c=relaxed/simple;
	bh=rlnibuafkxBJQpUaWKsPbz0JEUKLXyVNRXQdiOu0Byg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6rJEtpDftF1KLC2wgwb5oiZlLXMqUAg8wsy6BLUUIo+2P27QU+saWctSOV3g1SzPHdYuPwix3lc0XMRv6+RIqN5+ESqWH2rbVVj4DrCbTwt84q1QYjvt+jWJAyesNi79Q/csWw9JHVttkSvxWIG47KYHu+s8KaBiSNO8MDaKYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9pbPRme; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9pbPRme"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so625ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 16:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778887938; cv=none;
        d=google.com; s=arc-20240605;
        b=edyHJ5ANHKRRjOH7Jq+7zXyP/TTOIsPRbCVTTGxocL2MhRlghCQOm1xDcsw+Uajo6k
         EFOkY2+2MyfLK3j07wvA863mI5624A1q8ZecN8dDohhc8IYNHMyk8QwHqndeuoK2sWUG
         6hT+u+67LXrxviLNdq1AT9ZpIRu1+PSBIavX4diiC5P6LZbdL4FF1owOUvJvVmXlAr2q
         +YDY/l39h+pMtaBcRmZSQnMXDXGPpqYwlyu2aeLJNheXthEfO41OohyJzISVebn+IG/a
         Jes12jrher0vxTH95DY+Rdt8RRY9EJjdovo2i9YiSLTF/8H8ValUQCSDZM1kXtiB6lL7
         /QNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=taVpDGO8357JvuXO5HGCBQyhKg1VCpTmNQkkufou/MU=;
        fh=RMQKk4q5INrJeVrsLO3TdCCvvPGzBw5hpXs9IUWknUw=;
        b=dywlXg6BjEQQuCmxdvKtILihlmOf/Vm2Os2z9PMhGyNLDG+z5gZKdnRaM+2Qxi4C3T
         n+dQjzwc1ydeszylHIjhDVY1jGlTu/78/slMWSGnHQ5w7FraTRuD1FPppKgbpgmkYFw9
         mai2DYvFsGpetRToDOYWPHNR7jJtJvMhW3gTL2psnvRpGmLxvx2E/qaKkWODhmwDHWXq
         8UI90LLElmJt+2loo5Gsog593f/lt2dUQTpn4RX3S8S8DKIJ+kjdCpZkAwruG57vgvqv
         e10gNsKAkct84N5wJctWXPs5VEkRSQhqNzpKTJsBQrhNe6WMJrgO1++bCF9QhFqF+Knm
         3trQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778887938; x=1779492738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taVpDGO8357JvuXO5HGCBQyhKg1VCpTmNQkkufou/MU=;
        b=v9pbPRmeQcrqTOtK7jx5UJMYjyq9DhuR4fFBAt+XGC3LHdtQt/RhhW+bomJzXCy/4D
         GQFTu9OrF8aw8mPC1q3apHd/B3IRs0Y1Za60y+U3S4sO4DfGhg+Gpmuy6xqykkmb+o50
         OHFQkPdozWiRqLlZE4FfQwdJxp4jxAAhW09dKsSYr874NvSwqUVC8Y8K9xbMMzlYMCFv
         VHQqIClm495vNNoxf4ZGGmTXUxgr/R7hcr1nGICqmwmVHRe7hsrHZW1KlyAx+nG0fS7n
         NR7wyd3vo5BYv2bvwb2pml3RM6SkcKjQOrvMXAolay/Njs/YZbbNMblIgQR8+YXGGSzy
         IIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778887938; x=1779492738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=taVpDGO8357JvuXO5HGCBQyhKg1VCpTmNQkkufou/MU=;
        b=cwVdbNyIPazjtyMe8T4FnNW3DGJlwJjVmDgpaiSgJkR3An3BbBls68BrjHgI1lFnpS
         tl91y+1iZg9o7DU7Z6jeKHAXTY5ivYnQFIne7QEVPdqAReNYShZOczR6O10iVmQgMM5U
         zDQ+G3c1Mm0vG2DtqeKG7DpUFMhPuqIkjVe9xIGSn9oqsWuBkKAwizPsFKlo/Q2HB5iw
         HzLdrVStegx/C9CE72nfqwVuwxha9oauhfdXNpIahNpny0kuup6GPgjURJZ7fRbZrh09
         OUMNz3sU/RhTeohJMx5q+I5Jj2qnj/8KZzr2SsmlepCPkC1f6FoHM3Rq8fqnV0eyQovS
         oQxw==
X-Forwarded-Encrypted: i=1; AFNElJ9wey9UsyPoeS78cd/u8ubZi9OrA/kCohTTDu4y6leUMC1uZwoQQopX60xnWXWle7JeCLYllT//PMJVmIbyHLlO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5N6FHb2wpIsS2U+QHWqXQy9rWngjrf8ln92cGaxZ8yUBOLBd9
	9onWH5lkAPtRA+a5wv4E8j/eBv7kzC1dB5awPydGmREGgTWIxRD8KOhp5f6k3PFmiREDBXqfP7M
	ZmbRWQeAocAQ5+zlpYjF+UEogPlwNKe38UtsRqevw
X-Gm-Gg: Acq92OHfdBzmbHFEIhvd6mAnUr+VRypRohDqah5fU5DcjHI30MrFookeriRttmXEhOh
	OBaY8UWKg75ydafMcZ+BAPBXIdiym/3vNIt1J/MKzTcb/mjd/4FWkF/BuEHQKTp4StFJloGHE2X
	P2bGO3YZAdcQOV8iawOVLcQbeNcS91sg1/nx8f9kT9L1tlVt/rqBmOTWcn/feHvMEt/fKJ/4GGS
	zAHuI+6MG2eGqiHhdserGyYkcasrbiWDztYpg1Sp+3P9UiAmg7I8Xy7u97bTBV/AM6Jmovsc5bt
	X8blAzng3Ni4yasRL3I=
X-Received: by 2002:a17:902:d508:b0:2bd:6dad:3dfd with SMTP id
 d9443c01a7336-2bda5303d91mr550265ad.27.1778887937703; Fri, 15 May 2026
 16:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com> <20260515193314.1593560-1-irogers@google.com>
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 May 2026 16:32:06 -0700
X-Gm-Features: AVHnY4KE3oqNgl6jQ5JuPZyyBywUGPxeDuZ_S4oiCXwVhXAzwZDmbaYrTj6BSag
Message-ID: <CAP-5=fWJ-AQ+dPfocop_0ok23g3p4m2q87kfF4pvLOu9dBjNAg@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] perf build: Reduce build time by nearly half
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:33=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> This patch series refactors Kbuild internals, BPF skeleton generation,
> Python AST pre-computation, and foundational tooling dependencies across
> the perf tool build system. By eliminating umbrella target synchronizatio=
n
> barriers, decoupling static library prerequisites, parallelizing single-c=
ore
> script generators, and eradicating redundant feature checks, this series
> unlocks greater concurrency during Kbuild startup.
>
> On a 28-core build workstation (make -j28 all from scratch), clean build
> latency improves by over 44%:
>
>   Before:
>     real    0m29.006s
>     user    2m46.019s
>     sys     0m30.610s
>
>   After:
>     real    0m16.091s
>     user    2m40.135s
>     sys     0m25.740s
>
> Saving 12.9 full seconds time per clean build. Furthermore, nothing to
> build incremental builds are improved by nearly 7x:
>
>   Before:
>     real    0m11.528s
>     user    0m9.633s
>     sys     0m6.965s
>
>   After:
>     real    0m1.717s
>     user    0m1.682s
>     sys     0m0.960s
>
> Summary of Patches:
>
> 1: Fast-Path Feature Detection
>   - Refactors test-clang-bpf-co-re.bin and test-bpftool-skeletons.bin fea=
ture
>     checks to group shell pipelines within curly braces and redirect both=
 stdout
>     and stderr to .make.output before touching $@ purely upon success
>     (> $(@:.bin=3D.make.output) 2>&1 && touch $@). Grouping the pipeline =
({ cmd1 | cmd2; })
>     ensures that compiler stderr is successfully captured in .make.output=
 rather
>     than escaping to the parent shell. This perfectly matches standard Kb=
uild
>     feature check conventions and ensures the target files are touched on=
 disk
>     purely upon success, allowing Kbuild to cache positive detections and=
 avoid
>     continuous sub-make re-evaluations during incremental builds. Adds
>     test-bpftool-skeletons.bin to the clean FILES list and explicit sourc=
e
>     prerequisite test-clang-bpf-co-re.c.
>
> 2-4: Flattening Umbrella Prepare Barriers
>   - builtin-trace embedded inclusions and pmu-events generation are compl=
etely
>     decoupled from the sequential "prepare" umbrella target, eliminating =
Make
>     AST double-parsing overhead and unchoking parallel compilation barrie=
rs.
>
> 5-7: Decoupling & Pre-generating BPF Skeletons
>   - BPF skeleton rules are extracted out of Makefile.perf into bpf_skel.m=
ak.
>   - Decouples bpftool bootstrap from top-level static libbpf dependencies=
,
>     attaching bpf-skel-prepare directly to the umbrella prepare target. T=
his
>     allows Make to pre-compile bpftool and dump vmlinux.h in the backgrou=
nd at
>     build startup, removing the 7-second serialization bottleneck before =
BPF
>     object compilation.
>   - Ensures benchmark skeleton intermediate .bpf.o files are cleanly remo=
ved
>     during make clean, and adds bpf-skel-prepare to .PHONY.
>
> 8-9: Foundational Linkage Optimization
>   - Moves static libsymbol library prerequisites out of the prepare step.
>   - Eliminates redundant libbpf sub-make feature checks during static bui=
lds.
>
> 10-11: jevents.py Concurrency & Deduplication
>   - Splits the massive 2.8 MB big_c_string literal out of pmu-events.c in=
to a
>     dedicated pmu-events-string.c compilation unit. This slices C compila=
tion
>     latency in half by compiling string and struct tables simultaneously =
across
>     separate CPU cores while preserving zero dynamic ELF relocations. Add=
s
>     pmu-events-string.c to .gitignore, declares extern const char big_c_s=
tring[];
>     locally inside output_string_file and output_file when split to preve=
nt linkage
>     conflicts with empty-pmu-events.c, defers file closures to ensure ide=
ntical
>     timestamps, and uses canonical Make 4.0 @: dependency chaining.
>   - Pre-populates jevents.py JSON ASTs and metric formulas in parallel ac=
ross
>     all available CPU cores using ProcessPoolExecutor (accelerating Pytho=
n
>     execution by 11x, from 3.3s down to ~290ms). Moves _init_worker to to=
p-level
>     scope to ensure clean pickling under spawn multiprocessing start meth=
ods.
>
> 12: Out-of-Tree Incremental Rebuild Fix
>   - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to preven=
t
>     Make from continuously re-executing script installation rules on alre=
ady
>     built out-of-tree builds.
>
> 13-14: AST Parsing Optimization & Shell Fork Eradication
>   - Converts ZENS, ARMS, and INTELS in pmu-events/Build from recursive as=
signment
>     (=3D) to simply expanded assignment (:=3D) and replaces model_name/ve=
ndor_name
>     with pure GNU Make string functions. This guarantees Make executes di=
rectory
>     probing shell forks exactly once during AST parsing and evaluates pat=
h macros
>     purely in memory, completely eradicating over 7,800 redundant sub-pro=
cesses
>     during out-of-tree build evaluation.
>   - Converts llvm-config shell queries in Makefile.config from recursive =
assignment
>     (=3D) to simply expanded assignment (:=3D). This eliminates ~185 redu=
ndant sub-processes
>     that were previously executed across object compilation dependency ch=
ecks.
>
> Changes since v4:
>   - tools build (Patch 1): Refactored test-bpftool-skeletons.bin and
>     test-clang-bpf-co-re.bin feature check recipes to group the shell pip=
eline
>     within curly braces ({ cmd1 | cmd2; }) so that compiler stderr is suc=
cessfully
>     captured in .make.output rather than escaping to the parent shell. Ad=
ded
>     test-bpftool-skeletons.bin to the clean FILES list in feature/Makefil=
e so
>     that make clean correctly purges the generated binary and prevents pe=
rmanent
>     feature cache poisoning.
>   - perf pmu-events (Patch 10): Reverted secondary target rule in pmu-eve=
nts/Build
>     back to the canonical Make 4.0 @: dependency chaining pattern to prev=
ent
>     concurrency race conditions during parallel compilation. Removed glob=
al
>     extern const char big_c_string[]; declaration from pmu-events.h and i=
nstead
>     emitted the extern declaration locally inside output_string_file and
>     output_file when split, preventing type and linkage conflicts with
>     empty-pmu-events.c when building with NO_JEVENTS=3D1.

Just to add that Sashiko on v5 has 2 medium and 1 low priority warning
across the 14 patches:
https://sashiko.dev/#/patchset/20260515193314.1593560-1-irogers%40google.co=
m
We could get it to 0 by removing the 3 patches it is warning about,
dropping the jevents.py changes would impact build time the most. I'd
prefer to land this series as it is.

Thanks,
Ian

> Ian Rogers (14):
>   tools build: Fix feature checks to touch target files on success
>   perf trace beauty: Make beauty generated C code standalone .o files
>   perf build: Decouple pmu-events from prepare umbrella target
>   perf build: Remove empty archheaders target
>   perf build: Move BPF skeleton generation out of Makefile.perf
>   perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
>   perf build: Pre-generate BPF skeleton tooling during umbrella prepare
>     phase
>   perf build: Move libsymbol dependency out of prepare step
>   perf build: Remove redundant libbpf feature check for static builds
>   perf pmu-events: Split big_c_string storage into standalone
>     compilation unit
>   perf pmu-events: Parallelize JSON and metric pre-computation in
>     jevents.py
>   perf build: Prefix SCRIPTS with output directory to fix continuous
>     rebuilds
>   perf pmu-events: Convert recursive shell assignments and macros to
>     Make built-ins
>   perf build: Convert llvm-config shell queries to simply expanded
>     variables
>
>  tools/build/feature/Makefile                  |  13 +-
>  tools/perf/.gitignore                         |   1 +
>  tools/perf/Build                              |   2 +
>  tools/perf/Makefile.config                    |  19 +-
>  tools/perf/Makefile.perf                      | 423 ++----------------
>  tools/perf/bench/Build                        |   6 +
>  .../bpf_skel/bench_uprobe.bpf.c               |   0
>  tools/perf/bench/uprobe.c                     |   2 +-
>  tools/perf/bpf_skel.mak                       | 109 +++++
>  tools/perf/builtin-trace.c                    |  32 +-
>  tools/perf/pmu-events/Build                   |  26 +-
>  tools/perf/pmu-events/jevents.py              |  58 ++-
>  tools/perf/trace/beauty/Build                 | 276 ++++++++++++
>  tools/perf/trace/beauty/arch_errno_names.c    |   2 +
>  tools/perf/trace/beauty/arch_errno_names.sh   |   2 +-
>  tools/perf/trace/beauty/beauty.h              |  60 +++
>  tools/perf/trace/beauty/eventfd.c             |   6 +-
>  tools/perf/trace/beauty/fsconfig.c            |   5 +
>  tools/perf/trace/beauty/futex_op.c            |   5 +-
>  tools/perf/trace/beauty/futex_val3.c          |   5 +-
>  tools/perf/trace/beauty/mmap.c                |  24 +-
>  tools/perf/trace/beauty/mode_t.c              |   6 +-
>  tools/perf/trace/beauty/msg_flags.c           |   8 +-
>  tools/perf/trace/beauty/open_flags.c          |   2 +
>  tools/perf/trace/beauty/perf_event_open.c     |  21 +-
>  tools/perf/trace/beauty/pid.c                 |   5 +-
>  tools/perf/trace/beauty/sched_policy.c        |   8 +-
>  tools/perf/trace/beauty/seccomp.c             |  12 +-
>  tools/perf/trace/beauty/signum.c              |   6 +-
>  tools/perf/trace/beauty/socket_type.c         |   6 +-
>  .../perf/{util =3D> trace/beauty}/syscalltbl.c  |   0
>  .../perf/{util =3D> trace/beauty}/syscalltbl.h  |   0
>  tools/perf/trace/beauty/tracepoints/Build     |  21 +
>  tools/perf/trace/beauty/waitid_options.c      |   8 +-
>  tools/perf/util/Build                         |  17 +-
>  tools/perf/util/bpf-trace-summary.c           |   2 +-
>  tools/perf/util/env.c                         |   4 -
>  tools/perf/util/env.h                         |   1 +
>  38 files changed, 687 insertions(+), 516 deletions(-)
>  rename tools/perf/{util =3D> bench}/bpf_skel/bench_uprobe.bpf.c (100%)
>  create mode 100644 tools/perf/bpf_skel.mak
>  create mode 100644 tools/perf/trace/beauty/fsconfig.c
>  rename tools/perf/{util =3D> trace/beauty}/syscalltbl.c (100%)
>  rename tools/perf/{util =3D> trace/beauty}/syscalltbl.h (100%)
>
> --
> 2.54.0.563.g4f69b47b94-goog
>

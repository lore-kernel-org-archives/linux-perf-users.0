Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4A3F660B
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862059; cv=pass; b=ZBF4fFONf9verKNod4IniTj3OFiav5EFxDjkjyJrT0udg/TTAGXz97vIyIIBQErRGhBHsx8s9nk7Kd5442jBSNtJ1774VfB0lR4GF9oQC8fMk3aAxgB906lIll8pom4v1GFEni8vzNjeiN8s/7Me04/Z+khUqQWdZ6pa7qmo0hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862059; c=relaxed/simple;
	bh=/EPmi14+1zjubWdFrLL2KPxrm79oW2N9XZy8UV7+Mz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeFRPQ6TaNw8IP2AxenKdNQtQeIGA1UK0jjpLQ4TcbFaq+A9N2d5Jl8IBCbhHaTfoce3oHbA7/9caTt/WQY8Rm10Ehbn9pxVKS7CxHdWK4Bf+c4xNS/bpgtvB2hd4pHe5fcU0ybVG7c8pIlgMQGzvHGLhWmf5vXyT3Cp95kTYSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DNaYMgc6; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNaYMgc6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b46da8c48eso1545ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 09:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778862056; cv=none;
        d=google.com; s=arc-20240605;
        b=DnqT33Uh2MqifzFj2o4Dmt4CXlc3TyEOJCo4hWi9bYlxDVhGUri4WJTQwe1qJzdmpb
         BZcFdJsMAAvG5vpJrG7yWwMe3ZSOrpZqeDz5HDCpA6EVhG3KC1aQsELz/D5nk91ofe3o
         Jy+x5ybpUfO0ghluc5xmZaDL/aI3UOcGeBLUK5RUCGAwPUtHn2LlH7Qf2rWX55eh7/JZ
         UTztsLxDDV+XhhE5UFkeh7DICO/OUC12uKAXbzoBaRIdx04vb7dintfWae8YF379mPY+
         gHlcV0eowkRY4ALGPA7kgIONMwKicPDuDNSWWISEvYiTPYo+HIrX/TQri8OGXb6pd1LJ
         S0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zhV09scwUdNYRokEFV6EToCs7XBqklXbgOQ8ThCs9Gs=;
        fh=29kESxxPC1agG0FTjQ6rtUgLFIB0hciKDQXhYFUf/ho=;
        b=BIQXS2n0SYOQaiHCUNAKlgdHCa1p4mHbY0UnEH5L7w/AjMYc8DEKTXiqteGK/X0iMc
         kVXk3QlRPpkv1HBqoq+ggxPv7zxh6xIFcls9X6azXLbXTvjYRtszRYPwK8qAX95WxO9G
         HzBknVeAfsWPD7ydPlCmB9W+JxSfVPp1mZuUVzzMnZLE7Xcuk7HrgEjbDFeNC3j2/ad6
         bW3I3/G4fODdpJ2HS+cWpAs08EqhvWyhC5gK2gxYplWGyarK4vG2nj4gc7JnNH6PdWth
         A1LxmH9Fq1/8UMkNrYEYzPWCgR84gWBCzJXP0mDOQqG3ApDnDtb5aasLbZS3YNkBMsjN
         xFwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778862056; x=1779466856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhV09scwUdNYRokEFV6EToCs7XBqklXbgOQ8ThCs9Gs=;
        b=DNaYMgc6L2qrunG5u9Gt5irSiSPpA3TtnLVVzcshxZMgof2TcgyA/i5TjGFgb2ccFO
         HJTlNimk4IYeWt5Hn89p6XT5TP0lJvRx2at8ap2F5kJUQRlJGTiNbVMckIaABppscFFS
         w1Xl2RHQrCkOTRJPUx7nKqVqkmugLRSmtivNIwK9oxlv+cD3Vsx4fV2N4oOpX4SN/3LI
         KC/QH+t48A47No8uyh9C/gy2TfJV5fF80KuWJ9g0x2um3gRD929ykGTdrh54vQ29Wfpo
         +CYhHnYdvABY8lP/vacEhnUEQeJktLknT3x3pG2SYzaRwxOQPeJ5RTbMFVDKQHjnDQ/f
         xokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778862056; x=1779466856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zhV09scwUdNYRokEFV6EToCs7XBqklXbgOQ8ThCs9Gs=;
        b=UwQf+EcxbSIE/xPCJ2ciNjnJNNVFXL1RopjxfrG+Rb3FG9Ju1oO+bPIrDsbwCsgQT2
         Z0jo2axT8o1RbDw0+F26hjR4IobU3J1rzvbI5Q0wTjO0IMy5VnwsnMSi+Kgkq0BhtiPk
         d8UFAPJtYTaULjV6P+S/gYl+9/UBBPI5nwFJ35a0JDl4dt/vLZAzlXXsY1y/pAgwCyzw
         cfu5c+aOHcsPoF9ZWVfIXqeJUpDTrTA71tl2L9RdZOAkcSlAlVUwOHx5ElGzZpK1QoCo
         eFJ/8ujmU2CgE7s9CP93BG4ybDAKJnWtL2Ap56zvKjBDzAO8LPeNAuTkxcD/kDUQQ15/
         z5bQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aNdz9etAxWOccngKjI4hh7ivCge7XRlSUEEVTqEWx+rV74iP0MGDIPDZTfKr+BJ9g5gcvED7WqULQ/YMvE6h5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdg3Fte9uBJLHP66pZ2Asi83SGIamUG6ZL+GbvwHous4+s0zty
	ObZ0Vmd3dv7x5Ch7nuxnVnW0X6jXTXGH/71ZVwN+jiX6mQJEvUbCRmD681+fOOGnrPptLj/QGMp
	gIJIxCZIfdO65KMhvoIs/he5Zr6N4YhhSVp+klKZO
X-Gm-Gg: Acq92OGTXT8CH+DuSxuCkLQO6wqRdttKG4C26DCVsjJOWfJIJQ6xFeUz053XZs8TdDO
	BR8GNPVGzzyQ5DdgD5dPoGGSi/1Xh0Gs6lG9ryyU2pN1i31J+vfye3yt0oxpz9UhSSx57rziZ4E
	FXEYOgG2gBik5zofD/dQzrtc2Skh3iHTLTMPFRkgVA/qfXrFXYzq+e/TpT3gl4umxvfwRNJhE+k
	pPwvlxb7fIt8aIBerUG4t/dJ24BU0qTMkNw6cvJBBnI/Yrsxh6icuogfmTThdBzbMO/qMnOhb1M
	a7pvmPHFRHoKBXH0FxM=
X-Received: by 2002:a17:903:4405:b0:2b4:6153:e541 with SMTP id
 d9443c01a7336-2bd84c82659mr2078635ad.3.1778862055942; Fri, 15 May 2026
 09:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
 <agZHYSFneOSIo8d5@google.com> <CAP-5=fUJFRcXFdpSy_X23NSU7zMp9SVZEqX+cEBsKP9YARGRvA@mail.gmail.com>
In-Reply-To: <CAP-5=fUJFRcXFdpSy_X23NSU7zMp9SVZEqX+cEBsKP9YARGRvA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 May 2026 09:20:44 -0700
X-Gm-Features: AVHnY4I75MWaI-wF_DmtAlpK-G0hZtvy0KMdBRIL5hge3WP6Q0c60dE8AiFc8EM
Message-ID: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] perf build: Reduce build time by nearly half
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, james.clark@linaro.org, 9erthalion6@gmail.com, 
	adrian.hunter@intel.com, alex@ghiti.fr, alexandre.chartre@oracle.com, 
	andrii@kernel.org, ankur.a.arora@oracle.com, aou@eecs.berkeley.edu, 
	bpf@vger.kernel.org, collin.funk1@gmail.com, costa.shul@redhat.com, 
	daniel@iogearbox.net, dapeng1.mi@linux.intel.com, dsterba@suse.com, 
	eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 3:23=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, May 14, 2026 at 3:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Thu, May 14, 2026 at 09:33:52AM -0700, Ian Rogers wrote:
> > > This patch series refactors Kbuild internals, BPF skeleton generation=
,
> > > Python AST pre-computation, and foundational tooling dependencies acr=
oss
> > > the perf tool build system. By eliminating umbrella target synchroniz=
ation
> > > barriers, decoupling static library prerequisites, parallelizing sing=
le-core
> > > script generators, and eradicating redundant feature checks, this ser=
ies
> > > unlocks absolute theoretical peak multi-core concurrency during Kbuil=
d startup.
> > >
> > > On a 28-core build workstation (make -j28 all from scratch), clean bu=
ild
> > > latency improves by over 49%:
> > >
> > >   Before:
> > >     real    0m29.006s
> > >     user    2m46.019s
> > >     sys     0m30.610s
> > >
> > >   After:
> > >     real    0m14.782s
> > >     user    2m39.527s
> > >     sys     0m22.938s
> > >
> > > Saving 14.2 full seconds time per clean build. Furthermore, nothing t=
o
> > > build incremental builds are improved by nearly 7x:
> > >
> > >   Before:
> > >     real    0m11.528s
> > >     user    0m9.633s
> > >     sys     0m6.965s
> > >
> > >   After:
> > >     real    0m1.729s
> > >     user    0m1.600s
> > >     sys     0m0.884s
> >
> > I've quickly checked it with latency profiling like below:
> >
> >   $ perf record --latency -- make -C tools/perf
> >
> >   $ perf report --latency -s comm
> >
> > The result looks like this.
> >
> > Before:
> >   #
> >   # Samples: 715K of event 'cpu/cycles/Pu'
> >   # Event count (approx.): 422452811481
> >   #
> >   #  Latency  Overhead  Command
> >   # ........  ........  ...............
> >   #
> >       45.28%    71.33%  cc1
> >       34.48%    16.92%  python3
> >       11.15%     2.21%  ld
> >        2.58%     1.51%  x86_64-linux-gn
> >        2.22%     0.99%  cc1plus
> >        0.71%     0.63%  sh
> >        0.69%     0.14%  llvm-config
> >        0.62%     0.56%  clang
> >        0.57%     4.40%  shellcheck
> >        0.44%     0.12%  perl
> >
> > After:
> >   #
> >   # Samples: 709K of event 'cpu/cycles/Pu'
> >   # Event count (approx.): 416654798495
> >   #
> >   #  Latency  Overhead  Command
> >   # ........  ........  ...............
> >   #
> >       64.99%    71.16%  cc1
> >       15.07%     1.81%  ld
> >        7.14%    17.59%  python3
> >        3.66%     1.53%  x86_64-linux-gn
> >        3.48%     0.75%  cc1plus
> >        1.11%     4.43%  shellcheck
> >        1.09%     0.74%  sh
> >        0.86%     0.59%  clang
> >        0.77%     0.12%  perl
> >        0.45%     0.23%  make
> >
> > Now I see a big drop in the latency from python.  And the llvm-config
> > doesn't show up in the top 10.
>
> This looks good. What is "x86_64-linux-gn", and since we default off
> LIBPERL, why does perl show up in the commands?
>
> Thanks,
> Ian

So, Sashiko reviews caught 2 regressions I introduced in v3. Given
that people seem reasonably happy I propose the following for v4 to
make the easy bits easy to land:

1) Drop patch 1 the bpftool change - hopefully someone on the BPF side
can pull in an equivalent change so that we're not testing libbfd for
disassembly support in a bootstrap version of bpftool that doesn't
support disassembly.
2) Drop patch 2 on feature testing debuginfod and avoiding repeated
tests we can come back to it.
3) Fix patch 3 "tools build: Fix test-clang-bpf-co-re.bin" to cover
the other missed case and to make the dependency tracking better. We
shouldn't have to re-feature test BPF features on every incremental
build.
4) Patch 4 to 8, keep everything seems happy.
5) Drop patch 9 "perf build: Move static libbpf dependency out of
prepare step." There's parallelism in the prepare step, so this likely
wasn't gaining much build time and Sashiko seems to find many
potential not really issues that suggest the gain isn't worth the
pain.
6) Patch 10 needs a fix for a variable dropped from v2.
7) Patch 11 to 12, keep everything seems happy.
8) Patch 13, the header file declaring the variable seems to have gone
AWOL. Needs a fix.
9) Patch 14, Sashiko is warning "Does this loop overwrite standard
events from earlier architectures?" which would be a worry if (1) we
cared much about building for >1 architecture, or (2) more than just
arm64 were using the architecture standard files. I think we can
address this problem later.
10) Patch 15 to 17, keep everything seems happy.

Thanks,
Ian

> > Thanks,
> > Namhyung
> >
> > >
> > > Summary of Patches:
> > >
> > > 1-3: Foundational Tooling & Fast-Path Feature Detection
> > >   - Exempts bpftool bootstrap from non-essential feature tests (LLVM,=
 libbfd,
> > >     libcap), saving 1.1s of sub-make fork overhead during Kbuild star=
tup.
> > >   - Integrates libdebuginfod directly into test-all.c, allowing Make =
to skip
> > >     individual feature check sub-make forks during AST parsing on ful=
ly
> > >     configured workstations. Escapes $(shell ...) macro expansion to =
prevent
> > >     unconditional sub-make forks.
> > >   - Fixes test-clang-bpf-co-re.bin feature check to correctly generat=
e its
> > >     target file on disk via atomic move (> $@.tmp && mv $@.tmp $@), a=
llowing
> > >     Kbuild to perfectly cache the detection result and avoid continuo=
us sub-make
> > >     re-evaluations.
> > >
> > > 4-6: Flattening Umbrella Prepare Barriers
> > >   - builtin-trace embedded inclusions and pmu-events generation are c=
ompletely
> > >     decoupled from the sequential "prepare" umbrella target, eliminat=
ing Make
> > >     AST double-parsing overhead and unchoking parallel compilation ba=
rriers.
> > >
> > > 7-10: Decoupling & Pre-generating BPF Skeletons
> > >   - BPF skeleton rules are extracted out of Makefile.perf into bpf_sk=
el.mak.
> > >   - Decouples bpftool bootstrap from top-level static libbpf dependen=
cies,
> > >     attaching bpf-skel-prepare directly to the umbrella prepare targe=
t. This
> > >     allows Make to pre-compile bpftool and dump vmlinux.h in the back=
ground at
> > >     build startup, removing the 7-second serialization bottleneck bef=
ore BPF
> > >     object compilation.
> > >   - Ensures benchmark skeleton intermediate .bpf.o files are cleanly =
removed
> > >     during make clean, and adds bpf-skel-prepare to .PHONY.
> > >
> > > 11-12: Foundational Linkage Optimization
> > >   - Eliminates redundant libbpf sub-make feature checks during static=
 builds.
> > >   - Moves static libsymbol and libbpf library prerequisites out of th=
e
> > >     prepare step, ensuring libbpf headers are installed before
> > >     compiling BPF-dependent tests.
> > >
> > > 13-14: jevents.py Concurrency & Deduplication
> > >   - Splits the massive 2.8 MB big_c_string literal out of pmu-events.=
c
> > >     into a dedicated pmu-events-string.c compilation unit. This slice=
s
> > >     C compilation latency in half by compiling string and struct
> > >     tables simultaneously across separate CPU cores while preserving
> > >     zero dynamic ELF relocations. Adds pmu-events-string.c to
> > >     .gitignore and uses Make 4.0 compatible dependency chaining.
> > >   - Pre-populates jevents.py JSON ASTs and metric formulas in paralle=
l across
> > >     all available CPU cores using ProcessPoolExecutor (accelerating P=
ython
> > >     execution by 11x, from 3.3s down to ~290ms). Moves _init_worker t=
o top-level
> > >     scope to ensure clean pickling under spawn multiprocessing start =
methods.
> > >
> > > 15: Out-of-Tree Incremental Rebuild Fix
> > >   - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to pr=
event
> > >     Make from continuously re-executing script installation rules on =
already
> > >     built out-of-tree builds.
> > >
> > > 16-17: AST Parsing Optimization & Shell Fork Eradication
> > >   - Converts ZENS, ARMS, and INTELS in pmu-events/Build from recursiv=
e
> > >     assignment (=3D) to simply expanded assignment (:=3D) and replace=
s
> > >     model_name/vendor_name with pure GNU Make string functions. This
> > >     guarantees Make executes directory probing shell forks exactly
> > >     once during AST parsing and evaluates path macros purely in
> > >     memory, completely eradicating over 7,800 redundant sub-processes
> > >     during out-of-tree build evaluation.
> > >   - Converts llvm-config shell queries in Makefile.config from
> > >     recursive assignment (=3D) to simply expanded assignment (:=3D). =
This
> > >     eliminates ~185 redundant sub-processes that were previously
> > >     executed across object compilation dependency checks.
> > >
> > > Changes since v2:
> > >   - Dropped Patch 4 (tools scripts: Short-circuit CC_NO_CLANG compile=
r
> > >     probe in Makefile.include) to prevent potential cross-compilation
> > >     regressions when CC and HOSTCC use different compilers.
> > >   - tools build (Patch 2): Escaped $(shell ...) macro expansion as
> > >     $$(shell ...) inside define feature_check_code to safely defer
> > >     sub-make execution until after eval parses the ifeq guard.
> > >   - tools build (Patch 3): Refactored test-clang-bpf-co-re.bin featur=
e
> > >     check recipe to redirect grep output to a temporary file and
> > >     atomically move it upon success (> $@.tmp && mv $@.tmp $@),
> > >     preventing Kbuild from permanently caching failed detections due =
to
> > >     0-byte files.
> > >   - perf trace beauty (Patch 4): Updated commit description to accura=
tely
> > >     reflect the unconditional top-level recursive kbuild hook
> > >     (perf-util-y +=3D trace/beauty/).
> > >   - perf build (Patch 7): Added $(OUTPUT)bench/bpf_skel/.tmp to
> > >     bpf-skel-clean in Makefile.perf to ensure intermediate benchmark
> > >     skeleton .bpf.o artifacts are cleanly removed during make clean.
> > >     Removed unused bpf_skel_deps variable from bpf_skel.mak.
> > >   - perf build (Patch 9): Added $(LIBBPF) as an explicit prerequisite=
 to
> > >     $(LIBPERF_TEST_IN) in Makefile.perf to guarantee libbpf headers a=
re
> > >     fully installed before compiling sigtrap.c or other BPF-dependent
> > >     tests during parallel builds.
> > >   - perf build (Patch 10): Added bpf-skel-prepare to the .PHONY targe=
t
> > >     list in Makefile.perf to ensure Make never incorrectly skips the
> > >     target if a file or directory named bpf-skel-prepare accidentally
> > >     exists in the build tree.
> > >   - perf pmu-events (Patch 13): Added pmu-events/pmu-events-string.c =
to
> > >     tools/perf/.gitignore. Replaced grouped targets (&:) with Make 4.=
0
> > >     compatible dependency chaining to guarantee backward compatibilit=
y
> > >     with older Make versions (like 4.2.1) and prevent parallel builds
> > >     from spawning multiple concurrent jevents.py processes.
> > >   - perf pmu-events (Patch 14): Moved _init_worker from local main()
> > >     scope to the top-level module scope in jevents.py to ensure it ca=
n be
> > >     cleanly pickled when ProcessPoolExecutor uses the spawn
> > >     multiprocessing start method (avoiding AttributeError crashes).
> > >
> > > Ian Rogers (17):
> > >   bpftool build: Restrict feature tests during bootstrap compilation
> > >   tools build: Integrate libdebuginfod into test-all fast path
> > >   tools build: Fix test-clang-bpf-co-re.bin to generate target file
> > >   perf trace beauty: Make beauty generated C code standalone .o files
> > >   perf build: Decouple pmu-events from prepare umbrella target
> > >   perf build: Remove empty archheaders target
> > >   perf build: Move BPF skeleton generation out of Makefile.perf
> > >   perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
> > >   perf build: Move static libbpf dependency out of prepare step
> > >   perf build: Pre-generate BPF skeleton tooling during umbrella prepa=
re
> > >     phase
> > >   perf build: Move libsymbol dependency out of prepare step
> > >   perf build: Remove redundant libbpf feature check for static builds
> > >   perf pmu-events: Split big_c_string storage into standalone
> > >     compilation unit
> > >   perf pmu-events: Parallelize JSON and metric pre-computation in
> > >     jevents.py
> > >   perf build: Prefix SCRIPTS with output directory to fix continuous
> > >     rebuilds
> > >   perf pmu-events: Convert recursive shell assignments and macros to
> > >     Make built-ins
> > >   perf build: Convert llvm-config shell queries to simply expanded
> > >     variables
> > >
> > >  tools/bpf/bpftool/Makefile                    |   5 +
> > >  tools/build/Makefile.feature                  |   6 +-
> > >  tools/build/feature/Makefile                  |   4 +-
> > >  tools/build/feature/test-all.c                |   5 +
> > >  tools/perf/.gitignore                         |   1 +
> > >  tools/perf/Build                              |   2 +
> > >  tools/perf/Makefile.config                    |  19 +-
> > >  tools/perf/Makefile.perf                      | 431 ++--------------=
--
> > >  tools/perf/bench/Build                        |   6 +
> > >  .../bpf_skel/bench_uprobe.bpf.c               |   0
> > >  tools/perf/bench/uprobe.c                     |   2 +-
> > >  tools/perf/bpf_skel.mak                       | 109 +++++
> > >  tools/perf/builtin-trace.c                    |  30 +-
> > >  tools/perf/pmu-events/Build                   |  26 +-
> > >  tools/perf/pmu-events/jevents.py              |  56 ++-
> > >  tools/perf/trace/beauty/Build                 | 280 ++++++++++++
> > >  tools/perf/trace/beauty/arch_errno_names.c    |   2 +
> > >  tools/perf/trace/beauty/arch_errno_names.sh   |   2 +-
> > >  tools/perf/trace/beauty/beauty.h              |  60 +++
> > >  tools/perf/trace/beauty/eventfd.c             |   6 +-
> > >  tools/perf/trace/beauty/fsconfig.c            |   5 +
> > >  tools/perf/trace/beauty/futex_op.c            |   6 +-
> > >  tools/perf/trace/beauty/futex_val3.c          |   6 +-
> > >  tools/perf/trace/beauty/mmap.c                |  24 +-
> > >  tools/perf/trace/beauty/mode_t.c              |   6 +-
> > >  tools/perf/trace/beauty/msg_flags.c           |   8 +-
> > >  tools/perf/trace/beauty/open_flags.c          |   1 +
> > >  tools/perf/trace/beauty/perf_event_open.c     |  22 +-
> > >  tools/perf/trace/beauty/pid.c                 |   5 +-
> > >  tools/perf/trace/beauty/sched_policy.c        |   8 +-
> > >  tools/perf/trace/beauty/seccomp.c             |  12 +-
> > >  tools/perf/trace/beauty/signum.c              |   6 +-
> > >  tools/perf/trace/beauty/socket_type.c         |   6 +-
> > >  .../perf/{util =3D> trace/beauty}/syscalltbl.c  |   0
> > >  .../perf/{util =3D> trace/beauty}/syscalltbl.h  |   0
> > >  tools/perf/trace/beauty/tracepoints/Build     |  22 +
> > >  tools/perf/trace/beauty/waitid_options.c      |   8 +-
> > >  tools/perf/util/Build                         |  17 +-
> > >  tools/perf/util/bpf-trace-summary.c           |   2 +-
> > >  tools/perf/util/env.c                         |   4 +-
> > >  tools/perf/util/env.h                         |   1 +
> > >  41 files changed, 717 insertions(+), 504 deletions(-)
> > >  rename tools/perf/{util =3D> bench}/bpf_skel/bench_uprobe.bpf.c (100=
%)
> > >  create mode 100644 tools/perf/bpf_skel.mak
> > >  create mode 100644 tools/perf/trace/beauty/fsconfig.c
> > >  rename tools/perf/{util =3D> trace/beauty}/syscalltbl.c (100%)
> > >  rename tools/perf/{util =3D> trace/beauty}/syscalltbl.h (100%)
> > >
> > > --
> > > 2.54.0.563.g4f69b47b94-goog
> > >

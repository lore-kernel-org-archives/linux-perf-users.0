Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F072D5932
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216802; cv=pass; b=o3RouB1iwhH6mLAUythXFMS2qeDy6cgMcHpy6z25Bc59mTeup6pDWSULR7pZls3JczVZgq2c+RSq6vtOZG5NgapI4CciV4a/18yGLb97ea4YYsxvss4wmEE9c41/P6YWRU0C4i/ZwglSfjMBxw9q3BSHFeDHYI3EiC4sFsSRz0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216802; c=relaxed/simple;
	bh=plfXtwctcX7RIwwVCPJRx5M23rgQL0XAh/FVtT+8StY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owtU4tsEqxrxILVfx2CsMFhku/KZ6tv4vxVIW89n47DbDk0IWXbEKSwOxkuudw8c3usyAbQdwzkk59rgp6JbGkNT1V+gsvC3ffGUFfSR/MI+/vFYM0e3PwK+Rph+K43z+87akyiCul5hweWIp7z+rt5rF6xn0Fi8LLbxgxj6JyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=giqX4hO4; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giqX4hO4"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba180a022dso1645ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 11:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216800; cv=none;
        d=google.com; s=arc-20240605;
        b=DSGb6IVg+eXiYvfvs/mD/MQolRfjgARpFgOVFeFewRO5e2neafuNq0nHpBm+5tC2Z0
         MUxrGA3xcnVaJ/GmGwjiMl5P2UIKaQRJaK3DeGmPEdzQsnaP9OSKANiq2xYBmK7yaIs+
         OXx1LvsHLNMDE93CRTNKm8+HLHhAglnem+tpgZ0wd/IDEp/PDXYLkqBWdbrAjVwmSHAW
         m9rhx/O1BhIpHL7P/JZbzP+ry6nBzCs/7fRtlJbxUjxbJAwZJ7FTY0EJ1p0QPTfu81Eu
         77gpIstxwwn7vgeM/ropP6DZGXRadjKCgztokx8k/CoFYG6Zz0TR1SUJrJbmEYfFB3m9
         Ttwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lhvxmYHKe0KMovn7WvpTgA8pqdI/EU1EyA8chDBDlck=;
        fh=VcVQapjWewTEzNZISj13IzvL/5tBrpuuv7DS7Ju9MDw=;
        b=gWLi127mv9+8aNb3TeaeaJkTyC1nEBQFHM2Ifo2w+3pB1eHMXW4wwpkn0d3B/xn6zD
         /7WUMpbtBLHAWpFO9A+kcccbNbt48gQnuX7Mnb+NT0racpyEIiY/9X7Iul6wN5yR3Jpn
         G0SUlQQu0Ck5rtATsZJSv2nrCtZhNcEgVZGjSrbw+TooltvzaxlVl/ipKpP4w2/R5sdU
         O4+YfZxzHlCu0UFIJvFR9RF+BAeZhTPnl/dENJ9aC0UnbxmGRC2aNGhCsqW+oWDmSCvn
         wDwWrHdRA6wr9C2zCn+MCsW/jqYBO/7jEKSZMZUTWkMZT0mpIkr2Hux8yc2XY7R4IxFD
         HnUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779216800; x=1779821600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhvxmYHKe0KMovn7WvpTgA8pqdI/EU1EyA8chDBDlck=;
        b=giqX4hO4QLmogg3y8ieX9agB+/XVvmosCfW3praEaaK9t72rZYLmPMncOshacLyUvy
         kHQn8EJCg9/FeEuWJlhydb0MGa130onHBszYs9FTKBu7k9w9OWA7l4NMrzAj59kQqB1r
         8xHZq9EREGeY+T7DFkLz0mHEpLEgs30uTs28Q2ZYNlrwdaoM0nSo30Ql/zJaFHR9cTaH
         VIatp5aQyXi8HzyUolqBkSYk2fu0KydSpsYcr1Ycxo7SgVitaJzQuqSa27+AnO1DVF3s
         w2uPM++lndv1jSA+/l0xkhbdQBkfod2S7Fu2vghUxAQJfWN6v7hYa3ix6y4FaMPiE6wn
         EXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216800; x=1779821600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhvxmYHKe0KMovn7WvpTgA8pqdI/EU1EyA8chDBDlck=;
        b=MF7d03K3qOiKLl336XiJwLyKdH04n93TNGyS68v7h9ujiP4NrnKvYOKZnkhpllZol7
         1LseklnFOBp9DDigJSSKycZpzAF323vCNQOzWmpMypQpseoAq5dmW6f5QDXUW8y+nMZx
         hBaRRjpSiEOzmvb0XAOc3/2Dk8uWPuRTpBQWXC8Rvx1u18Uyg9ScpCjclNnDBq91uw2V
         C3Vgu7ScS8V+NhmVXJHGJjF79K89ceAJthYqdnS7CORHO8oD85YuDV8jmnKhi87rQWfJ
         /PgRoXZ0VSnAGSA0vSDlCvFwG/tMOXTD689Zm4PpyRR0TdUET0qCdVgt4zb3NnZCuf49
         m13g==
X-Forwarded-Encrypted: i=1; AFNElJ/qMsL7XEoQWmsylCVoK4GIbIMVV5KoIt5qa385SsuAh/65X6/UoSN8EiXkOZHNJNanzMF47B87PuFrRz/hn2Qv@vger.kernel.org
X-Gm-Message-State: AOJu0YwJG7C2b8SpfWBDbXNiTKZrle3UsnMI3zlmT20bCoBa73Ix84zW
	6H7F/KexcEh+1AgyPNtMqL3Vi8UbknaWb3mEe5leXAucfwf2jrfl0Z9SG4NIumMSGyCkF4XS34A
	Xn17KaBSAjmyn2HdJqx9bzlZda8C+YOJEMSFnAgXy
X-Gm-Gg: Acq92OFRm3ghsaiuJudgH9HhL+olYO0LDjrofmPpqhOrkIl2FcdkU5Z45hFydyfCWhR
	/tEu/bJZabZAkX+RahItHadWbE+nFWlID/7TtOLYIYNusn9FCLWRgrsfXYaKVHtnmUov2xvUxye
	n7dBccCVao/Qe0qW2IUR9x7SzSmHaJZ4b6wPiIhHVv6nAuHGl/E5NPBOA7U7iQoKC8zWT4twok4
	QHH+KF/dGZztC5TgkRHezRDgWZ4dZBNRxhmFcShl8uTXHIS/LObsrPZgR0tb6r13Sn/qxNMd1EX
	A6kkq2HyXtJi36Pq7yU7BYrdtT8pBeTwbB636UBg+QvUoFmQ
X-Received: by 2002:a17:903:3904:b0:2a8:ffed:4663 with SMTP id
 d9443c01a7336-2bdb03a2a4bmr7137625ad.12.1779216799339; Tue, 19 May 2026
 11:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
 <agyrebq2hdayDIyg@google.com> <agyw0IoPccrjYq2q@x1>
In-Reply-To: <agyw0IoPccrjYq2q@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 May 2026 11:53:08 -0700
X-Gm-Features: AVHnY4Kn-EG5dZ43_XH-invlWIDQ8vKMTqwZaTbDUr0oLGMckblRt09X_blga_8
Message-ID: <CAP-5=fVX+_oYzuanMwoia6PqtoRrK_K0zO1A+qG8Xp+fueETjw@mail.gmail.com>
Subject: Re: [PATCH v7 00/14] perf build: Reduce build time by nearly half
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alex@ghiti.fr, alexandre.chartre@oracle.com, andrii@kernel.org, 
	ankur.a.arora@oracle.com, aou@eecs.berkeley.edu, bpf@vger.kernel.org, 
	collin.funk1@gmail.com, costa.shul@redhat.com, daniel@iogearbox.net, 
	dapeng1.mi@linux.intel.com, dsterba@suse.com, eddyz87@gmail.com, 
	howardchu95@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:49=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, May 19, 2026 at 11:27:05AM -0700, Namhyung Kim wrote:
> > On Mon, May 18, 2026 at 08:46:24AM -0700, Ian Rogers wrote:
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
> > > latency improves by over 44%:
> > >
> > >   Before:
> > >     real    0m29.006s
> > >     user    2m46.019s
> > >     sys     0m30.610s
> > >
> > >   After:
> > >     real    0m16.091s
> > >     user    2m40.135s
> > >     sys     0m25.740s
> > >
> > > Saving 12.9 full seconds time per clean build. Furthermore, nothing t=
o
> > > build incremental builds are improved by nearly 7x:
> > >
> > >   Before:
> > >     real    0m11.528s
> > >     user    0m9.633s
> > >     sys     0m6.965s
> > >
> > >   After:
> > >     real    0m1.717s
> > >     user    0m1.682s
> > >     sys     0m0.960s
> > >
> > > Summary of Patches:
> > >
> > > 1: Fast-Path Feature Detection
> > >   - Refactors test-clang-bpf-co-re.bin and test-bpftool-skeletons.bin=
 feature
> > >     checks to group shell pipelines within curly braces and redirect =
both stdout
> > >     and stderr to .make.output before touching $@ purely upon success
> > >     (> $(@:.bin=3D.make.output) 2>&1 && touch $@). Grouping the pipel=
ine ({ cmd1 | cmd2; })
> > >     ensures that compiler stderr is successfully captured in .make.ou=
tput rather
> > >     than escaping to the parent shell. This perfectly matches standar=
d Kbuild
> > >     feature check conventions and ensures the target files are touche=
d on disk
> > >     purely upon success, allowing Kbuild to cache positive detections=
 and avoid
> > >     continuous sub-make re-evaluations during incremental builds. Add=
s
> > >     test-bpftool-skeletons.bin to the clean FILES list and explicit s=
ource
> > >     prerequisite test-clang-bpf-co-re.c.
> >
> > I think patch 1 can be separated and needs Ack/Review from BPF folks.
> >
> > >
> > > 2-4: Flattening Umbrella Prepare Barriers
> > >   - builtin-trace embedded inclusions and pmu-events generation are c=
ompletely
> > >     decoupled from the sequential "prepare" umbrella target, eliminat=
ing Make
> > >     AST double-parsing overhead and unchoking parallel compilation ba=
rriers.
> > >
> > > 5-7: Decoupling & Pre-generating BPF Skeletons
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
> > > 8-9: Foundational Linkage Optimization
> > >   - Moves static libsymbol library prerequisites out of the prepare s=
tep.
> > >   - Eliminates redundant libbpf sub-make feature checks during static=
 builds.
> > >
> > > 10-11: jevents.py Concurrency & Deduplication
> > >   - Splits the massive 2.8 MB big_c_string literal out of pmu-events.=
c into a
> > >     dedicated pmu-events-string.c compilation unit. This slices C com=
pilation
> > >     latency in half by compiling string and struct tables simultaneou=
sly across
> > >     separate CPU cores while preserving zero dynamic ELF relocations.=
 Adds
> > >     pmu-events-string.c to .gitignore, declares extern const char big=
_c_string[];
> > >     locally inside output_string_file and output_file when split to p=
revent linkage
> > >     conflicts with empty-pmu-events.c, defers file closures to ensure=
 identical
> > >     timestamps, and uses canonical Make 4.0 @: dependency chaining.
> > >   - Pre-populates jevents.py JSON ASTs and metric formulas in paralle=
l across
> > >     all available CPU cores using ProcessPoolExecutor (accelerating P=
ython
> > >     execution by 11x, from 3.3s down to ~290ms). Moves _init_worker t=
o top-level
> > >     scope to ensure clean pickling under spawn multiprocessing start =
methods.
> > >
> > > 12: Out-of-Tree Incremental Rebuild Fix
> > >   - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to pr=
event
> > >     Make from continuously re-executing script installation rules on =
already
> > >     built out-of-tree builds.
> > >
> > > 13-14: AST Parsing Optimization & Shell Fork Eradication
> > >   - Converts ZENS, ARMS, and INTELS in pmu-events/Build from recursiv=
e assignment
> > >     (=3D) to simply expanded assignment (:=3D) and replaces model_nam=
e/vendor_name
> > >     with pure GNU Make string functions. This guarantees Make execute=
s directory
> > >     probing shell forks exactly once during AST parsing and evaluates=
 path macros
> > >     purely in memory, completely eradicating over 7,800 redundant sub=
-processes
> > >     during out-of-tree build evaluation.
> > >   - Converts llvm-config shell queries in Makefile.config from recurs=
ive assignment
> > >     (=3D) to simply expanded assignment (:=3D). This eliminates ~185 =
redundant sub-processes
> > >     that were previously executed across object compilation dependenc=
y checks.
> > >
> > > Changes since v6:
> > >   - Rebase/resend as last series failed to apply by Sashiko.
> > >
> > > Ian Rogers (14):
> > >   tools build: Fix feature checks to touch target files on success
> > >   perf trace beauty: Make beauty generated C code standalone .o files
> > >   perf build: Decouple pmu-events from prepare umbrella target
> > >   perf build: Remove empty archheaders target
> > >   perf build: Move BPF skeleton generation out of Makefile.perf
> > >   perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
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
> >
> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
> So this is for 2-14? I haven't checked if 1 can be left out of an
> initial merge by me.

I believe you are correct. Patch 1 is completely independent because
it is the only change in tools/build; everything else is in
tools/perf.

Thanks,
Ian

> - Arnaldo

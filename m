Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91B366051
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216457; cv=pass; b=HjZP1pzTkcKWX1HUkvd1g7uEIAXkTWk3h76Px5ybv6FkFMw8KsMqTbdslCvxuskvV4IN1t+EIE9rWEbqhtUjvKNWjxLQ3QuTPdrMjlY5ShKYdpi1h25U2/d0bLhcsHX6KNppQYerlXAMWoHf62qEwBrahdVKQIwKTk0Tvi9rsK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216457; c=relaxed/simple;
	bh=nclwi7q8vEhshosl9rAtLGP/YxwRGYzne4w/pe8ypO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgvO9jMlXsZblDz0ud9WrvchvpOiNkzmP1IFb7Y3R4E1VNREAfxpTsSGIc4rz5dCVq7SN4penV0D+JEre1+49q0YbB388KHS3NIg8RqKZzxwRLlm8Up7u7K6Qmk3qLV4221rTo4sCQLoUwb7qYJBs8SN10U3gryj4vzHkCSMLKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eOrTCRP7; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOrTCRP7"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1225ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 11:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216455; cv=none;
        d=google.com; s=arc-20240605;
        b=c8jrce9DU0nUkaNR1OYoXPqGoodDhAiffJeFCIwqrgTidTyttr9AhCD6JeMTTJxIx5
         P0H3ztcUJIIPo/64Ba9PKu5uugs5geMEIOmou+48EZn+cqklrCYN13LoqJBC/dszmulO
         hyfC+4ksciX19CvaBMwxwynaD/BohDAVWt+G2ZgYHCGgdbIbIyuaxIG0EGH6Pkr2Uf2v
         SZ5++ilr1nQBXEKImPbB4p3c18gZUmm4WxxUP+YAnHtsLDchCjfxhMoOJKzvNA/URwxp
         y1OnGse0Ic1SaDCFMIhimXOibbfpwClXz7YKMBDvlMu+QYM2uT0IOoXR9HpZshFIEVqE
         xFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gnyw5FEIioV9+7c61EPkvkZwQkVYNkDQPqYH+54mzWI=;
        fh=0FMdXCOWNF+1mynuggFRz77QAX2z5Fw1vZV9PikwEp0=;
        b=a5goyAqsfXq8CqD1HnR1PQjK5dV9534slqc1iews1f+DLUatKV3qEMK6fUqK2P+gxh
         ndnKRT2lugcGh1DmoHpPptwWTIXVWwA9F+xitZYNuqya7Jxb+D4Q9a2aBc2lkVt1gKc4
         IrYoGmqeyDY8dgsAqRyU9zUrjrlVDBeUJNEawGqKjJwILtB45Ktv2eWdYEiQpwjDxREn
         foYlYV6efU7mhN5dMepgYGv9IYHsjlzmTzM9hNTS/5SzqgOvBpvpGwU+VpdWsV494byu
         9H84Vw/SPh0/HnM8A0p8gyx+N5RAwADZ5Vtf84dDBVw9d19ZCRtFlv63wXAnh5NN1RWv
         DlTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779216455; x=1779821255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnyw5FEIioV9+7c61EPkvkZwQkVYNkDQPqYH+54mzWI=;
        b=eOrTCRP7Fl3MkXPXr5k4TnVldN43abODJbmaclCqIgNzJ9jFDZ/zVOkVHeGWYSfcSc
         Dag5FCcKdvZiE1lG2+n+agYQl4Rl12l3hPhHRGaSF+TQwWtZ+HQJyRU20ZLkRdq80uQi
         0PU5KRF5sqTmXnV2ZK/apQTgJVfoWNEMB6Camai5PrbyLL5m1Wu3wa2B/erfvV0B4AF1
         ZmcK1gP7cwfOgpIeccQCkbbw8oz4E1dfy9sk0nqiPjVGcdP9I6EXpeWnyyPEwnaLSOJO
         qVTGwVz4Pa/81N0TIxI6xESnwL8v352sbAGmEYuyaxc+wj4tN7l7zsBBpGRNTG42ad/L
         HCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216455; x=1779821255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gnyw5FEIioV9+7c61EPkvkZwQkVYNkDQPqYH+54mzWI=;
        b=jnj937go9/6TcYclco/OTDEBOFkROTNEEc31axtWmqbFSfwMw1mSRBvpZbQEgASy67
         p8MhHu89RGV1kX+WtWBd1YdSPEpWykvTT5uT1oT6gRN2Qhj0XDYHQisbBQQ7AWloDXkh
         fNie4RyIBzwiqqv1RUXHIQk3QqqSN20q3VnA0JpCsbGz+LyeIgrOZbn6zYo1YTfWMZs+
         QCLyS/mRO0zXdSeJfXOuz8jhPaeK2ocMjH7jpCj2vccj4cNLd//vV4jesDqz3Ici+KVU
         AFFV914HKW4xDdZQDOjSImnKH0UdRsu1JWoQNqzk4ySuxvlkN4twgYVOJrRb1qxXzYz5
         fTEg==
X-Forwarded-Encrypted: i=1; AFNElJ8eRBmkTtiHMJCcDhgU6HfJzqfCA1L+cf1xTNWDYtQZf90/3kwvTQBAeDHsf355wZZ1k+79g02cGtXPvuKgFXU3@vger.kernel.org
X-Gm-Message-State: AOJu0YyZt9XXxp4uiczM08tkAImockSMjUALs5WDslJNFwMsh9NCRKiV
	6eyPzslzKrUJBtI/0e0rLnEksIsV/UX1aDVRLJ0fGzv5zF8HYcxASlmDjxfU8T2d7Dqd/cgdZFj
	XPzstNZVRrtBh/QQkAVQnmfzfjkphqF0U7yuMds6c
X-Gm-Gg: Acq92OHPhry4Z+JbT9X7Nzfanlxz9IylqLwzDvjmi8R9uefNUb9RI3QvluQVZn19C3G
	samjyeCMPeIrJlOdw/FhCpzTuT+K4pg3zW0iAsqWgznZ01QAa79NMBg/pA18WeoMIVZSaqknk9p
	jqSeSrUhEXMwimBJEW6kOzLOL7y2K5k2vq5SEnTN8LujjZ48u1M/0Jv1hHOmFsAj9ooOdGG4PKs
	vzRCnrf/uVqOX9riV2n1LbkDGO/Ja11TwNaS6OIQsRuJ4eiKOzQrWsLRTCJq1/cq5/9N/nz0HA6
	k2WbbH0BjX0Sw7tUrVWdMLqEobK6WwofMOWhRETdjRvx6WEK
X-Received: by 2002:a17:903:2ecc:b0:2b0:be7d:a25e with SMTP id
 d9443c01a7336-2bdb041188emr7643845ad.18.1779216454303; Tue, 19 May 2026
 11:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
 <agyrebq2hdayDIyg@google.com>
In-Reply-To: <agyrebq2hdayDIyg@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 May 2026 11:47:22 -0700
X-Gm-Features: AVHnY4LSjWEY_4tSs1NBSEbYghAXY_qBkRMxOvlVfCOQVqq2-vI3d3Yuohs6A-Y
Message-ID: <CAP-5=fXKnuevAptyns_JE-Bdb5xYxCg359FBmdYTmo4Yy3R-UA@mail.gmail.com>
Subject: Re: [PATCH v7 00/14] perf build: Reduce build time by nearly half
To: Namhyung Kim <namhyung@kernel.org>, andrii@kernel.org, bpf@vger.kernel.org, 
	acme@kernel.org, jolsa@kernel.org, daniel@iogearbox.net, song@kernel.org, 
	yonghong.song@linux.dev
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, ankur.a.arora@oracle.com, aou@eecs.berkeley.edu, 
	collin.funk1@gmail.com, costa.shul@redhat.com, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, 
	james.clark@linaro.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:27=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, May 18, 2026 at 08:46:24AM -0700, Ian Rogers wrote:
> > This patch series refactors Kbuild internals, BPF skeleton generation,
> > Python AST pre-computation, and foundational tooling dependencies acros=
s
> > the perf tool build system. By eliminating umbrella target synchronizat=
ion
> > barriers, decoupling static library prerequisites, parallelizing single=
-core
> > script generators, and eradicating redundant feature checks, this serie=
s
> > unlocks absolute theoretical peak multi-core concurrency during Kbuild =
startup.
> >
> > On a 28-core build workstation (make -j28 all from scratch), clean buil=
d
> > latency improves by over 44%:
> >
> >   Before:
> >     real    0m29.006s
> >     user    2m46.019s
> >     sys     0m30.610s
> >
> >   After:
> >     real    0m16.091s
> >     user    2m40.135s
> >     sys     0m25.740s
> >
> > Saving 12.9 full seconds time per clean build. Furthermore, nothing to
> > build incremental builds are improved by nearly 7x:
> >
> >   Before:
> >     real    0m11.528s
> >     user    0m9.633s
> >     sys     0m6.965s
> >
> >   After:
> >     real    0m1.717s
> >     user    0m1.682s
> >     sys     0m0.960s
> >
> > Summary of Patches:
> >
> > 1: Fast-Path Feature Detection
> >   - Refactors test-clang-bpf-co-re.bin and test-bpftool-skeletons.bin f=
eature
> >     checks to group shell pipelines within curly braces and redirect bo=
th stdout
> >     and stderr to .make.output before touching $@ purely upon success
> >     (> $(@:.bin=3D.make.output) 2>&1 && touch $@). Grouping the pipelin=
e ({ cmd1 | cmd2; })
> >     ensures that compiler stderr is successfully captured in .make.outp=
ut rather
> >     than escaping to the parent shell. This perfectly matches standard =
Kbuild
> >     feature check conventions and ensures the target files are touched =
on disk
> >     purely upon success, allowing Kbuild to cache positive detections a=
nd avoid
> >     continuous sub-make re-evaluations during incremental builds. Adds
> >     test-bpftool-skeletons.bin to the clean FILES list and explicit sou=
rce
> >     prerequisite test-clang-bpf-co-re.c.
>
> I think patch 1 can be separated and needs Ack/Review from BPF folks.

So I dropped the patch restricting the features tested when making
bpftool in bootstrap mode as perf does:
https://lore.kernel.org/linux-perf-users/20260514163409.927816-2-irogers@go=
ogle.com/
We don't need to test for libbfd disassembly support for bpftool if we
just need the bootstrap version. But anyway, I dropped that patch and
hopefully someone on the BPF side can take it or something. I find the
BPF mailing list has a difficult user interface.

The only patch remaining is:
https://lore.kernel.org/linux-perf-users/20260518154638.2798789-2-irogers@g=
oogle.com/
```
...
-$(OUTPUT)test-clang-bpf-co-re.bin:
- $(CLANG) -S -g --target=3Dbpf -o - $(patsubst %.bin,%.c,$(@F)) | \
- grep BTF_KIND_VAR
+$(OUTPUT)test-clang-bpf-co-re.bin: test-clang-bpf-co-re.c
+ { $(CLANG) -S -g --target=3Dbpf -o - $< | \
+ grep BTF_KIND_VAR; } > $(@:.bin=3D.make.output) 2>&1 && touch $@

 $(OUTPUT)test-file-handle.bin:
  $(BUILD)
@@ -393,8 +394,8 @@ $(OUTPUT)test-libopenssl.bin:
  $(BUILD) $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null)

 $(OUTPUT)test-bpftool-skeletons.bin:
- $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
- > $(@:.bin=3D.make.output) 2>&1
+ { $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons'; } \
+ > $(@:.bin=3D.make.output) 2>&1 && touch $@
...
```
which just adds `&& touch $@` so that every incremental build doesn't
re-detect these features. None of the logic changes, so I was hoping
that a BPF sign off wouldn't be a requirement. But anyway, let's hope
a BPF person responds.

> >
> > 2-4: Flattening Umbrella Prepare Barriers
> >   - builtin-trace embedded inclusions and pmu-events generation are com=
pletely
> >     decoupled from the sequential "prepare" umbrella target, eliminatin=
g Make
> >     AST double-parsing overhead and unchoking parallel compilation barr=
iers.
> >
> > 5-7: Decoupling & Pre-generating BPF Skeletons
> >   - BPF skeleton rules are extracted out of Makefile.perf into bpf_skel=
.mak.
> >   - Decouples bpftool bootstrap from top-level static libbpf dependenci=
es,
> >     attaching bpf-skel-prepare directly to the umbrella prepare target.=
 This
> >     allows Make to pre-compile bpftool and dump vmlinux.h in the backgr=
ound at
> >     build startup, removing the 7-second serialization bottleneck befor=
e BPF
> >     object compilation.
> >   - Ensures benchmark skeleton intermediate .bpf.o files are cleanly re=
moved
> >     during make clean, and adds bpf-skel-prepare to .PHONY.
> >
> > 8-9: Foundational Linkage Optimization
> >   - Moves static libsymbol library prerequisites out of the prepare ste=
p.
> >   - Eliminates redundant libbpf sub-make feature checks during static b=
uilds.
> >
> > 10-11: jevents.py Concurrency & Deduplication
> >   - Splits the massive 2.8 MB big_c_string literal out of pmu-events.c =
into a
> >     dedicated pmu-events-string.c compilation unit. This slices C compi=
lation
> >     latency in half by compiling string and struct tables simultaneousl=
y across
> >     separate CPU cores while preserving zero dynamic ELF relocations. A=
dds
> >     pmu-events-string.c to .gitignore, declares extern const char big_c=
_string[];
> >     locally inside output_string_file and output_file when split to pre=
vent linkage
> >     conflicts with empty-pmu-events.c, defers file closures to ensure i=
dentical
> >     timestamps, and uses canonical Make 4.0 @: dependency chaining.
> >   - Pre-populates jevents.py JSON ASTs and metric formulas in parallel =
across
> >     all available CPU cores using ProcessPoolExecutor (accelerating Pyt=
hon
> >     execution by 11x, from 3.3s down to ~290ms). Moves _init_worker to =
top-level
> >     scope to ensure clean pickling under spawn multiprocessing start me=
thods.
> >
> > 12: Out-of-Tree Incremental Rebuild Fix
> >   - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to prev=
ent
> >     Make from continuously re-executing script installation rules on al=
ready
> >     built out-of-tree builds.
> >
> > 13-14: AST Parsing Optimization & Shell Fork Eradication
> >   - Converts ZENS, ARMS, and INTELS in pmu-events/Build from recursive =
assignment
> >     (=3D) to simply expanded assignment (:=3D) and replaces model_name/=
vendor_name
> >     with pure GNU Make string functions. This guarantees Make executes =
directory
> >     probing shell forks exactly once during AST parsing and evaluates p=
ath macros
> >     purely in memory, completely eradicating over 7,800 redundant sub-p=
rocesses
> >     during out-of-tree build evaluation.
> >   - Converts llvm-config shell queries in Makefile.config from recursiv=
e assignment
> >     (=3D) to simply expanded assignment (:=3D). This eliminates ~185 re=
dundant sub-processes
> >     that were previously executed across object compilation dependency =
checks.
> >
> > Changes since v6:
> >   - Rebase/resend as last series failed to apply by Sashiko.
> >
> > Ian Rogers (14):
> >   tools build: Fix feature checks to touch target files on success
> >   perf trace beauty: Make beauty generated C code standalone .o files
> >   perf build: Decouple pmu-events from prepare umbrella target
> >   perf build: Remove empty archheaders target
> >   perf build: Move BPF skeleton generation out of Makefile.perf
> >   perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
> >   perf build: Pre-generate BPF skeleton tooling during umbrella prepare
> >     phase
> >   perf build: Move libsymbol dependency out of prepare step
> >   perf build: Remove redundant libbpf feature check for static builds
> >   perf pmu-events: Split big_c_string storage into standalone
> >     compilation unit
> >   perf pmu-events: Parallelize JSON and metric pre-computation in
> >     jevents.py
> >   perf build: Prefix SCRIPTS with output directory to fix continuous
> >     rebuilds
> >   perf pmu-events: Convert recursive shell assignments and macros to
> >     Make built-ins
> >   perf build: Convert llvm-config shell queries to simply expanded
> >     variables
>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks!
Ian

> Thanks,
> Namhyung
>

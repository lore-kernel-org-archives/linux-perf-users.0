Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD3390C8B
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227228; cv=pass; b=r5bAOXi+85jsqJYvl05gvOMs+0ftXnMFMJE07/rPEEoxH4z81puTqMCHHidWuGbHX8U0PhZ3+JVxkZO4teFi0lMBUWJbQ0amBxzXGatuc4YW8ljftHHtJO6XYfUPBOQA4CWRPqZZxm+PLNFsKt0aQb0GXl4dD+ZRFmPbAyZPHCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227228; c=relaxed/simple;
	bh=1/0z+ZlPR54RhQcGppYRFNoNJpPcMxZpq7LTr7R240E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kihFnHhyddkhf2kAVhVl7MsX+/LX34wtYgcU/WNuwI44JXStXJXxncViZ7ejTc8HAJLT0+T8aZhoJrfJuAHJYO6O0V6TEYHgq+xtUMTr2E+QKVTVUgwlc5jVBg0COfFFXqMsIlHrHqLQN4K6d0dHUCQrmmqZxm4loZezCqdl/r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kCBIBjl6; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kCBIBjl6"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b46da8c48eso3715ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 14:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779227227; cv=none;
        d=google.com; s=arc-20240605;
        b=QYr+SMTq13iivbl83p0M5II/sHt8qpmkq7IhateLUk145xUxC/IluLrPRcTq9eBbUv
         b0gDPKrfhvnqBVER6mv8QoOGPYr/4S48rQ3FzJxDkI14qDZcekNG49B3IDpCjWruakCC
         FH4JOthOpNgSa9Yf+7mR+pSC3EZeJs4gxqVhZvN9Clitu+5Q6hYHYqzrhfsgqCr6EPhA
         uW7pjfi4doWMNPwFwiARbidHSsARFSyUdHDA0Vpztz9ppIv0fsbmKd7rsVBznulSe0pK
         Ql5qDCz1ZjGaK86Lz6b8HhFAv0L2dYPj+NZ6uoimbiOwm2qTj+HBWP1tYDYPUQmqLgUJ
         s+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=08fv7mUwDVV9ltPUZ8pC2yy1TwA/oOWa4ATfXmrcDX0=;
        fh=cTigODwenUiQhPvGeEJnPvbbYTPbDqxIXQNhPZtXVK0=;
        b=EWGkZqfzVIvPjcb3kH89+eaOuO9Zz6Yf0ObczseM6UwE20b/13ZnE1aTTiFcJk7KIe
         bNWnjzUpBI3nESIN8hCQ93wKwa0uRboehy50UU9bOriyLtjQJDPo1wAJXpf6TpTcPOz7
         BteD+CdlwvpKRC5+F+KTKBZv/6cLkSMmE6CGGFGg1s3LxAK3eCFWBur/q79OJnwtofz6
         MV+s1MPo3L/L1FCt/cdUCUobpXWsqvFKoRhGxCrjZk+TQPDPGqZHJF686o3k1/S5Q3WI
         qvSTWp9pv0KPw+QC7//3/bAEytl3lvUbgg3vrtMk7ImQFF2z3/ok9Yhu86915OWpgeu+
         UGww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779227227; x=1779832027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08fv7mUwDVV9ltPUZ8pC2yy1TwA/oOWa4ATfXmrcDX0=;
        b=kCBIBjl63X9I3k+2QOpiZybjeRiksG3VL/3OQFGw5BSV9TeykXapwIUGWiCm1578wt
         Y1dlcWB+vGcPajU++tDONqs/fZPL/QnQsQWLP3LLdXOydsbTP5b8+To0iOgSz7qy7+0L
         +GpcwbhFby7M8FVGLZBZ5//9JlH8BzZqd27dEdlz2ZjnXhyeJO2O0RvK+kbYKsTZJpkw
         5/p/wwNgVYPcoInXJJi1/FSidzEu4erptbXswQt7XbLpOSukuH6AA+7QXuFoDx+bx2Ma
         Bj69EVswnUyovjNWDdo/+j8l9FnCl82ZZRW7nGo6vD5HAxnoddyXv3M6zFKCPmhQ1PtF
         lDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779227227; x=1779832027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=08fv7mUwDVV9ltPUZ8pC2yy1TwA/oOWa4ATfXmrcDX0=;
        b=Abrt1LSyEJQYZHa7aphF/6zO0la+u6aGJ8VeMoIGPR31m9bqCWDc5342PvN/MgoaqV
         rWu3R/ACzJMU/4PS+nHGI8CyGEVNNWpase8bg2cgMo3746e4/hfJU1wwAvPb4SHM9Q9f
         htRvNWp6qOB0Y4TbCe+3wUdLuleQybjruO824rkVFRk+dZXFSw4+yR0EKjKhOt2myac7
         Me/tVL7UqDaqkEHH/qbmbYQvacZOWh0RM67lTB5GjyQFGY/W5cvw3wShwYshQJ6CRYNO
         EtpoGO1HDkCXSe6bFyTFNUZKEsjJsZcs7aMJEU2bNzOPZAzAp8Eprp9DIXgrpmQsAOVv
         Z44g==
X-Forwarded-Encrypted: i=1; AFNElJ81QjIHgnneSOAPyqoluXFBtP/K2ycJiHDhQpyFMwjcSEIJIEay0ooUyf7q6+lwsKSPF5Ag6V2bl/fIGChz8q9z@vger.kernel.org
X-Gm-Message-State: AOJu0YwdD8UruyzXEQeVSLNoJ/As2sr0F+yHNZj35G/rYO/nL1EoCPdY
	D4XwIyWW6vL/C8/X4UphDkj53iaC8krmRLNm9GRsvVXmyvu8+8C3iMufe0/yysYfK4Rcxi2TmcH
	2T+37GqkJeqIm/pihJ15KkogEmamiO0ziBkoaiq/A
X-Gm-Gg: Acq92OEqmYFiUhGsqZxhQ73FmXjhY4SrFB5fFrE/apDa3fdLSG5r9IdW3ZuXVPAIt/U
	BmFJ7mGHaXsi0YJky5bGUTcS3Q3eBy3my+X5M+9DZ0ldr8ytjKhIUA7ikZGGsYwGe5cprIXNEK9
	Gz9NMh1byTkAsDGP4sSR9Gje/IClKOn5mg770nji3wRVq83C2Z/72btJHGN6Nz4goJglDyEmd5X
	u+hYNGKG5+XjF7UXjnIjOx32Zap36/mQIr9kZonJc0RUtWM9QYp5KMzRD9C+KJ0tSi3kD2YVNpq
	bVvv8gUgjFmUhcBWzio4EJiLcDBZz4xfhRgbS0SuborW5wMs
X-Received: by 2002:a17:902:c952:b0:2bd:6dad:3df9 with SMTP id
 d9443c01a7336-2bdb36c6a4emr7479135ad.23.1779227225833; Tue, 19 May 2026
 14:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
 <agzXc--sXpLz0RNK@google.com>
In-Reply-To: <agzXc--sXpLz0RNK@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 May 2026 14:46:53 -0700
X-Gm-Features: AVHnY4J_NH_ufgGpbdGRJu-NXWJ8GpIVQwTtsBPhlZch99H_FuMGYGYim9tO7IA
Message-ID: <CAP-5=fXL1m71xLWdja4Xc6ja23yQmj7uTj_f4eUHj+2X1D9cSg@mail.gmail.com>
Subject: Re: [PATCH v13 00/32] perf tool: Add evsel to perf_sample
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 2:34=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, May 12, 2026 at 03:29:29PM -0700, Ian Rogers wrote:
> > Nearly all perf code ends up passing an evsel with the perf_sample,
> > which is problematic if you want to rewrite the evsel such as with
> > off-CPU processing - all uses of the evsel need fixing up. Previously
> > I'd mailed this patch as an RFC with everything combined:
> > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com=
/
> > and there was a request to break it up.
> >
> > v13: Rebase removing patches merged by Namhyung. Namhyung proposed
> >      changes that are in this series, but we became diverged. Address
> >      some minor Sashiko issues.
> >
> > v12: Add missing byteswap for tracepoint rawptr for dynamic
> >      offsets. Avoid some unsigned <0 compiler warnings.
> > https://lore.kernel.org/linux-perf-users/20260413041143.1736055-1-iroge=
rs@google.com/
> >
> > v11: Separate any remaining error path or other fixes out of
> >      refactoring the evsel into sample. Incorporate Sashiko
> >      feedback. Improve bounds checking for tracepoint data in
> >      samples. Incorporate changes from Namhyung.
> > https://lore.kernel.org/lkml/20260413012227.1089445-1-irogers@google.co=
m/
> >
> > v10: Changes to some of the bounds checks as prompted by Sashiko.
> > https://lore.kernel.org/linux-perf-users/20260412020833.641177-1-iroger=
s@google.com/
> >
> > v9: Clean up some error path nits caught by Sashiko and simple bound
> >     checks Sashiko recommended.
> > https://lore.kernel.org/linux-perf-users/20260411191710.524998-1-iroger=
s@google.com/
> >
> > v8: Fix address sanitizer issues with kwork and move patches, along
> >     with bound check additions, to end of series.
> > https://lore.kernel.org/linux-perf-users/20260411065718.372240-1-iroger=
s@google.com/
> >
> > v7: Separate out kwork work->name to a strdup into its own patch, now p=
atch 4.
> > https://lore.kernel.org/linux-perf-users/20260408072601.210837-1-iroger=
s@google.com/
> >
> > v6: Address more Sashiko feedback.
> > https://lore.kernel.org/lkml/20260404034325.3172592-1-irogers@google.co=
m/
> >
> > v5: Address feedback from Sashiko and Namhyung.
> > https://lore.kernel.org/lkml/20260403204017.2919994-1-irogers@google.co=
m/
> >
> > v4: Fix more sashiko issues: bounds checks, memory safety, making
> >     refactors better, inconsistent evsels, mmap2 buildid injection
> >     choice of evsel, mismatched function arguments.
> > https://sashiko.dev/#/patchset/20260320080835.724836-1-irogers%40google=
.com
> > https://lore.kernel.org/lkml/20260320192627.368357-1-irogers@google.com=
/
> >
> > v3: Fix various sashiko review comments particularly about unintended
> >     behavior changes.
> > https://lore.kernel.org/lkml/20260320080835.724836-1-irogers@google.com=
/
> >
> > v2: Add review feedback on the first 2 patches from Namhyung, fix a
> >     missed evsel assignment running event2evsel in builtin-inject.
> > https://lore.kernel.org/lkml/20260319232334.287517-1-irogers@google.com=
/
> >
> > v1: https://lore.kernel.org/lkml/20260209174032.4142096-1-irogers@googl=
e.com/
> >
> > Ian Rogers (32):
> >   perf tool: Remove evsel from tool APIs that pass the sample
> >   perf kvm: Don't pass evsel with sample
> >   perf evsel: Refactor evsel tracepoint sample accessors perf_sample
> >   perf trace: Don't pass evsel with sample
> >   perf callchain: Don't pass evsel and sample
> >   perf lock: Only pass sample to handlers
> >   perf hist: Remove evsel parameter from inc samples functions
> >   perf db-export: Remove evsel from struct export_sample
> >   perf hist: Remove evsel from struct hist_entry_iter
> >   perf report: Directly use sample->evsel to avoid computing from
> >     sample->id
> >   perf annotate: Don't pass evsel to add_sample
> >   perf inject: Don't pass evsel with sample
> >   perf kmem: Don't pass evsel with sample
> >   perf kwork: Don't pass evsel with sample
> >   perf sched: Don't pass evsel with sample
> >   perf timechart: Don't pass evsel with sample
> >   perf trace: Don't pass evsel with sample
> >   perf evlist: Try to avoid computing evsel from sample
> >   perf script: Don't pass evsel with sample
> >   perf s390-sample-raw: Don't pass evsel or its PMU with sample
> >   perf evsel: Don't pass evsel with sample
> >   perf lock: Constify trace_lock_handler variables
> >   perf lock: Avoid segv if event is missing a callchain
> >   perf timechart: Fix memory leaks
> >   perf kmem: Fix memory leaks on error path and when skipping
> >   perf synthetic-events: Bound check when synthesizing mmap2 and
> >     build_id events
> >   perf kmem: Add bounds checks to tracepoint read values
> >   perf sched: Bounds check CPU in sched switch events
> >   perf timechart: Bounds check CPU
> >   perf evsel: Add bounds checking to trace point raw data accessors
> >   perf kwork: Fix address sanitizer issues
> >   perf kwork: Fix memory management of kwork_work
>
> I have a few nitpicks but I think it's good to go.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks Namhyung, I'll rebase, address nits, and add your tag. I'll
keep an eye out in case Sashiko spots more issues, but we were pretty
clean so hopefully those things can be follow-ups.

Ian

> Thanks,
> Namhyung
>
> >
> >  tools/perf/builtin-annotate.c                 |  28 +-
> >  tools/perf/builtin-c2c.c                      |   6 +-
> >  tools/perf/builtin-diff.c                     |   5 +-
> >  tools/perf/builtin-inject.c                   |  75 +++---
> >  tools/perf/builtin-kmem.c                     |  95 ++++---
> >  tools/perf/builtin-kvm.c                      |  22 +-
> >  tools/perf/builtin-kwork.c                    | 253 +++++++++++-------
> >  tools/perf/builtin-lock.c                     | 128 +++++----
> >  tools/perf/builtin-mem.c                      |   1 -
> >  tools/perf/builtin-record.c                   |   3 +-
> >  tools/perf/builtin-report.c                   |  38 ++-
> >  tools/perf/builtin-sched.c                    | 198 +++++++-------
> >  tools/perf/builtin-script.c                   |  22 +-
> >  tools/perf/builtin-timechart.c                | 170 +++++++-----
> >  tools/perf/builtin-top.c                      |  19 +-
> >  tools/perf/builtin-trace.c                    | 121 +++++----
> >  tools/perf/tests/hists_cumulate.c             |   1 -
> >  tools/perf/tests/hists_filter.c               |   1 -
> >  tools/perf/tests/hists_output.c               |   1 -
> >  tools/perf/tests/mmap-basic.c                 |   4 +-
> >  tools/perf/tests/openat-syscall-tp-fields.c   |   2 +-
> >  tools/perf/tests/switch-tracking.c            |   9 +-
> >  tools/perf/util/annotate.c                    |  19 +-
> >  tools/perf/util/annotate.h                    |   6 +-
> >  tools/perf/util/bpf_kwork.c                   |  14 +-
> >  tools/perf/util/build-id.c                    |   3 +-
> >  tools/perf/util/build-id.h                    |   7 +-
> >  tools/perf/util/callchain.c                   |   8 +-
> >  tools/perf/util/callchain.h                   |   6 +-
> >  tools/perf/util/data-convert-bt.c             |   2 +-
> >  tools/perf/util/data-convert-json.c           |   5 +-
> >  tools/perf/util/db-export.c                   |  13 +-
> >  tools/perf/util/db-export.h                   |   3 +-
> >  tools/perf/util/evsel.c                       | 137 +++++++---
> >  tools/perf/util/evsel.h                       |  12 +-
> >  tools/perf/util/hist.c                        |  26 +-
> >  tools/perf/util/hist.h                        |   3 +-
> >  tools/perf/util/intel-pt.c                    |   2 +-
> >  tools/perf/util/intel-tpebs.c                 |   3 +-
> >  tools/perf/util/jitdump.c                     |   2 +-
> >  .../perf/util/kvm-stat-arch/kvm-stat-arm64.c  |  19 +-
> >  .../util/kvm-stat-arch/kvm-stat-loongarch.c   |  17 +-
> >  .../util/kvm-stat-arch/kvm-stat-powerpc.c     |  17 +-
> >  .../perf/util/kvm-stat-arch/kvm-stat-riscv.c  |  17 +-
> >  tools/perf/util/kvm-stat-arch/kvm-stat-s390.c |  20 +-
> >  tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  |  70 ++---
> >  tools/perf/util/kvm-stat.c                    |  19 +-
> >  tools/perf/util/kvm-stat.h                    |  18 +-
> >  tools/perf/util/kwork.h                       |  11 +-
> >  tools/perf/util/machine.c                     |  14 +-
> >  tools/perf/util/machine.h                     |   3 -
> >  tools/perf/util/s390-sample-raw.c             |  31 ++-
> >  .../util/scripting-engines/trace-event-perl.c |  23 +-
> >  .../scripting-engines/trace-event-python.c    |  47 ++--
> >  tools/perf/util/session.c                     |  38 +--
> >  tools/perf/util/synthetic-events.c            |  49 ++--
> >  tools/perf/util/synthetic-events.h            |   2 -
> >  tools/perf/util/tool.c                        |   4 +-
> >  tools/perf/util/tool.h                        |   4 +-
> >  tools/perf/util/trace-event-scripting.c       |   5 +-
> >  tools/perf/util/trace-event.h                 |   3 -
> >  61 files changed, 991 insertions(+), 913 deletions(-)
> >
> > --
> > 2.54.0.563.g4f69b47b94-goog
> >

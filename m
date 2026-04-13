Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8E1A683E
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776041593; cv=pass; b=TbOokfUypUDRmr+/7brWB2uyn9FqB0EBroqlOPmNiPuQZXlaFa1/jDuM2NiQrRXzr+AAkbVCq5nrff2ZByXWsy4IQcej/YHu4z/svhqYZcqJTwbDM8xXgniWgblN01kUQ+huQL6Z7PdAuBZcymh7hJSgArLI9Q2aWjDFQaStDRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776041593; c=relaxed/simple;
	bh=sTJQtoOdWQ22s3iqqG5lOcq303a2PfEk3ajiGlcaoVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkjbknNxxTyY2TAWNagNzX0TerD9T4aXNiv3C9SD19wM++9yLIuZ5faCac9RY0LLaOpuUtqS3dZDkRTZjT0gFlJfuZz4CnyIfZaaPN3wjb0HnAGJ4okF2y8f9Lwin4p3HRUvwiHCY88jLZpZPMWKUD1fikNY+x849f2vxi9wQDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GzKIX9Ag; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzKIX9Ag"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b243198058so315335ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 17:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776041590; cv=none;
        d=google.com; s=arc-20240605;
        b=JoiZYcnpXhv5QKa2r7XRgIeIASuLLTCnpIcRQUnamF+m/lUfAKb0JqoRitHRFOZUfG
         bYm2NIcMbK9JBYcWV07Y+kyh5T1ZpSIzSF6Mho4e2piHJK4Oj1kPl8mhCCqlU/YPIMbF
         tjnVjvtA84PA6z9AUy8VfZwDJmj8t1hIcHIiTgY7yah5cCkTDsCPz9Q2+lXtBlxW8lYF
         yj4ozWY0h2D0LxYZUKt6l30mz/hZFlW6kjIu2nzV6k93o4Toq1cPNWN9LiVgKp3CqBm3
         NjdVFKZN+mzXSNbOZw4QCCOVOPSsES5VwGUHaC+2fVcYE3eh4xESraC4c9hdDLNqKb3b
         9IXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tCfTa/kIecow9i8RfZ6SZ9Ua00NsSDKMxq/2R2ivOuY=;
        fh=swt3hYLECSV6OhG/UJR85voMXwlY6RCmtPD+YsDiJHY=;
        b=hmR2MNdvsJzcUgIxVlzgZoqTXIVCZwumIlfOMHbudHhMqopnAVG/aWtCfCt+qXo28l
         AgJdLhbEeMR4z2+ZNpvdFqODqH0HtMw5/8l8MrWcfEOQMPiUcJ7PTiB5YiuMrYHLrn8F
         lTbY8AKuOQqOON1lznYXshE6tT145I2iZEnYfwQ+iGXs2fWpVyydTZFh7kcW/7X4DjbP
         5FaqZvmgJMger/u3RJDP+XsPrSfM3VrWCrvFsD8ph16wNUA2JOvRy7u+qlHd4knWK+m4
         MQ3NIrSJl9zHgpqF53beXetIJ4AGB+brTiYLFmzGFtCe1QaDWRlSyKQzQDp6Wq3EDufG
         /d/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776041590; x=1776646390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCfTa/kIecow9i8RfZ6SZ9Ua00NsSDKMxq/2R2ivOuY=;
        b=GzKIX9AgCRy91txSjIqgaoeen/WERprqqOYCAky3PHWVitDz/LouDTHuXWQfn9FEcd
         KsjevQsa4czvrvs6NnPi+yqtYgSO3c4kmsS/zJyjt8nnhXnO7uhOAP6eP61rSTfGqsRs
         bKvJf3in2DztVd6B3SzddGbi9KwE0UsJKGhg54DaQQKc32TQjkcTKbuQl0s13HPBkXw/
         SD/dkmBLviwHc4DfBiqXCR9LSPVyXQhtdSiUEZ2OMe8BPjSm/IlXwO+erp9iaunsuJuH
         mMlsuyBaTeZY8gBaLF+35WXCMBnT5X4snJZsOkPHrHJZNNZIs9quExXP2cO2MMh4bzLO
         vQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776041590; x=1776646390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tCfTa/kIecow9i8RfZ6SZ9Ua00NsSDKMxq/2R2ivOuY=;
        b=PnoVZ5P036Y1KobYlCBzJJNz2WZIOCZ4eUgsKRPwvahqE5bA0Ku/dC5zR/qL7bpx0/
         WO989BullYVn4hcoRNtpvUSXMCGPW27M1UWgHg48XB8/bGVidDaFFmvN4A9hrbzTgqAE
         6ykCO1fBATbv269wv2FZ72F1IB+HBuy02eyem3DKDRQCoRN2xBUzeXTj/CVsz4ptumWh
         QNev9e9SrWsT9q4AQ810gnqDhMNFfCZxuBhgPWQqL7du+nF6aZYE6BqELPv9f0vOx2Yb
         jEcVNdSmD1uOXyp6iDjfYO6LA8RuaSemmp60ow8tZZhcsV8rKpFrnNP7IPSuGxIlGyEz
         3nsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Z5ptZu3kwOgdCBsiFTFviwGt6SgMjTtjUhzRfMl1weUJc9bomhYBl2RlaGV+btORQfPJzQmP19Z4sc004EN8b@vger.kernel.org
X-Gm-Message-State: AOJu0YznGy0Me+9v8guA2YNOc8RWIL9ItPJ4wEdG0DhzlNlmnOmA1lOA
	P/0ZEnWnNFL8tpsfGmKy1IdsRZtHk4omDNk9ffoyKU5nG6YELqjNYGWdiSrmcNB61bF4NyH1/mA
	Uig0RG62R0ChAohXRuekFU4AHsYRDZ9voQEakA3cu
X-Gm-Gg: AeBDietzM1iIXx/CdREIxMSI9ZH6D8siGVoXf3Vrr/JUHgrw8RpUzC4szwjfvozYvlf
	2aZc3GxZJ6y8Mmx5MYSguwYBF3ojvLX0ewUPEbZxYuxpbu8cllPeI6unCOohtOlYBUvQQXwLLJV
	6B/UU8U2u6rFiihJIeta/+GKx4GwIZuv11v6j9jJ7PC6qyFFzGd1bgmL3tLkyjY7vsdR5IPAyT+
	/x80BhVCyxIapHKvGDyiz+eeWoI+3EYtNcef8DVTUvJnDirXXchk4Hz5aOkntYpf3sNu9VcuWok
	J+odt4jqVBY8X4Mo5Rg=
X-Received: by 2002:a17:903:2c0f:b0:2b2:5931:5950 with SMTP id
 d9443c01a7336-2b2c7a85420mr11552395ad.16.1776041589250; Sun, 12 Apr 2026
 17:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
 <adv8Ka16pvgVkm8R@google.com>
In-Reply-To: <adv8Ka16pvgVkm8R@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 12 Apr 2026 17:52:57 -0700
X-Gm-Features: AQROBzDdMHImxaEMiu7tBoHZ-hxSGp8_U3t6lQyq9L3hCyu5LfZybhsXc0gGgzA
Message-ID: <CAP-5=fVc-Ac09cnXYPUVcNwzHOqFod0v=-YjjDf_oVHvM7cHDw@mail.gmail.com>
Subject: Re: [PATCH v10 00/29] perf tool: Add evsel to perf_sample
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

On Sun, Apr 12, 2026 at 1:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Sat, Apr 11, 2026 at 07:08:03PM -0700, Ian Rogers wrote:
> > Nearly all perf code ends up passing an evsel with the perf_sample,
> > which is problematic if you want to rewrite the evsel such as with
> > off-CPU processing - all uses of the evsel need fixing up. Previously
> > I'd mailed this patch as an RFC with everything combined:
> > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com=
/
> > and there was a request to break it up.
> >
> > v10: Changes to some of the bounds checks as prompted by Sashiko.
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
> > Ian Rogers (29):
> >   perf sample: Fix documentation typo
> >   perf tool: Remove evsel from tool APIs that pass the sample
> >   perf kvm: Don't pass evsel with sample
> >   perf evsel: Refactor evsel tracepoint sample accessors perf_sample
> >   perf trace: Don't pass evsel with sample
> >   perf callchain: Don't pass evsel and sample
> >   perf lock: Only pass sample to handlers
> >   perf lock: Constify trace_lock_handler variables
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
> >   perf kmem: Add bounds checks to tracepoint read values
> >   perf sched: Bounds check CPU in sched switch events
> >   perf timechart: Bounds check CPU
> >   perf evsel: Add bounds checking to trace point raw data accessors
> >   perf kwork: Fix address sanitizer issues
> >   perf kwork: Fix memory management of kwork_work
>
> I've picked the first 23 patches to tmp.perf-tools-next as the rest
> still has some issues.  Also I've touched some commits to either remove
> some parts or split them into separate commits.
>
> Please take a look.

Hi Namhyung,

thanks for doing this but I've done a similar clean up. To totally
separate the evsel refactoring from the rest of the changes, to fix
the address sanitizer issues with kwork, etc. I'll incorporate your
changes and then resend the series.

Thanks,
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
> >  tools/perf/builtin-sched.c                    | 188 ++++++-------
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
> >  tools/perf/util/evsel.c                       |  94 ++++---
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
> >  tools/perf/util/sample.h                      |   2 +-
> >  .../util/scripting-engines/trace-event-perl.c |  23 +-
> >  .../scripting-engines/trace-event-python.c    |  47 ++--
> >  tools/perf/util/session.c                     |  38 +--
> >  tools/perf/util/synthetic-events.c            |  68 +++--
> >  tools/perf/util/synthetic-events.h            |   2 -
> >  tools/perf/util/tool.c                        |   4 +-
> >  tools/perf/util/tool.h                        |   4 +-
> >  tools/perf/util/trace-event-scripting.c       |   5 +-
> >  tools/perf/util/trace-event.h                 |   3 -
> >  62 files changed, 967 insertions(+), 905 deletions(-)
> >
> > --
> > 2.53.0.1213.gd9a14994de-goog
> >

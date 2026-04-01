Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE0329C48
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775023063; cv=pass; b=McjcuznlqhqV9qIk3Tgm3hqLhJStPO+pE6+0tEUtp2F0wGM5jCMC0bnppkI7QLkgU0K6+sQgwb7vxONpOMgC1jKIX1ouaPFx0kNhFaFow0L/GftXZwdME3h6lZPL3hbDHouN5guRnIbWAA7sZBQG22gYl1KDDUC/Wvdw4WQgA64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775023063; c=relaxed/simple;
	bh=dZtZKpfuwvpe9rCVzh3e+v3mhe0aeVGdKmeWlgYBAbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CscLf2nNXqfkbkgchvnaAN0oyzujaYNuYIyaVjx+Q5T3CrHvojMq/AjTirLzNlaX1qtfbQVh8aPiZwxlSY/WPYD4pLmM0FUEQajDXxPhl0jPhrk/TXU4OPNUVhjqgMfncWtF4YAxm8JHFTQuD0yT4SF/FNbrzPQmjqkGdtTuSYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UP3yZD74; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UP3yZD74"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b243198058so153565ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775023061; cv=none;
        d=google.com; s=arc-20240605;
        b=eaghn7OjK8FQw6igdYjIPq2spG9mkWEFzkrO89HERzze/DZoGc3GCLJBeddGhXn59g
         4uEOzcgGuW7vjaNpX49HGWkCmno3eyhfNg6RLtq66atYfUNtKwXb5D59XV7HCIr7UxhU
         JWu/3RDxP2quJwv//HoaQwDxxXrkrvxBQysNskvcDrxx1H18eP2+NyU3p1w95Atetn1p
         S04caolmU9NAq2F1UpGhKn/tmmmEr8+FYab+kjWVRI4Jl5x/ak56Ck8FuFqgzL/YmpRN
         Nb6wBKxnKLpCnyK3BwAEDCOCrrNw8QIfQuSrjtuZVhmqTa+cTmdfhP2MkyfKQK7rXblC
         h8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F4D74rEvTfOa7wHEJPKPTdSdwxlH64Vyw3tWj8oq9Lk=;
        fh=eMov+TC6bO9dv8WkrNDveLc86wuEIOA+Fgh1zsh3u6c=;
        b=g/gepHa6t/ZSQu9s79WSo9jIFks7UtqdnhiI1bRZTzpXPYXVq05QZ8zF09c4qbe6s3
         aEmbeT50mrRoHomLIzoMQ45snprT56VQJeHCYdgUbNDExX2iXoiEIgWvhLMSyekkfECg
         y0ST+asNal9uSzXvP84Ze7qd6tA47DLvC/coKwfmm84ubYILSzKZqcIHnv3u8Bafq7up
         P6cXFeU6TXJ4VJB278RJy/wtJD8Z+8XwTpv+XEgnCI3V3hs3wSvr1VyEPe1etftPxNq7
         03TXRSvfivUp8OnaI82JPReu+uI2RFc7boIuQtZe30M7faN8pNTpIWhvTQeSLpigZpA5
         QNHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775023061; x=1775627861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4D74rEvTfOa7wHEJPKPTdSdwxlH64Vyw3tWj8oq9Lk=;
        b=UP3yZD74smytZ9aI6FLOG8ze1y5iztFXPorrQIxSWWxVT3Zi5y1UvHHXWnGlDjfrOE
         ZZ++cA+UMVQb33x4cBaTLGtgmdZXchNkw4boo+T5XMaiAxZ5FWSR0PY0KwgeaJe9Dxh0
         90Pm+B1D+P3z2ZMbpUDtFBrqvh/H5b+xx6EKD/2VVsFkIT3OCiYvtxkaEuZc5lZvdqNh
         5XrOykunF5DB7i1KPLuD5zat19d973D7cpCysF8fAEETc0occzaBwMV5Hr7RSPlpGs0P
         fMpqlO7YzmsvSOqdv7yUc/TXmgcNFk0AL6CrZvi8A7ayGn3il2EwtCmJHkjZYYcmX9rR
         loQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775023061; x=1775627861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F4D74rEvTfOa7wHEJPKPTdSdwxlH64Vyw3tWj8oq9Lk=;
        b=Rs24XTHmQaKG8Zcy5PnxrRyjXoZ7IvvYSaFT78mQR3s9S25ediFNd5jTYKBKH6+IXY
         p9x8nfbD5IuFyQUwQMBxBYVPArSqD64eGqcE0thITfAOO124ff+D+ifXxPqMzluv5B+6
         GKSSSLK617HtUPjVf1D4/kdIB4jH8C9RnnLK0KNo6ZxsjUEXIM3rpAFBJXYrTLYXqLA+
         FgaoVJ9StYCQJsFolLRgCreIOLhFr6dqQzF9NAqrENCyZk9Kt6cWAPhpsN3IWW8JPg2b
         hVwH91/Su6PHSE9lLM+4hBl/+JKdpoxw6tOk3Qu8ASa9/qmx1io90l65a1hqys6LBbfH
         I7aA==
X-Forwarded-Encrypted: i=1; AJvYcCXuvyMBAUQE+zPilcDb1JxSYqcJolpcudcodsM4xcr7W2dPug+/+/t6Lb4ZmJko3MtFjkizcn6W9aHnK6OHrbA2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmp77pn9F81511HlybliE3xqlb3vk/runJtFOj4g+oKVQdzHFI
	Dux3MnNp/S1Bp0ToaXxPJcwMblAHg1B4K7znmh8HNI+hMEauHJb+7tYVdDfjTAl7mQySeLQtcRD
	XPUBEHYXzjQfonXHYixVbh0TZ+SXRg0089TmqAk37rggGCGb4LAtOH4seDw4=
X-Gm-Gg: ATEYQzwGo1VV9G6h1xgbOjIqrQ8GJgxZvhMgDw1VUU7Hebx+Ow8zsj9nrZsPyub0uqu
	sa7QHhnzD0O+cffM5ualrxlGC6dJ4Ee2jzhQNcjsg4VBgUPJto2VgN3F9yVHet8s/MDog+Cdrd6
	n/rB1iR4T53tC8GCe4iQdFxOGmfWaEvwwfSujoEfg8Hrxy1/HSEVsDbzm7uMD/VWdmYRUhVJSiG
	FlNvVcWYjmsusv+4i5jcHAOLd8IrH/n211tBscgAc1pqZwc3/AhwcSL8sfomuSLwe2WBZ+r3nS0
	SZ9N1Jul
X-Received: by 2002:a17:902:f711:b0:2a9:5ef5:399b with SMTP id
 d9443c01a7336-2b26b2dc7f2mr1482655ad.19.1775023060680; Tue, 31 Mar 2026
 22:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 22:57:28 -0700
X-Gm-Features: AQROBzBcerRbqQEHIFtgX6ylx2_7WYrt7Y4hFxvpemXp6xLE-QIK5-i3xwye5ks
Message-ID: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] perf tool: Add evsel to perf_sample
To: namhyung@kernel.org
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

On Fri, Mar 20, 2026 at 12:27=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Nearly all perf code ends up passing an evsel with the perf_sample,
> which is problematic if you want to rewrite the evsel such as with
> off-CPU processing - all uses of the evsel need fixing up. Previously
> I'd mailed this patch as an RFC with everything combined:
> https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
> and there was a request to break it up.
>
> I've started the series by adding documentation to struct
> perf_sample. Next I fixed missing perf_sample__init/exit largely from
> the recent perf inject callchain rewriting work. The 3rd patch adds
> the evsel to struct perf_sample and ensures it is correctly
> initialized. The next 22 patches avoid passing the evsel along with
> sample for different parts of the perf tool, along with some minor
> tweaks like constification and not determining the evsel if it is
> present in the sample.
>
> v4: Fix more sashiko issues: bounds checks, memory safety, making
>     refactors better, inconsistent evsels, mmap2 buildid injection
>     choice of evsel, mismatched function arguments.
> https://sashiko.dev/#/patchset/20260320080835.724836-1-irogers%40google.c=
om
>
> v3: Fix various sashiko review comments particularly about unintended
>     behavior changes.
> https://lore.kernel.org/lkml/20260320080835.724836-1-irogers@google.com/
>
> v2: Add review feedback on the first 2 patches from Namhyung, fix a
>     missed evsel assignment running event2evsel in builtin-inject.
> https://lore.kernel.org/lkml/20260319232334.287517-1-irogers@google.com/
>
> v1: https://lore.kernel.org/lkml/20260209174032.4142096-1-irogers@google.=
com/
>
> Ian Rogers (25):
>   perf sample: Document struct perf_sample
>   perf sample: Make sure perf_sample__init/exit are used
>   perf sample: Add evsel to struct perf_sample
>   perf tool: Remove evsel from tool APIs that pass the sample
>   perf kvm: Don't pass evsel with sample
>   perf evsel: Refactor evsel__intval to perf_sample__intval
>   perf trace: Don't pass evsel with sample
>   perf callchain: Don't pass evsel and sample
>   perf lock: Only pass sample to handlers
>   perf lock: Constify trace_lock_handler variables
>   perf hist: Remove evsel parameter from inc samples functions
>   perf db-export: Remove evsel from struct export_sample
>   perf hist: Remove evsel from struct hist_entry_iter
>   perf report: Directly use sample->evsel to avoid computing from
>     sample->id
>   perf annotate: Don't pass evsel to add_sample
>   perf inject: Don't pass evsel with sample
>   perf kmem: Don't pass evsel with sample
>   perf kwork: Don't pass evsel with sample
>   perf sched: Don't pass evsel with sample
>   perf timechart: Don't pass evsel with sample
>   perf trace: Don't pass evsel with sample
>   perf evlist: Try to avoid computing evsel from sample
>   perf script: Don't pass evsel with sample
>   perf s390-sample-raw: Don't pass evsel or its PMU with sample
>   perf evsel: Don't pass evsel with sample

Ping.

Thanks,
Ian

>  tools/perf/builtin-annotate.c                 |  28 ++-
>  tools/perf/builtin-c2c.c                      |   6 +-
>  tools/perf/builtin-diff.c                     |   5 +-
>  tools/perf/builtin-inject.c                   |  87 ++++----
>  tools/perf/builtin-kmem.c                     |  85 ++++----
>  tools/perf/builtin-kvm.c                      |  22 +-
>  tools/perf/builtin-kwork.c                    | 104 ++++------
>  tools/perf/builtin-lock.c                     | 117 +++++------
>  tools/perf/builtin-mem.c                      |   1 -
>  tools/perf/builtin-record.c                   |   3 +-
>  tools/perf/builtin-report.c                   |  38 ++--
>  tools/perf/builtin-sched.c                    | 188 ++++++++----------
>  tools/perf/builtin-script.c                   |  26 ++-
>  tools/perf/builtin-timechart.c                | 145 +++++++-------
>  tools/perf/builtin-top.c                      |  19 +-
>  tools/perf/builtin-trace.c                    | 120 +++++------
>  tools/perf/tests/hists_cumulate.c             |   3 +-
>  tools/perf/tests/hists_filter.c               |   2 +-
>  tools/perf/tests/hists_output.c               |   3 +-
>  tools/perf/tests/mmap-basic.c                 |   4 +-
>  tools/perf/tests/openat-syscall-tp-fields.c   |   2 +-
>  tools/perf/tests/perf-record.c                |   1 +
>  tools/perf/tests/switch-tracking.c            |  11 +-
>  tools/perf/util/annotate.c                    |  19 +-
>  tools/perf/util/annotate.h                    |   6 +-
>  tools/perf/util/build-id.c                    |   3 +-
>  tools/perf/util/build-id.h                    |   7 +-
>  tools/perf/util/callchain.c                   |  18 +-
>  tools/perf/util/callchain.h                   |   5 +-
>  tools/perf/util/data-convert-bt.c             |   2 +-
>  tools/perf/util/data-convert-json.c           |   5 +-
>  tools/perf/util/db-export.c                   |  13 +-
>  tools/perf/util/db-export.h                   |   3 +-
>  tools/perf/util/evlist.c                      |   5 +-
>  tools/perf/util/evsel.c                       | 101 +++++++---
>  tools/perf/util/evsel.h                       |  12 +-
>  tools/perf/util/hist.c                        |  26 +--
>  tools/perf/util/hist.h                        |   3 +-
>  tools/perf/util/intel-pt.c                    |   2 +-
>  tools/perf/util/intel-tpebs.c                 |   3 +-
>  tools/perf/util/jitdump.c                     |   2 +-
>  .../perf/util/kvm-stat-arch/kvm-stat-arm64.c  |  19 +-
>  .../util/kvm-stat-arch/kvm-stat-loongarch.c   |  17 +-
>  .../util/kvm-stat-arch/kvm-stat-powerpc.c     |  17 +-
>  .../perf/util/kvm-stat-arch/kvm-stat-riscv.c  |  17 +-
>  tools/perf/util/kvm-stat-arch/kvm-stat-s390.c |  20 +-
>  tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  |  70 +++----
>  tools/perf/util/kvm-stat.c                    |  19 +-
>  tools/perf/util/kvm-stat.h                    |  18 +-
>  tools/perf/util/kwork.h                       |   9 +-
>  tools/perf/util/machine.c                     |  14 +-
>  tools/perf/util/machine.h                     |   3 -
>  tools/perf/util/powerpc-vpadtl.c              |  10 +-
>  tools/perf/util/s390-sample-raw.c             |  31 +--
>  tools/perf/util/sample.c                      |  11 +-
>  tools/perf/util/sample.h                      | 119 ++++++++++-
>  .../util/scripting-engines/trace-event-perl.c |  23 +--
>  .../scripting-engines/trace-event-python.c    |  47 ++---
>  tools/perf/util/session.c                     |  74 ++++---
>  tools/perf/util/synthetic-events.c            |  45 +++--
>  tools/perf/util/synthetic-events.h            |   2 -
>  tools/perf/util/tool.c                        |   4 +-
>  tools/perf/util/tool.h                        |   4 +-
>  tools/perf/util/trace-event-scripting.c       |   5 +-
>  tools/perf/util/trace-event.h                 |   3 -
>  65 files changed, 973 insertions(+), 883 deletions(-)
>
> --
> 2.53.0.959.g497ff81fa9-goog
>

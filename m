Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2933F23DD
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Mar 2026 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474229; cv=pass; b=bJ9ZH5u9xxDvfuzm4FFMauj9d/YQOqnYJhnA7B4O92DNRGfXXQBO0ArFCIvcBXL5Cx8UnLLxHxfSXCBQn3Qfd1UtlfmWVdRmHVR4Nvz6696eX2azY1Cpp8eHm/tdl1ZAhZH9mzmrIExm/f7kekjX/vi+fzBhleQV8HAXCfkpCEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474229; c=relaxed/simple;
	bh=S2O4FoObF7r0RW4UqbcprXgbXZNd9gzi/O9UqqQ5wWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DecDUv6pe/SSW2ktggN3wpijeCiBZtvl1zQq/WedyXKX2WE8pwAovnEvo56vOXvF4XUqjmYsRbaxKQRAe+b6EFbrM55PyMbMLk0ojGq6sodHVdpdPKP4Ct9DjgpqJD6CvwTYFxH/Ns4KqaUvf+zYM5R23o6F5ZdVEHSWkYoQvy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pisSCMTB; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pisSCMTB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae4b40999bso1065ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Mar 2026 09:57:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772474227; cv=none;
        d=google.com; s=arc-20240605;
        b=ZBP6SY7IUGVnHqr0wW/VB+61z7NBBDALnNtUNJt1QpoAd7pHKd/3pDCXv68hAWHX2J
         5TaIz3mrEZjgp/7uK0+sdey/Tsfn7OxYzk4s/Ka0hGRFhoim1MjlnE1Zqgyt15X5VIAL
         WGsjXZFqcmVF9x7FhqtKk0nM1Drtm3CC8ZRYYtYwgojaUfc0VjC9GSefGHkyhKkhkPYB
         XB9dbpsdkM252kYd70Qriu4Lif/FXQiwXbvVL87dPQYP3g2y/0o6zkKo2ZEXQwrxpQbJ
         p4o6f4gjfLi8naXKSKczI8Y7dcesKlt6Ch7m1fERUiqMeKH/O0aHz/xh8OpT5xNNAuo6
         i2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qjiTdHnryEOGMyadmx1iBFg/rzS0x8eg7lM/zS2Q+mM=;
        fh=O7jtROlW0dQp0OQadRXFyjKnJB6EIEfvTORzLrOayAI=;
        b=BOLHBowMUgWiprHKGF3FYqC9sv2HZtTc6dxHNe/sEC6tKev88yWDjrdFkTgcW0IO5M
         LrBRgiknu2rN5mSOZdRUqGmqlxEd+ascPB2Pb+VEdXc0SsC0HSMIK8Gt2Xqe+h+/RCvP
         iwaaoSYKV/CuSHpkjR8BUrc8kIFUjXU47ksoy6bBGO7XN+pPgq4tyWVpjm/tpiiRU6CG
         8HsO1BDo/DNa/Oc1Zr7x5nSLXaYt0TOC0/RIqlvEYiZHD5xNGCPrzKvl05TG0gIbfV+q
         EgF+fVZDh7UBWoi5V4zML8WSzKItswaHAOKw1lbFM6mX43nOXszqbYOovniUEo8DbjFv
         frhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772474227; x=1773079027; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjiTdHnryEOGMyadmx1iBFg/rzS0x8eg7lM/zS2Q+mM=;
        b=pisSCMTBudBZ6Xv756X1QpWU8UvbBUSLgb19Ot6zA8Spza00aYJqmo59Nxg4BmH8s8
         VzzsTNKtxiJjpM4kMo4g1HWpennzhyhRNcHZsqY2GL1cRqAMFlt4+McZSo80pW7Zj/jm
         KlDLT0AvDZAp6R7+dD5PowSpX/tNpWDaOGNwJigUdVcsuJVq1TKl4LIoLE5N96U+Ob4s
         W6jrMCVV2FVpKyj0izKeuEBlK7RPQtDvuXzy2lPfGsjHy5Nueb4G24KhxTJP5zCDgXwf
         D9mqc+Tf847GdDvsqqj5CPLsQMDd+2FNApBZOPHqf/Yasu74zH6OkvsD9neEhMhIo1wY
         xTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772474227; x=1773079027;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qjiTdHnryEOGMyadmx1iBFg/rzS0x8eg7lM/zS2Q+mM=;
        b=baPnnRxFARnG3bi/oDtO2G6GbVFh6pP2G/gsVRkMFgMhynJFzilSt7zSHM+AlUi/DU
         Y2dZy0/XJOwSlv7w5AHQLHADpCDYDytqCQ36zC4tqps4nYATlBsHD4sgDUxFIquEJAYK
         +w4Em+WyC8JejwkaOVHfymRgst0eU4lmiiSqqZTY1HDlQ6DHzAQs9e+Xc5SlSYlKVfp5
         VQ/N7tFTVZMFn7C7M8un8qlsfD4ZlDxV76QpVAhWhTi+Lh/TUlq1I+c7keSznGRX/1cv
         +DM37upUSdhMKFOPGB12nMfldwE8kWc2axaJTkEaO2iO0jFQCuljvmT5fhkC/UlMhKR+
         ur2g==
X-Forwarded-Encrypted: i=1; AJvYcCVK5dfKiLCrl90c80BzgijdkUOKm/bAUN2QoVDpDxAJB9qgdgEZ2OHwfUas2xLeyvF/42NNimHEDA6k4zj2uHMG@vger.kernel.org
X-Gm-Message-State: AOJu0YyQL7y8Sa44igHdc7otKMgrVFq3tM0BoGIKhq7wOREmC3sDu5Fd
	QPU9JzhGu3DaQEv+no8+zSYrgptvTiC4HihtuhR/1BpfQii31pDyXDgauC/l7N3TXbrwyQLMZ9C
	lqIiVEIcXDtHFwcqOmJW91wgLATyD9jJnpYVbfSdC
X-Gm-Gg: ATEYQzxBfHgn8avsCsrhqDT6UY2KpXlXa2RsJrgO9rigmdw3udZSTp2QIO5OhIA3h5o
	mrg6nM2z9GFT9oDQW5Lce6NMMhuYu9BtXSg8PcxluNnp9pkGD0W3YEoDXKqSlD9cG8h7S8w4hnZ
	QTPJFC+SEKmy5Gr0Z7o9nSyoXxbJtNtAATeA2D9XzV3NV33TnR3YGH5kxxOJzZlEzz1hrJA2/tS
	B7R2RwxtX81Yw7LCUnO+aQHMP/8BzzzG8q91LLEXpuBKWrRAhqBCVjwcvC39Tc5SIwqdM79Q3Vv
	iDUhP+Dp/AGvAwgRH/HpAWDi6/eoI6wP1Xich0nzO/M+cEs=
X-Received: by 2002:a17:903:3848:b0:2a0:89b0:71d7 with SMTP id
 d9443c01a7336-2ae3b50ac0dmr4007265ad.13.1772474226685; Mon, 02 Mar 2026
 09:57:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <CAP-5=fVaEfuM0_YXwX4tgFfiPTX1i_BkTKhYvGqnpZ2d_Cb6+w@mail.gmail.com>
In-Reply-To: <CAP-5=fVaEfuM0_YXwX4tgFfiPTX1i_BkTKhYvGqnpZ2d_Cb6+w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Mar 2026 09:56:54 -0800
X-Gm-Features: AaiRm50EDgmyTQhh6v5T3rKbw4ww2UACNptEVBRvtLDhpXubGXAhtBuSQMIsmwg
Message-ID: <CAP-5=fXebrVQoGyToo20cuAoFXi65NinbqJhhSdu9EUU0V3ETQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/25] perf tool: Add evsel to perf_sample
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Chen Ni <nichen@iscas.ac.cn>, 
	Blake Jones <blakejones@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 11:15=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Feb 9, 2026 at 9:40=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Nearly all perf code ends up passing an evsel with the perf_sample,
> > which is problematic if you want to rewrite the evsel such as with
> > off-CPU processing - all uses of the evsel need fixing up. Previously
> > I'd mailed this patch as an RFC with everything combined:
> > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com=
/
> > and there was a request to break it up.
> >
> > I've started the series by adding documentation to struct
> > perf_sample. Next I fixed missing perf_sample__init/exit largely from
> > the recent perf inject callchain rewriting work. The 3rd patch adds
> > the evsel to struct perf_sample and ensures it is correctly
> > initialized. The next 22 patches avoid passing the evsel along with
> > sample for different parts of the perf tool, along with some minor
> > tweaks like constification and not determining the evsel if it is
> > present in the sample.
>
> Ping.

Ping.

Thanks,
Ian

> > Ian Rogers (25):
> >   perf sample: Document struct perf_sample
> >   perf sample: Make sure perf_sample__init/exit are used
> >   perf sample: Add evsel to struct perf_sample
> >   perf tool: Remove evsel from tool APIs that pass the sample
> >   perf kvm: Don't pass evsel with sample
> >   perf evsel: Refactor evsel__intval to perf_sample__intval
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
> >   perf s390-sample-raw: Don't pass evsel with sample
> >   perf evsel: Don't pass evsel with sample
> >
> >  tools/perf/builtin-annotate.c                 |  28 ++-
> >  tools/perf/builtin-c2c.c                      |   6 +-
> >  tools/perf/builtin-diff.c                     |   5 +-
> >  tools/perf/builtin-inject.c                   |  81 ++++----
> >  tools/perf/builtin-kmem.c                     |  58 +++---
> >  tools/perf/builtin-kvm.c                      |  22 +--
> >  tools/perf/builtin-kwork.c                    | 104 ++++------
> >  tools/perf/builtin-lock.c                     | 117 +++++------
> >  tools/perf/builtin-mem.c                      |   1 -
> >  tools/perf/builtin-record.c                   |   3 +-
> >  tools/perf/builtin-report.c                   |  38 ++--
> >  tools/perf/builtin-sched.c                    | 183 ++++++++----------
> >  tools/perf/builtin-script.c                   |  26 ++-
> >  tools/perf/builtin-timechart.c                |  76 +++-----
> >  tools/perf/builtin-top.c                      |  19 +-
> >  tools/perf/builtin-trace.c                    | 103 +++++-----
> >  tools/perf/tests/hists_cumulate.c             |   3 +-
> >  tools/perf/tests/hists_filter.c               |   2 +-
> >  tools/perf/tests/hists_output.c               |   3 +-
> >  tools/perf/tests/mmap-basic.c                 |   4 +-
> >  tools/perf/tests/openat-syscall-tp-fields.c   |   2 +-
> >  tools/perf/tests/switch-tracking.c            |   9 +-
> >  tools/perf/util/annotate.c                    |  19 +-
> >  tools/perf/util/annotate.h                    |   6 +-
> >  tools/perf/util/build-id.c                    |   3 +-
> >  tools/perf/util/build-id.h                    |   7 +-
> >  tools/perf/util/callchain.c                   |   8 +-
> >  tools/perf/util/callchain.h                   |   5 +-
> >  tools/perf/util/data-convert-bt.c             |   2 +-
> >  tools/perf/util/data-convert-json.c           |   5 +-
> >  tools/perf/util/db-export.c                   |  13 +-
> >  tools/perf/util/db-export.h                   |   3 +-
> >  tools/perf/util/evsel.c                       |  60 +++---
> >  tools/perf/util/evsel.h                       |  12 +-
> >  tools/perf/util/hist.c                        |  26 +--
> >  tools/perf/util/hist.h                        |   3 +-
> >  tools/perf/util/intel-pt.c                    |  12 +-
> >  tools/perf/util/intel-tpebs.c                 |   3 +-
> >  tools/perf/util/jitdump.c                     |   2 +-
> >  .../perf/util/kvm-stat-arch/kvm-stat-arm64.c  |  19 +-
> >  .../util/kvm-stat-arch/kvm-stat-loongarch.c   |  17 +-
> >  .../util/kvm-stat-arch/kvm-stat-powerpc.c     |  17 +-
> >  .../perf/util/kvm-stat-arch/kvm-stat-riscv.c  |  17 +-
> >  tools/perf/util/kvm-stat-arch/kvm-stat-s390.c |  20 +-
> >  tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  |  70 +++----
> >  tools/perf/util/kvm-stat.c                    |  19 +-
> >  tools/perf/util/kvm-stat.h                    |  18 +-
> >  tools/perf/util/kwork.h                       |   9 +-
> >  tools/perf/util/machine.c                     |  14 +-
> >  tools/perf/util/machine.h                     |   3 -
> >  tools/perf/util/s390-sample-raw.c             |  15 +-
> >  tools/perf/util/sample.c                      |   8 +-
> >  tools/perf/util/sample.h                      |  93 ++++++++-
> >  .../util/scripting-engines/trace-event-perl.c |  23 +--
> >  .../scripting-engines/trace-event-python.c    |  47 ++---
> >  tools/perf/util/session.c                     |  74 ++++---
> >  tools/perf/util/synthetic-events.c            |   9 +-
> >  tools/perf/util/synthetic-events.h            |   2 -
> >  tools/perf/util/tool.c                        |   4 +-
> >  tools/perf/util/tool.h                        |   4 +-
> >  tools/perf/util/trace-event-scripting.c       |   5 +-
> >  tools/perf/util/trace-event.h                 |   3 -
> >  62 files changed, 769 insertions(+), 823 deletions(-)
> >
> > --
> > 2.53.0.239.g8d8fc8a987-goog
> >

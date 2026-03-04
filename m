Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6F43630BC
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Mar 2026 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641204; cv=pass; b=lTdc7hgKGn0z5Op/ZnzEynMoQdj4qbXEA8em0q0UhVm6PUj6FwdRu/iP9Hrm/WSRs093jIJ55qcbZK1v3ev0qHD7fCIgTMhZAslEtG/cFP6BSMyw8fA2HEpcYJVQiv6+nocX7Es67TO00Jf47qAVniTmkDBDQ6ObBwZiQ01KqRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641204; c=relaxed/simple;
	bh=Gsp2Ma2zn95PRb4OX94Ch19gNDGLwXiFOev2N3dN9Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKb6wIGfLmsxMuu1V2i2y8PPZ4oz3qZZ0vVMzEtWsvyy3cCIVg/oeIvnzFJI7MwJXRKWdR14MO7x+c3Zelc/06uIdOh6oHfFa88uhAHwHE6oxaOB+kudFLwtUWMMNE8SsK0sXz0O+Tp/yJH6b9vD6jTyMr7YALO9EEHYSyV4+6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXj8L6me; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXj8L6me"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae3f822163so181215ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Mar 2026 08:20:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772641202; cv=none;
        d=google.com; s=arc-20240605;
        b=NCk4Nn3r4aws7AdikEWiOCbiDuEdOsAgFbU4SgPpnnbQXs2mhY4qClkaQZvbRQbzbh
         SPbKV2tF10WIvLxkML4DerI0EVtbE/mnu5tiygbEO4mhT1Af+qiul71g3BAzsyq9gd5k
         I/ZyOX4uiZ2frRxuHT8Jzjxr+Ir/i+/qBbBVJx9dEFHgOQhAnkKEMCjF9NmrkPgPaBtB
         CCGDAFWpkMYynbKA4ygS+WPEmn9tNuv1z/b8yiFqK1wMnq0+uCflMHFec/V32V6ErfKe
         oEbuzxjKgM5csyQx0t4+eHDJxrHrFSpNIBBFofouFHcSzoxH9QHcHDeSVukydFsZd5qM
         cwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OG2ql/cjQS1o0TAKZHVw2msMvYcYan9/a46iMayPV4Q=;
        fh=OhNIFq0hsdfDAl1Fd9IqJnHjHXWoe95NM2mSq6ARwsY=;
        b=lGbRKHen3njmreBClRBQ++3e2DbT0Gxpq6jQ6vm8Ic98LP6qPnNuqwBg+XytYKH2Tf
         xrp9x7Uhvv7LO2sVAQ4gNUQGfuS2kbtGfkDyUOk6SPZV+OOVj7gVY+wUd0TjO3xJtTMf
         WNBFo7cFtgQJMOyx/i/SvfMJeCEmHTVOmwRfV5ejke2AlXqqLiwgKl8Y86KGQzBnXx7z
         rszVx0LrnrCiu7Z0IeNC6IjP5BGdchOjlZtA5to01SLYxpBx1alADWVfkT1LsxvP7GS6
         PBOJe/hG49Xsf9fWxwj6ImxT3+VNo+7BNV5XBLATqgeKj5thPwFrh9zcYkTTkzD2/SL4
         +pBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772641202; x=1773246002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OG2ql/cjQS1o0TAKZHVw2msMvYcYan9/a46iMayPV4Q=;
        b=CXj8L6me3Z8y8UbPYIQHaBEU0B9+YOcWPaQa26pXYtKrPXLkbkwt+wZZ0+joseL1T1
         XTsvoF5WSz+31ZYm6Za3B7sOijQ4KDXXZ0tX+Tlrj4GzRbWQhmzjcdroBHHxNSfmfbm6
         7U3SKNMnijIcNSv4/E7oIlTlK9jdC/UH8EpR7NUeWCxE/r1udUWoWV3iVlxgR1ODU8h6
         tdtbbUdTE+Kv+IrXqU5opNFkFbaFtD6ovMrK06FOAiy5mfp8LeHMuj8uMgdNX6nGvmDl
         rW4CixSDnL/LRT5jrGDNU5dO0AabyN1CCM5sO2l0IVYsBxdVjrUhj8g3pL1eRB9l6Zmf
         z+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772641202; x=1773246002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OG2ql/cjQS1o0TAKZHVw2msMvYcYan9/a46iMayPV4Q=;
        b=rYd0GP+h70Zwbk6srRxEWa9vMYBiuG3Omub3R/PCKY0BnvW0EwtpMH8Ggu4jEHOl79
         yqTc4zOXzz2rwXKv6KphmgzPsz0pRBOSWFfOWOpuMZoFpUJWZx166rkmEQkHDlxH+X/p
         8qUg0PdYWXnif6sOMU5rxmKbJ0hqWUS8OnBaEcLSVXz/5lDyrt8scAJwaIIBKcbag+Nc
         jO3+r6M2qFQTs+X+ZVgUlIW002KT2vuPUQn71Sdko1RxOq8/+3kvOiEvyLkehBGrzCXG
         1D/I2gKLKCK+HOxtkBC6wZaQKpSJ90NbgW01z1TVZHahtzyG28XPAi+WowRCbMYCs6oP
         23eg==
X-Forwarded-Encrypted: i=1; AJvYcCWHWAVk66qamOnSKaAheA2d3+y3GIQqh3ZCVqJ3/0eJbfCVkqHscz5+UEqxoyvaIzRl4pE3yY4/zIESdvHNIAUQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1wBcYm2INTaA7QAP0zVvp6txY0y2W/LYPMZhrinpCb8exuyA
	r64MI0EpxKckY5GAoeEpxR3ODL53AiaZ5PuTWw/gxySNDUb6rFzvezhxq+F1p0FOzXjXctLzqKu
	VJYKlylf0c+e0mCRa7bQYi3Hg7zZIQGmXv/uAtnxa
X-Gm-Gg: ATEYQzyr01K3OKnUjZh1gXAeaOWyW4RR1t6GuNVhJO9JXV6Woyb/U9BQdonNvIYbNwQ
	dWk02TPs16LftjiAfuY8WA+O/BrhebQLvQ+ye8f7dGajcku9p4Z6i1WqxZ1nZx2127mOxiEpx6l
	IJMhdiKOP31oVDEkEzP5U+M3tyRSYhJ14hwa3Ej8ONn5KI9HfCvmHeU3H/4LNaiopFiuDhmqCF0
	59bzsNItDFNYQkaqhIU1FA+9m3uhXc/zxepQwoCpRe6xjJ5znZo0N8So0Op9f95dq7aESpZUDkz
	lGU9NozgjqsInaqrfNWTXQ9+9XNxEzAbIT0SQg==
X-Received: by 2002:a17:902:cec8:b0:2a1:3cda:8e99 with SMTP id
 d9443c01a7336-2ae72691ae7mr89015ad.21.1772641201768; Wed, 04 Mar 2026
 08:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <aaeEpB9OTFGVIsr4@google.com>
In-Reply-To: <aaeEpB9OTFGVIsr4@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Mar 2026 08:19:50 -0800
X-Gm-Features: AaiRm51juM_OXuMHIk788p3QQbjHtlXdSt_KFoDWixbe2AgNhhCc2TblumhTEGE
Message-ID: <CAP-5=fUp-d7e--v_J=MUAcbPSStKF2oSqH1g6-SnH4US0w0Khw@mail.gmail.com>
Subject: Re: [PATCH v1 00/25] perf tool: Add evsel to perf_sample
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
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

On Tue, Mar 3, 2026 at 5:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Feb 09, 2026 at 09:40:07AM -0800, Ian Rogers wrote:
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
> Do you have a patch for off-CPU on top of this change?  I'd like to see
> what you expect before applying massive changes.

I'll need to rebase on top of these changes as it was on top of:
https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
Wrt size, these changes are prior to adding extra comments... was:
 57 files changed, 599 insertions(+), 749 deletions(-)
and last year we landed a clean up of:
https://lore.kernel.org/lkml/20251105001103.1296863-1-irogers@google.com/#t
which was:
 17 files changed, 130 insertions(+), 93 deletions(-)
but that was 1 patch and this is now broken into 25.

Thanks,
Ian


> Thanks,
> Namhyung
>
> >
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

Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E136A000
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Feb 2026 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874170; cv=pass; b=nOKOnYqIR4fVwl6BMoWjNXpdajxej5VSG20MYXA5oaOcibMthksvn2iN/DRDBQ6wO0FjI8cwJOxxzY2z1b8u1zwBEwJxqb2m4BbOjCdchxbAa7s5T44+3ohnIMQx3nMXvxELylsLubOPFGd65Tv1/WBWWM5ICDTiGpUWTGYApZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874170; c=relaxed/simple;
	bh=4nSPEE+huXhXJmh4Pl6hlPF5wooewqpu3ddGdsj7KhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LBBUt6tdDmGcV+jCSBiu68Mq8V4+7Keo3+sCggMLH3KD9XBlLxLLp6WYpY6KlksfmMw9x8FTQ5uVqDNmSODOqlKVZERlr/D8mUaLxLgijziu9txEHxVfWVqPrjs5LONU0VpyY9fHjdc86DWpGp9bBAfAIzJX2YfirLVFHhVG684=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwnubLPo; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwnubLPo"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a885af8ee7so7185ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Feb 2026 11:16:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771874169; cv=none;
        d=google.com; s=arc-20240605;
        b=e2QY8Z/BjCLYye9xQnaOaQq1ZRktC+kO4wqKyBmvZ9a6a3PT/Bqm+rMfHbS8d2BHSK
         6Ur9bcOmvGCjzxm5Covnr14su9xTGWWxq2G8xhXOh/TjuZaV96nmLEc+8DwZJr+VwL0o
         fwNcqWrLoGxTMF9K70mKf1Ku+zYR3cvuDMqkQmk8FLtp1zhqqHBgMYexLAxaHsWw3Nz1
         KYBCzZPQTFLT2/CsEQCEVW2A0dqyOWO8NRea0NoFkODr1OlIL8V0+HHOJfDtzbLfXC7J
         lFnMG33cbyvhCcjIXWf6gqDWHmSDI9yMtZS5MmDGEHnAwHKoeZQrS2z+tjvb28K1HM4b
         fTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hHw1VFbjT77k7HrskOem2hCB5voEmXsncP6036xF2uc=;
        fh=EjaDFD9c+htidsC3DvcrR3XyMnkz0R1Lj8LEWoER9rQ=;
        b=DYual87WJ8kz2yqrsoI8RGAUcBSCTOg/xq6Ql1bRQ4O79PhOCF58bHdN8SahhOosho
         Vd3Hx2sZxLHgkA/ROzdOSRJRU8MuUAsQ6lttSObYlc1bvETBCyf+h8ttZ4T6x27XoYC5
         vU4fk7mkA7ezPK9STBvZYdx3LrIWEiYhnZsEGz+xaw+yvvA6s3icFVXSYofZ0+gnM2eo
         uNB1CsNgY31PF/EAhfxYZpn2QAupDkKXpgxLJ2qo2s14RZy91lbnE5r57VAHqI2sdgI3
         5NCxQfZz2hr7b/WRA+/7dyrnRjsi0Lagrd6ZQbZ4N3+oGXelOc1d9WJAzr9iyrkCIQ5a
         7Asw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771874169; x=1772478969; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHw1VFbjT77k7HrskOem2hCB5voEmXsncP6036xF2uc=;
        b=YwnubLPo1zwbUM+nnmppAVHKD1exQUag8dN0aQxUnq2bVL/E7gjtXpY5T0sSW6ZW9+
         8CADCwtbB0++/Zsx7cwtS6rN7q2RfkECfGSaf5V8mUDvEjRtwrw5lZ6nlJUNKzYPxHKf
         fHMRP+XmXjclg1fllTQPuiovyNfBb/rfm0tL0dI6kpI5V12g3YU49RsmgPAYnmLqINn2
         GtYhMnlJYn3Re7z2iuUApYu4pW00IbY4nq/t+N0IFIidcOfEb3z9IERipo/X9IC0oc9r
         Dz3e7ZeZlsnn7TQ++4f5OPt9kbIxwB0bPJ+kXbN2Fzeacjmf47DscS0LTpSSLDtGXUc7
         XptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771874169; x=1772478969;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHw1VFbjT77k7HrskOem2hCB5voEmXsncP6036xF2uc=;
        b=oIP8U+Jd0/bmpKP3+qO7FH3XVLQWoYjWzpWpjHvQSzbVQHVJwEuaX1gtCIyMdfZFPo
         ODv0R+OvIBjyyDZieODirpZknJ2uH7qUg+v5Qx07gefDwAL8pZqnG83M4BL7btzQWfcr
         5/jMi39l8SFbRbmT8VvxIbPZ1b7c7lRhU0jn+n1wBsDqGueokTG7OGORI6ZTUbqprRlL
         iVOA/BsA97TB5QKumU/Xim3mkf09pQPGFHJ4e/Igxkti5n1BnSPIGSh6fCiaPOygtYUN
         Enr0gDpgcXBxiKV4o8u5KZw4p2wkczYXF8mKE/1odhUbQtTBv6Jzm5XalionAQMCQFqr
         KF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmmeim535Y6OlbLrmztUPeXn/hIB1FvUDcEKsc7qXOXf5ydR/vGBNNQMGEa4s9/ed+dPO6WBujI353Y5FQNyPj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbxez4ePENDAmWLLBeOEVxXQwFVuySqlmMImMsByog+cUVcPf8
	DzSU93AGuXMh8uUoHJR4h5xhnV9ycry8QFc73p9DgF6yosxDnmpEHNPV3ykHtHiEiqG/WfTePVC
	1ypUISciQHDAUWyhqGygkvTtTgboF501z0BdW/4AB
X-Gm-Gg: ATEYQzwLSTC9MoJWtQJHT6PxXRM6GKwXvMCPLi9lzU/aP0JAfwZU/KtBrSP8BR/8MG2
	nAirQBbFVztxOPno6FFN+NIfK51Mv0O2F1aXQm6nboiIKHprq2+gri0QVHcR+clAN2FAhY0i1Lw
	p+6Pyg1B4D/4xgNyHy7rvO4h3OgSsNsCcuWvOw8GoaUBDDnhkvbNZhF/sXLaWQc8EmEr3Yzfcbg
	jo9pXyI6fjDp6mdFqbZYm5/qvTSE/ENF8PYIJrtlmWpW6Mdpb1rEBk7iPYVkrQMPoxiU87tpb/B
	AT/PL2yEXuyzcqSKpKh0heB1IRGeypjiapNh
X-Received: by 2002:a17:902:f687:b0:2a7:d266:d84a with SMTP id
 d9443c01a7336-2ad99b59e09mr153955ad.17.1771874168041; Mon, 23 Feb 2026
 11:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Feb 2026 11:15:57 -0800
X-Gm-Features: AaiRm50VUhK6MoGwycZPLuSd5kcEAugBNvP-gsc4oF16XDdB3MmMn2nx6HpGac0
Message-ID: <CAP-5=fVaEfuM0_YXwX4tgFfiPTX1i_BkTKhYvGqnpZ2d_Cb6+w@mail.gmail.com>
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

On Mon, Feb 9, 2026 at 9:40=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
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

Ping.

Thanks,
Ian

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
>   perf s390-sample-raw: Don't pass evsel with sample
>   perf evsel: Don't pass evsel with sample
>
>  tools/perf/builtin-annotate.c                 |  28 ++-
>  tools/perf/builtin-c2c.c                      |   6 +-
>  tools/perf/builtin-diff.c                     |   5 +-
>  tools/perf/builtin-inject.c                   |  81 ++++----
>  tools/perf/builtin-kmem.c                     |  58 +++---
>  tools/perf/builtin-kvm.c                      |  22 +--
>  tools/perf/builtin-kwork.c                    | 104 ++++------
>  tools/perf/builtin-lock.c                     | 117 +++++------
>  tools/perf/builtin-mem.c                      |   1 -
>  tools/perf/builtin-record.c                   |   3 +-
>  tools/perf/builtin-report.c                   |  38 ++--
>  tools/perf/builtin-sched.c                    | 183 ++++++++----------
>  tools/perf/builtin-script.c                   |  26 ++-
>  tools/perf/builtin-timechart.c                |  76 +++-----
>  tools/perf/builtin-top.c                      |  19 +-
>  tools/perf/builtin-trace.c                    | 103 +++++-----
>  tools/perf/tests/hists_cumulate.c             |   3 +-
>  tools/perf/tests/hists_filter.c               |   2 +-
>  tools/perf/tests/hists_output.c               |   3 +-
>  tools/perf/tests/mmap-basic.c                 |   4 +-
>  tools/perf/tests/openat-syscall-tp-fields.c   |   2 +-
>  tools/perf/tests/switch-tracking.c            |   9 +-
>  tools/perf/util/annotate.c                    |  19 +-
>  tools/perf/util/annotate.h                    |   6 +-
>  tools/perf/util/build-id.c                    |   3 +-
>  tools/perf/util/build-id.h                    |   7 +-
>  tools/perf/util/callchain.c                   |   8 +-
>  tools/perf/util/callchain.h                   |   5 +-
>  tools/perf/util/data-convert-bt.c             |   2 +-
>  tools/perf/util/data-convert-json.c           |   5 +-
>  tools/perf/util/db-export.c                   |  13 +-
>  tools/perf/util/db-export.h                   |   3 +-
>  tools/perf/util/evsel.c                       |  60 +++---
>  tools/perf/util/evsel.h                       |  12 +-
>  tools/perf/util/hist.c                        |  26 +--
>  tools/perf/util/hist.h                        |   3 +-
>  tools/perf/util/intel-pt.c                    |  12 +-
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
>  tools/perf/util/s390-sample-raw.c             |  15 +-
>  tools/perf/util/sample.c                      |   8 +-
>  tools/perf/util/sample.h                      |  93 ++++++++-
>  .../util/scripting-engines/trace-event-perl.c |  23 +--
>  .../scripting-engines/trace-event-python.c    |  47 ++---
>  tools/perf/util/session.c                     |  74 ++++---
>  tools/perf/util/synthetic-events.c            |   9 +-
>  tools/perf/util/synthetic-events.h            |   2 -
>  tools/perf/util/tool.c                        |   4 +-
>  tools/perf/util/tool.h                        |   4 +-
>  tools/perf/util/trace-event-scripting.c       |   5 +-
>  tools/perf/util/trace-event.h                 |   3 -
>  62 files changed, 769 insertions(+), 823 deletions(-)
>
> --
> 2.53.0.239.g8d8fc8a987-goog
>

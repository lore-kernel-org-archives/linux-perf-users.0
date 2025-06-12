Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB02D3221
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757785; cv=none; b=Q5EBwcpOrz46z67bBMmq+jaTOBF6Kuyt8fiRVx/41QpDLTOJ5iesUQYRx+E7UGlP+GX8TosrqUFmyHfxtpqpdjYlSd4Y4Axz7zhN0Y0D1ztxRBuGVgdYCo6l9MaoC8yeNOCxEXUrSi9Tu2FROjqDkYs3EB4mX7cBXCn/4939R8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757785; c=relaxed/simple;
	bh=chSaC++D/KyOpv+GZTMMsJcBWrfO2VNl6nPnGCY7BBs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o6hdGvcrZSWeoNlgzEisISwX2x/GlVPzbMXehQqV0Hm22SLHiCqP1K8urwPVflOTMjj6O/d8YrLy55mB2ebn5vxEFkNK9mt0HBX5Di+dByVah4cOpe95Fv3apYEqaZsh97YIHgx7IPb/typxg34PQU8kzfe4aRRP7uqakn4DNkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGjIoIs7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGjIoIs7"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74858256d38so977252b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749757783; x=1750362583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QRtdXj9Yg5ChlR8GveTsxt0/9PdGzyJBP4FqYzn0P3E=;
        b=ZGjIoIs7bcMsbHxS8vKH/kA5aqIWIAvG/xeviYAxv2cTjEK/EHi++orjZaQFZ+87hg
         6NQ2ikbSZX99iJT36e0L9hIz7lEXWSaRbYFGZYMnyVxjSjdKm4fqOCmizeg8j3VdvRN/
         uFJTM7s2G5l/tbTJb+jOW+Pm8Sa3ofNJ3OZmU6Wdnyhr9a8ZUHvfz2SRPLrwJpsSaXhI
         c7qQJzJn5i7Z5klpm1HfzMIdA+sEYs8g3jGfN+Y5aEyIH8lD34OE1mfxZy3N9wSG0HKw
         TozlLe8AFuKeECHE0GHStXEozqoyCtj+ByP004Hw/KNW86zxe6QbDh0mcQwsdZFBrpQn
         Ux1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757783; x=1750362583;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRtdXj9Yg5ChlR8GveTsxt0/9PdGzyJBP4FqYzn0P3E=;
        b=Ink9GBa6Sb5F/lYzW0VNxLZLM6FP7ADCnxUbfuggkd+c0zFvQoaEGZQQ8PTjBzdand
         Ui3kNmDZhFqOI3cag0KiCEVLt50PYOr86QV4E1fThxWuVkXStjWX+JC0Q6YMFp63taTj
         EFk5OltaYqhRGfFMfuZl/yaLEgwoLdirn7NRyPWqDnutSM9aYANXe5yCCWtDPzF8Gztr
         YgvCnAqXhpGph8n42ibN5SsJcsnW0heDzFcyWbcJK3RXc03djo/1ZVDCTHsOZVCf8CJz
         gC44uTWK6BSPMBVIvTp+zG1qJJjg7X+nvTTrXwYykCX/pm6xmkNkk0/+JAGyCK+hQV+j
         DPDA==
X-Forwarded-Encrypted: i=1; AJvYcCWRTfFcdjYw6XIN7Snze5GENNROxZoS3NrCWL5ze4PG41ddmAqMQ4AdLXF8JhDjzCjVone0JKajYLvLayVTHjr4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8bYKSTv27aJPPgt+T82EvgKB6txhRnixgCUVqpoZ4OzGaCBz
	pDCFoCd9cGt0Y29heZyKcNN2k5+CXXXLKKy2Td3zRtecrfYKSh4oj5pDilXOJrbC8sCJA2O/Mrf
	vgiPU4q5OnF5nqgC341Yd5Q==
X-Google-Smtp-Source: AGHT+IFM8Zsyd1izWSsKwHQVwM28qL7GxFgsDTq3f1gsP9i89hkNUtONoVCoWeSmOlItnRfASjQ6b12TLmirns5R
X-Received: from pfm10.prod.google.com ([2002:a05:6a00:72a:b0:746:3321:3880])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:27a0:b0:736:34a2:8a23 with SMTP id d2e1a72fcca58-7488f76502fmr596866b3a.15.1749757782819;
 Thu, 12 Jun 2025 12:49:42 -0700 (PDT)
Date: Thu, 12 Jun 2025 12:49:34 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612194939.162730-1-blakejones@google.com>
Subject: [PATCH v4 0/5] perf: generate events for BPF metadata
From: Blake Jones <blakejones@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit ffa915f46193 ("Merge branch 'bpf_metadata'"), from September 2020,
added support to the kernel, libbpf, and bpftool to treat read-only BPF
variables that have names starting with 'bpf_metadata_' specially. This
patch series updates perf to handle these variables similarly, allowing a
perf.data file to capture relevant information about BPF programs on the
system being profiled.

When it encounters a BPF program, it reads the program's maps to find an
'.rodata' map with 'bpf_metadata_' variables. If it finds one, it extracts
their values as strings, and creates a new PERF_RECORD_BPF_METADATA
synthetic event using that data. It does this both for BPF programs that
were loaded when a 'perf record' starts, as well as for programs that are
loaded while the profile is running. For the latter case, it stores the
metadata for the duration of the profile, and then dumps it at the end of
the profile, where it's in a better context to do so.

The PERF_RECORD_BPF_METADATA event holds an array of key-value pairs, where
the key is the variable name (minus the "bpf_metadata_" prefix) and the
value is the variable's value, formatted as a string. There is one such
event generated for each BPF subprogram. Generating it per subprogram
rather than per program allows it to be correlated with PERF_RECORD_KSYMBOL
events; the metadata event's "prog_name" is designed to be identical to the
"name" field of a perf_record_ksymbol. This allows specific BPF metadata to
be associated with each BPF address range in the collection.

Changes:

* v3 -> v4:
  - Fix LIBBPF_INCLUDE in tools/perf/Makefile.config to use the libbpf
    source path, since libbpf/include doesn't exist during feature testing.
  - Fix the bpf_metadata_free() declaration for HAVE_LIBBPF_SUPPORT=0.
  - Add HAVE_LIBBPF_SUPPORT around some declarations in util/env.h,
    to align with the guards in util/env.c.
  - Add HAVE_LIBBPF_SUPPORT around a function call in builtin-record.c.
  - Link to v3:
    https://lore.kernel.org/linux-perf-users/20250606215246.2419387-1-blakejones@google.com/T/#t

* v2 -> v3:
  - Split out event collection from event display.
  - Resync with tmp.perf-tools-next.
  - Link to v2:
    https://lore.kernel.org/linux-perf-users/20250605233934.1881839-1-blakejones@google.com/T/#t

* v1 -> v2:
  - Split out libbpf change and send it to the bpf tree.
  - Add feature detection to perf to detect the libbpf change.
  - Allow the feature to be skipped if the libbpf support is not found.
  - Add an example of a PERF_RECORD_BPF_METADATA record.
  - Change calloc() calls to zalloc().
  - Don't check for NULL before calling free().
  - Update the perf_event header when it is created, rather than
    storing the event size and updating it later.
  - Add a BPF metadata variable (with the perf version) to all
    perf BPF programs.
  - Update the selftest to look for the new perf_version variable.
  - Split out the selftest into its own patch.
  - Link to v1:
    https://lore.kernel.org/linux-perf-users/20250521222725.3895192-1-blakejones@google.com/T/#t

Blake Jones (5):
  perf: detect support for libbpf's emit_strings option
  perf: collect BPF metadata from existing BPF programs
  perf: collect BPF metadata from new programs
  perf: display the new PERF_RECORD_BPF_METADATA event
  perf: add test for PERF_RECORD_BPF_METADATA collection

 tools/build/Makefile.feature                |   1 +
 tools/build/feature/Makefile                |   4 +
 tools/build/feature/test-libbpf-strings.c   |  10 +
 tools/lib/perf/include/perf/event.h         |  18 +
 tools/perf/Documentation/perf-check.txt     |   1 +
 tools/perf/Makefile.config                  |   8 +
 tools/perf/Makefile.perf                    |   3 +-
 tools/perf/builtin-check.c                  |   1 +
 tools/perf/builtin-inject.c                 |   1 +
 tools/perf/builtin-record.c                 |  10 +
 tools/perf/builtin-script.c                 |  15 +-
 tools/perf/tests/shell/test_bpf_metadata.sh |  76 ++++
 tools/perf/util/bpf-event.c                 | 378 ++++++++++++++++++++
 tools/perf/util/bpf-event.h                 |  13 +
 tools/perf/util/bpf_skel/perf_version.h     |  17 +
 tools/perf/util/env.c                       |  19 +-
 tools/perf/util/env.h                       |   6 +
 tools/perf/util/event.c                     |  21 ++
 tools/perf/util/event.h                     |   1 +
 tools/perf/util/header.c                    |   1 +
 tools/perf/util/session.c                   |   4 +
 tools/perf/util/synthetic-events.h          |   2 +
 tools/perf/util/tool.c                      |  14 +
 tools/perf/util/tool.h                      |   3 +-
 24 files changed, 622 insertions(+), 5 deletions(-)
 create mode 100644 tools/build/feature/test-libbpf-strings.c
 create mode 100755 tools/perf/tests/shell/test_bpf_metadata.sh
 create mode 100644 tools/perf/util/bpf_skel/perf_version.h

-- 
2.50.0.rc1.591.g9c95f17f64-goog


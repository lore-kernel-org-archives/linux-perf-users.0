Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA1D38E129
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087108; cv=none; b=NMQ0AkQTIcfNO0cObWj6Q0a+9R1060yViMEpsNi40pHYOFobejo8NCpku86iL7jLgX7X2N1JEAdXqAEUOw8P/JwolI4x40VTSXTq5htBLloHD33Vb7heDTZOlbig7darLYf9uxQzfasqYUhy/q+3nbqhlXCVB7ysDVTzahvddi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087108; c=relaxed/simple;
	bh=pR4sKjOg6M5FpHXGSlh8e2AK38K+ESFD8AdmYkYBd4M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=EZMQjb1+rQvhaivHmrOgcpGZn/SF5Tan+fNYn0C3SxfKMly6GoVmsMZnIKNZ6HUpGxZI7DhKFpfSOh6EP/+ipcqWFFOqrM+w35khUG74s+GZ+ICccLGyNoTC55IPHZhzbyaajgTUGayYbsOfvVJXw8gXwDHUhrsI8R7a+/rCPZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPbwIsAq; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPbwIsAq"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so2642769a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 00:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786087106; x=1786691906; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=s0uOfK2vBqt76lOjULU8OLFIMTR7IToQpEOfI/OQz2U=;
        b=wPbwIsAq1I9i9/EPSCfEogdG+KPMbmFkjjX+Wx/Cf5Y1aiyzR+4933wE9Iso2tqlke
         rpKK1BKUtzlwDQGJibK29YbRyf6KmNgLIWoR/mNlOJsajAOe0MLh3k54kuYW0XjCmfAx
         yBAyW5qe7XFM3ja+Go8gRelFJTuGaX21WFH9gjSTlUnTh4dG5kuDtihtq9cOhD7c112u
         XTbrQnYfjmih4Qqu32A1iVvanrslF8kocJEgPt5FiWlXGWZt198ToO6tNfB88aGdDjRp
         7Po3wxv0uh8jNOs5Kv2pPNP9bJ76qLxuwp6sBFS3Xh4EpLrFi2DPV5R/oks/1UPKDAbW
         lmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786087106; x=1786691906;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s0uOfK2vBqt76lOjULU8OLFIMTR7IToQpEOfI/OQz2U=;
        b=BqYkgKdfg5+83CMAViu6Me8/a0w/JhHWl2gTgXAm68KfzY3xIiV9FOD1PJxxQYHLFO
         CLmWQymX+ebRPpe6XnInlu9MeYh28yFluWSqggKK6o0JACKJf2+SCWl+LM26gYSimh4a
         lXwsOk0HWzxC+bOywnqFnXS2bcUVT4nSx9OtEFsnBu5vDWr5bftY3DyLvgIOq3HpGLDF
         /VgJj9chanj4+U/Km7683Hkm/f3plSO0v84hJRYiJntxCMM1TF7KccD7LVy+0RTjb6TM
         84+h7oU6aQWroHyFvlskyLujjvGTLw+UNs9+b5WyA4xbq8UGCYsoXRptCdrSLb+XAaoz
         HjdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rov3T/Epw/M+PWe1uLKDdW7lmNNtISCzQLB5f29YC0EiaY5Dn7DVDAYlKsSwFM4G/Jh8MadQTbcTXojJzbGB7BF@vger.kernel.org
X-Gm-Message-State: AOJu0YwDyF1Cs12AC01oBgcouRDQBeZOXf2XnQ+8+K5Scd7zaJkZVgC8
	s7YM+bweejJV+YESRcu5O7uK58zR+mEr/Fn4MSU18C7cBy2sodTa1CKjvulF5O/yJBI5u71gJ+j
	apd918PhKlw==
X-Received: from dlbsj11.prod.google.com ([2002:a05:7022:f90b:b0:140:f42f:50e5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:220a:b0:3c4:2cf9:28ad
 with SMTP id adf61e73a8af0-3cb85e9927amr26857052637.12.1786087105691; Fri, 07
 Aug 2026 00:18:25 -0700 (PDT)
Date: Fri,  7 Aug 2026 00:18:10 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807071818.718751-1-irogers@google.com>
Subject: [RFC PATCH v1 0/8] perf/core, perf/tools: Add PERF_SAMPLE_BUILD_ID_OFFSET
 support
From: Ian Rogers <irogers@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Eric Biggers <ebiggers@kernel.org>, Zecheng Li <zli94@ncsu.edu>, 
	Gabriel Marin <gmx@google.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Derek Foreman <derek.foreman@collabora.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Aaron Tomlin <atomlin@atomlin.com>, tanze <tanze@kylinos.cn>, 
	Rui Qi <qirui.001@bytedance.com>, Howard Chu <howardchu95@gmail.com>, 
	Chuck Lever <cel@kernel.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch series introduces PERF_SAMPLE_BUILD_ID_OFFSET to the
perf_event UAPI and implements full support across both the kernel
and perf tools.

Background & Motivation:

In order for perf to translate virtual addresses of samples into
symbols a file and offset within the file are needed. During event
synthesis perf will create mmap events to facilitate the translation
of a virtual address to a file and offset by modelling the address
space of a process. By directly recording in a sample the Build ID of
a file and the offset within it, no synthesis is necessary. The Build
ID and offset as a pair are much larger than a virtual address, so
there is a trade-off between synthesis cost and extra size for
samples. These changes just facilitate Build ID and offset as a choice
for perf samples and the user can have the choice to use it when they
believe it is advantageous.

In practice perf still needs to map a build ID to a file, so by
default this change keeps synthesis to allow this. It is expected a
user that knows their build IDs, say through debuginfod, will disable
this option with say --synth=no.

The kernel support uses the existing build ID and offset support used
by BPF stack traces.

The Build ID and offset samples inherently don't leak ASLR
information. As with the ASLR remapping work in perf inject, support
is added to migrate virtual addresses to Build ID and offset for the
purposes of testing without kernel support.

Series Overview:

- Patch 1: Factor struct perf_build_id into top-level header structure.
- Patch 2: Add PERF_SAMPLE_BUILD_ID_OFFSET to UAPI.
- Patch 3: Implement kernel-side sampling support in
           perf_output_sample() using stack_map_get_build_id_offset().
- Patch 4: Refactor perf tools thread__find_map and symbol lookup APIs
           to accept struct perf_sample.
- Patch 5: Add perf tools internal parsing and symbol resolution via
           Build ID + offset.
- Patch 6: Extend perf inject with --buildid-offset to convert sample
           files.
- Patch 7: Add --buildid-offset option to perf record.
- Patch 8: Add unit and shell test coverage (bid-offset test and
           inject_bid_offset.sh).

Testing & Verification:

The series was verified using QEMU hypervisor testing with kernel
builds and perf test.

Linux Plumbers Tracing Miniconference:

I submitted a proposal/abstract to talk about these changes to the
Tracing Micro Conference at Linux Plumbers Conference 2026 in Prague.

Ian Rogers (8):
  perf event: Factor build_id out into its own top-level struct
  perf/core: Add BUILD_ID_OFFSET to UAPI
  perf/core: Implement BUILD_ID_OFFSET sample type
  perf: Refactor thread map and symbol APIs to take perf_sample
  perf tools: Internal support for BUILD_ID_OFFSET
  perf inject: Extend perf inject to support bid_offset conversion
  perf record: Add --buildid-offset option
  perf tests: Add build_id_offset test coverage

 include/linux/bpf.h                           |  13 +
 include/uapi/linux/perf_event.h               |   4 +-
 kernel/bpf/stackmap.c                         |   2 +-
 kernel/events/core.c                          |  85 ++-
 tools/include/uapi/linux/perf_event.h         |  30 +-
 tools/lib/perf/include/perf/event.h           |  18 +-
 .../arch/powerpc/util/skip-callchain-idx.c    |   4 +-
 tools/perf/builtin-inject.c                   |  23 +-
 tools/perf/builtin-record.c                   |   7 +
 tools/perf/builtin-script.c                   |  49 +-
 tools/perf/builtin-timechart.c                |   4 +-
 tools/perf/builtin-trace.c                    |  12 +-
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/bid-offset.c                 |  60 +++
 tools/perf/tests/builtin-test.c               |   1 +
 tools/perf/tests/code-reading.c               |   4 +-
 tools/perf/tests/mmap-thread-lookup.c         |  45 +-
 tools/perf/tests/sample-parsing.c             |  37 +-
 tools/perf/tests/shell/inject_bid_offset.sh   | 170 ++++++
 tools/perf/tests/shell/record.sh              |  69 +++
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/util/Build                         |   1 +
 tools/perf/util/annotate-data.c               |   5 +-
 tools/perf/util/aslr.c                        |  16 +-
 tools/perf/util/build-id.c                    |   5 +-
 tools/perf/util/capstone.c                    |   4 +-
 tools/perf/util/cs-etm.c                      |   4 +-
 tools/perf/util/data-convert-json.c           |   4 +-
 tools/perf/util/debug.c                       |   4 +-
 tools/perf/util/dlfilter.c                    |   8 +-
 tools/perf/util/event.c                       |  93 ++--
 tools/perf/util/evsel.c                       |  35 ++
 tools/perf/util/evsel.h                       |   3 +-
 tools/perf/util/evsel_fprintf.c               |   2 +-
 tools/perf/util/inject_bid_offset.c           | 504 ++++++++++++++++++
 tools/perf/util/inject_bid_offset.h           |  21 +
 tools/perf/util/intel-pt.c                    |  12 +-
 tools/perf/util/machine.c                     | 106 ++--
 tools/perf/util/maps.c                        |  29 +
 tools/perf/util/maps.h                        |   2 +
 tools/perf/util/perf_event_attr_fprintf.c     |   3 +-
 tools/perf/util/python.c                      |  13 +-
 tools/perf/util/record.h                      |   1 +
 tools/perf/util/sample.h                      |  13 +
 .../scripting-engines/trace-event-python.c    |  20 +-
 tools/perf/util/synthetic-events.c            |  60 ++-
 tools/perf/util/thread.c                      |  11 +-
 tools/perf/util/thread.h                      |  14 +-
 tools/perf/util/unwind-libdw.c                |   7 +-
 tools/perf/util/unwind-libunwind.c            |   8 +-
 50 files changed, 1473 insertions(+), 174 deletions(-)
 create mode 100644 tools/perf/tests/bid-offset.c
 create mode 100755 tools/perf/tests/shell/inject_bid_offset.sh
 create mode 100644 tools/perf/util/inject_bid_offset.c
 create mode 100644 tools/perf/util/inject_bid_offset.h

-- 
2.55.0.679.g6767b8d81c-goog


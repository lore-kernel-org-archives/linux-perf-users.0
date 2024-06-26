Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972415B10D
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434201; cv=none; b=CfOKBq0HWNwxrIxfHaQc3P6wOdxxMZn57ZPHR77W3Ofqr/Kj3EuH/MtYNK3co3QODsG2+tZKhbS3LZf7FqPDoPoqMZt6GQJyQC+yopqmZ7gN5Lh9PGUoIbR3l8/+etRu12OXcMJEcbfWOj75KZGQWmqLxv3B2Tm6UT8hk0AN//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434201; c=relaxed/simple;
	bh=+6av3dlgj64H4ygfu2KimyeTYDV1dKJUzQJ1ASocDG4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=TbCP9Zrf371G2D75eAEO4aEZQuQi7vBAlW9PTLuVH3XMxmxHve6xisatFUCLMlJQucSpISxSw5e8v4AyRiHcW/mePsC+ZDQjJ85LMt1mALCKQcMDdYykD07u2IQfraK/ISmt7DOpiheEPf6L6btzIZtWFFTo98ecwm+8+txVe3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3dnTjpN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3dnTjpN"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bab20b9f4so127626407b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434199; x=1720038999; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c3z4mjiJwqFTlGfQGdTxhJfg4DHbpaFVUu0X6ClFmOM=;
        b=I3dnTjpNEWE+iNmWYP8iQKejS95h6IvkeEnX33f1BS92PujJdWrdOKW3/75KoMDTNC
         sF43AkAwtiVsVLs0JXI5qvOMGLTJ5ItWEuGkTXZQMVVO+Zi1KhHon0TXl/bMntOjM1xo
         GBlabE0liyQp68QJozjuXZsXReKnfZOKNw0vWPM9nH4oGo5pqbTKqdkeixEsge6Z6OJg
         2Wum6wY5zlrfWKNEBLDkpAnjYEWHjQ36HW432fj3i87/nhDJ0ExM7gXGF3s4qsvEUvnJ
         3lnqGsvwqM2KPTJLUWIhh8lqiAGutAZyLSaeB9CEKlgR5HlUtIXuoG+/8XXtFOaQcyGE
         6j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434199; x=1720038999;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c3z4mjiJwqFTlGfQGdTxhJfg4DHbpaFVUu0X6ClFmOM=;
        b=gGAM2fRw5fhRCLVWNAXMUogvRST2uN66X71TKx9sZyiB2tcVUP+FniN+iK/47xLNpU
         wpS/neRzkzlg+ElSEwc8KhL1u80M9L2bqsIQywDhj4DEfLGwnR+xFfahnhB77SEm4NXP
         3q+nmcLaQJPq5dLAGxK0xc5hMKw+IstUzn1F3LX9uwH+7QNTjuf3RNMnfHpRhLBCjTdL
         nwJivbtP4qg9GjqY3SPr8hJWfo4JIORiNc3kJWkGSYWmHn7+8py9JkCI0zw7eGtKLSad
         Tz438LZRn6QflXF9LoPzPiuumt4fgLBLX/7lqAL8Uk7NJh5y/b/A4qF5yeIZvJp5Y3ia
         8/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCW32GF/8NO2eyiajCyPo5zLVVby9/AYmsHAMIVV33bOFLCg2rezf5Ju9Evu4J+E4PJovDc6bmelkguVvyC57Y9jHMrTTQrLozgCK1t88JzSQg==
X-Gm-Message-State: AOJu0YwX3qNUys4saf1NyJDR1rQIkVGCXHktQD1tKS2t9wa/Wg2lL5Ru
	8R3DW6ulqLXbBKQXCypATOjh1OFs8QtAs3TC/mAqc984sfDvZbZDLdo2TpJuEUes/J8zzOyQu/B
	2DKPfTQ==
X-Google-Smtp-Source: AGHT+IHQoNW7EBiDlY2CaPg02hKB+zsNGCyLVPLQP+hAr612VAXtdXj/jRAYk7bFbb1ZclTwvgVMu2EqH0eE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:25ca:b0:62c:ea0b:a447 with SMTP
 id 00721157ae682-643aba49756mr2851447b3.2.1719434198766; Wed, 26 Jun 2024
 13:36:38 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:02 -0700
Message-Id: <20240626203630.1194748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 00/27] Constify tool pointers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

struct perf_tool provides a set of function pointers that are called
through when processing perf data. To make filling the pointers less
cumbersome, if they are NULL perf_tools__fill_defaults will add
default do nothing implementations.

This change refactors struct perf_tool to have an init function that
provides the default implementation. The special use of NULL and
perf_tools__fill_defaults are removed. As a consequence the tool
pointers can then all be made const, which better reflects the
behavior a particular perf command would expect of the tool and to
some extent can reduce the cognitive load on someone working on a
command.

v2: Remove dummy tool initialization [Adrian] and make zero sized. Add
    cs-etm fix for address sanitizer build, found necessary when
    testing dummy tool change.

Ian Rogers (27):
  perf auxevent: Zero size dummy tool
  perf cs-etm: Fix address sanitizer dso build failure
  perf tool: Constify tool pointers
  perf tool: Move fill defaults into tool.c
  perf tool: Add perf_tool__init
  perf kmem: Use perf_tool__init
  perf buildid-list: Use perf_tool__init
  perf kvm: Use perf_tool__init
  perf lock: Use perf_tool__init
  perf evlist: Use perf_tool__init
  perf record: Use perf_tool__init
  perf c2c: Use perf_tool__init
  perf script: Use perf_tool__init
  perf inject: Use perf_tool__init
  perf report: Use perf_tool__init
  perf stat: Use perf_tool__init
  perf annotate: Use perf_tool__init
  perf sched: Use perf_tool__init
  perf mem: Use perf_tool__init
  perf timechart: Use perf_tool__init
  perf diff: Use perf_tool__init
  perf data convert json: Use perf_tool__init
  perf data convert ctf: Use perf_tool__init
  perf test event_update: Ensure tools is initialized
  perf kwork: Use perf_tool__init
  perf tool: Remove perf_tool__fill_defaults
  perf session: Constify tool

 tools/perf/arch/x86/util/event.c    |   4 +-
 tools/perf/bench/synthesize.c       |   2 +-
 tools/perf/builtin-annotate.c       |  44 ++--
 tools/perf/builtin-buildid-list.c   |  10 +
 tools/perf/builtin-c2c.c            |  33 ++-
 tools/perf/builtin-diff.c           |  30 ++-
 tools/perf/builtin-evlist.c         |  10 +-
 tools/perf/builtin-inject.c         | 159 +++++++------
 tools/perf/builtin-kmem.c           |  20 +-
 tools/perf/builtin-kvm.c            |  19 +-
 tools/perf/builtin-kwork.c          |  33 ++-
 tools/perf/builtin-lock.c           |  41 ++--
 tools/perf/builtin-mem.c            |  37 +--
 tools/perf/builtin-record.c         |  47 ++--
 tools/perf/builtin-report.c         |  67 +++---
 tools/perf/builtin-sched.c          |  50 ++--
 tools/perf/builtin-script.c         | 106 ++++-----
 tools/perf/builtin-stat.c           |  26 +--
 tools/perf/builtin-timechart.c      |  25 +-
 tools/perf/builtin-top.c            |   2 +-
 tools/perf/builtin-trace.c          |   4 +-
 tools/perf/tests/cpumap.c           |   6 +-
 tools/perf/tests/dlfilter-test.c    |   2 +-
 tools/perf/tests/dwarf-unwind.c     |   2 +-
 tools/perf/tests/event_update.c     |   9 +-
 tools/perf/tests/stat.c             |   6 +-
 tools/perf/tests/thread-map.c       |   2 +-
 tools/perf/util/Build               |   1 +
 tools/perf/util/arm-spe.c           |  14 +-
 tools/perf/util/auxtrace.c          |  12 +-
 tools/perf/util/auxtrace.h          |  20 +-
 tools/perf/util/bpf-event.c         |   4 +-
 tools/perf/util/build-id.c          |  34 +--
 tools/perf/util/build-id.h          |   8 +-
 tools/perf/util/cs-etm.c            |  24 +-
 tools/perf/util/data-convert-bt.c   |  34 ++-
 tools/perf/util/data-convert-json.c |  47 ++--
 tools/perf/util/dso.h               |  10 +
 tools/perf/util/event.c             |  54 +++--
 tools/perf/util/event.h             |  38 ++--
 tools/perf/util/header.c            |   6 +-
 tools/perf/util/header.h            |   4 +-
 tools/perf/util/hisi-ptt.c          |   6 +-
 tools/perf/util/intel-bts.c         |  14 +-
 tools/perf/util/intel-pt.c          |  15 +-
 tools/perf/util/jitdump.c           |   4 +-
 tools/perf/util/s390-cpumsf.c       |  11 +-
 tools/perf/util/session.c           | 342 ++--------------------------
 tools/perf/util/session.h           |   6 +-
 tools/perf/util/synthetic-events.c  |  80 +++----
 tools/perf/util/synthetic-events.h  |  70 +++---
 tools/perf/util/tool.c              | 294 ++++++++++++++++++++++++
 tools/perf/util/tool.h              |  18 +-
 tools/perf/util/tsc.c               |   2 +-
 54 files changed, 967 insertions(+), 1001 deletions(-)
 create mode 100644 tools/perf/util/tool.c

-- 
2.45.2.741.gdbec12cfda-goog


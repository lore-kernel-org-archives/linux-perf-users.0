Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC84613D
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495647; cv=none; b=efTWWLmebmb1qXDZnCWYEUjri1vPd3SrP9pChXgv36QsI9rK4I5s+MGqbECUACFfzwP/TIOGG1O+BKqmz+QHjOYiLg6omCDwX5Iglkj2Qrh2EvziTxpI5SQauROhv3sT+tuGGJlZWXQvlRbnqWKiTpKlNJWQQLfhATsbWnS7Vl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495647; c=relaxed/simple;
	bh=SS2FLjVc73xgVt6nS1jtYfQTf6WBJ9pwSZp9v1YLrI8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Oa0HDych4b51es8R9P5NxYYK4Fe5JkWEmjEqQlGPTqG0j/ajDJ468B3niE843/ZmEb2Bu2S5aFroZdHI8qrhDwsjGN9mY1kpYR4ItW4NOEnD8NhFEoyMsZ9I4TFC/ElTUgWXmwXGB/7QNccYyi0ZsCiTPy/fItwi/ynWAU4lNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bb2sToHZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bb2sToHZ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-672bea19dd3so107595947b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495644; x=1724100444; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uer6PQjscKvGgXXE3fJO4sZtaX8fzUOBmNat/aWkUT0=;
        b=Bb2sToHZ+SODyATRQjWujk7vbUkuWeMPA+02HFQvFErEv5qUcWsy0VQplQEyxcLPz5
         SxWXqGr9OW05QJ2XqPgnqcjonaDBJcPfGh+m4ZkQlEHRabiQx7sz7G/4J1pOy3WPXpnA
         RJLxUXMtXcTirGWr+lIGin5C+pwU+qSnHWx2eS2tN05h5IxfUO8zqwi3N2Mi8ubweHCV
         7+3x5EjQzaB6rwWs4Ndk+r3kK5zqJg37CWgtHMo3jmZ1zAPpSEm4Dt85H1DhlRUJq/aW
         i4wkcpQcrwgNQ2APa6YVWb7Kh5aolemoJAiL/MnScNQcwkJV619EHHdKi4/qPc6XgoSS
         OOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495644; x=1724100444;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uer6PQjscKvGgXXE3fJO4sZtaX8fzUOBmNat/aWkUT0=;
        b=DamkGTqAiKk+nh3H6BhDSesyEK++sJsEvXBKIJ2KZlm9BfA0yuwDTUUxFZmGfhcnyK
         N4jenqhfRmR3vGRpSYze0FysGmC28F7bOIDLL42Uy4hO4Gsf/I1riXYNn/0QptD3q/dF
         HFtXbASDiYuxlRWj6SNSPkFEtJQ3OB1hTRuKbt7YvAC6t2rKakUsyT2i9/7BgQMI2OfY
         vklGiylmvDdOqiEd1Vbk0ZB41VVSG66x+Lrnyrdv7EiL5ZyrRLM6lP5CoMHVDtSLa4RZ
         BN7HdvKgKX54gvwYZCThhDN42J5Npg7zWVe3Oytq+QhfU/QHoUKIYn4iW2lt6W2JKUFo
         XiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHAVP384WbaBzfBmryEwE+jOeL1yxmgh+4miERT2YoyGcYqlMNgOEyU/Vs8KnDzSPiJ7Amc787jmT5SU/LzK3qvm7Jam3H4Zo9lwhiMWrS+A==
X-Gm-Message-State: AOJu0YxO6xvxKF5HosohO3nh+WwCqOcFGyFQmwyRosT23bB7u+a6JFQQ
	bSPPSXaDtPms6QqPWlDVwf7MyOZVKBqKHxGfMjpNld9FmCzx5XswUx8/nYYnSdsJVyZBVaTqr9Q
	AA6JPdg==
X-Google-Smtp-Source: AGHT+IEu0sMNYCIm71cwC3UyJ4MUqsU6Lo8drC4vUiZ6GZl6gb9xWPCK3IYSZfz8TDUui39XAjW2ez9/ny6C
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a81:d84d:0:b0:622:cd7d:fec4 with SMTP id
 00721157ae682-6a97695ee2amr538717b3.9.1723495644367; Mon, 12 Aug 2024
 13:47:24 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:46:52 -0700
Message-Id: <20240812204720.631678-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 00/27] Constify tool pointers
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

v7: Rebase and correct Adrian's reviewed-by tags.
v6: Rebase adding Adrian's reviewed-by/tested-by and Leo's tested-by.
v5: Rebase dropping asan fix merged by Namhyung.
v4: Simplify perf_session__deliver_synth_attr_event following Adrian's
    suggestions.
v3: Just remove auxtrace dummy tools [Adrian] and make s390-cpumsf
    struct removal its own patch [Adrian].
v2: Remove dummy tool initialization [Adrian] and make zero sized. Add
    cs-etm fix for address sanitizer build, found necessary when
    testing dummy tool change.

Ian Rogers (27):
  perf auxtrace: Remove dummy tools
  perf s390-cpumsf: Remove unused struct
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
 tools/perf/builtin-inject.c         | 161 ++++++------
 tools/perf/builtin-kmem.c           |  20 +-
 tools/perf/builtin-kvm.c            |  19 +-
 tools/perf/builtin-kwork.c          |  33 ++-
 tools/perf/builtin-lock.c           |  41 ++--
 tools/perf/builtin-mem.c            |  37 +--
 tools/perf/builtin-record.c         |  47 ++--
 tools/perf/builtin-report.c         |  67 +++--
 tools/perf/builtin-sched.c          |  50 ++--
 tools/perf/builtin-script.c         | 106 ++++----
 tools/perf/builtin-stat.c           |  26 +-
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
 tools/perf/util/arm-spe.c           |  55 +----
 tools/perf/util/auxtrace.c          |  12 +-
 tools/perf/util/auxtrace.h          |  20 +-
 tools/perf/util/bpf-event.c         |   4 +-
 tools/perf/util/build-id.c          |  34 +--
 tools/perf/util/build-id.h          |   8 +-
 tools/perf/util/cs-etm.c            |  39 +--
 tools/perf/util/data-convert-bt.c   |  34 ++-
 tools/perf/util/data-convert-json.c |  47 ++--
 tools/perf/util/event.c             |  54 ++--
 tools/perf/util/event.h             |  38 +--
 tools/perf/util/header.c            |   6 +-
 tools/perf/util/header.h            |   4 +-
 tools/perf/util/hisi-ptt.c          |   6 +-
 tools/perf/util/intel-bts.c         |  37 +--
 tools/perf/util/intel-pt.c          |  30 +--
 tools/perf/util/jitdump.c           |   4 +-
 tools/perf/util/s390-cpumsf.c       |  11 +-
 tools/perf/util/session.c           | 366 +++-------------------------
 tools/perf/util/session.h           |   9 +-
 tools/perf/util/synthetic-events.c  |  80 +++---
 tools/perf/util/synthetic-events.h  |  70 +++---
 tools/perf/util/tool.c              | 294 ++++++++++++++++++++++
 tools/perf/util/tool.h              |  18 +-
 tools/perf/util/tsc.c               |   2 +-
 53 files changed, 978 insertions(+), 1103 deletions(-)
 create mode 100644 tools/perf/util/tool.c

-- 
2.46.0.76.ge559c4bf1a-goog


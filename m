Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB21DFD2
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807933; cv=none; b=GDsplL1Y2sabBD9QrF0TUdO8L8k33UB3R2EqvunXqPgKe0PCP/CtDWowGR/Ejcf4jL0ybgRyW1ThQOpYkiCH0pdTj7GQUmJgVaHPK1D9Z2nJ+F+rkcge4KOdUGKmlxQwhFpTSdkyDBy+Ng/tN263c7+UQ0Ds4hoevYlYfmHPYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807933; c=relaxed/simple;
	bh=tDQLol1kA8jgMs8n1wfoZX/DscdZCloL52WFhMLQAzo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=MQ9HizRgJqOlqcPU9xAQrnWrmiQRCrh4IAirWiz3hgtUt6DpyGES6nCiYYUjx+lvsZGbnyZEb0BmtwTY6ArePlMSCZa6L/kyXPo8oWL3QtIiu/vpf+5nwZdIoOa80e1vzovS2Ib2In9BS6RBbsOoqovCKZzP/cgAeF30ep4NXbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJ0Ytf90; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJ0Ytf90"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a5534d58so3532700276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807931; x=1721412731; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1PvywuL9TWKvnf9wi2fxGXLZq6Gkm5fBOWHqNoqtxX0=;
        b=GJ0Ytf906Bq+TIfvhpOXVfZyKbEDPIUlJpiTya5w+iHJtQ0zcPLeCcSrbfGj9zSlZK
         4ynLakTj6t9VJNfxUHWk5IZhOTtdHg6teXVV1SA4vkv1qOtEOBj5av0UBLicbpmxEpVy
         FuH9JBiL4JhWMustDReZKm+MFEuRILubGRgtv7JGEPyq33WT5XK1Nle+bRop6UpdFI+r
         P2zBgqH/8cPg1gpIDtqkg3cSIYPl+5OSW3a9+2pBCo1XWXY2RFQWWTOKg1UEsL/4alqD
         SvJxd+a1JfqIqz7xXXZYRQU054X4yjUFLrqr06sqEVCl0NySOZUnUXAhzpmPzOW98jkF
         afeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807931; x=1721412731;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PvywuL9TWKvnf9wi2fxGXLZq6Gkm5fBOWHqNoqtxX0=;
        b=BbMV4r8u3XVrZmr33UBGSm/uZxWSk+lQJI5cF3ep1eWKKC0660q/lwewLMzZPG8gkR
         KkDcqfINOGX4+W8EChhfhC1lmEsrLXHCZK5vpFXo038lmdK8zrGcZGU3Wukv8hldRDME
         h7q0QvDHeEIlJyUCNUUviT+scV+DyC6i884w4moFITM1IhUzDQHaRXgcVSKElWs0fyuj
         Ruc2tSWJUVsuZ3Myb7PImieLFdKPkx8ENaskRVW4csD2h1fM2i4t5tJVqJIXH1+lu1TN
         HbrNuvhrhGvUUyq09HRefOUXB5CpDfdwJsKmhejXL3tX3jo2EFyo6+q17rs7japr7cCM
         NLPg==
X-Forwarded-Encrypted: i=1; AJvYcCWbiC8PPdK4Tm2rRC7ahqF9zQFDytP0vT0tkR9hlzmQF638+dA+zferPwgbwNKmAdRz4gXwqwQgTo5Cgpe4aDXghTGUZIm7P7nz2k/UbJHseg==
X-Gm-Message-State: AOJu0Yy0w0kTf09izE/XQMeDFbcd2VCSiVCg/qrYtRVKfzVkdmBZZwuW
	UYJk9tSt5G21lOqdoPhH+SUgIxbzPafUOohnO8mj1K101Mn12fVr0ThxSBRy9RLLmC2zoRYFCGh
	b2zhBKg==
X-Google-Smtp-Source: AGHT+IGFo9eXDGAsGUb1rZgo+kAM+1GIHCtXrOoChYgiTMag4nDyO647SbLAbsF9q/vuVbwCCdQC+aJE9xjc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1206:b0:e03:59e2:e82 with SMTP id
 3f1490d57ef6-e041b134afbmr21094276.10.1720807930780; Fri, 12 Jul 2024
 11:12:10 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:41 -0700
Message-Id: <20240712181108.475336-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 00/27] Constify tool pointers
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
 tools/perf/builtin-inject.c         | 159 ++++++------
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
 53 files changed, 977 insertions(+), 1102 deletions(-)
 create mode 100644 tools/perf/util/tool.c

-- 
2.45.2.993.g49e7a77208-goog


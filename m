Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C533D8
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636851; cv=none; b=s7KKeich2fJMhBz0OHIySfzcC7+4Ybdm3ZDMP84uLh5zUu7/00PnnmF0eO3IkxRAWU9YS2EM906dgjHpZODxDDrqYYya2YxyF8ADbyhDkDakuKC2rEyZmOChjLUu5w6rE05qvbqhl3ibaMYHiJUBcSMMvzP6npFdfCQX+KaQfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636851; c=relaxed/simple;
	bh=ulgnEXeySFIkrktz7yXWAqrrSl4AnoUp7YlCZDC6t6o=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=HRG6rO6AV6itOHfliBywrOhrgutiVtNhVp3guckoGkvEGYkvREhoWXSOqKm80/OjBdAQv/Nj76gfYulLFaHEnsJGCOykcC7FMtgda550ME84v5DZTW7GlYUxYXxbvdjpaZwaSi8EuGWco2ozxRkD4VIWd0YhKyIWma7u4D7RxGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pNDKMXEt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNDKMXEt"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-643acc141cbso14177287b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636848; x=1720241648; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/0dC8Bwm3vf/Imiu0GWXnmXRUHRnUVX3GhUs/K6jXVQ=;
        b=pNDKMXEt4vuOwp0Iozt4OYhdV1Vq/DiqEbcyJOd3CONAbytZBmHbI3zfMDihqqyjgk
         woA4t5A1zMgoQgW4qA2xtDp141OtP0bqfOKq5bZKnBrawFDMZMlMpbqWzTGzTLRhpmGn
         ne0XRJbRnROJxM8N0ZaL+buLJPK+bcMRJfdyqlwZJI45MdeeIf15MAk6Xm8a8ovsVu3S
         CLMeN9cNYPZit7cOKXJJDTJCqBtim9ZQ4+fIA7pxbnK/aLIq7mJj9qVLexB8LsNQt6cl
         fbHeOuuvbtdEls/OgGK2w8KsOhHz6xBlwjJxtwqNZxxDhL3n3hiWtUjO2VME+Z78B0sf
         pI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636848; x=1720241648;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0dC8Bwm3vf/Imiu0GWXnmXRUHRnUVX3GhUs/K6jXVQ=;
        b=gBmZ0nHLbrl+dp/PiDIykWHXHlrKpP81ntySATlEKg5urd1rSTD+Gc+Ctr+g9Efpfs
         dnmDBy/SMNqAuE1612spJ09BQHIjlTbDWC/DLfSXsBLNC1Mvphe+vlKb0GDntmnD6lQS
         0KMsHifWfEGtPIFZtzxIWrWUnZjTQWM2rQZ8uNOpzxZZX+dYyyxXcyOZLppmGGAK0RBt
         Q439Wq9V50082J0VGwIxrO5UxP6e608FHinINT6mEfy6BBVcU1ksMF7T0QWj6r3umoye
         3KSPOgUjl9FpydnHoqBrTP3n5l2ZmqwDHvrArcdTqPnuXTyVj7bacHwnFbL7XRfoHtao
         CtbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX69AdjHIWV8+vpuUhkNIW+TqG3MxVDcQD81EHWYiY7cm2TR1PuVdM0axtvwrAsJrkvHUwQnF5eSjxyyvXH3b3mf4srVO0KB+rD+pGjSYQR8Q==
X-Gm-Message-State: AOJu0YwVvN9KxwbhscAPvkIN/tjl5W6BxzauN6RoeP+djuf3guDLU9l4
	7UOwquWTTKb4HQ2Uzqkq5YWxGKr6OssLJkK3rQzld92x/Vqqccz6hfkZzpVP53cjqhjvcC7/u62
	GkcT1bw==
X-Google-Smtp-Source: AGHT+IHoHdrZmEBlrpZ6Zqpk1K2Ypd9vGdWOS5MBKTc36yPJSr3winrBSZVjqq0a+AN9vOt7GZ4Og36DCWr+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a81:9281:0:b0:648:2f1d:1329 with SMTP id
 00721157ae682-64c6b773206mr325697b3.1.1719636848038; Fri, 28 Jun 2024
 21:54:08 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:22 -0700
Message-Id: <20240629045350.285243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 00/28]  Constify tool pointers
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

v3: Just remove auxtrace dummy tools [Adrian] and make s390-cpumsf
    struct removal its own patch [Adrian].
v2: Remove dummy tool initialization [Adrian] and make zero sized. Add
    cs-etm fix for address sanitizer build, found necessary when
    testing dummy tool change.

Ian Rogers (28):
  perf auxtrace: Remove dummy tools
  perf s390-cpumsf: Remove unused struct
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
 tools/perf/builtin-inject.c         | 159 ++++++------
 tools/perf/builtin-kmem.c           |  20 +-
 tools/perf/builtin-kvm.c            |  19 +-
 tools/perf/builtin-kwork.c          |  33 ++-
 tools/perf/builtin-lock.c           |  41 ++-
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
 tools/perf/util/arm-spe.c           |  55 +---
 tools/perf/util/auxtrace.c          |  12 +-
 tools/perf/util/auxtrace.h          |  20 +-
 tools/perf/util/bpf-event.c         |   4 +-
 tools/perf/util/build-id.c          |  34 +--
 tools/perf/util/build-id.h          |   8 +-
 tools/perf/util/cs-etm.c            |  49 +---
 tools/perf/util/data-convert-bt.c   |  34 ++-
 tools/perf/util/data-convert-json.c |  47 ++--
 tools/perf/util/dso.h               |  10 +
 tools/perf/util/event.c             |  54 ++--
 tools/perf/util/event.h             |  38 +--
 tools/perf/util/header.c            |   6 +-
 tools/perf/util/header.h            |   4 +-
 tools/perf/util/hisi-ptt.c          |   6 +-
 tools/perf/util/intel-bts.c         |  37 +--
 tools/perf/util/intel-pt.c          |  30 +--
 tools/perf/util/jitdump.c           |   4 +-
 tools/perf/util/s390-cpumsf.c       |  11 +-
 tools/perf/util/session.c           | 372 ++++------------------------
 tools/perf/util/session.h           |   9 +-
 tools/perf/util/synthetic-events.c  |  80 +++---
 tools/perf/util/synthetic-events.h  |  70 +++---
 tools/perf/util/tool.c              | 294 ++++++++++++++++++++++
 tools/perf/util/tool.h              |  18 +-
 tools/perf/util/tsc.c               |   2 +-
 54 files changed, 998 insertions(+), 1107 deletions(-)
 create mode 100644 tools/perf/util/tool.c

-- 
2.45.2.803.g4e1b14247a-goog


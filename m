Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8427E05E
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622543; cv=none; b=jZuWuk/YUMuGg8tZHIYYn9eq4MjoXo4lN4IgIDG+ECdjFZBe9+g6ysIqWDBGgVnEWR5IeuhF9hsYim8YJ9xkeheyJoB7DHJK7cJSPdQUiNK55wZj7CqHAupGmbKvsHn11fShttt3P1MjpQH7vDQuC5pbhQWGV2HyvCrrT4adxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622543; c=relaxed/simple;
	bh=LUgHek8vbiWDOkcjtIU9UCv7EbmsEAOGQ2dFOdHmat4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HVecz5etlMd711rHY4GUmHol8edEImDFJuscikl9zM8EBLXwbHyBL/ZGmJuOBiOTeF2+MAdmMZCdM79aJ1egHOP8gnG8meWgNdKmi1D13J9sudEMLx9Ppb+Cj37chYVTb5I/iKFeIiuac3CtGLDAjXVXXE0TAWtGi50/O123Exs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdFdFhbh; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdFdFhbh"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7ba92341f38so4542604b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 12:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764622540; x=1765227340; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xT8wtJEMfyCmAK5hUMH5sU9s6sTyGN/uGz6ngBwjqc=;
        b=jdFdFhbhC7Kw/dpDzmTLBm+6wBIwDVLbwRhNENoYcI84wT3FZ7iODct1McDjKmk7xN
         2Rn0QoILwX6L58fLcTdsjUrwfb6wQgXcKCqET4jGnKDeAYlkXPTvpcEe1EVs73Vio03e
         1JJhU3x7OJ+SOwj32cp+YwrTuXe8GJl0sfPDg1ogLq9xrMrFHtDA5LGMBGdUCV3j7sEz
         bZxncrJJaPbwNytUxqZM2Df4582S+uDtyRHy6KBh8MTic2PpbPcthoXWwP3GMf70jLml
         Gp4XaMOAeGKIv0vfor8fTSZe0Q2HZOfDmzVUJLxVGKleFILHGQ6EWUilCiNs3eiuJQF3
         VwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764622540; x=1765227340;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xT8wtJEMfyCmAK5hUMH5sU9s6sTyGN/uGz6ngBwjqc=;
        b=TMimuPFF+9kC1o7jaYSujbsIau2uq1bGGMva7RuLLy9vRFdi0tW8i+It1hkzgH3vrm
         v5JObU+ZAD9O2+AJeBAFaX3yFO27fssQmauAOZ7OSg7MW8XUOdtjqBpoUzKAOqjrqAfx
         E1NTozP//pRkUKvDK/oXbti+0LVGzvaqaPtu0M6vJk4Oz+ONvWIg2r+Zj6al6sEFAhVY
         z+YHyRJTI6eVwnEFviN88v9Z78BBEQtEhhRBwb9GRLnw7h6bd+uko8ATYEdZ3CX52MLs
         +AzdiknByB6cYITsGdJ6HWXWq1JiYYyHJ3PPgzfqLmK6eI3/svwibKnfnvOavbOm+s3V
         KEFg==
X-Forwarded-Encrypted: i=1; AJvYcCV48dTCkXhOcDqxvAB5wWVE3P/UkrdsHuDQUGFrztF46IRJJrJQZdblzodoBTur07PJgDZaWkj9cTBX1ydjaMap@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13OmfDkf2q7QdKJGvbNH2bFvx7kluTddcJ5TtwhJ7c9mW9Gy6
	ecM8WG2kgv5UBS4XDWIezzZziAfUfkgeskqasb+8Uta0UUg83jHJBas6dV2hRd2p3Ei31rAbtol
	whmxkEYgipQ==
X-Google-Smtp-Source: AGHT+IHXYsxbKhTOiExqvbHu2q8pVlZxS4dN2TT7L+3HHwF5ECvIXkrd5YPNRU7kCSmbr0naZcrGy4shEL2g
X-Received: from pfus11.prod.google.com ([2002:a05:6a00:8cb:b0:7bf:76b4:31f8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:124d:b0:777:797b:7318
 with SMTP id d2e1a72fcca58-7ca88e8eee2mr29377223b3a.7.1764622539453; Mon, 01
 Dec 2025 12:55:39 -0800 (PST)
Date: Mon,  1 Dec 2025 12:55:03 -0800
In-Reply-To: <20251201205509.195451-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201205509.195451-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201205509.195451-5-irogers@google.com>
Subject: [PATCH v2 04/10] perf symbol: Remove unused includes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove the includes of addr_location.h, spark.h, <elf.h>,
<linux/refcount.h> and <stdint.h> as they're not used in the
file. This caused an issue particularly with addr_location.h where
there were lots of transitive dependencies. Resolve those by adding
the include to the C file.

When adding the necessary includes, sort the includes and fix any
other transitive dependency issues. Also, fix paths to files in util,
erroneously in ../, etc.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c                 | 47 +++++-----
 tools/perf/builtin-c2c.c                      | 58 ++++++------
 tools/perf/builtin-diff.c                     | 22 ++---
 tools/perf/builtin-inject.c                   | 19 ++--
 tools/perf/builtin-kmem.c                     | 41 +++++----
 tools/perf/builtin-kwork.c                    |  9 +-
 tools/perf/builtin-mem.c                      | 16 ++--
 tools/perf/builtin-report.c                   | 76 ++++++++--------
 tools/perf/builtin-sched.c                    | 50 +++++------
 tools/perf/builtin-script.c                   | 89 ++++++++++---------
 tools/perf/builtin-timechart.c                | 34 +++----
 tools/perf/builtin-top.c                      | 85 +++++++++---------
 tools/perf/builtin-trace.c                    | 82 ++++++++---------
 .../scripts/python/Perf-Trace-Util/Context.c  | 11 +--
 tools/perf/tests/code-reading.c               |  1 +
 tools/perf/tests/hists_cumulate.c             |  1 +
 tools/perf/tests/hists_filter.c               |  1 +
 tools/perf/tests/hists_link.c                 |  1 +
 tools/perf/tests/hists_output.c               |  1 +
 tools/perf/tests/mmap-thread-lookup.c         |  1 +
 tools/perf/util/annotate-data.c               |  7 +-
 tools/perf/util/auxtrace.h                    |  1 +
 tools/perf/util/block-info.c                  | 11 +--
 tools/perf/util/build-id.c                    | 28 +++---
 tools/perf/util/callchain.c                   |  1 +
 tools/perf/util/cs-etm.c                      |  1 +
 tools/perf/util/data-convert-json.c           | 30 ++++---
 tools/perf/util/db-export.c                   | 16 ++--
 tools/perf/util/dlfilter.c                    | 11 +--
 tools/perf/util/dlfilter.h                    |  1 +
 tools/perf/util/event.c                       | 41 +++++----
 tools/perf/util/evsel_fprintf.c               | 14 +--
 tools/perf/util/hist.c                        | 29 +++---
 tools/perf/util/intel-pt.c                    | 35 ++++----
 tools/perf/util/kvm-stat.h                    |  5 +-
 tools/perf/util/machine.c                     | 34 +++----
 tools/perf/util/print_insn.c                  | 14 +--
 .../util/scripting-engines/trace-event-perl.c |  1 +
 .../scripting-engines/trace-event-python.c    |  1 +
 tools/perf/util/symbol.h                      | 14 ++-
 tools/perf/util/symbol_fprintf.c              |  1 +
 tools/perf/util/thread-stack.c                | 12 +--
 tools/perf/util/thread.c                      | 18 ++--
 tools/perf/util/unwind-libdw.c                | 15 ++--
 44 files changed, 518 insertions(+), 468 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 9c27bb30b708..2967dd085b82 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -6,45 +6,46 @@
  * look up and read DSOs and symbol information and display
  * a histogram of results, along various sorting keys.
  */
+
+#include <dlfcn.h>
+#include <errno.h>
+#include <inttypes.h>
+
 #include "builtin.h"
 #include "perf.h"
 
-#include "util/color.h"
-#include <linux/list.h>
+#include "arch/common.h"
+#include "ui/progress.h"
+#include "util/addr_location.h"
+#include "util/annotate-data.h"
+#include "util/annotate.h"
+#include "util/block-range.h"
+#include "util/branch.h"
 #include "util/cache.h"
-#include <linux/rbtree.h>
-#include <linux/zalloc.h>
-#include "util/symbol.h"
-
+#include "util/color.h"
+#include "util/data.h"
 #include "util/debug.h"
-
+#include "util/dso.h"
+#include "util/event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
-#include "util/annotate.h"
-#include "util/annotate-data.h"
-#include "util/event.h"
-#include <subcmd/parse-options.h>
-#include "util/parse-events.h"
-#include "util/sort.h"
 #include "util/hist.h"
-#include "util/dso.h"
 #include "util/machine.h"
 #include "util/map.h"
+#include "util/map_symbol.h"
+#include "util/parse-events.h"
 #include "util/session.h"
+#include "util/sort.h"
+#include "util/symbol.h"
 #include "util/tool.h"
-#include "util/data.h"
-#include "arch/common.h"
-#include "util/block-range.h"
-#include "util/map_symbol.h"
-#include "util/branch.h"
 #include "util/util.h"
-#include "ui/progress.h"
 
-#include <dlfcn.h>
-#include <errno.h>
 #include <linux/bitmap.h>
 #include <linux/err.h>
-#include <inttypes.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/zalloc.h>
+#include <subcmd/parse-options.h>
 
 struct perf_annotate {
 	struct perf_tool tool;
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 14c3823f8fed..6cc0060cacca 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -12,41 +12,45 @@
  */
 #include <errno.h>
 #include <inttypes.h>
+#include <sys/param.h>
+
+#include "builtin.h"
+
+#include "ui/browsers/hists.h"
+#include "ui/progress.h"
+#include "ui/ui.h"
+#include "util/addr_location.h"
+#include "util/annotate.h"
+#include "util/cacheline.h"
+#include "util/data.h"
+#include "util/debug.h"
+#include "util/event.h"
+#include "util/evlist.h"
+#include "util/evsel.h"
+#include "util/hist.h"
+#include "util/map_symbol.h"
+#include "util/mem-events.h"
+#include "util/mem-info.h"
+#include "util/mem2node.h"
+#include "util/pmus.h"
+#include "util/session.h"
+#include "util/sort.h"
+#include "util/string2.h"
+#include "util/symbol.h"
+#include "util/symbol.h"
+#include "util/thread.h"
+#include "util/tool.h"
+#include "util/util.h"
+
+#include <asm/bug.h>
 #include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/zalloc.h>
-#include <asm/bug.h>
-#include <sys/param.h>
-#include "debug.h"
-#include "builtin.h"
 #include <perf/cpumap.h>
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
-#include "map_symbol.h"
-#include "mem-events.h"
-#include "session.h"
-#include "hist.h"
-#include "sort.h"
-#include "tool.h"
-#include "cacheline.h"
-#include "data.h"
-#include "event.h"
-#include "evlist.h"
-#include "evsel.h"
-#include "ui/browsers/hists.h"
-#include "thread.h"
-#include "mem2node.h"
-#include "mem-info.h"
-#include "symbol.h"
-#include "ui/ui.h"
-#include "ui/progress.h"
-#include "pmus.h"
-#include "string2.h"
-#include "util/util.h"
-#include "util/symbol.h"
-#include "util/annotate.h"
 
 struct c2c_hists {
 	struct hists		hists;
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 53d5ea4a6a4f..9fc8a18647d1 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -8,25 +8,27 @@
 #include "builtin.h"
 #include "perf.h"
 
+#include "util/addr_location.h"
+#include "util/annotate.h"
+#include "util/block-info.h"
+#include "util/config.h"
+#include "util/data.h"
 #include "util/debug.h"
 #include "util/event.h"
-#include "util/hist.h"
-#include "util/evsel.h"
 #include "util/evlist.h"
+#include "util/evsel.h"
+#include "util/hist.h"
+#include "util/map.h"
 #include "util/session.h"
-#include "util/tool.h"
 #include "util/sort.h"
+#include "util/spark.h"
 #include "util/srcline.h"
+#include "util/stream.h"
 #include "util/symbol.h"
-#include "util/data.h"
-#include "util/config.h"
 #include "util/time-utils.h"
-#include "util/annotate.h"
-#include "util/map.h"
-#include "util/spark.h"
-#include "util/block-info.h"
-#include "util/stream.h"
+#include "util/tool.h"
 #include "util/util.h"
+
 #include <linux/err.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 0e40f2a4bd18..311225944b78 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -8,26 +8,27 @@
  */
 #include "builtin.h"
 
+#include "util/addr_location.h"
+#include "util/auxtrace.h"
+#include "util/build-id.h"
 #include "util/color.h"
+#include "util/data.h"
+#include "util/debug.h"
 #include "util/dso.h"
-#include "util/vdso.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
+#include "util/jit.h"
 #include "util/map.h"
+#include "util/namespaces.h"
 #include "util/session.h"
-#include "util/tool.h"
-#include "util/debug.h"
-#include "util/build-id.h"
-#include "util/data.h"
-#include "util/auxtrace.h"
-#include "util/jit.h"
 #include "util/string2.h"
 #include "util/symbol.h"
 #include "util/synthetic-events.h"
 #include "util/thread.h"
-#include "util/namespaces.h"
-#include "util/util.h"
+#include "util/tool.h"
 #include "util/tsc.h"
+#include "util/util.h"
+#include "util/vdso.h"
 
 #include <internal/lib.h>
 
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 7929a5fa5f46..e9f5b3ff24e7 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1,42 +1,41 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <inttypes.h>
+#include <locale.h>
+#include <regex.h>
+
 #include "builtin.h"
 
+#include "util/addr_location.h"
+#include "util/callchain.h"
+#include "util/config.h"
+#include "util/cpumap.h"
+#include "util/data.h"
+#include "util/debug.h"
 #include "util/dso.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
-#include "util/config.h"
+#include "util/header.h"
 #include "util/map.h"
+#include "util/session.h"
+#include "util/string2.h"
 #include "util/symbol.h"
 #include "util/thread.h"
-#include "util/header.h"
-#include "util/session.h"
-#include "util/tool.h"
-#include "util/callchain.h"
 #include "util/time-utils.h"
-#include <linux/err.h>
-
-#include <subcmd/pager.h>
-#include <subcmd/parse-options.h>
+#include "util/tool.h"
 #include "util/trace-event.h"
-#include "util/data.h"
-#include "util/cpumap.h"
-
-#include "util/debug.h"
-#include "util/string2.h"
 #include "util/util.h"
 
+#include <event-parse.h>
+#include <linux/ctype.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/numa.h>
 #include <linux/rbtree.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
-#include <errno.h>
-#include <inttypes.h>
-#include <locale.h>
-#include <regex.h>
-
-#include <linux/ctype.h>
-#include <event-parse.h>
+#include <subcmd/pager.h>
+#include <subcmd/parse-options.h>
 
 static int	kmem_slab;
 static int	kmem_page;
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 7f3068264568..4a274c550cdf 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -8,18 +8,19 @@
 #include "builtin.h"
 #include "perf.h"
 
+#include "util/addr_location.h"
+#include "util/callchain.h"
 #include "util/data.h"
+#include "util/debug.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
+#include "util/evsel_fprintf.h"
 #include "util/header.h"
 #include "util/kwork.h"
-#include "util/debug.h"
 #include "util/session.h"
+#include "util/string2.h"
 #include "util/symbol.h"
 #include "util/thread.h"
-#include "util/string2.h"
-#include "util/callchain.h"
-#include "util/evsel_fprintf.h"
 #include "util/util.h"
 
 #include <subcmd/pager.h>
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index d43500b92a7b..bad3784bd119 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -7,24 +7,26 @@
 #include "builtin.h"
 #include "perf.h"
 
-#include <subcmd/parse-options.h>
+#include "util/addr_location.h"
 #include "util/auxtrace.h"
-#include "util/trace-event.h"
-#include "util/tool.h"
-#include "util/session.h"
 #include "util/data.h"
-#include "util/map_symbol.h"
-#include "util/mem-events.h"
 #include "util/debug.h"
 #include "util/dso.h"
 #include "util/map.h"
-#include "util/symbol.h"
+#include "util/map_symbol.h"
+#include "util/mem-events.h"
 #include "util/pmus.h"
 #include "util/sample.h"
+#include "util/session.h"
 #include "util/sort.h"
 #include "util/string2.h"
+#include "util/symbol.h"
+#include "util/tool.h"
+#include "util/trace-event.h"
 #include "util/util.h"
+
 #include <linux/err.h>
+#include <subcmd/parse-options.h>
 
 #define MEM_OPERATION_LOAD	0x1
 #define MEM_OPERATION_STORE	0x2
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2bc269f5fcef..cdc7dd8d6320 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -6,68 +6,66 @@
  * look up and read DSOs and symbol information and display
  * a histogram of results, along various sorting keys.
  */
-#include "builtin.h"
+#include <dlfcn.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <regex.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
 
-#include "util/config.h"
+#include "builtin.h"
+#include "perf.h"
 
+#include "arch/common.h"
+#include "ui/progress.h"
+#include "ui/ui.h"
+#include "util/addr_location.h"
 #include "util/annotate.h"
-#include "util/color.h"
-#include "util/dso.h"
-#include <linux/list.h>
-#include <linux/rbtree.h>
-#include <linux/err.h>
-#include <linux/zalloc.h>
-#include "util/map.h"
-#include "util/symbol.h"
-#include "util/map_symbol.h"
-#include "util/mem-events.h"
+#include "util/auxtrace.h"
+#include "util/block-info.h"
 #include "util/branch.h"
 #include "util/callchain.h"
-#include "util/values.h"
-
-#include "perf.h"
+#include "util/color.h"
+#include "util/config.h"
+#include "util/data.h"
 #include "util/debug.h"
+#include "util/dso.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/evswitch.h"
 #include "util/header.h"
+#include "util/hist.h"
+#include "util/map.h"
+#include "util/map_symbol.h"
+#include "util/mem-events.h"
 #include "util/mem-info.h"
+#include "util/parse-events.h"
 #include "util/session.h"
+#include "util/sort.h"
 #include "util/srcline.h"
-#include "util/tool.h"
-
-#include <subcmd/parse-options.h>
-#include <subcmd/exec-cmd.h>
-#include "util/parse-events.h"
-
+#include "util/symbol.h"
 #include "util/thread.h"
-#include "util/sort.h"
-#include "util/hist.h"
-#include "util/data.h"
-#include "arch/common.h"
 #include "util/time-utils.h"
-#include "util/auxtrace.h"
+#include "util/tool.h"
 #include "util/units.h"
 #include "util/util.h" // perf_tip()
-#include "ui/ui.h"
-#include "ui/progress.h"
-#include "util/block-info.h"
+#include "util/values.h"
 
-#include <dlfcn.h>
-#include <errno.h>
-#include <inttypes.h>
-#include <regex.h>
-#include <linux/ctype.h>
-#include <signal.h>
 #include <linux/bitmap.h>
+#include <linux/ctype.h>
+#include <linux/err.h>
+#include <linux/list.h>
 #include <linux/list_sort.h>
+#include <linux/mman.h>
+#include <linux/rbtree.h>
 #include <linux/string.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <linux/mman.h>
+#include <linux/zalloc.h>
+#include <subcmd/exec-cmd.h>
+#include <subcmd/parse-options.h>
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index eca3b1c58c4b..bc9e098642df 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1,51 +1,49 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
+#include <errno.h>
+#include <semaphore.h>
+#include <pthread.h>
+#include <math.h>
+
 #include "builtin.h"
 #include "perf.h"
 #include "perf-sys.h"
 
+#include "util/addr_location.h"
+#include "util/callchain.h"
+#include "util/cloexec.h"
+#include "util/color.h"
 #include "util/cpumap.h"
+#include "util/debug.h"
+#include "util/event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/evsel_fprintf.h"
-#include "util/mutex.h"
-#include "util/symbol.h"
-#include "util/thread.h"
 #include "util/header.h"
+#include "util/mutex.h"
 #include "util/session.h"
-#include "util/tool.h"
-#include "util/cloexec.h"
-#include "util/thread_map.h"
-#include "util/color.h"
 #include "util/stat.h"
 #include "util/string2.h"
-#include "util/callchain.h"
+#include "util/symbol.h"
+#include "util/thread.h"
+#include "util/thread_map.h"
 #include "util/time-utils.h"
-
-#include <subcmd/pager.h>
-#include <subcmd/parse-options.h>
+#include "util/tool.h"
 #include "util/trace-event.h"
-
-#include "util/debug.h"
-#include "util/event.h"
 #include "util/util.h"
 
+#include <api/fs/fs.h>
+#include <linux/ctype.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/time64.h>
 #include <linux/zalloc.h>
+#include <perf/cpumap.h>
+#include <subcmd/pager.h>
+#include <subcmd/parse-options.h>
 #include <sys/prctl.h>
 #include <sys/resource.h>
-#include <inttypes.h>
-
-#include <errno.h>
-#include <semaphore.h>
-#include <pthread.h>
-#include <math.h>
-#include <api/fs/fs.h>
-#include <perf/cpumap.h>
-#include <linux/time64.h>
-#include <linux/err.h>
-
-#include <linux/ctype.h>
 
 #define PR_SET_NAME		15               /* Set process name */
 #define MAX_CPUS		4096
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 011962e1ee0f..ba363884a79d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1,73 +1,76 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+
 #include "builtin.h"
+#include "perf.h"
 
+#include "ui/ui.h"
+#include "util/addr_location.h"
+#include "util/annotate.h"
+#include "util/archinsn.h"
+#include "util/auxtrace.h"
+#include "util/cgroup.h"
+#include "util/color.h"
 #include "util/counts.h"
+#include "util/cpumap.h"
+#include "util/data.h"
 #include "util/debug.h"
+#include "util/dlfilter.h"
 #include "util/dso.h"
-#include <subcmd/exec-cmd.h>
-#include "util/header.h"
-#include <subcmd/parse-options.h>
-#include "util/perf_regs.h"
-#include "util/session.h"
-#include "util/tool.h"
-#include "util/map.h"
-#include "util/srcline.h"
-#include "util/symbol.h"
-#include "util/thread.h"
-#include "util/trace-event.h"
+#include "util/dump-insn.h"
 #include "util/env.h"
+#include "util/event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/evsel_fprintf.h"
 #include "util/evswitch.h"
+#include "util/header.h"
+#include "util/map.h"
+#include "util/mem-events.h"
+#include "util/mem-info.h"
+#include "util/metricgroup.h"
+#include "util/path.h"
+#include "util/perf_regs.h"
+#include "util/print_binary.h"
+#include "util/print_insn.h"
+#include "util/record.h"
+#include "util/session.h"
 #include "util/sort.h"
-#include "util/data.h"
-#include "util/auxtrace.h"
-#include "util/cpumap.h"
-#include "util/thread_map.h"
+#include "util/srcline.h"
 #include "util/stat.h"
-#include "util/color.h"
 #include "util/string2.h"
+#include "util/symbol.h"
 #include "util/thread-stack.h"
+#include "util/thread.h"
+#include "util/thread_map.h"
 #include "util/time-utils.h"
-#include "util/path.h"
-#include "util/event.h"
-#include "util/mem-info.h"
-#include "util/metricgroup.h"
-#include "ui/ui.h"
-#include "print_binary.h"
-#include "print_insn.h"
-#include "archinsn.h"
+#include "util/tool.h"
+#include "util/trace-event.h"
+#include "util/util.h"
+
+#include <asm/bug.h>
 #include <linux/bitmap.h>
 #include <linux/compiler.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
-#include <linux/zalloc.h>
 #include <linux/unaligned.h>
-#include <sys/utsname.h>
-#include "asm/bug.h"
-#include "util/mem-events.h"
-#include "util/dump-insn.h"
-#include <dirent.h>
-#include <errno.h>
-#include <inttypes.h>
+#include <linux/zalloc.h>
+#include <perf/evlist.h>
 #include <signal.h>
 #include <stdio.h>
+#include <subcmd/exec-cmd.h>
+#include <subcmd/pager.h>
+#include <subcmd/parse-options.h>
 #include <sys/param.h>
-#include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/utsname.h>
 #include <unistd.h>
-#include <subcmd/pager.h>
-#include <perf/evlist.h>
-#include <linux/err.h>
-#include "util/dlfilter.h"
-#include "util/record.h"
-#include "util/util.h"
-#include "util/cgroup.h"
-#include "util/annotate.h"
-#include "perf.h"
 
 #include <linux/ctype.h>
 #ifdef HAVE_LIBTRACEEVENT
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 22050c640dfa..3f464df723d4 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -12,33 +12,35 @@
 #include <inttypes.h>
 
 #include "builtin.h"
+
+#include "util/addr_location.h"
+#include "util/callchain.h"
 #include "util/color.h"
-#include <linux/list.h>
+#include "util/data.h"
+#include "util/debug.h"
+#include "util/event.h"
 #include "util/evlist.h" // for struct evsel_str_handler
 #include "util/evsel.h"
-#include <linux/kernel.h>
-#include <linux/rbtree.h>
-#include <linux/time64.h>
-#include <linux/zalloc.h>
-#include "util/symbol.h"
-#include "util/thread.h"
-#include "util/callchain.h"
-
 #include "util/header.h"
-#include <subcmd/pager.h>
-#include <subcmd/parse-options.h>
 #include "util/parse-events.h"
-#include "util/event.h"
 #include "util/session.h"
+#include "util/string2.h"
 #include "util/svghelper.h"
+#include "util/symbol.h"
+#include "util/thread.h"
 #include "util/tool.h"
-#include "util/data.h"
-#include "util/debug.h"
-#include "util/string2.h"
 #include "util/tracepoint.h"
 #include "util/util.h"
-#include <linux/err.h>
+
 #include <event-parse.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/time64.h>
+#include <linux/zalloc.h>
+#include <subcmd/pager.h>
+#include <subcmd/parse-options.h>
 
 #ifdef LACKS_OPEN_MEMSTREAM_PROTOTYPE
 FILE *open_memstream(char **ptr, size_t *sizeloc);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 710604c4f6f6..60cb08783457 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -16,77 +16,72 @@
  *   Mike Galbraith <efault@gmx.de>
  *   Paul Mackerras <paulus@samba.org>
  */
-#include "builtin.h"
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <poll.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
+#include <sys/uio.h>
+#include <sys/utsname.h>
+#include <sys/wait.h>
+#include <termios.h>
+#include <time.h>
+#include <unistd.h>
 
+#include "builtin.h"
 #include "perf.h"
 
+#include "arch/common.h"
+#include "ui/ui.h"
+#include "util/addr_location.h"
 #include "util/annotate.h"
 #include "util/bpf-event.h"
+#include "util/callchain.h"
 #include "util/cgroup.h"
-#include "util/config.h"
 #include "util/color.h"
+#include "util/config.h"
+#include "util/cpumap.h"
+#include "util/debug.h"
 #include "util/dso.h"
+#include "util/event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/evsel_config.h"
-#include "util/event.h"
+#include "util/intlist.h"
 #include "util/machine.h"
 #include "util/map.h"
 #include "util/mmap.h"
+#include "util/ordered-events.h"
+#include "util/parse-branch-options.h"
+#include "util/parse-events.h"
+#include "util/pfm.h"
 #include "util/session.h"
-#include "util/thread.h"
+#include "util/sort.h"
 #include "util/stat.h"
+#include "util/string2.h"
 #include "util/symbol.h"
 #include "util/synthetic-events.h"
+#include "util/term.h"
+#include "util/thread.h"
 #include "util/top.h"
 #include "util/util.h"
-#include <linux/rbtree.h>
-#include <subcmd/parse-options.h>
-#include "util/parse-events.h"
-#include "util/callchain.h"
-#include "util/cpumap.h"
-#include "util/sort.h"
-#include "util/string2.h"
-#include "util/term.h"
-#include "util/intlist.h"
-#include "util/parse-branch-options.h"
-#include "arch/common.h"
-#include "ui/ui.h"
 
-#include "util/debug.h"
-#include "util/ordered-events.h"
-#include "util/pfm.h"
-
-#include <assert.h>
 #include <elf.h>
-#include <fcntl.h>
-
-#include <stdio.h>
-#include <termios.h>
-#include <unistd.h>
-#include <inttypes.h>
-
-#include <errno.h>
-#include <time.h>
-#include <sched.h>
-#include <signal.h>
-
-#include <sys/syscall.h>
-#include <sys/ioctl.h>
-#include <poll.h>
-#include <sys/prctl.h>
-#include <sys/wait.h>
-#include <sys/uio.h>
-#include <sys/utsname.h>
-#include <sys/mman.h>
-
+#include <linux/ctype.h>
+#include <linux/err.h>
+#include <linux/rbtree.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
 #include <linux/types.h>
-#include <linux/err.h>
-
-#include <linux/ctype.h>
 #include <perf/mmap.h>
+#include <subcmd/parse-options.h>
 
 static volatile sig_atomic_t done;
 static volatile sig_atomic_t resize;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a743bda294bd..f4791b9b8b3b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -13,17 +13,22 @@
  *
  * http://lwn.net/Articles/415728/ ("Announcing a new utility: 'trace'")
  */
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/sysmacros.h>
 
-#include "util/record.h"
-#include <api/fs/tracing_path.h>
-#ifdef HAVE_LIBBPF_SUPPORT
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include <bpf/btf.h>
-#endif
-#include "util/bpf_map.h"
-#include "util/rlimit.h"
 #include "builtin.h"
+#include "perf.h"
+
+#include "trace/beauty/beauty.h"
+#include "util/addr_location.h"
+#include "util/bpf_map.h"
+#include "util/callchain.h"
 #include "util/cgroup.h"
 #include "util/color.h"
 #include "util/config.h"
@@ -31,47 +36,39 @@
 #include "util/dso.h"
 #include "util/env.h"
 #include "util/event.h"
+#include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/evsel_fprintf.h"
-#include "util/synthetic-events.h"
-#include "util/evlist.h"
 #include "util/evswitch.h"
 #include "util/hashmap.h"
-#include "util/mmap.h"
-#include <subcmd/pager.h>
-#include <subcmd/exec-cmd.h>
+#include "util/include/dwarf-regs.h"
+#include "util/intlist.h"
 #include "util/machine.h"
 #include "util/map.h"
-#include "util/symbol.h"
+#include "util/mmap.h"
+#include "util/parse-events.h"
 #include "util/path.h"
+#include "util/print_binary.h"
+#include "util/record.h"
+#include "util/rlimit.h"
 #include "util/session.h"
-#include "util/thread.h"
-#include <subcmd/parse-options.h>
+#include "util/stat.h"
+#include "util/string2.h"
 #include "util/strlist.h"
-#include "util/intlist.h"
+#include "util/symbol.h"
+#include "util/synthetic-events.h"
+#include "util/syscalltbl.h"
+#include "util/thread.h"
 #include "util/thread_map.h"
-#include "util/stat.h"
 #include "util/tool.h"
+#include "util/trace-event.h"
 #include "util/trace.h"
-#include "util/util.h"
-#include "trace/beauty/beauty.h"
-#include "trace-event.h"
-#include "util/parse-events.h"
+#include "util/trace_augment.h"
 #include "util/tracepoint.h"
-#include "callchain.h"
-#include "print_binary.h"
-#include "string2.h"
-#include "syscalltbl.h"
-#include "../perf.h"
-#include "trace_augment.h"
-#include "dwarf-regs.h"
+#include "util/util.h"
 
-#include <errno.h>
-#include <inttypes.h>
-#include <poll.h>
-#include <signal.h>
-#include <stdlib.h>
-#include <string.h>
+#include <api/fs/tracing_path.h>
+#include <linux/ctype.h>
 #include <linux/err.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
@@ -80,13 +77,18 @@
 #include <linux/stringify.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
-#include <fcntl.h>
-#include <sys/sysmacros.h>
-
-#include <linux/ctype.h>
 #include <perf/mmap.h>
+#include <subcmd/exec-cmd.h>
+#include <subcmd/pager.h>
+#include <subcmd/parse-options.h>
 #include <tools/libc_compat.h>
 
+#ifdef HAVE_LIBBPF_SUPPORT
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <bpf/btf.h>
+#endif
+
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
 #endif
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 60dcfe56d4d9..aeafcc71cb08 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -12,17 +12,18 @@
 #define PY_SSIZE_T_CLEAN
 
 #include <Python.h>
+#include "../../../util/addr_location.h"
+#include "../../../util/auxtrace.h"
 #include "../../../util/config.h"
-#include "../../../util/trace-event.h"
 #include "../../../util/event.h"
-#include "../../../util/symbol.h"
-#include "../../../util/thread.h"
 #include "../../../util/map.h"
 #include "../../../util/maps.h"
-#include "../../../util/auxtrace.h"
 #include "../../../util/session.h"
-#include "../../../util/srcline.h"
 #include "../../../util/srccode.h"
+#include "../../../util/srcline.h"
+#include "../../../util/symbol.h"
+#include "../../../util/thread.h"
+#include "../../../util/trace-event.h"
 
 #define _PyCapsule_GetPointer(arg1, arg2) \
   PyCapsule_GetPointer((arg1), (arg2))
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 5927d1ea20e2..cff0ecb0a805 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -15,6 +15,7 @@
 #include <perf/evlist.h>
 #include <perf/mmap.h>
 
+#include "addr_location.h"
 #include "debug.h"
 #include "dso.h"
 #include "env.h"
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 3eb9ef8d7ec6..c0931f639fb0 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "util/addr_location.h"
 #include "util/debug.h"
 #include "util/dso.h"
 #include "util/event.h"
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 1cebd20cc91c..24f98c874ba6 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "util/addr_location.h"
 #include "util/debug.h"
 #include "util/map.h"
 #include "util/symbol.h"
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 996f5f0b3bd1..04197fcdfa9b 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "tests.h"
+#include "addr_location.h"
 #include "debug.h"
 #include "symbol.h"
 #include "sort.h"
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index ee5ec8bda60e..5e121f2181de 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "util/addr_location.h"
 #include "util/debug.h"
 #include "util/dso.h"
 #include "util/event.h"
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 0c5619c6e6e9..f39dc0b28810 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -7,6 +7,7 @@
 #include <pthread.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include "addr_location.h"
 #include "debug.h"
 #include "env.h"
 #include "event.h"
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 07cf9c334be0..85ab4330da0b 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -10,14 +10,15 @@
 #include <inttypes.h>
 #include <linux/zalloc.h>
 
-#include "annotate.h"
+#include "addr_location.h"
 #include "annotate-data.h"
-#include "debuginfo.h"
+#include "annotate.h"
 #include "debug.h"
+#include "debuginfo.h"
 #include "dso.h"
 #include "dwarf-regs.h"
-#include "evsel.h"
 #include "evlist.h"
+#include "evsel.h"
 #include "map.h"
 #include "map_symbol.h"
 #include "sort.h"
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index eee2c11f7666..a07e9b6ab24d 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -8,6 +8,7 @@
 #define __PERF_AUXTRACE_H
 
 #include <stdio.h> // FILE
+#include <unistd.h> // pid_t
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <asm/barrier.h>
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 649392bee7ed..15e42e9fb2e8 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -2,15 +2,16 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/zalloc.h>
-#include "block-info.h"
-#include "sort.h"
+#include "addr_location.h"
 #include "annotate.h"
-#include "symbol.h"
+#include "block-info.h"
 #include "dso.h"
-#include "map.h"
-#include "srcline.h"
 #include "evlist.h"
 #include "hist.h"
+#include "map.h"
+#include "sort.h"
+#include "srcline.h"
+#include "symbol.h"
 #include "ui/browsers/hists.h"
 
 static struct block_header_column {
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index fdb35133fde4..9e1f8d5f6d51 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -7,38 +7,40 @@
  * Copyright (C) 2009, 2010 Red Hat Inc.
  * Copyright (C) 2009, 2010 Arnaldo Carvalho de Melo <acme@redhat.com>
  */
-#include "util.h" // lsdir(), mkdir_p(), rm_rf()
 #include <dirent.h>
 #include <errno.h>
 #include <stdio.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-#include "util/copyfile.h"
-#include "dso.h"
+
+#include "addr_location.h"
 #include "build-id.h"
+#include "copyfile.h"
+#include "debug.h"
+#include "dso.h"
 #include "event.h"
-#include "namespaces.h"
+#include "header.h"
 #include "map.h"
+#include "namespaces.h"
+#include "path.h"
+#include "probe-file.h"
+#include "session.h"
+#include "strlist.h"
 #include "symbol.h"
 #include "thread.h"
-#include <linux/kernel.h>
-#include "debug.h"
-#include "session.h"
 #include "tool.h"
-#include "header.h"
+#include "util.h" // lsdir(), mkdir_p(), rm_rf()
 #include "vdso.h"
-#include "path.h"
-#include "probe-file.h"
-#include "strlist.h"
 
 #ifdef HAVE_DEBUGINFOD_SUPPORT
 #include <elfutils/debuginfod.h>
 #endif
 
+#include <asm/bug.h>
 #include <linux/ctype.h>
-#include <linux/zalloc.h>
+#include <linux/kernel.h>
 #include <linux/string.h>
-#include <asm/bug.h>
+#include <linux/zalloc.h>
 
 static bool no_buildid_cache;
 
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index d7b7eef740b9..9c295b38d1e1 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -21,6 +21,7 @@
 
 #include "asm/bug.h"
 
+#include "addr_location.h"
 #include "debug.h"
 #include "dso.h"
 #include "event.h"
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 25d56e0f1c07..cb499a81625a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -17,6 +17,7 @@
 
 #include <stdlib.h>
 
+#include "addr_location.h"
 #include "auxtrace.h"
 #include "color.h"
 #include "cs-etm.h"
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 9dc1e184cf3c..aec1302e599b 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -12,20 +12,22 @@
 #include <sys/stat.h>
 #include <unistd.h>
 
-#include "linux/compiler.h"
-#include "linux/err.h"
-#include "util/auxtrace.h"
-#include "util/debug.h"
-#include "util/dso.h"
-#include "util/event.h"
-#include "util/evsel.h"
-#include "util/evlist.h"
-#include "util/header.h"
-#include "util/map.h"
-#include "util/session.h"
-#include "util/symbol.h"
-#include "util/thread.h"
-#include "util/tool.h"
+#include "addr_location.h"
+#include "auxtrace.h"
+#include "debug.h"
+#include "dso.h"
+#include "event.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "header.h"
+#include "map.h"
+#include "session.h"
+#include "symbol.h"
+#include "thread.h"
+#include "tool.h"
+
+#include <linux/compiler.h>
+#include <linux/err.h>
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 8f52e8cefcf3..5c23b1b2eafb 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -7,18 +7,20 @@
 #include <errno.h>
 #include <stdlib.h>
 
+#include "addr_location.h"
+#include "call-path.h"
+#include "callchain.h"
+#include "comm.h"
+#include "db-export.h"
 #include "dso.h"
+#include "event.h"
 #include "evsel.h"
 #include "machine.h"
-#include "thread.h"
-#include "comm.h"
-#include "symbol.h"
 #include "map.h"
-#include "event.h"
+#include "symbol.h"
 #include "thread-stack.h"
-#include "callchain.h"
-#include "call-path.h"
-#include "db-export.h"
+#include "thread.h"
+
 #include <linux/zalloc.h>
 
 int db_export__init(struct db_export *dbe)
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index c0afcbd954f8..70e322de711f 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -13,17 +13,18 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 
+#include "../include/perf/perf_dlfilter.h"
+#include "addr_location.h"
 #include "debug.h"
+#include "dlfilter.h"
+#include "dso.h"
 #include "event.h"
 #include "evsel.h"
-#include "dso.h"
 #include "map.h"
+#include "srcline.h"
+#include "symbol.h"
 #include "thread.h"
 #include "trace-event.h"
-#include "symbol.h"
-#include "srcline.h"
-#include "dlfilter.h"
-#include "../include/perf/perf_dlfilter.h"
 
 static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 {
diff --git a/tools/perf/util/dlfilter.h b/tools/perf/util/dlfilter.h
index cc4bb9657d05..522d8e707db0 100644
--- a/tools/perf/util/dlfilter.h
+++ b/tools/perf/util/dlfilter.h
@@ -13,6 +13,7 @@ struct perf_sample;
 struct evsel;
 struct machine;
 struct addr_location;
+struct option;
 struct perf_dlfilter_fns;
 struct perf_dlfilter_sample;
 struct perf_dlfilter_al;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index fcf44149feb2..f4a3f76edad2 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1,42 +1,45 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
-#include <linux/compiler.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <perf/cpumap.h>
-#include <perf/event.h>
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
-#include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
-#include <linux/perf_event.h>
-#include <linux/zalloc.h>
+
+#include "addr_location.h"
+#include "bpf-event.h"
 #include "cpumap.h"
+#include "debug.h"
 #include "dso.h"
 #include "event.h"
-#include "debug.h"
 #include "hist.h"
 #include "machine.h"
+#include "map.h"
+#include "print_binary.h"
+#include "session.h"
 #include "sort.h"
+#include "stat.h"
 #include "string2.h"
 #include "strlist.h"
+#include "symbol.h"
+#include "symbol/kallsyms.h"
 #include "thread.h"
 #include "thread_map.h"
 #include "time-utils.h"
-#include <linux/ctype.h>
-#include "map.h"
-#include "util/namespaces.h"
-#include "symbol.h"
-#include "symbol/kallsyms.h"
-#include "asm/bug.h"
-#include "stat.h"
-#include "session.h"
-#include "bpf-event.h"
-#include "print_binary.h"
 #include "tool.h"
 #include "util.h"
+#include "namespaces.h"
+
+#include <asm/bug.h>
+#include <linux/compiler.h>
+#include <linux/ctype.h>
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/types.h>
+#include <linux/zalloc.h>
+#include <perf/cpumap.h>
+#include <perf/event.h>
+#include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
 
 static const char *perf_event__names[] = {
 	[0]					= "TOTAL",
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 103984b29b1e..abdd9985c4e3 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -2,16 +2,18 @@
 #include <inttypes.h>
 #include <stdio.h>
 #include <stdbool.h>
-#include "util/evlist.h"
-#include "evsel.h"
-#include "util/evsel_fprintf.h"
-#include "util/event.h"
+
+#include "addr_location.h"
 #include "callchain.h"
+#include "dso.h"
+#include "event.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "evsel_fprintf.h"
 #include "map.h"
+#include "srcline.h"
 #include "strlist.h"
 #include "symbol.h"
-#include "srcline.h"
-#include "dso.h"
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 64ff427040c3..bd71e48c1183 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1,32 +1,35 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <math.h>
+#include <inttypes.h>
+#include <sys/param.h>
+
+#include "addr_location.h"
+#include "annotate.h"
+#include "block-info.h"
+#include "branch.h"
+#include "build-id.h"
 #include "callchain.h"
+#include "cgroup.h"
 #include "debug.h"
 #include "dso.h"
-#include "build-id.h"
+#include "evlist.h"
+#include "evsel.h"
 #include "hist.h"
 #include "kvm-stat.h"
 #include "map.h"
 #include "map_symbol.h"
-#include "branch.h"
 #include "mem-events.h"
 #include "mem-info.h"
-#include "session.h"
 #include "namespaces.h"
-#include "cgroup.h"
+#include "session.h"
 #include "sort.h"
-#include "units.h"
-#include "evlist.h"
-#include "evsel.h"
-#include "annotate.h"
 #include "srcline.h"
 #include "symbol.h"
 #include "thread.h"
-#include "block-info.h"
 #include "ui/progress.h"
-#include <errno.h>
-#include <math.h>
-#include <inttypes.h>
-#include <sys/param.h>
+#include "units.h"
+
 #include <linux/rbtree.h>
 #include <linux/string.h>
 #include <linux/time64.h>
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index fc9eec8b54b8..244749c89770 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -14,29 +14,30 @@
 #include <linux/types.h>
 #include <linux/zalloc.h>
 
-#include "session.h"
-#include "machine.h"
-#include "memswap.h"
-#include "sort.h"
-#include "tool.h"
+#include "addr_location.h"
+#include "auxtrace.h"
+#include "callchain.h"
+#include "color.h"
+#include "config.h"
+#include "debug.h"
+#include "dso.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
+#include "intel-pt.h"
+#include "machine.h"
 #include "map.h"
-#include "color.h"
-#include "thread.h"
-#include "thread-stack.h"
+#include "memswap.h"
+#include "perf_api_probe.h"
+#include "session.h"
+#include "sort.h"
 #include "symbol.h"
-#include "callchain.h"
-#include "dso.h"
-#include "debug.h"
-#include "auxtrace.h"
-#include "tsc.h"
-#include "intel-pt.h"
-#include "config.h"
-#include "util/perf_api_probe.h"
-#include "util/synthetic-events.h"
+#include "synthetic-events.h"
+#include "thread-stack.h"
+#include "thread.h"
 #include "time-utils.h"
+#include "tool.h"
+#include "tsc.h"
 
 #include "../arch/x86/include/uapi/asm/perf_regs.h"
 
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index a356b839c2ee..7b63b1ba1b8a 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -4,11 +4,12 @@
 
 #ifdef HAVE_KVM_STAT_SUPPORT
 
-#include "tool.h"
+#include "addr_location.h"
+#include "record.h"
 #include "sort.h"
 #include "stat.h"
 #include "symbol.h"
-#include "record.h"
+#include "tool.h"
 
 #include <errno.h>
 #include <stdlib.h>
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b5dd42588c91..db8052443259 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3,8 +3,19 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
+#include <stdbool.h>
 #include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "addr_location.h"
+#include "arm64-frame-pointer-unwind-support.h"
+#include "asm/bug.h"
+#include "bpf-event.h"
+#include "branch.h"
 #include "callchain.h"
+#include "cgroup.h"
 #include "debug.h"
 #include "dso.h"
 #include "env.h"
@@ -14,37 +25,28 @@
 #include "machine.h"
 #include "map.h"
 #include "map_symbol.h"
-#include "branch.h"
 #include "mem-events.h"
 #include "mem-info.h"
 #include "path.h"
+#include "sort.h"
 #include "srcline.h"
+#include "strlist.h"
 #include "symbol.h"
 #include "synthetic-events.h"
-#include "sort.h"
-#include "strlist.h"
 #include "target.h"
 #include "thread.h"
+#include "unwind.h"
 #include "util.h"
 #include "vdso.h"
-#include <stdbool.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include "unwind.h"
-#include "linux/hash.h"
-#include "asm/bug.h"
-#include "bpf-event.h"
-#include <internal/lib.h> // page_size
-#include "cgroup.h"
-#include "arm64-frame-pointer-unwind-support.h"
-#include <api/io_dir.h>
 
+#include <api/io_dir.h>
+#include <internal/lib.h> // page_size
 #include <linux/ctype.h>
-#include <symbol/kallsyms.h>
+#include <linux/hash.h>
 #include <linux/mman.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <symbol/kallsyms.h>
 
 static struct dso *machine__kernel_dso(struct machine *machine)
 {
diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index 02e6fbb8ca04..07f9c9f6e244 100644
--- a/tools/perf/util/print_insn.c
+++ b/tools/perf/util/print_insn.c
@@ -5,18 +5,20 @@
  * Author(s): Changbin Du <changbin.du@huawei.com>
  */
 #include <inttypes.h>
-#include <string.h>
 #include <stdbool.h>
+#include <string.h>
+
+#include "addr_location.h"
 #include "capstone.h"
 #include "debug.h"
+#include "dso.h"
+#include "dump-insn.h"
+#include "machine.h"
+#include "map.h"
+#include "print_insn.h"
 #include "sample.h"
 #include "symbol.h"
-#include "machine.h"
 #include "thread.h"
-#include "print_insn.h"
-#include "dump-insn.h"
-#include "map.h"
-#include "dso.h"
 
 size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
 {
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index e261a57b87d4..9116ffa252b4 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -35,6 +35,7 @@
 #include <EXTERN.h>
 #include <perl.h>
 
+#include "../addr_location.h"
 #include "../callchain.h"
 #include "../dso.h"
 #include "../machine.h"
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 6655c0bbe0d8..aacb4dc3cb90 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -34,6 +34,7 @@
 #include <event-parse.h>
 #endif
 
+#include "../addr_location.h"
 #include "../build-id.h"
 #include "../counts.h"
 #include "../debug.h"
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 393a528326d5..2b2bbb5914b9 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -2,20 +2,18 @@
 #ifndef __PERF_SYMBOL
 #define __PERF_SYMBOL 1
 
-#include <linux/types.h>
-#include <linux/refcount.h>
 #include <stdbool.h>
-#include <stdint.h>
+#include <stdio.h>
+#include <elf.h>
+
+#include <linux/types.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
-#include <stdio.h>
-#include "addr_location.h"
+
 #include "path.h"
 #include "symbol_conf.h"
-#include "spark.h"
-
-#include <elf.h>
 
+struct addr_location;
 struct dso;
 struct map;
 struct maps;
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index 53e1af4ed9ac..59aa97c0a997 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -3,6 +3,7 @@
 #include <inttypes.h>
 #include <stdio.h>
 
+#include "addr_location.h"
 #include "dso.h"
 #include "map.h"
 #include "symbol.h"
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index c6a0a27b12c2..0d0cbc1250e9 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -11,15 +11,17 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
-#include "thread.h"
+
+#include "addr_location.h"
+#include "call-path.h"
+#include "comm.h"
+#include "debug.h"
+#include "env.h"
 #include "event.h"
 #include "machine.h"
-#include "env.h"
-#include "debug.h"
 #include "symbol.h"
-#include "comm.h"
-#include "call-path.h"
 #include "thread-stack.h"
+#include "thread.h"
 
 #define STACK_GROWTH 2048
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index aa9c58bbf9d3..bf051074d66c 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -7,18 +7,20 @@
 #include <string.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
-#include "dso.h"
-#include "session.h"
-#include "thread.h"
-#include "thread-stack.h"
-#include "debug.h"
-#include "namespaces.h"
+
+#include "addr_location.h"
+#include "callchain.h"
 #include "comm.h"
+#include "debug.h"
+#include "dso.h"
+#include "dwarf-regs.h"
 #include "map.h"
+#include "namespaces.h"
+#include "session.h"
 #include "symbol.h"
+#include "thread-stack.h"
+#include "thread.h"
 #include "unwind.h"
-#include "callchain.h"
-#include "dwarf-regs.h"
 
 #include <api/fs/fs.h>
 
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index ae70fb56a057..552cffb4bb92 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -4,20 +4,23 @@
 #include <elfutils/libdwfl.h>
 #include <inttypes.h>
 #include <errno.h>
+
+#include "addr_location.h"
+#include "callchain.h"
 #include "debug.h"
 #include "dso.h"
-#include "unwind.h"
-#include "unwind-libdw.h"
+#include "env.h"
+#include "event.h"
 #include "machine.h"
 #include "map.h"
+#include "perf_regs.h"
 #include "symbol.h"
 #include "thread.h"
+#include "unwind-libdw.h"
+#include "unwind.h"
+
 #include <linux/types.h>
 #include <linux/zalloc.h>
-#include "event.h"
-#include "perf_regs.h"
-#include "callchain.h"
-#include "util/env.h"
 
 static char *debuginfo_path;
 
-- 
2.52.0.158.g65b55ccf14-goog


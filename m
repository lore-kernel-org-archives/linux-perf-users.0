Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BDD3A9635
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787955660; cv=none; b=MmMctShK4rBj32UB9khCmm+UIjevxjUf0ZPy9P8izAAXKwz1mgHgx2L7FCF/sGBIYYzCnx1CI/4TlHqI7PNNLmie+fE9szGKol5Wp7YbwC9MPKQEGcdx0X8ny0W3uIn1Sd6pMLE6UGHUMpOhfhD6HN6C6ZZCNQgFeHj3IohYax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787955660; c=relaxed/simple;
	bh=orcG2Gn6YQZC5bBkqHgpUm5aYGWam9biAuOCitF1jTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fPia4M9B2UwgeYwM7VIrAJCcqd5o9SbDGMGWldfvL4OpJYkQ1P9JrRq6OmuJnr833J1X9Nf/fv8SvFK5AUnEBrLAOTZyyumqiPaCnzCRYZu4/ibRHfU1RY8RS61DFqfG2k4mYF8CpjO4f8j12Us0VbC80doluXghQssHS2Aj3DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpGTmKhY; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpGTmKhY"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc18ced1a5aso3162889a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787955657; x=1788560457; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LY2F7Qu/OgPW4SvV7J8QvCDtOum52DXu0gkh9YH8DxA=;
        b=OpGTmKhYmpOBOaqL3cRu7K7yjlHiySKU0Ra2FXIYSEPDOyVB6AibYq1TkLDx7g+d2R
         m4slxO9FNQLADr9l0wxQFrC4V4NRqgQ19/pLb4rGd/3yW9XhK109reyBR2Po/PZYsAz0
         3ktgRmnHKQD2TtbXbNOvPwzzwpe4WkYYCSwJwnL9tg7/16BV7jrEXbXr27tDdN6tYo+5
         FO8QTqpaSrRIy9IDCbD3pcpRwqG6aMnZQJpLJC0N4o41keC5W3feTuIVZT6oB/jLs4P4
         lGMvJ5S5VbSf+QCWQQ+40y4aHlxP4AVce3UUJTvEWs2Vi4eLQ+uqhptnyO9paKUfCG/2
         itqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787955657; x=1788560457;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LY2F7Qu/OgPW4SvV7J8QvCDtOum52DXu0gkh9YH8DxA=;
        b=HC2u1tjbHyzs0P+illpzLYCp7SPyU8wAnh/6PDiovih2eRzk991Cujz0tdN40k3LYo
         Nz+jxe9NyJAIoumRq4ARKQT9tUwmvTgKQx/L1XlhUAqrDyBaL9rK1BpPrVrJK8pC1VD4
         fL0ehYxHrnT7fFS1mHFn+Esb9BJkyvV+1hwHY9SALFYDOxfXfphETSkjzJXEIDH4Phm2
         7Y2+W7CKkhEZZ9O5vdRCokMny8HQJToNAMrDSJN/1ShffFZo3dOgC+iUEzW4w9Tf8xUY
         DIQSMhtMHxZ0Fy8VJFQlRACtiHuwQXxKsvJyq3y9f9YdhPfPUkhQ/H+PuAlGy1s/fRA/
         uD1g==
X-Forwarded-Encrypted: i=1; AHgh+RptfbK6F5es26HvazbEdp6QLR1ozpsZZmy48t6MC8gL6FU5RH2NPmoCpJvaXm1jQa+VY1QDRG8c5JBT2Dm+legx@vger.kernel.org
X-Gm-Message-State: AFuF++la48Ji52Fj1tp43ZQ0OT7whbjRRs8Q6XMS7Cp1sQmRz0Hnectd
	FF12zDwWYsPQfksCUQZ/yGI28UXB0aENH9GfTeb9N9o5PUvBmcLJe7uOk1B1X/xvLCJ2jIqW/Z1
	Y4W9TcdvxUQ==
X-Received: from dldyr20-n2.prod.google.com ([2002:a05:701b:4514:20b0:13f:c741:a50b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c784:b0:3cd:3e77:1dcd
 with SMTP id adf61e73a8af0-3d265330cdemr20297973637.1.1787955656942; Fri, 28
 Aug 2026 15:20:56 -0700 (PDT)
Date: Fri, 28 Aug 2026 15:20:45 -0700
In-Reply-To: <20260828222045.1314766-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260828222045.1314766-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828222045.1314766-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf tool: Sort headers from previous cache.h removal
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use git clang-format to sort headers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c      | 49 +++++++++++++++---------------
 tools/perf/builtin-config.c        | 14 +++++----
 tools/perf/builtin-help.c          | 31 ++++++++++---------
 tools/perf/perf.c                  | 49 ++++++++++++++++--------------
 tools/perf/util/config.c           | 34 ++++++++++++---------
 tools/perf/util/help-unknown-cmd.c |  9 ++++--
 tools/perf/util/path.c             |  8 +++--
 tools/perf/util/path.h             |  3 +-
 8 files changed, 107 insertions(+), 90 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 3efeb845099c..fbdcfae858e2 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -6,44 +6,43 @@
  * look up and read DSOs and symbol information and display
  * a histogram of results, along various sorting keys.
  */
-#include "builtin.h"
-#include "perf.h"
+#include <errno.h>
+#include <inttypes.h>
 
-#include "util/color.h"
+#include <dlfcn.h>
+#include <linux/bitmap.h>
+#include <linux/err.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
-#include "util/symbol.h"
 
-#include "util/debug.h"
+#include <subcmd/parse-options.h>
 
-#include "util/evlist.h"
-#include "util/evsel.h"
-#include "util/annotate.h"
+#include "arch/common.h"
+#include "builtin.h"
+#include "perf.h"
+#include "ui/progress.h"
+#include "ui/ui.h"
 #include "util/annotate-data.h"
+#include "util/annotate.h"
+#include "util/block-range.h"
+#include "util/branch.h"
+#include "util/color.h"
+#include "util/data.h"
+#include "util/debug.h"
+#include "util/dso.h"
 #include "util/event.h"
-#include <subcmd/parse-options.h>
-#include "util/parse-events.h"
-#include "util/sort.h"
+#include "util/evlist.h"
+#include "util/evsel.h"
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
-#include "ui/ui.h"
-
-#include <dlfcn.h>
-#include <errno.h>
-#include <linux/bitmap.h>
-#include <linux/err.h>
-#include <inttypes.h>
 
 struct perf_annotate {
 	struct perf_tool tool;
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index f4f916241d1d..1ee5461436b6 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -5,16 +5,18 @@
  * Copyright (C) 2015, Taeung Song <treeze.taeung@gmail.com>
  *
  */
-#include "builtin.h"
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <linux/string.h>
 
 #include <subcmd/parse-options.h>
-#include "util/debug.h"
+
+#include "builtin.h"
 #include "util/config.h"
+#include "util/debug.h"
 #include "util/path.h"
-#include <linux/string.h>
-#include <limits.h>
-#include <stdio.h>
-#include <stdlib.h>
 
 static bool use_system_config, use_user_config;
 
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 36f5c5e94289..676a0bb63b24 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -4,28 +4,31 @@
  *
  * Builtin help command
  */
-#include "util/config.h"
-#include "util/path.h"
-#include "util/strbuf.h"
-#include "builtin.h"
-#include <subcmd/exec-cmd.h>
-#include <subcmd/parse-options.h>
-#include <subcmd/run-command.h>
-#include <subcmd/help.h>
-#include "util/debug.h"
-#include "util/util.h"
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/zalloc.h>
 #include <errno.h>
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/types.h>
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
 #include <sys/stat.h>
+#include <sys/types.h>
 #include <unistd.h>
 
+#include <subcmd/exec-cmd.h>
+#include <subcmd/help.h>
+#include <subcmd/parse-options.h>
+#include <subcmd/run-command.h>
+
+#include "builtin.h"
+#include "util/config.h"
+#include "util/debug.h"
+#include "util/path.h"
+#include "util/strbuf.h"
+#include "util/util.h"
+
 static struct man_viewer_list {
 	struct man_viewer_list *next;
 	char name[0];
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index ad8c8067b765..99135d17b85c 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -6,38 +6,41 @@
  * This is the main hub from which the sub-commands (perf stat,
  * perf top, perf record, perf report, etc.) are started.
  */
-#include "builtin.h"
 #include "perf.h"
 
-#include "util/build-id.h"
-#include "util/env.h"
-#include <internal/lib.h> // page_size
-#include <subcmd/exec-cmd.h>
-#include "util/config.h"
-#include <subcmd/run-command.h>
-#include "util/parse-events.h"
-#include <subcmd/pager.h>
-#include <subcmd/parse-options.h>
-#include <subcmd/help.h>
-#include "util/debug.h"
-#include "util/event.h"
-#include "util/util.h" // usage()
-#include "ui/ui.h"
-#include "perf-sys.h"
-#include <api/fs/fs.h>
-#include <api/fs/tracing_path.h>
-#include <perf/core.h>
 #include <errno.h>
-#include <pthread.h>
 #include <signal.h>
 #include <stdlib.h>
 #include <time.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
+
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <pthread.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <api/fs/fs.h>
+#include <api/fs/tracing_path.h>
+#include <internal/lib.h> // page_size
+#include <perf/core.h>
+#include <subcmd/exec-cmd.h>
+#include <subcmd/help.h>
+#include <subcmd/pager.h>
+#include <subcmd/parse-options.h>
+#include <subcmd/run-command.h>
+
+#include "builtin.h"
+#include "perf-sys.h"
+#include "ui/ui.h"
+#include "util/build-id.h"
+#include "util/config.h"
+#include "util/debug.h"
+#include "util/env.h"
+#include "util/event.h"
+#include "util/parse-events.h"
+#include "util/util.h" // usage()
 
 #define CMD_EXEC_PATH "--exec-path"
 #define CMD_DEBUGFS_DIR "--debugfs-dir="
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 6a310e56a2f1..a748c9fd629e 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -9,28 +9,32 @@
  * Copyright (C) Johannes Schindelin, 2005
  *
  */
+#include "config.h"
+
 #include <errno.h>
+#include <stdlib.h>
+
+#include <linux/ctype.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
 #include <sys/param.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <subcmd/exec-cmd.h>
+
+#include "build-id.h"
 #include "callchain.h"
+#include "debug.h"
 #include "header.h"
-#include <subcmd/exec-cmd.h>
-#include "util/event.h"  /* proc_map_timeout */
-#include "util/hist.h"  /* perf_hist_config */
-#include "util/stat.h"  /* perf_stat__set_big_num */
-#include "util/evsel.h"  /* evsel__hw_names, evsel__use_bpf_counters */
 #include "path.h"
 #include "srcline.h"
-#include "build-id.h"
-#include "debug.h"
-#include "config.h"
 #include "unwind.h"
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <linux/string.h>
-#include <linux/zalloc.h>
-#include <linux/ctype.h>
+#include "util/event.h" /* proc_map_timeout */
+#include "util/evsel.h" /* evsel__hw_names, evsel__use_bpf_counters */
+#include "util/hist.h" /* perf_hist_config */
+#include "util/stat.h" /* perf_stat__set_big_num */
 
 #define MAXNAME (256)
 
diff --git a/tools/perf/util/help-unknown-cmd.c b/tools/perf/util/help-unknown-cmd.c
index f1cd9d4746f3..64dbe6e514f5 100644
--- a/tools/perf/util/help-unknown-cmd.c
+++ b/tools/perf/util/help-unknown-cmd.c
@@ -1,13 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "config.h"
-#include <poll.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+
+#include <linux/zalloc.h>
+#include <poll.h>
+
 #include <subcmd/help.h>
+
 #include "../builtin.h"
+#include "config.h"
 #include "levenshtein.h"
-#include <linux/zalloc.h>
 
 static int autocorrect;
 
diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
index bf5d081707e4..7e85bbd8f751 100644
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "path.h"
-#include <linux/kernel.h>
+
 #include <limits.h>
 #include <stdio.h>
 #include <string.h>
-#include <sys/types.h>
-#include <sys/stat.h>
+
 #include <dirent.h>
+#include <linux/kernel.h>
+#include <sys/stat.h>
+#include <sys/types.h>
 #include <unistd.h>
 
 static char *cleanup_path(char *path)
diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
index e7cdb0cb1097..62e86d390589 100644
--- a/tools/perf/util/path.h
+++ b/tools/perf/util/path.h
@@ -2,8 +2,9 @@
 #ifndef _PERF_PATH_H
 #define _PERF_PATH_H
 
-#include <stddef.h>
 #include <stdbool.h>
+#include <stddef.h>
+
 #include <linux/compiler.h>
 
 struct dirent;
-- 
2.55.0.897.gb25b4bd76c-goog


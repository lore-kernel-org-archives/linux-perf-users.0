Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EFB33FE09
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364149; cv=none; b=t6Pf3OKSe2/kGUa1w0OUbdZpfykGV4lp52f9hwj5VvPwxRIMf+nQUoGJM7sS7EaZCiDR3a6G9gDNT8gH/jN9LoTMBPRg3XRp/LvXHNwGlX2s7IEoB3ihzJ1hlycQIbPsb1A3GzUlhcYu/lBz6bKYvZ+jQX8RoTloxo2yDi7HKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364149; c=relaxed/simple;
	bh=5PqBUztHFiiSoVV0MnGN6JdwtV6U4uYa4tZnZmnCjsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FhdJQ4B5rHUXbYWmC5XhCiR75VBICSYqfnJXwNWtHmae8FgMTxOl1eAPSkI8+ZZYGj7Roj0Iext4AEpkBfE1+YFIr4OGKLcz9yXs5JckxiredQXtzjaHYTSPu8tlpVHl7St3R5HZ6FBOvkAmAMlxKohzv7hflUQVPkRZG7hVOhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXNKTGlH; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXNKTGlH"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso17272705ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2026 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788364146; x=1788968946; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ts6pjVv6aTNbBmIw4be3JQNIqlAOqk8kSdpUdbRFXk=;
        b=PXNKTGlHTsK6WdBiOOBR/4hiVmgzIk8mM8Zn0L+GEof3AHKx8LdMd6kbl1TYGMkkex
         SJSbRmpRAG0BKuWfyFfZpxTgTsck+EN6NSlPV2fdO6teSVfDKsSXt3MKn/1CoGw87+W/
         SCLv2teKkhLgpgm75RO1zH8iNVMicvmLckD+KJ3utYoLCHZU5IAyHdk4Swb8GychCKAs
         p6O2DNmiazYrTuuBeIcr0f+nGHkZD2CAQkdByKFQU7OYtcuuM61fChbrpDrlHeu6+qnI
         UvYlohHlZZscI7MjYr9T09zeJaTL3SlJhhDaeIiv7uChrzWkNJaJHgz62jJCJgx/4jYl
         3wLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364146; x=1788968946;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ts6pjVv6aTNbBmIw4be3JQNIqlAOqk8kSdpUdbRFXk=;
        b=ZCZCRI9NhZx+esng1Ev71N28rHWuh+mNs6pq1fdq5g5Fh8Ru6vdf+1dNKyYdB/E1IE
         DwL0+q5qz29JIKSTbTb9QYjpKhyScql5euXVh5x8tBZypw5SU80IxK3MfGT7cOYBDs2u
         XN+KXvxnxCjip0Kz4xiJoDTZl4v3KiVV/Nm3VipoJURIlbjwXhLkxT947HWOmehOY9f0
         AiZz72+Ol8f8npTAzCpKJA79ozKAEfI9E68zArCYVuaZd3CnIT4s3JHNqhkl24d0rS91
         HgtLXNDF0GPQgDsUG7TOiiYiqA0UNvHB+jPsREB6YRenQzlrMy0OxxxuE9iA9MwJ4OJJ
         AyHw==
X-Forwarded-Encrypted: i=1; AKwUvBzhtr2IJrlYMwbGvDa+lWIPamaorbtN2V6mVVZLs9+iCsGAjcuYIa4USdAQMY11gT0p/vNJkjFoKGptoYXZNucE@vger.kernel.org
X-Gm-Message-State: AFuF++k3/De1kOyK3hxp+Q84crBuuTLG9tkMJqe15g0x9SL2Kg4FJdzs
	Qb2I88zYdKEHL1FcqA2a+Mhixzx0G19t9joU7KLPZRKCcO1dolNZKI3g9JAHyl6Jiv1F2kArtTa
	ZFA6DQoqmgg==
X-Received: from dyz5.prod.google.com ([2002:a05:693c:4085:b0:322:f0d3:b9f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e749:b0:2d8:de9f:9a44
 with SMTP id d9443c01a7336-2daec732f99mr71539485ad.19.1788364145497; Wed, 02
 Sep 2026 08:49:05 -0700 (PDT)
Date: Wed,  2 Sep 2026 08:48:54 -0700
In-Reply-To: <20260902154858.2078885-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902154858.2078885-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902154858.2078885-3-irogers@google.com>
Subject: [PATCH v3 2/6] perf tool: Tidy up util/cache.h header file users
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Tianyou Li <tianyou.li@intel.com>, 
	Jiebin Sun <jiebin.sun@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Eric Biggers <ebiggers@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use git clang-format to sort header files. Review header file includes
removing those that were unnecessary or adding explicit includes in
cases where transitive dependencies were be using.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/builtin-annotate.c      | 53 ++++++++++++++----------------
 tools/perf/builtin-config.c        | 18 +++++-----
 tools/perf/builtin-help.c          | 31 ++++++++---------
 tools/perf/perf.c                  | 45 +++++++++++--------------
 tools/perf/util/config.c           | 39 ++++++++++++----------
 tools/perf/util/help-unknown-cmd.c |  9 +++--
 tools/perf/util/path.c             |  8 ++---
 tools/perf/util/path.h             |  3 +-
 tools/perf/util/strbuf.c           |  9 ++---
 9 files changed, 109 insertions(+), 106 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 75cbea567196..f208ff513238 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -6,48 +6,45 @@
  * look up and read DSOs and symbol information and display
  * a histogram of results, along various sorting keys.
  */
-#include "builtin.h"
-#include "perf.h"
+#include <errno.h>
+#include <inttypes.h>
 #include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 
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
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
 
 struct perf_annotate {
 	struct perf_tool tool;
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 845a8af67fc5..cefd042e4f85 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -5,19 +5,21 @@
  * Copyright (C) 2015, Taeung Song <treeze.taeung@gmail.com>
  *
  */
-#include "builtin.h"
-
-#include <subcmd/parse-options.h>
-#include "util/debug.h"
-#include "util/config.h"
-#include "util/path.h"
-#include <linux/string.h>
 #include <limits.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <stdbool.h>
 #include <string.h>
 
+#include <linux/string.h>
+
+#include <subcmd/parse-options.h>
+
+#include "builtin.h"
+#include "util/config.h"
+#include "util/debug.h"
+#include "util/path.h"
+
 static bool use_system_config, use_user_config;
 
 static const char * const config_usage[] = {
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index f0e95d741892..5bbdb4d9b9c0 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -4,29 +4,30 @@
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
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <stdbool.h>
 #include <string.h>
-#include <sys/types.h>
+
+#include <linux/string.h>
+#include <linux/zalloc.h>
 #include <sys/stat.h>
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
index 8ad01a78fdd5..53c50cfd92d6 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -6,41 +6,36 @@
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
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <stdbool.h>
 #include <time.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <linux/kernel.h>
+
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <sys/stat.h>
+
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
+#include "util/util.h" // usage()
 
 #define CMD_EXEC_PATH "--exec-path"
 #define CMD_DEBUGFS_DIR "--debugfs-dir="
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 5b696139f655..b2972c35c1ec 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -9,31 +9,34 @@
  * Copyright (C) Johannes Schindelin, 2005
  *
  */
+#include "config.h"
+
 #include <errno.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <linux/ctype.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
 #include <sys/param.h>
+#include <sys/stat.h>
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
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <string.h>
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
index 5ba7861a3e65..b7592e16718d 100644
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -1,14 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "path.h"
-#include <linux/kernel.h>
+
 #include <limits.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <string.h>
-#include <sys/types.h>
-#include <sys/stat.h>
+
 #include <dirent.h>
-#include <unistd.h>
+#include <linux/kernel.h>
+#include <sys/stat.h>
 
 static char *cleanup_path(char *path)
 {
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
diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index df3f9c4123fd..4080bc02a533 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -1,15 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "debug.h"
 #include "strbuf.h"
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/zalloc.h>
+
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+
+#include <linux/zalloc.h>
 #include <unistd.h>
 
+#include "debug.h"
+
 /*
  * Used as the default ->buf value, so that people can always assume
  * buf is non NULL and ->buf is NUL terminated even for a freshly
-- 
2.55.0.966.g6673acef38-goog


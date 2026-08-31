Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D62471CED
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200564; cv=none; b=HXdfRYfmyyT6rVdGtJwHN/JVbg2khmkJxP7/Bu+DyTIvuGsxEpCBjcmG6/WnPOkGvCvFaiEswEwunOYOLndQENJ4nlfWGa5LKzpEveNOn5iS6qLujASbz/Lp6dkwEd4SwQTlX/FK0cUBglWN0p1iVJ608IooIn62cSJkj6Lu9GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200564; c=relaxed/simple;
	bh=/BbbXYU+78pgUJA2/qc71sEXVPC1VGapkcvrY5uq9tY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZChU394FOYMXo1UTNMDXvriZdePA6VaoBFIn5496jzDDQpi/dMoedDKxRhS4xnEGlAm4nU2Wz694E6uTfpOIEPO7q03pc8/evBV8HusMfehfuScS4UALmBt9h0UnUU/LwKbhZkKLAhKL6iaJxqDxsPMOqMWnZPDADS/1dXusD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iufg9SBY; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iufg9SBY"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-395543dc382so5479175a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788200562; x=1788805362; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BDDlkHf/zj6WwF/EQ5Z2gsHuPA4tj8JSUyEoLuvBfZY=;
        b=Iufg9SBYWRqzdapDnnlGthRBaYPDpRi4wxuDR3mEDzNdUcZeLJgbH0v2Lc755h6POY
         0Da/BAE5+lczyyrVrRDo5Eze+3mfvslHRzrEoMza9yYku5isHtLtNx1UtlyqUhcjLGFp
         Byb1lwiuWhxbVkbXNboD8XvrdH29WzwVgUIqvW1FEewVzWLGziukBYUvO+pIcBs7qfq7
         JPkP54JQTh5SSHjerX3dZqYTI8uLeuhZEk8k3mMGb0AGnV/IphfpoXnkxPc4ozMLN+6F
         jM+/l2wklu8NyK6Ss9hdkVjpJcrEDaM+kdZW3BEPV62vf/QGpio/r4/+wk+jhgYbcGDT
         uXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788200562; x=1788805362;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BDDlkHf/zj6WwF/EQ5Z2gsHuPA4tj8JSUyEoLuvBfZY=;
        b=qO1WBj5CfztnVRQPGcf1dT4mJlP3bHWleGs+JMkKqcndaPLYE8odfmUqOEz9zjMxMb
         KM3aRhhb1F+bm54/qlO/XhNFozkeoSbM00Cnuf2aLgPuBPxA+eg1FCJy4UFoWo+tVVO9
         x/eKaBMydZJ/mR4zTn6N62MY4WXFo5htaN1w3Mdvg/5dDMS9m7zfJEoaLKiXQ0frb1d5
         HbTCe+OUIA6wQLOEWYebYzLYAYDP6+Xw0lkWjf13MDtn+jcCW2n/v1UiIOBmFv6IYoGj
         gADVdkkPpXk616MDXTR2xyIcD077shjVF5O4dHtiKvpUweFqy2W5oDmpoiQlsXLSHZis
         BGEA==
X-Forwarded-Encrypted: i=1; AKwUvBxqJ36ktnEr3zG2atb2aAW80hEjdChJAC0HUvRgRY0h0gM4LlO07LXViNNeupH0a1UGC8akHi3k7BoVfBvGPLth@vger.kernel.org
X-Gm-Message-State: AFuF++lTIl64W6KccsWEpGUlw39DpuNQxfuqzf9oDudjeuAAlvlLjpPT
	4pCJAsL9YUhDAeOCRgIg+z8tCljIa01dj6ypDeN98lZVYbUWf1Ag3A7FoYc1qBw8Ir1FzFHvVHf
	DQMBTJkSPRA==
X-Received: from dlbrn6.prod.google.com ([2002:a05:7022:1506:b0:141:4b41:e0d0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec5:b0:398:e6b6:acc1
 with SMTP id 98e67ed59e1d1-39907d6563cmr3267337a91.15.1788200561313; Mon, 31
 Aug 2026 11:22:41 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:22:32 -0700
In-Reply-To: <20260831182232.2959017-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260828222045.1314766-1-irogers@google.com> <20260831182232.2959017-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260831182232.2959017-2-irogers@google.com>
Subject: [PATCH v2 2/2] perf tool: Tidy up util/cache.h header file users
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
2.55.0.897.gb25b4bd76c-goog


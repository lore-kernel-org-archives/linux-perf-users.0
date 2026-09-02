Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C44A8427
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364147; cv=none; b=vAdKg0x54qml2Lvk/KNMkksIbLslL0XI91v495lyOJ97XSF6zbb15Pm56S3sx6sNwfy7alCuRYoQD+ZhQTVqmXXi2jieyY6Y+bOy15gaRodAm2zS6rmdIu0j8GCxK2S95zt0NzWYKvhEp1+FJ7DaujOJ8AFxKBatOgM22TJDCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364147; c=relaxed/simple;
	bh=Hc042OnjMbeOhiRDfxFyqOhhVR8bwn2dxdpXlOvXKd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=esUfO45wIKDEJWIOPLfEi+pFYPGIJF3Bd1vRzwPjMdy7765AC3mBpMjkgCrJcDq00K94WzMISTANZfREZBiKMHNypxDRsfdr1b5KcjoVJuEdKnzCi8aBaaEX6jb2J1dLM+1GSknP534tbNajMKuMPkPqOPzeND9I5Z+dzoN2p7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jc08JaDr; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jc08JaDr"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so2498346a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2026 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788364144; x=1788968944; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8aBBetvGBVEfqoHqsirSJaUaP1jK8F5YiaqOaygKhtc=;
        b=jc08JaDrr7tgr9N2RHTbQVQBt6BHGYLjZsXuj5Wq6ADVAm6f7fgRa5IJmvnSq60CFh
         /jq8wiQqnZfgk282eBhWy/D9+ChPOYsQDMDC0dO3WKI7BWyDDRsKV2KoGr4WY76OFLPk
         odIngrLIoaWMdzLtkMnvobkdTZpSkj5gnD8UjwP2dhxlvFDYOgN32/11fIK7ZC7QGLBw
         8ane0lumOQ/vI4900w0s8RO/uri38XNxfyKg3BOxV7FQucMxBIfQLBA2uZpeIOyT3EkK
         UmVeUJ4uJQipYTVxYb6RpHUtE+XOJ/KXzdz3DKxh0QE3VihSyFbPz7fAsbbUz+gzdId0
         l3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364144; x=1788968944;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8aBBetvGBVEfqoHqsirSJaUaP1jK8F5YiaqOaygKhtc=;
        b=iNnKeerj6jKF5qi6q3SxgJWpujQozPFsYe83OG3BYJYc/5ZenrkZSBu8RNA95DQ2Ux
         lJ77qRqWuEINEV66Oxa/KmI0s4NqI9hbG/w1uubW0ZbzoXOlzaYlwXEAhc90/Laes840
         5ucRhz+/DNwldhG9hrDpvnF3VnMSLsOMyVUzGiqi9BRyRl9uc42+nJ+q2DPV9wuqHmaW
         Tv+1UJArgNTy0si+JhIbo1mbD9zvPfwFbWAfZkqsh68s5yUCWM3MgZBx6u4u/y0MPLPh
         jTxtU/AWI7ahKcg2zUB1B2Nxohi046HPDIhcwNMlZdx96OrPC5HQkh3qPQMjcxXpnYek
         VkHA==
X-Forwarded-Encrypted: i=1; AKwUvBwi7MWgZ+eqGQHyCdjHuk/t8x0/uLeq28cN+Nepya5PoUB+2BD9m9YbziYrZFzVUOXvA0Gf/NAtUwGGF4JJ9S9W@vger.kernel.org
X-Gm-Message-State: AFuF++kFwFKRfZ0EmtfhdrFk+xy57DHKLeEGPCBE3KO85varJBMBJ94i
	DVNXHac2BLPMJjH6nfH35zTk7FT1DhiiCLTjjS+k798dmli1M9/3IKc7n39/P9yXYAfeLLvYzuD
	AX98O1hZVzw==
X-Received: from dlbsn7.prod.google.com ([2002:a05:7022:b907:b0:141:ac8:b5ae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6cc:b0:398:9bd5:490d
 with SMTP id 98e67ed59e1d1-39aee0eafb9mr8976231a91.20.1788364143883; Wed, 02
 Sep 2026 08:49:03 -0700 (PDT)
Date: Wed,  2 Sep 2026 08:48:53 -0700
In-Reply-To: <20260902154858.2078885-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902154858.2078885-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902154858.2078885-2-irogers@google.com>
Subject: [PATCH v3 1/6] perf tool: Remove util/cache.h
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

Move definitions to places they are used, or path.h in the case of
path.c's mkpath function. Remove unused definitions. Fix transitive
include dependencies.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c      |  6 +++++-
 tools/perf/builtin-config.c        |  4 +++-
 tools/perf/builtin-help.c          |  3 ++-
 tools/perf/perf.c                  | 11 ++++++++++-
 tools/perf/util/cache.h            | 31 ------------------------------
 tools/perf/util/config.c           |  5 ++++-
 tools/perf/util/help-unknown-cmd.c |  6 +++++-
 tools/perf/util/path.c             |  2 +-
 tools/perf/util/path.h             |  3 +++
 tools/perf/util/strbuf.c           |  5 ++++-
 10 files changed, 37 insertions(+), 39 deletions(-)
 delete mode 100644 tools/perf/util/cache.h

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 69cb72b2082a..75cbea567196 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -8,10 +8,10 @@
  */
 #include "builtin.h"
 #include "perf.h"
+#include <stdbool.h>
 
 #include "util/color.h"
 #include <linux/list.h>
-#include "util/cache.h"
 #include <linux/rbtree.h>
 #include "util/symbol.h"
 
@@ -38,12 +38,16 @@
 #include "util/branch.h"
 #include "util/util.h"
 #include "ui/progress.h"
+#include "ui/ui.h"
 
 #include <dlfcn.h>
 #include <errno.h>
 #include <linux/bitmap.h>
 #include <linux/err.h>
 #include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 
 struct perf_annotate {
 	struct perf_tool tool;
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 237600643bbd..845a8af67fc5 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -7,14 +7,16 @@
  */
 #include "builtin.h"
 
-#include "util/cache.h"
 #include <subcmd/parse-options.h>
 #include "util/debug.h"
 #include "util/config.h"
+#include "util/path.h"
 #include <linux/string.h>
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
 
 static bool use_system_config, use_user_config;
 
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 2692b2e40a23..f0e95d741892 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -4,8 +4,8 @@
  *
  * Builtin help command
  */
-#include "util/cache.h"
 #include "util/config.h"
+#include "util/path.h"
 #include "util/strbuf.h"
 #include "builtin.h"
 #include <subcmd/exec-cmd.h>
@@ -21,6 +21,7 @@
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1f51e8de6b1b..8ad01a78fdd5 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -10,13 +10,13 @@
 #include "perf.h"
 
 #include "util/build-id.h"
-#include "util/cache.h"
 #include "util/env.h"
 #include <internal/lib.h> // page_size
 #include <subcmd/exec-cmd.h>
 #include "util/config.h"
 #include <subcmd/run-command.h>
 #include "util/parse-events.h"
+#include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <subcmd/help.h>
 #include "util/debug.h"
@@ -30,7 +30,10 @@
 #include <errno.h>
 #include <pthread.h>
 #include <signal.h>
+#include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
 #include <time.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -39,6 +42,12 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
+#define CMD_EXEC_PATH "--exec-path"
+#define CMD_DEBUGFS_DIR "--debugfs-dir="
+
+#define EXEC_PATH_ENVIRONMENT "PERF_EXEC_PATH"
+#define PERF_PAGER_ENVIRONMENT "PERF_PAGER"
+
 static int use_pager = -1;
 static FILE *debug_fp = NULL;
 
diff --git a/tools/perf/util/cache.h b/tools/perf/util/cache.h
deleted file mode 100644
index 0b61840d4226..000000000000
--- a/tools/perf/util/cache.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PERF_CACHE_H
-#define __PERF_CACHE_H
-
-#include "strbuf.h"
-#include <subcmd/pager.h>
-#include "../ui/ui.h"
-
-#include <linux/compiler.h>
-#include <linux/string.h>
-
-#define CMD_EXEC_PATH "--exec-path"
-#define CMD_DEBUGFS_DIR "--debugfs-dir="
-
-#define EXEC_PATH_ENVIRONMENT "PERF_EXEC_PATH"
-#define PERF_DEBUGFS_ENVIRONMENT "PERF_DEBUGFS_DIR"
-#define PERF_TRACEFS_ENVIRONMENT "PERF_TRACEFS_DIR"
-#define PERF_PAGER_ENVIRONMENT "PERF_PAGER"
-
-int split_cmdline(char *cmdline, const char ***argv);
-
-#define alloc_nr(x) (((x)+16)*3/2)
-
-static inline int is_absolute_path(const char *path)
-{
-	return path[0] == '/';
-}
-
-char *mkpath(char *path_buf, size_t sz, const char *fmt, ...) __printf(3, 4);
-
-#endif /* __PERF_CACHE_H */
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 7988149dc7ed..5b696139f655 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -11,7 +11,6 @@
  */
 #include <errno.h>
 #include <sys/param.h>
-#include "cache.h"
 #include "callchain.h"
 #include "header.h"
 #include <subcmd/exec-cmd.h>
@@ -19,6 +18,7 @@
 #include "util/hist.h"  /* perf_hist_config */
 #include "util/stat.h"  /* perf_stat__set_big_num */
 #include "util/evsel.h"  /* evsel__hw_names, evsel__use_bpf_counters */
+#include "path.h"
 #include "srcline.h"
 #include "build-id.h"
 #include "debug.h"
@@ -26,7 +26,10 @@
 #include "unwind.h"
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
 #include <unistd.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/util/help-unknown-cmd.c b/tools/perf/util/help-unknown-cmd.c
index a0a46e34f8d1..f1cd9d4746f3 100644
--- a/tools/perf/util/help-unknown-cmd.c
+++ b/tools/perf/util/help-unknown-cmd.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "cache.h"
 #include "config.h"
 #include <poll.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <subcmd/help.h>
 #include "../builtin.h"
 #include "levenshtein.h"
@@ -36,10 +36,14 @@ static int add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 
 	if (nr > cmds->alloc) {
 		/* Choose bigger one to alloc */
+#define alloc_nr(x) (((x) + 16) * 3 / 2)
+
 		if (alloc_nr(cmds->alloc) < nr)
 			cmds->alloc = nr;
 		else
 			cmds->alloc = alloc_nr(cmds->alloc);
+
+#undef alloc_nr
 		tmp = realloc(cmds->names, cmds->alloc * sizeof(*cmds->names));
 		if (!tmp)
 			return -1;
diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
index 2e62f272fda8..5ba7861a3e65 100644
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "path.h"
-#include "cache.h"
 #include <linux/kernel.h>
 #include <limits.h>
+#include <stdarg.h>
 #include <stdio.h>
 #include <string.h>
 #include <sys/types.h>
diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
index fb850fb55c60..e7cdb0cb1097 100644
--- a/tools/perf/util/path.h
+++ b/tools/perf/util/path.h
@@ -4,9 +4,12 @@
 
 #include <stddef.h>
 #include <stdbool.h>
+#include <linux/compiler.h>
 
 struct dirent;
 
+char *mkpath(char *path_buf, size_t sz, const char *fmt, ...) __printf(3, 4);
+
 int path__join(char *bf, size_t size, const char *path1, const char *path2);
 int path__join3(char *bf, size_t size, const char *path1, const char *path2, const char *path3);
 
diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index a64a37628f12..df3f9c4123fd 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "cache.h"
 #include "debug.h"
 #include "strbuf.h"
 #include <linux/kernel.h>
@@ -8,6 +7,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 
 /*
@@ -54,9 +54,12 @@ int strbuf_grow(struct strbuf *sb, size_t extra)
 	if (nr <= sb->len)
 		return -E2BIG;
 
+#define alloc_nr(x) (((x) + 16) * 3 / 2)
+
 	if (alloc_nr(sb->alloc) > nr)
 		nr = alloc_nr(sb->alloc);
 
+#undef alloc_nr
 	/*
 	 * Note that sb->buf == strbuf_slopbuf if sb->alloc == 0, and it is
 	 * a static variable. Thus we have to avoid passing it to realloc.
-- 
2.55.0.966.g6673acef38-goog


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6586139B;
	Wed,  4 Jun 2025 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749015756; cv=none; b=PDCaWuhpUNg0FTsGBe21jDymlF3SmwEYDf0XLtsEMrHkO80MzN8Uz5TfhCIbRcqvI/xXh/kT4r5EUsfZXrYHQnt85X3TPXVaYbUMQyzOXfgPYCXsJP/teGtxOTlABJLrlTyHC0IKGKcZ9L07Ay2q+TKg4pl9Bf945Awwq/5Vf08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749015756; c=relaxed/simple;
	bh=vePpomZfvgm927vD/p6qYd4tSnIYzpFRWkR72PcO+JM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A70TDBO1yJkBXTdoh/2IOR9L4pA4UR8QJLBEms8HZhsfX0DMVZLEGuSQ4z2ofKvaEMs8oSsbiZV82+Qrtd9uwlhQAZw2q2kb5pP59aHsdw9vSahA9ckxofQ0YmJxYOdbQe/p6jZgqgCX2upG5/VNRN3U8hsqSS117X3jh9zwGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7nvxY1Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7nvxY1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB931C4CEE7;
	Wed,  4 Jun 2025 05:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749015756;
	bh=vePpomZfvgm927vD/p6qYd4tSnIYzpFRWkR72PcO+JM=;
	h=From:To:Cc:Subject:Date:From;
	b=s7nvxY1Yf1rjTYvgk4DM5R5SyQzwvg0NNUlFI2rnyZSv6UmdYtI35GNB3+CVzQEUA
	 toSGzYehsvaGLB7Fo8Z1Uw8WAgOqrvrAfyw9NqvV7NpmUpQuf4LvtDvteK0W2eGSej
	 jrVnVgsqZkYJACnKgnqZ+QE4BVeDxFqSnjQ7/EgYuG/L8Ph6Tx3FGgJ+bMAaodAyzO
	 Dc11WJQR/4CU3oUhtjCn2hArq2kbjlckm3Pqz9J+Ol9UBrExWYHC0YO+oPpRp+KndL
	 G/kHUbE0VtSgL3WeTP3cL4kwxw1gqUPdpQ+iunaHSV3bNQ0IzScTmx5qJ6m7je0KDM
	 MspVHBpvbdESw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf bpf-filter: Improve error messages
Date: Tue,  3 Jun 2025 22:42:34 -0700
Message-ID: <20250604054234.23608-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF filter needs libbpf/BPF-skeleton support and root privilege.
Add error messages to help users understand the problem easily.

When it's not build with BPF support (make BUILD_BPF_SKEL=0).

  $ sudo perf record -e cycles --filter "pid != 0" true
  Error: BPF filter is requested but perf is not built with BPF.
  	Please make sure to build with libbpf and BPF skeleton.

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

          --filter <filter>
                            event filter

When it supports BPF but runs without root or CAP_BPF.  Note that it
also checks pinned BPF filters.

  $ perf record -e cycles --filter "pid != 0" -o /dev/null true
  Error: BPF filter only works for users with the CAP_BPF capability!
  	Please run 'perf record --setup-filter pin' as root first.

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

          --filter <filter>
                            event filter

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-filter.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/bpf-filter.h |  3 +++
 tools/perf/util/cap.c        |  1 -
 tools/perf/util/cap.h        |  5 +++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index a4fdf6911ec1c32e..92e2f054b45e91dd 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -52,6 +52,7 @@
 #include <internal/xyarray.h>
 #include <perf/threadmap.h>
 
+#include "util/cap.h"
 #include "util/debug.h"
 #include "util/evsel.h"
 #include "util/target.h"
@@ -618,11 +619,38 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term
 	return expr;
 }
 
+static bool check_bpf_filter_capable(void)
+{
+	bool used_root;
+
+	if (perf_cap__capable(CAP_BPF, &used_root))
+		return true;
+
+	if (!used_root) {
+		/* Check if root already pinned the filter programs and maps */
+		int fd = get_pinned_fd("filters");
+
+		if (fd >= 0) {
+			close(fd);
+			return true;
+		}
+	}
+
+	pr_err("Error: BPF filter only works for %s!\n"
+	       "\tPlease run 'perf record --setup-filter pin' as root first.\n",
+	       used_root ? "root" : "users with the CAP_BPF capability");
+
+	return false;
+}
+
 int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
 {
 	YY_BUFFER_STATE buffer;
 	int ret;
 
+	if (!check_bpf_filter_capable())
+		return -EPERM;
+
 	buffer = perf_bpf_filter__scan_string(str);
 
 	ret = perf_bpf_filter_parse(expr_head);
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
index 916ed7770b734f15..187e5bbcc5910d78 100644
--- a/tools/perf/util/bpf-filter.h
+++ b/tools/perf/util/bpf-filter.h
@@ -2,6 +2,7 @@
 #ifndef PERF_UTIL_BPF_FILTER_H
 #define PERF_UTIL_BPF_FILTER_H
 
+#include <stdio.h>
 #include <linux/list.h>
 
 #include "bpf_skel/sample-filter.h"
@@ -38,6 +39,8 @@ int perf_bpf_filter__unpin(void);
 static inline int perf_bpf_filter__parse(struct list_head *expr_head __maybe_unused,
 					 const char *str __maybe_unused)
 {
+	fprintf(stderr, "Error: BPF filter is requested but perf is not built with BPF.\n"
+		"\tPlease make sure to build with libbpf and BPF skeleton.\n");
 	return -EOPNOTSUPP;
 }
 static inline int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused,
diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
index 69d9a2bcd40bfdd1..24a0ea7e6d97749b 100644
--- a/tools/perf/util/cap.c
+++ b/tools/perf/util/cap.c
@@ -7,7 +7,6 @@
 #include "debug.h"
 #include <errno.h>
 #include <string.h>
-#include <linux/capability.h>
 #include <sys/syscall.h>
 #include <unistd.h>
 
diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
index 0c6a1ff55f07340a..c1b8ac033ccc5826 100644
--- a/tools/perf/util/cap.h
+++ b/tools/perf/util/cap.h
@@ -3,6 +3,7 @@
 #define __PERF_CAP_H
 
 #include <stdbool.h>
+#include <linux/capability.h>
 
 /* For older systems */
 #ifndef CAP_SYSLOG
@@ -13,6 +14,10 @@
 #define CAP_PERFMON	38
 #endif
 
+#ifndef CAP_BPF
+#define CAP_BPF		39
+#endif
+
 /* Query if a capability is supported, used_root is set if the fallback root check was used. */
 bool perf_cap__capable(int cap, bool *used_root);
 
-- 
2.49.0


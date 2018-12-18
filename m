From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/63] perf beauty: Add a string table generator for renameat2's flags constants
Date: Tue, 18 Dec 2018 19:06:39 -0300
Message-ID: <20181218220733.15839-10-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Using the already copied tools/include/uapi/linux/fs.h file:

  $ tools/perf/trace/beauty/rename_flags.sh
  static const char *rename_flags[] = {
	[0 + 1] = "NOREPLACE",
	[1 + 1] = "EXCHANGE",
	[2 + 1] = "WHITEOUT",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ta2jbh03spkymp4sbdh489g8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/rename_flags.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100755 tools/perf/trace/beauty/rename_flags.sh

diff --git a/tools/perf/trace/beauty/rename_flags.sh b/tools/perf/trace/beauty/rename_flags.sh
new file mode 100755
index 000000000000..54c87c782ab2
--- /dev/null
+++ b/tools/perf/trace/beauty/rename_flags.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+# Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+# SPDX-License-Identifier: LGPL-2.1
+
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+
+fs_header=${header_dir}/fs.h
+
+printf "static const char *rename_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+RENAME_([[:alnum:]_]+)[[:space:]]+\(1[[:space:]]*<<[[:space:]]*([[:xdigit:]]+)[[:space:]]*\)[[:space:]]*.*'
+egrep -q $regex ${fs_header} && \
+(egrep $regex ${fs_header} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[%d + 1] = \"%s\",\n")
+printf "};\n"
-- 
2.19.2

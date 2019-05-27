From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/44] perf beauty: Add generator for sync_file_range's 'flags' arg values
Date: Mon, 27 May 2019 19:37:08 -0300
Message-ID: <20190527223730.11474-23-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Amir Goldstein <amir73il@gmail.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  $ tools/perf/trace/beauty/sync_file_range.sh
  static const char *sync_file_range_flags[] = {
          [ilog2(1) + 1] = "WAIT_BEFORE",
          [ilog2(2) + 1] = "WRITE",
          [ilog2(4) + 1] = "WAIT_AFTER",
  };
  $

When all are the above are present, then we have something called
SYNC_FILE_RANGE_WRITE_AND_WAIT, that will be special cased in the
upcoming scnprintf beautifier for this flags arg.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-uf2vd7bc8fkz65j7yit8dh84@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/sync_file_range.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100755 tools/perf/trace/beauty/sync_file_range.sh

diff --git a/tools/perf/trace/beauty/sync_file_range.sh b/tools/perf/trace/beauty/sync_file_range.sh
new file mode 100755
index 000000000000..7a9282d04e44
--- /dev/null
+++ b/tools/perf/trace/beauty/sync_file_range.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+if [ $# -ne 1 ] ; then
+	linux_header_dir=tools/include/uapi/linux
+else
+	linux_header_dir=$1
+fi
+
+linux_fs=${linux_header_dir}/fs.h
+
+printf "static const char *sync_file_range_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+SYNC_FILE_RANGE_([[:alnum:]_]+)[[:space:]]+([[:xdigit:]]+)[[:space:]]*.*'
+egrep $regex ${linux_fs} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
-- 
2.20.1

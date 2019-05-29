From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/41] perf beauty: Add generator for fspick's 'flags' arg values
Date: Wed, 29 May 2019 10:35:34 -0300
Message-ID: <20190529133605.21118-11-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Brendan Gregg <brendan.d.gregg@gmail.com>, David Howells <dhowells@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  $ tools/perf/trace/beauty/fspick.sh
  static const char *fspick_flags[] = {
          [ilog2(0x00000001) + 1] = "CLOEXEC",
          [ilog2(0x00000002) + 1] = "SYMLINK_NOFOLLOW",
          [ilog2(0x00000004) + 1] = "NO_AUTOMOUNT",
          [ilog2(0x00000008) + 1] = "EMPTY_PATH",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8i16btocq1ax2u6542ya79t5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fspick.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100755 tools/perf/trace/beauty/fspick.sh

diff --git a/tools/perf/trace/beauty/fspick.sh b/tools/perf/trace/beauty/fspick.sh
new file mode 100755
index 000000000000..b220e07ef452
--- /dev/null
+++ b/tools/perf/trace/beauty/fspick.sh
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
+linux_mount=${linux_header_dir}/mount.h
+
+printf "static const char *fspick_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+FSPICK_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+egrep $regex ${linux_mount} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
-- 
2.20.1

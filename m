From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/41] perf beauty: Add generator for 'move_mount' flags argument
Date: Wed, 29 May 2019 10:35:32 -0300
Message-ID: <20190529133605.21118-9-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Brendan Gregg <brendan.d.gregg@gmail.com>, David Howells <dhowells@redhat.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  $ tools/perf/trace/beauty/move_mount_flags.sh
  static const char *move_mount_flags[] = {
	  [ilog2(0x00000001) + 1] = "F_SYMLINKS",
	  [ilog2(0x00000002) + 1] = "F_AUTOMOUNTS",
	  [ilog2(0x00000004) + 1] = "F_EMPTY_PATH",
	  [ilog2(0x00000010) + 1] = "T_SYMLINKS",
	  [ilog2(0x00000020) + 1] = "T_AUTOMOUNTS",
	  [ilog2(0x00000040) + 1] = "T_EMPTY_PATH",
  };
  $

Will be wired up to the 'perf trace' arg in a followup patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-px7v33suw1k2ehst52l7bwa3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/move_mount_flags.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100755 tools/perf/trace/beauty/move_mount_flags.sh

diff --git a/tools/perf/trace/beauty/move_mount_flags.sh b/tools/perf/trace/beauty/move_mount_flags.sh
new file mode 100755
index 000000000000..55e59241daa4
--- /dev/null
+++ b/tools/perf/trace/beauty/move_mount_flags.sh
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
+printf "static const char *move_mount_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MOVE_MOUNT_([FT]_[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+egrep $regex ${linux_mount} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
-- 
2.20.1

From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/28] perf beauty: Add a generator for MS_ mount/umount's flag constants
Date: Wed, 31 Oct 2018 13:44:42 -0300
Message-ID: <20181031164508.4784-3-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Benjamin Peterson <benjamin@python.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It'll use tools/include copy of linux/fs.h to generate a table to be
used by tools, initially by the 'mount' and 'umount' beautifiers in
'perf trace', but that could also be used to translate from a string
constant to the integer value to be used in a eBPF or tracefs tracepoint
filter.

When used without any args it produces:

  $ tools/perf/trace/beauty/mount_flags.sh
  static const char *mount_flags[] = {
	[1 ? (ilog2(1) + 1) : 0] = "RDONLY",
	[2 ? (ilog2(2) + 1) : 0] = "NOSUID",
	[4 ? (ilog2(4) + 1) : 0] = "NODEV",
	[8 ? (ilog2(8) + 1) : 0] = "NOEXEC",
	[16 ? (ilog2(16) + 1) : 0] = "SYNCHRONOUS",
	[32 ? (ilog2(32) + 1) : 0] = "REMOUNT",
	[64 ? (ilog2(64) + 1) : 0] = "MANDLOCK",
	[128 ? (ilog2(128) + 1) : 0] = "DIRSYNC",
	[1024 ? (ilog2(1024) + 1) : 0] = "NOATIME",
	[2048 ? (ilog2(2048) + 1) : 0] = "NODIRATIME",
	[4096 ? (ilog2(4096) + 1) : 0] = "BIND",
	[8192 ? (ilog2(8192) + 1) : 0] = "MOVE",
	[16384 ? (ilog2(16384) + 1) : 0] = "REC",
	[32768 ? (ilog2(32768) + 1) : 0] = "SILENT",
	[16 + 1] = "POSIXACL",
	[17 + 1] = "UNBINDABLE",
	[18 + 1] = "PRIVATE",
	[19 + 1] = "SLAVE",
	[20 + 1] = "SHARED",
	[21 + 1] = "RELATIME",
	[22 + 1] = "KERNMOUNT",
	[23 + 1] = "I_VERSION",
	[24 + 1] = "STRICTATIME",
	[25 + 1] = "LAZYTIME",
	[26 + 1] = "SUBMOUNT",
	[27 + 1] = "NOREMOTELOCK",
	[28 + 1] = "NOSEC",
	[29 + 1] = "BORN",
	[30 + 1] = "ACTIVE",
	[31 + 1] = "NOUSER",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mgutbbkmip9gfnmd28ikg7xt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mount_flags.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100755 tools/perf/trace/beauty/mount_flags.sh

diff --git a/tools/perf/trace/beauty/mount_flags.sh b/tools/perf/trace/beauty/mount_flags.sh
new file mode 100755
index 000000000000..45547573a1db
--- /dev/null
+++ b/tools/perf/trace/beauty/mount_flags.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+
+printf "static const char *mount_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+([[:digit:]]+)[[:space:]]*.*'
+egrep $regex ${header_dir}/fs.h | egrep -v '(MSK|VERBOSE|MGC_VAL)\>' | \
+	sed -r "s/$regex/\2 \2 \1/g" | sort -n | \
+	xargs printf "\t[%s ? (ilog2(%s) + 1) : 0] = \"%s\",\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+\(1<<([[:digit:]]+)\)[[:space:]]*.*'
+egrep $regex ${header_dir}/fs.h | \
+	sed -r "s/$regex/\2 \1/g" | \
+	xargs printf "\t[%s + 1] = \"%s\",\n"
+printf "};\n"
-- 
2.14.4

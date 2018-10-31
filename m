From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/28] perf beauty: Add a generator for MAP_ mmap's flag constants
Date: Wed, 31 Oct 2018 13:44:58 -0300
Message-ID: <20181031164508.4784-19-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It'll use tools/{arch}/*,include copies of mman.h to generate a table to
be used by tools, initially by the 'mmap' beautifiers in 'perf trace',
but that could also be used to translate from a string constant to the
integer value to be used in a eBPF or tracefs tracepoint filter.

Tested for all archs using:

$ for arch in `ls tools/arch/` ; \
	do echo $arch ; tools/perf/trace/beauty/mmap_flags.sh $arch ; \
   done | less

Example for alpha, an oddball, doesn't include any header, defines all
its stuff:

  $ tools/perf/trace/beauty/mmap_flags.sh alpha
  static const char *mmap_flags[] = {
	[ilog2(0x10) + 1] = "ANONYMOUS",
	[ilog2(0x02000) + 1] = "DENYWRITE",
	[ilog2(0x04000) + 1] = "EXECUTABLE",
	[ilog2(0x100) + 1] = "FIXED",
	[ilog2(0x01000) + 1] = "GROWSDOWN",
	[ilog2(0x100000) + 1] = "HUGETLB",
	[ilog2(0x08000) + 1] = "LOCKED",
	[ilog2(0x40000) + 1] = "NONBLOCK",
	[ilog2(0x10000) + 1] = "NORESERVE",
	[ilog2(0x20000) + 1] = "POPULATE",
	[ilog2(0x02) + 1] = "PRIVATE",
	[ilog2(0x01) + 1] = "SHARED",
	[ilog2(0x80000) + 1] = "STACK",
  };
  $

Common case, my workstation, defines one entry (MAP_32BIT), then
includes mman.h, which gets it to include mman-common.h too:

  $ tools/perf/trace/beauty/mmap_flags.sh
  static const char *mmap_flags[] = {
	[ilog2(0x40) + 1] = "32BIT",
	[ilog2(0x01) + 1] = "SHARED",
	[ilog2(0x02) + 1] = "PRIVATE",
	[ilog2(0x10) + 1] = "FIXED",
	[ilog2(0x20) + 1] = "ANONYMOUS",
	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
	[ilog2(0x0100) + 1] = "GROWSDOWN",
	[ilog2(0x0800) + 1] = "DENYWRITE",
	[ilog2(0x1000) + 1] = "EXECUTABLE",
	[ilog2(0x2000) + 1] = "LOCKED",
	[ilog2(0x4000) + 1] = "NORESERVE",
	[ilog2(0x8000) + 1] = "POPULATE",
	[ilog2(0x10000) + 1] = "NONBLOCK",
	[ilog2(0x20000) + 1] = "STACK",
	[ilog2(0x40000) + 1] = "HUGETLB",
	[ilog2(0x80000) + 1] = "SYNC",
  };
  $ uname -m
  x86_64
  $

Sparc, that defines a bunch then includes just mman-common.h:

  $ tools/perf/trace/beauty/mmap_flags.sh sparc
  static const char *mmap_flags[] = {
	[ilog2(0x0800) + 1] = "DENYWRITE",
	[ilog2(0x1000) + 1] = "EXECUTABLE",
	[ilog2(0x0200) + 1] = "GROWSDOWN",
	[ilog2(0x40000) + 1] = "HUGETLB",
	[ilog2(0x100) + 1] = "LOCKED",
	[ilog2(0x10000) + 1] = "NONBLOCK",
	[ilog2(0x40) + 1] = "NORESERVE",
	[ilog2(0x8000) + 1] = "POPULATE",
	[ilog2(0x20000) + 1] = "STACK",
	[ilog2(0x01) + 1] = "SHARED",
	[ilog2(0x02) + 1] = "PRIVATE",
	[ilog2(0x10) + 1] = "FIXED",
	[ilog2(0x20) + 1] = "ANONYMOUS",
	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
  };
  [acme@jouet perf]$

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-xydeh491z8fkgglcmqnl5thj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap_flags.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 tools/perf/trace/beauty/mmap_flags.sh

diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
new file mode 100755
index 000000000000..22c3fdca8975
--- /dev/null
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+if [ $# -ne 2 ] ; then
+	[ $# -eq 1 ] && hostarch=$1 || hostarch=`uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/`
+	header_dir=tools/include/uapi/asm-generic
+	arch_header_dir=tools/arch/${hostarch}/include/uapi/asm
+else
+	header_dir=$1
+	arch_header_dir=$2
+fi
+
+arch_mman=${arch_header_dir}/mman.h
+
+# those in egrep -vw are flags, we want just the bits
+
+printf "static const char *mmap_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MAP_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+egrep -q $regex ${arch_mman} && \
+(egrep $regex ${arch_mman} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
+egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman} &&
+(egrep $regex ${header_dir}/mman-common.h | \
+	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
+egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman} &&
+(egrep $regex ${header_dir}/mman.h | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
+printf "};\n"
-- 
2.14.4

From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 52/63] perf beauty: Add a string table generator for x86's 'arch_prctl' codes
Date: Tue, 18 Dec 2018 19:07:22 -0300
Message-ID: <20181218220733.15839-53-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  $ tools/perf/trace/beauty/x86_arch_prctl.sh
  #define x86_arch_prctl_codes_1_offset 0x1001
  static const char *x86_arch_prctl_codes_1[] = {
	[0x1001 - 0x1001]= "SET_GS",
	[0x1002 - 0x1001]= "SET_FS",
	[0x1003 - 0x1001]= "GET_FS",
	[0x1004 - 0x1001]= "GET_GS",
	[0x1011 - 0x1001]= "GET_CPUID",
	[0x1012 - 0x1001]= "SET_CPUID",
  };

  #define x86_arch_prctl_codes_2_offset 0x2001
  static const char *x86_arch_prctl_codes_2[] = {
	[0x2001 - 0x2001]= "MAP_VDSO_X32",
	[0x2002 - 0x2001]= "MAP_VDSO_32",
	[0x2003 - 0x2001]= "MAP_VDSO_64",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-w0fux1psivphhx6rve8kn3vq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/x86_arch_prctl.sh | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100755 tools/perf/trace/beauty/x86_arch_prctl.sh

diff --git a/tools/perf/trace/beauty/x86_arch_prctl.sh b/tools/perf/trace/beauty/x86_arch_prctl.sh
new file mode 100755
index 000000000000..7372d3cab959
--- /dev/null
+++ b/tools/perf/trace/beauty/x86_arch_prctl.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+# SPDX-License-Identifier: LGPL-2.1
+
+[ $# -eq 1 ] && x86_header_dir=$1 || x86_header_dir=tools/arch/x86/include/uapi/asm/
+
+prctl_arch_header=${x86_header_dir}/prctl.h
+
+print_range () {
+	local idx=$1
+	local prefix=$2
+	local first_entry=$3
+
+	printf "#define x86_arch_prctl_codes_%d_offset %s\n" $idx $first_entry
+	printf "static const char *x86_arch_prctl_codes_%d[] = {\n" $idx
+	regex=`printf '^[[:space:]]*#[[:space:]]*define[[:space:]]+ARCH_([[:alnum:]_]+)[[:space:]]+(%s[[:xdigit:]]+).*' ${prefix}`
+	fmt="\t[%#x - ${first_entry}]= \"%s\",\n"
+	egrep -q $regex ${prctl_arch_header} && \
+	(egrep $regex ${prctl_arch_header} | \
+		sed -r "s/$regex/\2 \1/g"	| \
+		xargs printf "$fmt")
+	printf "};\n\n"
+}
+
+print_range 1 0x1 0x1001
+print_range 2 0x2 0x2001
-- 
2.19.2

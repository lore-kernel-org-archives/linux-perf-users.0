From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/18] tools perf: Do not check spaces/blank lines when checking header file copy drift
Date: Tue,  1 Aug 2017 16:56:33 -0300
Message-ID: <20170801195645.16986-7-acme@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We copy headers from include/, arch/ to allow tools/ use defines,
structs from newer kernels and still be able to build on older systems.

We then, as part of a build, check if those copies got out of sync, when
we emit a warning, so that we can check if something needs to be
reflected on the tools, e.g. a 'perf trace' syscall argument beautifier
needs tweaking.

But we don't have to be super strict with that, for instance, extra
spaces, tabs or blank lines aren't problematic, so change
check-headers.sh to have "--ignore-blank-lines --ignore-space-change" as
default "diff" arguments.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-d8emqpdc3m2qtzt1ei8ra2tf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/check-headers.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index ff0a5fabf055..3f0c6577f8cc 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -37,7 +37,7 @@ include/uapi/asm-generic/mman-common.h
 
 check () {
   file=$1
-  opts=
+  opts="--ignore-blank-lines --ignore-space-change"
 
   shift
   while [ -n "$*" ]; do
@@ -58,7 +58,7 @@ for i in $HEADERS; do
 done
 
 # diff with extra ignore lines
-check arch/x86/lib/memcpy_64.S        -B -I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"
-check arch/x86/lib/memset_64.S        -B -I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"
-check include/uapi/asm-generic/mman.h -B -I "^#include <\(uapi/\)*asm-generic/mman-common.h>"
-check include/uapi/linux/mman.h       -B -I "^#include <\(uapi/\)*asm/mman.h>"
+check arch/x86/lib/memcpy_64.S        -I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"
+check arch/x86/lib/memset_64.S        -I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"
+check include/uapi/asm-generic/mman.h -I "^#include <\(uapi/\)*asm-generic/mman-common.h>"
+check include/uapi/linux/mman.h       -I "^#include <\(uapi/\)*asm/mman.h>"
-- 
2.9.4

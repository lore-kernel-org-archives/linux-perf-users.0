From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/35] perf tools: Move syscall_64.tbl check into check-headers.sh
Date: Wed, 15 Aug 2018 12:06:05 -0300
Message-ID: <20180815150611.32080-30-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Kapshuk <alexander.kapshuk@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Probably leftover from the time we introducd the check-headers.sh script.

Committer testing:

Remove the 'rseq' syscall from tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
to fake a diff:

make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j4' parallel build
Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
  CC       /tmp/build/perf/util/syscalltbl.o
  INSTALL  trace_plugins
<SNIP>
  $ diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
  --- tools/perf/arch/x86/entry/syscalls/syscall_64.tbl	2018-08-13 15:49:50.896585176 -0300
  +++ arch/x86/entry/syscalls/syscall_64.tbl	2018-07-20 12:04:04.536858304 -0300
  @@ -342,6 +342,7 @@
   331	common	pkey_free		__x64_sys_pkey_free
   332	common	statx			__x64_sys_statx
   333	common	io_pgetevents		__x64_sys_io_pgetevents
  +334	common	rseq			__x64_sys_rseq

  #
  # x32-specific system call numbers start at 512 to avoid cache impact
  $

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180813111504.3568-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/Makefile | 3 ---
 tools/perf/check-headers.sh  | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 1a38e78117ce..8cc6642fce7a 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -19,9 +19,6 @@ systbl := $(sys)/syscalltbl.sh
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sys)/syscall_64.tbl $(systbl)
-	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
-        (diff -B arch/x86/entry/syscalls/syscall_64.tbl ../../arch/x86/entry/syscalls/syscall_64.tbl >/dev/null) \
-        || echo "Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'" >&2 )) || true
 	$(Q)$(SHELL) '$(systbl)' $(sys)/syscall_64.tbl 'x86_64' > $@
 
 clean::
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index b61f8a4dfca3..466540ee8ea7 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -101,4 +101,7 @@ check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 
+# diff non-symmetric files
+check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
+
 cd tools/perf
-- 
2.14.4

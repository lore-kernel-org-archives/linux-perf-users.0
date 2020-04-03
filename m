From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/31] perf: Normalize gcc parameter when generating arch errno table
Date: Fri,  3 Apr 2020 11:54:15 -0300
Message-ID: <20200403145443.24774-4-acme@kernel.org>
References: <20200403145443.24774-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200403145443.24774-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, He Zhe <zhe.he@windriver.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

The $(CC) passed to arch_errno_names.sh may include a series of parameters
along with gcc itself. To avoid overwriting the following parameters of
arch_errno_names.sh and break the build like below, we just pick up the
first word of the $(CC).

  find: unknown predicate `-m64/arch'
  x86_64-wrs-linux-gcc: warning: '-x c' after last input file has no effect
  x86_64-wrs-linux-gcc: error: unrecognized command line option '-m64/include/uapi/asm-generic/errno.h'
  x86_64-wrs-linux-gcc: fatal error: no input files

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/1581618066-187262-2-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a02aca9b21f4..d15a311408f1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -574,7 +574,7 @@ arch_errno_hdr_dir := $(srctree)/tools
 arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
 
 $(arch_errno_name_array): $(arch_errno_tbl)
-	$(Q)$(SHELL) '$(arch_errno_tbl)' $(CC) $(arch_errno_hdr_dir) > $@
+	$(Q)$(SHELL) '$(arch_errno_tbl)' $(firstword $(CC)) $(arch_errno_hdr_dir) > $@
 
 sync_file_range_arrays := $(beauty_outdir)/sync_file_range_arrays.c
 sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
-- 
2.21.1

From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/75] perf beauty mmap_flags: Check if the arch has a mmap.h file
Date: Thu,  6 Dec 2018 18:25:08 -0300
Message-ID: <20181206212602.20474-22-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If not, then just use what is in asm-generic. This fixes the build for
my sh4, m68k and riscv64 perf test build containers that were failing
due to 80ee5668b8a7 ("perf beauty: Add a generator for MAP_ mmap's flag
constants"), that were not covered in the cset introducing those
tools/arch/*/include/uapi/asm/mman.h files.

  f3539c12d819 ("tools include: Add uapi mman.h for each architecture")

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 80ee5668b8a7 ("perf beauty: Add a generator for MAP_ mmap's flag constants")
Link: https://lkml.kernel.org/n/tip-rpy9t2e0wxpnum1yvxhreafe@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf              | 2 +-
 tools/perf/trace/beauty/mmap_flags.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 67e9adbe6ee8..bfdaefd500ab 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -474,7 +474,7 @@ $(madvise_behavior_array): $(madvise_hdr_dir)/mman-common.h $(madvise_behavior_t
 mmap_flags_array := $(beauty_outdir)/mmap_flags_array.c
 mmap_flags_tbl := $(srctree)/tools/perf/trace/beauty/mmap_flags.sh
 
-$(mmap_flags_array): $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(arch_asm_uapi_dir)/mman.h $(mmap_flags_tbl)
+$(mmap_flags_array): $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(mmap_flags_tbl)
 	$(Q)$(SHELL) '$(mmap_flags_tbl)' $(asm_generic_uapi_dir) $(arch_asm_uapi_dir) > $@
 
 mount_flags_array := $(beauty_outdir)/mount_flags_array.c
diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index 22c3fdca8975..cd41023107d7 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -20,12 +20,12 @@ egrep -q $regex ${arch_mman} && \
 (egrep $regex ${arch_mman} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman} &&
+[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman} ] &&
 (egrep $regex ${header_dir}/mman-common.h | \
 	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman} &&
+[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman} ] &&
 (egrep $regex ${header_dir}/mman.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-- 
2.19.2

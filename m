From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/75] perf beauty mmap_flags: Fixed syntax error Fixed missing ']' error
Date: Thu,  6 Dec 2018 18:25:21 -0300
Message-ID: <20181206212602.20474-35-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sihyeon Jang <uneedsihyeon@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sihyeon Jang <uneedsihyeon@gmail.com>

Committer testing:

Before:

  # tools/perf/trace/beauty/mmap_flags.sh
  static const char *mmap_flags[] = {
	[ilog2(0x40) + 1] = "32BIT",
  tools/perf/trace/beauty/mmap_flags.sh: line 23: [: missing `]'
	[ilog2(0x01) + 1] = "SHARED",
	[ilog2(0x02) + 1] = "PRIVATE",
	[ilog2(0x10) + 1] = "FIXED",
	[ilog2(0x20) + 1] = "ANONYMOUS",
	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
  tools/perf/trace/beauty/mmap_flags.sh: line 28: [: missing `]'
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
  #

After:

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
  $

Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: aca70cc40a0b ("perf beauty mmap_flags: Check if the arch has a mmap.h file")
Link: http://lkml.kernel.org/r/20181202080651.4685-1-uneedsihyeon@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap_flags.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index cd41023107d7..32bac9c0d694 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -20,12 +20,12 @@ egrep -q $regex ${arch_mman} && \
 (egrep $regex ${arch_mman} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman} ] &&
+([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman}) &&
 (egrep $regex ${header_dir}/mman-common.h | \
 	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman} ] &&
+([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
 (egrep $regex ${header_dir}/mman.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-- 
2.19.2

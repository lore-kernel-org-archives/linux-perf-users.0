From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/37] perf arm64: Fix generate system call table failed with /tmp mounted with noexec
Date: Thu, 25 Oct 2018 08:09:59 -0300
Message-ID: <20181025111031.3440-6-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Hongxu Jia <hongxu.jia@windriver.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, =?UTF-8?q?S=C3=A9bastien=20Boisvert?= <sboisvert@gydle.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Hongxu Jia <hongxu.jia@windriver.com>

When /tmp is mounted with noexec, mksyscalltbl fails.

  [snip]
  |perf-1.0/tools/perf/arch/arm64/entry/syscalls//mksyscalltbl:
  /tmp/create-table-6VGPSt: Permission denied
  [snip]

Add variable TMPDIR as prefix dir of the temporary file, if it is set,
replace default /tmp.

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Sébastien Boisvert <sboisvert@gydle.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Fixes: 2b5882435606 ("perf arm64: Generate system call table from asm/unistd.h")
LPU-Reference: 1539851173-14959-1-git-send-email-hongxu.jia@windriver.com
Link: https://lkml.kernel.org/n/tip-1qrgq840ci0c5cy4oww957ge@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index 2dbb8cade048..c88fd32563eb 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -23,7 +23,7 @@ create_table_from_c()
 {
 	local sc nr last_sc
 
-	create_table_exe=`mktemp /tmp/create-table-XXXXXX`
+	create_table_exe=`mktemp ${TMPDIR:-/tmp}/create-table-XXXXXX`
 
 	{
 
-- 
2.14.4

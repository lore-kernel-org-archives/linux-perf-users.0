From: Hongxu Jia <hongxu.jia@windriver.com>
Subject: [PATCH V2] perf arm64: Fix generate system call table failed with /tmp mounted with noexec
Date: Fri, 19 Oct 2018 10:16:19 +0800
Message-ID: <1539915379-11910-1-git-send-email-hongxu.jia@windriver.com>
References: <1c6964d0-a7d2-83ef-16f2-bdf349e3f0af@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1c6964d0-a7d2-83ef-16f2-bdf349e3f0af@gydle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: kim.phillips@arm.com, brueckner@linux.ibm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, mpe@ellerman.id.au, peterz@infradead.org, ravi.bangoria@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com, acme@redhat.com, namhyung@kernel.org, hongxu.jia@windriver.com
List-Id: linux-perf-users.vger.kernel.org

When /tmp is mounted with noexec, mksyscalltbl fails.
[snip]
|perf-1.0/tools/perf/arch/arm64/entry/syscalls//mksyscalltbl:
/tmp/create-table-6VGPSt: Permission denied
[snip]

Add variable TMPDIR as prefix dir of the temporary file, if it is set,
replace default /tmp

Remove extra slash from `syscalls//mksyscalltbl'

Fixes: 2b5882435606 ("perf arm64: Generate system call table from asm/unistd.h")

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 tools/perf/arch/arm64/Makefile                    | 2 +-
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index dbef716..bc2a284 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -13,7 +13,7 @@ out    := $(OUTPUT)arch/arm64/include/generated/asm
 header := $(out)/syscalls.c
 incpath := $(srctree)/tools
 sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
-sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
+sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls
 systbl := $(sysprf)/mksyscalltbl
 
 # Create output directory if not already present
diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index 2dbb8cad..c88fd32 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -23,7 +23,7 @@ create_table_from_c()
 {
 	local sc nr last_sc
 
-	create_table_exe=`mktemp /tmp/create-table-XXXXXX`
+	create_table_exe=`mktemp ${TMPDIR:-/tmp}/create-table-XXXXXX`
 
 	{
 
-- 
2.7.4

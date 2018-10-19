From: Hongxu Jia <hongxu.jia@windriver.com>
Subject: [PATCH] perf arm64 Makefile: remove harmless but unneeded extra slash
Date: Sat, 20 Oct 2018 00:01:35 +0800
Message-ID: <1539964895-35174-1-git-send-email-hongxu.jia@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: kim.phillips@arm.com, brueckner@linux.ibm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, mpe@ellerman.id.au, peterz@infradead.org, ravi.bangoria@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com, acme@redhat.com, namhyung@kernel.org, hongxu.jia@windriver.com, sboisvert@gydle.com
List-Id: linux-perf-users.vger.kernel.org

Fixes: 2b5882435606 ("perf arm64: Generate system call table from asm/unistd.h")

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 tools/perf/arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.7.4

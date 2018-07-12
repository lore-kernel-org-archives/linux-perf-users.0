From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf kvm: Fix subcommands on s390
Date: Thu, 12 Jul 2018 09:09:36 +0200
Message-ID: <20180712070936.67547-1-tmricht@linux.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, stable@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

With commit eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
s390 platform provides detailed type/model/capacitiy information
in the CPU indentifier string instead of just "IBM/S390".

This breaks perf kvm support which uses hard coded string IBM/S390 to
compare with the CPU identifier string. Fix this by changing the comparison.

Fixes: eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
Cc: Stefan Raspl <raspl@linux.ibm.com>
Cc: <stable@vger.kernel.org> # 4.17

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/arch/s390/util/kvm-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index d233e2eb9592..aaabab5e2830 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -102,7 +102,7 @@ const char * const kvm_skip_events[] = {
 
 int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
 {
-	if (strstr(cpuid, "IBM/S390")) {
+	if (strstr(cpuid, "IBM")) {
 		kvm->exit_reasons = sie_exit_reasons;
 		kvm->exit_reasons_isa = "SIE";
 	} else
-- 
2.14.3

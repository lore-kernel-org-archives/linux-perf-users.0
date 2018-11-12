From: Pu Wen <puwen@hygon.cn>
Subject: [RFC PATCH RESEND] tools/perf: Add Hygon Dhyana support
Date: Mon, 12 Nov 2018 15:40:51 +0800
Message-ID: <1542008451-31735-1-git-send-email-puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Pu Wen <puwen@hygon.cn>
List-Id: linux-perf-users.vger.kernel.org

The tool perf is useful for the performance analysis on the Hygon Dhyana
platform. But right now there is no Hygon support for it to analyze the
KVM guest os data. So add Hygon Dhyana support to it by checking vendor
string to share the code path of AMD.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 tools/perf/arch/x86/util/kvm-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index b32409a..081353d 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -156,7 +156,7 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
 	if (strstr(cpuid, "Intel")) {
 		kvm->exit_reasons = vmx_exit_reasons;
 		kvm->exit_reasons_isa = "VMX";
-	} else if (strstr(cpuid, "AMD")) {
+	} else if (strstr(cpuid, "AMD") || strstr(cpuid, "Hygon")) {
 		kvm->exit_reasons = svm_exit_reasons;
 		kvm->exit_reasons_isa = "SVM";
 	} else
-- 
2.7.4

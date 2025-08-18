Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8942204583;
	Mon, 18 Aug 2025 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552933; cv=none; b=f69i9ZS3QNufBDinjPWZ4gUkT2c6hJ3IsucwITqLJNzBCco+DSHbg90wTfL3801xtJB8v4VnbKjs+Fb7o04bvdpcRr9W7eNQhR6W6dgZWF/tjfZRr0hP6Y9XxVVqWw5jNCap85HIVhVeC9s9Z7Ziyip04UsaNqOAyn2pcII1aj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552933; c=relaxed/simple;
	bh=Z+1IquETUuvnvgb9eqz1cuwQMXLohgMxMNidxvFnrZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7CfbPtBiLLU9Th1lqOUYTqKfet7ToU1pwoa8nuuE3zYIMVHvtYlUPJNDW3PmvDcW2+jEnIXPFfapef+AikJ2/EHno3nz2Jg9GcXMC5WaS16PlxYBtERuH+Y2hJWEWWX/LMvOtafJy1h+7g31NJg/8yv80wEnOcceH30tAA7rTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03AB619F0;
	Mon, 18 Aug 2025 14:35:23 -0700 (PDT)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D1903F738;
	Mon, 18 Aug 2025 14:35:30 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	thiago.bauermann@linaro.org,
	broonie@kernel.org,
	yury.khrustalev@arm.com,
	kristina.martsenko@arm.com,
	liaochang1@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>,
	Steve Capper <steve.capper@arm.com>
Subject: [PATCH v6 5/7] arm64: uprobes: Add GCS support to uretprobes
Date: Mon, 18 Aug 2025 16:34:50 -0500
Message-ID: <20250818213452.50439-6-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818213452.50439-1-jeremy.linton@arm.com>
References: <20250818213452.50439-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ret probes work by changing the value in the link register at
the probe location to return to the probe rather than the calling
routine. Thus the GCS needs to be updated with this address as well.

Since its possible to insert probes at locations where the
current value of the LR doesn't match the GCS state this needs
to be detected and handled in order to maintain the existing
no-fault behavior.

Co-developed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
(updated to use new gcs accessors, and handle LR/GCS mismatches)
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/probes/uprobes.c | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index 1f91fd2a8187..6b98503a0198 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -6,6 +6,7 @@
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
 #include <asm/cacheflush.h>
+#include <asm/gcs.h>
 
 #include "decode-insn.h"
 
@@ -159,11 +160,43 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 				  struct pt_regs *regs)
 {
 	unsigned long orig_ret_vaddr;
+	unsigned long gcs_ret_vaddr;
+	int err = 0;
+	u64 gcspr;
 
 	orig_ret_vaddr = procedure_link_pointer(regs);
+
+	if (task_gcs_el0_enabled(current)) {
+		gcspr = read_sysreg_s(SYS_GCSPR_EL0);
+		gcs_ret_vaddr = get_user_gcs((unsigned long __user *)gcspr, &err);
+		if (err) {
+			force_sig(SIGSEGV);
+			goto out;
+		}
+
+		/*
+		 * If the LR and GCS return addr don't match, then some kind of PAC
+		 * signing or control flow occurred since entering the probed function.
+		 * Likely because the user is attempting to retprobe on an instruction
+		 * that isn't a function boundary or inside a leaf function. Explicitly
+		 * abort this retprobe because it will generate a GCS exception.
+		 */
+		if (gcs_ret_vaddr != orig_ret_vaddr) {
+			orig_ret_vaddr = -1;
+			goto out;
+		}
+
+		put_user_gcs(trampoline_vaddr, (unsigned long __user *)gcspr, &err);
+		if (err) {
+			force_sig(SIGSEGV);
+			goto out;
+		}
+	}
+
 	/* Replace the return addr with trampoline addr */
 	procedure_link_pointer_set(regs, trampoline_vaddr);
 
+out:
 	return orig_ret_vaddr;
 }
 
-- 
2.50.1


Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5E13D544;
	Mon, 21 Apr 2025 05:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745214748; cv=none; b=da35cxxxKZxY+s57Givno/JC9jNnacgSNY9PveRh6DltbwgMTHK5bXX7oYTYHmcSDruF6j0PaE8k67iCPP6fJnXHuU+dDzxnm01En6ysmWf9p0BvlH2uGP5ZXky9jcAHgMbKcWR+4z1COt9eIzhLX/wwBlb910vDIKFXzYdL70c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745214748; c=relaxed/simple;
	bh=wZjJBN3xFy9LG8Qvwy9ErSuPhnkRMtBcU0buZu4NYBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JqF3YAdUVJiMSRtcuCsHhmOjovtviSFlDgOqbnRKejg5HU9CGy+O2eDfzv2P5AJl/YzQ14UMR00+RBoZYEV2zLLnpjLb7boqshnPlAsyfHiocD4gGG1XKd/SJs5+sXHXAOHJgJtS+3zqi15JmDMNZugOaOJaGQnT0054t2+bZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD01A339;
	Sun, 20 Apr 2025 22:52:15 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.16.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90EEB3F59E;
	Sun, 20 Apr 2025 22:52:17 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/ptrace: Make user_hwdebug_state.dbg_regs[] array size as ARM_MAX_BRP
Date: Mon, 21 Apr 2025 11:22:12 +0530
Message-Id: <20250421055212.123774-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Array elements inside 'struct user_hwdebug_state.dbg_regs[]' are inherently
coupled with maximum breakpoints or watchpoints which could be present on a
platform and which are defined with macros ARM_MAX_[BRP|WRP].

Rather than explicitly trying to keep the array elements in sync with these
macros and then adding a BUILD_BUG_ON() just to ensure continued compliance
, move these two macros into the uapi ptrace header itself thus making them
available both for user space and kernel.

While here also ensure that ARM_MAX_BRP and ARM_MAX_WRP are always the same
via a new BUILD_BUG_ON(). This helps in making sure that user_hwdebug_state
structure remains usable both for breakpoint and watchpoint registers set
via ptrace() system call interface.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.15-rc3

 arch/arm64/include/asm/hw_breakpoint.h |  7 -------
 arch/arm64/include/uapi/asm/ptrace.h   | 10 +++++++++-
 arch/arm64/kernel/hw_breakpoint.c      |  9 +++++++++
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index bd81cf17744a..63c21b515647 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -75,13 +75,6 @@ static inline void decode_ctrl_reg(u32 reg,
 #define ARM_KERNEL_STEP_ACTIVE	1
 #define ARM_KERNEL_STEP_SUSPEND	2
 
-/*
- * Limits.
- * Changing these will require modifications to the register accessors.
- */
-#define ARM_MAX_BRP		16
-#define ARM_MAX_WRP		16
-
 /* Virtual debug register bases. */
 #define AARCH64_DBG_REG_BVR	0
 #define AARCH64_DBG_REG_BCR	(AARCH64_DBG_REG_BVR + ARM_MAX_BRP)
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 0f39ba4f3efd..8683f541a467 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -99,6 +99,14 @@ struct user_fpsimd_state {
 	__u32		__reserved[2];
 };
 
+/*
+ * Maximum number of breakpoint and watchpoint registers
+ * on the platform. These macros get used both in kernel
+ * and user space as well.
+ */
+#define ARM_MAX_BRP		16
+#define ARM_MAX_WRP		16
+
 struct user_hwdebug_state {
 	__u32		dbg_info;
 	__u32		pad;
@@ -106,7 +114,7 @@ struct user_hwdebug_state {
 		__u64	addr;
 		__u32	ctrl;
 		__u32	pad;
-	}		dbg_regs[16];
+	}		dbg_regs[ARM_MAX_BRP];	/* Or ARM_MAX_WRP */
 };
 
 /* SVE/FP/SIMD state (NT_ARM_SVE & NT_ARM_SSVE) */
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 722ac45f9f7b..9bc51682713d 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -981,6 +981,15 @@ static int __init arch_hw_breakpoint_init(void)
 {
 	int ret;
 
+	/*
+	 * Maximum supported breakpoint and watchpoint registers must
+	 * always be the same - regardless of actual register numbers
+	 * found on a given platform. This is because the user facing
+	 * ptrace structure 'user_hwdebug_state' actually depends on
+	 * these macros to be the same.
+	 */
+	BUILD_BUG_ON(ARM_MAX_BRP != ARM_MAX_WRP);
+
 	core_num_brps = get_num_brps();
 	core_num_wrps = get_num_wrps();
 
-- 
2.25.1


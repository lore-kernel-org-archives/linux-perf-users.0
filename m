Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4627EFE9;
	Tue,  7 Apr 2026 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572219; cv=none; b=eFd87nMoD7vgtbtKyD/GgSwVnhE/TtGUwzpeLqK14ZzBXZ8Lr8C7wyHz9r8FTncIGDkD85aBJewkABIHPZ7YmbYI+YoxYOzkgXrsaKoNy77UmSyu9huaHIlU+SMk7ATeeHGnR3LdIO7pHPMiey3Epor26G7AEtblxpTZm6APIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572219; c=relaxed/simple;
	bh=SJDQ3b5SsRthX8/7tiLEloyuRg0cJ7pkoH2/b6dPyTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbGACKJhCMxC/vbbarlykQlifUmNI+IVC9U63M8H9m7eJM3JVHd/0mARnVw+GiGIvLjluOBi4nLeCnSfNFqS3FYZaSyc0H3tr6v0Xb/SX6aNK4Ow3tcMm6BI5NDW9t5u0Q8Zj18ps8veZBvG9pXMLsNDFF9KvT6pQRpJB1UjTMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEBen4WD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEBen4WD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A10C2BCB5;
	Tue,  7 Apr 2026 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775572218;
	bh=SJDQ3b5SsRthX8/7tiLEloyuRg0cJ7pkoH2/b6dPyTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZEBen4WD5noftUnkL55UHtJD5sfjPzXnWFbmZAjtb3mJX89esSwhus8rJnPftmxe+
	 FbtJlWTqB1BK1ORUdlnYLkDy2hiQu18chJxTBCnau2CgCoIoF6XqlSjK2uEUYZmmEm
	 w6cqdP+DkrUkK2FfDLCfEjzycA9ZfQtFPEwYVbPLrJH0mT/WwpzLPk8khqfn+vuwWx
	 C161Q+FNw0IfMZ+5dbDKMzUP/d06V8gn4zLsxtRlfJZQtJ+AYCCLS/Kk8So2nUivk0
	 5iRf9TNvlLxC7M62XO2Iex6CCrh5xA/+aiBzbSO2I1YwVacszwEDUpfBaMqXsL0W0V
	 8eh6SB2Tq4e2A==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 07 Apr 2026 09:29:48 -0500
Subject: [PATCH v4 6/6] arm64: hw_breakpoint: Enable FEAT_Debugv8p9
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-arm-debug-8-9-v4-6-a4864e69b0ea@kernel.org>
References: <20260407-arm-debug-8-9-v4-0-a4864e69b0ea@kernel.org>
In-Reply-To: <20260407-arm-debug-8-9-v4-0-a4864e69b0ea@kernel.org>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15-dev

From: Anshuman Khandual <anshuman.khandual@arm.com>

Currently, there can be maximum 16 breakpoints and 16 watchpoints available
on a given platform - as detected from ID_AA64DFR0_EL1.[BRPs|WRPs] register
fields. These breakpoints and watchpoints can be extended further up to
64 via a new arch feature FEAT_Debugv8p9.

Checking for FEAT_Debugv8p9 alone is not enough to enable the support.
It is also necessary to determine if there are more than 16 breakpoints
or watchpoints. The behavior with FEAT_Debugv8p9 and <=16 breakpoints
and watchpoints is IMPDEF.

The addition of the MDSELR_EL1 to set the bank index makes the register
accesses non-atomic. However, the combination of all the breakpoint code
being in the kprobe blacklist and breakpoint install/uninstall being
protected by perf locking (IRQs disabled and context lock) will prevent
debug exceptions during accesses and serialize the accesses.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - Update commit message.
 - Configure MDSCR_EL1_EMBWE on CPU reset/hotplug instead of every time
   breakpoints are enabled/disabled.
 - Drop unnecessary IRQ save and restore on register accesses.
 - Stash checking whether FEAT_Debugv8p9 is used rather than reading
   feature register on every register access.
 - Check that we're greater than or equal to Debug_v8p9 not just equal
   to.
 - Use is_debug_v8p9_enabled() in get_num_brps/get_num_wrps(). Handle
   the case when FEAT_Debugv8p9 is present, but the number of BP/WP
   are <16. It is IMPDEF if ID_AA64DFR1_EL1 is used in this case. It is
   also IMPDEF if MDSELR_EL1 is accessible. TF-A doesn't enable access
   to MDSELR_EL1 in this case.
 - Mark register access functions nokprobe.
---
 arch/arm64/include/asm/hw_breakpoint.h | 47 ++++++++++++++++++++++++++--------
 arch/arm64/kernel/debug-monitors.c     | 16 ++++++++----
 arch/arm64/kernel/hw_breakpoint.c      | 41 +++++++++++++++++++++++++++--
 3 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index bd81cf17744a..c5624a906f3c 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -79,8 +79,9 @@ static inline void decode_ctrl_reg(u32 reg,
  * Limits.
  * Changing these will require modifications to the register accessors.
  */
-#define ARM_MAX_BRP		16
-#define ARM_MAX_WRP		16
+#define ARM_MAX_BRP		64
+#define ARM_MAX_WRP		64
+#define MAX_PER_BANK		16
 
 /* Virtual debug register bases. */
 #define AARCH64_DBG_REG_BVR	0
@@ -94,6 +95,14 @@ static inline void decode_ctrl_reg(u32 reg,
 #define AARCH64_DBG_REG_NAME_WVR	wvr
 #define AARCH64_DBG_REG_NAME_WCR	wcr
 
+static inline bool is_debug_v8p9_enabled(void)
+{
+	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
+	int dver = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_DebugVer_SHIFT);
+
+	return dver >= ID_AA64DFR0_EL1_DebugVer_V8P9;
+}
+
 /* Accessor macros for the debug registers. */
 #define AARCH64_DBG_READ(N, REG, VAL) do {\
 	VAL = read_sysreg(dbg##REG##N##_el1);\
@@ -138,19 +147,37 @@ static inline void ptrace_hw_copy_thread(struct task_struct *task)
 /* Determine number of BRP registers available. */
 static inline int get_num_brps(void)
 {
-	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
-	return 1 +
-		cpuid_feature_extract_unsigned_field(dfr0,
-						ID_AA64DFR0_EL1_BRPs_SHIFT);
+	u64 dfr0, dfr1;
+	int brps;
+
+	dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
+	brps = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_BRPs_SHIFT);
+	if (is_debug_v8p9_enabled() && brps == 15) {
+		dfr1 = read_sanitised_ftr_reg(SYS_ID_AA64DFR1_EL1);
+		brps = cpuid_feature_extract_unsigned_field_width(dfr1,
+								  ID_AA64DFR1_EL1_BRPs_SHIFT, 8);
+		if (!brps)
+			return 16;
+	}
+	return 1 + brps;
 }
 
 /* Determine number of WRP registers available. */
 static inline int get_num_wrps(void)
 {
-	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
-	return 1 +
-		cpuid_feature_extract_unsigned_field(dfr0,
-						ID_AA64DFR0_EL1_WRPs_SHIFT);
+	u64 dfr0, dfr1;
+	int wrps;
+
+	dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
+	wrps = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_WRPs_SHIFT);
+	if (is_debug_v8p9_enabled() && wrps == 15) {
+		dfr1 = read_sanitised_ftr_reg(SYS_ID_AA64DFR1_EL1);
+		wrps = cpuid_feature_extract_unsigned_field_width(dfr1,
+								  ID_AA64DFR1_EL1_WRPs_SHIFT, 8);
+		if (!wrps)
+			return 16;
+	}
+	return 1 + wrps;
 }
 
 #ifdef CONFIG_CPU_PM
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 29307642f4c9..8ff74432d0c3 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -22,6 +22,7 @@
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/exception.h>
+#include <asm/hw_breakpoint.h>
 #include <asm/kgdb.h>
 #include <asm/kprobes.h>
 #include <asm/system_misc.h>
@@ -123,11 +124,16 @@ void disable_debug_monitors(enum dbg_active_el el)
 }
 NOKPROBE_SYMBOL(disable_debug_monitors);
 
-/*
- * OS lock clearing.
- */
-static int clear_os_lock(unsigned int cpu)
+static int debug_monitors_reset(unsigned int cpu)
 {
+	if (is_debug_v8p9_enabled()) {
+		u64 mdscr = mdscr_read();
+
+		mdscr |= MDSCR_EL1_EMBWE;
+		mdscr_write(mdscr);
+	}
+
+	/* Clear OS lock */
 	write_sysreg(0, osdlr_el1);
 	write_sysreg(0, oslar_el1);
 	isb();
@@ -138,7 +144,7 @@ static int __init debug_monitors_init(void)
 {
 	return cpuhp_setup_state(CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
 				 "arm64/debug_monitors:starting",
-				 clear_os_lock, NULL);
+				 debug_monitors_reset, NULL);
 }
 postcore_initcall(debug_monitors_init);
 
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index a9266dc710b4..ea48c1562bee 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -40,6 +40,7 @@ static DEFINE_PER_CPU(int, stepping_kernel_bp);
 /* Number of BRP/WRP registers on this CPU. */
 static int core_num_brps;
 static int core_num_wrps;
+static bool has_debug_v8p9;
 
 int hw_breakpoint_slots(int type)
 {
@@ -104,7 +105,7 @@ int hw_breakpoint_slots(int type)
 	WRITE_WB_REG_CASE(OFF, 14, REG, VAL);	\
 	WRITE_WB_REG_CASE(OFF, 15, REG, VAL)
 
-static u64 read_wb_reg(int reg, int n)
+static nokprobe_inline u64 __read_wb_reg(int reg, int n)
 {
 	u64 val = 0;
 
@@ -119,9 +120,27 @@ static u64 read_wb_reg(int reg, int n)
 
 	return val;
 }
+
+static u64 read_wb_reg(int reg, int n)
+{
+	u64 val;
+
+	/*
+	 * Bank selection in MDSELR_EL1, followed by an indexed read from
+	 * breakpoint (or watchpoint) registers cannot be interrupted, as
+	 * that might cause misread from the wrong targets instead. Hence
+	 * this requires mutual exclusion.
+	 */
+	if (has_debug_v8p9) {
+		write_sysreg_s(SYS_FIELD_PREP(MDSELR_EL1, BANK, n / MAX_PER_BANK), SYS_MDSELR_EL1);
+		isb();
+	}
+	val = __read_wb_reg(reg, n % MAX_PER_BANK);
+	return val;
+}
 NOKPROBE_SYMBOL(read_wb_reg);
 
-static void write_wb_reg(int reg, int n, u64 val)
+static nokprobe_inline void __write_wb_reg(int reg, int n, u64 val)
 {
 	switch (reg + n) {
 	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_BVR, AARCH64_DBG_REG_NAME_BVR, val);
@@ -133,6 +152,21 @@ static void write_wb_reg(int reg, int n, u64 val)
 	}
 	isb();
 }
+
+static void write_wb_reg(int reg, int n, u64 val)
+{
+	/*
+	 * Bank selection in MDSELR_EL1, followed by an indexed read from
+	 * breakpoint (or watchpoint) registers cannot be interrupted, as
+	 * that might cause misread from the wrong targets instead. Hence
+	 * this requires mutual exclusion.
+	 */
+	if (has_debug_v8p9) {
+		write_sysreg_s(SYS_FIELD_PREP(MDSELR_EL1, BANK, n / MAX_PER_BANK), SYS_MDSELR_EL1);
+		isb();
+	}
+	__write_wb_reg(reg, n % MAX_PER_BANK, val);
+}
 NOKPROBE_SYMBOL(write_wb_reg);
 
 /*
@@ -990,6 +1024,7 @@ static int __init arch_hw_breakpoint_init(void)
 
 	core_num_brps = get_num_brps();
 	core_num_wrps = get_num_wrps();
+	has_debug_v8p9 = (core_num_brps > 16) || (core_num_wrps > 16);
 
 	pr_info("found %d breakpoint and %d watchpoint registers.\n",
 		core_num_brps, core_num_wrps);
@@ -1006,6 +1041,8 @@ static int __init arch_hw_breakpoint_init(void)
 
 	/* Register cpu_suspend hw breakpoint restore hook */
 	cpu_suspend_set_dbg_restorer(hw_breakpoint_reset);
+	BUILD_BUG_ON((ARM_MAX_BRP % MAX_PER_BANK) != 0);
+	BUILD_BUG_ON((ARM_MAX_WRP % MAX_PER_BANK) != 0);
 
 	return ret;
 }

-- 
2.53.0


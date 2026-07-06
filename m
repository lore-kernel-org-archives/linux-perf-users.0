Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0218C2C;
	Mon,  6 Jul 2026 02:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303294; cv=none; b=DMM1tjxgHcSwf4WONbuABo1znDFY+l5yEZ80JEnNVWiCOBBQh+4zMxVu+4Tz4Iz+fQr1ypIR/6L9vF3XoQE7bhOhGFzB6dcX6uMUu3DLTZroUZFu3u+EvsDktFXyzDCoHdcRlhzhj8AucjbReo0QS8WLz+BpmNOeLWS1wmypS2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303294; c=relaxed/simple;
	bh=BeOKSbUGemldust9ypJ1lFfU0hJlWuoaMcv4mPUDYNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H8iE6TpzXNMka13+F3aikZDqFwOsJDECLKCLgEuSET+FvEwLLEDhOljCxVXVyYrYLG/6sVBONZHimn5z10kF7Q8iktJtNdMtEGjN7UHIEn9LybRe7w/y9P6xPgqeFSRn4b8eyFEvhQHTZCmwjK1nhdzQmjLco9wyeDzsTGq+s3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBri7EC1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBri7EC1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303293; x=1814839293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BeOKSbUGemldust9ypJ1lFfU0hJlWuoaMcv4mPUDYNc=;
  b=IBri7EC1FBZTrVlWwrQ8+kEumdQDhmc3TZe7AcjyV3psUjeoqibp12X/
   w/AchNyWoMxWU6PgzBXamo6XiVE0iloSnujk0h7gY4v0AnBwNMbiL+oNo
   8T+Z4N7HKXLrEa8kXI7sqTzzMXUnRALm9AmnHZBbdTeVQnLCt6bE+iRbA
   6BPfUGpZSPmKAYV/pY/gEykv6O22HjBsWb0klHuWVrL8aPG6lBpWSxS1k
   J19rfVV4lPAfZL3tP/b70/8DhaL4uVwFLkvxWzUp7y16tt+8eC+qhE6pU
   4WlX54Chdy4BcO8DKywH+bHNl31DA6VCmRT/5W7CE/HsKRs9am5aiPBPW
   A==;
X-CSE-ConnectionGUID: 9xFIjomCTuO0r6Qyl6mCAw==
X-CSE-MsgGUID: 19Vi5LtqSpWhoKDRwoGDXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911595"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911595"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:01:33 -0700
X-CSE-ConnectionGUID: WSeW62PqQ7uMXvIMT11Hqg==
X-CSE-MsgGUID: cFuNC/AeRI6wyvWqqy3IzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191283"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:01:28 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v9 05/24] perf: Eliminate duplicate arch-specific function definitions
Date: Mon,  6 Jul 2026 09:54:20 +0800
Message-Id: <20260706015439.3040804-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define default common __weak functions for perf_reg_value(),
perf_reg_validate(), perf_reg_abi() and perf_get_regs_user(). This helps
to eliminate the duplicated arch-specific definitions.

No function changes intended.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/arm/kernel/perf_regs.c       |  6 ------
 arch/arm64/kernel/perf_regs.c     |  6 ------
 arch/csky/kernel/perf_regs.c      |  6 ------
 arch/loongarch/kernel/perf_regs.c |  6 ------
 arch/mips/kernel/perf_regs.c      |  6 ------
 arch/parisc/kernel/perf_regs.c    |  6 ------
 arch/riscv/kernel/perf_regs.c     |  6 ------
 arch/x86/kernel/perf_regs.c       |  6 ------
 include/linux/perf_regs.h         | 32 ++++++-------------------------
 kernel/events/core.c              | 22 +++++++++++++++++++++
 10 files changed, 28 insertions(+), 74 deletions(-)

diff --git a/arch/arm/kernel/perf_regs.c b/arch/arm/kernel/perf_regs.c
index 0529f90395c9..d575a4c3ca56 100644
--- a/arch/arm/kernel/perf_regs.c
+++ b/arch/arm/kernel/perf_regs.c
@@ -31,9 +31,3 @@ u64 perf_reg_abi(struct task_struct *task)
 	return PERF_SAMPLE_REGS_ABI_32;
 }
 
-void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs)
-{
-	regs_user->regs = task_pt_regs(current);
-	regs_user->abi = perf_reg_abi(current);
-}
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index b4eece3eb17d..70e2f13f587f 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -98,9 +98,3 @@ u64 perf_reg_abi(struct task_struct *task)
 		return PERF_SAMPLE_REGS_ABI_64;
 }
 
-void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs)
-{
-	regs_user->regs = task_pt_regs(current);
-	regs_user->abi = perf_reg_abi(current);
-}
diff --git a/arch/csky/kernel/perf_regs.c b/arch/csky/kernel/perf_regs.c
index 09b7f88a2d6a..94601f37b596 100644
--- a/arch/csky/kernel/perf_regs.c
+++ b/arch/csky/kernel/perf_regs.c
@@ -31,9 +31,3 @@ u64 perf_reg_abi(struct task_struct *task)
 	return PERF_SAMPLE_REGS_ABI_32;
 }
 
-void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs)
-{
-	regs_user->regs = task_pt_regs(current);
-	regs_user->abi = perf_reg_abi(current);
-}
diff --git a/arch/loongarch/kernel/perf_regs.c b/arch/loongarch/kernel/perf_regs.c
index 263ac4ab5af6..8dd604f01745 100644
--- a/arch/loongarch/kernel/perf_regs.c
+++ b/arch/loongarch/kernel/perf_regs.c
@@ -45,9 +45,3 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return regs->regs[idx];
 }
 
-void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs)
-{
-	regs_user->regs = task_pt_regs(current);
-	regs_user->abi = perf_reg_abi(current);
-}
diff --git a/arch/mips/kernel/perf_regs.c b/arch/mips/kernel/perf_regs.c
index e686780d1647..7736d3c5ebd2 100644
--- a/arch/mips/kernel/perf_regs.c
+++ b/arch/mips/kernel/perf_regs.c
@@ -60,9 +60,3 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return (s64)v; /* Sign extend if 32-bit. */
 }
 
-void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs)
-{
-	regs_user->regs = task_pt_regs(current);
-	regs_user->abi = perf_reg_abi(current);
-}
diff --git a/arch/parisc/kernel/perf_regs.c b/arch/parisc/kernel/perf_regs.c
index 10a1a5f06a18..b9fe1f2fcb9b 100644
--- a/arch/parisc/kernel/perf_regs.c
+++ b/arch/parisc/kernel/perf_regs.c
@@ -53,9 +53,3 @@ u64 perf_reg_abi(struct task_struct *task)
 	return PERF_SAMPLE_REGS_ABI_64;
 }
 
-void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs)
-{
-	regs_user->regs = task_pt_regs(current);
-	regs_user->abi = perf_reg_abi(current);
-}
diff --git a/arch/riscv/kernel/perf_regs.c b/arch/riscv/kernel/perf_regs.c
index fd304a248de6..3bba8deababb 100644
--- a/arch/riscv/kernel/perf_regs.c
+++ b/arch/riscv/kernel/perf_regs.c
@@ -35,9 +35,3 @@ u64 perf_reg_abi(struct task_struct *task)
 #endif
 }
 
-void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs)
-{
-	regs_user->regs = task_pt_regs(current);
-	regs_user->abi = perf_reg_abi(current);
-}
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 624703af80a1..81204cb7f723 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -100,12 +100,6 @@ u64 perf_reg_abi(struct task_struct *task)
 	return PERF_SAMPLE_REGS_ABI_32;
 }
 
-void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs)
-{
-	regs_user->regs = task_pt_regs(current);
-	regs_user->abi = perf_reg_abi(current);
-}
 #else /* CONFIG_X86_64 */
 #define REG_NOSUPPORT ((1ULL << PERF_REG_X86_DS) | \
 		       (1ULL << PERF_REG_X86_ES) | \
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index f632c5725f16..144bcc3ff19f 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -9,6 +9,12 @@ struct perf_regs {
 	struct pt_regs	*regs;
 };
 
+u64 perf_reg_value(struct pt_regs *regs, int idx);
+int perf_reg_validate(u64 mask);
+u64 perf_reg_abi(struct task_struct *task);
+void perf_get_regs_user(struct perf_regs *regs_user,
+			struct pt_regs *regs);
+
 #ifdef CONFIG_HAVE_PERF_REGS
 #include <asm/perf_regs.h>
 
@@ -16,35 +22,9 @@ struct perf_regs {
 #define PERF_REG_EXTENDED_MASK	0
 #endif
 
-u64 perf_reg_value(struct pt_regs *regs, int idx);
-int perf_reg_validate(u64 mask);
-u64 perf_reg_abi(struct task_struct *task);
-void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs);
 #else
 
 #define PERF_REG_EXTENDED_MASK	0
 
-static inline u64 perf_reg_value(struct pt_regs *regs, int idx)
-{
-	return 0;
-}
-
-static inline int perf_reg_validate(u64 mask)
-{
-	return mask ? -ENOSYS : 0;
-}
-
-static inline u64 perf_reg_abi(struct task_struct *task)
-{
-	return PERF_SAMPLE_REGS_ABI_NONE;
-}
-
-static inline void perf_get_regs_user(struct perf_regs *regs_user,
-				      struct pt_regs *regs)
-{
-	regs_user->regs = task_pt_regs(current);
-	regs_user->abi = perf_reg_abi(current);
-}
 #endif /* CONFIG_HAVE_PERF_REGS */
 #endif /* _LINUX_PERF_REGS_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0f29d17a600d..82009bfb4fd9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7807,6 +7807,28 @@ unsigned long perf_instruction_pointer(struct perf_event *event,
 		0 : perf_arch_instruction_pointer(regs);
 }
 
+u64 __weak perf_reg_value(struct pt_regs *regs, int idx)
+{
+	return 0;
+}
+
+int __weak perf_reg_validate(u64 mask)
+{
+	return mask ? -ENOSYS : 0;
+}
+
+u64 __weak perf_reg_abi(struct task_struct *task)
+{
+	return PERF_SAMPLE_REGS_ABI_NONE;
+}
+
+void __weak perf_get_regs_user(struct perf_regs *regs_user,
+			       struct pt_regs *regs)
+{
+	regs_user->regs = task_pt_regs(current);
+	regs_user->abi = perf_reg_abi(current);
+}
+
 static void
 perf_output_sample_regs(struct perf_output_handle *handle,
 			struct pt_regs *regs, u64 mask)
-- 
2.34.1


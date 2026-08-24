Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7E3EC82B;
	Mon, 24 Aug 2026 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560473; cv=none; b=FzvSF6mkaIxcb5xnUommOlDO8miFi+lAfx0pWLEuD4mI/YoL6PcLnTQK/qKaT3iOlzaPE006jw+GCZexSAKoofjbR3L/bRL81op2Ah7cNLAe4aWOjXVlwA9/IoECbfHgYM1Sm/gN9TWXqg1YO2/kPkUWrnn2/AlLBTMn7cLWWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560473; c=relaxed/simple;
	bh=Y6CjqyIN9BhD//XXN13QoTb+JBuG4vVdfsZb71K0hFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=doiaUzdFVVo/glFZR8tmlIWKSQsFA5O1BzlQv46qksvCHJpt1sI8uqMH8R68EKIim3FGhoPu6q3xzr+Zl6Bk4ynX8NHfxDYnHS8VI73y+9XfBBFWTU4e3sfYt6DdHlGKIXQhexYYYQhX707TPp1uQF6ZPmFOYqMNOmmW+MuBOl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WV6COMSQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WV6COMSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560472; x=1819096472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y6CjqyIN9BhD//XXN13QoTb+JBuG4vVdfsZb71K0hFg=;
  b=WV6COMSQMeXgHJxIoZ3T3knATAyqlNzYzHOjkeODbBeTGnJnRs1FDHp4
   K9cNaD2mRzU2yix/yWy9FCUNjTzr1zg0Knktd2SHS+3CGVmT/u07ynqJm
   0hvp08znXNDddBMWUB4lu7Rx7tERJghGvEcNEp9gC1w2UYF3eoq23QnKc
   /jevcz2dC4IzPTlFmoagLtMxaNHAkXQUq+DZEeJfjhlT7OdLbev/pw5Im
   62lek3RLMtKhDT8jH7wpr2zS7X4IBq/zSO3YMIvIPAtGP4/UVtNzvof5F
   /Nq/iaq12/uQq3/P+IDphtyUsQRPnO9oel081qdwV36X7qI/xFE0kOXgh
   A==;
X-CSE-ConnectionGUID: nUD0FC+uTS6zS8o0gR4RtA==
X-CSE-MsgGUID: 6bJwVo9yQe67mHwHPIzxwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598712"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598712"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:34:31 -0700
X-CSE-ConnectionGUID: Ykn98ASaQE62/kpmACpPDg==
X-CSE-MsgGUID: 3R+ANJXoT9KhfonlHsdokA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264326040"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:34:26 -0700
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
Subject: [RESEND Patch v10 04/23] perf: Eliminate duplicate arch-specific function definitions
Date: Mon, 24 Aug 2026 16:27:12 +0800
Message-Id: <20260824082731.1013973-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
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
index 4638544205f2..aac1617865d5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7809,6 +7809,28 @@ unsigned long perf_instruction_pointer(struct perf_event *event,
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


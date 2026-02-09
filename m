Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6E3033F5;
	Mon,  9 Feb 2026 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621915; cv=none; b=A8OrRrMuOgUGUtgS+sLHAl6i0Wvzu8fsP5jkq6zrO7YqvC/klWjpMpx4AWcpTcDDYSVTwDwrg/OFqS8a8/BbmVShwh5mmksiMC0WTVNbr80zKH4TzRxDoVaPB049PRbQKqHDBPxKm7zP8JgvnLMyGpA4sJAc+iUzKpk2XRLB0wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621915; c=relaxed/simple;
	bh=xTp/DsfHjyWY1mGACH6X7HJX8BBEFPachisALC7Njeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwCSAWL4ONwnLZHaK7+YIDzHNwXtAAeoKjOfNxvfbmjqZWPsqegDobR5cK7K5ECY6nDG3EZ/szUrqy17ZrJBGRr03PbUNbgpDHlbzHpscOfxlpClbJ+fOtV2gQjASFMunIsqNDRmNC4PN9R39k7WMHa03dzz0nNxuEaaFhqzfUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mX+sTI5x; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mX+sTI5x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621916; x=1802157916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTp/DsfHjyWY1mGACH6X7HJX8BBEFPachisALC7Njeg=;
  b=mX+sTI5xkf8tQWayey5NTf/IUW6DJ13mbaHWpYo3C/ZDH0jfcjQGHRuY
   rIxhmchfjj1zdZpQcQB7wVEE/n2TBTVMsxEblRKFH1uKq+8MutgxjbBzj
   SJ0w57zWER+Ark2DxrBmF6M7AkqSBazU5VOTzYkr82jTO24MzaIZiEBC5
   VZ31yERlDNBxjoKUs1Ygq5YjJ6mh3BGRqLeKDdNQgpyJIRwKKvrHNjbqS
   VgSSKFryXyGX3Tl5tJueCgtgnyIJsl4FJmNM4cj9N05Qz6/9gtRW2esC0
   Cn3HISEUW169wjuCnCPtdPM9+lrQ5Mdh7L0yfNHq10ihqOz9tw7sNxYgA
   A==;
X-CSE-ConnectionGUID: sXLgkzVnS2qqDTiunAY7/Q==
X-CSE-MsgGUID: M2w98H5aQoyQRFkUeuF50A==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098286"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098286"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:25:10 -0800
X-CSE-ConnectionGUID: jgyMbLJhSkubuDarwCdPSQ==
X-CSE-MsgGUID: +ceWcjTcRwm6z08D0Uk8vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694614"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:25:05 -0800
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
Subject: [Patch v6 04/22] perf: Eliminate duplicate arch-specific functions definations
Date: Mon,  9 Feb 2026 15:20:29 +0800
Message-Id: <20260209072047.2180332-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define default common __weak functions for perf_reg_value(),
perf_reg_validate(), perf_reg_abi() and perf_get_regs_user(). This helps
to eliminate the duplicated arch-specific definations.

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
index da013b9a595f..8410b1a7ef3b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7723,6 +7723,28 @@ unsigned long perf_instruction_pointer(struct perf_event *event,
 	return perf_arch_instruction_pointer(regs);
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


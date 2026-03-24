Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA934E766;
	Tue, 24 Mar 2026 00:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313195; cv=none; b=QS/6Mdzivpf9k78gQantULj21auHnPVfqwYFhmf2myVHOwFFWS8tZxfPCsZwBF5WLWdQfhcZ8S5IPXf0m+K1OzefenE3Ef6cLV+t/QAN/qfumLaLXZ6HYkQgXLeoSwSBKXWFucV6EVkRZdZxUZP42rxafSCqk8sDZvLiAjdWCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313195; c=relaxed/simple;
	bh=Ok6beftmWm0pWdV2KRZB73jdWdPdriAvjeD78kI5/0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEgaGf7zyQ6fdZStiL/Q8qyRtc8yoC36ws2E9GSDoBURZ5fHj43I3kKNwTSfOg1hbWPJ0V7TWQ6XbaxA832ZcDxtGH4J6XhoIG9ucQa/JeF+CnAJTFZC904PTAFwiSj2fdXQ9cOgkG1LFAc/NBc+wmocJDLAe4PFiQXrQYXRtRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXrssQ3n; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXrssQ3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313194; x=1805849194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ok6beftmWm0pWdV2KRZB73jdWdPdriAvjeD78kI5/0k=;
  b=CXrssQ3ntJ1ZkeGLAXLtXipKCjl6uNqdLyT3rtbaGYV4Bq2lIS/XXKCa
   bzQoKqT5GhSSbUfAFbo7gfy9fvu1YuBGaV1famjTLDueQnyhpHg97pFu6
   PJpADqdnw/0yIPWaRDS2wlm+wHg6cWcrwaF20LsW2TcZGyR7DcsQ2edNu
   9GBU6IApkjxr9ZW7vwTgb+W7FQsuGYxdvRzZlCJd30amX40E7dg3Rk+LK
   GVRvu4TsLYoDUo39uIV9+SUady0W8YiExEZH7YDEiwJJBPwimwL6zFdYn
   bQ0OqJRUMeLBFFjqAnQUtbreUy9rbCo9IgwyAVA4jBnDsAhhdohDBVqy/
   g==;
X-CSE-ConnectionGUID: tFHbh24/TiazHWQ342a7AQ==
X-CSE-MsgGUID: bbk/CeAHQdGgxVs0F7gNKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397098"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397098"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:46:34 -0700
X-CSE-ConnectionGUID: 3qeI3Ps7SiKYn3GH/aJ4sA==
X-CSE-MsgGUID: /S573n1vTFSvN7hjHdZblg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322746"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:46:29 -0700
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
Subject: [Patch v7 09/24] x86/fpu: Ensure TIF_NEED_FPU_LOAD is set after saving FPU state
Date: Tue, 24 Mar 2026 08:41:03 +0800
Message-Id: <20260324004118.3772171-10-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following Peter and Dave's suggestion, Ensure that the TIF_NEED_FPU_LOAD
flag is always set after saving the FPU state. This guarantees that the
user space FPU state has been saved whenever the TIF_NEED_FPU_LOAD flag
is set.

A subsequent patch will verify if the user space FPU state can be
retrieved from the saved task FPU state in the NMI context by checking
the TIF_NEED_FPU_LOAD flag.

Please check the below link to get more background about the suggestion.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20251204154721.GB2619703@noisy.programming.kicks-ass.net/
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V7: Add wrapper helper update_fpu_state_and_flag() and corresponding
comments.

 arch/x86/include/asm/fpu/sched.h |  5 +++--
 arch/x86/kernel/fpu/core.c       | 27 ++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index 89004f4ca208..dcb2fa5f06d6 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -10,6 +10,8 @@
 #include <asm/trace/fpu.h>
 
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
+extern void update_fpu_state_and_flag(struct fpu *fpu,
+				      struct task_struct *task);
 extern void fpu__drop(struct task_struct *tsk);
 extern int  fpu_clone(struct task_struct *dst, u64 clone_flags, bool minimal,
 		      unsigned long shstk_addr);
@@ -36,8 +38,7 @@ static inline void switch_fpu(struct task_struct *old, int cpu)
 	    !(old->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		struct fpu *old_fpu = x86_task_fpu(old);
 
-		set_tsk_thread_flag(old, TIF_NEED_FPU_LOAD);
-		save_fpregs_to_fpstate(old_fpu);
+		update_fpu_state_and_flag(old_fpu, old);
 		/*
 		 * The save operation preserved register state, so the
 		 * fpu_fpregs_owner_ctx is still @old_fpu. Store the
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 608983806fd7..48d1ab50a961 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -213,6 +213,19 @@ void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
 	}
 }
 
+/*
+ * Save the FPU register state in fpu->fpstate->regs and set
+ * TIF_NEED_FPU_LOAD subsequently.
+ *
+ * Must be called with fpregs_lock() held, ensuring flag
+ * TIF_NEED_FPU_LOAD is set last.
+ */
+void update_fpu_state_and_flag(struct fpu *fpu, struct task_struct *task)
+{
+	save_fpregs_to_fpstate(fpu);
+	set_tsk_thread_flag(task, TIF_NEED_FPU_LOAD);
+}
+
 void fpu_reset_from_exception_fixup(void)
 {
 	restore_fpregs_from_fpstate(&init_fpstate, XFEATURE_MASK_FPSTATE);
@@ -379,17 +392,19 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 
 	fpregs_lock();
 	if (!cur_fps->is_confidential && !test_thread_flag(TIF_NEED_FPU_LOAD))
-		save_fpregs_to_fpstate(fpu);
+		update_fpu_state_and_flag(fpu, current);
 
 	/* Swap fpstate */
 	if (enter_guest) {
-		fpu->__task_fpstate = cur_fps;
+		WRITE_ONCE(fpu->__task_fpstate, cur_fps);
+		barrier();
 		fpu->fpstate = guest_fps;
 		guest_fps->in_use = true;
 	} else {
 		guest_fps->in_use = false;
 		fpu->fpstate = fpu->__task_fpstate;
-		fpu->__task_fpstate = NULL;
+		barrier();
+		WRITE_ONCE(fpu->__task_fpstate, NULL);
 	}
 
 	cur_fps = fpu->fpstate;
@@ -481,10 +496,8 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 	this_cpu_write(kernel_fpu_allowed, false);
 
 	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
-	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		set_thread_flag(TIF_NEED_FPU_LOAD);
-		save_fpregs_to_fpstate(x86_task_fpu(current));
-	}
+	    !test_thread_flag(TIF_NEED_FPU_LOAD))
+		update_fpu_state_and_flag(x86_task_fpu(current), current);
 	__cpu_invalidate_fpregs_state();
 
 	/* Put sane initial values into the control registers. */
-- 
2.34.1


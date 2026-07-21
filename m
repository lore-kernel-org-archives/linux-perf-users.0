Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2E442D75E;
	Tue, 21 Jul 2026 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615574; cv=none; b=ckbUe2E/8mgFMMo5cano5BhO85bi6i7lRUugzr6OQNVHNlpXzCpH3GRm+lsMAu/3M0oD2hRHahJ+8L5NAPJZJOzTZoCpxjthvVmFYwxNYuh2XtBzZ5MKQYbc5LE3qaPBzK479d3ITXNIQIh7Os1j7XkenVVpInkiwJjYPU5r6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615574; c=relaxed/simple;
	bh=nC74cNfjP2+EsKrsD4m63iGzVE8gu+HzDH11FE4a1d8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mMIh11xrte5giiPAnJ/qyKsvTFdGQTvK0Effczc3YTboXqC0wj5HQIXB/OmQ4wq1c/qzPVO8coDouc9URhEd4hIBrhhLwD9bR7m7483mAs+npTmlKeMUTOjYjZ2QHza+YZvo75z/LjzmHjEXNCa5dhZqduHoSr+FsD9BDuGcbFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KsWjxonw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KsWjxonw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784615573; x=1816151573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nC74cNfjP2+EsKrsD4m63iGzVE8gu+HzDH11FE4a1d8=;
  b=KsWjxonw9U+NYnlAxckLcPrxgNBKu+VzTmJT4qr9KuPSEF6av/MU8F8a
   n9O7wS2XNtxDAoV4ClfydGrckIrdJJbcdAAWU4kkTnrLU2ycu7VLVxvso
   0bFwvs4iRE+a6c4dy4hHuFJbE9L8lZVYDaLQUu3tCKhD9QsWGENde4HOQ
   klGybBQ7UD55y7083ftL9v2oeDOR9XvZf1NS90O1IZLpdvLP1oI0renAC
   DCZv0hVNYe8p1emUYpJkbhyVcJ/VYX84KhUKhpCULajl94otJV9aOj+3y
   tzNN7yMIykSxWFZn6GR+nlwomgoBUBFWAMGTksLya022KviviFPCWZ/bk
   g==;
X-CSE-ConnectionGUID: 4O5ykRaBRvey2cg0o1LvBg==
X-CSE-MsgGUID: chR4UQUvRCaXwdsL+sHRGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95565414"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95565414"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:32:53 -0700
X-CSE-ConnectionGUID: 2Mai+FVMTTW80jk+WNvqIg==
X-CSE-MsgGUID: 44DQub42R4K/X9e/p/9nlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="259655979"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jul 2026 23:32:47 -0700
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
Subject: [Patch v10 07/23] x86/fpu: Add update_fpu_state_and_flag() helper
Date: Tue, 21 Jul 2026 14:24:50 +0800
Message-Id: <20260721062506.3745816-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
References: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add update_fpu_state_and_flag() as suggested by Peter and Dave.
The helper saves user FPU state and then sets TIF_NEED_FPU_LOAD,
ensuring the task FPU state is saved whenever the flag is set.

Subsequent patches will use this guarantee in NMI context by checking
TIF_NEED_FPU_LOAD before retrieving user FPU state from the saved
task FPU state.

Also add barrier() in the host/guest FPU state switch path and move
clearing of fpu->__task_fpstate after switching back to host state. So
fpu->__task_fpstate is always observed as host FPU state when non-NULL.

Link: https://lore.kernel.org/all/20251204154721.GB2619703@noisy.programming.kicks-ass.net/
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/fpu/sched.h |  5 +++--
 arch/x86/kernel/fpu/core.c       | 33 ++++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 8 deletions(-)

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
index 584fb9913be4..9e029b2f8937 100644
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
@@ -383,13 +396,13 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 
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
 	}
 
 	cur_fps = fpu->fpstate;
@@ -406,6 +419,16 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 		xfd_update_state(cur_fps);
 	}
 
+	/*
+	 * Clear fpu->__task_fpstate after switching back to host state.
+	 * A non-NULL __task_fpstate means guest state is still resident in
+	 * hardware; reset it only once host state has been restored.
+	 */
+	if (!enter_guest) {
+		barrier();
+		WRITE_ONCE(fpu->__task_fpstate, NULL);
+	}
+
 	fpregs_mark_activate();
 	fpregs_unlock();
 	return 0;
@@ -481,10 +504,8 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
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


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3617B50F;
	Mon,  6 Jul 2026 02:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303308; cv=none; b=kSpIGhCB+jhZq5bqSsMgSjxLQOv/NfUZCHSSGMHvgrEalVP4TkqeswGk8NA9GbKRSU8BMcB4ID42UIQtWrlrOFFp2AvxJKIwOLCdLyJwaftua8NWyPgyZHpK1eCXxKAqjyEHE+QSFjKmbBz7HvAUMDs6WtKLonti+IXmxVhGHKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303308; c=relaxed/simple;
	bh=uUTEuqulN1zyDc08bpfQAjT0U2zS/xD8H73htCMPV5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M2ThtWIRKblnQFLKlCymOyfJBeQvhhRJxMnF+/0iD/bheFt3f2JRHDuJinqdvgycq9fOKkwQfDkza8lC1142UyHfUhKP2ec1WQuk6M9b+fARARUkv3RtkfjHHwqcr5ruFh3p8OTZSxa9rmFuNi2tsgsgBLG3y6JtoY87Yli+++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hq2aXgQC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hq2aXgQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303308; x=1814839308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uUTEuqulN1zyDc08bpfQAjT0U2zS/xD8H73htCMPV5w=;
  b=hq2aXgQCj0ED1/UeK+zaw7tTHG+9Tku997zQrnILtP/L6vKOaG0+f2kK
   Bomy+2gAZLpmp0pZcTLHpKQm0tqlZ2s07OLhm0ksc3jCnOGld04Ujy79D
   8j2PSrUbAK/N3hXKTkVRRFmmw588G+jOqj9xIpH3NA0kWWoomBb4b9507
   D05dwu+EebQkHtfDi9BTIM4vvx26/hb5RkzDudlVDZQyQ4g68mhc+HKPu
   ndbS5zdCet/hz64tMdzW5Z3y+YaqZq4ZD6WtZ+xEn7Jhw/LY2FTwmEaLk
   vsgVEzJba+mhN96l9MpZOt9nGmZ6E4hUW0zIY3tSUCsfQ6Zl91kQXEzhc
   w==;
X-CSE-ConnectionGUID: gMR8WjxJRbmEBD9QbbaETw==
X-CSE-MsgGUID: v01RXnarS2+GnYEYs+byuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911624"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911624"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:01:48 -0700
X-CSE-ConnectionGUID: oP4GD9aJTLiKqnU5b2DcDQ==
X-CSE-MsgGUID: Nw6Hs+DIRE2K0OOcmliKDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191294"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:01:42 -0700
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
Subject: [Patch v9 08/24] x86/fpu: Add update_fpu_state_and_flag() helper
Date: Mon,  6 Jul 2026 09:54:23 +0800
Message-Id: <20260706015439.3040804-9-dapeng1.mi@linux.intel.com>
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

Add update_fpu_state_and_flag() as suggested by Peter and Dave.
The helper saves user FPU state and then sets TIF_NEED_FPU_LOAD,
ensuring the task FPU state is saved whenever the flag is set.

Subsequent patches will use this guarantee in NMI context by checking
TIF_NEED_FPU_LOAD before retrieving user FPU state from the saved
task FPU state.

Also add barrier() in the host/guest FPU state switch path so
fpu->__task_fpstate is always observed as host FPU state when non-NULL.

Link: https://lore.kernel.org/all/20251204154721.GB2619703@noisy.programming.kicks-ass.net/
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/fpu/sched.h |  5 +++--
 arch/x86/kernel/fpu/core.c       | 25 +++++++++++++++++++------
 2 files changed, 22 insertions(+), 8 deletions(-)

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
index 584fb9913be4..fb78e0ecd5fa 100644
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
@@ -383,13 +396,15 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 
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


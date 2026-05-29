Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1D3B5E01;
	Fri, 29 May 2026 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041796; cv=none; b=LV6nMNawJpk+i2ygJ2Am0UjIE1bldWrryaVYQESR7nUEocrCN9lgo1YfytV3NXyT5r2vVLqq4vrCybu4DPUQW14zILsVxIop8Nn/RaX+uwh1LOGC+rpyrzUZb2acWRUzTPD3CKQfZQcY0lC7u4+iPHRNT38uszAl8MRbiweq98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041796; c=relaxed/simple;
	bh=u769g9Miy1Dv9v+Lug92+pVXVhRuV3mC/HCmdG44lYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E4ETiN//Ta7wN8KtFZ/TJQP/ZPs60qC4QxWNv+Ma7zuf8MPl2MqmahGqhw82zkVCIpn2gxb3G8Whd3Nx59pVhd76roRG1RJR4XyAuA9gOlYtYODd+Gl4NLS676wOb1cJ7Oq2680OubANS5P7GvTzq+ygRsS/4RePeDjCB75lTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgQhNjLz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgQhNjLz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041795; x=1811577795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u769g9Miy1Dv9v+Lug92+pVXVhRuV3mC/HCmdG44lYU=;
  b=NgQhNjLzCXvnNvcusVWa6aX9nRNQV9t0cY0RWKKXrqWhX0yLjZbYO3to
   bULAG6Q9gtHvfvGdWlydsk+NyFZVO+Ij9DweBHLsv4Pavw379tO/IleEr
   z49yl26ld0rILvtXAK7vo7Px3Q21CU2G3crJetf2Xh3wLuQMiPZgA0mA/
   i5NoO3+OaJlXDhJyRpdso08Gk50T7BVHvMxNk7qrfrHvl5rau0UNHUyv6
   YrjX3Lv1WRlnzZvVHqLryk1lzCwqicZcuGsVcFjqF10Hi/pNxxbVRXImn
   sKvMaH8c2eiHC0oA8avwG0BJoz2R2PKcrh1jNVQWAENv3tf2ZbKlHy9in
   w==;
X-CSE-ConnectionGUID: gauFmsXpSValinchPKwT7w==
X-CSE-MsgGUID: a/EPGTYFQdmYd9I5T8u4OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106341936"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106341936"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:03:15 -0700
X-CSE-ConnectionGUID: 7HsYs+JGQIaUhAxpcg6NLw==
X-CSE-MsgGUID: l5mW+HHMQoqIUptTBLSrQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802110"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:03:10 -0700
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
Subject: [Patch v8 08/23] x86/fpu: Ensure TIF_NEED_FPU_LOAD is set after saving FPU state
Date: Fri, 29 May 2026 15:56:30 +0800
Message-Id: <20260529075645.580362-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
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
Link: https://lore.kernel.org/all/20251204154721.GB2619703@noisy.programming.kicks-ass.net/
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
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


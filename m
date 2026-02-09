Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33041EB5F8;
	Mon,  9 Feb 2026 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621930; cv=none; b=LweVAELDxR62+/uCqO2F8Bn/K7CGSUySX4TZRL2v+1hqcBxZCLflLUvZmqXCXDtnr8ahNFMmpJ+T5LHfbghPtJ3cyMe/cJAdQYQo6UbskDp7kyNCq336Wp9P5sY/15DiJpHGsCf5aYi81CZcs5MNf2x+3dO0m/P0qYMj9lcRVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621930; c=relaxed/simple;
	bh=FxXIF/UDFwdpUEz9aVfYkf18vVCta1TtH/HcMsU+WAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmEYsWUQBxx1iwCWHn374znlLNl/XoG8oUDkH1g4I1P6Fbr92uJZi4xMe9WLxEO3m+i/QV72DQXs3X8GQ/JMZKdafeHMSg2S33erEHInhigmsZ+qAHRdIHHxcLR6aLxeA0AW8ajdmVFO7VNvFtqJwXFqgk6O13GOIm3K/f3JvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKnZxx9p; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKnZxx9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621930; x=1802157930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FxXIF/UDFwdpUEz9aVfYkf18vVCta1TtH/HcMsU+WAk=;
  b=EKnZxx9pqS0zXNzKIdKa4DBfFDrpXKHwpluMzjXDpfJR7osd9qwW9esN
   qF9IlhQICs0V7fMEaSJqvvQPd2mP8ubLyKpzvVGo34OIIQYl0lVwoXV8V
   uaVPSIW1KCK12ujrO7nUgDMBhekstYjuDpUORiPTJxv+qNOsoNbtIzwtw
   zgkmQeDlV+f6q2dqedLoMk0Tn1yhxBq7CzKdMRk8gn0EoAXZUcRuWpuWc
   PN383dJV/Kp/iblO+e+1Hie0NfU3wWth+90wzY/HtU3/0pUPUTOO4VQ4w
   ucLYySjIJvkEjleQs1By83Cn+ZSBAHB39I1Ca+77PtCBXgt4ml7Pq2p+0
   g==;
X-CSE-ConnectionGUID: vxToSYPKQCiIg1LG9AaB4Q==
X-CSE-MsgGUID: Qf9rq95DThSjGPoO6k5r6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098342"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098342"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:25:30 -0800
X-CSE-ConnectionGUID: SHjNoBXiT1GBuF2eVL0UVw==
X-CSE-MsgGUID: o6bquAC/RqGyjivp2nEP6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694634"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:25:25 -0800
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
Subject: [Patch v6 08/22] x86/fpu: Ensure TIF_NEED_FPU_LOAD is set after saving FPU state
Date: Mon,  9 Feb 2026 15:20:33 +0800
Message-Id: <20260209072047.2180332-9-dapeng1.mi@linux.intel.com>
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

Ensure that the TIF_NEED_FPU_LOAD flag is always set after saving the
FPU state. This guarantees that the user space FPU state has been saved
whenever the TIF_NEED_FPU_LOAD flag is set.

A subsequent patch will verify if the user space FPU state can be
retrieved from the saved task FPU state in the NMI context by checking
the TIF_NEED_FPU_LOAD flag.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

v6: new patch.

 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/kernel/fpu/core.c       | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index 89004f4ca208..2d57a7bf5406 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -36,8 +36,8 @@ static inline void switch_fpu(struct task_struct *old, int cpu)
 	    !(old->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		struct fpu *old_fpu = x86_task_fpu(old);
 
-		set_tsk_thread_flag(old, TIF_NEED_FPU_LOAD);
 		save_fpregs_to_fpstate(old_fpu);
+		set_tsk_thread_flag(old, TIF_NEED_FPU_LOAD);
 		/*
 		 * The save operation preserved register state, so the
 		 * fpu_fpregs_owner_ctx is still @old_fpu. Store the
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index da233f20ae6f..0f91a0d7e799 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -359,18 +359,22 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 	struct fpstate *cur_fps = fpu->fpstate;
 
 	fpregs_lock();
-	if (!cur_fps->is_confidential && !test_thread_flag(TIF_NEED_FPU_LOAD))
+	if (!cur_fps->is_confidential && !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		save_fpregs_to_fpstate(fpu);
+		set_thread_flag(TIF_NEED_FPU_LOAD);
+	}
 
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
@@ -456,8 +460,8 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 
 	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		set_thread_flag(TIF_NEED_FPU_LOAD);
 		save_fpregs_to_fpstate(x86_task_fpu(current));
+		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	__cpu_invalidate_fpregs_state();
 
-- 
2.34.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C82242D76;
	Wed, 18 Mar 2026 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854248; cv=none; b=iSFm7EMpYn7794y5Uwk6zB29O6sCjSCNrDarUFqznp/Ei554zBAiT9V4klyfPEH2dZdzrVofGCxOAhIcBQRS3qnku86Jj59YSUNoSeZJ6VgqvU7JeaXyFgt0OzL5s9yVmMsUJbZ/vLBkovikmlDIkgyBJB9T8iAWWKPlTCirjZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854248; c=relaxed/simple;
	bh=UAeqv1crTMesgqI0eCm4lZuBxl3uq8Ao0hE7O5sw9WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDo4rhoqcO13vt5qErD6m/QUXxIam5eUIDIuDr3W8g8pVmVviQTR5bOMUzL1ruJWOr3K2oGk3xvftJb6fI5zf1qKbig6cswMu3QQO7GPGjPUmrzejSePyR/D7xE77WtOwJxDS8lHeWwA3K2x3kXDR1HcxETKiWUcv4JC5A4nvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHbOPoqo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHbOPoqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3469EC2BCAF;
	Wed, 18 Mar 2026 17:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773854248;
	bh=UAeqv1crTMesgqI0eCm4lZuBxl3uq8Ao0hE7O5sw9WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vHbOPoqohS+J2yBQ2tc3UMWkMCmiLoL19m7AH8VT9z7odibeTRewAB538KJOXk5kC
	 YqN8SX9RGd4buaIuI6O1N4Sgf/1/D7B6RHdtcCferpumSpGWaQTPoX9G4dhyNiHTTS
	 8fsjNY27/ZzMuvtbD9O/0NFb83IjCk6hvUvyGKaoaUgmwYAAMve8gzo9dSeWKqHnLK
	 6JkZKi8+ch4NDRwDlbpPBMuIj8urVbvboxFq75XlE1Gc2VpZVSBrXX2tBwLgvUzMon
	 qHGqy909oQK3KUuoMFqD67XZrgGGxTPgpxIqz07vhNtLTnZtIrM7iggv8r9E4vhsIV
	 9I458M1FGTLCg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 1/4] perf/arm_pmuv3: Fix NULL pointer dereference in armv8pmu_sched_task()
Date: Wed, 18 Mar 2026 10:16:55 -0700
Message-ID: <20260318171706.2840512-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318171706.2840512-1-puranjay@kernel.org>
References: <20260318171706.2840512-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is easily triggered with:

  perf record -b -e cycles -a -- ls

which crashes on the first context switch with:

  Unable to handle kernel NULL pointer dereference at virtual address 00[.]
  PC is at armv8pmu_sched_task+0x14/0x50
  LR is at perf_pmu_sched_task+0xac/0x108
  Call trace:
    armv8pmu_sched_task+0x14/0x50 (P)
    perf_pmu_sched_task+0xac/0x108
    __perf_event_task_sched_out+0x6c/0xe0
    prepare_task_switch+0x120/0x268
    __schedule+0x1e8/0x828
    ...

perf_pmu_sched_task() invokes the PMU sched callback with cpc->task_epc,
which is NULL when no per-task events exist for this PMU. With CPU-wide
branch-stack events, armv8pmu_sched_task() is still registered and
dereferences pmu_ctx->pmu unconditionally, causing the crash.

The bug was introduced by commit fa9d27773873 ("perf: arm_pmu: Kill last
use of per-CPU cpu_armpmu pointer") which changed the function from
using the per-CPU cpu_armpmu pointer (always valid) to dereferencing
pmu_ctx->pmu without adding a NULL check.

Add a NULL check for pmu_ctx to avoid the crash.

Fixes: fa9d27773873 ("perf: arm_pmu: Kill last use of per-CPU cpu_armpmu pointer")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 drivers/perf/arm_pmuv3.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 8014ff766cff..2d097fad9c10 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1074,8 +1074,15 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
 static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
 				struct task_struct *task, bool sched_in)
 {
-	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
-	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
+	struct arm_pmu *armpmu;
+	struct pmu_hw_events *hw_events;
+
+	/* cpc->task_epc is NULL when no per-task events exist for this PMU */
+	if (!pmu_ctx)
+		return;
+
+	armpmu = to_arm_pmu(pmu_ctx->pmu);
+	hw_events = this_cpu_ptr(armpmu->hw_events);
 
 	if (!hw_events->branch_users)
 		return;
-- 
2.52.0


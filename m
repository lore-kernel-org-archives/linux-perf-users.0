Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF413E898;
	Sat, 12 Apr 2025 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744448475; cv=none; b=PfQs/s9J9yvKhSwKAD4IsnQQw0tv+RgG644q1gHFix6gHaF1nnDDRey0Dqidb6id07E8wVcJ2Tqc6KD/RrQ/S1eAlrizIhUBhoePD/lPXtgPEwmWzjVLaFV+2DnHHeJ+R8b8h7uVuVxdvzcBSl95oGTK/UOpnYK3Mgo3D1437oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744448475; c=relaxed/simple;
	bh=ei+dZM8tndbz+6mZ+f0R0iePe87jLJXnq/aEdUvIuGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YwwxEuKfboUpxZeawJFkYle3HUhRtCKXgnJU0EviZVPQrLkmtQSNEhjt8vMqYSr0np3u+2TaoM1h9UIvA1yklHYVeZRj739Mhq8/d9f52Dfq7wuDOmUr1xP7QRApBer6ZQ5IZgCocANlNozVVE/pWW2WVuFN9qcj+boX5hdVtQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZZSFQ44mBz4f3lVs;
	Sat, 12 Apr 2025 17:00:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A510A1A058E;
	Sat, 12 Apr 2025 17:01:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl+3K_pnr0MAJQ--.64008S4;
	Sat, 12 Apr 2025 17:01:07 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: peterz@infradead.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [PATCH] perf/x86/intel: Fix lbr event can placed into non lbr group
Date: Sat, 12 Apr 2025 09:14:23 +0000
Message-Id: <20250412091423.1839809-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl+3K_pnr0MAJQ--.64008S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4rCw4rZF4DGFykWr1DGFg_yoW8ZrWxp3
	yfJFsxKF4Ygwn5u34fJFn2qF4Yvryvq3Z5G347K345X3WkZr9FgFWxKa45ur95CryIkFy5
	Xw1jvr4UCF9rZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRiSdgUUUUU=
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

The following perf command can trigger a warning on
intel_pmu_lbr_counters_reorder.

 # perf record -e "{cpu-clock,cycles/call-graph="lbr"/}" -- sleep 1

The reason is that a lbr event are placed in non lbr group. And the
previous implememtation cannot force the leader to be a lbr event in this
case. And is_branch_counters_group will check if the group_leader supports
BRANCH_COUNTERS. So if a software event becomes a group_leader, which
hw.flags is -1, this check will alway pass.

To fix this problem, using has_branch_stack to judge if leader is lbr
event.

Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 arch/x86/events/intel/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 09d2d66c9f21..c6b394019e54 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4114,6 +4114,13 @@ static int intel_pmu_hw_config(struct perf_event *event)
 			event->hw.flags |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
 	}
 
+	/*
+	 * Force the leader to be a LBR event. So LBRs can be reset
+	 * with the leader event. See intel_pmu_lbr_del() for details.
+	 */
+	if (has_branch_stack(event) && !has_branch_stack(event->group_leader))
+		return -EINVAL;
+
 	if (branch_sample_counters(event)) {
 		struct perf_event *leader, *sibling;
 		int num = 0;
@@ -4157,13 +4164,6 @@ static int intel_pmu_hw_config(struct perf_event *event)
 			  ~(PERF_SAMPLE_BRANCH_PLM_ALL |
 			    PERF_SAMPLE_BRANCH_COUNTERS)))
 			event->hw.flags  &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
-
-		/*
-		 * Force the leader to be a LBR event. So LBRs can be reset
-		 * with the leader event. See intel_pmu_lbr_del() for details.
-		 */
-		if (!intel_pmu_needs_branch_stack(leader))
-			return -EINVAL;
 	}
 
 	if (intel_pmu_needs_branch_stack(event)) {
-- 
2.34.1


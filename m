Received: from out198-31.us.a.mail.aliyun.com (out198-31.us.a.mail.aliyun.com [47.90.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0179D2E1741;
	Thu, 14 Aug 2025 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755169611; cv=none; b=oquC1f6PQy0DBUF9O89rJxSKca37H6nhZ9fCjPMJIasPU6w+8+aClsuhGNYmZGVmJJzFoe/qKV9hhqw8iI4MNXvgYWNX6V0mggqVk/VT/wzdk5HVLEY/J7tgk+M/4jo/MyctFAZ+odrEX/vLmJgt/jIT3xc9HFx8k4iIKfV6F84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755169611; c=relaxed/simple;
	bh=VtJ5d0dnJ0nT19N+Q2EDvOONesDogBF26DJ7buWGfNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPhBXvi/MXVUgY+SNHfCq9qQ6+cl8k77//P7hf8ceMS+UTfn8neNoJMKnYQq3iV7B1+tDHqphVmqzfF6rT1Bb0bzPN8STJ0+dM+66xW55endfzgMHCTUtIZbHwARkwYnMlC2Z/hcn4HBXXrBDiyGDicnO+cCmwRM1TKna60mC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=optimatist.com; spf=pass smtp.mailfrom=optimatist.com; arc=none smtp.client-ip=47.90.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=optimatist.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=optimatist.com
Received: from localhost.localdomain(mailfrom:chengdongli@optimatist.com fp:SMTPD_---.eFXRFyu_1755169589 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 14 Aug 2025 19:06:30 +0800
From: Chengdong Li <chengdongli@optimatist.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengdong Li <chengdongli@optimatist.com>
Subject: [PATCH] perf/core: Improve arguments checking of inherited per-task counters when sampling.
Date: Thu, 14 Aug 2025 19:06:25 +0800
Message-ID: <20250814110625.84622-1-chengdongli@optimatist.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not allowed to mmap() of inherited per-task counters with CPU ==
-1, this would create a performance issue. But it is not friendly to
developers as current implementation postponed the arguments checking to
perf_mmap(), developer can get an -EINVAL from mmap() but without
any previous error returned from perf_event_open().

This patch improves it by moving the arguments checking from perf_mmap()
to perf_event_open().

Signed-off-by: Chengdong Li <chengdongli@optimatist.com>
---
 kernel/events/core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8060c2857bb2..f102adb395ec 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6941,14 +6941,6 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	int ret, flags = 0;
 	mapped_f mapped;
 
-	/*
-	 * Don't allow mmap() of inherited per-task counters. This would
-	 * create a performance issue due to all children writing to the
-	 * same rb.
-	 */
-	if (event->cpu == -1 && event->attr.inherit)
-		return -EINVAL;
-
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
@@ -13392,6 +13384,18 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EACCES;
 	}
 
+	/*
+	 * Don't allow perf_event_open() of inherited per-task counters
+	 * with cpu == 1 when sampling. Otherwise, this would create a
+	 * performance issue due to all children writing to the same mmap()
+	 * created ring buffer.
+	 *
+	 * We recommend to call perf_event_open() for all cpus when sampling on
+	 * inherited per-task counters.
+	 */
+	if (attr.sample_freq && attr.inherit && cpu == -1)
+		return -EINVAL;
+
 	if (attr.freq) {
 		if (attr.sample_freq > sysctl_perf_event_sample_rate)
 			return -EINVAL;
-- 
2.43.0


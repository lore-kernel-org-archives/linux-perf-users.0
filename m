Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC4218A6AD;
	Fri, 12 Dec 2025 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765529399; cv=none; b=NGbkv3UjgfV1zczR0DSy96WqnjBDDrLTNzfkKQgN1vP42+hB+TLObfyy8Sfx5Dja6ZmST2lT0NeDrBMyLJUWYG+xQpx0dVrltJRf/5O43u1ze8nhscqCw4MObBedhxzIU6tFSyaFXm7QFu0dXISEkcM4Z6I+lf1MFqVGXvpheDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765529399; c=relaxed/simple;
	bh=AG4XivHlnnZP8ZufBJk+mjBSMaiIPllSw0LPSjITrLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7djOIQMF/BBqvuiSmx4SZkiqJfYRzBZYjwL2ByL65z41lEZ1DxNxhwDS2B7Lr48/6Y3WU8CpxC14SI9x8/rbBYfzZqipX29QDQzqQdPj1uAgQIzYxzXlN7/XaEkikGq2l/cdE5yM9JxMtN0CsV2uCz2+VKBOTMOBQI4mNMkvQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lYziCLxX; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lYziCLxX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765529394; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cjrUU9eVfpoMcYCbnqKLtx4FvjcyWCXSkBXGmms+bIY=;
	b=lYziCLxXjgnWiNq5+PslhI7av4pGoCE3VE9f5CNZRsBG5WLkMhAZlKWGGR6y53szjJ/2qd5DpM0y/T+CcJNY1HtRbgOYzkchJsLro3Q07RpCqwRkPnaDc7bPLaPkejgNt6QK0VEyPdBH8pK/CgYS20MBnA2OqiX+BAMODN1vuFU=
Received: from localhost(mailfrom:evan.li@linux.alibaba.com fp:SMTPD_---0Wudi-Ch_1765529393 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Dec 2025 16:49:53 +0800
From: evan.li@linux.alibaba.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Evan Li <evan.li@linux.alibaba.com>,
	kitta <kitta@linux.alibaba.com>
Subject: [PATCH] perf/x86: Prevent NULL event deref in handle_pmi_common()
Date: Fri, 12 Dec 2025 16:49:43 +0800
Message-ID: <20251212084943.2124787-1-evan.li@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Evan Li <evan.li@linux.alibaba.com>

handle_pmi_common() may observe an active bit set in cpuc->active_mask
while the corresponding cpuc->events[] entry has already been cleared,
which leads to a NULL pointer dereference.

This can happen when interrupt throttling stops all events in a group
while PEBS processing is still in progress. perf_event_overflow() can
trigger perf_event_throttle_group(), which stops the group and clears
the cpuc->events[] entry, but the active bit may still be set when
handle_pmi_common() iterates over the events.

The following change:

7e772a93 ("perf/x86: Fix NULL event access and potential PEBS record loss")

moved cpuc->events[] clearing from x86_pmu_stop() to x86_pmu_del() and
relied on cpuc->active_mask/pebs_enabled checks. However,
handle_pmi_common() can still encounter a NULL cpuc->events[] entry
despite the active bit being set.

Add an explicit NULL check on the event pointer before using it to
avoid dereferencing a cleared cpuc->events[] slot.

Fixes: 7e772a93 ("perf/x86: Fix NULL event access and potential PEBS record loss")
Reported-by: kitta <kitta@linux.alibaba.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220855
Co-developed-by: kitta <kitta@linux.alibaba.com>
Signed-off-by: Evan Li <evan.li@linux.alibaba.com>
---
 arch/x86/events/intel/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 853fe073b..a7454ed6a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3378,6 +3378,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		if (!test_bit(bit, cpuc->active_mask))
 			continue;
+		/* Check if event is NULL to prevent null pointer dereference */
+		if (!event)
+			continue;
 
 		/*
 		 * There may be unprocessed PEBS records in the PEBS buffer,
-- 
2.43.7


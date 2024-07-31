Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F71A7F7B;
	Wed, 31 Jul 2024 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419959; cv=none; b=XJPR6gg64/N9RBezleeF+fxIHzhqFyIBtYjS7+4jbvjCRW2WvgEevMq9paeszeN0qvslSbqcQpVuh3VxUnJ5ngs/2usSFRfhn0Xz5PI/rcKFQ+hfDu7cQWFBbU2IEVJjUgfoo1H/4/CRzeF4cBWVeq4MocRPelk+WfhV2OziX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419959; c=relaxed/simple;
	bh=0zDPImMfP8uELHlerqU/ZcC4S1MlQRyeKlXnKm1s8bY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mKHNhdZ6xbNLlIFJ+ZOwvlJZgmtzZYIqclIA0EHEK5TdXQ2N92WbX0/I6DSHxeC6ckIfgYWp8DagNmAsXSQAolNZgc1hSp16GjAU4gPztBKRLPUluyFJ+n6i5LuWCU9SlsQ+FtjcfviicqL1n13Y/B/ieqov/iPEkuOESCawVJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WYnYP0xv9z1HFkd;
	Wed, 31 Jul 2024 17:56:25 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 0942014037C;
	Wed, 31 Jul 2024 17:59:14 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 31 Jul
 2024 17:59:13 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<mhiramat@kernel.org>, <oleg@redhat.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
Subject: [PATCH] uprobes: Remove redundant spinlock in uprobe_deny_signal
Date: Wed, 31 Jul 2024 09:50:17 +0000
Message-ID: <20240731095017.1560516-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Since clearing a bit in thread_info is an atomic operation, the spinlock
is redundant and can be removed, reducing lock contention is good for
performance.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 kernel/events/uprobes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 73cc47708679..76a51a1f51e2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1979,9 +1979,7 @@ bool uprobe_deny_signal(void)
 	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
 
 	if (task_sigpending(t)) {
-		spin_lock_irq(&t->sighand->siglock);
 		clear_tsk_thread_flag(t, TIF_SIGPENDING);
-		spin_unlock_irq(&t->sighand->siglock);
 
 		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
 			utask->state = UTASK_SSTEP_TRAPPED;
-- 
2.34.1


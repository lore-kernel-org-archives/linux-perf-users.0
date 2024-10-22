Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6A814EC6E;
	Tue, 22 Oct 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582950; cv=none; b=jaxxGHxVWb5qJln76Qhiq/nrmuVblHxRsVW0J8YUmXV1L0Jbr/hE0wsUOTqZclOmko0A4vvX4nk3OPlsJvLV2F0MQHLlFpNxU3VL/yay3gwtngufU5xkU51IaCvjm5DRtfBXGwQ2fGS/2tNrUofkp1llOWt3/3aV6HAe6wk9ji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582950; c=relaxed/simple;
	bh=ZTESNk0TwpnCiaPAZD8hbpu4RXeK4V6ATOv6HmarPTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjU57IkHqvpl1mbbEtKDZMqriELDMXCj/nrHH4hPA8BVjUb8Do+qToB4KTUWyzPML7EX5Svzp152xDu8fx7pOKcr6IDK7dVXhgKzAN8fLVbzkYOMK+PHaYxjD65IscvDJUlFO4Cxf/yowBL9FCHPCWSWofaLlCq3A2jcNeeBKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XXkYR5FMlz1HLL0;
	Tue, 22 Oct 2024 15:38:03 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A84814010D;
	Tue, 22 Oct 2024 15:42:23 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 22 Oct
 2024 15:42:22 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <andrii.nakryiko@gmail.com>, <mhiramat@kernel.org>, <oleg@redhat.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH v4 1/2] uprobes: Remove redundant spinlock in uprobe_deny_signal()
Date: Tue, 22 Oct 2024 07:31:40 +0000
Message-ID: <20241022073141.3291245-2-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022073141.3291245-1-liaochang1@huawei.com>
References: <20241022073141.3291245-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Since clearing a bit in thread_info is an atomic operation, the spinlock
is redundant and can be removed, reducing lock contention is good for
performance.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 kernel/events/uprobes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2a0059464383..196366c013f2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1986,9 +1986,7 @@ bool uprobe_deny_signal(void)
 	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
 
 	if (task_sigpending(t)) {
-		spin_lock_irq(&t->sighand->siglock);
 		clear_tsk_thread_flag(t, TIF_SIGPENDING);
-		spin_unlock_irq(&t->sighand->siglock);
 
 		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
 			utask->state = UTASK_SSTEP_TRAPPED;
-- 
2.34.1


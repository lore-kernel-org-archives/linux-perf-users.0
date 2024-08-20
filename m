Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B92191477;
	Tue, 20 Aug 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161962; cv=none; b=r+CWPyh6/dUvIZV5YBkuUryh02+AqYMnvW1YNc7GhgGjR/bzfpW5IH1DFR3zFWAIUQieI32jKMGQu71nubnlhkFyXFrUqCQRGCREzMlCTRW0at9EwVodf9NkKyh195M86dot/13And+T28Z70kq+4i4EUv/z8vtTyC92Hb441O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161962; c=relaxed/simple;
	bh=aoGgvXxneXVWbzG5PcZX/RqdYS4kVM9UKC1ewzOZhP0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fPX9ZwnJEP2JtZhYBwWi5fkC6ud0tGavixJDZntRylH0UFYKdVkdo3C/SeWwVH62hXCVtnBvNrBs8Jb1rn6cYgbpTHsU2NHdPOT/K11m6KEjOk4qc5Xb/IfYtMFIC22oNECrrm1mfmVvYMIQz8S5pLvdaFkfVLG9HMo16EWeqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wp9pV1vH6z1xvW2;
	Tue, 20 Aug 2024 21:50:42 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 65E611A0188;
	Tue, 20 Aug 2024 21:52:36 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Aug 2024 21:52:35 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] uprobe: fix comment of uprobe_apply()
Date: Tue, 20 Aug 2024 21:52:31 +0800
Message-ID: <20240820135232.1913-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Depending on the argument 'add', uprobe_apply() may be registering or
unregistering a probe. The current comment misses the description of the
registration.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/events/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 73cc47708679f0c..c9de255e56e777f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1201,8 +1201,8 @@ int uprobe_register_refctr(struct inode *inode, loff_t offset,
 EXPORT_SYMBOL_GPL(uprobe_register_refctr);
 
 /*
- * uprobe_apply - unregister an already registered probe.
- * @inode: the file in which the probe has to be removed.
+ * uprobe_apply - register a probe or unregister an already registered probe.
+ * @inode: the file in which the probe has to be placed or removed.
  * @offset: offset from the start of the file.
  * @uc: consumer which wants to add more or remove some breakpoints
  * @add: add or remove the breakpoints
-- 
2.34.1


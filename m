Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081882;
	b=ZHCeE28mYa9S8QKMuVg6DWBgJYBxij5BwxSpEjCe9te03kxhD3jUXS/wkUewCYVAGjUu
	 uOxAoQDko5Osorg7FMLkAzEqSlM3Wv7xN1RSdRC8784tbzQyQWzITyXNn55GI7R71me7K
	 z9qZnx2Ova/28gdgGn2lilUfFlMWPjalNUmwyvDWwENAHQu0854PpsXyuxiQlJDXe9xpy
	 ZG+PML3+Yv0mP4jk+nenAveM8XXM9gTmj78XqrW0Kz8wT96QgFBhoi3Sr3Z+RiIW/T7zt
	 oKDdLEuJeEpnD1UH96x3ZJF7/M2EFWksmUkRJPyUcuy+BxdnAEuWeDT/FRnTBSUk71w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081882;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=vKT/Z3z5pHTz1FUzBFVmBK+qZqGsEwiPHCP6bly7ASY=;
	b=m1ysz9vDEEQzJhVMAQNpmhN0ZNsOfbVeizHL5WZwdZQl62BLiV5wUd+qtGH3GNkImPZj
	 vVnPfC/wlwXGrGmNG9akyYywJE/ZpydNpMVIt7R/WzRU+qyD9mhc/nZwzqNRkpJl6tn9Y
	 SZXvo6U9rMVYeFOvfM0TueaHa4yAwYHFxAlw6Vg31z1QxdmPhIGS0nutkUK1/GugZmUgZ
	 mKd5d+JU0x2fyhj22qVmp3wq08XTqdOpbxoMT6PuyII3n5r08A8kta9bwZZrmjXMT9IR4
	 oolEys2tH2iR833AqV8qtIBy6DaClMCS5/WYGD/EOVyCvjf0L2ppAVUvK+M1PdriklQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=none smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF759606A324;
	Thu, 19 Nov 2026 09:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF759606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jVYcB540pz1rrtd;
	Thu, 19 Nov 2026 17:50:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AA5A740D80;
	Thu, 19 Nov 2026 17:51:12 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgDn7QCHxv5qwsKLEw--.20837S2;
	Thu, 19 Nov 2026 17:51:12 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v5 0/2] perf/core: Fix sigtrap task_work races
Date: Thu, 19 Nov 2026 09:50:59 +0000
Message-Id: <cover.1795053619.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDn7QCHxv5qwsKLEw--.20837S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary5Kw1xZr45ur47XrykuFg_yoW8trWxpF
	s5Zr1Skw1jgr1Iyw43Jw18ua4Fgw4rXF43Grs7tw1fAF4YvFn8AFWxWr4YvFy7Ar97JFyr
	tws2qF4kurWj9FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8c_-DUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Two fixes for sigtrap task_work handling since the switch to always
enqueue SIGTRAP via task_work.

The warning splats and PoCs for both patches are too long to inline
in the commit messages, so they are provided as separate replies at
the following links:

Patch 1: https://lore.kernel.org/all/29aa123c-36a2-460f-b76b-a8dfe1eb542f@huaweicloud.com/
Patch 2: https://lore.kernel.org/all/d1b24bbf-9111-4766-87c8-ff97adcac727@huaweicloud.com/

Patch 1 fixes a re-entrancy race in __perf_event_overflow(): pending_work
was set only after task_work_add(), so an NMI could re-enter and enqueue
the same pending_task twice, creating a cycle in the task work list and
unbalancing the event refcount. Claim pending_work before enqueuing, and
clear it if the enqueue fails.

Patch 2 fixes a WARN_ON_ONCE() in perf_sigtrap() triggered by the context
fast-swap path swapping ctx->task while a sigtrap event has pending task
work. SIGTRAP is targeted at ctx->task, so exclude sigtrap events from
fast-swap alongside inherit+sample-read events.

Changelog
=========
v4 -> v5:
  - v4: https://lore.kernel.org/all/cover.1794914794.git.wutengda@huaweicloud.com/
  - Roll back patch 2 to v3 to avoid the fast swap isolation omission in
    the nr_no_switch_fast 1->0 scenario. (Shashiko)
v3 -> v4:
  - v3: https://lore.kernel.org/all/cover.1793870900.git.wutengda@huaweicloud.com/
  - Patch 1: Use acquire/release pairs for pending_work updates (Sebastian)
  - Patch 2: Remove redundant nr_no_switch_fast updates (Sebastian)
v2 -> v3:
  - v2: https://lore.kernel.org/all/20261102021355.650671-1-wutengda@huaweicloud.com/
  - Added Patch 2 to fix WARN_ON_ONCE() in perf_sigtrap()
v1 -> v2:
  - v1: https://lore.kernel.org/all/20261031114520.642476-1-wutengda@huaweicloud.com/
  - Drop the redundant event->pending_work assignment. (Sashiko)

Tengda Wu (2):
  perf/core: Prevent duplicate sigtrap task work enqueue
  perf/core: Disable context fast-swap for sigtrap events

 include/linux/perf_event.h |  6 ++---
 kernel/events/core.c       | 48 ++++++++++++++++++++++++++------------
 2 files changed, 35 insertions(+), 19 deletions(-)

-- 
2.34.1


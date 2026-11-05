Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871080;
	b=Rzi8cGCuSMOVfAR7UaSLyKGjpqIGTNFfImz7UFZozrglZYMeCw4pAsBUo9v4kOovDAGQ
	 9okp7dyilwbq3uk8TZau6aZ8zeAUQMim8mRGAvifFYv0pXPKXnErCoqzEj1O6KfMJBUmN
	 HtO3qQo496+m/ZuIu+Akz8nNsLDtjD7SKgst+QMPKKPQ6YsxSOhxkzT2pMJoGNJgYgf6B
	 dUB36fP9lQwdPEspAjT82Z/rbke+gkyCC5bl3d+jsVKrzOHpNqOhC0F5M7lNnmvePONtp
	 5rTGS6ATwNcDQXn0UEIKb0wYV/AWE/w0SrFT3ZNTg8Adx/jJCiO0yn8u0pGZMyh/xQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871080;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=vdZD0y5QaPmxoC/GOogdB9j6cmFXfwnHWNZ5At60b8I=;
	b=uQ8vkKG+eDPCd3rfVbOuDB2i8OgYYXDmWioFAkygIzsDMa8PmNVlcAewIXHnR+ju78bN
	 uThxgr3iVPg713tbSHiW8p2AzH/tA5GFfQ0gbBrYJ8jsYfwLAKcfCd/FCszdq63ZGS7L8
	 bjdCedPJ4Sbjj7qI5OGdSwDSJcZvEucrFKJ3yIGoEoPyIwO8TCgkEl3q9gJo3X48qaXFO
	 DTLfsIdlAu62ba9B76EJyO7iKqgTWAF7BcvkuC6OFTcFIHqwCJd7P5PFuOHF64NqQhOW3
	 an8Vl+F991xN7O6BKJ8ccQs6dKwnGzFxHKmRLuyIrDXC7qwfXWSIhcZuxFs+0f5a6WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF90606A32F;
	Thu,  5 Nov 2026 09:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEF90606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jKxr02BSYz1c1kn;
	Thu,  5 Nov 2026 17:30:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 77D5A4056D;
	Thu,  5 Nov 2026 17:31:09 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBnnu3OTOxqcwqpDA--.46006S2;
	Thu, 05 Nov 2026 17:31:09 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v3 0/2] perf/core: Fix sigtrap task_work races
Date: Thu,  5 Nov 2026 09:30:42 +0000
Message-Id: <cover.1793870900.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBnnu3OTOxqcwqpDA--.46006S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary5Kw1xZr15tr1rGr4xCrg_yoW8XFWDpF
	sxurySkw48J34Iv3y3Aw48Z3yrWw4Fqa13Wrs3Kw18AF45ZF98XFW7Gr4Y9FW7Cr97tayS
	yw4vvFWkuryj9FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU2oGQUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Two fixes for sigtrap task_work handling since the switch to always
enqueue SIGTRAP via task_work.

The warning splats and PoCs for both patches are too long to inline in
the commit messages. They are sent as separate replies to this cover
letter, one per patch.

Patch 1 fixes a re-entrancy race in __perf_event_overflow(): pending_work
was set only after task_work_add(), so an NMI could re-enter and enqueue
the same pending_task twice, creating a cycle in the task work list and
unbalancing the event refcount. Claim pending_work with cmpxchg() before
enqueuing, and clear it if the enqueue fails.

Patch 2 fixes a WARN_ON_ONCE() in perf_sigtrap() triggered by the context
fast-swap path swapping ctx->task while a sigtrap event has pending task
work. SIGTRAP is targeted at ctx->task, so exclude sigtrap events from
fast-swap alongside inherit+sample-read events.

Changelog
=========
v2 -> v3:
  - v2: https://lore.kernel.org/all/20261102021355.650671-1-wutengda@huaweicloud.com/
  - Added Patch 2 to fix WARN_ON_ONCE() in perf_sigtrap()
v1 -> v2:
  - v1: https://lore.kernel.org/all/20261031114520.642476-1-wutengda@huaweicloud.com/
  - Drop the redundant event->pending_work assignment. (Sashiko)

Tengda Wu (2):
  perf/core: Prevent duplicate sigtrap task work enqueue
  perf/core: Disable context fast-swap for sigtrap events

 include/linux/perf_event.h |  6 ++----
 kernel/events/core.c       | 30 ++++++++++++++++++------------
 2 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.34.1


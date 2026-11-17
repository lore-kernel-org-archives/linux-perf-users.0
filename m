Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914919;
	b=Vc9xuJtyM8bEDmQoRAEdunSYmL/OlWDBB2I3Hh+c+R3Yt7mHRTKxje8iAoabQa2vXkUr
	 vlNvlyyZ98OiPKDw5APpFQntVEIN7eNrr+QRFuQP0caGdQovDt3xee7F3ab7D8zMuB8j1
	 G1Sn120W/s5e5OCTMbfTG44TPW5zcOFGE7OF+2N2MJK+xHiGyHH/jXOT6Iu66nfdcnjqo
	 s5S/IFBRsjVL2nfkINzVAZKLoeIFzsB3W//t1G+XZsOvczMJ52hx6sedhn8ofrGYmWdtE
	 Kr2b/UabPDIcSR+H6dwnTUfu34S3dWdIHaskS0U2SI8FlksUNGnXdlknCYQ0QU+CmKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914919;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=q2CyYZ2Bf8MvQVPeej7bz6SeLJherhUzzT/5WsMTPqs=;
	b=pt1OFpH8j7de3+VKdZTGhfbwUgiVq67gEd8QqGWuJ9MR93TByDueD02Cw+ZYnRTITCa5
	 ECx/OxMxUPW9RTqQbvjeEAZMc9u4kpt5w3Bn8ekPwJJGpV1Zjyyd4Tc3mIAy0E0fHkC+Q
	 UV9NzlKZ+GxXhftXxPL+tNCLTi7f9tKo1xXsyhGaqFQ/ELF188iLpHkbpcRF+HrdHZRu2
	 xckMhqjGeMG6GyEdTfe5eGlBU9eBmKEz5hVu+BGshqmBfPcx031TA7XvqvSKCQuKMf/2m
	 kqaD0SP9AY7Yxfmz2e69YEtgM//KrvPZbtOXS8KbfW3PsSboB5txlql/t1KGiGEH1ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C7606A33A;
	Tue, 17 Nov 2026 11:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F7C7606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jTMsQ1Fjgz20BK;
	Tue, 17 Nov 2026 19:27:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AE7E940574;
	Tue, 17 Nov 2026 19:28:27 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBHS_5QOvxq4EOQEg--.20741S4;
	Tue, 17 Nov 2026 19:28:27 +0800 (CST)
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
Subject: [PATCH v4 2/2] perf/core: Disable context fast-swap for sigtrap events
Date: Tue, 17 Nov 2026 11:28:08 +0000
Message-Id: <cff9b939758dad9f16bb4eb0483c63b7787e62bb.1794914794.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794914794.git.wutengda@huaweicloud.com>
References: <cover.1794914794.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBHS_5QOvxq4EOQEg--.20741S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1UCFyUAryxGrW5JrykAFb_yoWrtr4xpr
	Z7Cwn5KrW8Xr42qw15ta1Duw17Ww4rtFsrJws0gayava1Yg3s3XFWUG3WYqF45Jrn2va43
	t3yqvrZrC34UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUa2NtUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

perf_sigtrap() contains:

	WARN_ON_ONCE(event->ctx->task != current)

The warning assumes that an event's ctx->task always matches the task
that ends up running the pending task_work. That assumption can be
broken by the context fast-swap path.

The failure sequence is:

  1. A -> B switch, perf_event_context_sched_out() takes the fast path
     and does WRITE_ONCE(ctx->task, next) / WRITE_ONCE(next_ctx->task, task).
     An NMI then hits while the context is swapped, and
     __perf_event_overflow() queues pending task_work on the *current*
     task (A), even though the event now belongs to B's swapped-in
     context view.

  2. B -> A switch. Because A now has pending task_work,
     nr_no_switch_fast is non-zero, so the slow path is taken and
     ctx->task is *not* swapped back.

  3. A returns to user mode, task_work runs perf_pending_task() ->
     perf_sigtrap(), and event->ctx->task no longer equals current,
     tripping the WARN_ON_ONCE().

The context fast-swap path was already excluded for events that need
stable task association (inherit + sample read). sigtrap events have
the same requirement: the SIGTRAP is targeted at ctx->task and must not
be delivered after ctx->task has been swapped to another task.

Fix this by also excluding events with attr->sigtrap from the fast-swap
path, i.e. bump nr_no_switch_fast for sigtrap events in
list_add_event()/list_del_event(), and update the comment describing
the invariant accordingly.

Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 include/linux/perf_event.h |  8 +++-----
 kernel/events/core.c       | 11 +++++++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e1e11500df09..15d35b9bfd02 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1066,11 +1066,9 @@ struct perf_event_context {
 	 * The count of events for which using the switch-out fast path
 	 * should be avoided.
 	 *
-	 * Sum (event->pending_work + events with
-	 *    (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ)))
-	 *
-	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
-	 * that until the signal is delivered.
+	 * Sum (events with
+	 *    (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ)) +
+	 *    events with attr->sigtrap)
 	 */
 	local_t				nr_no_switch_fast;
 };
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 857230b023ae..cb0ec8d51e50 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2009,7 +2009,7 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 		ctx->nr_user++;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat++;
-	if (has_inherit_and_sample_read(&event->attr))
+	if (has_inherit_and_sample_read(&event->attr) || event->attr.sigtrap)
 		local_inc(&ctx->nr_no_switch_fast);
 
 	if (event->state > PERF_EVENT_STATE_OFF)
@@ -2235,7 +2235,7 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 		ctx->nr_user--;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat--;
-	if (has_inherit_and_sample_read(&event->attr))
+	if (has_inherit_and_sample_read(&event->attr) || event->attr.sigtrap)
 		local_dec(&ctx->nr_no_switch_fast);
 
 	list_del_rcu(&event->event_entry);
@@ -3841,6 +3841,11 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 				 * SAMPLE_READ events they should be switched
 				 * out using the slow path so that they are
 				 * treated as if they were distinct contexts.
+				 *
+				 * A context holding a sigtrap event must also
+				 * take the slow path, even when nothing is
+				 * pending, since the sigtrap delivery relies on
+				 * the ctx->task relation as well.
 				 */
 				raw_spin_unlock(&next_ctx->lock);
 				rcu_read_unlock();
@@ -7777,7 +7782,6 @@ static void perf_pending_task(struct callback_head *head)
 
 	if (smp_load_acquire(&event->pending_work)) {
 		perf_sigtrap(event);
-		local_dec(&event->ctx->nr_no_switch_fast);
 		/*
 		 * Ensure the pending work is fully handled before allowing
 		 * another overflow to queue it. See __perf_event_overflow().
@@ -10960,7 +10964,6 @@ static int __perf_event_overflow(struct perf_event *event,
 		 */
 		if (cmpxchg_acquire(&event->pending_work, 0, pending_id) == 0) {
 			if (!task_work_add(current, &event->pending_task, notify_mode)) {
-				local_inc(&event->ctx->nr_no_switch_fast);
 				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
 
 				event->pending_addr = 0;
-- 
2.34.1


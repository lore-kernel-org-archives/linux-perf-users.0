Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081882;
	b=slZwsqSd9DMk1yiQDrV/KcrGTSlIq0UIKkV0kjct+c2MdF6NPosyi/bXKhiCE3glu4nF
	 ZmbgNVebA00w08soVZG66M5GLAJU3kWxk5YQ8sSKWKmmCkrxeaxzSOQx75R5tJblISqds
	 B5tFng68/EZ3G4j+a2KeoXWC3nLjEjHPGTo7A2VyAcotfRrg7csGXoQq1uVd4W0BOMNNb
	 6QWNRAFtAU2mrEQLgwdFn9eJMyJILjry0bye4JqEUPUDcynmbqNbFP9sxzIrsGXd6wYTc
	 kFqJXN8nvt1TyrzkRiL8oSDJfASWC+I/Iz/V04bocuymTEXiu5+fMPUNCd2KWorxYUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081882;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=qtZWF0xWIbmvLKtAiQ9PUnqCDrlFT4QZq9euhGsGkNU=;
	b=5H00pfBorDGmYGZAOhKW0bZiZTtQEQr0fln3jyROWFEQ7UTwgZzPLUkTNy4BVVx7T8PW
	 fQskJ67sqNfMuqySWUHJm3ubcPWa7oXpB7tw0gsZTHAG0XtcdEYWWVFMfR/IKLLsCl0K7
	 yf9JFVAOFUPaS0aEpZCgkWhAJ60cK8JlPZ5lyjHowerQPQxGw0bRdXWpvH8xkl2pfI+OQ
	 ouiqXRne7j0/+DzAdA6PptiF7UQNr4wo3+3RQ3WQ4m/8i4S132steZtwEAuN41KBqHkEq
	 KUzxB5awHfTesHNRAJ49WZBK9yrUGY80rPDZVnUSMGWGshcinFov98aGRETuEFmRPJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=none smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B90606A325;
	Thu, 19 Nov 2026 09:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6B90606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jVYcC69vWz20NY;
	Thu, 19 Nov 2026 17:50:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id DA4A040D80;
	Thu, 19 Nov 2026 17:51:12 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgDn7QCHxv5qwsKLEw--.20837S4;
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
Subject: [PATCH v5 2/2] perf/core: Disable context fast-swap for sigtrap events
Date: Thu, 19 Nov 2026 09:51:01 +0000
Message-Id: <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1795053619.git.wutengda@huaweicloud.com>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgDn7QCHxv5qwsKLEw--.20837S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1UCFyUAryxGrW5JrykAFb_yoWrGF15pF
	WkCrn3Kry8Xr12v345K3Wq9343Ww4rtFsrWwsag3yavw4Yq3saqFWUJ3WYqF45Jrn2va45
	t3yqvrZxC34UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUzyxiUUUUU=
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
 include/linux/perf_event.h | 6 ++----
 kernel/events/core.c       | 9 +++++++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e1e11500df09..d2eb22cc5b71 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1067,10 +1067,8 @@ struct perf_event_context {
 	 * should be avoided.
 	 *
 	 * Sum (event->pending_work + events with
-	 *    (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ)))
-	 *
-	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
-	 * that until the signal is delivered.
+	 *    (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ)) +
+	 *    events with attr->sigtrap)
 	 */
 	local_t				nr_no_switch_fast;
 };
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 857230b023ae..094b42ed6462 100644
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
-- 
2.34.1


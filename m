Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871079;
	b=Ybumx6cp2jM4VTxXAs7MWBdT/8SMMdO/b1SzcMhxLIyQk+lGbjYIZAcAdYkOR+CBzklm
	 r5IC39Tn5CUXYIP8N6yq9CpNyl1a0BTZpCKZ1sbChNQcWaRlSIbObwhB+Q/3Ns/UFWlym
	 a903UgG3f3DNRoNglgwtU0bvRjbQlCOg6gsCWYCAzEXNAsxCQ87dPBhafnnM/tV/y93X6
	 K9+it60w6ANIjt2o09HwDgVFoAmQwJDRGJIvYQsyQm2KTC5VCFUSP3qXprF9XNg7yy/1v
	 rDpAcEZkq7DY6RXioF0auvv9a8XeKUfbup1eUXB5MHFCpH4Oo4MtqR01dKbLwa8ZvlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871079;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=pctn8oD6fQBVAGPm5jnPVM5s1k69X3qxtiwPvcIl6kE=;
	b=aSeax3eJ3VIlPQ9NotuQBhCMmrcMBkaKA9oEHRY3J47DK+GTcWIXWuuDzbvuVanAVsNg
	 QNy8aDDIoqU7Ng5zH4au70Gy24ynkuZtgfGga/jC1DD4A9QAabm2n7+/BMVKG7am7pEVL
	 H67JoJchYlzbtFfq71440e1z+BLgvaJba9eBbNRsf9cpsWpC2KQlFN3xEVe68+cdggiJ4
	 7EOCMeVQYoFWr07P+aXt911pT6H0yqwJdLcwGoxXTA/Fny+7Fd1jRX6b9Rks+rtCJVTcm
	 qXLTL960EYc7FXy+gbv/V3TEkqo2WV9y7Vc0760DziDFPkA6qQDFE7pi5s65YsUzS9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03C606A330;
	Thu,  5 Nov 2026 09:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF03C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jKxr03Sjsz1c1lC;
	Thu,  5 Nov 2026 17:30:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A2E7740574;
	Thu,  5 Nov 2026 17:31:09 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBnnu3OTOxqcwqpDA--.46006S4;
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
Subject: [PATCH v3 2/2] perf/core: Disable context fast-swap for sigtrap events
Date: Thu,  5 Nov 2026 09:30:44 +0000
Message-Id: <f19b29b90fe1d0126fa8f5cd0e7c8d7da07e5a34.1793870900.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1793870900.git.wutengda@huaweicloud.com>
References: <cover.1793870900.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBnnu3OTOxqcwqpDA--.46006S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1UCFyUAryxGrW5JrykAFb_yoWrGF15pF
	WkCrn3KrW8XF12vw15Ka1qg343Ww4rKFsrWwsag3y3Zw4Yq3saqFWUJ3WYqF45Jrn2va45
	t3yqvrZ3C34UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUiF4tUUUUU==
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
index eb3f7bab498c..5cc0fb144e04 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1068,10 +1068,8 @@ struct perf_event_context {
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
index ee5c59158b89..d693a14ca50d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1999,7 +1999,7 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 		ctx->nr_user++;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat++;
-	if (has_inherit_and_sample_read(&event->attr))
+	if (has_inherit_and_sample_read(&event->attr) || event->attr.sigtrap)
 		local_inc(&ctx->nr_no_switch_fast);
 
 	if (event->state > PERF_EVENT_STATE_OFF)
@@ -2225,7 +2225,7 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 		ctx->nr_user--;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat--;
-	if (has_inherit_and_sample_read(&event->attr))
+	if (has_inherit_and_sample_read(&event->attr) || event->attr.sigtrap)
 		local_dec(&ctx->nr_no_switch_fast);
 
 	list_del_rcu(&event->event_entry);
@@ -3831,6 +3831,11 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
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


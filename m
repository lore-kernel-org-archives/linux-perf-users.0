Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871075;
	b=1Vqkm+LRJQs0VFOHcuIQ+M6Gwdvl2PVgJKEP77V0dMWY7pt1R8+ezubmH8g0GRTJE9H7
	 Fw//U1eVkhHWOBHvfAO4s4nTcqLK6FIQxaVfkrq3HNaYfSF16FxhQu7m5wLO09An+ODb6
	 PXpz+B4T9geir8CTigeIKqXf/XeVx7CgDO4xJjKhqzd35W33lRdStLW2sP0jLfal5VuC0
	 ab5S/XstmLskVCxg0FudUmMKrCvMGbXz/esdECH6UOfF/6M9IuyORVw9wYrfLQ6jmktoM
	 NxUbeScKpmZixGqclSUFxMCLKftbus/9vlmrJJJibXUDHAUMGovQt8xmLJgMjBtnqhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871075;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=SRZQ0Gzs6aLf7t6xhqXhqon/Ja06I2IN6ER4ujbRXnw=;
	b=08XG8AqNQtNgJBFkLULV739YI91ch8caVpvHOi3n9DTAWAvfVgKdoptK4BkmYUSrYwMk
	 mClqDUoUiN4LFnYNaJGyorKYiTQAbbq4LgSVm8S6h833ggSPE0C6QL4E7CU008glOT5Dv
	 JY5pSewh+aSQ2MnYv8oWDliPgEr9ElU4q70Gw1+d081LTDyEYpFfhbP7r5VUJyOLetr/p
	 h84aK1Nlbd6MwUSEzZ+xRFF18s8dOrpZOXbVqN1kULU7BUJTbJjnRTE0BjloKoeQRmMrB
	 pZPRjp4Hp1MVGHAAmxiFPKOggT3JWNzG6+o+VRLmjqy+cAkfDwS2w30sHJXP3pFGFnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206A606A31B;
	Thu,  5 Nov 2026 09:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F206A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jKxr065GBz1rqYh;
	Thu,  5 Nov 2026 17:30:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 894F040573;
	Thu,  5 Nov 2026 17:31:09 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBnnu3OTOxqcwqpDA--.46006S3;
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
Subject: [PATCH v3 1/2] perf/core: Prevent duplicate sigtrap task work enqueue
Date: Thu,  5 Nov 2026 09:30:43 +0000
Message-Id: <ff842e802e9ecb74510a90964f8ad2c4825834b7.1793870900.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBnnu3OTOxqcwqpDA--.46006S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr15JFy8AF48XF1fGrW5GFg_yoW5Zr48pr
	W3trn8ta1UXrnFqry5tws7Ar18Ww40qan8ArWDCa4SvF1YvF9rXay7W3WYvFW5ArnrAa43
	Zw4j9rW7C34UXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiR6wJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The sigtrap handling in __perf_event_overflow() checks
event->pending_work before calling task_work_add(), but only sets
pending_work after the task work has been queued.

This leaves a window where an NMI can interrupt task_work_add()
and re-enter __perf_event_overflow() for the same event. Since
pending_work is still zero, the nested invocation can enqueue
the same pending_task again.

The re-entrant call path is:

  __perf_event_overflow()
    task_work_add()
      kasan_record_aux_stack()
        <NMI>
          __perf_event_overflow()
            task_work_add()

The nested invocation can enqueue pending_task before the
outer invocation does. When the outer invocation resumes, it
inserts the same task_work entry again, potentially creating
a cycle in the task work list.

This causes perf_pending_task() to be executed repeatedly
and leads to unbalanced event reference counting.

Use cmpxchg() to atomically claim pending_work before calling
task_work_add(). This ensures that only one invocation can
enqueue the pending_task, even when interrupted by an NMI.

If task_work_add() fails, clear the pending_work claim so that
a subsequent overflow can retry.

Also use READ_ONCE() when checking pending_work in the
exclude_kernel warning path to avoid an unsynchronized read.

Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 kernel/events/core.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 457d75ea7142..ee5c59158b89 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10925,16 +10925,17 @@ static int __perf_event_overflow(struct perf_event *event,
 
 		notify_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
 
-		if (!event->pending_work &&
-		    !task_work_add(current, &event->pending_task, notify_mode)) {
-			event->pending_work = pending_id;
-			local_inc(&event->ctx->nr_no_switch_fast);
-			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
-
-			event->pending_addr = 0;
-			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
-				event->pending_addr = data->addr;
-
+		if (cmpxchg(&event->pending_work, 0, pending_id) == 0) {
+			if (!task_work_add(current, &event->pending_task, notify_mode)) {
+				local_inc(&event->ctx->nr_no_switch_fast);
+				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
+
+				event->pending_addr = 0;
+				if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
+					event->pending_addr = data->addr;
+			} else {
+				cmpxchg(&event->pending_work, pending_id, 0);
+			}
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
@@ -10948,7 +10949,7 @@ static int __perf_event_overflow(struct perf_event *event,
 			 *     To approximate progress (with false negatives),
 			 *     check 32-bit hash of the current IP.
 			 */
-			WARN_ON_ONCE(event->pending_work != pending_id);
+			WARN_ON_ONCE(READ_ONCE(event->pending_work) != pending_id);
 		}
 	}
 
-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914912;
	b=LGdTbtzbeBAvbInFMnw48qKRAz81EJVjaEN5gBPATfD7O/zpc3ewZfJqsEVm4dXdEN3n
	 s74AgAP33LUEyFTbe6eFt5KRqyTGV7TIs1tCZMBeprOKgM/zeqzj44EDFQwGdaPa8PHiv
	 mpfc6jKHrmk/2DCBrtFPPNs6zE6f/m1qL2rytMN/WxA+owNWkhd4HjaSo8F1nPYmiUgDA
	 3FSKxODEX3+FkzpiEu1o1+n89v/fL9PnUJiRmn021usPgeVSH5VWby2pjLo3MyyR9Rnye
	 jIPXa9chzw+57VoPtJnsmjOMn8egdsuybCVaIGtVoC7Ct8ZDsBQ183G1C/U3ErcqiYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914912;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=MXOCB2uKjKaor2OrklW8VqDy4yR8s1PFFph39t/ACkc=;
	b=zm/Ygsxd/9di1e4uWdInMFMV7FJ213hcDF6Aq/h0XSInD7rnSJ8bQ8p88OQQbCB0gxeI
	 +xqd6I5aRVK1rDdJ6Yen0AJPRzg0GZ95gI/WYxurl93uSX5uCrWk5PMvbYgrom84DK4do
	 sZyMbvNLI5WIQtuilXsa+94ru9Zol/Y5ANCVg8SwwLN5IfbG8cYW3gUVSdLkg8Eat1C4V
	 kvLnXNWhJyak01e9NCWcCXa+6HON4IQdK6moFLxchN23eg/soZ9BNsf9ZpmhG7IGVpKMR
	 3Z0B3ucvdhnBJHaZQFy/pKmfGgB9XUkKrUO83iP5yVmluEH4LnFjuyx5vmojhZAdchw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4679606A323;
	Tue, 17 Nov 2026 11:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4679606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jTMsP0zctz1rrSl;
	Tue, 17 Nov 2026 19:27:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9D9B040574;
	Tue, 17 Nov 2026 19:28:27 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBHS_5QOvxq4EOQEg--.20741S3;
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
Subject: [PATCH v4 1/2] perf/core: Prevent duplicate sigtrap task work enqueue
Date: Tue, 17 Nov 2026 11:28:07 +0000
Message-Id: <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1794914794.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBHS_5QOvxq4EOQEg--.20741S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr15JFy8AF48GF18GFyUKFg_yoWrCF15pr
	43tws0ya1UXFnFqry5tw1kAr1rWw4FqFZ8ArWvk34fAF1YqF17Xay7G3WYvFWrArn7Aa43
	Xw40kFW7C34UXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUjQ6XUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The sigtrap handling in __perf_event_overflow() checks
event->pending_work before calling task_work_add(), but only sets
pending_work after the task work has been queued.

This leaves a window where an NMI can interrupt task_work_add()
and re-enter __perf_event_overflow() for the same event. Since
pending_work is still zero, the nested invocation can enqueue
the same pending_task again.

The re-entrant call path looks like this:

  __perf_event_overflow()
    task_work_add()
      kasan_record_aux_stack()
        <NMI>
          __perf_event_overflow()
            task_work_add()

The nested invocation may enqueue pending_task before the
outer invocation does. When the outer invocation resumes, it
inserts the same task work entry again, potentially creating
a cycle in the task work list.

As a result, perf_pending_task() may be executed repeatedly,
leading to unbalanced event reference counting.

Fix this by atomically claiming pending_work with
cmpxchg_acquire() before calling task_work_add(). This ensures
that only one invocation can enqueue the task work, even when
another overflow occurs re-entrantly from an NMI.

If task_work_add() fails, clear the claim with
smp_store_release() to allow a subsequent overflow to retry.

In perf_pending_task(), defer clearing pending_work until
after perf_sigtrap() has completed. Use smp_store_release()
to ensure that a subsequent overflow cannot re-queue the task
work before the previous invocation has finished handling it.

Also use smp_load_acquire() when checking pending_work in
the exclude_kernel warning path to ensure the read is properly
ordered.

Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 kernel/events/core.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 614f9f0e6500..857230b023ae 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7775,10 +7775,14 @@ static void perf_pending_task(struct callback_head *head)
 	 */
 	rctx = perf_swevent_get_recursion_context();
 
-	if (event->pending_work) {
-		event->pending_work = 0;
+	if (smp_load_acquire(&event->pending_work)) {
 		perf_sigtrap(event);
 		local_dec(&event->ctx->nr_no_switch_fast);
+		/*
+		 * Ensure the pending work is fully handled before allowing
+		 * another overflow to queue it. See __perf_event_overflow().
+		 */
+		smp_store_release(&event->pending_work, 0);
 	}
 	put_event(event);
 
@@ -10950,16 +10954,25 @@ static int __perf_event_overflow(struct perf_event *event,
 
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
+		/*
+		 * Claim pending_work before queueing the task work to prevent
+		 * another overflow from queueing it concurrently.
+		 */
+		if (cmpxchg_acquire(&event->pending_work, 0, pending_id) == 0) {
+			if (!task_work_add(current, &event->pending_task, notify_mode)) {
+				local_inc(&event->ctx->nr_no_switch_fast);
+				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
+
+				event->pending_addr = 0;
+				if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
+					event->pending_addr = data->addr;
+			} else {
+				/*
+				 * Publish the failed queueing attempt so
+				 * a subsequent overflow can retry.
+				 */
+				smp_store_release(&event->pending_work, 0);
+			}
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
@@ -10973,7 +10986,7 @@ static int __perf_event_overflow(struct perf_event *event,
 			 *     To approximate progress (with false negatives),
 			 *     check 32-bit hash of the current IP.
 			 */
-			WARN_ON_ONCE(event->pending_work != pending_id);
+			WARN_ON_ONCE(smp_load_acquire(&event->pending_work) != pending_id);
 		}
 	}
 
-- 
2.34.1


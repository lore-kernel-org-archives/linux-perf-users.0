Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793447161;
	b=yjhSeBCje5vU/OZ0WfuK6ALpsoTomhtTupdtibrd3TQ30IQvuUNdOH2tR4NY+I5nmxkW
	 7SdVns06DL5vHrWB1qu2FXvwy3Owc1ntWIQAX/eSGUmuoPjrCPdhZlwt+deC4PUgqeweS
	 VAhBzxaaJa462n2Z3MZqy5iqRYJPDf+M85jh8n6gjvx1tJfJ5PlPwbLFSbYnh84HPMDjF
	 WQ00xAabPA+7OezdDNBkoxUlsYmIGR2y/NBKwBgzgsfyT3Eicjf6gd0D3HMWKAyd4D50L
	 jMiJfcZfaEW1zjqbWSgGo4eFJZNzqESqub/IzVdRI+rQcCE7YcMCSSsPwQnS+3p0Rug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793447161;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=fqcMcWI6B4pbneac0+d0du8gjqzWSJbtYahBflLJhA8=;
	b=Ag6fyHDK9bzJ8nI88AvAvTQR2UaeY2M2OxgFpay+ujjDuAhy2ygvn3KbQZzyoAOHOzAT
	 roa7SXJ/bOAOFTMIeTrgagNG7ZVmRg5ClDxvQcFK9Scn/ctq9tPelYOXreGkoDaa9wRNM
	 rAGZ6uo8KTM4SVCn4d0C4tx1/ICWfLec0pJymA06+4ASpP5eaDxrmRjJiH8xIsVF3CmM9
	 q5QMj2N0H1ZieoVh1355xclHq6eL0lzPkpjubZPVuIRWfj79KmoGEq7VcXg5zVHgrxfak
	 tYpzUhhKLUW4yN9d7/PNv4dikziii+dyhMx1BKWTGsitxhGdRbQf4MfraAvuYzIBNQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EACE606A31C;
	Sat, 31 Oct 2026 11:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EACE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jGx3z3sdfz1c0W7;
	Sat, 31 Oct 2026 19:45:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id DA05D4056B;
	Sat, 31 Oct 2026 19:45:55 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAnKv3X1OVqfLkHCg--.25404S2;
	Sat, 31 Oct 2026 19:45:55 +0800 (CST)
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
Subject: [PATCH] perf/core: Prevent duplicate sigtrap task work enqueue
Date: Sat, 31 Oct 2026 11:45:20 +0000
Message-Id: <20261031114520.642476-1-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAnKv3X1OVqfLkHCg--.25404S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr15JFy8AF48XF1fGrW5GFg_yoW5ZF17pr
	W3trn8ta1UXrnFqry5tws7Ar18Ww40qan8ArWDCa4SvF1YvF9rXay7W3WYqFW5ArnrAa43
	Zw4j9rW7C34UXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
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
 kernel/events/core.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 457d75ea7142..f1e4e153c49a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10925,16 +10925,18 @@ static int __perf_event_overflow(struct perf_event *event,
 
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
+				event->pending_work = pending_id;
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
@@ -10948,7 +10950,7 @@ static int __perf_event_overflow(struct perf_event *event,
 			 *     To approximate progress (with false negatives),
 			 *     check 32-bit hash of the current IP.
 			 */
-			WARN_ON_ONCE(event->pending_work != pending_id);
+			WARN_ON_ONCE(READ_ONCE(event->pending_work) != pending_id);
 		}
 	}
 
-- 
2.34.1


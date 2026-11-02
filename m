Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585651;
	b=1TUirNVnYJVPfnDzRqWBR808M8ykJRkb1H00BPrvD9QtwFnEv6fzQRb+bzYlP18cs/16
	 zkHw4erzsfKNuvJo9KdW9W4fKy9HCY7heUor5Gdcwkka7z0Q3BfjGRI53CMH+f9s63F/v
	 B7+M2VQn0WO1B0YXSBFdLW6aF/UH+g+/zcdn/+wji9UGAf/IXHohjzXyvIruDzhKAvpHv
	 WV3mX9hSG+9C8oW6ZNJVw9lSCRYN8W79WYl/3dg+Qwe9AVi749fzwx5MwMqKmFTcMDp/c
	 flB251lipyHL3In8Pt0AQ7bsegtO92m4wH8dt9tzXs/IcfJCCUbVmhav08ArmIkUvdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585651;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=GvRE35XJQ4xUZoV4JwRSxvCslV0vzaJg9Inl/F3vTbs=;
	b=NuThb8E5RNY/m7Rg6fXFzCzyOdc2SssTwDblEOURSnIPWHmBHAs7Jy2mD7NKzoZ2blEf
	 EwFHFVEB4tmvSRkOTE/p4Th5wVYiRgzbVF9HaiWAIuzH7STXlrUHnI+pfEqbiYHXUBHn8
	 OfoS3Ke4xX1usUeZy64tTVfMvTzel8DERSpRsg7aYh4L44vNwqntAC6Wjj28RIVPz+OdU
	 v4pj1ptAVvx/GNf0S/NPu5GygyKDS782ypHepnpmw1/mWjwxm5mduSjPZ1XhnzCShsR0T
	 MAPosEy474i2qqFKEnfuixGoM8sOocCVncMwDC2z64cqWLNE4mGUsnhNyqMb/JWMMHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8F5606F6CB;
	Mon,  2 Nov 2026 02:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E8F5606F6CB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jHwHC6kb5z1rrK7;
	Mon,  2 Nov 2026 10:13:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A782040574;
	Mon,  2 Nov 2026 10:14:06 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHDgHn8edqKVXXCg--.2851S2;
	Mon, 02 Nov 2026 10:14:06 +0800 (CST)
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
Subject: [PATCH v2] perf/core: Prevent duplicate sigtrap task work enqueue
Date: Mon,  2 Nov 2026 02:13:55 +0000
Message-Id: <20261102021355.650671-1-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAHDgHn8edqKVXXCg--.2851S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr15JFy8AF48XF1fGrW5GFg_yoW5uF1kp3
	y3trn8ta1UXrnFqryrtws7Ar18Ww40qan8CrWkCa4SvF4YvFyDXay7W3WYqFW5ArnrAa43
	Zw4jkrW7u34UXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8c_-DUUUU
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
v2: Drop the redundant event->pending_work assignment. (Sashiko)
v1: https://lore.kernel.org/all/20261031114520.642476-1-wutengda@huaweicloud.com/

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


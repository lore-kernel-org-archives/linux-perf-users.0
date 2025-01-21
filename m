Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD41F237F;
	Tue, 21 Jan 2025 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464333; cv=none; b=dSGUg0CkHkK0Tp8lUkNVaSpdxql2AL6BgwxI+xBTYQ0j57z8jOlluGclnHtZlEr9TTYnMKbj9PJJgX6KZDGwfk1bSwVJq1tpfKyYFqQ5AntnaLEiZ9vXMbg+SBH9k1yj1aBW63jBHFT/PzFF3ahMAARMmK58DJgpZbgbKqXZO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464333; c=relaxed/simple;
	bh=QYslSgnT9BU4BwJnueu1pngMVropz0v/0dvjrApe5FU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l10/doX9SykTmuopj9d7Ys0EFoAWoyOhYZ6KG0GiLuGRCDmBAwKvPwHWmz/pclgyvkCgHYSA7KH7NxyLUz86atxn2IJGYaEi27xNfIuCwHr4dALYQaNP0PyHAqGi30SICon7Wk9HTz9ZvqtvN04XMNjyUZWM2h24Hb8a8rumtYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YcnMD5JMbz4f3jqy;
	Tue, 21 Jan 2025 20:58:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2C6FA1A154A;
	Tue, 21 Jan 2025 20:58:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl8Emo9npdRUBg--.36843S4;
	Tue, 21 Jan 2025 20:58:45 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [PATCH v2] perf/core: Fix warning due to unordred pmu_ctx_list
Date: Tue, 21 Jan 2025 13:08:02 +0000
Message-Id: <20250121130802.1813928-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl8Emo9npdRUBg--.36843S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur1kAry8trWDZFyxWrWDtwb_yoW5Wr15pF
	s7ArnYvFWkt3Wvvayaya1DXwn8Kr1fXFWDXwn8C34FyF4agFWDJa17GF45tF909rs7XFyj
	yw4jqFy7tayDtFDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRuZXoDUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

Syskaller triggers a warning due to prev_epc->pmu != next_epc->pmu in
perf_event_swap_task_ctx_data. vmcore shows that two lists have the same
perf_event_pmu_context, but not in the same order.

The problem is that the order of pmu_ctx_list for the parent is impacted by
the time when an event/pmu is added. While the order for a child is
impacted bt the event order in the pinned_groups and flexible_groups. So
the order of pmu_ctx_list in the parent and child may be different.

To fix this problem, insert the perf_event_pmu_context to proper place
after iteration of pmu_ctx_list.

The follow testcase can trigger above warning:

 # perf record -e cycles --call-graph lbr -- taskset -c 3 ./a.out &
 # perf stat -e cpu-clock,cs -p xxx // xxx is the pid of a.out

test.c

void main() {
        int count = 0;
        pid_t pid;

        printf("%d running\n", getpid());
        sleep(30);
        printf("running\n");

        pid = fork();
        if (pid == -1) {
                printf("fork error\n");
                return;
        }
        if (pid == 0) {
                while (1) {
                        count++;
                }
        } else {
                while (1) {
                        count++;
                }
        }
}

The testcase first open a lbr event, so it will alloc task_ctx_data, and
then open tracepoint and software events, so the parent ctx will have 3
different perf_event_pmu_contexts. When doing inherit, child ctx will
insert the perf_event_pmu_context in another order then the warning will
trigger.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
Changes in v2:
1. update commit message.
2. only sort the pmu_ctx_list of ctx which ctx->task != NULL.
Link to v1: https://lore.kernel.org/all/20250120114344.632474-1-luogengkun@huaweicloud.com/

---
 kernel/events/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..096f92b9a971 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4950,7 +4950,7 @@ static struct perf_event_pmu_context *
 find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 		     struct perf_event *event)
 {
-	struct perf_event_pmu_context *new = NULL, *epc;
+	struct perf_event_pmu_context *new = NULL, *pos = NULL, *epc;
 	void *task_ctx_data = NULL;
 
 	if (!ctx->task) {
@@ -5007,12 +5007,19 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 			atomic_inc(&epc->refcount);
 			goto found_epc;
 		}
+		// Make sure the pmu_ctx_list is sorted by pmu
+		if (!pos && epc->pmu->type > pmu->type)
+			pos = epc;
 	}
 
 	epc = new;
 	new = NULL;
 
-	list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+	if (!pos)
+		list_add_tail(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+	else
+		list_add(&epc->pmu_ctx_entry, pos->pmu_ctx_entry.prev);
+
 	epc->ctx = ctx;
 
 found_epc:
-- 
2.34.1


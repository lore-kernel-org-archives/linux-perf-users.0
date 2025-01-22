Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3126AF5;
	Wed, 22 Jan 2025 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737530689; cv=none; b=ESdqSN44VJUO6pSnWpvGX3Gv8NxjdQ5kb8gxexOSc3T/HnTIcSkZVSXFMusT+GPO71KNsl8a/irD+0x+IoMc0aBsGTs6XkmIYCogiUsyTGDKw7OYYvnk/PeBKHXfkcYpY4YLulnJ1TbTbqJ0tWrNJf7XdeGSrfKdCh94ac2MAlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737530689; c=relaxed/simple;
	bh=nnOW8QCaq9yXAB6ElHKDnDMVq3KR9+zk2s8leSid3II=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qc2urq/V9+xwJUHOhIZIJLba5zL+iJLwepcAq7i4l9Q6wHp+mLgrjT9cJAqtHdYLdAsLrd8IUPtXKwXtt90mxxpVQfQsgI9WM4bMDPF0/TC1U82/vbxwIujvu0J8oX4+TJne/yT+hyxBGNxEgGGKZXznCgnbPBCuMpgWP7WOD1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YdFv9206vz4f3jLN;
	Wed, 22 Jan 2025 15:24:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 27CAA1A1822;
	Wed, 22 Jan 2025 15:24:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgBHq183nZBnrk2dBg--.46007S4;
	Wed, 22 Jan 2025 15:24:41 +0800 (CST)
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
Subject: [PATCH v3] perf/core: Fix warning due to unordred pmu_ctx_list
Date: Wed, 22 Jan 2025 07:33:56 +0000
Message-Id: <20250122073356.1824736-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHq183nZBnrk2dBg--.46007S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGr18ArWxtw1DKFWUWry8Krg_yoW5Ar43pF
	4kCrnYvFWkKF10vayaya1DXw15Kr1fXa1DWwn8G34FyF4agFWDJa17GF45JF909rs7Wa4j
	yw4jqF17tayDta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

Syskaller triggers a warning due to prev_epc->pmu != next_epc->pmu in
perf_event_swap_task_ctx_data. vmcore shows that two lists have the same
perf_event_pmu_context, but not in the same order.

The problem is that the order of pmu_ctx_list for the parent is impacted by
the time when an event/pmu is added. While the order for a child is
impacted by the event order in the pinned_groups and flexible_groups. So
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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
1. update commit message.
2. modify annotation style.
3. add reviewed by.
Link to v2: https://lore.kernel.org/all/20250121130802.1813928-1-luogengkun@huaweicloud.com/
Link to v1: https://lore.kernel.org/all/20250120114344.632474-1-luogengkun@huaweicloud.com

---
 kernel/events/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..3f68fbbf3de0 100644
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
+		/* Make sure the pmu_ctx_list is sorted by pmu */
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


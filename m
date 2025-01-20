Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7091BBBD3;
	Mon, 20 Jan 2025 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372922; cv=none; b=d+X04m3aF39VLr9HW3IRybK3QzijtAnm9yU/joMcpW+UTF8qcvjMgKnxmb1xDuOZnqcxTaaBVR0WH133oPbshe++Or9WlECMW/z+sxmBtThyMQRxBWQPvbiZI7mWjGwAgp4LXe8KzYAdXAEszfI3MvZ0Lm+H2rn8fiCMBvrkHy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372922; c=relaxed/simple;
	bh=Kaz7UuSkcDR3PkLmDtYnp4b61PO3XRoA4o/ZfNAdjwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wpns1IcdAmuD+RYAc6pUonnz0qzur1FbA95VxJc5WRW3Wr8HNHtXFRH9G4XCRVMYgqEswb11n4Hxh+RiZ2nXZJWZCy39fGvPUEvhz+19CtfuiPGVLhYt0MGETaCKv3NKNI6qzmVrR8l6fbPcr9vMdMxnNfBDPxz7S9dqRKUxuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Yc7YC1q4Bz4f3jYQ;
	Mon, 20 Jan 2025 19:34:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C8D001A0E8B;
	Mon, 20 Jan 2025 19:35:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2DyNI5nVaTwBQ--.23185S4;
	Mon, 20 Jan 2025 19:35:15 +0800 (CST)
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
Subject: [PATCH] perf/core: Fix warning warning due to unordred pmu_ctx_list
Date: Mon, 20 Jan 2025 11:43:44 +0000
Message-Id: <20250120114344.632474-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHK2DyNI5nVaTwBQ--.23185S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWryxKF4rCr43Cw1fuFyrXrb_yoW5Cw4fpF
	s7CrnavrWkt3Z7Zay3Ja1DXwn8Kr1fXFWDGwn8Gw1FyF4fWFWDWa4UGa1Yyr98ur1xuFyY
	yw4jqFy7tayDXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

Syskaller triggers a warning due to prev_epc->pmu != next_epc->pmu in
perf_event_swap_task_ctx_data. vmcore shows that two lists have the same
perf_event_pmu_context, but not in the same order.

The problem is that when inheritance is performed, it traverses the ordered
groups of events, and inserts the new perf_event_pmu_context into
child_ctx->pmu_ctx_list which is unordered. So the order of pmu_ctx_list in
the parent and child may be different.

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

To fix this problem, add pmu_ctx_insertion_sort to make sure the
pmu_ctx_list is ordered.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 kernel/events/core.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95b01a51139d..1bdff3ef0ce2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4953,6 +4953,24 @@ find_get_context(struct task_struct *task, struct perf_event *event)
 	return ERR_PTR(err);
 }
 
+/*
+ * This function ensures that ctx->pmu_ctx_list is ordered, so that no warning
+ * is triggered due to prev_epc->pmu != next_epc->pmu.
+ */
+static void pmu_ctx_insertion_sort(struct perf_event_pmu_context *new,
+				   struct perf_event_context *ctx)
+{
+	struct perf_event_pmu_context *epc;
+
+	lockdep_assert_held(&ctx->lock);
+
+	list_for_each_entry(epc, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+		if (epc->pmu > new->pmu)
+			break;
+	}
+	list_add(&new->pmu_ctx_entry, epc->pmu_ctx_entry.prev);
+}
+
 static struct perf_event_pmu_context *
 find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 		     struct perf_event *event)
@@ -4974,7 +4992,7 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 		if (!epc->ctx) {
 			atomic_set(&epc->refcount, 1);
 			epc->embedded = 1;
-			list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+			pmu_ctx_insertion_sort(epc, ctx);
 			epc->ctx = ctx;
 		} else {
 			WARN_ON_ONCE(epc->ctx != ctx);
@@ -5021,7 +5039,7 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 	printk(KERN_INFO
 		"lgk: ctx %p insert pmu ctx %p, pmu is %p!\n", ctx, epc, epc->pmu);
 
-	list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+	pmu_ctx_insertion_sort(epc, ctx);
 	epc->ctx = ctx;
 
 found_epc:
-- 
2.34.1


Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2D1AD5E1;
	Wed, 21 Aug 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247440; cv=none; b=lkZOSVrkhWx+4GW8BlHJHwtb/9YgY6p+jhbYc/HwHbGGkHXcm0/YsX2usJzSgi6Jw5I3LT/gN4pVyhgQrxNsayeeEfnwt6cyUQzx1AgQFbTBwlzErOTCumrml9KDMCyEtfoa6rt28ghjTfIn5vtTUT4r4OeZk/byNvlmv2kzrqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247440; c=relaxed/simple;
	bh=z31QW6kvH2wyeyMWTQnXNuZskSb2afeJSupgdV0PHQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/J20QnVx3Ib09QeeWCLryAY2hG7q4A8Ns8RJk4hgmj03Cih4ZZ9frlxdCRtVLwb2WoKMOILU7qUbzPKKDnxSQnhNGHB5ZqVBrv86gcvdlq9zX1dX3mNCdO5D/g8PRqoyOfXzNCSVzTDgtUxTDxLfwvPU1KlZJikcyHAai+yzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WpnS62jszz4f3jrs;
	Wed, 21 Aug 2024 21:36:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8E0B01A1568;
	Wed, 21 Aug 2024 21:37:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4V97cVmXa5CCQ--.15501S6;
	Wed, 21 Aug 2024 21:37:08 +0800 (CST)
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [PATCH v4 2/2] perf/core: Fix incorrect time diff in tick adjust period
Date: Wed, 21 Aug 2024 13:42:27 +0000
Message-Id: <20240821134227.577544-3-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821134227.577544-1-luogengkun@huaweicloud.com>
References: <20240821134227.577544-1-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4V97cVmXa5CCQ--.15501S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4rXryDtF4kAr13XrW3GFg_yoW5XFy5pF
	Z8AF1aqFWkXw1F9345C3Z2gw15X3WkArsIga45KrWfAw47trZ3XFsrWF15Xr15AFZ7Za4a
	v3ZFgryUC3yjqFJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxc
	IEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4c8E
	cI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYTmhDU
	UUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

Perf events has the notion of sampling frequency which is implemented in
software by dynamically adjusting the counter period so that samples occur
at approximately the target frequency.  Period adjustment is done in 2
places:
 - when the counter overflows (and a sample is recorded)
 - each timer tick, when the event is active
The later case is slightly flawed because it assumes that the time since
the last timer-tick period adjustment is 1 tick, whereas the event may not
have been active (e.g. for a task that is sleeping).

Fix by using jiffies to determine the elapsed time in that case.

Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a8942277dda..d29b7cf971a1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -265,6 +265,7 @@ struct hw_perf_event {
 	 * State for freq target events, see __perf_event_overflow() and
 	 * perf_adjust_freq_unthr_context().
 	 */
+	u64				freq_tick_stamp;
 	u64				freq_time_stamp;
 	u64				freq_count_stamp;
 #endif
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a9395bbfd4aa..86e80e3ef6ac 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -55,6 +55,7 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/jiffies.h>
 
 #include "internal.h"
 
@@ -4120,7 +4121,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 {
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
-	u64 now, period = TICK_NSEC;
+	u64 now, period, tick_stamp;
 	s64 delta;
 
 	list_for_each_entry(event, event_list, active_list) {
@@ -4148,6 +4149,10 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		 */
 		event->pmu->stop(event, PERF_EF_UPDATE);
 
+		tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
+		period = tick_stamp - hwc->freq_tick_stamp;
+		hwc->freq_tick_stamp = tick_stamp;
+
 		now = local64_read(&event->count);
 		delta = now - hwc->freq_count_stamp;
 		hwc->freq_count_stamp = now;
@@ -4157,9 +4162,9 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		 * reload only if value has changed
 		 * we have stopped the event so tell that
 		 * to perf_adjust_period() to avoid stopping it
-		 * twice.
+		 * twice. And skip if it is the first tick adjust period.
 		 */
-		if (delta > 0)
+		if (delta > 0 && likely(period != tick_stamp))
 			perf_adjust_period(event, period, delta, false);
 
 		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
-- 
2.34.1


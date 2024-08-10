Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A21514DC;
	Sat, 10 Aug 2024 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723285110; cv=none; b=tcNM2nQFOH6UwRxpaTDwNuT7x2cIQNmsUItB5nEqLfQX254AFHx8r8kl/6lT37/LG3BWTsGzFNjf1kBTey1nq/azP/O34TxA/M5w2G6F1bVx+b2oSiiS4mAvtM59x0snFQHaoXPYMxxHqVl8Smw/TrKaraHWvKRKkPb/e/btm60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723285110; c=relaxed/simple;
	bh=IbU8lDGRSb6RrSmjo8Ux+vm167vgMSbXpHUYhLvr66M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MLnF83MMK5Z51BTzcjVBdB/m69GQ4T3vcAaiOrZGpIIVMvIDAm2WgYSM15I0BvxNO8ReGGCiuKYF4Z39B1Z57PHrS/DX3NUDegQysgpwKs0Q85hVrxDBrXrCOJI9XIGMhoCEi19iIMWIR1hUVe8mAi1Ba4oBla07KhBcDw1vs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WgxYv10Mxz4f3jdG;
	Sat, 10 Aug 2024 18:18:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A4C631A1629;
	Sat, 10 Aug 2024 18:18:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgBXfoRuPrdmTV4rBQ--.16555S6;
	Sat, 10 Aug 2024 18:18:24 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [PATCH v3 2/2] perf/core: Fix incorrected time diff in tick adjust period
Date: Sat, 10 Aug 2024 10:24:05 +0000
Message-Id: <20240810102406.1190402-3-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810102406.1190402-1-luogengkun@huaweicloud.com>
References: <20240810102406.1190402-1-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXfoRuPrdmTV4rBQ--.16555S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4xCw4xuF4UCFWDZrykGrg_yoWrWFyUpr
	Z0yry3tFsrJF1j9wnYka4Fgry5Ww48Aan8G348Cw18Aw1fGr9xJF4kKF1UGF98AFZrZFyI
	y3s0gw4ayFWjqaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AK
	xVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUADGOUUUUU=
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

Adrian found that there is a probability that the number of samples
is small, which is caused by the unreasonable large sampling period.

 # taskset --cpu 0 perf record -F 1000 -e cs -- taskset --cpu 1 ./test
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.010 MB perf.data (204 samples) ]
 # perf script
 ...
 test   865   265.377846:         16 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.378900:         15 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.379845:         14 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.380770:         14 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.381647:         15 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.382638:         16 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.383647:         16 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.384704:         15 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.385649:         14 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.386578:        152 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.396383:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.406183:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.415839:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.425445:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.435052:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.444708:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.454314:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.463970:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.473577:        154 cs:  ffffffff832e927b schedule+0x2b
 ...

And the reason is perf_adjust_freq_unthr_events() calculates a value that is too
big because it incorrectly assumes the count has accumulated only since the last
tick, whereas it can have been much longer. To fix this problem, perf can calculate
the tick interval by itself. For perf_adjust_freq_unthr_events we can use jiffies
to calculate the tick interval more efficiently, as sugguested by Adrian.

Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index afb028c54f33..2708f1d0692c 100644
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
index cad50d3439f1..309af5520f52 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -55,6 +55,7 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/jiffies.h>
 
 #include "internal.h"
 
@@ -4112,7 +4113,7 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 {
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
-	u64 now, period = TICK_NSEC;
+	u64 now, period, tick_stamp;
 	s64 delta;
 
 	/*
@@ -4151,6 +4152,10 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 		 */
 		event->pmu->stop(event, PERF_EF_UPDATE);
 
+		tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
+		period = tick_stamp - hwc->freq_tick_stamp;
+		hwc->freq_tick_stamp = tick_stamp;
+
 		now = local64_read(&event->count);
 		delta = now - hwc->freq_count_stamp;
 		hwc->freq_count_stamp = now;
@@ -4162,8 +4167,13 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 		 * to perf_adjust_period() to avoid stopping it
 		 * twice.
 		 */
-		if (delta > 0)
-			perf_adjust_period(event, period, delta, false);
+		if (delta > 0) {
+			/*
+			 * we skip first tick adjust period
+			 */
+			if (likely(period != tick_stamp))
+				perf_adjust_period(event, period, delta, false);
+		}
 
 		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
 	next:
-- 
2.34.1


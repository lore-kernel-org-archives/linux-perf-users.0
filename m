Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53F484039;
	Mon,  3 Jun 2024 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407231; cv=none; b=nJ38hfbRyYJ9F3XKyRYn11QzGIdgrawL+N5o8tl4WeQ2XY4LHzCvWqJJH412H5tApLpi8cy0ZeMWX4f1zdreWPew1+qwZLXqquB6TTIRpH9AOtVw8XRksDl7K911OkwaWyGRLQ7biOxAjfOxXeaNI16Ocf/ktTX+KVbf8HFy7xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407231; c=relaxed/simple;
	bh=vLeKRnEegxE0K436urLC3fMIxW8y761LOsyI4592Faw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPGNttOTrw/RAXT0Bb6Xaw3TIdaas0+dAsAJM4MzMv4OWU0l6YRDPS1Cb1YFCCdUUu4ElbzXbPj19Zr8ETwauL57iN0YWupxTBBM21PQ3mjozmGNyo9joGUMMZeT4disbQlDNBQJfw9XgRR1261uvlKMNr4XQWC/pDX+wZdGY0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Vt7hk5M0NzmXXQ;
	Mon,  3 Jun 2024 17:29:10 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id D03E5180060;
	Mon,  3 Jun 2024 17:33:40 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Jun 2024 17:33:40 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>, <dongli.zhang@oracle.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 1/3] perf pmu: Limit PMU cpumask to online CPUs
Date: Mon, 3 Jun 2024 17:28:10 +0800
Message-ID: <20240603092812.46616-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20240603092812.46616-1-yangyicong@huawei.com>
References: <20240603092812.46616-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

We'll initialize the PMU's cpumask from "cpumask" or "cpus" sysfs
attributes if provided by the driver without checking the CPUs
are online or not. In such case that CPUs provided by the driver
contains the offline CPUs, we'll try to open event on the offline
CPUs and then rejected by the kernel:

[root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online
[root@localhost yang]# ./perf_static stat -e armv8_pmuv3_0/cycles/ --timeout 100
Error:
The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
/bin/dmesg | grep -i perf may provide additional information.

So it's better to do a double check in the userspace and only include
the online CPUs from "cpumask" or "cpus" to avoid opening events on
offline CPUs.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/perf/util/pmu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 888ce9912275..51e8d10ee28b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -771,8 +771,17 @@ static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name, bool is_cor
 			continue;
 		cpus = perf_cpu_map__read(file);
 		fclose(file);
-		if (cpus)
-			return cpus;
+		if (cpus) {
+			struct perf_cpu_map *intersect __maybe_unused;
+
+			if (perf_cpu_map__is_subset(cpu_map__online(), cpus))
+				return cpus;
+
+			intersect = perf_cpu_map__intersect(cpus, cpu_map__online());
+			perf_cpu_map__put(cpus);
+			if (intersect)
+				return intersect;
+		}
 	}
 
 	/* Nothing found, for core PMUs assume this means all CPUs. */
-- 
2.24.0


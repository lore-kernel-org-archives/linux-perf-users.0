Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D784039;
	Mon,  3 Jun 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407226; cv=none; b=S8q9jfCWr8F7028UCgCT3/AbWXgN+PMFaJSDVlAnfbXLAAiYQh/Xrzsa2UcDtmj+ATtZK8qURa4i4NPBN/tc/rhQJ5T1mqNVIM4nIN3KWI2Kry+Y3HfAsacTNhe1DSAtYXCMdGKE79i73XjQHQq6QofaxRDx2Zo2nbfDWaSyYgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407226; c=relaxed/simple;
	bh=ElFxRXFnLreP2B/j6C2YdLwoMXQn2kE494QqHuqzJBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgU0JQgdh77ZJTV8/JYLQhLKH/OPcUbiIkj0PxdtrTUFAnl+G3ISJJQFwzjx1d2yKBeL+WHjn45d2cWkS5F78uoVfhkdIcueXZc/DdIgfegLJ+R1tNLJmuIanniY9rzfSJuyiCM2ucYwV0XrC6W2e8ptqdyS8+dqFTdyWR7XxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Vt7kB55pNz1yspx;
	Mon,  3 Jun 2024 17:30:26 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AA4F180063;
	Mon,  3 Jun 2024 17:33:41 +0800 (CST)
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
Subject: [PATCH 2/3] perf: arm_pmu: Only show online CPUs in device's "cpus" attribute
Date: Mon, 3 Jun 2024 17:28:11 +0800
Message-ID: <20240603092812.46616-3-yangyicong@huawei.com>
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

When there're CPUs offline after system booting, perf will failed:
[root@localhost ~]# /home/yang/perf stat -a -e armv8_pmuv3_0/cycles/
Error:
The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
/bin/dmesg | grep -i perf may provide additional information.

This is due to PMU's "cpus" is not updated and still contains offline
CPUs and perf will try to open perf event on the offlined CPUs.

Make "cpus" attribute only shows online CPUs and introduced a new
"supported_cpus" where users can get the range of the CPUs this
PMU supported monitoring.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/arm_pmu.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 8458fe2cebb4..acbb0e1d0414 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -558,13 +558,35 @@ static ssize_t cpus_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(dev_get_drvdata(dev));
-	return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus);
+	cpumask_var_t mask;
+	ssize_t n;
+
+	/* If allocation failed then show the supported_cpus */
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
+		return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus);
+
+	cpumask_and(mask, &armpmu->supported_cpus, cpu_online_mask);
+	n = cpumap_print_to_pagebuf(true, buf, mask);
+	free_cpumask_var(mask);
+
+	return n;
 }
 
 static DEVICE_ATTR_RO(cpus);
 
+static ssize_t supported_cpus_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus);
+}
+
+static DEVICE_ATTR_RO(supported_cpus);
+
 static struct attribute *armpmu_common_attrs[] = {
 	&dev_attr_cpus.attr,
+	&dev_attr_supported_cpus.attr,
 	NULL,
 };
 
-- 
2.24.0


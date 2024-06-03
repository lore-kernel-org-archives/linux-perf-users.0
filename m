Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D585C77;
	Mon,  3 Jun 2024 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407231; cv=none; b=C+AcLVRNThe9B5egPUcbdIgx+evbkKl7WYEG6YwTf3PMFRvUKc76bThSVkHc9jeT+ffouPdR+8O2PAKAbNLxqpkyFhDbFHfl+LM8llQWhkuaHQ0zxxnJD83ugMMhw0xdR5o9R74/JX/EQ2gMEh4zNBSY957baiRbLniG5NT6zGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407231; c=relaxed/simple;
	bh=XhEbvu4Og1P2n64dCfUrrOpcJR4T9pHKZ6Ww9X4yrKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVTtSFuyBfqwz5O+O1J7jBNZ2fGW7izR3FrF5U+Csg/rG9f0HhXsVA+rudDE9Jc7hwPyWQ3hOhSHKqx4MSc7DD+/ItCOFFkMCQ6YR48QSOh5OK2oZsLnlaaCGSspGKp5y12YJCSm/bon+4czqIX6g0ZoZ8kpZ8gg4U57bIUNpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Vt7lw6C5Dz1HCv1;
	Mon,  3 Jun 2024 17:31:56 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 0306A1A0188;
	Mon,  3 Jun 2024 17:33:42 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Jun 2024 17:33:41 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>, <dongli.zhang@oracle.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 3/3] perf: arm_spe: Only show online CPUs in device's "cpumask" attribute
Date: Mon, 3 Jun 2024 17:28:12 +0800
Message-ID: <20240603092812.46616-4-yangyicong@huawei.com>
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
[root@localhost ~]# /home/yang/perf record -e arm_spe_0//
Error:
The sys_perf_event_open() syscall returned with 19 (No such device) for event (arm_spe_0//).
/bin/dmesg | grep -i perf may provide additional information.

This is due to PMU's "cpumask" is not updated and still contains offline
CPUs and perf will try to open perf event on the offlined CPUs.

Make "cpumask" attribute only shows online CPUs and introduced a new
"supported_cpus" where users can get the range of the CPUs this
PMU supported monitoring.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/arm_spe_pmu.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 9100d82bfabc..2182f214c587 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -254,13 +254,33 @@ static ssize_t cpumask_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
+	cpumask_var_t mask;
+	ssize_t n;
 
-	return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
+	/* If allocation failed then show the supported_cpus */
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
+		return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
+
+	cpumask_and(mask, &spe_pmu->supported_cpus, cpu_online_mask);
+	n = cpumap_print_to_pagebuf(true, buf, mask);
+	free_cpumask_var(mask);
+
+	return n;
 }
 static DEVICE_ATTR_RO(cpumask);
 
+static ssize_t supported_cpus_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
+
+	return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
+}
+static DEVICE_ATTR_RO(supported_cpus);
+
 static struct attribute *arm_spe_pmu_attrs[] = {
 	&dev_attr_cpumask.attr,
+	&dev_attr_supported_cpus.attr,
 	NULL,
 };
 
-- 
2.24.0


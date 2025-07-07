Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000D28A719;
	Mon,  7 Jul 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900822; cv=none; b=mH3c/5Je2+qa8/UlXejvo4R+Wlqj9/Q746Kc1AW6p2zm81unai24okeVRbZ8hQ6zF+UgO51cjVu7fezeaBmim177t3Mtil/+Za0FvugYHvxwwDjyUTxqf5Y0nTcYr5bkZKdWxGQoptScBtnulzVX2sSLIchLw5MffvkRALWNfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900822; c=relaxed/simple;
	bh=a3tFfaUC5nwZzL3kNsozkXk8L0sG9BajuGncdWLpSW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOpkWYsthrXMbLv88iNrJP3772U7xYTXKHbAM2uBePBpVjv7C3/ysD39IRt1P4PMUKgD4YvK0g4uxVP8tG+NwlSmPMbh5Vw1drjY0inbfy2+gItjfE08j9FgrwvCbPjwAg3lzX7P1W+T3rbrb6MUUheojx8+WTrhw430a7Jbvbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bbSHX6MYYz6G93x;
	Mon,  7 Jul 2025 23:06:16 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 57F551402EE;
	Mon,  7 Jul 2025 23:06:59 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.45.147.207) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Jul 2025 17:06:57 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <mark.rutland@arm.com>, <robh@kernel.org>
CC: <coresight@lists.linaro.org>, <devicetree@vger.kernel.org>,
	<dianders@chromium.org>, <james.clark@linaro.org>,
	<jonathan.cameron@huawei.com>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linuxarm@huawei.com>,
	<mike.leach@linaro.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: [PATCH 5/5] perf/arm-dsu: refactor cpu id retrieval via new API of_cpu_phandle_to_id
Date: Mon, 7 Jul 2025 16:04:14 +0100
Message-ID: <20250707150414.620-6-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707150414.620-1-alireza.sanaee@huawei.com>
References: <20250707150414.620-1-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500003.china.huawei.com (7.182.85.28)

Update arm-dsu to use the new API, where both "cpus" and "cpu"
properties are supported.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 drivers/perf/arm_dsu_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index cb4fb59fe04b..7ef204d39173 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -596,11 +596,9 @@ static int dsu_pmu_dt_get_cpus(struct device *dev, cpumask_t *mask)
 	n = of_count_phandle_with_args(dev->of_node, "cpus", NULL);
 	if (n <= 0)
 		return -ENODEV;
+
 	for (; i < n; i++) {
-		cpu_node = of_parse_phandle(dev->of_node, "cpus", i);
-		if (!cpu_node)
-			break;
-		cpu = of_cpu_node_to_id(cpu_node);
+		cpu = of_cpu_phandle_to_id(dev->of_node, &cpu_node, i);
 		of_node_put(cpu_node);
 		/*
 		 * We have to ignore the failures here and continue scanning
-- 
2.43.0


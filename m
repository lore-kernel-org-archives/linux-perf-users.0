Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72547257420;
	Mon, 12 May 2025 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037400; cv=none; b=PLpTKCgI+8zU3wK5u5o6pahozF57UNI/B/IC5as6BmdlPh3KCRL3FTsfw0EhfqjAsbkhESzhzLKtTioFQCpRIShnGupT4JSidFAuJOh44jIdZqip60K0wl8QTzbSuRBY1ST3h1ssg5xFP73k2tspiuyYO4y2byXFaKaFcyfIffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037400; c=relaxed/simple;
	bh=86RFJGgsvzEJQpRgYjnhLJ6ByzoyLTPc5oOuzezqwWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6XWCXWRNn+AhKZYX1o7txRYUjzq/pfAxgeuNp/Vlq0hg8Q/9a20vj4YSwd4tfu9e5DZ3o2qVUKl9WFwBeFVWcGkI2zBCGE7fxNar2xOtsXbtQDGxG1V6/e10htZTddjolRM407mYXvr2P0IgRAU4ViN5Siu/oiVGWElUyHPQVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zwsbf6JXNz6M4jB;
	Mon, 12 May 2025 16:05:18 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 6469C1402F4;
	Mon, 12 May 2025 16:09:57 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.30.10) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 May 2025 10:09:56 +0200
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <devicetree@vger.kernel.org>
CC: <robh@kernel.org>, <alireza.sanaee@huawei.com>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<mark.rutland@arm.com>, <shameerali.kolothum.thodi@huawei.com>,
	<krzk@kernel.org>, <dianders@chromium.org>, <catalin.marinas@arm.com>,
	<suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <coresight@lists.linaro.org>,
	<gshan@redhat.com>, <ruanjinjie@huawei.com>, <saravanak@google.com>
Subject: [PATCH v3 5/7] perf/arm-dsu: refactor cpu id retrieval via new API of_cpu_phandle_to_id
Date: Mon, 12 May 2025 09:07:13 +0100
Message-ID: <20250512080715.82-6-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512080715.82-1-alireza.sanaee@huawei.com>
References: <20250512080715.82-1-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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
2.34.1


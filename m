Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189DF192D87;
	Wed, 16 Apr 2025 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769329; cv=none; b=LxFoa8IBQBdzjUvzJsTkT88mJw0xLYJTxmlKSa9PEMiUCUH+3etGMYJJ28KUIERL6u2e9jkknek7TdiL2EYmvGOCYknSfLjoZe4a/f11UA+o0oosSHiWZ5ci8jPKmZ8PLKTYUvSMiSygR4nxGAbCOyo8CvAgI9n0evGXWwh68kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769329; c=relaxed/simple;
	bh=1DJ+B69A/sS9fC2YpOVw5kgpDni4GKhZL5Zha6AYYNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ymfhxz8FC0VT4XkPc6ZuwmYZ6ZytuODNsGwrzNWZRDOmE9j/YahGDPPl2HOfnwSjsWqodK8nKdCnsaOMVr8Wit/KLMTrOuKhBdXAQYUGHepD3ZOn/ZNWGZurZZ9izCt+IBbL+hLP4Ho9ZRTNYB+OSeL7KVv49SPHYKuDMyuI7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZckvB1Zrrz1d16k;
	Wed, 16 Apr 2025 10:07:50 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9552D1402DA;
	Wed, 16 Apr 2025 10:08:39 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Apr 2025 10:08:37 +0800
Received: from localhost.localdomain (10.90.30.45) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Apr 2025 10:08:37 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <james.clark@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<leo.yan@arm.com>, <john.g.garry@oracle.com>, <will@kernel.org>,
	<mike.leach@linaro.org>, <yangyicong@hisilicon.com>,
	<jonathan.cameron@huawei.com>
CC: <linuxarm@huawei.com>, <hejunhao3@huawei.com>
Subject: [PATCH 2/2] MAINTAINERS: Add hisilicon pmu json events under its entry
Date: Wed, 16 Apr 2025 10:02:16 +0800
Message-ID: <20250416020216.3377959-3-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250416020216.3377959-1-hejunhao3@huawei.com>
References: <20250416020216.3377959-1-hejunhao3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn500004.china.huawei.com (7.202.194.145)

The all hisilicon pmu json events were missing to be listed there.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00ff21b955bc..bf9588a94919 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10474,6 +10474,7 @@ W:	http://www.hisilicon.com
 F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst
 F:	Documentation/admin-guide/perf/hisi-pmu.rst
 F:	drivers/perf/hisilicon
+F:	tools/perf/pmu-events/arch/arm64/hisilicon/
 
 HISILICON PTT DRIVER
 M:	Yicong Yang <yangyicong@hisilicon.com>
-- 
2.33.0


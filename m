Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486D2686B3;
	Fri, 18 Apr 2025 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744960481; cv=none; b=Fm1SXyx18KzfsSlh0dWGJgARvVAdgoPm6eovN1P+3VI0WrFzffzwALXpucsooIgjNGAdqU/ifKzyrLRbBi0UQFH/lCzGWJ3ArsB0AmeQwTR4sweY8ICZ0eZOg1brzZ+clV4BAKyubjUnbRLMvYNQwsoKRVpKU6Xs5NAh+OG4bQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744960481; c=relaxed/simple;
	bh=hhYYkzz8KsNbp9pRtELlB+zhwZN+CrJrfx5tX8l+r/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R53sdQ2KtFfbk1oOhJ54sHiz5bsi8A5sXNgHqafPPQUGtMQSh4h+PaVypvDaPoh3G1PJMKDUCiqFRBpUI5RZjq5uFcQskNA95ihG09KNolp4Reo9etuWlvvGV+QYzlDZ+CZ4Z4/gN2IWQnQ0ri7Hv2CBqKM/1EJN4TgNqEDx5Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Zf5c162nyzsSgH;
	Fri, 18 Apr 2025 15:14:25 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 8204C1A0190;
	Fri, 18 Apr 2025 15:14:36 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 15:14:36 +0800
Received: from localhost.localdomain (10.90.30.45) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 15:14:35 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <james.clark@linaro.org>, <leo.yan@arm.com>,
	<john.g.garry@oracle.com>, <will@kernel.org>, <mike.leach@linaro.org>,
	<yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <hejunhao3@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 3/3] MAINTAINERS: Add hisilicon pmu json events under its entry
Date: Fri, 18 Apr 2025 15:08:12 +0800
Message-ID: <20250418070812.3771441-4-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250418070812.3771441-1-hejunhao3@huawei.com>
References: <20250418070812.3771441-1-hejunhao3@huawei.com>
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
Reviewed-by: James Clark <james.clark@linaro.org>
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


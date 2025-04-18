Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A825211460;
	Fri, 18 Apr 2025 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744960480; cv=none; b=NOO3P7PNSBrouGfDXzWQgua6Jtmj7s2HgBSq0zamdS1a5dICiMXUwDdCcq73b6Dl1BLmj9tUkfVVDb22PuuuVRZioziWVDpSi1vC5aQ1ajXMOCTgq0hT6bhUDZjoYruWaFAsOM9i7vFH6lgXbWAG1hfCjTk37yc+U2f2BzvKIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744960480; c=relaxed/simple;
	bh=73Ej3bQ6VAuYzOOdWfwhXB+DTMiSF9Ozf6blmvRLeys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kqZ3z4nkqVi2pIptZB5DX1HMBzlL9WnCKagOVLBLN/CammE20M4WP1jV7UqBCqbRJW4+dYvm8ANiDCeCpa9KouxYvCmbXZJHqxEk2N3l9sx9XwzbLmRx28qRh7IEC2rNxhRs/5PmkwBHDnVqLawHg6xNE+dmnKjD4dwUdCsJFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Zf5Wn1BJRz5vM7;
	Fri, 18 Apr 2025 15:10:45 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 403F1180B51;
	Fri, 18 Apr 2025 15:14:34 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 15:14:34 +0800
Received: from localhost.localdomain (10.90.30.45) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 15:14:33 +0800
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
Subject: [PATCH v2 0/3] perf vendor events arm64: Do some cleanup for Hisi hip08 json
Date: Fri, 18 Apr 2025 15:08:09 +0800
Message-ID: <20250418070812.3771441-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.30.0
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

Add missing field for Hisi hip08 json and list hisilicon pmu json
events under the its entry to MAINTAINERS.

Changes in v2:
- drop this PublicDescription addressed James's comment
- fix commit of patch 2
- add new patch to drop other hip08 uncore PMU PublicDescriptions

Junhao He (3):
  perf vendor events arm64: Fill up Desc field for Hisi hip08 hha pmu
  perf vendor events arm64: Drop hip08 PublicDescription if same as
    BriefDescription
  MAINTAINERS: Add hisilicon pmu json events under its entry

 MAINTAINERS                                   |  1 +
 .../arm64/hisilicon/hip08/uncore-ddrc.json    |  8 ------
 .../arm64/hisilicon/hip08/uncore-hha.json     | 26 ++++++++++++-------
 .../arm64/hisilicon/hip08/uncore-l3c.json     | 13 ----------
 4 files changed, 17 insertions(+), 31 deletions(-)

-- 
2.33.0


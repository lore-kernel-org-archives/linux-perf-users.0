Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D815E96;
	Wed, 16 Apr 2025 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769321; cv=none; b=OS2qQJlK7Lky+Ltry3yMGH54mGl0XkUNFhmO96q93F+CoRQRusZiAhF7k4HmioD6ElRwbAyPJhQCttXP+i6K63t1E8FVMJcfuftaagT/F5wPbJcSxy2jgKgahX0jYovnmknYB73eSsZlQXmJ7tdbFlfFpCo/feWr2TKIEzN0ZP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769321; c=relaxed/simple;
	bh=qR6lA/y5DDnN0ipNgt3BbT8hrUfGqg7N34Og8kjE3dw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P8OAMW94HeyoXNTnIBUG7T9tFkso3b3a3QAuc1H3j9Mb5jo7z2M/IkdfoJ/c3M7w5gliuuwFjDrU4fF1y+G44AnqVCR3pLSFuSZwcZiImrZEUDMjj4uuWIqFJuglbRpnoZzcQmWpvHdKO25rf9izU3yUhLjqcd0cMZLoamCiR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Zckwt4jfrz27hQ2;
	Wed, 16 Apr 2025 10:09:18 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D904B1402C7;
	Wed, 16 Apr 2025 10:08:36 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Apr 2025 10:08:36 +0800
Received: from localhost.localdomain (10.90.30.45) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Apr 2025 10:08:35 +0800
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
Subject: [PATCH 0/2] perf vendor events arm64: Add some missing content for Hisi hip08 json
Date: Wed, 16 Apr 2025 10:02:14 +0800
Message-ID: <20250416020216.3377959-1-hejunhao3@huawei.com>
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

Junhao He (2):
  perf vendor events arm64: Fill up Desc field for Hisi hip08 hha pmu
  MAINTAINERS: Add hisilicon pmu json events under its entry

 MAINTAINERS                                   |  1 +
 .../arm64/hisilicon/hip08/uncore-hha.json     | 32 +++++++++++++++++++
 2 files changed, 33 insertions(+)

-- 
2.33.0


Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B1033CEA9;
	Thu,  7 May 2026 06:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135877; cv=none; b=tSAmsHO7X4qa1grkuWwyiSQrij1et7any6U5m7g/C6OK40/JN+yCeuPE+bGth5MMWU3Vj7BnqtKFjBzP8Do2keiMyqdmT+4Sb6QIZZjDoPm/4Cen204eo0uqGCVM7SYAa4O/X0n3J4xm/8aNgXmWESK3Siz/JqeMzL0YCMVWwHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135877; c=relaxed/simple;
	bh=q6OkRdzLG4KekcM1Oi9hSQ1rdfNRo5m8Ds0bfJicBIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzE0bU2ecfm8RSvCQgUDd3uGbkqW6BdWJ/4/FQXw2rPMjEXi7+KYwi1PlOwq4jG1KDC3D5ifG50aSViIrhm7dvR5sBpjpU7cCoh0wZsac8eEjMdhPpfniombYWFXmNSVC5CzzMbIX1OgBsmX9B7g2Q6KRuPpT45NaDcu3WlADDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4m+577lW; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4m+577lW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GGcKzy66/ad1dSIdtq5qJ/h9XgDG1eOVLqadNHxudqA=;
	b=4m+577lWR5gkOuN+DcEO0u76lmZh/FEg8XWwUCRBNLHe3+Fkr/jMFI6wBZjVxuRGyEGEV2i0y
	t11UmY0UQkaKwhTFfRv8DLGWCArHAYNvBzyy9woAwTdNzaskAC3aEvMaCyF9FrRjvWKE8ie5vZ8
	mwEIJATP2BBh0h+2CzcX2co=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gB2SB1sn7znTV5;
	Thu,  7 May 2026 14:30:34 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 89E5F402AB;
	Thu,  7 May 2026 14:37:40 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 14:37:40 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 14:37:39 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@arm.com>,
	<john.g.garry@oracle.com>, <will@kernel.org>, <mike.leach@arm.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <jic23@kernel.org>, <leo.yan@linux.dev>, <robin.murphy@arm.com>,
	<linuxarm@huawei.com>, <hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [RFT PATCH v2 3/7] perf-x86: iostat: Move iostat arch-specific implementation to util
Date: Thu, 7 May 2026 14:37:33 +0800
Message-ID: <20260507063737.3542950-4-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260507063737.3542950-1-wangyushan12@huawei.com>
References: <20260507063737.3542950-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100008.china.huawei.com (7.202.194.111)

To support cross-platform iostat capabilities, like record/report on
different platforms, architecture-specific implementation of iostat
should be moved out of arch directory to get built. Build scripts are
changed accordingly.

Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 tools/perf/arch/x86/util/Build                           | 1 -
 tools/perf/util/Build                                    | 1 +
 tools/perf/{arch/x86/util/iostat.c => util/x86-iostat.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/{arch/x86/util/iostat.c => util/x86-iostat.c} (100%)

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index b94c91984c66..358541beaa0f 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -7,7 +7,6 @@ perf-util-y += event.o
 perf-util-y += evlist.o
 perf-util-y += mem-events.o
 perf-util-y += evsel.o
-perf-util-y += iostat.o
 
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 70cc91d00804..c7e5ada3800d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -127,6 +127,7 @@ perf-util-y += thread-stack.o
 perf-util-y += spark.o
 perf-util-y += topdown.o
 perf-util-y += iostat.o
+perf-util-y += x86-iostat.o
 perf-util-y += stream.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-util-y += kvm-stat-arch/
diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/util/x86-iostat.c
similarity index 100%
rename from tools/perf/arch/x86/util/iostat.c
rename to tools/perf/util/x86-iostat.c
-- 
2.33.0


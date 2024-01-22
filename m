Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53AA20DE8
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910913; cv=none; b=rG98Wyvm9rEEygdCErpq2fOIrSj59awVRGmvujDRE8Gh3PhGGubjF08WGKeS7xzezJmJwQoBQx4E9yABTjoD0IIQvqiy3vvQDkNUjB7n/MeHMBMuD/OiE+HGotpUG/z1fnfRh2MqhdDeArbNtcnS19J7/f3fKf9ouGEaOlYrVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910913; c=relaxed/simple;
	bh=Vh8E3DZxmiDKvZseKvJCT2wSpgW/IY+P80/oK0T9oj4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AK/S7jU9hMYlJ0R/6l9ImvgZV7b1nc//7rpjupc3qa9Vg7ZZw1yRFjySEcuZcRsOBuCiOAng9UAocg70IGrA7DJG5Y7sibUqWs4+5HuByR8Ew4FFsZcBixByCHbX5ujXu8J0NpiPywOI+EZS11QZDttsyO+G/ikutXlGSxnoY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TJNB21l2Lz1xmXD;
	Mon, 22 Jan 2024 16:07:38 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A4A31A0176;
	Mon, 22 Jan 2024 16:08:13 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 16:08:04 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <peterz@infradead.org>,
	<irogers@google.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<linux-perf-users@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <hejunhao3@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH] perf build: Make minimal shellcheck version to v0.6.0
Date: Mon, 22 Jan 2024 16:04:06 +0800
Message-ID: <20240122080406.28678-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)

From: Yicong Yang <yangyicong@hisilicon.com>

perf build failed due to the shellcheck on my machine (v0.4.6 on Ubuntu
18.04.1 LTS) doesn't support -a/--check-sourced and -S/--severity option.
These two options are introduced in shellcheck v0.4.7 and v0.6.0
respectively. So restrict the minimal version of shellcheck to v0.6.0.

Fixes: b809fc656e76 ("perf build: Shellcheck support for OUTPUT directory")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/perf/Makefile.perf | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 27e7c478880f..f8774a9b1377 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -236,6 +236,16 @@ else
   SHELLCHECK := $(shell which shellcheck 2> /dev/null)
 endif
 
+# shellcheck is using in tools/perf/tests/Build with option -a/--check-sourced (
+# introduced in v0.4.7) and -S/--severity (introduced in v0.6.0). So make the
+# minimal shellcheck version as v0.6.0.
+ifneq ($(SHELLCHECK),)
+  ifeq ($(shell expr $(shell $(SHELLCHECK) --version | grep version: | \
+        sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< 060), 1)
+    SHELLCHECK :=
+  endif
+endif
+
 export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
 export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK
 
-- 
2.24.0


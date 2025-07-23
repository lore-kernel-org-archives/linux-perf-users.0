Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19B2E36F8;
	Wed, 23 Jul 2025 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254274; cv=none; b=jRgtqbMRQ/aZyJ4JAVESR/rQiBW8HnPGZPzE4uEqAAcO2pfyRMKPq8bFEJZd+Vh1Xt2M1xQmKgLj316FZqf4iIMSljkEBwE0dIeRyKwCvNhv0xaBWm9KRSyEstE2wKDR8Nu59loE59Ra7Fe4es2mUm7Bffn5guUagdoLOSnDymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254274; c=relaxed/simple;
	bh=Mk6pcmOIYFhzCJbSpMEQIoKkluMqL5X0GT5YKhI94kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsV0UDT5Ldmsr9qybj6EPng1qdO68Wkw3aLBREaJnTo+FdRhcr8vCBJE0BTxlFrisAGJOFFiAmXsFUj1CIHOnKKmWfFrimWl/y1yO2HeQrnuA4QZJSbhqPN8F0SQGcuK7NyP/a5BtEMrSZ0y1HJb+1aDcZPu8b4ep9JLcfwafw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SarAQenZ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SarAQenZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753254261; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FFERm/47OcF63OLXk2lK+CyyGhbbyijy+wVFJ8YJd4M=;
	b=SarAQenZMlF0qqH2acF3Sk6PNn7ucqsZvI1GDwUBlhxx+LyWPE6x2cbMIJ5tpTx8f3WHFf9ftuOYnP2PgliAFTF+CF1PzfK6jUijfgqsLW8QtMgLJ4bEOtTafTnA3vrrOnxFLdWK0VSvhBDwOcEu9/gtpq37sj2f3GLm1TLWDHo=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Wjb7KTd_1753254260 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Jul 2025 15:04:20 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: namhyung@kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] perf stat: Remove duplicated include in stat-shadow.c
Date: Wed, 23 Jul 2025 15:04:18 +0800
Message-ID: <20250723070418.2195172-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files rblist.h is included twice in stat-shadow.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22933
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/perf/util/stat-shadow.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 2b4950f56fae..abaf6b579bfc 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -15,7 +15,6 @@
 #include <linux/zalloc.h>
 #include "iostat.h"
 #include "util/hashmap.h"
-#include "rblist.h"
 #include "tool_pmu.h"
 
 struct stats walltime_nsecs_stats;
-- 
2.43.5


Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BD927FB35;
	Thu, 26 Feb 2026 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772108573; cv=none; b=acCil1mJ7j7VV0vaksS7LFxjAQHT17HpT858yM+T5tPyVTdpIoicivoHjYKmXzB2OVMLByuEoe1xKW3H6Lf3vyMxR+XANGxWZChXv2i+LgIIeKek5EB7ru6maGzSDn+rYyO8+MJVXt3OwEZsTPQs6P9nYtoLSUfKOU5JOJDEF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772108573; c=relaxed/simple;
	bh=leFjjgyHJQwcIa/rNmsjm+SdUgbnyXj0TY2/3hcmhHs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lA6/F8Z85vjsfBygVwwxXV1SlIIiyWku/wecZtRDIwbAgousLyU4/uZv00zZLqRjtZx5yRhOoohBz1p47Bmz+A89zevKTMsdAK45JUxjOaIdtmoI14zZ7otCQqDT2/ecLaPaJ5xb81jX9U3sWFLYoTggv2SwqKcS83r/skJQ/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fM9ZZ3GGbz1YHN2w;
	Thu, 26 Feb 2026 20:22:30 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fM9ZW3HPKz1YHN2w;
	Thu, 26 Feb 2026 20:22:27 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id AEBC230A6425;
	Thu, 26 Feb 2026 20:21:28 +0800 (CST)
Received: from BJ-HV00147.Hygon.cn (172.18.22.73) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 26 Feb
 2026 20:22:24 +0800
From: <wangguangju@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@linaro.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	wangguangju <wangguangju@hygon.cn>
Subject: [PATCH] perf trace: Fix IS_ERR() vs NULL check bug
Date: Thu, 26 Feb 2026 20:22:08 +0800
Message-ID: <20260226122208.162765-1-wangguangju@hygon.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

From: wangguangju <wangguangju@hygon.cn>

The alloc_syscall_stats() function always returns an error pointer
(ERR_PTR) on failure.

So replace NULL check with IS_ERR() check after calling
delete_syscall_stats() function.

Signed-off-by: wangguangju <wangguangju@hygon.cn>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 311d9da9896a..295b272c6c29 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1573,7 +1573,7 @@ static void delete_syscall_stats(struct hashmap *syscall_stats)
 	struct hashmap_entry *pos;
 	size_t bkt;
 
-	if (syscall_stats == NULL)
+	if (IS_ERR(syscall_stats))
 		return;
 
 	hashmap__for_each_entry(syscall_stats, pos, bkt)
-- 
2.43.0



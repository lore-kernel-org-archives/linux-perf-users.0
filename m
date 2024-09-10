Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA759167;
	Tue, 10 Sep 2024 00:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929730; cv=none; b=qoe/o/4ceUGK+bRaCfN2oqD0dmEhdP/e+466X786PBdQr70Zhi4KWljlwFIgvEHyk+lpFuUuDz8yA/qlE20RcQNOsQzQKVgwrRNBzI3LnK1R60LcNTOnW5gLtyfHjgEIA3Y0GdBbDrfRhWd8nYuPBzw628Iz/WJQTztUxGe0zn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929730; c=relaxed/simple;
	bh=0ahhAY5GVfOCMe7f6GF5sqzP9cnBFhB4+lhYpncmJVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D6YfFzbzGSrp1jd02QJFdLeOII5YKIN5FeqIxDGufwVtKgiYew7vXgf8TfIDaDBeEC/wTBtt9nWqyMBinR47gez6hmOzA2zORzJBwWfgbQZhHibV7HfgbDjPtWJ5iLZS1JPvPe0AKkDw8IArp8IUddiPopRtpq6btgC+0UIvVk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vCXGel6+; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vCXGel6+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725929725; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rO6Mhttmn/yg+VpApywInkqxijJJX6s/sf/Qqug6+sk=;
	b=vCXGel6+jGKzOaJgbrGIU9iwCWXiA5S21U/ZlyQgjqVTLVOqX8eOJsoR9gkTs3Z+Bnk8FnZSq6EGpeBH7tCdH8IDn9/ZQjI7tqlSBhAYgNBT1etrU43ezn04pOk1hcuivbZseqxaAxUDwXV39Q/6QjFObycsBzjR/X2lI99lhhQ=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WEhmt09_1725929724)
          by smtp.aliyun-inc.com;
          Tue, 10 Sep 2024 08:55:25 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] perf parse-events: Remove duplicated include in parse-events.c
Date: Tue, 10 Sep 2024 08:55:22 +0800
Message-Id: <20240910005522.35994-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files parse-events.h is included twice in parse-events.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=10822
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/perf/tests/parse-events.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 639e65a9bf61..e228511c85a5 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -5,7 +5,6 @@
 #include <api/fs/fs.h>
 #include "tests.h"
 #include "debug.h"
-#include "parse-events.h"
 #include "pmu.h"
 #include "pmus.h"
 #include <dirent.h>
-- 
2.32.0.3.g01195cf9f


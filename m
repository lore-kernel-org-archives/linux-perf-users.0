Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C63F9278;
	Tue, 14 Jul 2026 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017955; cv=none; b=sNc3p3vOvnQHtn5WWx8J7LM14p0nWxIIOWo6pXyBImuIRUPVWsgQg0qJv9dPtKsJ4QmpLxc7SGYFxHOKZnRYsAwVUaYqLqCk0+/0B40TJHnc8Gxc/rgmqMpOC/4/S1OVaGBGr1yXS+6tX+bQoT+fOd/SsKjkc/icChrFpzOuX3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017955; c=relaxed/simple;
	bh=GwHOpumLhMwk0ARYY2IZ1JDcPM60D4qF/lTFq65fo6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OsgwO1zmSo8I9eriGEg6IDIWt18EMJ2fH2yrbRTSbU5Z1g+dL8gnln17GdcG+ko1VUUemFLEBdOxPSI+2CWYgZW10qd96FyQmgo7/DoGPn3s3EdfkjKPGgmhWhQWww8EkCx362b+/AUv3Y+2zMdMH6z4tyY2XFb2dmzwIPyA3w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3F9sL9FVqSswqGA--.1573S2;
	Tue, 14 Jul 2026 16:32:11 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: acme@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	leo.yan@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] perf test: Remove duplicate include of util/term.h
Date: Tue, 14 Jul 2026 16:28:10 +0800
Message-Id: <20260714082810.3660091-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3F9sL9FVqSswqGA--.1573S2
X-Coremail-Antispam: 1UD129KBjvdXoWrXw18Ww15XFWDAF43KF47twb_yoWxGFb_u3
	WxGFnFgFyUAr9rtFWfZas5AF10gw4fXr4kuFs09wnxtFyDJ3Z0qa98Jr1DGF1Yg3s5JF92
	qa1kCrWUCa13WjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUrrWFUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove duplicate inclusion of util/term.h in builtin-test.c to clean up
redundant code.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/perf/tests/builtin-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7d18cb6021d3..41dcfbf874f0 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -15,7 +15,6 @@
 #include <string.h>
 
 #include <dirent.h>
-#include "util/term.h"
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
-- 
2.25.1


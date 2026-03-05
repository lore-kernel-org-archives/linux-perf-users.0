Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5F5BA21;
	Thu,  5 Mar 2026 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677107; cv=none; b=YBG81fVs68hDxLxkI0+kT17q3ppq7Ki4KvhftDm2qPl3SI/Q+2cqp0SE4Nhrla4CK5/vEg6MsrH6pVwvRqVF2sTawtAdLVKSGhw4dhYG4i2xz2ta3fSsmbhX37HQ7tFuFl8tCEbFgiP/upH+mYff5bDPWLHGi1RdufZOFRqb7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677107; c=relaxed/simple;
	bh=6LpMEPifz5AQLpc5oOcMsi03zesiXvTRC7A8wJyuzCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mICoxtRMEjxcwrbuPyWtF2yblvhu18DgXL+KUhtNIRuHg+gqKrGV/yingcLUU0NpW5KNi2NqXGZSrlO6BDRQL38Qs7XoVjsPQzHLdactiDyks4Fyn6k2tU1ApJIUvTzf5sWvbKdUulpetJahu32HUiyKRFnhuWNQ/2UjIaxEu1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADndgrZ56hpPkCsCQ--.16695S2;
	Thu, 05 Mar 2026 10:18:01 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: namhyung@kernel.org,
	acme@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] perf annotate: Fix NULL vs IS_ERR() check in annotated_source__alloc_histograms()
Date: Thu,  5 Mar 2026 10:17:21 +0800
Message-Id: <20260305021721.593803-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADndgrZ56hpPkCsCQ--.16695S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1rCryfWw47CFyftFykAFb_yoWDZFc_Cw
	1IqF4jg34UCryDtF9ruFZxXa4SgF45XrW0qr9YkwnrGFZrJ3yUWa93XrZ5Cr43Kas8KFnr
	Aas5GrW7urWY9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbLFxUUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

The hashmap__new() function never returns NULL, it returns error
pointers. Fix the error checking to match.

Fixes: d3e7cad6f36d ("perf annotate: Add a hashmap for symbol histogram")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/perf/util/annotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2e3522905046..64ab5c36ac02 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -44,6 +44,7 @@
 #include "strbuf.h"
 #include <regex.h>
 #include <linux/bitops.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
@@ -137,7 +138,7 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
 		return -1;
 
 	src->samples = hashmap__new(sym_hist_hash, sym_hist_equal, NULL);
-	if (src->samples == NULL)
+	if (IS_ERR(src->samples))
 		zfree(&src->histograms);
 
 	return src->histograms ? 0 : -1;
-- 
2.25.1


Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F622424C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 04:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773806771; cv=none; b=Uwy0AjofyP8QKiM3iZbNq8rh18ev27MdhH4Mv8QdvUt6K0qcqGnLKPp3dfaZBhEYrI7qz3Uo27HT+N21lP+kR1/7Mz71UXMHf6I1Kl3p3d8oey7KZv75EEIgMmwZ1F9FtVEhxsTFNG8V2xhEe1J7lqY3nI/W6raC5fbJ+8e0flo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773806771; c=relaxed/simple;
	bh=7oCXCbNFmtMAXuWdrC8TAbjM+2n4GIRNOg4u4NwAHk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KdofbHLFKTesYcYvNbnw86+ZP1aYdWD8X10C8sJ76WFgp9J0Re/6/Ii5QIfgaa/ZkdM6Zp/F7vPK9EK1F7V1PWO55ltvB/1caJz2oit9LS3wJvN8kUxdgz4LpJJmW/EOTO/2DiThYCB5eMWrP0jOQqJwMYuEmDV5sAZPkl/BgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABXZ86VJLppyFP8Cg--.31997S2;
	Wed, 18 Mar 2026 12:05:41 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] perf symbol: Remove duplicate include of debug.h
Date: Wed, 18 Mar 2026 12:04:22 +0800
Message-Id: <20260318040422.398996-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXZ86VJLppyFP8Cg--.31997S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYA7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2js
	IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxAqzx
	v26xkF7I0En4kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb38n5UU
	UUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove duplicate inclusion of debug.h in symbol.c to clean up redundant
code.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/perf/util/symbol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index bd811b2b7890..ce9195717f44 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -26,7 +26,6 @@
 #include "demangle-rust-v0.h"
 #include "dso.h"
 #include "util.h" // lsdir()
-#include "debug.h"
 #include "event.h"
 #include "machine.h"
 #include "map.h"
-- 
2.25.1


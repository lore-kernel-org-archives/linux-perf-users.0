Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5D7263B;
	Thu,  5 Mar 2026 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677522; cv=none; b=Jua8cRxtxp3OaduaK6dnvy6PyfGxjGyty9GI7/u6DfhUaqr9Tl7nYDH93XeVhp4pVhZ3cRFfxDvE9COvRittJWWE7AMlOMeyq3uUzbnJ+VROlEOraoirv9HbqbpoLBf25lutm51Mh2Yfc5trqJYLZ7LVXLFk7Lv3ZrG7b8+wi7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677522; c=relaxed/simple;
	bh=Ap8MyJHiTjP2rcTPDWL2AVzqYdNfcDustxzWkb41dNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U/Z8+3Mb/WtzoMNj5fc8Ot3qzJCW0uCas7fuFmYLrnaq034hlPGVXIyfHqH9tIjNn4IZLiTX4G+KluH2QLiTAHh3le1jhVxqCNkbxySBvWCpGapHVUv2SQRBrp4f2irGVT5IkI/l/x5fgVVfSCkgMxvowUgU8egNs18IWacMwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACHFwt+6ahprlKsCQ--.4891S2;
	Thu, 05 Mar 2026 10:25:02 +0800 (CST)
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
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] perf ftrace: Fix NULL vs IS_ERR() check in prepare_func_profile()
Date: Thu,  5 Mar 2026 10:23:08 +0800
Message-Id: <20260305022308.593869-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHFwt+6ahprlKsCQ--.4891S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1rCryfAr45CF13WrW5GFg_yoWDXFg_u3
	4xGw4Ig34UC3s7twn3AF95Aw10q3ZxXr4UXanYgw13Xa4DJ390gFnrWr98Cr4a9a9FqF12
	9F1furWDGr43CjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUC2NNUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

The hashmap__new() function never returns NULL, it returns error
pointers. Fix the error checking to match.

Fixes: 0f223813edd0 ("perf ftrace: Add 'profile' command")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/perf/builtin-ftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 6b6eec65f93f..9e7e81a08606 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -18,6 +18,7 @@
 #include <poll.h>
 #include <ctype.h>
 #include <linux/capability.h>
+#include <linux/err.h>
 #include <linux/string.h>
 #include <sys/stat.h>
 
@@ -1209,7 +1210,7 @@ static int prepare_func_profile(struct perf_ftrace *ftrace)
 	ftrace->graph_verbose = 0;
 
 	ftrace->profile_hash = hashmap__new(profile_hash, profile_equal, NULL);
-	if (ftrace->profile_hash == NULL)
+	if (IS_ERR(ftrace->profile_hash))
 		return -ENOMEM;
 
 	return 0;
-- 
2.25.1


Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B94C74;
	Tue, 16 Jul 2024 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116532; cv=none; b=b3DSxerzS1cVChCj6e39LiJ/vB1O5l7T58O2NBobjWaCQAV8Bc71jsdWJ9gJMm2dQ3is8oOhcMvT7XxucXUpd6kz2sDmyAW7xw/F3KMmJgYeD2RfoAy84bI+ATR9KHxjTIcXYJ0E5t0LRq7QYG2b2qVwm1ijdb8A3zazXb4YeRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116532; c=relaxed/simple;
	bh=1w/t3Enj+agqwPfSNzEYS6I1cisuuk5fmCmz/ssryDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GVdzERXNaJcpYzd7ubQrNBmBew4cnwST6s9TIfjz2QNkGkwQl+9jmMWAkCWvAeH8UcoD+/2oODPG2UDJGbN/oXofnYX38fYfsSTYmbXXASqhHqrP8Kv7T7tuK0cIlToMbVWI1JkUpc1RYguZZbt25GV1syXAgrzW/6DF7h47O6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADX3+djJ5Zm_dOWAw--.54281S2;
	Tue, 16 Jul 2024 15:55:15 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] perf inject: Convert comma to semicolon
Date: Tue, 16 Jul 2024 15:53:47 +0800
Message-Id: <20240716075347.969041-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADX3+djJ5Zm_dOWAw--.54281S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZrWfCr4rZw43JrWDArb_yoWfAwb_X3
	Z7XFn2vFZ8CrZrtFnrZ3y5XFWUJa95Ga4UZr4kGr1UXrW7Aw4qqFWxuryDC3ZxKryUtr9I
	qFs5Gw4Utr48ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd5rcUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Fixes: 97406a7e4fa6 ("perf inject: Add support for injecting guest sideband events")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/perf/builtin-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a212678d47be..7b4a5d56d279 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2069,7 +2069,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		 */
 		inject->tool.finished_init	= host__finished_init;
 		/* Obey finished round ordering */
-		inject->tool.finished_round	= host__finished_round,
+		inject->tool.finished_round	= host__finished_round;
 		/* Keep track of which CPU a VCPU is runnng on */
 		inject->tool.context_switch	= host__context_switch;
 		/*
-- 
2.25.1


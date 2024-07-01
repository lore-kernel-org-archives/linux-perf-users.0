Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DA11863E;
	Mon,  1 Jul 2024 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719805455; cv=none; b=e4cq0IP2xdxk1KALaT8xuE/5dWcLuyzkRRcgvl1YeKqo1n1kSkvPPATG1zqpjOMpNwQE+DwMbP1wvFIxMKD61eq3XQAL4ixeCwWVeXytJBQHGIw3ZG1LPvHnf3gyW3q4j62arKzbG/rwU1+4n3teFsIkJplmw5ZbMTLiQAW6nC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719805455; c=relaxed/simple;
	bh=EmN0HyErxUi/t88ya0Y2EFToqI7LudU60sxfOsCokjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D1kZLw8CiE/lfl6PijzVKPEVUI97GC50tAV4uqBSpzujYY/Rh1ithJ+p26PPzj8JHrpd3JJwwNvnJIMGiR+yKJ7qW2ccrz4Duikr///h/DU11t07RNc6rg9G8cQdsWFUCEtrOXmpDewtfPOhrkWUbtOUjKQKd+4yVwRMpxqusfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowACHtFXsJYJmN8rwAA--.5579S2;
	Mon, 01 Jul 2024 11:43:40 +0800 (CST)
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
	kan.liang@linux.intel.com,
	james.clark@arm.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] perf pmu: Remove unneeded semicolon
Date: Mon,  1 Jul 2024 11:43:00 +0800
Message-Id: <20240701034300.558886-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHtFXsJYJmN8rwAA--.5579S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFW5Jw4xZr47Jw1DWw4kWFg_yoW3GFc_W3
	Z7KFZIyr18JF95K3W7ArWrZFyrArW3uay8KFWqkr45GF4DJr4UXr4F9w4DAFy5Kw4qkFy7
	K34rAFyUXrWakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUb2g4DUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unneeded semicolon.
This is detected by coccinelle.

Fixes: d9c5f5f94c2d ("perf pmu: Count sys and cpuid JSON events separately")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c94a91645b21..884eb23445e4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1773,7 +1773,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 	size_t nr;
 
 	pmu_aliases_parse(pmu);
-	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;;
+	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
 
 	if (pmu->cpu_aliases_added)
 		 nr += pmu->cpu_json_aliases;
-- 
2.25.1


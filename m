Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E044FECCC;
	Thu, 17 Sep 2026 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649905; cv=none; b=I8Mb++pOCfSsZcElZeZzkcu30iizIPk/Y6xMtkzyGRm2YiDE1qp8TdI2Wc7gRFvcz5IsqjE4ShdraDKUwqCwDh2Ff9KOdCJcjUyjgxewzxUeo6V5A9dPFXMvgr1GKvqE3QxQSTct+byBKkYSvfIwN1E8C5fWYCWHTHqnbyhoJRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649905; c=relaxed/simple;
	bh=OGzk8wjM60Wwj+FAun71fA5/O9kO8ATMa04vDG1JPCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lb97aSt81f6T9B2eJgDWVVNqvjRrVbzsOUSwK74tGf9wq05tBphTpFwIgISoqELRSCMYT+gcYp/4WDXc1y+6PyN8Xzf/gfCHlgyKru5PxvjhLAdSdq1gFeCNmImdduDaHDMsuyO36GmQhW8eIuTUDly+Xrgf4xcyqGl2ioMnC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hlwlp0SczzKHMpp;
	Thu, 17 Sep 2026 20:57:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1E9464056E;
	Thu, 17 Sep 2026 20:58:14 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBXzvjc46tqZzyKAg--.25951S2;
	Thu, 17 Sep 2026 20:58:13 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH] perf llvm: Fix memory leak of args->fileloc in symbol__disassemble_llvm()
Date: Thu, 17 Sep 2026 12:58:02 +0000
Message-Id: <20260917125802.1198419-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXzvjc46tqZzyKAg--.25951S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyUZFyfKF1rtw1Dtry3twb_yoWDZwc_Gr
	1IgFWjyrWUGrZ7ta1I9r45JryIgFnYqryxZF4agF47Ar9rJFWDWFsxZF95AF45GwsIg3sx
	Jwn7Zr1UZw42kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb68YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIE
	c7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5Mx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRNksq3UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

In symbol__disassemble_llvm(), after calling llvm_addr2line(), if the
subsequent disasm_line__new() fails, the code directly jumps to 'err'
without freeing args->fileloc, leading to a memory leak.

Fix this by explicitly calling free(args->fileloc) before jumping to
the error handling path when disasm_line__new() fails.

Fixes: 048856817888 ("perf annotate: LLVM-based disassembler")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/llvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index a0deb742a733..dc66f6cc1db6 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -254,8 +254,10 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 			       (unsigned int *)&args->line_nr, false, NULL);
 
 		dl = disasm_line__new(args);
-		if (dl == NULL)
+		if (dl == NULL) {
+			free(args->fileloc);
 			goto err;
+		}
 
 		annotation_line__add(&dl->al, &notes->src->source);
 
-- 
2.34.1


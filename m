Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1215746E;
	Tue, 30 Jul 2024 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320588; cv=none; b=Zd7Ziv6qsWUdYiGy4Qse4osoKvdJg6srsZv0l/tdgyuWQSSk5qgtlUx4AVpFkcDemjuR/qCTSIuYUWeOFfBpQv3vcOWYskOsA8ZiDzZpMxc6W9mQmMt5V6+AJrfYgCZLAbZ1+UfD5yVUOlK7elxxEhQEUq0LPKWqAHnTmmz1+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320588; c=relaxed/simple;
	bh=5PwJ4fWAgb3Upnlv4Cxpup2BaJDWtHpU08Y6tlWHG2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgZSFmsotaSKfveoL3sv7pNyqo4ZlTuS3tolapxTTpSstTJOtcVRFpckeNyhnAIxo5MJWtr5VPG0lotRoEI+kerskKlCsLj6yHLdiXlj5FcTCnBcc+LxdxxFMP+mfTDNAHl/pvNze32CgntMBfC/i4PSREFPPt5gfAe4l9GE8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxyOnHhqhmFkUEAA--.14762S3;
	Tue, 30 Jul 2024 14:23:03 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxRuTGhqhmAhgGAA--.30579S3;
	Tue, 30 Jul 2024 14:23:03 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf tools: Fix wrong message when running "make JOBS=1"
Date: Tue, 30 Jul 2024 14:23:00 +0800
Message-ID: <20240730062301.23244-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240730062301.23244-1-yangtiezhu@loongson.cn>
References: <20240730062301.23244-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxRuTGhqhmAhgGAA--.30579S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GFy8Zr4DKF47Kw47Zw47GFX_yoWfKrXEga
	4xGFn2g345Xrsav3y7WrZ8AryFvFs3ua1kCws8Jr9rXFZYyan5tF1Dur4kZF45ursrtFW7
	Jr40gr15Jr47KosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU4OzVUUUUU

There is only one job when running "make JOBS=1", it should
print "sequential build" rather than "parallel build".

Before:

$ cd tools/perf && make JOBS=1
  BUILD:   Doing 'make -j1' parallel build

After:

$ cd tools/perf && make JOBS=1
  BUILD:   Doing 'make -j1' sequential build

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 75f3f6e0a231..816d5d84816b 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -51,8 +51,14 @@ else
   override DEBUG = 0
 endif
 
+ifeq ($(JOBS),1)
+  BUILD_TYPE := sequential
+else
+  BUILD_TYPE := parallel
+endif
+
 define print_msg
-  @printf '  BUILD:   Doing '\''make \033[33m-j'$(JOBS)'\033[m'\'' parallel build\n'
+  @printf '  BUILD:   Doing '\''make \033[33m-j'$(JOBS)'\033[m'\'' $(BUILD_TYPE) build\n'
 endef
 
 define make
-- 
2.42.0


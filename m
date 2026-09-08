Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6154854E;
	Tue,  8 Sep 2026 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872530; cv=none; b=ATHdPDl8cyBAoUQEN7N1IyRW15VyQ6jW+hp+OS8h5DAqD2682pvgEMaJDYN17rkbDp/kNDL8yQFQkluOMH+wruLUQDN9BwrnoAIIRivoQhbMcfOxJA//E+MiXoU41Ss62l5fd96p4ZAQRnhzoN3vp/XR99nf3yKySEaHGn95rpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872530; c=relaxed/simple;
	bh=082KIMFqE+/uvlHTdBvoMV9qFKfen+dk73/eqLUYMKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fCD9uMzkjikKcYzojab7SJIovcSiXy3ulmNhVqsKZ5yQsFm9r0/P88NGiyKZyjip2EEnxaXKBcSvGMwlIHomTLvUJqWkA5o5rP/bwp2kWxF4elKCDSWaT65MRN7SOaY+RllsRO8eh+5/Txyl7cjzF+SzzfYzOjTatu92YP2xEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hfPGS2CBpzKHN4d;
	Tue,  8 Sep 2026 21:01:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 99A554058D;
	Tue,  8 Sep 2026 21:01:53 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S7;
	Tue, 08 Sep 2026 21:01:53 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
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
Subject: [PATCH v5 05/26] perf annotate: Normalize arch__dwarf_regnum() error return values
Date: Tue,  8 Sep 2026 13:01:01 +0000
Message-Id: <20260908130122.633500-6-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908130122.633500-1-wutengda@huaweicloud.com>
References: <20260908130122.633500-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S7
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1rAr1kKw4xtFWDCFWkXrb_yoWfuFg_u3
	WxtF1Utr18JrZ7tasFkFyrCryxJFy5ZrWxGry7Ga47ZFyfGr17tFWqyrn5G3yrGayUtrnI
	yw1kXrWxZr429jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbQkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
	1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRepBfUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

arch__dwarf_regnum() returns inconsistent error values: early path
returns -1 while the main lookup returns -ENOENT/-EINVAL from
get_dwarf_regnum(). Callers only check for -1, so genuine failures
can slip through.

Normalize all failures to -1 to match the callers' expectation.

Suggested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index df70e95a8470..f3d17d153b67 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2492,7 +2492,7 @@ static int arch__dwarf_regnum(const struct arch *arch, const char *str)
 
 	reg = get_dwarf_regnum(regname, arch->id.e_machine, arch->id.e_flags);
 	free(regname);
-	return reg;
+	return reg < 0 ? -1 : reg;
 }
 
 /*
-- 
2.34.1


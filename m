Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD92FDC27;
	Wed,  1 Jul 2026 03:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878092; cv=none; b=LUB/Jb98DkCZSk4CAnWR4LnP9dCHIF3/0jrGwnGKq3OyAEVEzjXzknzhuTBQ/00zx+St6XBQkV6PCRMsCQz8heG0TjlnIFvxyMKFgPZQ4YsoUU42kA+45K+7J/NI8CGba1w9Jd9h6cNw0k9vEChEFN+MPFbfrpy62LARepaxtfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878092; c=relaxed/simple;
	bh=/rNSs9bLnzLwJMY5kCUzPfNPNIGc3IDwpcDfqFgsiPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWsIqUEciC/aN/xGJkjBPyBLwH40WKU52eeOQJ1I1faKC4ye4zt4ltsHOQ44T99hIVqion/bM57FUs7TXCcRpjFcmXZyZkZzQ/dh4z8upu1j0yLDNj+JF31eVRdSe97FrG0G5eP8Ds9CamhIFw8GZfu6blgs4cA8M2daWDLGRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqmMz5Z48zYQtmy;
	Wed,  1 Jul 2026 11:53:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A11BE4056D;
	Wed,  1 Jul 2026 11:54:45 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S9;
	Wed, 01 Jul 2026 11:54:45 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v3 07/21] perf annotate: Adapt arch__dwarf_regnum() for arm64
Date: Wed,  1 Jul 2026 03:53:41 +0000
Message-Id: <20260701035355.752944-8-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701035355.752944-1-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S9
X-Coremail-Antispam: 1UD129KBjvJXoW7ury3uw48Cr47ZF1DGF1Utrb_yoW8ur45pw
	47C343Jr18Cr4Fqw4fXFs3WFy3Gr1fAF15ur4kt3Z7Can7Wry8Ja1ftF1F9a13Jrs7Jr1j
	yr4jqw18WF13AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6x
	kF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0piPkusUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Currently, arch__dwarf_regnum() assumes that all architectures use a
register prefix character (e.g., '%' for x86) defined by
arch->objdump.register_char, and uses it to match register names in
objdump output. However, this assumption does not hold for arm64,
where assembly syntax uses bare register names like 'x0', 'w1'
without any prefix.

As a result, arm64 builds may fail to correctly recognize register
names from objdump disassembly, leading to incomplete or incorrect
annotation output.

To address this:

- Make the register prefix check optional, allowing architectures
  without a prefix character to be parsed correctly.

- Extend the delimiter set in strpbrk() to include the closing square
  bracket ']'. In arm64 assembly, memory operands often use bracketed
  syntax such as '[x1, #16]' or '[x2]'. Adding ']' ensures clean
  extraction of register names like 'x2' without trailing characters.

- Remove the 'static' qualifier from arch__dwarf_regnum() so that it
  can be reused by other architecture-specific profiling components
  in future changes.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 53b2a224b21d..ecd367582315 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2449,21 +2449,23 @@ int annotate_check_args(void)
 	return 0;
 }
 
-static int arch__dwarf_regnum(const struct arch *arch, const char *str)
+int arch__dwarf_regnum(const struct arch *arch, const char *str)
 {
-	const char *p;
+	const char *p = str;
 	char *regname, *q;
 	int reg;
 
-	p = strchr(str, arch->objdump.register_char);
-	if (p == NULL)
-		return -1;
+	if (arch->objdump.register_char) {
+		p = strchr(str, arch->objdump.register_char);
+		if (p == NULL)
+			return -1;
+	}
 
 	regname = strdup(p);
 	if (regname == NULL)
 		return -1;
 
-	q = strpbrk(regname, ",) ");
+	q = strpbrk(regname, ",)] ");
 	if (q)
 		*q = '\0';
 
-- 
2.34.1


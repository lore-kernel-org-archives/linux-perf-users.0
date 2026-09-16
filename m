Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE939184C;
	Wed, 16 Sep 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522222; cv=none; b=Fb7tFUe5MJbbBJJrLsXP52sihDcGMOBFLIZZ6MikwXlh9O8cRa9ZFeDo+WYiU7qtbrNGuvusxLTfyGAV3nn6O6PgSMgb8Pv8I/f59mTeSorYv+a8Ckg1CscFVvPCZovsCW6FQ6yx8pfyfxIoAaXzDe8euqxDcvCVb/49dxTzJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522222; c=relaxed/simple;
	bh=mQOEnFNDPytHbQQT9IAXpz28luodl7krkuFVgcN+Mng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5Dge5up9UiXLgfOmKSKOILcfn8LmaVDjrMS0mU6eixix97WTmgHXXIG0Qw7fKeyrtNjG9G8Q5fFYnSeaoVVFaxuZkjwFvEXSZi0Pd7FVYfnnc5qdPvXf1Xpytkq9YIjUI1MNmUFu6GMlmT8zDKc98gKFGw7EUV+t/ZYcqfiCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hl1XT4JzMzYQtp4;
	Wed, 16 Sep 2026 09:30:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B429940576;
	Wed, 16 Sep 2026 09:30:05 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAn+CoH8alqUcjbAQ--.36458S10;
	Wed, 16 Sep 2026 09:30:05 +0800 (CST)
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
Subject: [PATCH v6 08/26] perf annotate: Adapt arch__dwarf_regnum() for arm64
Date: Wed, 16 Sep 2026 01:29:22 +0000
Message-Id: <1f03970d9efc5195283158362873d1e445b4afe5.1789521520.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAn+CoH8alqUcjbAQ--.36458S10
X-Coremail-Antispam: 1UD129KBjvJXoW7ury3uw48Cr47ZF1DGF1Utrb_yoW8CF1fpw
	4xC343Ar10kr4FqwsxXFs3WFy3G3WfAa13uF1ktwn7Can7WryrJw4SyF1F9a13Ars7Jr1Y
	yr4qqw18WFnxCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxc
	IEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr
	0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRNg4S3UUUU
	U==
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

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d3482eba9283..86a4beec6528 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2582,19 +2582,21 @@ int annotate_check_args(void)
 
 int arch__dwarf_regnum(const struct arch *arch, const char *str)
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


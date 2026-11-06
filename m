Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957310;
	b=iL2DPnU/j9bkuOJbSsDsBRqDnjIgLM5QnwADaiac6HcKI50S9SZheDSWU436Hln8V0/6
	 V24zXUuOCrn3RzdRuIMyq1sC5OK+R9a3R6IUr1g52fu5BPo8yxlFiVDhjXqLuFXRWw+7D
	 UARCbInFnVwomKprtcCONh/cUEQSTFk67anttzRb2B+QZnwO7xlXUjeVE4/LwvnH7dIDN
	 ct9hhKjgoKP67NwpwkNumsmWR4Gkml4GmfZwezfEClrbkskxIEcEc1RUqmbMdJlQaIeeA
	 FHoGa6XAnGgn7MlzmUu7e07ALg0bXUFc1JzsomX0Udms7xv35A52kFUYazhh/Ulrn2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957310;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=s2yPprdtKSVM/pEbDCZgmatvxfAjK6EQ7JH+7rJ37Jk=;
	b=ahTKbNxujAN7VeZF1NnddxAObD1nBHZlNhpFAfcqHQoE4xMqnhtCZjrCc2qyHWWIeGMT
	 P5t28Wi4gs+uP+qXV+GG9JwOvpK13y1uUv/V11LPSiGw68UZqVog9umFpuGX1Yoiww/+M
	 7Nxtj40msg2B77zKoutocHtKDu2tkvp3eneLNRq4Q63wrWgtrLXR5Loryz+RJVkJpxCk+
	 0K9fh9VM0ohZ29KjjRnmDI0eNmvkM+8jBi201nu1kXiW52tbXWNZ/FOd99Aqm0ReOTsv2
	 UBiS/xQRGFkq2WIlByKIQ7FFZtjw5Be4WvmvwZatGBoZSXTFEuz/Z7JlZ4Is/8qZDdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13608606A328;
	Fri,  6 Nov 2026 09:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13608606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxYdGzne1q1gUdAA--.19002S3;
	Fri, 06 Nov 2026 17:28:19 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxRs2one1qAMEyAA--.25383S4;
	Fri, 06 Nov 2026 17:28:16 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] perf tests: Use TEST_ASSERT_EQUAL for all watchpoint tests
Date: Fri,  6 Nov 2026 17:28:08 +0800
Message-ID: <20261106092808.6914-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261106092808.6914-1-yangtiezhu@loongson.cn>
References: <20261106092808.6914-1-yangtiezhu@loongson.cn>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxRs2one1qAMEyAA--.25383S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr1UCFWDKw1xWr4ktw4UKFX_yoWrJFWfpw
	4YyFy8trW5Wa10q3W2vw1DuF4DGryqqFy3Gr1Sg3yIyFs8CFsIk3y8tryktF1qyrZ3uw15
	Z3s8Gr43C3yxCFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8EeHDUUUUU==

Currently, WP_TEST_ASSERT_VAL uses TEST_ASSERT_VAL which only prints
the failure message but drops the actual and expected counters. This
makes debugging hard when a watchpoint test fails due to arch-specific
hardware behavior or counter mismatches.

Rename WP_TEST_ASSERT_VAL to WP_TEST_ASSERT_EQUAL and use the built-in
TEST_ASSERT_EQUAL macro. This ensures that both the expected and actual
counter values are automatically printed upon failure.

Here is the log when executing "./perf test -v 'Read Only Watchpoint'".

Before:
  FAILED tests/wp.c:90 RO watchpoint

After:
  FAILED tests/wp.c:90 RO watchpoint (2 != 1)

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/tests/wp.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index f0b829b82f2b..253e551f10d2 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -13,11 +13,11 @@
 #include "cloexec.h"
 #include "../perf-sys.h"
 
-#define WP_TEST_ASSERT_VAL(fd, text, val)       \
-do {                                            \
-	long long count;                        \
-	wp_read(fd, &count, sizeof(long long)); \
-	TEST_ASSERT_VAL(text, count == val);    \
+#define WP_TEST_ASSERT_EQUAL(fd, text, val)		\
+do {							\
+	long long count;				\
+	wp_read(fd, &count, sizeof(long long));		\
+	TEST_ASSERT_EQUAL(text, (int)count, (int)val);	\
 } while (0)
 
 #ifdef __i386__
@@ -87,10 +87,10 @@ static int test__wp_ro(struct test_suite *test __maybe_unused,
 		return fd == -ENODEV ? TEST_SKIP : -1;
 
 	tmp = data1;
-	WP_TEST_ASSERT_VAL(fd, "RO watchpoint", 1);
+	WP_TEST_ASSERT_EQUAL(fd, "RO watchpoint", 1);
 
 	data1 = tmp1 + tmp;
-	WP_TEST_ASSERT_VAL(fd, "RO watchpoint", 1);
+	WP_TEST_ASSERT_EQUAL(fd, "RO watchpoint", 1);
 
 	close(fd);
 	return 0;
@@ -111,10 +111,10 @@ static int test__wp_wo(struct test_suite *test __maybe_unused,
 		return fd == -ENODEV ? TEST_SKIP : -1;
 
 	tmp = data1;
-	WP_TEST_ASSERT_VAL(fd, "WO watchpoint", 0);
+	WP_TEST_ASSERT_EQUAL(fd, "WO watchpoint", 0);
 
 	data1 = tmp1 + tmp;
-	WP_TEST_ASSERT_VAL(fd, "WO watchpoint", 1);
+	WP_TEST_ASSERT_EQUAL(fd, "WO watchpoint", 1);
 
 	close(fd);
 	return 0;
@@ -136,10 +136,10 @@ static int test__wp_rw(struct test_suite *test __maybe_unused,
 		return fd == -ENODEV ? TEST_SKIP : -1;
 
 	tmp = data1;
-	WP_TEST_ASSERT_VAL(fd, "RW watchpoint", 1);
+	WP_TEST_ASSERT_EQUAL(fd, "RW watchpoint", 1);
 
 	data1 = tmp1 + tmp;
-	WP_TEST_ASSERT_VAL(fd, "RW watchpoint", 2);
+	WP_TEST_ASSERT_EQUAL(fd, "RW watchpoint", 2);
 
 	close(fd);
 	return 0;
@@ -160,7 +160,7 @@ static int test__wp_modify(struct test_suite *test __maybe_unused, int subtest _
 		return fd == -ENODEV ? TEST_SKIP : -1;
 
 	data1 = tmp;
-	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 1);
+	WP_TEST_ASSERT_EQUAL(fd, "Modify watchpoint", 1);
 
 	/* Modify watchpoint with disabled = 1 */
 	get__perf_event_attr(&new_attr, HW_BREAKPOINT_W, (void *)&data2[0],
@@ -179,7 +179,7 @@ static int test__wp_modify(struct test_suite *test __maybe_unused, int subtest _
 	}
 
 	data2[1] = tmp; /* Not Counted */
-	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 1);
+	WP_TEST_ASSERT_EQUAL(fd, "Modify watchpoint", 1);
 
 	/* Enable the event */
 	ret = ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
@@ -190,10 +190,10 @@ static int test__wp_modify(struct test_suite *test __maybe_unused, int subtest _
 	}
 
 	data2[1] = tmp; /* Counted */
-	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 2);
+	WP_TEST_ASSERT_EQUAL(fd, "Modify watchpoint", 2);
 
 	data2[2] = tmp; /* Not Counted */
-	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 2);
+	WP_TEST_ASSERT_EQUAL(fd, "Modify watchpoint", 2);
 
 	close(fd);
 	return 0;
-- 
2.42.0


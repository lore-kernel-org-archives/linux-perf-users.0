Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957299;
	b=scllnZSgT29liLLCo3OKvAH6Eqrpk2Xb3huWfQnFu21px7I5lAOZfOo2C+YWVGogConF
	 RFLd1msNG9UucvJP9b5sJEkwmy+FDOlzRI0QSBB1RSnu6R6hGnpnhMJDE1u7Euaohwfz/
	 c6b/4Nt5ZydUw9SZzDr7BK+fBUJGR6UxbSiq5v1XsHin/Qj/QXUaL1XqYtooEsvbIBGCa
	 oGnv0nBA0LKz6dVMcN0lEOqxBpLNdHe2lW6D0Tu2IjwiEZhwfGOjz4ASDNo57EDj1jJvX
	 zWC9F0l7cDj0CmG6sliI2HWkAOVBSNC6ejQAlt15UGBA/FfrV9oK2qUs8g0srlLG4Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957299;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=AfG9UNNFpRLgdfp5mToXYhID3rEywlzkGucBPIBmQfM=;
	b=MY4NwICAH23OZdpepUzBzt4FSkkiHvgB9NdISGoJMQF6yiuSrbHRcjq4vNcdmN1nvkTM
	 PgAWcRHVlX6UHD/ranZSCwphjZ+0jh9BZtsvJIugMy4mgvY9OrD3ApPTMRshDbmFByJ1G
	 k9AlNhxl9GRqR6mOKo/j+mRiTOOTKlw2DDUVpQb+9nC1aC8b/QCrDonivLipvMyADDYvR
	 HL4Ltk7/Qp1EZAG/5onnJJzo/SNj2xJaS4oZu11Be7u1flItzKL8BOybB+1b3GVAHDdAo
	 vLbY6r9fSMdfcEWUMGacAxIGLcCjrz5RzsdcU2LRz/pxdlBvzBT2fttQRvk4hviQFTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5BE606A328;
	Fri,  6 Nov 2026 09:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED5BE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxutGwne1q0QUdAA--.18364S3;
	Fri, 06 Nov 2026 17:28:16 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxRs2one1qAMEyAA--.25383S3;
	Fri, 06 Nov 2026 17:28:13 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] perf tests: Assign return value of ioctl in wp_modify test
Date: Fri,  6 Nov 2026 17:28:07 +0800
Message-ID: <20261106092808.6914-2-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJDxRs2one1qAMEyAA--.25383S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFyxurWrArykXF4Dury5WrX_yoWDKrcE9r
	17WrsFga4rursFvF9Fk3WS9FWfXa15uryxJr4ktr13G3y7JFWvqF4qyr1kAr15Kw4qqFW3
	KFZFgry2g3W29osvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUc0eHDUUUU

In test__wp_modify(), the return value of ioctl PERF_EVENT_IOC_ENABLE
was not being captured. As a result, the subsequent error handling was
checking a stalled value of `ret` instead of the actual result of the
enablement operation.

Fix this by properly assigning the return value of the ioctl call to
`ret` so that the test can correctly catch and report failures when
enabling the watchpoint event.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/tests/wp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 69b31f00eed0..f0b829b82f2b 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -182,7 +182,7 @@ static int test__wp_modify(struct test_suite *test __maybe_unused, int subtest _
 	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 1);
 
 	/* Enable the event */
-	ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
+	ret = ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
 	if (ret < 0) {
 		pr_debug("Failed to enable event\n");
 		close(fd);
-- 
2.42.0


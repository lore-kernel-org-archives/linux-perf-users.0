Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0D1DA60D;
	Wed, 14 Jan 2026 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768352981; cv=none; b=mj8TRWfx/JgNkbEwFC5HkaVf+Lt/O2NlbpjkYIXGaXZanCu1S7pZcrdXPiWdZeMyi3HtZIXr5XIM+uRGvn75W8ePbpPudPfb+GPqy+aU6bX22OxxxyG5Gv3aEu4l37O9dopUOnenM1v3NZOiPLOjST36Xltmkef9MGJjiO5JGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768352981; c=relaxed/simple;
	bh=wQtk6WEScMR9IJv2BXg5OUc+AUNCfuLeT1JFsePNMMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OGuQ/is+fJUVRg1qpLoGdEpSrje2hYweawWKqUcMBre/YXCii48Nta8O48pRuDs6JO65VftyKl1nqERu9xIa5Az0OBRkt4na3i1+/5/Wn6lar+t488yJFCrCdz+dhTQovbSitxFLD151QDsSyX238fCJQscBG7qATH+LpMb8n7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowACHp96t7GZpk7YTBQ--.42623S2;
	Wed, 14 Jan 2026 09:09:01 +0800 (CST)
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
	james.clark@linaro.org,
	tglx@kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] perf/x86/intel/uncore: Convert comma to semicolon
Date: Wed, 14 Jan 2026 09:07:40 +0800
Message-Id: <20260114010740.3500665-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHp96t7GZpk7YTBQ--.42623S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17ur4DKrWUZF4kWryDJrb_yoW8GFW8pr
	48CrykKFs5uayvqa4UGF1UGFWjva93Ga93WrsrGayfZ395Jw17XF43Ww45K3WkKFy8tFy7
	tr1DZw4UJ3s8Aa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPjb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26rxl6r
	kdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67
	AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj4isqWxUUUU
	U
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 arch/x86/events/intel/uncore_snb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index e8e44741200e..3dbc6bacbd9d 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -2005,11 +2005,11 @@ static struct intel_uncore_type *nvl_msr_uncores[] = {
 void nvl_uncore_cpu_init(void)
 {
 	mtl_uncore_cbox.num_boxes = 12;
-	mtl_uncore_cbox.perf_ctr = NVL_UNC_CBOX_PER_CTR0,
-	mtl_uncore_cbox.event_ctl = NVL_UNC_CBOX_PERFEVTSEL0,
+	mtl_uncore_cbox.perf_ctr = NVL_UNC_CBOX_PER_CTR0;
+	mtl_uncore_cbox.event_ctl = NVL_UNC_CBOX_PERFEVTSEL0;
 
-	ptl_uncore_santa.perf_ctr = NVL_UNC_SANTA_CTR0,
-	ptl_uncore_santa.event_ctl = NVL_UNC_SANTA_CTRL0,
+	ptl_uncore_santa.perf_ctr = NVL_UNC_SANTA_CTR0;
+	ptl_uncore_santa.event_ctl = NVL_UNC_SANTA_CTRL0;
 
 	mtl_uncore_cncu.box_ctl = NVL_UNC_CNCU_BOX_CTL;
 	mtl_uncore_cncu.fixed_ctr = NVL_UNC_CNCU_FIXED_CTR;
-- 
2.25.1


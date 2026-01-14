Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73431ED65;
	Wed, 14 Jan 2026 02:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768358742; cv=none; b=NJ42KaHkYKW02GfFYpaQx8TrladpFy1AJlBSZRCL06IoMZiDM4snfxj8aNMXmyGZiNWad8aql3Uq14Ufh5RN4/0eton7De2e4qzaFwP8vQ/GSjg3Vg8HC48Q3OADUrpkgjFEAOX+6HjTM0YyKA0aTWaDp61zr0DTTAluGbx4CRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768358742; c=relaxed/simple;
	bh=eA2onqy7WNJAtm3fDgxMhxrNqcEUZIO/xaF7vCjglg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TvMnwOMib3/3BxYtq5f9Ex8mfHPNxg5XtUDevRYxRzKVIi+puw/lFUiUUIYc4H9XV9LMv6E22WkJ9jfE8OoHdFnRIZmQFxtlVXznrA9vlSNQ8XXsf0HattvHxOfwTgzZkMyYe4gWUhJNH1VeGgshSZ+HJLI0G3v73IGF+KRbV68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAAnSeA7A2dpNrgVBQ--.11347S2;
	Wed, 14 Jan 2026 10:45:15 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: nichen@iscas.ac.cn,
	peterz@infradead.org,
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
	hpa@zytor.com,
	zide.chen@intel.com,
	dapeng1.mi@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf/x86/intel/uncore: Convert comma to semicolon
Date: Wed, 14 Jan 2026 10:36:52 +0800
Message-Id: <20260114023652.3926117-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnSeA7A2dpNrgVBQ--.11347S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17ur4DKrWUur4UKw1Dtrb_yoW8XFy3pr
	48ArykKrs5uayvga4UGF1UGFWjva93Ga93Wr4DKayfZ395Jw17XFsrWw45K3WkKFy8tFy7
	tr1DXw48Jas8Ja7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_GcC_Xc
	WlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14
	v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcWrWDUUU
	U
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Fixes: e7d5f2ea0923 ("perf/x86/intel/uncore: Add Nova Lake support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
Changelog:

v1 -> v2:

- Add Fixes tag.
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


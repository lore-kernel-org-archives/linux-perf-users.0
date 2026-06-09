Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94D03CF1ED
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780984993; cv=none; b=ami0RrCD523V8MLS+dci3iL9vbbolHxOO3vv/qwbKipvtFmYamSBUYDUBOWdZ0JxRyR6FLePsUhI7HSvTl+mUkVWXrsPN8mi7fXgjV/R3zn3INjo/+sjgJwqXYn79Th5HwFZXjQSMP7XwhmYqRtHira82ZjYx2iBd89aplFmCHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780984993; c=relaxed/simple;
	bh=1QogxSyPX7FywvVaFCnOg2eE+pP5EQh82n+ltbBK2zY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s/5Qn5xwxTbyM9drGlXi2Oym6cZH77cjrgRGNjJwx8ZiiSxSAexS9+VpnRazaAKIuxKKu13ePdgsHrUWtgc7kk6uLeeFcPB6nGYB6yQSlgH83taMiHC59opbSk1rqXhkIYoUsPo+rvt+Svn5Z4rLhaARrbSvgiMtgC4hHdGNTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T4cVLiBK; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T4cVLiBK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780984990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CeVq8nIFWuQTYTDv2nXLX/gfQ3GPv2/MmaJpRnKjBUM=;
	b=T4cVLiBKpub52d9V/sOMY+nhHhBdp+01hm4SMjSruiz278dhwElAEu3t5HWnq2fP/MYHOU
	LR0NxNlDcXAU5jpTOY9CKWBMlGdRjf9cL9rL2xrH0a/LXTVo+a3bi+OedYecR9sFeiMUyA
	LIUS7sF025t5x1y9+yM2oMFOyCMI1sQ=
From: Atish Patra <atish.patra@linux.dev>
Date: Mon, 08 Jun 2026 23:01:34 -0700
Subject: [PATCH v6 20/21] TEST(do-not-upstream): fake qemu-virt PMU events
 for cdeleg counter-mask testing
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-counter_delegation-v6-20-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-0-285b72ed65a9@meta.com>
In-Reply-To: <20260608-counter_delegation-v6-0-285b72ed65a9@meta.com>
To: James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>, 
 Atish Patra <atish.patra@linux.dev>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ian Rogers <irogers@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Migadu-Flow: FLOW_OUT

From: Atish Patra <atishp@meta.com>

Adds fake-any/fake-ctr3/fake-ctr34 (event codes 0xF0x QEMU doesn't model) with
counterid_masks, to exercise the counter-delegation allocation + counter-mask
constraint in QEMU (events read 0 = allocated/programmed, vs 'not supported').

Signed-off-by: Atish Patra <atishp@meta.com>
---
 drivers/perf/riscv_pmu_sbi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 74acac54328e..3c0829c0a42a 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -476,6 +476,12 @@ RVPMU_EVENT_CMASK_ATTR(instructions, instructions, 0x02, 0xFFFFFFF8);
 RVPMU_EVENT_CMASK_ATTR(dTLB-load-misses, dTLB_load_miss, 0x10019, 0xFFFFFFF8);
 RVPMU_EVENT_CMASK_ATTR(dTLB-store-misses, dTLB_store_miss, 0x1001B, 0xFFFFFFF8);
 RVPMU_EVENT_CMASK_ATTR(iTLB-load-misses, iTLB_load_miss, 0x10021, 0xFFFFFFF8);
+/*
+ * FAKE events for cdeleg mechanism testing: event codes QEMU does NOT model.
+ */
+RVPMU_EVENT_CMASK_ATTR(fake-any, fake_any, 0xF00, 0xFFFFFFF8);
+RVPMU_EVENT_CMASK_ATTR(fake-ctr3, fake_ctr3, 0xF01, 0x8);
+RVPMU_EVENT_CMASK_ATTR(fake-ctr34, fake_ctr34, 0xF02, 0x18);
 
 static struct attribute *qemu_virt_event_group[] = {
 	RVPMU_EVENT_ATTR_PTR(cycles),
@@ -483,6 +489,9 @@ static struct attribute *qemu_virt_event_group[] = {
 	RVPMU_EVENT_ATTR_PTR(dTLB_load_miss),
 	RVPMU_EVENT_ATTR_PTR(dTLB_store_miss),
 	RVPMU_EVENT_ATTR_PTR(iTLB_load_miss),
+	RVPMU_EVENT_ATTR_PTR(fake_any),
+	RVPMU_EVENT_ATTR_PTR(fake_ctr3),
+	RVPMU_EVENT_ATTR_PTR(fake_ctr34),
 	NULL,
 };
 

-- 
2.53.0-Meta


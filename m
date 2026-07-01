Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201123F86E2
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895747; cv=none; b=Sj6+bYPVN3bfr4RFWnoRA/kuT84jwlCFlRn2XFjZmQqWHAlQ2zE//NnnbBRAyzi0RsdiI+/Ag3ZeHqeH1CsUMIAJNQNfAqtBmJEofJityBqkGr7g3rXKwEMh0FOUcJnDj/xUxxLvLG8SPSicK1SBYjal7qtN7q95p1p5/mwPQRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895747; c=relaxed/simple;
	bh=rlr1JrpvEX5VV6u+bodY3ZJOPnTthq0L3jv7H/1JuPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7n/sRHbHr8zdoExXSWeDA/YqYvPx2VLwkdowRMP6uHs66IqSIS41KE827hQDmuihaEnOAwlOg5R/Cn/bTI4PdNcs/M34Owt0l+uVM/dq0r13loFnp9n9WulCY00Ju1hFambXI2SxyIvltCqKohoD6xpNkej4yIVBFgmO6VcHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=idSR86bR; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="idSR86bR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782895744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KM/aix7Aoq3ErthWJJhVZGT/lKJGUMSauEvdAp3MmGs=;
	b=idSR86bRfn7ZYGRhVuVR1igwFO20aocVs5vam+0JJ+tJGd448gZUIXXUlg9IrVOLUd/PTR
	/siamZ9g5fKUuv6zXvwXpewzO3GXbmLPwplqdsbJ8GESTvjSmemWFngNPwed43KRINxxvK
	trG53oCWbp07eerA/xgJ08iaxCOtdV8=
From: Atish Patra <atish.patra@linux.dev>
Date: Wed, 01 Jul 2026 01:47:10 -0700
Subject: [PATCH v8 22/22] TEST(do-not-upstream): fake qemu vendor JSON +
 mapfile entry for CounterIDMask path
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-counter_delegation-v8-22-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
In-Reply-To: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
To: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Atish Patra <atish.patra@linux.dev>, Ian Rogers <irogers@google.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
X-Migadu-Flow: FLOW_OUT

From: Atish Patra <atishp@meta.com>

arch/riscv/qemu/virt/events.json: fake-json-{any,ctr3,ctr34,ctr6} with EventCode
+ CounterIDMask; mapfile.csv: 0x0-0x0-0x0 -> qemu/virt. Exercises jevents
CounterIDMask -> counterid_mask= -> config2 -> cdeleg counter allocation.

Signed-off-by: Atish Patra <atishp@meta.com>
---
 tools/perf/pmu-events/arch/riscv/mapfile.csv       |  2 ++
 .../pmu-events/arch/riscv/qemu/virt/events.json    | 26 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index 87cfb0e0849f..2fa3c3fd4663 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -24,3 +24,5 @@
 0x602-0x3-0x0,v1,openhwgroup/cva6,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
 0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
+0x0-0x0-0x0,v1,qemu/virt,core
+0x0-0x2a-0x0,v1,qemu/virt,core
diff --git a/tools/perf/pmu-events/arch/riscv/qemu/virt/events.json b/tools/perf/pmu-events/arch/riscv/qemu/virt/events.json
new file mode 100644
index 000000000000..294c4ed645f6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/qemu/virt/events.json
@@ -0,0 +1,26 @@
+[
+  {
+    "EventName": "fake-json-any",
+    "EventCode": "0xF10",
+    "CounterIDMask": "0xFFFFFFF8",
+    "BriefDescription": "FAKE json event (any hpmcounter 3-31) - QEMU does not model 0xF10"
+  },
+  {
+    "EventName": "fake-json-ctr3",
+    "EventCode": "0xF11",
+    "CounterIDMask": "0x8",
+    "BriefDescription": "FAKE json event constrained to hpmcounter3"
+  },
+  {
+    "EventName": "fake-json-ctr34",
+    "EventCode": "0xF12",
+    "CounterIDMask": "0x18",
+    "BriefDescription": "FAKE json event constrained to hpmcounter3,4"
+  },
+  {
+    "EventName": "fake-json-ctr6",
+    "EventCode": "0xF13",
+    "CounterIDMask": "0x40",
+    "BriefDescription": "FAKE json event constrained to hpmcounter6 (out of a small pmu-mask)"
+  }
+]

-- 
2.53.0-Meta


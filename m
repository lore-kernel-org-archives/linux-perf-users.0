Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F009318144;
	Mon,  9 Feb 2026 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626361; cv=none; b=dHM0sF9WQvszNM5ALsmWHl4htshYVN53nKBOxLoeJvHS9t4o8d0eoyANVInwVqLl5ft7nUbM2Aum4JtAWey3C1IKezP/l3IQkjecM0SKTE589k5ktRSswirAXEknm6Ys6k8nBt4KjwsTHZWTOl2RN2WHBMxfcEWtnUNnGkttSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626361; c=relaxed/simple;
	bh=E9saGuhJGOU9+I6Yjce+ud/XgxCtUAe4jefhxgreW1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nad/FYhIeQpfch/CLQ+G4rNgcCJsEk6aglk/0ZJ7vBMtQSCy8sr072tH6rI0JeB9+bSC0gwLK5RmlIvqLyh2k3YC8u4/2QrBzWviSGaWwSke5q1mw9z6hgWBnPefe3fJZ9prKlZ00z55WdKp7V/RHjzG+odRO+bt5jLKtfm+1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biTJAkH0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biTJAkH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770626362; x=1802162362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E9saGuhJGOU9+I6Yjce+ud/XgxCtUAe4jefhxgreW1c=;
  b=biTJAkH0l37AQiKQ9FJblFJ+UHWGY2cD77SovSFsVxQRK1MEwbNes4Ae
   XUNEyhzSQ3dOPqhdO5OUZMq46ik44B63FGFHNOfRhUC6xjWPFZlTXbfqs
   d+khOgGXB83HhJdv+ocxr5VLHxBZgPxSg7Bs+BOqZrpGPHXiwdCZCKlqg
   PwyaNAQ0QfAuxK9kV1Urwi9ZD4FMDv2S2S+93Y3fTkHJdNYc40uri7cQW
   JrIpynOA3Xy/Gjyxn+fm/XkAH2Ji0/bu+UElQQIIuoIS4Q8fkbmjp7Syy
   cmkL2EKhN2+A+HSEoQ7eZSAbSpIRTd8FtZd/yJCjdM3I4De13ePrn8wCK
   A==;
X-CSE-ConnectionGUID: uVIygSjhQFGU0y5v0py1NA==
X-CSE-MsgGUID: AJknPYOGSzyyuwIV0a4yfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="75580733"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="75580733"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:39:21 -0800
X-CSE-ConnectionGUID: S25R2+EyQWaYUkSqdxWUrg==
X-CSE-MsgGUID: l2aZxljuQMeIqE6bWMGOew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="211582346"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 09 Feb 2026 00:39:18 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 4/4] perf regs: Enable dumping of SIMD registers
Date: Mon,  9 Feb 2026 16:35:14 +0800
Message-Id: <20260209083514.2225115-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209083514.2225115-1-dapeng1.mi@linux.intel.com>
References: <20260209083514.2225115-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

This patch adds support for dumping SIMD registers using the new
PERF_SAMPLE_REGS_ABI_SIMD ABI.

Currently, the XMM, YMM, ZMM, OPMASK, eGPRs, and SSP registers on x86
platforms are supported with the PERF_SAMPLE_REGS_ABI_SIMD ABI.

An example of the output is displayed below.

Example:

 $perf record -e cycles:p -IXMM,YMM,OPMASK,SSP ./test
 $perf report -D
 ... ...
 237538985992962 0x454d0 [0x480]: PERF_RECORD_SAMPLE(IP, 0x1):
 179370/179370: 0xffffffff969627fc period: 124999 addr: 0
 ... intr regs: mask 0x20000000000 ABI 64-bit
 .... SSP   0x0000000000000000
 ... SIMD ABI nr_vectors 32 vector_qwords 4 nr_pred 8 pred_qwords 1
 .... YMM  [0] 0x0000000000004000
 .... YMM  [0] 0x000055e828695270
 .... YMM  [0] 0x0000000000000000
 .... YMM  [0] 0x0000000000000000
 .... YMM  [1] 0x000055e8286990e0
 .... YMM  [1] 0x000055e828698dd0
 .... YMM  [1] 0x0000000000000000
 .... YMM  [1] 0x0000000000000000
 ... ...
 .... YMM  [31] 0x0000000000000000
 .... YMM  [31] 0x0000000000000000
 .... YMM  [31] 0x0000000000000000
 .... YMM  [31] 0x0000000000000000
 .... OPMASK[0] 0x0000000000100221
 .... OPMASK[1] 0x0000000000000020
 .... OPMASK[2] 0x000000007fffffff
 .... OPMASK[3] 0x0000000000000000
 .... OPMASK[4] 0x0000000000000000
 .... OPMASK[5] 0x0000000000000000
 .... OPMASK[6] 0x0000000000000000
 .... OPMASK[7] 0x0000000000000000
 ... ...

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/util/evsel.c   | 20 ++++++++++
 tools/perf/util/sample.h  | 10 +++++
 tools/perf/util/session.c | 77 +++++++++++++++++++++++++++++++++++----
 3 files changed, 99 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a86d2434a4ad..2e1d50a72762 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3514,6 +3514,16 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			regs->mask = mask;
 			regs->regs = (u64 *)array;
 			array = (void *)array + sz;
+
+			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				regs->config = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+				regs->data = (u64 *)array;
+				sz = (regs->nr_vectors * regs->vector_qwords +
+				      regs->nr_pred * regs->pred_qwords) * sizeof(u64);
+				OVERFLOW_CHECK(array, sz, max_size);
+				array = (void *)array + sz;
+			}
 		}
 	}
 
@@ -3571,6 +3581,16 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			regs->mask = mask;
 			regs->regs = (u64 *)array;
 			array = (void *)array + sz;
+
+			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				regs->config = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+				regs->data = (u64 *)array;
+				sz = (regs->nr_vectors * regs->vector_qwords +
+				      regs->nr_pred * regs->pred_qwords) * sizeof(u64);
+				OVERFLOW_CHECK(array, sz, max_size);
+				array = (void *)array + sz;
+			}
 		}
 	}
 
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 3cce8dd202aa..b98bc58d365e 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -15,6 +15,16 @@ struct regs_dump {
 	u64 abi;
 	u64 mask;
 	u64 *regs;
+	union {
+		u64 config;
+		struct {
+			u16 nr_vectors;
+			u16 vector_qwords;
+			u16 nr_pred;
+			u16 pred_qwords;
+		};
+	};
+	u64 *data;
 
 	/* Cached values/mask filled by first register access. */
 	u64 cache_regs[PERF_SAMPLE_REGS_CACHE_SIZE];
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7cf7bf86205d..fba8ef52f0a1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -972,18 +972,77 @@ static void regs_dump__printf(u64 mask, struct regs_dump *regs,
 	}
 }
 
-static const char *regs_abi[] = {
-	[PERF_SAMPLE_REGS_ABI_NONE] = "none",
-	[PERF_SAMPLE_REGS_ABI_32] = "32-bit",
-	[PERF_SAMPLE_REGS_ABI_64] = "64-bit",
-};
+static void simd_regs_dump__printf(struct regs_dump *regs, bool intr)
+{
+	const char *name = "unknown";
+	int i, idx = 0;
+	uint16_t qwords;
+	int reg_c;
+
+	if (!(regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
+		return;
+
+	printf("... SIMD ABI nr_vectors %d vector_qwords %d nr_pred %d pred_qwords %d\n",
+	       regs->nr_vectors, regs->vector_qwords,
+	       regs->nr_pred, regs->pred_qwords);
+
+	for (reg_c = 0; reg_c < 64; reg_c++) {
+		if (intr) {
+			perf_intr_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
+							       &qwords, /*pred=*/false);
+		} else {
+			perf_user_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
+							       &qwords, /*pred=*/false);
+		}
+		if (regs->vector_qwords == qwords) {
+			name = perf_simd_reg_class_name(EM_HOST, reg_c, /*pred=*/false);
+			break;
+		}
+	}
+
+	for (i = 0; i < regs->nr_vectors; i++) {
+		printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+		printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+		if (regs->vector_qwords > 2) {
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+		}
+		if (regs->vector_qwords > 4) {
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+		}
+	}
+
+	name = "unknown";
+	for (reg_c = 0; reg_c < 64; reg_c++) {
+		if (intr) {
+			perf_intr_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
+							       &qwords, /*pred=*/true);
+		} else {
+			perf_user_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
+							       &qwords, /*pred=*/true);
+		}
+		if (regs->pred_qwords == qwords) {
+			name = perf_simd_reg_class_name(EM_HOST, reg_c, /*pred=*/true);
+			break;
+		}
+	}
+	for (i = 0; i < regs->nr_pred; i++)
+		printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+}
 
 static inline const char *regs_dump_abi(struct regs_dump *d)
 {
-	if (d->abi > PERF_SAMPLE_REGS_ABI_64)
-		return "unknown";
+	if (!d->abi)
+		return "none";
+	if (d->abi & PERF_SAMPLE_REGS_ABI_32)
+		return "32-bit";
+	else if (d->abi & PERF_SAMPLE_REGS_ABI_64)
+		return "64-bit";
 
-	return regs_abi[d->abi];
+	return "unknown";
 }
 
 static void regs__printf(const char *type, struct regs_dump *regs,
@@ -1010,6 +1069,7 @@ static void regs_user__printf(struct perf_sample *sample, uint16_t e_machine, ui
 
 	if (user_regs->regs)
 		regs__printf("user", user_regs, e_machine, e_flags);
+	simd_regs_dump__printf(user_regs, /*intr=*/false);
 }
 
 static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine, uint32_t e_flags)
@@ -1023,6 +1083,7 @@ static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine, ui
 
 	if (intr_regs->regs)
 		regs__printf("intr", intr_regs, e_machine, e_flags);
+	simd_regs_dump__printf(intr_regs, /*intr=*/true);
 }
 
 static void stack_user__printf(struct stack_dump *dump)
-- 
2.34.1


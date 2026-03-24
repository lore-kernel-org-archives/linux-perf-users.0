Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2522374745;
	Tue, 24 Mar 2026 01:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314103; cv=none; b=TXxfEyOkbPW4hGnxbznLIKBR2dQJQrcMinAxjr5vHL5TO21XmgrXUAzq/DoPaImgj45wGqB4K5LTQvrQRQuqTkKCSEA+GRw9fv4SxmX5DQWLMZQVQhSvQ2uA8C/3hG4C1RoB57i1gBxzVLtz9v7Wb+ZOsJ+ie2k1Ouj87wE1RsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314103; c=relaxed/simple;
	bh=5NI4ea9cKFwayWZZvfaw66PawTCNz+JzZthcJEGzSfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFVMR0DQC7/kqn4B2pOZPBxVPqyV7NpSzc7uGh9KYyR5gBapHHzgjlj9xQC624UYdoxYL5VZ3wGpoSZ2XR977wmDcSFPNiSXQpJ/OwlT4vGau46IEydgKXNvNRnLxoq3/iBqnAaAPpJhM7i4zF3dNTs5PCNWP/XApBvRoMbzl6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jaz8nIz/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jaz8nIz/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774314102; x=1805850102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5NI4ea9cKFwayWZZvfaw66PawTCNz+JzZthcJEGzSfo=;
  b=Jaz8nIz/p+0WYR7CHtCzAuqDUq0y0ICTy/6DRUFqY2Z0nEwjujnQnUf3
   tId7VoTHAuiJEYBmWYvO0D3SNkjXbVyrWLvKTEw2qVSDAJQH0ieGoIQGY
   f+y7PmX/aJom9pethpwydRdm5UdBea50t1z63OAGDOvUctsH/PxmQRadb
   tiUoO30niGF8rQvC3aola9pZGVRsCbTOtNUyuBGz0Ldw6l98wel9e/0g8
   MyrHWwzHDu47WDOmwuQ/Z2Wkf2FIl9yIAhy1NJBu6QpLz+IxW4iUkdfGy
   uxgVd4NT8/ZS1Bkzx3bk7ydRFSgODFoxGJM8nWtGX/gOmGQNU5qbW2LCy
   A==;
X-CSE-ConnectionGUID: oiTs01DJSjW8QiMrnknTcg==
X-CSE-MsgGUID: z0b4X7f8TF2RGIPXkf5mkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75441749"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75441749"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 18:01:42 -0700
X-CSE-ConnectionGUID: ZJmOB2M8Syy/kh3qizfFmQ==
X-CSE-MsgGUID: +36nYkBLSVy/CZPnlFGxvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228263324"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa003.jf.intel.com with ESMTP; 23 Mar 2026 18:01:35 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v7 4/4] perf regs: Enable dumping of SIMD registers
Date: Tue, 24 Mar 2026 08:57:06 +0800
Message-Id: <20260324005706.3778057-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324005706.3778057-1-dapeng1.mi@linux.intel.com>
References: <20260324005706.3778057-1-dapeng1.mi@linux.intel.com>
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

V7: 1) add assert() check for SIMD fields in sample data.
    2) optimize regs_abi[] defination.

 tools/perf/util/evsel.c   | 36 +++++++++++++++++++++
 tools/perf/util/sample.h  | 10 ++++++
 tools/perf/util/session.c | 66 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5f00489e714a..24cc7ba71ae1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3520,6 +3520,24 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			regs->mask = mask;
 			regs->regs = (u64 *)array;
 			array = (void *)array + sz;
+
+			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				assert(regs->nr_vectors <=
+				       hweight64(evsel->core.attr.sample_simd_vec_reg_user));
+				assert(regs->vector_qwords <=
+				       evsel->core.attr.sample_simd_vec_reg_qwords);
+				assert(regs->nr_pred <=
+				       hweight64(evsel->core.attr.sample_simd_pred_reg_user));
+				assert(regs->pred_qwords <=
+					 evsel->core.attr.sample_simd_pred_reg_qwords);
+				regs->config = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+				regs->simd_data = (u64 *)array;
+				sz = (regs->nr_vectors * regs->vector_qwords +
+				      regs->nr_pred * regs->pred_qwords) * sizeof(u64);
+				OVERFLOW_CHECK(array, sz, max_size);
+				array = (void *)array + sz;
+			}
 		}
 	}
 
@@ -3577,6 +3595,24 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			regs->mask = mask;
 			regs->regs = (u64 *)array;
 			array = (void *)array + sz;
+
+			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				assert(regs->nr_vectors <=
+				       hweight64(evsel->core.attr.sample_simd_vec_reg_intr));
+				assert(regs->vector_qwords <=
+				       evsel->core.attr.sample_simd_vec_reg_qwords);
+				assert(regs->nr_pred <=
+				       hweight64(evsel->core.attr.sample_simd_pred_reg_intr));
+				assert(regs->pred_qwords <=
+					 evsel->core.attr.sample_simd_pred_reg_qwords);
+				regs->config = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+				regs->simd_data = (u64 *)array;
+				sz = (regs->nr_vectors * regs->vector_qwords +
+				      regs->nr_pred * regs->pred_qwords) * sizeof(u64);
+				OVERFLOW_CHECK(array, sz, max_size);
+				array = (void *)array + sz;
+			}
 		}
 	}
 
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 3cce8dd202aa..21f3416d3755 100644
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
+	u64 *simd_data;
 
 	/* Cached values/mask filled by first register access. */
 	u64 cache_regs[PERF_SAMPLE_REGS_CACHE_SIZE];
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7cf7bf86205d..453d44d32162 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -972,15 +972,77 @@ static void regs_dump__printf(u64 mask, struct regs_dump *regs,
 	}
 }
 
+static void simd_regs_dump__printf(uint16_t e_machine, struct regs_dump *regs, bool intr)
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
+			perf_intr_simd_reg_class_bitmap_qwords(e_machine, reg_c,
+							       &qwords, /*pred=*/false);
+		} else {
+			perf_user_simd_reg_class_bitmap_qwords(e_machine, reg_c,
+							       &qwords, /*pred=*/false);
+		}
+		if (regs->vector_qwords == qwords) {
+			name = perf_simd_reg_class_name(e_machine, reg_c, /*pred=*/false);
+			break;
+		}
+	}
+
+	for (i = 0; i < regs->nr_vectors; i++) {
+		printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
+		printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
+		if (regs->vector_qwords > 2) {
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
+		}
+		if (regs->vector_qwords > 4) {
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
+		}
+	}
+
+	name = "unknown";
+	for (reg_c = 0; reg_c < 64; reg_c++) {
+		if (intr) {
+			perf_intr_simd_reg_class_bitmap_qwords(e_machine, reg_c,
+							       &qwords, /*pred=*/true);
+		} else {
+			perf_user_simd_reg_class_bitmap_qwords(e_machine, reg_c,
+							       &qwords, /*pred=*/true);
+		}
+		if (regs->pred_qwords == qwords) {
+			name = perf_simd_reg_class_name(e_machine, reg_c, /*pred=*/true);
+			break;
+		}
+	}
+	for (i = 0; i < regs->nr_pred; i++)
+		printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
+}
+
 static const char *regs_abi[] = {
 	[PERF_SAMPLE_REGS_ABI_NONE] = "none",
 	[PERF_SAMPLE_REGS_ABI_32] = "32-bit",
 	[PERF_SAMPLE_REGS_ABI_64] = "64-bit",
+	[PERF_SAMPLE_REGS_ABI_SIMD | PERF_SAMPLE_REGS_ABI_64] = "64-bit SIMD",
 };
 
 static inline const char *regs_dump_abi(struct regs_dump *d)
 {
-	if (d->abi > PERF_SAMPLE_REGS_ABI_64)
+	if (d->abi >= ARRAY_SIZE(regs_abi) || !regs_abi[d->abi])
 		return "unknown";
 
 	return regs_abi[d->abi];
@@ -1010,6 +1072,7 @@ static void regs_user__printf(struct perf_sample *sample, uint16_t e_machine, ui
 
 	if (user_regs->regs)
 		regs__printf("user", user_regs, e_machine, e_flags);
+	simd_regs_dump__printf(e_machine, user_regs, /*intr=*/false);
 }
 
 static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine, uint32_t e_flags)
@@ -1023,6 +1086,7 @@ static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine, ui
 
 	if (intr_regs->regs)
 		regs__printf("intr", intr_regs, e_machine, e_flags);
+	simd_regs_dump__printf(e_machine, intr_regs, /*intr=*/true);
 }
 
 static void stack_user__printf(struct stack_dump *dump)
-- 
2.34.1


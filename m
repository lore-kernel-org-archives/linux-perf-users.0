Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E1B2C158F;
	Wed,  3 Dec 2025 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745180; cv=none; b=edcFXq1E3tqdiqn8lNZ8WouAQB7b4z/CPdHKcGBPdkrANn3zZpcAZk6My3QPbsRiLSndKLiV7M7mVDsRroEtZFe2Qn3N88L/7BKRa0izvJqpeeHRkffqcJDpPAApcw64ghvJJ5oyhkYC5JH+qDfZp33alO5hUMfhTS/zm7dGtPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745180; c=relaxed/simple;
	bh=t23Vet3KpXEUBHWAW7TVt4gogWNPDsrOzq5ZhNAt7G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pf6P0Q/6kqieFwQ/q1MBGyodCaGXpmcp8nVenhQc/yprxcZnisVfMNM59dQdQXSy3WwA0Q7wkwa6sv21M7uhh/xj4ZNid/KheKVh+EzXyiLlrCZZmCULN+UdNUn7jYcEQBq1r3OtlRglTsxqXQKcbpdXzK8PRUOVKeejBvP81I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXRveBX9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXRveBX9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745178; x=1796281178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t23Vet3KpXEUBHWAW7TVt4gogWNPDsrOzq5ZhNAt7G4=;
  b=JXRveBX95n9c9lGE466SprKkb8tsjmn5TE8Ahd03uNnPpfvVywsqPb8r
   wphy81YGvEWS6an0YS8Y0YOfX/7KZGkew2Wq9Hr+InZxyl0/R/UJUld1B
   IHU/sJQnQPN9VZXq1irI0OmpbHLBlflZaPayKgRmM/5GtYmvEizAfq8Fc
   OGppAkttb7mKND8RV27doaXgpHLXd5Y9JtjJ8Vtm4xxwVkuBjwr/yJE7H
   bVGOb9TVpmbMZlxfGDKVKJZr9cw3kZCs7PoMvuLgTmWVfh/8ysCbXmBom
   I/A8j+FuFUSXwt+HvKLKmGP896EY9C6wDhh802ntcManwrD0A9H0zRKjv
   w==;
X-CSE-ConnectionGUID: midD1SyQQX6Lo+1z6qj97Q==
X-CSE-MsgGUID: zjMW/uOWQJiBoSc3yzHQdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324945"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324945"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:59:38 -0800
X-CSE-ConnectionGUID: Iax5iAaaQtC7ELeUQh+33w==
X-CSE-MsgGUID: Dl9PMkYSSTGYZ1gM0YB5JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199004058"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:59:33 -0800
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
Subject: [Patch v5 19/19] perf regs: Enable dumping of SIMD registers
Date: Wed,  3 Dec 2025 14:55:00 +0800
Message-Id: <20251203065500.2597594-20-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
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
 tools/perf/util/evsel.c                       | 20 +++++
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 43 ++++++++++
 tools/perf/util/sample.h                      | 10 +++
 tools/perf/util/session.c                     | 78 +++++++++++++++++--
 4 files changed, 143 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5d1d90cf9488..8f3fafe3a43f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3347,6 +3347,16 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
 
@@ -3404,6 +3414,16 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
 
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index 708954a9d35d..32dac438b12d 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -5,6 +5,49 @@
 
 const char *__perf_reg_name_x86(int id)
 {
+	if (id > PERF_REG_X86_R15 && arch__intr_simd_reg_mask()) {
+		switch (id) {
+		case PERF_REG_X86_R16:
+			return "R16";
+		case PERF_REG_X86_R17:
+			return "R17";
+		case PERF_REG_X86_R18:
+			return "R18";
+		case PERF_REG_X86_R19:
+			return "R19";
+		case PERF_REG_X86_R20:
+			return "R20";
+		case PERF_REG_X86_R21:
+			return "R21";
+		case PERF_REG_X86_R22:
+			return "R22";
+		case PERF_REG_X86_R23:
+			return "R23";
+		case PERF_REG_X86_R24:
+			return "R24";
+		case PERF_REG_X86_R25:
+			return "R25";
+		case PERF_REG_X86_R26:
+			return "R26";
+		case PERF_REG_X86_R27:
+			return "R27";
+		case PERF_REG_X86_R28:
+			return "R28";
+		case PERF_REG_X86_R29:
+			return "R29";
+		case PERF_REG_X86_R30:
+			return "R30";
+		case PERF_REG_X86_R31:
+			return "R31";
+		case PERF_REG_X86_SSP:
+			return "SSP";
+		default:
+			return NULL;
+		}
+
+		return NULL;
+	}
+
 	switch (id) {
 	case PERF_REG_X86_AX:
 		return "AX";
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index fae834144ef4..3b247e0e8242 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -12,6 +12,16 @@ struct regs_dump {
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
index 09af486c83e4..c692be265c21 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -927,18 +927,78 @@ static void regs_dump__printf(u64 mask, u64 *regs, const char *arch)
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
+	const struct sample_reg *r;
+	int i, idx = 0;
+	u16 qwords;
+	int reg_idx;
+
+	if (!(regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
+		return;
+
+	printf("... SIMD ABI nr_vectors %d vector_qwords %d nr_pred %d pred_qwords %d\n",
+	       regs->nr_vectors, regs->vector_qwords,
+	       regs->nr_pred, regs->pred_qwords);
+
+	for (r = arch__sample_simd_reg_masks(); r->name; r++) {
+		if (!fls64(r->mask))
+			continue;
+		reg_idx = fls64(r->mask) - 1;
+		if (intr)
+			arch__intr_simd_reg_bitmap_qwords(reg_idx, &qwords);
+		else
+			arch__user_simd_reg_bitmap_qwords(reg_idx, &qwords);
+		if (regs->vector_qwords == qwords) {
+			name = r->name;
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
+	for (r = arch__sample_pred_reg_masks(); r->name; r++) {
+		if (!fls64(r->mask))
+			continue;
+		reg_idx = fls64(r->mask) - 1;
+		if (intr)
+			arch__intr_pred_reg_bitmap_qwords(reg_idx, &qwords);
+		else
+			arch__user_pred_reg_bitmap_qwords(reg_idx, &qwords);
+		if (regs->pred_qwords == qwords) {
+			name = r->name;
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
 
 static void regs__printf(const char *type, struct regs_dump *regs, const char *arch)
@@ -964,6 +1024,7 @@ static void regs_user__printf(struct perf_sample *sample, const char *arch)
 
 	if (user_regs->regs)
 		regs__printf("user", user_regs, arch);
+	simd_regs_dump__printf(user_regs, false);
 }
 
 static void regs_intr__printf(struct perf_sample *sample, const char *arch)
@@ -977,6 +1038,7 @@ static void regs_intr__printf(struct perf_sample *sample, const char *arch)
 
 	if (intr_regs->regs)
 		regs__printf("intr", intr_regs, arch);
+	simd_regs_dump__printf(intr_regs, true);
 }
 
 static void stack_user__printf(struct stack_dump *dump)
-- 
2.34.1


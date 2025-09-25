Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911082E9735;
	Thu, 25 Sep 2025 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780943; cv=none; b=tsFi6Yk0RWX6GCNxjaZMwGG1+4zn1w4aJLHvcVQxGsKJExORku7q2wZKADT92afravAH/oRlNfkon7D5/243FQ7aZbL8YAV/w+zLy87ySksJ0Kehh8LUjmtgw9/2iJMdMuvNOj1ktSr+r2Cq9rdQm01VD9xwtdwkIY0yl1n4l7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780943; c=relaxed/simple;
	bh=hbINY1d3vMKbOoiTLJ2OqBpvWIDyUISmVFhTZDlytuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S1d0PbRwhedAuWOXUH9bXVYPAeqIrC5gL6rYLHJnti+CGR3of72Qhy48fb9eYthLv2Ggi4/wtv4W0mOck+NTUNlKf8bE9OkQddQpUwvIKmup8Rg908ieYEk2AYp0nvnvvoUaQ5WZpSe09nQfTxDrhXWMSATNZgGHzR/D5zmJyf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpbQhtc9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpbQhtc9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780942; x=1790316942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hbINY1d3vMKbOoiTLJ2OqBpvWIDyUISmVFhTZDlytuw=;
  b=mpbQhtc9LSMA0yb0Ip910/5yoLFhW+kGBARgvAnsNcGBG9t+oTxe2hdx
   KQkc+fz8x4GuX0UkVHXeATdQ9lOrSzmdtwUlbQC1xpSsNwpI1AxqWwfm2
   RGctDJ/XPbOWW91KgFvQQwfd2ac+htCTU930cj+L3xeeBGRCNsGgBBYxq
   Wqou8x2pMii/ecGl5gyXZVs4AzFHOAwxYN63On8OljKiUWy3+2L002+Ko
   KHb4xj54rm16ZybPjSkbasLrORfdCnlO6jUD4vXqtxn0SuOZhaGUYTqas
   Pe+/KWYzRML8lC/TssxRyAUWp2ETxG82hfsmKAE43dgnZ39QepTTmwnUs
   A==;
X-CSE-ConnectionGUID: emBGDrRoSge6PXUNMGTjQg==
X-CSE-MsgGUID: l5JYVAjqTiqZOGVwLJeSzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139656"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139656"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:15:41 -0700
X-CSE-ConnectionGUID: XahZuPCbSzGzvH9ODewjdA==
X-CSE-MsgGUID: bL4mBxj4RHy4vZG+RvpnhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528727"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:15:36 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 17/17] perf tools: regs: Support to dump regs for PERF_SAMPLE_REGS_ABI_SIMD
Date: Thu, 25 Sep 2025 14:12:13 +0800
Message-Id: <20250925061213.178796-18-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
References: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Support the new PERF_SAMPLE_REGS_ABI_SIMD ABI. Dump the data to
perf report -D. Only the superset of the vector registers is displayed
for now.

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
index 98996e672794..e7404b2e1e24 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3259,6 +3259,16 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
 
@@ -3316,6 +3326,16 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
index 26ae078278cd..4cf6afa37d79 100644
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


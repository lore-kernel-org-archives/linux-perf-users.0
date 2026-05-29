Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812DF3B6BFF;
	Fri, 29 May 2026 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043437; cv=none; b=ECnOOJ9DCe+y6zew1iKQDTCUJLz46ciGWbpAwqjFljnSVCuSqCDO6ekPoPokh7ystKqSRL7VnCHC0Sk4P2RVAC5oXYRz3tXkvudHoljfcZAT5hPlNDflCdIYoM6JVJbESfSgHjgE5Vyvka+erAdbB2jEeQfGr6mkHlIl1QPWRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043437; c=relaxed/simple;
	bh=gRbVIFrVUjGfneIqDnqPxclESScD+RomiDo//Dr6Yas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5UZ+ir14Tt1MZ7EIelTXyBA2B7ES/vnMQ/FvETjgy8FQvniWbbKJkeVdsz8O8z+De6DzUZIVc1o2zw3C0afdllK9Sn2C2tnKGoIE3J+xmlQ0KRPq+OGSYrkzEGXEU8GWAWnUXzOEmSPPjOLhhVWiz5qtdc/jV2nL868K3rrTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atpBWbV9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atpBWbV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780043435; x=1811579435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gRbVIFrVUjGfneIqDnqPxclESScD+RomiDo//Dr6Yas=;
  b=atpBWbV9n/DcIEafNa/3RvHI6477rerOxR57FzHVHAGNTj/Lie3clqiO
   NRSolGmN1mLSEiAj4WXeedyuo34v0xjArO1G9hQqYrja9LhafsHHz/RPt
   +iJUGTF+1V0Q+OJF1K+AdknEHzH9iiTXk9fvoel/nF/wRw1VYkOJ9j68j
   udOIqCw79KzbQuqvYm8ZwsSEv5/UElpPgFX/PT+OLGKWOqSS/Phzl/Z8M
   lgu870OEPvURC3ndZOvHZzE4dGm+HyhHNkNQzSTAMBMgrSeWTwUdwpR5q
   YnSgG0H/NXVUT00cP06pcv1ESpEiKjYuLq6Y/oLcaxn69inU6Cv2MUPrO
   Q==;
X-CSE-ConnectionGUID: lyGKS94BTmS06sMM35zWjA==
X-CSE-MsgGUID: oUUw/zQrQfKfZCLbNzFiYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="81076379"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="81076379"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:30:35 -0700
X-CSE-ConnectionGUID: 8sftXwIxSA+Gzf02Ij9JOQ==
X-CSE-MsgGUID: fzEoe74MS4qMbvNPkcCoZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="247734866"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa005.jf.intel.com with ESMTP; 29 May 2026 01:30:30 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [Patch v8 4/5] perf regs: Enable dumping of SIMD registers
Date: Fri, 29 May 2026 16:24:50 +0800
Message-Id: <20260529082451.591783-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529082451.591783-1-dapeng1.mi@linux.intel.com>
References: <20260529082451.591783-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for dumping SIMD registers using the new
PERF_SAMPLE_REGS_ABI_SIMD ABI.

Currently, the XMM, YMM, ZMM, OPMASK, eGPRs, and SSP registers on x86
platforms are supported with the PERF_SAMPLE_REGS_ABI_SIMD ABI.

An example of the output is displayed below.

Example:

 $perf record -e cycles:p -Iax,bx,r8,r16,r31,ssp,xmm,ymm,zmm,opmask ./test
 $perf report -D
 ... ...
 3342715685845 0x3afe8 [0xbc8]: PERF_RECORD_SAMPLE(IP, 0x1):
 27776/27776: 0xffffffff91d7c18f period: 10000 addr: 0
 ... intr regs: mask 0x18001010003 ABI 64-bit SIMD
 .... AX    0xffffed102de1a606
 .... BX    0xffffed102de1a606
 .... R8    0x0000000000000001
 .... R16   0x0000000000000000
 .... R31   0x0000000000000000
 .... SSP   0x0000000000000000
 ... SIMD ABI nr_vectors 32 vector_qwords 8 nr_pred 8 pred_qwords 1
 .... ZMM[0][0] 0x616c2f656d6f682f
 .... ZMM[0][1] 0x696c2f7265737562
 .... ZMM[0][2] 0x0000000000000000
 .... ZMM[0][3] 0x0000000000000000
 .... ZMM[0][4] 0x0000000000000000
 .... ZMM[0][5] 0x0000000000000000
 .... ZMM[0][6] 0x0000000000000000
 .... ZMM[0][7] 0x0000000000000000
 .... ZMM[1][0] 0x702f636578656269
 .... ZMM[1][1] 0x65726f632d667265
 .... ZMM[1][2] 0x0000000000000000
 .... ZMM[1][3] 0x0000000000000000
 .... ZMM[1][4] 0x0000000000000000
 .... ZMM[1][5] 0x0000000000000000
 .... ZMM[1][6] 0x0000000000000000
 .... ZMM[1][7] 0x0000000000000000
 ... ...
 .... ZMM[31][0] 0x0000000000000000
 .... ZMM[31][1] 0x0000000000000000
 .... ZMM[31][2] 0x0000000000000000
 .... ZMM[31][3] 0x0000000000000000
 .... ZMM[31][4] 0x0000000000000000
 .... ZMM[31][5] 0x0000000000000000
 .... ZMM[31][6] 0x0000000000000000
 .... ZMM[31][7] 0x0000000000000000
 .... OPMASK[0] 0x0000000000100221
 .... OPMASK[1] 0x0000000000000020
 .... OPMASK[2] 0x000000007fffffff
 .... OPMASK[3] 0x0000000000000000
 .... OPMASK[4] 0x0000000000000000
 .... OPMASK[5] 0x0000000000000000
 .... OPMASK[6] 0x0000000000000000
 .... OPMASK[7] 0x0000000000000000
 ... ...

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/builtin-inject.c        |  9 +++-
 tools/perf/util/evsel.c            | 68 ++++++++++++++++++++++++--
 tools/perf/util/sample.h           |  5 ++
 tools/perf/util/session.c          | 78 ++++++++++++++++++++++++++++++
 tools/perf/util/synthetic-events.c | 28 +++++++++--
 5 files changed, 178 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f6611d7e85eb..de19d5bd2d57 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -457,8 +457,13 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 	/* adjust sample size for stack and regs */
 	sample_size -= sample->user_stack.size;
 	sample_size -= (hweight64(evsel->core.attr.sample_regs_user) + 1) * sizeof(u64);
-	if (sample->user_regs && sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
-		sample_size -= 4 * sizeof(u64);	/* Reduce SIMD regs header size */
+	if (sample->user_regs && sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+		sample_size -= 4 * sizeof(u64);
+		sample_size -= (sample->user_regs->nr_vectors *
+				sample->user_regs->vector_qwords +
+				sample->user_regs->nr_pred *
+				sample->user_regs->pred_qwords) * sizeof(u64);
+	}
 	sample_size += (sample->callchain->nr + 1) * sizeof(u64);
 	event_copy->header.size = sample_size;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index cd62af14a4f5..a47747c8be08 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3523,9 +3523,39 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			array = (void *)array + sz;
 
 			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
-				/* Skip SIMD-regs header. */
-				sz = 4 * sizeof(u64);
+				u64 attr_nr_vectors =
+					hweight64(evsel->core.attr.sample_simd_vec_reg_user);
+				u64 attr_vec_qwords =
+					evsel->core.attr.sample_simd_vec_reg_qwords;
+				u64 attr_nr_pred =
+					hweight32(evsel->core.attr.sample_simd_pred_reg_user);
+				u64 attr_pred_qwords =
+					 evsel->core.attr.sample_simd_pred_reg_qwords;
+
+				OVERFLOW_CHECK_u64(array);
+				regs->nr_vectors = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+				OVERFLOW_CHECK_u64(array);
+				regs->vector_qwords = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+				OVERFLOW_CHECK_u64(array);
+				regs->nr_pred = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+				OVERFLOW_CHECK_u64(array);
+				regs->pred_qwords = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+
+				if (regs->nr_vectors > attr_nr_vectors ||
+				    regs->vector_qwords > attr_vec_qwords ||
+				    regs->nr_pred > attr_nr_pred ||
+				    regs->pred_qwords > attr_pred_qwords)
+					goto out_efault;
+
+				sz = (regs->nr_vectors * regs->vector_qwords +
+				      regs->nr_pred * regs->pred_qwords) * sizeof(u64);
 				OVERFLOW_CHECK(array, sz, max_size);
+
+				regs->simd_data = (u64 *)array;
 				array = (void *)array + sz;
 			}
 		}
@@ -3587,9 +3617,39 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			array = (void *)array + sz;
 
 			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
-				/* Skip SIMD-regs header. */
-				sz = 4 * sizeof(u64);
+				u64 attr_nr_vectors =
+					hweight64(evsel->core.attr.sample_simd_vec_reg_intr);
+				u64 attr_vec_qwords =
+					evsel->core.attr.sample_simd_vec_reg_qwords;
+				u64 attr_nr_pred =
+					hweight32(evsel->core.attr.sample_simd_pred_reg_intr);
+				u64 attr_pred_qwords =
+					 evsel->core.attr.sample_simd_pred_reg_qwords;
+
+				OVERFLOW_CHECK_u64(array);
+				regs->nr_vectors = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+				OVERFLOW_CHECK_u64(array);
+				regs->vector_qwords = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+				OVERFLOW_CHECK_u64(array);
+				regs->nr_pred = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+				OVERFLOW_CHECK_u64(array);
+				regs->pred_qwords = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+
+				if (regs->nr_vectors > attr_nr_vectors ||
+				    regs->vector_qwords > attr_vec_qwords ||
+				    regs->nr_pred > attr_nr_pred ||
+				    regs->pred_qwords > attr_pred_qwords)
+					goto out_efault;
+
+				sz = (regs->nr_vectors * regs->vector_qwords +
+				      regs->nr_pred * regs->pred_qwords) * sizeof(u64);
 				OVERFLOW_CHECK(array, sz, max_size);
+
+				regs->simd_data = (u64 *)array;
 				array = (void *)array + sz;
 			}
 		}
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index e556c9b656ea..95f921d482ad 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -16,6 +16,11 @@ struct regs_dump {
 	u64 abi;
 	u64 mask;
 	u64 *regs;
+	u64 nr_vectors;
+	u64 vector_qwords;
+	u64 nr_pred;
+	u64 pred_qwords;
+	u64 *simd_data;
 
 	/* Cached values/mask filled by first register access. */
 	u64 cache_regs[PERF_SAMPLE_REGS_CACHE_SIZE];
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 9e36c834a8f4..cd8e9aaa10a1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -979,6 +979,82 @@ static void regs_dump__printf(u64 mask, struct regs_dump *regs,
 	}
 }
 
+static void simd_regs_dump__printf(uint16_t e_machine, struct regs_dump *regs, bool intr)
+{
+	const char *name = "unknown";
+	const char *simd_header;
+	u32 i, j, idx, pred_base;
+	uint16_t qwords;
+	int reg_c;
+
+	if (!(regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
+		return;
+
+	if (!regs->nr_vectors && !regs->nr_pred)
+		return;
+
+	simd_header = "... SIMD ABI nr_vectors %" PRIu64 " vector_qwords %" PRIu64 \
+		      " nr_pred %" PRIu64 "  pred_qwords %" PRIu64 "\n";
+	printf(simd_header, regs->nr_vectors, regs->vector_qwords,
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
+		for (j = 0; j < regs->vector_qwords; j++) {
+			idx = i * regs->vector_qwords + j;
+			if (regs->vector_qwords > 1) {
+				printf(".... %3s[%d][%d] 0x%016" PRIx64 "\n",
+				       name, i, j, regs->simd_data[idx++]);
+			} else {
+				printf(".... %3s[%d] 0x%016" PRIx64 "\n",
+				       name, i, regs->simd_data[idx++]);
+			}
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
+
+	pred_base = regs->nr_vectors * regs->vector_qwords;
+	for (i = 0; i < regs->nr_pred; i++) {
+		for (j = 0; j < regs->pred_qwords; j++) {
+			idx = pred_base + i * regs->pred_qwords + j;
+			if (regs->pred_qwords > 1) {
+				printf(".... %3s[%d][%d] 0x%016" PRIx64 "\n",
+				       name, i, j, regs->simd_data[idx++]);
+			} else {
+				printf(".... %3s[%d] 0x%016" PRIx64 "\n",
+				       name, i, regs->simd_data[idx++]);
+			}
+		}
+	}
+}
+
 static const char *regs_abi[] = {
 	[PERF_SAMPLE_REGS_ABI_NONE] = "none",
 	[PERF_SAMPLE_REGS_ABI_32] = "32-bit",
@@ -1019,6 +1095,7 @@ static void regs_user__printf(struct perf_sample *sample, uint16_t e_machine, ui
 
 	if (user_regs->regs)
 		regs__printf("user", user_regs, e_machine, e_flags);
+	simd_regs_dump__printf(e_machine, user_regs, /*intr=*/false);
 }
 
 static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine, uint32_t e_flags)
@@ -1032,6 +1109,7 @@ static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine, ui
 
 	if (intr_regs->regs)
 		regs__printf("intr", intr_regs, e_machine, e_flags);
+	simd_regs_dump__printf(e_machine, intr_regs, /*intr=*/true);
 }
 
 static void stack_user__printf(struct stack_dump *dump)
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index ce61734cd5d2..461a4633fd4e 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1524,8 +1524,13 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 		if (sample->user_regs && sample->user_regs->abi) {
 			result += sizeof(u64);
 			sz = hweight64(sample->user_regs->mask) * sizeof(u64);
-			if (sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
+			if (sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
 				sz += 4 * sizeof(u64);
+				sz += (sample->user_regs->nr_vectors *
+				       sample->user_regs->vector_qwords +
+				       sample->user_regs->nr_pred *
+				       sample->user_regs->pred_qwords) * sizeof(u64);
+			}
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -1554,8 +1559,13 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 		if (sample->intr_regs && sample->intr_regs->abi) {
 			result += sizeof(u64);
 			sz = hweight64(sample->intr_regs->mask) * sizeof(u64);
-			if (sample->intr_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
+			if (sample->intr_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
 				sz += 4 * sizeof(u64);
+				sz += (sample->intr_regs->nr_vectors *
+				       sample->intr_regs->vector_qwords +
+				       sample->intr_regs->nr_pred *
+				       sample->intr_regs->pred_qwords) * sizeof(u64);
+			}
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -1733,8 +1743,13 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		if (sample->user_regs && sample->user_regs->abi) {
 			*array++ = sample->user_regs->abi;
 			sz = hweight64(sample->user_regs->mask) * sizeof(u64);
-			if (sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
+			if (sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
 				sz += 4 * sizeof(u64);
+				sz += (sample->user_regs->nr_vectors *
+				       sample->user_regs->vector_qwords +
+				       sample->user_regs->nr_pred *
+				       sample->user_regs->pred_qwords) * sizeof(u64);
+			}
 			memcpy(array, sample->user_regs->regs, sz);
 			array = (void *)array + sz;
 		} else {
@@ -1771,8 +1786,13 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		if (sample->intr_regs && sample->intr_regs->abi) {
 			*array++ = sample->intr_regs->abi;
 			sz = hweight64(sample->intr_regs->mask) * sizeof(u64);
-			if (sample->intr_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
+			if (sample->intr_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
 				sz += 4 * sizeof(u64);
+				sz += (sample->intr_regs->nr_vectors *
+				       sample->intr_regs->vector_qwords +
+				       sample->intr_regs->nr_pred *
+				       sample->intr_regs->pred_qwords) * sizeof(u64);
+			}
 			memcpy(array, sample->intr_regs->regs, sz);
 			array = (void *)array + sz;
 		} else {
-- 
2.34.1


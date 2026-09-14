Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F452EEE9E;
	Mon, 14 Sep 2026 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350485; cv=none; b=QAmKhibP4JU6kKsohZZ7gCWHDMiB030s8dhBpN56KfXmurrqjvVULG09zV0GPm3+7CsRPppLrAxczrskZs1J6UfWZNQjFur4G1ac1nr5fwW1asH9pXFLWpx818BSxth25Z8+5FzR8dKjFx5edsUFM4iLh2NzeM2GSVjqJo0cJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350485; c=relaxed/simple;
	bh=abvsaE7myw7nDH++/QfG+DQyY5KO3LQvbH5TuMlh0VQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=udbJub+je6lDELSM+3G/9eY1iRyvrDa1V+jZ3tPo5sPhM4WTvA/NOGgbaaLAbTF3jb+kU+7rW6zYcOTN2BIWLnO88EYrcztNqLUFIjPVZwqO6kl7JsZwrswttvCZ+aJkiXw5QnTCWGJXa2gRp0VKUMFPlm0ZXUM4gzewZpIlGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtCGmXVU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtCGmXVU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789350483; x=1820886483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=abvsaE7myw7nDH++/QfG+DQyY5KO3LQvbH5TuMlh0VQ=;
  b=AtCGmXVUcJw9Ue4Tl53BDaOoZeGo1RjGVmWRS7KqaIqs8zUJArukgcO5
   i27Jjwj7J6DPPX+D7g+L6H05d66uyzTuur2DcKL8URB+7MOgQ99DCT6Wf
   8CA4CONJwuHvrW0s3zrBixINIqJLe0BNsxqhLZDJVj2ebb8JMWFGzLDwL
   lHbggjAHX/EHn2P+Vmidry8Lj5NxCGS0kMYqbFhEe391zDl/MGmflSQUA
   3RWcEeMTcujJ2vKXu0IMvs574CpQO2SP2C6K8FTedSfSNO2PwmO/jZePS
   aexdftj4aQuTTxtswFlTYefCWLXrisvexZo9hmvM4ZaG9iUWoeT6UuG2X
   A==;
X-CSE-ConnectionGUID: tA2RcTQsQ9OwvWcnN8qmdg==
X-CSE-MsgGUID: KHnzUiGKToC0WXGslROqVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93530665"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="93530665"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 18:48:02 -0700
X-CSE-ConnectionGUID: rWCw8vO8SwyvR4oiAq9Rxw==
X-CSE-MsgGUID: 5laeSjDCQ0uXcrAc5MjYag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="276664207"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 13 Sep 2026 18:47:57 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [Patch v11 07/10] perf regs: Enable dumping of SIMD registers
Date: Mon, 14 Sep 2026 09:40:46 +0800
Message-Id: <20260914014049.2061519-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support dumping of SIMD registers with the new PERF_SAMPLE_REGS_ABI_SIMD
ABI.

Currently, the XMM, YMM, ZMM, OPMASK, eGPRs, and SSP registers on x86
platforms are supported with the PERF_SAMPLE_REGS_ABI_SIMD ABI.

An example of the raw format output is displayed below.

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
 tools/perf/builtin-script.c                   |  91 +++++++++++--
 tools/perf/util/evsel.c                       |  68 +++++++++-
 tools/perf/util/sample.h                      |   5 +
 .../scripting-engines/trace-event-python.c    | 125 ++++++++++++++++--
 tools/perf/util/session.c                     |  82 ++++++++++++
 tools/perf/util/synthetic-events.c            |  38 +++++-
 6 files changed, 387 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ec3ce841b33e..0174489d1c0f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -719,23 +719,96 @@ static int perf_session__check_output_opt(struct perf_session *session)
 	return 0;
 }
 
-static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
+static int perf_sample__fprintf_regs(struct regs_dump *regs,
+				     struct perf_event_attr *attr,
 				     uint16_t e_machine, uint32_t e_flags,
-				     FILE *fp)
+				     FILE *fp, bool intr)
 {
-	unsigned i = 0, r;
+	const char *name = "unknown";
+	int reg_c, idx, pred_base;
+	unsigned int i = 0, j, r;
+	uint16_t qwords;
 	int printed = 0;
+	uint64_t mask;
 
-	if (!regs || !regs->regs)
+	if (!regs || (!regs->regs && !regs->simd_data))
 		return 0;
 
 	printed += fprintf(fp, " ABI:%" PRIu64 " ", regs->abi);
 
+	mask = intr ? attr->sample_regs_intr : attr->sample_regs_user;
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
-		u64 val = regs->regs[i++];
+		if (!regs->regs)
+			break;
 		printed += fprintf(fp, "%5s:0x%"PRIx64" ",
 				   perf_reg_name(r, e_machine, e_flags, regs->abi),
-				   val);
+				   regs->regs[i++]);
+	}
+
+	if (!regs->simd_data)
+		return printed;
+
+	if (!regs->nr_vectors && !regs->nr_pred)
+		return printed;
+
+	for (reg_c = 0; reg_c < 64; reg_c++) {
+		if (!regs->nr_vectors)
+			break;
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
+				printed += fprintf(fp, "%5s[%d][%d]:0x%" PRIx64 " ",
+						   name, i, j, regs->simd_data[idx]);
+			} else {
+				printed += fprintf(fp, "%5s[%d]:0x%" PRIx64 " ",
+						   name, i, regs->simd_data[idx]);
+			}
+		}
+	}
+
+	name = "unknown";
+	for (reg_c = 0; reg_c < 64; reg_c++) {
+		if (!regs->nr_pred)
+			break;
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
+				printed += fprintf(fp, "%5s[%d][%d]:0x%" PRIx64 " ",
+						   name, i, j, regs->simd_data[idx]);
+			} else {
+				printed += fprintf(fp, "%5s[%d]:0x%" PRIx64 " ",
+						   name, i, regs->simd_data[idx]);
+			}
+		}
 	}
 
 	return printed;
@@ -801,7 +874,8 @@ static int perf_sample__fprintf_iregs(struct perf_sample *sample,
 		return 0;
 
 	return perf_sample__fprintf_regs(perf_sample__intr_regs(sample),
-					 attr->sample_regs_intr, e_machine, e_flags, fp);
+					 attr, e_machine, e_flags, fp,
+					 /*intr=*/true);
 }
 
 static int perf_sample__fprintf_uregs(struct perf_sample *sample,
@@ -814,7 +888,8 @@ static int perf_sample__fprintf_uregs(struct perf_sample *sample,
 		return 0;
 
 	return perf_sample__fprintf_regs(perf_sample__user_regs(sample),
-					 attr->sample_regs_user, e_machine, e_flags, fp);
+					 attr, e_machine, e_flags, fp,
+					 /*intr=*/false);
 }
 
 static int perf_sample__fprintf_start(struct perf_script *script,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index df16780bf887..b44fd880d2d5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3715,9 +3715,39 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
@@ -3779,9 +3809,39 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
index c4eae8b2fd06..cb4b16654876 100644
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
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 11877b56548f..239104b0337d 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -711,8 +711,8 @@ static void set_sample_datasrc_in_dict(PyObject *dict,
 			_PyUnicode_FromString(decode));
 }
 
-static void regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine, uint32_t e_flags,
-		     char *bf, int size)
+static int regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine,
+		    uint32_t e_flags, char *bf, int size)
 {
 	unsigned int i = 0, r;
 	int printed = 0;
@@ -720,10 +720,10 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine,
 	bf[0] = 0;
 
 	if (size <= 0)
-		return;
+		return 0;
 
 	if (!regs || !regs->regs)
-		return;
+		return 0;
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
@@ -732,6 +732,90 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine,
 				     "%5s:0x%" PRIx64 " ",
 				     perf_reg_name(r, e_machine, e_flags, regs->abi), val);
 	}
+
+	return printed;
+}
+
+static void simd_regs_map(struct regs_dump *regs, struct perf_event_attr *attr,
+			  uint16_t e_machine, char *bf, int size, int printed, bool intr)
+{
+	const char *name = "unknown";
+	int reg_c, idx, pred_base;
+	unsigned int i = 0, j;
+	uint16_t qwords;
+
+	if (size <= 0 || printed >= size)
+		return;
+
+	if (!regs || !regs->simd_data)
+		return;
+
+	if (!regs->nr_vectors && !regs->nr_pred)
+		return;
+
+	for (reg_c = 0; reg_c < 64; reg_c++) {
+		if (!regs->nr_vectors)
+			break;
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
+				printed += scnprintf(bf + printed, size - printed,
+						"%5s[%d][%d]:0x%" PRIx64 " ",
+						name, i, j, regs->simd_data[idx]);
+			} else {
+				printed += scnprintf(bf + printed, size - printed,
+						"%5s[%d]:0x%" PRIx64 " ",
+						name, i, regs->simd_data[idx]);
+			}
+		}
+	}
+
+	name = "unknown";
+	for (reg_c = 0; reg_c < 64; reg_c++) {
+		if (!regs->nr_pred)
+			break;
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
+				printed += scnprintf(bf + printed, size - printed,
+						"%5s[%d][%d]:0x%" PRIx64 " ",
+						name, i, j, regs->simd_data[idx]);
+			} else {
+				printed += scnprintf(bf + printed, size - printed,
+						"%5s[%d]:0x%" PRIx64 " ",
+						name, i, regs->simd_data[idx]);
+			}
+		}
+	}
 }
 
 #define MAX_REG_SIZE 128
@@ -742,16 +826,36 @@ static int set_regs_in_dict(PyObject *dict,
 			     uint32_t e_flags)
 {
 	struct perf_event_attr *attr = &sample->evsel->core.attr;
-
-	int size = (__sw_hweight64(attr->sample_regs_intr) * MAX_REG_SIZE) + 1;
+	int intr_size, user_size, size;
+	struct regs_dump *regs;
 	char *bf = NULL;
+	int printed;
+
+	intr_size = (__sw_hweight64(attr->sample_regs_intr) * MAX_REG_SIZE) + 1;
+	user_size = (__sw_hweight64(attr->sample_regs_user) * MAX_REG_SIZE) + 1;
+	if (sample->intr_regs && attr->sample_simd_regs_enabled) {
+		regs = sample->intr_regs;
+		intr_size += (regs->nr_vectors * regs->vector_qwords +
+			      regs->nr_pred * regs->pred_qwords) * MAX_REG_SIZE;
+	}
+	if (sample->user_regs && attr->sample_simd_regs_enabled) {
+		regs = sample->user_regs;
+		user_size += (regs->nr_vectors * regs->vector_qwords +
+			      regs->nr_pred * regs->pred_qwords) * MAX_REG_SIZE;
+	}
+	size = intr_size > user_size ? intr_size : user_size;
 
 	if (sample->intr_regs) {
 		bf = malloc(size);
 		if (!bf)
 			return -1;
 
-		regs_map(sample->intr_regs, attr->sample_regs_intr, e_machine, e_flags, bf, size);
+		printed = regs_map(sample->intr_regs, attr->sample_regs_intr,
+				   e_machine, e_flags, bf, size);
+		if (attr->sample_simd_regs_enabled) {
+			simd_regs_map(sample->intr_regs, attr, e_machine, bf,
+				      size, printed, true);
+		}
 
 		pydict_set_item_string_decref(dict, "iregs",
 					_PyUnicode_FromString(bf));
@@ -763,7 +867,12 @@ static int set_regs_in_dict(PyObject *dict,
 			if (!bf)
 				return -1;
 		}
-		regs_map(sample->user_regs, attr->sample_regs_user, e_machine, e_flags, bf, size);
+		printed = regs_map(sample->user_regs, attr->sample_regs_user,
+				   e_machine, e_flags, bf, size);
+		if (attr->sample_simd_regs_enabled) {
+			simd_regs_map(sample->user_regs, attr, e_machine, bf,
+				      size, printed, false);
+		}
 
 		pydict_set_item_string_decref(dict, "uregs",
 					_PyUnicode_FromString(bf));
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 90d4e45f09f0..a5b596cd14be 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1446,6 +1446,86 @@ static void regs_dump__printf(u64 mask, struct regs_dump *regs,
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
+		if (!regs->nr_vectors)
+			break;
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
+				       name, i, j, regs->simd_data[idx]);
+			} else {
+				printf(".... %3s[%d] 0x%016" PRIx64 "\n",
+				       name, i, regs->simd_data[idx]);
+			}
+		}
+	}
+
+	name = "unknown";
+	for (reg_c = 0; reg_c < 64; reg_c++) {
+		if (!regs->nr_pred)
+			break;
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
+				       name, i, j, regs->simd_data[idx]);
+			} else {
+				printf(".... %3s[%d] 0x%016" PRIx64 "\n",
+				       name, i, regs->simd_data[idx]);
+			}
+		}
+	}
+}
+
 static const char *regs_abi[] = {
 	[PERF_SAMPLE_REGS_ABI_NONE] = "none",
 	[PERF_SAMPLE_REGS_ABI_32] = "32-bit",
@@ -1486,6 +1566,7 @@ static void regs_user__printf(struct perf_sample *sample, uint16_t e_machine, ui
 
 	if (user_regs->regs)
 		regs__printf("user", user_regs, e_machine, e_flags);
+	simd_regs_dump__printf(e_machine, user_regs, /*intr=*/false);
 }
 
 static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine, uint32_t e_flags)
@@ -1499,6 +1580,7 @@ static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine, ui
 
 	if (intr_regs->regs)
 		regs__printf("intr", intr_regs, e_machine, e_flags);
+	simd_regs_dump__printf(e_machine, intr_regs, /*intr=*/true);
 }
 
 static void stack_user__printf(struct stack_dump *dump)
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2779f63a442c..6c5e2327fdfa 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1644,8 +1644,13 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
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
@@ -1674,8 +1679,13 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
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
@@ -1863,6 +1873,18 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 			sz = hweight64(sample->user_regs->mask) * sizeof(u64);
 			memcpy(array, sample->user_regs->regs, sz);
 			array = (void *)array + sz;
+			if (sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				*array++ = sample->user_regs->nr_vectors;
+				*array++ = sample->user_regs->vector_qwords;
+				*array++ = sample->user_regs->nr_pred;
+				*array++ = sample->user_regs->pred_qwords;
+				sz = (sample->user_regs->nr_vectors *
+				      sample->user_regs->vector_qwords +
+				      sample->user_regs->nr_pred *
+				      sample->user_regs->pred_qwords) * sizeof(u64);
+				memcpy(array, sample->user_regs->simd_data, sz);
+				array = (void *)array + sz;
+			}
 		} else {
 			*array++ = 0;
 		}
@@ -1899,6 +1921,18 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 			sz = hweight64(sample->intr_regs->mask) * sizeof(u64);
 			memcpy(array, sample->intr_regs->regs, sz);
 			array = (void *)array + sz;
+			if (sample->intr_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				*array++ = sample->intr_regs->nr_vectors;
+				*array++ = sample->intr_regs->vector_qwords;
+				*array++ = sample->intr_regs->nr_pred;
+				*array++ = sample->intr_regs->pred_qwords;
+				sz = (sample->intr_regs->nr_vectors *
+				      sample->intr_regs->vector_qwords +
+				      sample->intr_regs->nr_pred *
+				      sample->intr_regs->pred_qwords) * sizeof(u64);
+				memcpy(array, sample->intr_regs->simd_data, sz);
+				array = (void *)array + sz;
+			}
 		} else {
 			*array++ = 0;
 		}
-- 
2.34.1


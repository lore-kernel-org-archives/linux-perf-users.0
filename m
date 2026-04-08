Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0566A3B27FD
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641418; cv=none; b=hkjKN17rJSFrrvy600mhiDhs9c+OOxmLo49blolkA6Y4WExQkRQCN5TJI7EunPGSEGwCI9agoKJpoUyPtwjo9Eg8CHpeQoqBLCe3QtPLNMCyIrPkYU8GZtfLY1IVLYvN0coqumxzqw9bs1siLbxFJSJI9yFPg20mMMJJc+ifYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641418; c=relaxed/simple;
	bh=s7ux26SlH0K5gSQ6piiJUeKsBy+p29IKND6QiEms2cA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGo2wXd1OHyyATE6skTpaS9FFw3WsdfMsCyBi9nkAgxLk6gqwYEBZPh3eMwAC5L1h8APdiO6IZWQ3n7GwLLf5R0gaWo9KwGbehV11RuTzQZhzG3ELZRo8ENiW8mjBGoCM3u5AW1iFottqLnRGtTE+c3B8HYQxxSGY9nxQ+9F85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M3jnoIBC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M3jnoIBC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 013AB351C;
	Wed,  8 Apr 2026 02:43:28 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ED693F641;
	Wed,  8 Apr 2026 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775641413; bh=s7ux26SlH0K5gSQ6piiJUeKsBy+p29IKND6QiEms2cA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M3jnoIBCRaQlyHoHFCxBOU6wLcDFlxtTnjy+a7dYjiEL+pFrdqAWIqDbARwV8GetW
	 mF9Q3d7kiRsz/b05HcU+1hV8hTsdFqIsZbMqeM/kpfXWSdmOR5pvMCzHkj6Bw89mPA
	 ujpPJPyBVjpMeapskgOutpyW5wZ+0ICA7JKdWa1U=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 08 Apr 2026 10:42:32 +0100
Subject: [PATCH v5 2/4] perf sort: Sort disabled and full predicated flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-perf_support_arm_spev1-3-v5-2-b5bcea6217bb@arm.com>
References: <20260408-perf_support_arm_spev1-3-v5-0-b5bcea6217bb@arm.com>
In-Reply-To: <20260408-perf_support_arm_spev1-3-v5-0-b5bcea6217bb@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775641408; l=2896;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=s7ux26SlH0K5gSQ6piiJUeKsBy+p29IKND6QiEms2cA=;
 b=vbk1yYboGStAWTR/AB59bUABOL8hC97zAnr8KBnBWZptBmCNC2pQcKPorI8L4VKVNxK36D0JD
 ZnECfc6Xw5NCmO7MjJP0Q6UxGZ0C5prHswKFuBX6IXyPTlqmDP2FEXs
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

According to the Arm ARM (ARM DDI 0487, L.a), section D18.2.6
"Events packet", apart from the empty predicate and partial
predicates, an SVE or SME operation can be predicate-disabled
or full predicated.

To provide complete results, introduce two predicate types for
these cases.

Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/sample.h | 13 +++++++++----
 tools/perf/util/sort.c   | 15 ++++++++++-----
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 0e5ee7e0fb94f2d36c35df15de7c4ea00547a6c2..ca0c407c4423a4bc0b8098c657238b50ff5a3a17 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -72,8 +72,8 @@ struct aux_sample {
 
 struct simd_flags {
 	u8	arch:  2,	/* architecture (isa) */
-		pred:  2,	/* predication */
-		resv:  4;	/* reserved */
+		pred:  3,	/* predication */
+		resv:  3;	/* reserved */
 };
 
 /* simd architecture flags */
@@ -85,8 +85,13 @@ enum simd_op_flags {
 };
 
 /* simd predicate flags */
-#define SIMD_OP_FLAGS_PRED_PARTIAL	0x01	/* partial predicate */
-#define SIMD_OP_FLAGS_PRED_EMPTY	0x02	/* empty predicate */
+enum simd_pred_flags {
+	SIMD_OP_FLAGS_PRED_NONE = 0x0,	/* Not available */
+	SIMD_OP_FLAGS_PRED_PARTIAL,	/* partial predicate */
+	SIMD_OP_FLAGS_PRED_EMPTY,	/* empty predicate */
+	SIMD_OP_FLAGS_PRED_FULL,	/* full predicate */
+	SIMD_OP_FLAGS_PRED_DISABLED,	/* disabled predicate */
+};
 
 /**
  * struct perf_sample
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 69ecc5be0488c749a11fe9912375d8e5408175bf..5b88613992484d53c5caa47724f5fa29dd650515 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -209,18 +209,23 @@ static int hist_entry__simd_snprintf(struct hist_entry *he, char *bf,
 				     size_t size, unsigned int width __maybe_unused)
 {
 	const char *name;
+	const char *pred_str = ".";
 
 	if (!he->simd_flags.arch)
 		return repsep_snprintf(bf, size, "");
 
 	name = hist_entry__get_simd_name(&he->simd_flags);
 
-	if (he->simd_flags.pred & SIMD_OP_FLAGS_PRED_EMPTY)
-		return repsep_snprintf(bf, size, "[e] %s", name);
-	else if (he->simd_flags.pred & SIMD_OP_FLAGS_PRED_PARTIAL)
-		return repsep_snprintf(bf, size, "[p] %s", name);
+	if (he->simd_flags.pred == SIMD_OP_FLAGS_PRED_EMPTY)
+		pred_str = "e";
+	else if (he->simd_flags.pred == SIMD_OP_FLAGS_PRED_PARTIAL)
+		pred_str = "p";
+	else if (he->simd_flags.pred == SIMD_OP_FLAGS_PRED_DISABLED)
+		pred_str = "d";
+	else if (he->simd_flags.pred == SIMD_OP_FLAGS_PRED_FULL)
+		pred_str = "f";
 
-	return repsep_snprintf(bf, size, "[.] %s", name);
+	return repsep_snprintf(bf, size, "[%s] %s", pred_str, name);
 }
 
 struct sort_entry sort_simd = {

-- 
2.34.1


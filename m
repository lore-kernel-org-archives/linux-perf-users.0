Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B190030CD84
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163912; cv=none; b=lnBywHeuzxosdE+gnwvBKzodhllJbCN193dk2l54f1yuwAV9nJaW3OoTT5dAwqx0/d0ei76w1RL577C1ZHXbPPT5PzLiPp+9HJ+H/Z0RJenlhRhl9TTlzCvwEchFH+6OICSxMQ3qqL7aezviQDW46jdo2BJ3oVDeI1ZHTKnKY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163912; c=relaxed/simple;
	bh=O2JCKwZiq/8V3Xxbek8aiCCoU93jZthj0Zm90C2K5hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JK0gilXVCcwHoxhZeFhvnAnj7Nc/Q6FnzzEtnv7y+/m06D8SaHQc4ijvFCO8Htydwe6QuveihAKaTrBx0fpgUT6DFRX9J/Kpr783O6AlPGGTXSWGVBe1lxRztXxPqHDxCFaoA4I+ubztk5fRH2SXE33Kf8G8tr7hTJFbuC9avk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1632A1758;
	Mon, 29 Sep 2025 09:38:22 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B182E3F66E;
	Mon, 29 Sep 2025 09:38:28 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:58 +0100
Subject: [PATCH 22/25] perf sort: Support sort ASE and SME
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-22-1150b3c83857@arm.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
In-Reply-To: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=1594;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=O2JCKwZiq/8V3Xxbek8aiCCoU93jZthj0Zm90C2K5hU=;
 b=Hh6yzhTmHWVaSqklEuWWWA1Prr9Yngr304iLkQNyQjpGmMKNWl7+gZB+Ngy1CwyZpMxvzWyoj
 fLE14ZglA1KD2pehRXODrruZEXhyaezZD0geytLKGNiNn+zBiXUtq5q
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Support sort Advance SIMD extension (ASE) and SME.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/sample.h | 9 ++++++---
 tools/perf/util/sort.c   | 4 ++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index fae834144ef42105d08a59704ee75cd4852bbc5a..405876885e1f273c039cb67187c6e5c39c91a612 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -67,12 +67,15 @@ struct aux_sample {
 };
 
 struct simd_flags {
-	u8	arch:1,	/* architecture (isa) */
-		pred:2;	/* predication */
+	u8	arch:  3,	/* architecture (isa) */
+		pred:  2,	/* predication */
+		resv:  3;	/* reserved */
 };
 
 /* simd architecture flags */
-#define SIMD_OP_FLAGS_ARCH_SVE		0x01	/* ARM SVE */
+#define SIMD_OP_FLAGS_ARCH_SVE		0x01	/* Arm SVE */
+#define SIMD_OP_FLAGS_ARCH_SME		0x02	/* Arm SME */
+#define SIMD_OP_FLAGS_ARCH_ASE		0x04	/* Arm Advanced SIMD */
 
 /* simd predicate flags */
 #define SIMD_OP_FLAGS_PRED_PARTIAL	0x01	/* partial predicate */
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f3a565b0e2307a8adf159725f803df5fef0dff83..c7596e9ca089c170988dbc43a00f6973039261cd 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -195,6 +195,10 @@ static const char *hist_entry__get_simd_name(struct simd_flags *simd_flags)
 
 	if (arch & SIMD_OP_FLAGS_ARCH_SVE)
 		return "SVE";
+	if (arch & SIMD_OP_FLAGS_ARCH_SME)
+		return "SME";
+	if (arch & SIMD_OP_FLAGS_ARCH_ASE)
+		return "ASE";
 	else
 		return "n/a";
 }

-- 
2.34.1


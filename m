Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2138B30C608
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163903; cv=none; b=m5n6dSJWRCqdT9IlDN3dJi4vCCX1HBT6X9eqUtW0miVOcqrCxIYLhe9nOx0JWaushQ57XoBjVS+PB2XAkPMe7kXs7KVeWc3cyDWv7el5cFTZqmY+LIKIjyc492B7S1K/BuBJRALarnzB1zdz+1lJojDZaRkZ5yRPMOTHGn8qEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163903; c=relaxed/simple;
	bh=CGpOuSW1XrnSNd6YlOb/GhLSEOQawzm0r4F/0VX1FFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e3DVOJ1UsX74VaI046bP/8uC6MJHr6Fnlx2JkeyiXUdHjCJJ+uezW0XyPYntB7btCIhg3U0hP7TBYOEb6bJduQZqg6n0hIJLCWCRhXzxzepNo8xEfFrsWa/xcKt8irUc+AMUH0XnmlhyT+TJPp4Vpnz2Ac/8K30of+mH30japOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D26311758;
	Mon, 29 Sep 2025 09:38:13 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A01B3F66E;
	Mon, 29 Sep 2025 09:38:20 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:53 +0100
Subject: [PATCH 17/25] perf arm_spe: Expose length for SVE and SME
 operations
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-17-1150b3c83857@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=2303;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=CGpOuSW1XrnSNd6YlOb/GhLSEOQawzm0r4F/0VX1FFY=;
 b=JDJuGWAKneSPQfR5GUwZ3eZ2hijxK6fK96fPfHXa3hRzIUqdmgdR6a1gABwLUiqGVB9V7xQV/
 Sr05vRs2on0BSyi1ntwvglSAtnMpFkXqhakhtNRqfdK40EACJBWmmob
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Record length for SVE and SME operations into records.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 3 +++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 9e02b2bdd1177193996d071dd88f969e25b1ad86..82e3053131db62603553bd092388879ce9a9bcd4 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -220,6 +220,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 						decoder->record.op |= ARM_SPE_OP_ATOMIC;
 				} else if (SPE_OP_PKT_LDST_SUBCLASS_SVE_SME_REG(payload)) {
 					decoder->record.op |= ARM_SPE_OP_SVE;
+					decoder->record.length = SPE_OP_PKG_SVE_EVL(payload);
 					if (payload & SPE_OP_PKT_SVE_PRED)
 						decoder->record.op |= ARM_SPE_OP_PRED;
 					if (payload & SPE_OP_PKT_SVE_SG)
@@ -239,12 +240,14 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 				decoder->record.op |= ARM_SPE_OP_OTHER;
 				if (SPE_OP_PKT_OTHER_SUBCLASS_SVE(payload)) {
 					decoder->record.op |= ARM_SPE_OP_SVE | ARM_SPE_OP_DP;
+					decoder->record.length = SPE_OP_PKG_SVE_EVL(payload);
 					if (payload & SPE_OP_PKT_OTHER_FP)
 						decoder->record.op |= ARM_SPE_OP_FP;
 					if (payload & SPE_OP_PKT_SVE_PRED)
 						decoder->record.op |= ARM_SPE_OP_PRED;
 				} else if (SPE_OP_PKT_OTHER_SUBCLASS_SME(payload)) {
 					decoder->record.op |= ARM_SPE_OP_SME;
+					decoder->record.length = SPE_OP_PKG_SME_ETS(payload);
 					if (payload & SPE_OP_PKT_OTHER_FP)
 						decoder->record.op |= ARM_SPE_OP_FP;
 				} else if (SPE_OP_PKT_OTHER_SUBCLASS_OTHER(payload)) {
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index d4574268cf793efe154f252b3e2af9c721bada97..b9288cd774bea2534d9991213c942dcbaf2a7232 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -122,6 +122,7 @@ struct arm_spe_record {
 	u64 phys_addr;
 	u64 context_id;
 	u16 source;
+	u32 length;
 };
 
 struct arm_spe_insn;

-- 
2.34.1


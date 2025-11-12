Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343C4347BB6;
	Wed, 12 Nov 2025 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971899; cv=none; b=InH38euL8UdZvhePfL8WAo633PYqTf34QMDkd9UhsAdchKnwLRITSiKIbXMGaSCyV+Wbm6X9x6oQDbD/nJWPgU+/J4Hz5mzXgiCLLnSkFu3ddjM5f+prBuyvbLtcAPp+MEqDvUHn65JYMEsDW6wRP7AygtXtMqcGxe6gZ5uQY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971899; c=relaxed/simple;
	bh=G2/h7Cz3kpY9a4X3zZdlt9hLzKN/SrbioEaOWhtErXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a4pEr2xkjJ94t8xDX35XxPPoVXGLvnzKvPH976V6ZXU+W6p5hKsR+Hk4h8Mz4IG6YER1k6BCIDoaKS+99aPjZIOQsPTKxnMoG3QV57qF/DX15eJHmHnz+d05w7QylEb94sPYLd7Q9FvuFfH5p3t5UskU3fclhDx8ncWBsD3aYTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D345B1595;
	Wed, 12 Nov 2025 10:24:49 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AA953F63F;
	Wed, 12 Nov 2025 10:24:55 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 12 Nov 2025 18:24:28 +0000
Subject: [PATCH v3 02/25] perf arm_spe: Unify operation naming
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-perf_support_arm_spev1-3-v3-2-e63c9829f9d9@arm.com>
References: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
In-Reply-To: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762971890; l=4831;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=G2/h7Cz3kpY9a4X3zZdlt9hLzKN/SrbioEaOWhtErXY=;
 b=SrqRVaY9/p9rQ5zlPD71iH3uxt1E+GD3iP1nf7ahcXUrBzE2nhd4XhpM/okLRtJsh06qDLt/B
 I5fXIott3bgBkLY+pqRzg77Txjo+zrf7MKdHMuuwh8KqHIAtIHR19Nc
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Rename extended subclass and SVE/SME register access subclass, so that
the naming can be consistent cross all sub classes.

Add an log "SVE-SME-REG" for the SVE/SME register access, this is easier
for parsing.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c   |  2 +-
 .../perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 21 ++++++++++-----------
 .../perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h |  4 ++--
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 96eb7cced6fd1574f5d823e4c67b9051dcf183ed..b0fb896abad48de93aa1ed560029f9bc9ae969e9 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -200,7 +200,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 					decoder->record.op |= ARM_SPE_OP_ST;
 				else
 					decoder->record.op |= ARM_SPE_OP_LD;
-				if (SPE_OP_PKT_IS_LDST_SVE(payload))
+				if (SPE_OP_PKT_LDST_SUBCLASS_SVE_SME_REG(payload))
 					decoder->record.op |= ARM_SPE_OP_SVE_LDST;
 				break;
 			case SPE_OP_PKT_HDR_CLASS_OTHER:
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 1a1ffe50ee73ab4400fd1163d0e84e54f4d8ab0b..f6e9c58ce62f3ae227a79d91caefaef4bd87d98a 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -362,31 +362,30 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 		arm_spe_pkt_out_string(&err, &buf, &buf_len,
 				       payload & 0x1 ? "ST" : "LD");
 
-		if (SPE_OP_PKT_IS_LDST_ATOMIC(payload)) {
+		if (SPE_OP_PKT_LDST_SUBCLASS_EXTENDED(payload)) {
 			if (payload & SPE_OP_PKT_AT)
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " AT");
 			if (payload & SPE_OP_PKT_EXCL)
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " EXCL");
 			if (payload & SPE_OP_PKT_AR)
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " AR");
-		}
-
-		if (SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP(payload))
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP(payload)) {
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " SIMD-FP");
-		else if (SPE_OP_PKT_LDST_SUBCLASS_GP_REG(payload))
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_GP_REG(payload)) {
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " GP-REG");
-		else if (SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG(payload))
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG(payload)) {
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " UNSPEC-REG");
-		else if (SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG(payload))
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG(payload)) {
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " NV-SYSREG");
-		else if (SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG(payload))
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG(payload)) {
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " MTE-TAG");
-		else if (SPE_OP_PKT_LDST_SUBCLASS_MEMCPY(payload))
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_MEMCPY(payload)) {
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " MEMCPY");
-		else if (SPE_OP_PKT_LDST_SUBCLASS_MEMSET(payload))
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_MEMSET(payload)) {
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " MEMSET");
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_SVE_SME_REG(payload)) {
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-SME-REG");
 
-		if (SPE_OP_PKT_IS_LDST_SVE(payload)) {
 			/* SVE effective vector length */
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " EVLEN %d",
 					       SPE_OP_PKG_SVE_EVL(payload));
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 75e355fe3438cc07704cb61a66ca162bd0904042..cb947e625918922dc1fa25cf8843b09661197782 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -133,14 +133,14 @@ enum arm_spe_events {
 #define SPE_OP_PKT_LDST_SUBCLASS_MEMCPY(v)	(((v) & GENMASK_ULL(7, 1)) == 0x20)
 #define SPE_OP_PKT_LDST_SUBCLASS_MEMSET(v)	(((v) & GENMASK_ULL(7, 0)) == 0x25)
 
-#define SPE_OP_PKT_IS_LDST_ATOMIC(v)		(((v) & (GENMASK_ULL(7, 5) | BIT(1))) == 0x2)
+#define SPE_OP_PKT_LDST_SUBCLASS_EXTENDED(v)	(((v) & (GENMASK_ULL(7, 5) | BIT(1))) == 0x2)
 
 #define SPE_OP_PKT_AR				BIT(4)
 #define SPE_OP_PKT_EXCL				BIT(3)
 #define SPE_OP_PKT_AT				BIT(2)
 #define SPE_OP_PKT_ST				BIT(0)
 
-#define SPE_OP_PKT_IS_LDST_SVE(v)		(((v) & (BIT(3) | BIT(1))) == 0x8)
+#define SPE_OP_PKT_LDST_SUBCLASS_SVE_SME_REG(v)	(((v) & (BIT(3) | BIT(1))) == 0x8)
 
 #define SPE_OP_PKT_SVE_SG			BIT(7)
 /*

-- 
2.34.1


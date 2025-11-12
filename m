Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC5C34B68A;
	Wed, 12 Nov 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971898; cv=none; b=ljiNxHAaodsz5vrrxkFUZv6Q+qhqDDKenS6reqb9uTheCBwsHb3j/mvvfNqu4+Loa0gYkpDjmI7GZjFfkrluewCyxsM7leHkEKQEEokvprFmYlLEEGVYiNS9W7RaZtc8qIOJOYS0W94K4fpuSyilaqPmtyqnnDCE8FZUm6GDwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971898; c=relaxed/simple;
	bh=911J1yGhIzG59kvCUApAkrk5zeOIijIY/YAoFzkTeCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bGDsOsebw1p3spFAga5Rx5zvqyM/rCnGNqT+7ETsE2hdeEMDX1YprgYWi6CEauibg20H23PumPi/BRCR5gG/3KibhDmA0QpSHySN/XJdQ0qffeWpzr27VsCpGyZkVfV8Eht/WolfXJWI2L/tS2i518EQISHgUjuqRTiHzqGxFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A92271691;
	Wed, 12 Nov 2025 10:24:47 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 731F63F63F;
	Wed, 12 Nov 2025 10:24:53 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 12 Nov 2025 18:24:27 +0000
Subject: [PATCH v3 01/25] perf arm_spe: Fix memset subclass in operation
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-perf_support_arm_spev1-3-v3-1-e63c9829f9d9@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762971890; l=4136;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=911J1yGhIzG59kvCUApAkrk5zeOIijIY/YAoFzkTeCI=;
 b=oV+oeTQnvlkmSPbhxfyc0Ha9q2cY8921i0eRNcuu6YcbgQ1ES7LUu1jeNKwdZUVK2MYzday7i
 0bYpWfDz5oUD8wnPLyQE93gis6a0nwpjshHOXowBaN7BSC/mJS9SyE/
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The operation subclass is extracted from bits [7..1] of the payload.
Since bit [0] is not parsed, there is no chance to match the memset type
(0x25). As a result, the memset payload is never parsed successfully.

Instead of extracting a unified bit field, change to extract the
specific bits for each operation subclass.

Fixes: 34fb60400e32 ("perf arm-spe: Add raw decoding for SPEv1.3 MTE and MOPS load/store")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 25 ++++++----------------
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     | 15 ++++++-------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 80561630253dd5c46f7e99b24fc13b99f346459f..1a1ffe50ee73ab4400fd1163d0e84e54f4d8ab0b 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -371,31 +371,20 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " AR");
 		}
 
-		switch (SPE_OP_PKT_LDST_SUBCLASS_GET(payload)) {
-		case SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP:
+		if (SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " SIMD-FP");
-			break;
-		case SPE_OP_PKT_LDST_SUBCLASS_GP_REG:
+		else if (SPE_OP_PKT_LDST_SUBCLASS_GP_REG(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " GP-REG");
-			break;
-		case SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG:
+		else if (SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " UNSPEC-REG");
-			break;
-		case SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG:
+		else if (SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " NV-SYSREG");
-			break;
-		case SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG:
+		else if (SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " MTE-TAG");
-			break;
-		case SPE_OP_PKT_LDST_SUBCLASS_MEMCPY:
+		else if (SPE_OP_PKT_LDST_SUBCLASS_MEMCPY(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " MEMCPY");
-			break;
-		case SPE_OP_PKT_LDST_SUBCLASS_MEMSET:
+		else if (SPE_OP_PKT_LDST_SUBCLASS_MEMSET(payload))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " MEMSET");
-			break;
-		default:
-			break;
-		}
 
 		if (SPE_OP_PKT_IS_LDST_SVE(payload)) {
 			/* SVE effective vector length */
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index d00c2481712dcc457eab2f5e9848ffc3150e6236..75e355fe3438cc07704cb61a66ca162bd0904042 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -125,14 +125,13 @@ enum arm_spe_events {
 
 #define SPE_OP_PKT_IS_OTHER_SVE_OP(v)		(((v) & (BIT(7) | BIT(3) | BIT(0))) == 0x8)
 
-#define SPE_OP_PKT_LDST_SUBCLASS_GET(v)		((v) & GENMASK_ULL(7, 1))
-#define SPE_OP_PKT_LDST_SUBCLASS_GP_REG		0x0
-#define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP	0x4
-#define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG	0x10
-#define SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG	0x30
-#define SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG	0x14
-#define SPE_OP_PKT_LDST_SUBCLASS_MEMCPY		0x20
-#define SPE_OP_PKT_LDST_SUBCLASS_MEMSET		0x25
+#define SPE_OP_PKT_LDST_SUBCLASS_GP_REG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x0)
+#define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP(v)	(((v) & GENMASK_ULL(7, 1)) == 0x4)
+#define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x10)
+#define SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x30)
+#define SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x14)
+#define SPE_OP_PKT_LDST_SUBCLASS_MEMCPY(v)	(((v) & GENMASK_ULL(7, 1)) == 0x20)
+#define SPE_OP_PKT_LDST_SUBCLASS_MEMSET(v)	(((v) & GENMASK_ULL(7, 0)) == 0x25)
 
 #define SPE_OP_PKT_IS_LDST_ATOMIC(v)		(((v) & (GENMASK_ULL(7, 5) | BIT(1))) == 0x2)
 

-- 
2.34.1


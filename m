Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAC62BEC5E;
	Wed, 12 Nov 2025 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971904; cv=none; b=VibNgGPbHg+dbQ/pzHeT0nnXIZdsgF/lRjvWL+uKw9zdp9Bbwsfjzt53thSbEpTWPcSarOO1WvPtfFLBoqNkwPz5wBHOcUCtxgz1tetSZKKN1javnTwraADrky1tW72lEfCvsWl3GOQuR/BB/gOx/NSUn4Suo2Hg5HX68w302bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971904; c=relaxed/simple;
	bh=zixE5i3+mSZRJrxDBxY30q3IwlWCPYbQatyMldJsYEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I2ttc20NSaFf04T2vjdq/njSMS6ou1lP5zG7WEN/TNVbAT9LDIgHoen9OviQ2hC33P60jeL3o3lH2hOu1+B76QkjzzA3x8/egOLKcZ+l8lUOxc1bq8hD2cetVbQYTh37qPX8BTci6FdOLcrok8mTGnSnH3R77HAHte0epKoDuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32F911595;
	Wed, 12 Nov 2025 10:24:54 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F02B13F63F;
	Wed, 12 Nov 2025 10:24:59 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 12 Nov 2025 18:24:30 +0000
Subject: [PATCH v3 04/25] perf arm_spe: Rename SPE_OP_PKT_IS_OTHER_SVE_OP
 macro
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-perf_support_arm_spev1-3-v3-4-e63c9829f9d9@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762971890; l=2605;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=zixE5i3+mSZRJrxDBxY30q3IwlWCPYbQatyMldJsYEw=;
 b=bZDR+bsM4PrMy/Y2HfaDaz672uS7iKE+SzxXAxWYD2s0EftIqYcnu5lW0vP5AirkrfYgTGLHY
 WiU81mQEU77Dv1VL5hBnzB/2RVK/8OZ/V+8wm/1CjRifk5sAph7s6Zm
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Rename the macro to SPE_OP_PKT_OTHER_SUBCLASS_SVE to unify naming.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c     | 2 +-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 2 +-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index b0fb896abad48de93aa1ed560029f9bc9ae969e9..847c29385bea8618e14b2eb21a08896041890d89 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -205,7 +205,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 				break;
 			case SPE_OP_PKT_HDR_CLASS_OTHER:
 				decoder->record.op |= ARM_SPE_OP_OTHER;
-				if (SPE_OP_PKT_IS_OTHER_SVE_OP(payload))
+				if (SPE_OP_PKT_OTHER_SUBCLASS_SVE(payload))
 					decoder->record.op |= ARM_SPE_OP_SVE_OTHER;
 				break;
 			case SPE_OP_PKT_HDR_CLASS_BR_ERET:
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 0046079edaccdd4d0c093f73395d1ecdc0007621..533920b738cbcb39136d1ba3d88e99f9d8009e74 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -340,7 +340,7 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 
 	switch (packet->index) {
 	case SPE_OP_PKT_HDR_CLASS_OTHER:
-		if (SPE_OP_PKT_IS_OTHER_SVE_OP(payload)) {
+		if (SPE_OP_PKT_OTHER_SUBCLASS_SVE(payload)) {
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, "SVE-OTHER");
 
 			/* SVE effective vector length */
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 94333e7bc382deef119414e4f1de7c2878620035..48bd9e9ef132b11b79ffe2e2fbc7cfe4c340ff92 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -123,7 +123,7 @@ enum arm_spe_events {
 #define SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC	0x1
 #define SPE_OP_PKT_HDR_CLASS_BR_ERET		0x2
 
-#define SPE_OP_PKT_IS_OTHER_SVE_OP(v)		(((v) & (BIT(7) | BIT(3) | BIT(0))) == 0x8)
+#define SPE_OP_PKT_OTHER_SUBCLASS_SVE(v)	(((v) & (BIT(7) | BIT(3) | BIT(0))) == 0x8)
 
 #define SPE_OP_PKT_LDST_SUBCLASS_GP_REG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x0)
 #define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP(v)	(((v) & GENMASK_ULL(7, 1)) == 0x4)

-- 
2.34.1


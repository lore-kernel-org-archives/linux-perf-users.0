Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C874D30C110
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163884; cv=none; b=GbzgCKBZPonjgtqOzsWyyHfyGpQgzl7I6f6GfhLA3u9cdGLlnrmlDscbMooC7HI4KvtqeIKNb+d0rAtsoIjR3oLL3sLf73jOYhXMXxF1nSa/8EXn3R9nj4B9GlXWRFOzunQjt+zpKKjZzZ5fK6N8DZ0S+ZOOvLOIzbJZHmkQvSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163884; c=relaxed/simple;
	bh=N0jNmX4wH1J25D1rmsic2Y5Tu8VYPddY1OtkCA2TvqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZeE/zojbtRhmLKvfbEfnHBeiJufXMF2L13IVccAj5iX1bbC/xpLcoHhQbOlgW0HxaqmZqzVc0ubc6WwB8iRfuAoglj5ydgUOjpcNNuQIBNmkymcNVOSqRDGy34MjKkrNHwOLZ/+8lAbGjWiKKmHM6DeDQbhokpC1Yue4cYP8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16B75150C;
	Mon, 29 Sep 2025 09:37:54 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B35453F66E;
	Mon, 29 Sep 2025 09:38:00 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:41 +0100
Subject: [PATCH 05/25] perf arm_spe: Decode ASE and FP fields in other
 operation
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-5-1150b3c83857@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=2769;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=N0jNmX4wH1J25D1rmsic2Y5Tu8VYPddY1OtkCA2TvqI=;
 b=yMrPgAwwdu7beM/NSNWmHge3OPuSTUXwm20Vq5ziRrh+6reCpw8tuYjzXFWmuzMUKwwesYvSq
 i9OUborACD8Df+86MbmAr6eraYai58qJ066oXXOMB4NHrREW1jsxspf
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add a check for other operation, which prevents any incorrectly
classifying. Parse the ASE and FP fields.

After:

  .  0000002f:  48 06                                           OTHER ASE FP INSN-OTHER
  .  00000031:  b2 08 80 48 01 08 00 ff ff                      VA 0xffff000801488008
  .  0000003a:  9a 00 00                                        LAT 0 XLAT
  .  0000003d:  42 16                                           EV RETIRED L1D-ACCESS TLB-ACCESS

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 6 +++++-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 533920b738cbcb39136d1ba3d88e99f9d8009e74..21b65a9b40f481b6cb25aaf01ab627ade046ff72 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -351,8 +351,12 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " FP");
 			if (payload & SPE_OP_PKT_SVE_PRED)
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " PRED");
-		} else {
+		} else if (SPE_OP_PKT_OTHER_SUBCLASS_OTHER(payload)) {
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, "OTHER");
+			if (payload & SPE_OP_PKT_OTHER_ASE)
+				arm_spe_pkt_out_string(&err, &buf, &buf_len, " ASE");
+			if (payload & SPE_OP_PKT_OTHER_FP)
+				arm_spe_pkt_out_string(&err, &buf, &buf_len, " FP");
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " %s",
 					       payload & SPE_OP_PKT_COND ?
 					       "COND-SELECT" : "INSN-OTHER");
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 48bd9e9ef132b11b79ffe2e2fbc7cfe4c340ff92..704601c6dbe30e93f83a82670d0d60344a22222a 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -123,8 +123,12 @@ enum arm_spe_events {
 #define SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC	0x1
 #define SPE_OP_PKT_HDR_CLASS_BR_ERET		0x2
 
+#define SPE_OP_PKT_OTHER_SUBCLASS_OTHER(v)	(((v) & GENMASK_ULL(7, 3)) == 0x0)
 #define SPE_OP_PKT_OTHER_SUBCLASS_SVE(v)	(((v) & (BIT(7) | BIT(3) | BIT(0))) == 0x8)
 
+#define SPE_OP_PKT_OTHER_ASE			BIT(2)
+#define SPE_OP_PKT_OTHER_FP			BIT(1)
+
 #define SPE_OP_PKT_LDST_SUBCLASS_GP_REG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x0)
 #define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP(v)	(((v) & GENMASK_ULL(7, 1)) == 0x4)
 #define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x10)

-- 
2.34.1


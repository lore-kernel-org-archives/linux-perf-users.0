Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1433834DB42;
	Wed, 12 Nov 2025 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971909; cv=none; b=PLdvbJaMfUxJEbCO9Go5fBAeoCEXIXcU5T7oBulM2jP8QxXvSj3vLq7+BznvE7OS6C9LmkAZhTRsGH7NYpDUzY1IpNWB75tCau0GrrsrrqEVHXWvUZIBc2MQAXREauTjO392Zp88E1zk1DrF48FUzkwgBnVwlT+OLftUjd3VcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971909; c=relaxed/simple;
	bh=Eh/nqOU+QofsS2OSXnw9Q/W0xybJNqrLOXhmO4OxKOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uo1Zp3mz4LX6RlzUmkbCLI8hmxynQhpwOi0yIV6SB4naxAkdrFDXvwQqjw1B9+keGgnwv/7ANqa+bvHSDmfGvdXsBVJYl1Nssi14aqt1NGRh9eX9gAFnVpmZD8axBy4zxyk1pVUZntPX30nEWu+FxZOTlT8RC6BsCYlV7i1OKls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FF021595;
	Wed, 12 Nov 2025 10:24:58 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D58E3F63F;
	Wed, 12 Nov 2025 10:25:04 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 12 Nov 2025 18:24:32 +0000
Subject: [PATCH v3 06/25] perf arm_spe: Decode SME data processing packet
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-perf_support_arm_spev1-3-v3-6-e63c9829f9d9@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762971890; l=3212;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=Eh/nqOU+QofsS2OSXnw9Q/W0xybJNqrLOXhmO4OxKOw=;
 b=tAXK8Gn5kIHERiBzsIgLon1W4Myyb4BlHhKv7xSzqGsQ/xcVTFkp0J+NDFDjcgHhofqrOR4Za
 wVKpLI7gvyQAG1GwVHzZgV+wT5BDFeHzkK7W4VB6sUvtqZ3ufVYJIxZ
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

For SME data processing, decode its Effective vector length or Tile Size
(ETS), and print out if a floating-point operation.

After:

  .  00000000:  49 00                                           SME-OTHER ETS 1024 FP
  .  00000002:  b2 18 3c d7 83 00 80 ff ff                      VA 0xffff800083d73c18
  .  0000000b:  9a 00 00                                        LAT 0 XLAT
  .  0000000e:  43 00                                           DATA-SOURCE 0

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c |  9 +++++++++
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 21b65a9b40f481b6cb25aaf01ab627ade046ff72..5769ba2f414049161f271fd8b8f40c440d15a75a 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -351,6 +351,15 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " FP");
 			if (payload & SPE_OP_PKT_SVE_PRED)
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " PRED");
+		} else if (SPE_OP_PKT_OTHER_SUBCLASS_SME(payload)) {
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, "SME-OTHER");
+
+			/* SME effective vector length or tile size */
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " ETS %d",
+					       SPE_OP_PKG_SME_ETS(payload));
+
+			if (payload & SPE_OP_PKT_OTHER_FP)
+				arm_spe_pkt_out_string(&err, &buf, &buf_len, " FP");
 		} else if (SPE_OP_PKT_OTHER_SUBCLASS_OTHER(payload)) {
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, "OTHER");
 			if (payload & SPE_OP_PKT_OTHER_ASE)
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 704601c6dbe30e93f83a82670d0d60344a22222a..adf4cde320aad01265b5232b0d6ff6b1f752f35f 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -125,10 +125,21 @@ enum arm_spe_events {
 
 #define SPE_OP_PKT_OTHER_SUBCLASS_OTHER(v)	(((v) & GENMASK_ULL(7, 3)) == 0x0)
 #define SPE_OP_PKT_OTHER_SUBCLASS_SVE(v)	(((v) & (BIT(7) | BIT(3) | BIT(0))) == 0x8)
+#define SPE_OP_PKT_OTHER_SUBCLASS_SME(v)	(((v) & (BIT(7) | BIT(3) | BIT(0))) == 0x88)
 
 #define SPE_OP_PKT_OTHER_ASE			BIT(2)
 #define SPE_OP_PKT_OTHER_FP			BIT(1)
 
+/*
+ * SME effective vector length or tile size (ETS) is stored in byte 0
+ * bits [6:4,2]; the length is rounded up to a power of two and use 128
+ * as one step, so ETS calculation is:
+ *
+ *   128 * (2 ^ bits [6:4,2]) = 32 << (bits [6:4,2])
+ */
+#define SPE_OP_PKG_SME_ETS(v)			(128 << (FIELD_GET(GENMASK_ULL(6, 4), (v)) << 1 | \
+							(FIELD_GET(BIT(2), (v)))))
+
 #define SPE_OP_PKT_LDST_SUBCLASS_GP_REG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x0)
 #define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP(v)	(((v) & GENMASK_ULL(7, 1)) == 0x4)
 #define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG(v)	(((v) & GENMASK_ULL(7, 1)) == 0x10)

-- 
2.34.1


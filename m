Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1592734B674;
	Wed, 12 Nov 2025 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971925; cv=none; b=kpz6pTNV7h/LL+TN0JMSfwR2l5KAOKsYHj8JF9nF7+UoUMYBJpubs9+riRZszFri7/BRgKMaoK/GxVNWlkr/WETQFnWhsQbrowwd+QuzyRXnw7jmkP5SRn8lUj+DpGDZSPWSwGSiOsrISkHA2cKjfFMW+2ZHTYYYx/FczN0TCQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971925; c=relaxed/simple;
	bh=/o6IlPDccsoR4PgqXvnisv0NgEarTT/VpnQkQ92xlAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lXEMbZhql0qPnc8AGSE+xeFqkJfMizOeK3P2WlDuQWERw7dOI9flGfpwKAlJufTdjsqnNtSKWyOvA6zkPufU3podIeDJcjTI43YW/li3T8Sz/OVZ419KN9kHlA+UxdTSfiuu05GzYzAbuxtQpHHTXIbHZi/d7mn/YnpYq+kfmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D09101515;
	Wed, 12 Nov 2025 10:25:15 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C9103F63F;
	Wed, 12 Nov 2025 10:25:21 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 12 Nov 2025 18:24:40 +0000
Subject: [PATCH v3 14/25] perf arm_spe: Report memset and memcpy in records
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-perf_support_arm_spev1-3-v3-14-e63c9829f9d9@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762971891; l=1678;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=/o6IlPDccsoR4PgqXvnisv0NgEarTT/VpnQkQ92xlAQ=;
 b=47V3c1u5vYmIY4n1IjVgZFv6xGDnXGNOZMvec/1n63rBg3N19ZiV5kX4ExuFOpXMV7qvjw2e2
 4z7+xfyX72NCYwDhLl+6vouIrEVKrh22DYwy6y3dv2ubhK9K39OawT5
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Expose memset and memcpy related info in records.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 4 ++++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 5b214fc4ca9f67cf11700a18939f37f4a5400b84..6f0390d4089599cd6bbf1357fa4cd6ec8190a58c 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -224,6 +224,10 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 						decoder->record.op |= ARM_SPE_OP_PRED;
 					if (payload & SPE_OP_PKT_SVE_SG)
 						decoder->record.op |= ARM_SPE_OP_SG;
+				} else if (SPE_OP_PKT_LDST_SUBCLASS_MEMCPY(payload)) {
+					decoder->record.op |= ARM_SPE_OP_MEMCPY;
+				} else if (SPE_OP_PKT_LDST_SUBCLASS_MEMSET(payload)) {
+					decoder->record.op |= ARM_SPE_OP_MEMSET;
 				}
 
 				break;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index d14cf6b95507bcbdb1f7e6d4908e6c40c4a8279c..3f4dae589c062d927d286b73ce53fa39795daffd 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -45,6 +45,8 @@ enum arm_spe_2nd_op_ldst {
 	ARM_SPE_OP_SIMD_FP		= 1 << 11,
 	ARM_SPE_OP_SVE			= 1 << 12,
 	ARM_SPE_OP_MTE_TAG		= 1 << 13,
+	ARM_SPE_OP_MEMCPY		= 1 << 14,
+	ARM_SPE_OP_MEMSET		= 1 << 15,
 
 	/* Assisted information for memory / SIMD */
 	ARM_SPE_OP_LD			= 1 << 20,

-- 
2.34.1


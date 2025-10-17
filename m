Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BC03126C1
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695533; cv=none; b=tLWPtXaJ2nscFymWFpvVbvTdkIEv1oRVUhz3RuwGkYbrsnYQ4ZfG7aAV7cGKZhYzugy1FTjoLT+eFmFeczT6i2HEqCbHIJOJ8KQLE4y0n+ow3V37eMgqxiQ+oSJPpHLI6dcnx833ND4o8pfHKpiDEHl1FQKbJrwcKGkkHTVIMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695533; c=relaxed/simple;
	bh=/o6IlPDccsoR4PgqXvnisv0NgEarTT/VpnQkQ92xlAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gP3aCTW4Dmoyn4JXH5VXa3LXVsosbXSjSPokn2ez1WaAGQ2OZLia4JGuyit4uLBsfq8olJMqOj++dd+GvTPlk1D58OqwWySQZwe/p3uuXNAEOHZk2a5xcMeuVYdMDzKbIA6dt+Sp429iTKIEcRo9YnxCj/1Xe9+UrrLv99brAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B7631595;
	Fri, 17 Oct 2025 03:05:24 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E37A3F59E;
	Fri, 17 Oct 2025 03:05:30 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 17 Oct 2025 11:05:03 +0100
Subject: [PATCH v2 14/25] perf arm_spe: Report memset and memcpy in records
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-perf_support_arm_spev1-3-v2-14-2d41e4746e1b@arm.com>
References: <20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com>
In-Reply-To: <20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760695507; l=1678;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=/o6IlPDccsoR4PgqXvnisv0NgEarTT/VpnQkQ92xlAQ=;
 b=wa+2C7BhtYxkvU6Ig8PHrk2z3EMfAyPdcN7oM/5ayfZrj8wt6dYY07ELGAvp1wqoBQfPmbx6R
 r+NOHLFXVpOD5JIrK8Yn9zr2Aj16IcUVxxycObccOcJE1LmvlbVE2nN
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


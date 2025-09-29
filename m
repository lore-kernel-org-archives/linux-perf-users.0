Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE36530CD82
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163895; cv=none; b=N7QHoF9IE12ygcQLH+XplGU7c+POQUx5w2nLou74uaNF0XvZc0IfRt5KQyHebX6J5Wqh3VH+hjspF94GNjfOPPJvlFL1Z6NEzhfnSyiZjr4Gf1fYvhJ4pePh3GBzhhaGc5KUhiiAY4vWibIlEFEqq41SR6OPV9EYu2tO3jRwzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163895; c=relaxed/simple;
	bh=IN1q4IBQZez4Gc/ZmEnYrKyLPI5UL1+SlIBjzXyHK0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lth1OlBY56lTWtV3fa1KtRsLsiPyQ2/1i6WbLhqjZ6piR3mEkd+xvyZzKN8loNR2GuJ6TNcUAQmQ0CUqyMRX9NtdSFeenveVwTzFw1IHkHj/a6T1Rkkf6V5MtH9G9noleF07H1StQVcAmw9rHBfcYTF4v00BHdKiWillOfnduR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A87F150C;
	Mon, 29 Sep 2025 09:38:05 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 419AE3F66E;
	Mon, 29 Sep 2025 09:38:12 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:48 +0100
Subject: [PATCH 12/25] perf arm_spe: Report extended memory operations in
 records
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-12-1150b3c83857@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=1324;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=IN1q4IBQZez4Gc/ZmEnYrKyLPI5UL1+SlIBjzXyHK0A=;
 b=Ns/KHgBy0FELdbj3bJVeUMIr95L+HG/iQPxa8FG5hHkK38B0n5/G1LqzfT/EBPUpeb6Lt/XRB
 MN7KvAgwqtnDE+w1tDI4X7u3TMLE2oRlwWwQnV5n9aIP8iPGtgwUc55
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Extended memory operations include atomic (AT), acquire/release (AR),
and exclusive (EXCL) operations. Save the relevant information
in the records.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 6696448bdf4f347e2032a1b4da46fcdd4016f9fc..949c20816826a4d45d6cf9a5efaa125acea90b0a 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -211,6 +211,13 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 					decoder->record.op |= ARM_SPE_OP_NV_SYSREG;
 				} else if (SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG(payload)) {
 					decoder->record.op |= ARM_SPE_OP_MTE_TAG;
+				} else if (SPE_OP_PKT_LDST_SUBCLASS_EXTENDED(payload)) {
+					if (payload & SPE_OP_PKT_AR)
+						decoder->record.op |= ARM_SPE_OP_AR;
+					if (payload & SPE_OP_PKT_EXCL)
+						decoder->record.op |= ARM_SPE_OP_EXCL;
+					if (payload & SPE_OP_PKT_AT)
+						decoder->record.op |= ARM_SPE_OP_ATOMIC;
 				} else if (SPE_OP_PKT_LDST_SUBCLASS_SVE_SME_REG(payload)) {
 					decoder->record.op |= ARM_SPE_OP_SVE;
 				}

-- 
2.34.1


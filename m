Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4A53630BE
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189478; cv=none; b=NS5ubLKBwJbK304Qw2lCL2kAdMeTc8jDS73+MkpX9QeCI3O0u810k2alK4vh4vQ9qBgMdKDIpFSa81ZM+ct4BaPfpQV9uT7tQ8VUldshAB8Vk8RJVnK41AbDn+bWHTnpB33GXoZNTAzvDUbpaV+nAoQe1xPIR8pH9DvPeq7Pm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189478; c=relaxed/simple;
	bh=EsjXc42366tfvkg9x9YBDMdaool8cFnnoAYZpBNa4Do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pzbKEPWOrCuJJy8CJzURI5VUwdmu1TECrjorAwyswRROQqIJYZ1bgBqiHzg87eJ3rvJglHxDJh6wlciEWYE1OwptwQ2cfTDUp5EypMf7LvbkqO4/XiChRQQUNRvYwLezP8Yn40ouYwjlfe8jfRDrjoFWlWZN6j0C+hM/xGBDIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GGcuc6SP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GGcuc6SP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAD802576;
	Thu, 11 Jun 2026 07:51:10 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC7943FBB1;
	Thu, 11 Jun 2026 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781189475; bh=EsjXc42366tfvkg9x9YBDMdaool8cFnnoAYZpBNa4Do=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GGcuc6SPqGqHJ3N6Q6IGLlZDjcUgZr1FbtPLTRygss4Gma8/3pqFMvpQOKgvC5trv
	 Hs8/Oe6BQb1GMJ+Nq18q8crCS4Dm5+oOh5PUznSe6U3dPkaxfyzyN+awuGwZfed21W
	 RFmPho0LqZM4bQ64fJyp2MqqC5GJ7zejoVKaqDJM=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 11 Jun 2026 15:50:49 +0100
Subject: [PATCH v8 3/8] perf cs-etm: Refactor instruction size handling
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-arm_cs_callchain_support_v1-v8-3-737948584fea@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v8-0-737948584fea@arm.com>
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v8-0-737948584fea@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>, 
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>, 
 Leo Yan <leo.yan@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781189463; l=2953;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=KqrInmMKKXWFoDKKGlA3eO1CNnTbpsc10BaPC7smJeI=;
 b=m7iQ3l60uXd+b9hdrKBSJRQO9rKf3xCNdykKSdAwRPrUiLmdAcFy+VU18idxeJrEPC8I0J9aa
 DAdwaptzJo0CmllIUkjes5p/iIG7duWvzf15i347O4iQBshQ11qxRvM
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

From: Leo Yan <leo.yan@linaro.org>

This patch introduces a new function cs_etm__instr_size() to calculate
the instruction size based on ISA type and instruction address.

Given the trace data can be MB and most likely that will be A64/A32 on
a lot of platforms, cs_etm__instr_addr() keeps a single ISA type check
for A64/A32 and executes an optimized calculation (addr + offset * 4).

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index b4d598ccabbd2551affdc8feed5c63bac4fee98d..4127120459418389ca7aabb9a49dead2b50e7533 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1366,6 +1366,18 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 	return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
 }
 
+static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
+				     struct cs_etm_traceid_queue *tidq,
+				     struct cs_etm_packet *packet,
+				     u64 addr)
+{
+	if (packet->isa == CS_ETM_ISA_T32)
+		return cs_etm__t32_instr_size(etmq, tidq, packet, addr);
+
+	/* Otherwise, 4-byte instruction size for A32/A64 */
+	return 4;
+}
+
 static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 {
 	/*
@@ -1394,19 +1406,17 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
 				     struct cs_etm_packet *packet,
 				     u64 offset)
 {
-	if (packet->isa == CS_ETM_ISA_T32) {
-		u64 addr = packet->start_addr;
+	u64 addr = packet->start_addr;
 
-		while (offset) {
-			addr += cs_etm__t32_instr_size(etmq, tidq, packet,
-						       addr);
-			offset--;
-		}
-		return addr;
-	}
+	/* 4-byte instruction size for A32/A64 */
+	if (packet->isa == CS_ETM_ISA_A64 || packet->isa == CS_ETM_ISA_A32)
+		return addr + offset * 4;
 
-	/* Assume a 4 byte instruction size (A32/A64) */
-	return packet->start_addr + offset * 4;
+	while (offset) {
+		addr += cs_etm__instr_size(etmq, tidq, packet, addr);
+		offset--;
+	}
+	return addr;
 }
 
 static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
@@ -1576,16 +1586,7 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 		return;
 	}
 
-	/*
-	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
-	 * cs_etm__t32_instr_size().
-	 */
-	if (packet->isa == CS_ETM_ISA_T32)
-		sample->insn_len = cs_etm__t32_instr_size(etmq, tidq, packet,
-							  sample->ip);
-	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
-	else
-		sample->insn_len = 4;
+	sample->insn_len = cs_etm__instr_size(etmq, tidq, packet, sample->ip);
 
 	cs_etm__frontend_mem_access(etmq, tidq, packet, sample->ip,
 				    sample->insn_len, (void *)sample->insn);

-- 
2.34.1


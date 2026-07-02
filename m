Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A822372EC6
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021937; cv=none; b=gnezz0UPy25YYJ6C7uSX43BlqG0d9xnAWE0C7djQlqn/1Gh5QWFatH7Binmz3ZFpuA/OyPKcc50w5Ksiet0QdslLgXrfQhDAMvi3osGxsinIpAu0vpnf9dAEAk2vFZOUsLcvhwh1y+ZRhNEKKO3OWjFjTKiPmrBW3r3fVkE3Xoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021937; c=relaxed/simple;
	bh=dZEqeszVvWHTFps5dfkPrQPN3IoOPR7fgLo0ChO+IxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LeWiIrPGM2NVpExK9SK0uu6mdcA+zqpNIhp5GvKotjmSzKY/R9HZ9wB7nNRVIXbxxlNmS9GtNarKTYYoqt/Nz716pK7IP9eQvLYhJLMUVu/PWp3yDv50+uaLv/s6sQ98WOJDcyC1WKsV37/c5aGbLsGrAw3UfwhHS3bfkRlU3pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IVRZ7Nin; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IVRZ7Nin"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2975935E4;
	Thu,  2 Jul 2026 12:52:11 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70B723F673;
	Thu,  2 Jul 2026 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783021935; bh=dZEqeszVvWHTFps5dfkPrQPN3IoOPR7fgLo0ChO+IxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IVRZ7Nin/eMy0wi4uK6quMjSBgOQww+nHe/K0EvviF02mW4re762L8api2j/m4elg
	 XPkVPTdDJG/ocYb7rv3eN+6PWX4lxery7tht0h/ibrO/J28bfVG6a4+Q4vnbc2HYEq
	 RmMRJMtWZn2336NrI+Oz8QM84YPsXFC/AhCU8m8M=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 02 Jul 2026 20:51:39 +0100
Subject: [PATCH v11 4/9] perf cs-etm: Refactor instruction size handling
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-arm_cs_callchain_support_v1-v11-4-846abbf600d7@arm.com>
References: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
In-Reply-To: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783021918; l=2953;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=CUny7lLML35FZaKxVu48mngLnJRedpr/EHWH/kZdv94=;
 b=5TeSCB+gn1XrGOCbn7ihU51NY1o4S8/i2gzqDBkuEIF/icbgf9/h0m6lr1gxSlV0iAYUCcc1r
 2wgUZCMI6/RBIjHhcTWCL20LHo6zKW1NW7g2EW3suYQJmvSlTvdJ0SZ
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
index 0ad6cccc292d6bec1596d4826390762a83c04931..838c2d00471333b86d33aa86972a3e852ba6502e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1389,6 +1389,18 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
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
@@ -1417,19 +1429,17 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
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
@@ -1599,16 +1609,7 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
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


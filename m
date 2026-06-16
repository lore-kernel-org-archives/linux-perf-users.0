Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B433BFAF7
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621500; cv=none; b=p3riZhArCrhZsWEkfMIICENIZn/3H/VKFT7XDhgMXdaDk2FNFo3RDhf0yvqrgU71c+8iIThB8SZrWtkDnrB9Z6lK+Ev7QNE/0qe288xkGucijh6ZNw6cK5IVOf1uQw9F7YlMozLgyt+AG1yEGwOGHp3zjA/kjoFsBhsTkgF9cFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621500; c=relaxed/simple;
	bh=ysJUWJWNRZ09KY16IF++nf/Xmx3pQ0MU0riqsvus9BQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DGKvA+kDKMxspFgGPrWa3SuCk9x8fcv+9qYi6H+1enUeRtCUYElh22TMuuj9TZFC+Lw5aRKSJzxS159SCHgw6PFlFe245BKNVbCi4D7bCNn/Jpu2IZbbWnAKXTRYbWDudM8VzuH2Xdn2tj6l9+7nM38V1OoLqmrLGALmOQUs0nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jytqHjo5; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jytqHjo5"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96D7E1FC7;
	Tue, 16 Jun 2026 07:51:33 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 314443F915;
	Tue, 16 Jun 2026 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781621498; bh=ysJUWJWNRZ09KY16IF++nf/Xmx3pQ0MU0riqsvus9BQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jytqHjo5+ACo8vsILQWL5LKLt9jthDgEiRuN6EtwWBGHYbJ75znb0VTvXjgsJObGD
	 wcLwR3exO4vyIA4fE3B3c4vktU9Tr7rwXGgeokQ1SD7XNKizVQ3sDLqqbY/NEj606T
	 2TZPe7cnRL9B5nIvNDHEgD7SiY2cU0jvtvLR/OXU=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 16 Jun 2026 15:51:12 +0100
Subject: [PATCH v9 4/9] perf cs-etm: Refactor instruction size handling
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-b4-arm_cs_callchain_support_v1-v9-4-f8fad931c413@arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
In-Reply-To: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781621481; l=2953;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=r9k1yf8NPCHOaIU2ub0gjIQagE9+NZF2NT9kKZmJ2Lc=;
 b=w9gOPKmi8u9XgOHBB1CD3wYu9URGrtxuCtcxFEjvnFZQP5LMdTf1kKn0PWKvv1cKve1uWLJhb
 LUZc6LV7x6HDD1h7hc6gpAWsL9EnxdMCk/Js61yGM0+pJYOzc+baq9y
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
index e2c3d2efb5982136abf9295159acab04271897a0..6827ef8871a8fc092500b93a8284d5d162558357 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1371,6 +1371,18 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
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
@@ -1399,19 +1411,17 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
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
@@ -1581,16 +1591,7 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
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


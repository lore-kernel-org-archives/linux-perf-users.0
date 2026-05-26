Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93496402BB0
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814833; cv=none; b=c4mYJqsk8XaQsiGP8pXm6fBymFc8jShTqMbBjxRyiKnGXcLIvjZjyUtUWCzAIUFojvrNocl/T8A5JxhTr88tw7TmuVlhcW8R2izmjbCdIYlm0rNiHPkG5Ez4+oK3+y0IofxiQqMSISRZVj2V/W7/ZtGMxGR551MtKiSZr0Pc8i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814833; c=relaxed/simple;
	bh=SaTCKhV9X5XIaxj8i5bXkdjLOnGu6eAtChYEGP9QO4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9tc+ARPdHvQqlmbEa67X3xcDDk2bOSwE1K5rkuFuirYFywLuVxjcqJjdvy4+Btp006onZPlii/YWJRRaeSDEAjbKZ+5qjwnfNggssHLejZX1AxZTqDrBEkASjRhnVBrGBXE0wGAZ71GjQjSKSW5SjZuhEYZxC3br+1M25mhcos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TzFrrFBI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TzFrrFBI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3BE22936;
	Tue, 26 May 2026 10:00:25 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6251F3F7B4;
	Tue, 26 May 2026 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779814830; bh=SaTCKhV9X5XIaxj8i5bXkdjLOnGu6eAtChYEGP9QO4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TzFrrFBI7EwHsfGZ8FZw0hvlEmh8yZou9LgtUhkM0dJPtgFmy037TbkmVI5YC2AcE
	 cqVLc5NFqexjfeiXEC1OBeYQM3VkPz8wzS/+hAiFoXNI+yEsIgVcF6Cl8H+nf+6W4a
	 CFg7RsGsUPfneB96V9ZBtvHvpCAXQc8fY07fIvwQ=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 26 May 2026 17:59:38 +0100
Subject: [PATCH v6 2/8] perf cs-etm: Refactor instruction size handling
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-arm_cs_callchain_support_v1-v6-2-f9f49f53c9dd@arm.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
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
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779814822; l=2911;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=vKLci/qRmKhp3PH568ZVwGpZI4ByY3CpwPqWNMiQ61c=;
 b=2Q2+xqaSrNOZSLaq0/AYgBlsPSgvkr5iFpYiEc+dumVV66Yeb9xVg7IfYygJ1U5f+Jex4n4sZ
 GKb9CmxdjXZBomJe/H6ca7ItZEUvrEjdef9RyaVPiJz6VnLHO8C/bWA
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

From: Leo Yan <leo.yan@linaro.org>

This patch introduces a new function cs_etm__instr_size() to calculate
the instruction size based on ISA type and instruction address.

Given the trace data can be MB and most likely that will be A64/A32 on
a lot of platforms, cs_etm__instr_addr() keeps a single ISA type check
for A64/A32 and executes an optimized calculation (addr + offset * 4).

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ab79d08f5a6095448470e2c3ec85ff3db2fb5634..5bff8811d61e423463b7bd4e20d599d5b5307a1a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1347,6 +1347,17 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 	return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
 }
 
+static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
+				     u8 trace_chan_id,
+				     enum cs_etm_isa isa, u64 addr)
+{
+	if (isa == CS_ETM_ISA_T32)
+		return cs_etm__t32_instr_size(etmq, trace_chan_id, addr);
+
+	/* Otherwise, 4-byte instruction size for A32/A64 */
+	return 4;
+}
+
 static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 {
 	/*
@@ -1375,19 +1386,18 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
 				     const struct cs_etm_packet *packet,
 				     u64 offset)
 {
-	if (packet->isa == CS_ETM_ISA_T32) {
-		u64 addr = packet->start_addr;
+	u64 addr = packet->start_addr;
 
-		while (offset) {
-			addr += cs_etm__t32_instr_size(etmq,
-						       trace_chan_id, addr);
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
+		addr += cs_etm__instr_size(etmq, trace_chan_id,
+					   packet->isa, addr);
+		offset--;
+	}
+	return addr;
 }
 
 static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
@@ -1540,16 +1550,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 		return;
 	}
 
-	/*
-	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
-	 * cs_etm__t32_instr_size().
-	 */
-	if (packet->isa == CS_ETM_ISA_T32)
-		sample->insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
-							  sample->ip);
-	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
-	else
-		sample->insn_len = 4;
+	sample->insn_len = cs_etm__instr_size(etmq, trace_chan_id,
+					      packet->isa, sample->ip);
 
 	cs_etm__mem_access(etmq, trace_chan_id, sample->ip, sample->insn_len,
 			   (void *)sample->insn, 0);

-- 
2.34.1


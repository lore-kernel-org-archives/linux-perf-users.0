Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373217;
	b=3uu8f2V805EmGf8tfNj+mdS7MUkzDu4oIZpymcO1Qlp1vif/nL4V79cwo4aKmwzpEtZn
	 RYIr98GmdCwtoBr0kPoPBm2F+tpp6PD5NPvEWDqND+08yrdErzRCG2g3rGQaK3jV7qNLm
	 208mOZBX9m0vPSFJcl5yV94sw+wlbfJBmHf/Ke4S7Rc9L5GZ5zefCddkEmkAJck4CI1lw
	 rm012l3ruLgZse2kYiLIBbicFWo+ZcykRrL8iIAEplet+f0OLOI2Ix5tk6L/evNvXk+Pm
	 37X4YdfbPtHreph+2a1gIvb08RT1TENWUvCUwTlDyuG4HxTnFr+qjCKLKAls415H5hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373217;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=XYUbYfpJ1kU/FT3edRMSak58G4f8Z5E0Xegt0CaNa1c=;
	b=TtNvbIUH/vG9k45KZCZi3WMopybIUhIGzi0k4Eax6k6PuehotyS8xgyLMTeWpoq8kGvL
	 Q70/pg/zwHvpByexoC1huzN5B34yYBOM814sRjWNSI+QmNtYoGrjy3457SSz7m2pEqnJb
	 NDjoTZBtvRNPjmjgjInZzDnPNqBbZnNtbyDTgRXXelEfFHfTliTZQsEgBzRNs3apE0lNe
	 Fu6fQ7ZU8CChS3FiowYC2dkJDdfZ/iaHazRES5wsq6m48cxO757hnuRsw563Ju6lAOYQh
	 nl8yQSSVfWb6HAybnYa0oRVPAyDf8EuH6EycsWSOAhCAmBsSe9z6ta1aByOK0eeyFgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hOcuT6ww;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656FD606A32F;
	Fri, 30 Oct 2026 15:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 656FD606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hOcuT6ww
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C0EC1BD0;
	Fri, 30 Oct 2026 08:13:33 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 819AF3F59E;
	Fri, 30 Oct 2026 08:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373216; bh=BSoooiGLGKzGu8BpdgDPmCLJ3dfVUU5CGa5yHLVw51Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hOcuT6wwDJ4VQV+eO7oMgYQTKFz2jG2NOTOZuVUSlLS+VzZq7//vuF1iGuj9MdM9z
	 LrvsjfUJObrwuxGmou5qZkWh8Y9DiPPqMZ8xNRr5lgdsCZBsp1jCD0vpBTFM1id8By
	 TVBATE/OOC0e8ctDayp+iqt5R+RJ/YfpXDrXLZbc=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 30 Oct 2026 15:13:12 +0000
Subject: [PATCH v3 05/14] perf cs-etm: Use the recorded instruction size
 for A32 and A64
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-5-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=2181;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=BSoooiGLGKzGu8BpdgDPmCLJ3dfVUU5CGa5yHLVw51Y=;
 b=91UvI1sbll2WAz9sQwKGKruLAz1iWbb04XvRngWxA/9KrxB1SQ4iuvNxvIFuWeQlBHM3kZdur
 9DJsGBp9DXwCpfD604SukHETZp12eEbWDsTnn9FFE2F+9u7/s69aEWY
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Use packet->last_instr_size in cs_etm__instr_size() instead of a
hard-coded value of four. Ordinary A32/A64 instruction ranges are
unchanged, since their instructions are always four bytes.

Prepare for synthesizing exception entries separately from the preceding
instruction range. An exception packet may have last_instr_size = 0,
meaning that no instruction completed at the exception source PC and the
exception return address must not advance past that PC. The thread stack
computes the return address as the source PC plus the instruction size,
so returning four would incorrectly advance the return address by four
bytes.

Keep per-address decoding for T32. A range can mix 16-bit and 32-bit
instructions, so last_instr_size describes only the final instruction
and cannot determine the size at an arbitrary address in the range.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index bdcf9481312943b2bbcade8f9688311853c138f2..9126f6327e98b67852b6a55980d67abb24de17fe 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1391,8 +1391,7 @@ static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
 	if (packet->isa == CS_ETM_ISA_T32)
 		return cs_etm__t32_instr_size(etmq, tidq, packet, addr);
 
-	/* Otherwise, 4-byte instruction size for A32/A64 */
-	return 4;
+	return packet->last_instr_size;
 }
 
 static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
@@ -1572,6 +1571,15 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 
 	sample->insn_len = cs_etm__instr_size(etmq, tidq, packet, sample->ip);
 
+	/*
+	 * The instruction length should always fit within sample->insn,
+	 * but check it to prevent an out-of-bounds write.
+	 */
+	if (sample->insn_len > sizeof(sample->insn)) {
+		sample->insn_len = 0;
+		return;
+	}
+
 	cs_etm__frontend_mem_access(etmq, tidq, packet, sample->ip,
 				    sample->insn_len, (void *)sample->insn);
 }

-- 
2.34.1


Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821928CF5D;
	Mon,  5 Oct 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217897; cv=none; b=OAjw0O/H0Rhlm+Z7SGfMfB7IcAn+ftKn1z/8qt8UPhi4JYL7UEWjL8PwZG5s1UbJwouQsUy09sHbfw7bgR30Z1OX7+oittarBm7j07qbbcFjzJyUj/cIwfGUONGnxO/As/Xh3NDe2GUakGCI5Pq40wDTqkib7KXHG1G1fRMX2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217897; c=relaxed/simple;
	bh=wq7dGTNSgRnvVQ7thpYWolsJmCrLy6uQpgwZz9GNxtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Fvo69ANUJr2mtAD4UhJAyAZ+tqnD2W1O3Rar3+k+0Dnfm9n/ltUacO5O7ZRjWdgBEsILxVaBYQ8UJPefp+z0I9hpnHAKQzVkLrWl8hV/7/vBZJbYT42kt2MHubn1PAglNq/aiiJLZBBrEztvTPM0E4Vt7+AAkWI22Q+cqVtlgvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justus-bergermann.de; spf=pass smtp.mailfrom=justus-bergermann.de; dkim=pass (2048-bit key) header.d=justus-bergermann.de header.i=mail@justus-bergermann.de header.b=0KOymN2U; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justus-bergermann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justus-bergermann.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justus-bergermann.de header.i=mail@justus-bergermann.de header.b="0KOymN2U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=justus-bergermann.de; s=s1-ionos; t=1791217889; x=1791822689;
	i=mail@justus-bergermann.de;
	bh=CsITrZyjiqvY6cgbknX8/hqfuJO7/QyGO3sp+x+4Fi0=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=0KOymN2US1ay1HT80jQuly86U65Obunk95Uyj1BV5X0bIV8bWFv4ZVM+IZbfVhJB
	 vOus/5BKCZx+5f6Vq1058azOcYeanUxt+5bzmr2Le1cN6H1sbBwXjokZXGRdjPr/A
	 E83VpCQBkhUyfIiM2WZkCx38b97ktep2So8IA+CjvkObvI6zTcy4ynOqQcJLXJhX0
	 9RCo1I1Jtd0TbsWLc1NaXp+LRZ3eqT/4aamcU7TSWT4o94/z4acvKYEUg0R8mu6TU
	 RJ9ci2I/jLCRsDKqgF/Nlse6a8HarwJS15S7a56ohWMcSob2bF7Bth9Sh6RQ8aqJU
	 huzm1+w9TlIA8yirXQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.113]) with ESMTPSA (Nemesis) id 1MTRhS-1x8DQn47lE-00NQOJ; Mon, 05
 Oct 2026 18:16:46 +0200
From: Justus Bergermann <mail@justus-bergermann.de>
Date: Mon, 05 Oct 2026 18:15:52 +0200
Subject: [PATCH] perf vendor events riscv: Add PMU events JSON file for
 T-Head C908
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20261005-c908-pmu-events-v1-1-cfab33201c59@justus-bergermann.de>
X-B4-Tracking: v=1; b=H4sIADfNw2oC/yXMTQqEMAxA4atI1hNoK/7UqwwunBo1glUalQHx7
 lZdfov3DhAKTAJVckCgnYVnH6E/Cbih8T0ht9FglMm1Uhk6q0pcpg1pJ78KZtZo2xVt6koDsVo
 Cdfx/jt/6tWy/kdx6b+A8L6gPQKxzAAAA
X-Change-ID: 20261005-c908-pmu-events-59219f7d3c82
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Justus Bergermann <justus.bergermann@mpi-sp.org>, 
 Justus Bergermann <mail@justus-bergermann.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791217003; l=26328;
 i=mail@justus-bergermann.de; s=20261005; h=from:subject:message-id;
 bh=PwZr5qlQYWGngpAqe8ibKGge2oaK0EWe9ZtnY14PLkE=;
 b=maiIl1WgYSVsXrnkbohqKBQGrtme6ZCw6UM0oazqd7Z4n179vI+UdoOrup0PGkXLFK373pHhK
 X9etQK/nSZDCFF0aJJ7fXg7NIIRpyiHyYoPi6EC1uR+DuKX96urZDLk
X-Developer-Key: i=mail@justus-bergermann.de; a=ed25519;
 pk=lSU6MMoEK602rjbVE7OO5q4vESv+gR/awWo2p3i6dWw=
X-Provags-ID: V03:K1:lyBc/VplGk5/U0YiCH1hseeiswWEJgCreJHWR0lTNYjIL9Dhf9f
 9QnnJNeyTmDGZcGm57eC7fV+ax7L+5ys0cmPabf3OwhuUsKIZBhpUlVDUn97kEpTtGCsvLL
 9vjRXo+f7h8QVAvPAf94Owl/dAAx5cuFb44MoUDdJX/3xkxR4U8Rr7HnJNTRNVgqOb67GRI
 ccHvmZIt9GXE7cqHRKfUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wo8X1gd2DUE=;CvuNwmgdA7pIIfvj/mT4sYiNOVh
 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

The XuanTie C908 cannot use the existing thead/c900-legacy event file:
The c900-legacy mapfile entry is 0x5b7-0x0-0x0, which works because the
c906 and c910 leave marchid and mimpid unimplemented, so both read
as zero. The C908 implements them: a Kendryte K230 with the c908 reports
mvendorid 0x5b7, marchid 0x8000000009140d00 and mimpid 0x50000. No entry
matches, so perf currently resolves no vendor event names at all on this
core.

Add a thead/c908 directory describing the 165 raw events defined in
Table 14.6 of the XuanTie C908 user manual, codes 0x01 to 0xb4, and a
mapfile entry for the core.

Signed-off-by: Justus Bergermann <mail@justus-bergermann.de>
=2D--
 tools/perf/pmu-events/arch/riscv/mapfile.csv       |   1 +
 .../pmu-events/arch/riscv/thead/c908/cache.json    | 127 +++++
 .../pmu-events/arch/riscv/thead/c908/firmware.json |  68 +++
 .../arch/riscv/thead/c908/instruction.json         | 192 ++++++++
 .../arch/riscv/thead/c908/microarch.json           | 512 ++++++++++++++++=
+++++
 5 files changed, 900 insertions(+)

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu=
-events/arch/riscv/mapfile.csv
index 87cfb0e0849f..51d0438b9cc8 100644
=2D-- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -21,6 +21,7 @@
 0x489-0x8000000000000[1-6]08-0x[9b][[:xdigit:]]+,v1,sifive/p650,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
 0x5b7-0x80000000090c0d00-0x2047000,v1,thead/c900-legacy,core
+0x5b7-0x8000000009140d00-0x[[:xdigit:]]+,v1,thead/c908,core
 0x602-0x3-0x0,v1,openhwgroup/cva6,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
 0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c908/cache.json b/tool=
s/perf/pmu-events/arch/riscv/thead/c908/cache.json
new file mode 100644
index 000000000000..052c771fbdea
=2D-- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c908/cache.json
@@ -0,0 +1,127 @@
+[
+  {
+    "EventName": "L1_ICACHE_ACCESS",
+    "EventCode": "0x00000001",
+    "BriefDescription": "L1-icache Access"
+  },
+  {
+    "EventName": "L1_ICACHE_MISS",
+    "EventCode": "0x00000002",
+    "BriefDescription": "L1-icache Miss"
+  },
+  {
+    "EventName": "ITLB_MISS",
+    "EventCode": "0x00000003",
+    "BriefDescription": "iTLB Miss"
+  },
+  {
+    "EventName": "JTLB_MISS",
+    "EventCode": "0x00000005",
+    "BriefDescription": "jTLB Miss"
+  },
+  {
+    "EventName": "L1_DCACHE_READ_ACCESS",
+    "EventCode": "0x0000000c",
+    "BriefDescription": "L1-dcache load access"
+  },
+  {
+    "EventName": "L1_DCACHE_READ_MISS",
+    "EventCode": "0x0000000d",
+    "BriefDescription": "L1-dcache load miss"
+  },
+  {
+    "EventName": "L1_DCACHE_WRITE_ACCESS",
+    "EventCode": "0x0000000e",
+    "BriefDescription": "L1-dcache store access"
+  },
+  {
+    "EventName": "L1_DCACHE_WRITE_MISS",
+    "EventCode": "0x0000000f",
+    "BriefDescription": "L1-dcache store miss"
+  },
+  {
+    "EventName": "IF_REFILL_STALL",
+    "EventCode": "0x00000051",
+    "BriefDescription": "IF Refill Stall"
+  },
+  {
+    "EventName": "L1_DCACHE_ACCESS",
+    "EventCode": "0x0000009b",
+    "BriefDescription": "L1 Dcache Access"
+  },
+  {
+    "EventName": "L1_DCACHE_MISS",
+    "EventCode": "0x0000009c",
+    "BriefDescription": "L1 Dcache Miss"
+  },
+  {
+    "EventName": "L1_DCACHE_EXCLUSIVE_EVICTION",
+    "EventCode": "0x0000009d",
+    "BriefDescription": "L1 Dcache Exclusive Eviction"
+  },
+  {
+    "EventName": "ICACHE_PREFETCH",
+    "EventCode": "0x0000009e",
+    "BriefDescription": "Icache Prefetch"
+  },
+  {
+    "EventName": "DCACHE_AMR_ACTIVE",
+    "EventCode": "0x0000009f",
+    "BriefDescription": "Dcache Amr Active"
+  },
+  {
+    "EventName": "ICACHE_PREFETCH_MISS",
+    "EventCode": "0x000000a0",
+    "BriefDescription": "Icache Prefetch Miss"
+  },
+  {
+    "EventName": "DCACHE_REFILL_CAUSED_BY_PREFETCH",
+    "EventCode": "0x000000a1",
+    "BriefDescription": "Dcache Refill Caused by Prefetch"
+  },
+  {
+    "EventName": "DCACHE_HIT_CAUSED_BY_PREFETCH",
+    "EventCode": "0x000000a2",
+    "BriefDescription": "Dcache Hit Caused by Prefetch"
+  },
+  {
+    "EventName": "STORE_DTLB_MISS",
+    "EventCode": "0x000000a3",
+    "BriefDescription": "Store Dtlb Miss"
+  },
+  {
+    "EventName": "LOAD_DTLB_MISS",
+    "EventCode": "0x000000a4",
+    "BriefDescription": "Load Dtlb Miss"
+  },
+  {
+    "EventName": "L2_ACCESS",
+    "EventCode": "0x000000a5",
+    "BriefDescription": "L2 Access"
+  },
+  {
+    "EventName": "L2_MISS",
+    "EventCode": "0x000000a6",
+    "BriefDescription": "L2 Miss"
+  },
+  {
+    "EventName": "SNB_READ_CREATE_VLD",
+    "EventCode": "0x000000a7",
+    "BriefDescription": "Snb Read Create Vld"
+  },
+  {
+    "EventName": "SNB_READ_CREATE_STALL",
+    "EventCode": "0x000000a8",
+    "BriefDescription": "Snb Read Create Stall"
+  },
+  {
+    "EventName": "SNB_WRITE_CREATE_VLD",
+    "EventCode": "0x000000a9",
+    "BriefDescription": "Snb Write Create Vld"
+  },
+  {
+    "EventName": "SNB_WRITE_CREATE_STALL",
+    "EventCode": "0x000000aa",
+    "BriefDescription": "Snb Write Create Stall"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c908/firmware.json b/t=
ools/perf/pmu-events/arch/riscv/thead/c908/firmware.json
new file mode 100644
index 000000000000..7149caec4f80
=2D-- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c908/firmware.json
@@ -0,0 +1,68 @@
+[
+  {
+    "ArchStdEvent": "FW_MISALIGNED_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_MISALIGNED_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ILLEGAL_INSN"
+  },
+  {
+    "ArchStdEvent": "FW_SET_TIMER"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c908/instruction.json =
b/tools/perf/pmu-events/arch/riscv/thead/c908/instruction.json
new file mode 100644
index 000000000000..401544f1d15e
=2D-- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c908/instruction.json
@@ -0,0 +1,192 @@
+[
+  {
+    "EventName": "CONDITION_BRANCH_MISPRED",
+    "EventCode": "0x00000006",
+    "BriefDescription": "Condition Branch Mispred"
+  },
+  {
+    "EventName": "CONDITION_BRANCH",
+    "EventCode": "0x00000007",
+    "BriefDescription": "Condition Branch"
+  },
+  {
+    "EventName": "INDIRECT_BRANCH_MISS",
+    "EventCode": "0x00000008",
+    "BriefDescription": "Indirect Branch Miss"
+  },
+  {
+    "EventName": "INDIRECT_BRANCH",
+    "EventCode": "0x00000009",
+    "BriefDescription": "Indirect Branch"
+  },
+  {
+    "EventName": "INST_STORE",
+    "EventCode": "0x0000000b",
+    "BriefDescription": "Store Instruction"
+  },
+  {
+    "EventName": "ISSUE_INSTRUCTION",
+    "EventCode": "0x00000016",
+    "BriefDescription": "Issue Instruction"
+  },
+  {
+    "EventName": "INST_ALU",
+    "EventCode": "0x0000001d",
+    "BriefDescription": "ALU Instruction"
+  },
+  {
+    "EventName": "INST_VECTOR",
+    "EventCode": "0x0000001f",
+    "BriefDescription": "Vector SIMD Instruction"
+  },
+  {
+    "EventName": "INST_CSR",
+    "EventCode": "0x00000020",
+    "BriefDescription": "CSR Instruction"
+  },
+  {
+    "EventName": "ATOMIC_INSTRUCTION",
+    "EventCode": "0x00000021",
+    "BriefDescription": "ATOMIC Instruction"
+  },
+  {
+    "EventName": "INST_ECALL",
+    "EventCode": "0x00000025",
+    "BriefDescription": "Environment Call"
+  },
+  {
+    "EventName": "INST_LONG_JP",
+    "EventCode": "0x00000026",
+    "BriefDescription": "Long Jump"
+  },
+  {
+    "EventName": "INST_FP",
+    "EventCode": "0x0000002a",
+    "BriefDescription": "Float Point Instruction"
+  },
+  {
+    "EventName": "LOAD_INSTRUCTION",
+    "EventCode": "0x00000030",
+    "BriefDescription": "LOAD Instruction"
+  },
+  {
+    "EventName": "FUSED_INSTRUCTION",
+    "EventCode": "0x00000031",
+    "BriefDescription": "Fused Instruction"
+  },
+  {
+    "EventName": "MULT_INSTRUCTION",
+    "EventCode": "0x00000032",
+    "BriefDescription": "MULT Instruction"
+  },
+  {
+    "EventName": "DIV_INSTRUCTION",
+    "EventCode": "0x00000033",
+    "BriefDescription": "DIV Instruction"
+  },
+  {
+    "EventName": "BRANCH_INSTRUCTION",
+    "EventCode": "0x00000036",
+    "BriefDescription": "Branch Instruction"
+  },
+  {
+    "EventName": "UNCONDITION_BRANCH",
+    "EventCode": "0x00000037",
+    "BriefDescription": "Uncondition Branch"
+  },
+  {
+    "EventName": "BRANCH_MISPRED",
+    "EventCode": "0x00000038",
+    "BriefDescription": "Branch Mispred"
+  },
+  {
+    "EventName": "UNCONDITION_BRANCH_MISPRED",
+    "EventCode": "0x00000039",
+    "BriefDescription": "Uncondition Branch Mispred"
+  },
+  {
+    "EventName": "TAKEN_BRANCH_MISPRED",
+    "EventCode": "0x0000003a",
+    "BriefDescription": "Taken Branch Mispred"
+  },
+  {
+    "EventName": "TAKEN_CONDITION_BRANCH",
+    "EventCode": "0x0000003b",
+    "BriefDescription": "Taken Condition Branch"
+  },
+  {
+    "EventName": "TAKEN_CONDITION_BRANCH_MISPRED",
+    "EventCode": "0x0000003c",
+    "BriefDescription": "Taken Condition Branch Mispred"
+  },
+  {
+    "EventName": "UNALIGN_LOAD_INSTRUCTION",
+    "EventCode": "0x0000003d",
+    "BriefDescription": "Unalign LOAD Instruction"
+  },
+  {
+    "EventName": "UNALIGN_STORE_INSTRUCTION",
+    "EventCode": "0x0000003e",
+    "BriefDescription": "Unalign STORE Instruction"
+  },
+  {
+    "EventName": "LR_INSTRUCTION",
+    "EventCode": "0x0000003f",
+    "BriefDescription": "LR Instruction"
+  },
+  {
+    "EventName": "SC_INSTRUCTION",
+    "EventCode": "0x00000040",
+    "BriefDescription": "SC Instruction"
+  },
+  {
+    "EventName": "AMO_INSTRUCTION",
+    "EventCode": "0x00000041",
+    "BriefDescription": "AMO Instruction"
+  },
+  {
+    "EventName": "BARRIER_INSTRUCTION",
+    "EventCode": "0x00000042",
+    "BriefDescription": "Barrier Instruction"
+  },
+  {
+    "EventName": "FAILED_SC_INSTRUCTION",
+    "EventCode": "0x00000043",
+    "BriefDescription": "Failed SC Instruction"
+  },
+  {
+    "EventName": "FP_DIV_INSTRUCTION",
+    "EventCode": "0x00000045",
+    "BriefDescription": "FP DIV Instruction"
+  },
+  {
+    "EventName": "FP_LOAD_INSTRUCTION",
+    "EventCode": "0x00000046",
+    "BriefDescription": "FP LOAD Instruction"
+  },
+  {
+    "EventName": "FP_STORE_INSTRUCTION",
+    "EventCode": "0x00000047",
+    "BriefDescription": "FP STORE Instruction"
+  },
+  {
+    "EventName": "VECTOR_DIV_INSTRUCTION",
+    "EventCode": "0x00000048",
+    "BriefDescription": "Vector DIV Instruction"
+  },
+  {
+    "EventName": "VECTOR_LOAD_INSTRUCTION",
+    "EventCode": "0x00000049",
+    "BriefDescription": "Vector LOAD Instruction"
+  },
+  {
+    "EventName": "VECTOR_STORE_INSTRUCTION",
+    "EventCode": "0x0000004a",
+    "BriefDescription": "Vector STORE Instruction"
+  },
+  {
+    "EventName": "VECTOR_MICRO_OP",
+    "EventCode": "0x0000004b",
+    "BriefDescription": "Vector Micro Op"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c908/microarch.json b/=
tools/perf/pmu-events/arch/riscv/thead/c908/microarch.json
new file mode 100644
index 000000000000..35d344e1f8f1
=2D-- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c908/microarch.json
@@ -0,0 +1,512 @@
+[
+  {
+    "EventName": "IFU_BRANCH_TARGET_MISPRED",
+    "EventCode": "0x0000001b",
+    "BriefDescription": "IFU Branch Target Mispred"
+  },
+  {
+    "EventName": "IFU_BRANCH_TARGET_INSTRUCTION",
+    "EventCode": "0x0000001c",
+    "BriefDescription": "IFU Branch Target Instruction"
+  },
+  {
+    "EventName": "INTERRUPT_NUMBER",
+    "EventCode": "0x00000023",
+    "BriefDescription": "Interrupt Number"
+  },
+  {
+    "EventName": "IFU_STALLED_CYCLE",
+    "EventCode": "0x00000027",
+    "BriefDescription": "Stalled Cycles Frontend"
+  },
+  {
+    "EventName": "IDU_STALLED_CYCLE",
+    "EventCode": "0x00000028",
+    "BriefDescription": "Stalled Cycles Backend"
+  },
+  {
+    "EventName": "SYNC_STALL",
+    "EventCode": "0x00000029",
+    "BriefDescription": "SYNC Stall"
+  },
+  {
+    "EventName": "M_MODE_CYCLES",
+    "EventCode": "0x0000002b",
+    "BriefDescription": "M Mode Cycles"
+  },
+  {
+    "EventName": "S_MODE_CYCLES",
+    "EventCode": "0x0000002c",
+    "BriefDescription": "S Mode Cycles"
+  },
+  {
+    "EventName": "U_MODE_CYCLES",
+    "EventCode": "0x0000002d",
+    "BriefDescription": "U Mode Cycles"
+  },
+  {
+    "EventName": "EXCEPTION_NUMBER",
+    "EventCode": "0x0000002e",
+    "BriefDescription": "Exception Number"
+  },
+  {
+    "EventName": "FLUSH_NUMBER",
+    "EventCode": "0x0000002f",
+    "BriefDescription": "Flush Number"
+  },
+  {
+    "EventName": "MULT_INNER_FORWARD",
+    "EventCode": "0x00000034",
+    "BriefDescription": "Mult Inner Forward"
+  },
+  {
+    "EventName": "DIV_BUFFER_HIT",
+    "EventCode": "0x00000035",
+    "BriefDescription": "DIV Buffer Hit"
+  },
+  {
+    "EventName": "BUS_BARRIER",
+    "EventCode": "0x00000044",
+    "BriefDescription": "Bus Barrier"
+  },
+  {
+    "EventName": "ECC_INTERRUPT",
+    "EventCode": "0x0000004c",
+    "BriefDescription": "ECC Interrupt"
+  },
+  {
+    "EventName": "ASYNC_ABORT_INTERRUPT",
+    "EventCode": "0x0000004d",
+    "BriefDescription": "Async Abort Interrupt"
+  },
+  {
+    "EventName": "IF_STALL",
+    "EventCode": "0x0000004e",
+    "BriefDescription": "IF Stall"
+  },
+  {
+    "EventName": "IP_STALL",
+    "EventCode": "0x0000004f",
+    "BriefDescription": "IP Stall"
+  },
+  {
+    "EventName": "IB_STALL",
+    "EventCode": "0x00000050",
+    "BriefDescription": "IB Stall"
+  },
+  {
+    "EventName": "IF_MMU_STALL",
+    "EventCode": "0x00000052",
+    "BriefDescription": "IF Mmu Stall"
+  },
+  {
+    "EventName": "IB_MISPRED_STALL",
+    "EventCode": "0x00000053",
+    "BriefDescription": "IB Mispred Stall"
+  },
+  {
+    "EventName": "IB_FIFO_STALL",
+    "EventCode": "0x00000054",
+    "BriefDescription": "IB Fifo Stall"
+  },
+  {
+    "EventName": "IB_IND_BTB_RD_STALL",
+    "EventCode": "0x00000055",
+    "BriefDescription": "IB Ind Btb Rd Stall"
+  },
+  {
+    "EventName": "IB_VSETVL_STALL",
+    "EventCode": "0x00000056",
+    "BriefDescription": "IB Vsetvl Stall"
+  },
+  {
+    "EventName": "ID_STALL",
+    "EventCode": "0x00000057",
+    "BriefDescription": "ID Stall"
+  },
+  {
+    "EventName": "RF_STALL",
+    "EventCode": "0x00000058",
+    "BriefDescription": "RF Stall"
+  },
+  {
+    "EventName": "EU_STALL",
+    "EventCode": "0x00000059",
+    "BriefDescription": "EU Stall"
+  },
+  {
+    "EventName": "ID_INST_PIPEDOWN",
+    "EventCode": "0x0000005a",
+    "BriefDescription": "ID Inst Pipedown"
+  },
+  {
+    "EventName": "RF_INST_PIPEDOWN",
+    "EventCode": "0x0000005b",
+    "BriefDescription": "RF Inst Pipedown"
+  },
+  {
+    "EventName": "ID_ONE_INST_PIPEDOWN",
+    "EventCode": "0x0000005c",
+    "BriefDescription": "ID One Inst Pipedown"
+  },
+  {
+    "EventName": "ID_CSR_BEFORE_FENCE_STALL",
+    "EventCode": "0x0000005d",
+    "BriefDescription": "ID CSR Before Fence Stall"
+  },
+  {
+    "EventName": "ID_VSETVL_FOF_STALL",
+    "EventCode": "0x0000005e",
+    "BriefDescription": "ID VSETVL Fof Stall"
+  },
+  {
+    "EventName": "ID_FLUSH_STALL",
+    "EventCode": "0x0000005f",
+    "BriefDescription": "ID Flush Stall"
+  },
+  {
+    "EventName": "ID_MISPREDICTION_STALL",
+    "EventCode": "0x00000060",
+    "BriefDescription": "ID Misprediction Stall"
+  },
+  {
+    "EventName": "ID_IID_NOT_VLD_STALL",
+    "EventCode": "0x00000061",
+    "BriefDescription": "ID IID Not Vld Stall"
+  },
+  {
+    "EventName": "RF_ONE_INST_PIPEDOWN",
+    "EventCode": "0x00000062",
+    "BriefDescription": "RF One Inst Pipedown"
+  },
+  {
+    "EventName": "RF_RAW_STALL",
+    "EventCode": "0x00000063",
+    "BriefDescription": "RF RAW Stall"
+  },
+  {
+    "EventName": "RF_WAW_STALL",
+    "EventCode": "0x00000064",
+    "BriefDescription": "RF WAW Stall"
+  },
+  {
+    "EventName": "RF_STRUCTURE_STALL",
+    "EventCode": "0x00000065",
+    "BriefDescription": "RF Structure Stall"
+  },
+  {
+    "EventName": "RF_CSR_AFTER_FENCE_STALL",
+    "EventCode": "0x00000066",
+    "BriefDescription": "RF CSR After Fence Stall"
+  },
+  {
+    "EventName": "EU_IU_FULL",
+    "EventCode": "0x00000067",
+    "BriefDescription": "EU IU Full"
+  },
+  {
+    "EventName": "EU_IU_CONTROL_FULL",
+    "EventCode": "0x00000068",
+    "BriefDescription": "EU IU Control Full"
+  },
+  {
+    "EventName": "EU_CP0_FULL",
+    "EventCode": "0x00000069",
+    "BriefDescription": "EU CP0 Full"
+  },
+  {
+    "EventName": "EU_LSU_LOAD_FULL",
+    "EventCode": "0x0000006a",
+    "BriefDescription": "EU LSU LOAD Full"
+  },
+  {
+    "EventName": "EU_LSU_STORE_FULL",
+    "EventCode": "0x0000006b",
+    "BriefDescription": "EU LSU STORE Full"
+  },
+  {
+    "EventName": "EU_VFPU_FULL",
+    "EventCode": "0x0000006c",
+    "BriefDescription": "EU VFPU Full"
+  },
+  {
+    "EventName": "EU_BJU_FULL",
+    "EventCode": "0x0000006d",
+    "BriefDescription": "EU BJU Full"
+  },
+  {
+    "EventName": "IU_DP_STALL_PIPE0",
+    "EventCode": "0x0000006e",
+    "BriefDescription": "IU Dp Stall Pipe0"
+  },
+  {
+    "EventName": "IU_MULT_STALL_PIPE0",
+    "EventCode": "0x0000006f",
+    "BriefDescription": "IU MULT Stall Pipe0"
+  },
+  {
+    "EventName": "IU_DIV_EX1_STALL_PIPE0",
+    "EventCode": "0x00000070",
+    "BriefDescription": "IU DIV EX1 Stall Pipe0"
+  },
+  {
+    "EventName": "IU_DP_STALL_PIPE1",
+    "EventCode": "0x00000071",
+    "BriefDescription": "IU Dp Stall Pipe1"
+  },
+  {
+    "EventName": "IU_MULT_STALL_PIPE1",
+    "EventCode": "0x00000072",
+    "BriefDescription": "IU MULT Stall Pipe1"
+  },
+  {
+    "EventName": "IU_DIV_EX1_STALL_PIPE1",
+    "EventCode": "0x00000073",
+    "BriefDescription": "IU DIV EX1 Stall Pipe1"
+  },
+  {
+    "EventName": "IU_DP_WB_CONFLICT_PIPE0",
+    "EventCode": "0x00000074",
+    "BriefDescription": "IU DP Wb Conflict Pipe0"
+  },
+  {
+    "EventName": "IU_DP_WAW_STALL_PIPE0",
+    "EventCode": "0x00000075",
+    "BriefDescription": "IU DP WAW Stall Pipe0"
+  },
+  {
+    "EventName": "IU_DP_UNCOMMIT_PIPE0",
+    "EventCode": "0x00000076",
+    "BriefDescription": "IU DP Uncommit Pipe0"
+  },
+  {
+    "EventName": "IU_DP_WB_CONFLICT_PIPE1",
+    "EventCode": "0x00000077",
+    "BriefDescription": "IU DP Wb Conflict Pipe1"
+  },
+  {
+    "EventName": "IU_DP_WAW_STALL_PIPE1",
+    "EventCode": "0x00000078",
+    "BriefDescription": "IU DP WAW Stall Pipe1"
+  },
+  {
+    "EventName": "IU_DP_UNCOMMIT_PIPE1",
+    "EventCode": "0x00000079",
+    "BriefDescription": "IU DP Uncommit Pipe1"
+  },
+  {
+    "EventName": "IU_MULT_UNCOMMIT",
+    "EventCode": "0x0000007a",
+    "BriefDescription": "IU MULT Uncommit"
+  },
+  {
+    "EventName": "IU_MULT_WB_STALL",
+    "EventCode": "0x0000007b",
+    "BriefDescription": "IU MULT Wb Stall"
+  },
+  {
+    "EventName": "IU_DIV_UNCOMMIT",
+    "EventCode": "0x0000007c",
+    "BriefDescription": "IU DIV Uncommit"
+  },
+  {
+    "EventName": "IU_DIV_WB_STALL",
+    "EventCode": "0x0000007d",
+    "BriefDescription": "IU DIV Wb Stall"
+  },
+  {
+    "EventName": "LSU_LOAD_WAW_STALL",
+    "EventCode": "0x0000007e",
+    "BriefDescription": "LSU LOAD WAW Stall"
+  },
+  {
+    "EventName": "LSU_LOAD_COMMIT_STALL",
+    "EventCode": "0x0000007f",
+    "BriefDescription": "LSU LOAD Commit Stall"
+  },
+  {
+    "EventName": "LSU_LOAD_RAW_STALL",
+    "EventCode": "0x00000080",
+    "BriefDescription": "LSU LOAD RAW Stall"
+  },
+  {
+    "EventName": "LSU_STORE_COMMIT_STALL",
+    "EventCode": "0x00000081",
+    "BriefDescription": "LSU STORE Commit Stall"
+  },
+  {
+    "EventName": "VIDU_RF_NO_PIPEDOWN",
+    "EventCode": "0x00000082",
+    "BriefDescription": "Vidu Rf No Pipedown"
+  },
+  {
+    "EventName": "VPU_STALL_PIPE0",
+    "EventCode": "0x00000083",
+    "BriefDescription": "VPU Stall Pipe0"
+  },
+  {
+    "EventName": "VPU_STALL_PIPE1",
+    "EventCode": "0x00000084",
+    "BriefDescription": "VPU Stall Pipe1"
+  },
+  {
+    "EventName": "VPU_STRUCT_HAZARD_STALL_PIPE0",
+    "EventCode": "0x00000085",
+    "BriefDescription": "VPU Struct Hazard Stall Pipe0"
+  },
+  {
+    "EventName": "VPU_UNCOMMIT_STALL_PIPE0",
+    "EventCode": "0x00000086",
+    "BriefDescription": "VPU Uncommit Stall Pipe0"
+  },
+  {
+    "EventName": "VPU_VLSU_STALL_PIPE0",
+    "EventCode": "0x00000087",
+    "BriefDescription": "VPU VLSU Stall Pipe0"
+  },
+  {
+    "EventName": "VPU_STRUCT_HAZARD_STALL_PIPE1",
+    "EventCode": "0x00000088",
+    "BriefDescription": "VPU Struct Hazard Stall Pipe1"
+  },
+  {
+    "EventName": "VPU_UNCOMMIT_STALL_PIPE1",
+    "EventCode": "0x00000089",
+    "BriefDescription": "VPU Uncommit Stall Pipe1"
+  },
+  {
+    "EventName": "VPU_VLSU_STALL_PIPE1",
+    "EventCode": "0x0000008a",
+    "BriefDescription": "VPU VLSU Stall Pipe1"
+  },
+  {
+    "EventName": "VFPU_FDIV_VDIV_BUSY",
+    "EventCode": "0x0000008b",
+    "BriefDescription": "VFPU FDIV/VDIV Busy"
+  },
+  {
+    "EventName": "BJU_CP0_STALL",
+    "EventCode": "0x0000008c",
+    "BriefDescription": "BJU CP0 Stall"
+  },
+  {
+    "EventName": "BJU_IBUF_STALL",
+    "EventCode": "0x0000008d",
+    "BriefDescription": "BJU IBUF Stall"
+  },
+  {
+    "EventName": "BJU_WB_STALL",
+    "EventCode": "0x0000008e",
+    "BriefDescription": "BJU Wb Stall"
+  },
+  {
+    "EventName": "BJU_PIPEDOWN_STALL",
+    "EventCode": "0x0000008f",
+    "BriefDescription": "BJU Pipedown Stall"
+  },
+  {
+    "EventName": "RTU_FLUSH",
+    "EventCode": "0x00000090",
+    "BriefDescription": "RTU Flush"
+  },
+  {
+    "EventName": "RTU_IU_NOT_NO_OP",
+    "EventCode": "0x00000091",
+    "BriefDescription": "RTU IU Not No OP"
+  },
+  {
+    "EventName": "RTU_BJU_NOT_NO_OP",
+    "EventCode": "0x00000092",
+    "BriefDescription": "RTU BJU Not No OP"
+  },
+  {
+    "EventName": "RTU_LSU_NOT_NO_OP",
+    "EventCode": "0x00000093",
+    "BriefDescription": "RTU LSU Not No OP"
+  },
+  {
+    "EventName": "RTU_CP0_NOT_NO_OP",
+    "EventCode": "0x00000094",
+    "BriefDescription": "RTU CP0 Not No OP"
+  },
+  {
+    "EventName": "RTU_VFPU_NOT_NO_OP",
+    "EventCode": "0x00000095",
+    "BriefDescription": "RTU VFPU Not No OP"
+  },
+  {
+    "EventName": "RTU_ONLY_IU_NOT_NO_OP",
+    "EventCode": "0x00000096",
+    "BriefDescription": "RTU Only IU Not No OP"
+  },
+  {
+    "EventName": "RTU_ONLY_BJU_NOT_NO_OP",
+    "EventCode": "0x00000097",
+    "BriefDescription": "RTU Only BJU Not No OP"
+  },
+  {
+    "EventName": "RTU_ONLY_LSU_NOT_NO_OP",
+    "EventCode": "0x00000098",
+    "BriefDescription": "RTU Only LSU Not No OP"
+  },
+  {
+    "EventName": "RTU_ONLY_CP0_NOT_NO_OP",
+    "EventCode": "0x00000099",
+    "BriefDescription": "RTU Only CP0 Not No OP"
+  },
+  {
+    "EventName": "RTU_ONLY_VFPU_NOT_NO_OP",
+    "EventCode": "0x0000009a",
+    "BriefDescription": "RTU Only VFPU Not No OP"
+  },
+  {
+    "EventName": "IQ_FULL",
+    "EventCode": "0x000000ab",
+    "BriefDescription": "Iq Full"
+  },
+  {
+    "EventName": "VIDU_VEC0_STALL",
+    "EventCode": "0x000000ac",
+    "BriefDescription": "Vidu Vec0 Stall"
+  },
+  {
+    "EventName": "VIDU_VEC1_STALL",
+    "EventCode": "0x000000ad",
+    "BriefDescription": "Vidu Vec1 Stall"
+  },
+  {
+    "EventName": "VIDU_VEC0_DEPEND_STALL",
+    "EventCode": "0x000000ae",
+    "BriefDescription": "Vidu Vec0 Depend Stall"
+  },
+  {
+    "EventName": "VIDU_VEC0_STRUCT_HAZARD_STALL",
+    "EventCode": "0x000000af",
+    "BriefDescription": "Vidu Vec0 Struct Hazard Stall"
+  },
+  {
+    "EventName": "VIDU_VEC1_DEPEND_STALL",
+    "EventCode": "0x000000b0",
+    "BriefDescription": "Vidu Vec1 Depend Stall"
+  },
+  {
+    "EventName": "VIDU_VEC1_STRUCT_HAZARD_STALL",
+    "EventCode": "0x000000b1",
+    "BriefDescription": "Vidu Vec1 Struct Hazard Stall"
+  },
+  {
+    "EventName": "VIDU_TOTAL_CYCLE",
+    "EventCode": "0x000000b2",
+    "BriefDescription": "Vidu Total Cycle"
+  },
+  {
+    "EventName": "VIDU_VEC0_CYCLE",
+    "EventCode": "0x000000b3",
+    "BriefDescription": "Vidu Vec0 Cycle"
+  },
+  {
+    "EventName": "VIDU_VEC1_CYCLE",
+    "EventCode": "0x000000b4",
+    "BriefDescription": "Vidu Vec1 Cycle"
+  }
+]

=2D--
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20261005-c908-pmu-events-59219f7d3c82

Best regards,
=2D- =20
Justus Bergermann <mail@justus-bergermann.de>


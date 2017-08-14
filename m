From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: perf bpf: Reworked fix endianness problem when loading parameters in prologue
Date: Mon, 14 Aug 2017 11:47:40 +0200
Message-ID: <20170814094740.62459-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752521AbdHNJrq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Aug 2017 05:47:46 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7E9i40F028678
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2017 05:47:46 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2cb3qfx6pa-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2017 05:47:45 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Mon, 14 Aug 2017 10:47:44 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, linux-perf-users@vger.kernel.org, wangnan0@huawei.com
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Li Zefan <lizefan@huawei.com>

Perf BPF prologue generator unconditionally fetches 8 bytes for function
parameters, which causes problem on big endian machine. Thomas gives a
detail analysis for this problem:

 http://lkml.kernel.org/r/968ebda5-abe4-8830-8d69-49f62529d151@linux.vnet.ibm.com

This patch parses the type of each argument and converts data from
memory to expected type.

Now the test runs successfully on 4.13.0-rc5:
[root@s8360046 perf]# ./perf test  bpf
38: BPF filter                                 :
38.1: Basic BPF filtering                      : Ok
38.2: BPF pinning                              : Ok
38.3: BPF prologue generation                  : Ok
38.4: BPF relocation checker                   : Ok
[root@s8360046 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Li Zefan <lizefan@huawei.com>
---
 tools/perf/util/bpf-prologue.c | 49 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
index 1356220..827f914 100644
--- a/tools/perf/util/bpf-prologue.c
+++ b/tools/perf/util/bpf-prologue.c
@@ -58,6 +58,46 @@ check_pos(struct bpf_insn_pos *pos)
 	return 0;
 }
 
+/*
+ * Convert type string (u8/u16/u32/u64/s8/s16/s32/s64 ..., see
+ * Documentation/trace/kprobetrace.txt) to size field of BPF_LDX_MEM
+ * instruction (BPF_{B,H,W,DW}).
+ */
+static int
+argtype_to_ldx_size(const char *type)
+{
+	int arg_size = type ? atoi(&type[1]) : 64;
+
+	switch (arg_size) {
+	case 8:
+		return BPF_B;
+	case 16:
+		return BPF_H;
+	case 32:
+		return BPF_W;
+	case 64:
+	default:
+		return BPF_DW;
+	}
+}
+
+static const char *
+insn_sz_to_str(int insn_sz)
+{
+	switch (insn_sz) {
+	case BPF_B:
+		return "BPF_B";
+	case BPF_H:
+		return "BPF_H";
+	case BPF_W:
+		return "BPF_W";
+	case BPF_DW:
+		return "BPF_DW";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 /* Give it a shorter name */
 #define ins(i, p) append_insn((i), (p))
 
@@ -258,9 +298,14 @@ gen_prologue_slowpath(struct bpf_insn_pos *pos,
 	}
 
 	/* Final pass: read to registers */
-	for (i = 0; i < nargs; i++)
-		ins(BPF_LDX_MEM(BPF_DW, BPF_PROLOGUE_START_ARG_REG + i,
+	for (i = 0; i < nargs; i++) {
+		int insn_sz = (args[i].ref) ? argtype_to_ldx_size(args[i].type) : BPF_DW;
+
+		pr_debug("prologue: load arg %d, insn_sz is %s\n",
+			 i, insn_sz_to_str(insn_sz));
+		ins(BPF_LDX_MEM(insn_sz, BPF_PROLOGUE_START_ARG_REG + i,
 				BPF_REG_FP, -BPF_REG_SIZE * (i + 1)), pos);
+	}
 
 	ins(BPF_JMP_IMM(BPF_JA, BPF_REG_0, 0, JMP_TO_SUCCESS_CODE), pos);
 
-- 
2.9.3

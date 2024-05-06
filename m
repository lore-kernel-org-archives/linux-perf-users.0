Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6B144D28;
	Mon,  6 May 2024 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997997; cv=none; b=COyUj5NZQL2CklsOKs+N1nCp8eWSqQo65vTM/1Y+PT9iXNHUP7/gPUSf4QrfEvuhpMkua7qCy8R6PHMSQoRSqQodqe7H4EVQMp4KxE1McYQJr54PTHD7lW8aYe/kXDfElbzdiVu+jrMbAcuxBRD7BJ3Fg2EfpsinBnSFsz7JcpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997997; c=relaxed/simple;
	bh=zNJ1k5ybcgNHKBArFWXYsOLguPq8qo+EWFdarx7ochY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KCWJC3X8mHPbDOFv0IOon4bGMJrwz+knLv5OAfbFfk5SwkXfR0b8btGRh3wjYRlS1ygC9kmYpylv+6KKXTSeZWavor2lMidqSdw3PVc0jo8FH099KpXFH/z8nilX6al22Ei4YlMZ/DoKLPkj8uKzHPoCIoL9nWag6KiIRMor+Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZGApZSZo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZGApZSZo"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446BlZfA011547;
	Mon, 6 May 2024 12:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iHTUeZ0T/IUAIn09/t+OMcvI8S2itkKjhzjC2IDYdIQ=;
 b=ZGApZSZo1hSk4xnXEa2DFpGLUp4RH3Lu47IlF4IrNySuGSWMPnt7yo4HgSxVaV5AJmSQ
 0gUFd38hoWaAcukD23OrCifT2X7Pf+mrj+wTOnPQ2qEiCNK4Lf/9c3JkAXvZgtfRqAa6
 6wtySAVrYLzE8khbJnWWr8IIjekH9CNbIjO+aH0SarvDSjoSysyXfogLpnW953zXKuFp
 B95Ll9biQqZO6gtYm4as6zJRL6Mth+8rvGAlys7NlD6MzbS72LLGqp7Qc8OlLQwppNZA
 O756hvbhdXc0sGzLxZO49nvrwfMSMnI0LDRb5fHNmMI/uTv6KuOB2U147rVF2CqXoLe8 gg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xxxmt82yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 12:19:47 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 446CJkQZ005665;
	Mon, 6 May 2024 12:19:46 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xxxmt82ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 12:19:46 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 446BfLV4031316;
	Mon, 6 May 2024 12:19:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xwybtr2ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 12:19:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 446CJewn40108518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 12:19:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 439F120049;
	Mon,  6 May 2024 12:19:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7345F20040;
	Mon,  6 May 2024 12:19:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.103.211])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 May 2024 12:19:37 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        akanksha@linux.ibm.com
Subject: [PATCH V2 7/9] tools/perf: Update instruction tracking with add instruction
Date: Mon,  6 May 2024 17:49:04 +0530
Message-Id: <20240506121906.76639-8-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com>
References: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2k4ly3FmCmI4WVbNYzBIFkjqTnlVDspR
X-Proofpoint-GUID: Y42foEVAob09gcOwenFX9W6oVukdxgF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_07,2024-05-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060085

Update instruction tracking with add instruction. Apart from "mr"
instruction, the register state is carried on by other insns, ie,
"add, addi, addis". Since these are not memory instructions and doesn't
fall in the range of (32 to 63), add these as part of nmemonic table.
For now, add* instructions are added. There is possibility of getting
more added here. But to extract regs, still the binary code will be
used. So associate this with "load_store_ops" itself and no other
changes required.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 .../perf/arch/powerpc/annotate/instructions.c | 21 +++++++++++++++++++
 tools/perf/util/disasm.c                      |  1 +
 2 files changed, 22 insertions(+)

diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
index cce7023951fe..1f35d8a65bb4 100644
--- a/tools/perf/arch/powerpc/annotate/instructions.c
+++ b/tools/perf/arch/powerpc/annotate/instructions.c
@@ -1,6 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 
+/*
+ * powerpc instruction nmemonic table to associate load/store instructions with
+ * move_ops. mov_ops is used to identify add/mr to do instruction tracking.
+ */
+static struct ins powerpc__instructions[] = {
+	{ .name = "mr",         .ops = &load_store_ops,  },
+	{ .name = "addi",       .ops = &load_store_ops,   },
+	{ .name = "addis",      .ops = &load_store_ops,  },
+	{ .name = "add",        .ops = &load_store_ops,  },
+};
+
 static struct ins_ops *powerpc__associate_instruction_ops(struct arch *arch, const char *name)
 {
 	int i;
@@ -75,6 +86,9 @@ static void update_insn_state_powerpc(struct type_state *state,
 	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
 		return;
 
+	if (!strncmp(dl->ins.name, "add", 3))
+		goto regs_check;
+
 	if (strncmp(dl->ins.name, "mr", 2))
 		return;
 
@@ -85,6 +99,7 @@ static void update_insn_state_powerpc(struct type_state *state,
 		dst->reg1 = src_reg;
 	}
 
+regs_check:
 	if (!has_reg_type(state, dst->reg1))
 		return;
 
@@ -115,6 +130,12 @@ static void update_insn_state_powerpc(struct type_state *state __maybe_unused, s
 static int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	if (!arch->initialized) {
+		arch->nr_instructions = ARRAY_SIZE(powerpc__instructions);
+		arch->instructions = calloc(arch->nr_instructions, sizeof(struct ins));
+		if (!arch->instructions)
+			return -ENOMEM;
+		memcpy(arch->instructions, powerpc__instructions, sizeof(struct ins) * arch->nr_instructions);
+		arch->nr_instructions_allocated = arch->nr_instructions;
 		arch->initialized = true;
 		arch->associate_instruction_ops = powerpc__associate_instruction_ops;
 		arch->objdump.comment_char      = '#';
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index ac6b8b8da38a..32cf506a9010 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -36,6 +36,7 @@ static struct ins_ops mov_ops;
 static struct ins_ops nop_ops;
 static struct ins_ops lock_ops;
 static struct ins_ops ret_ops;
+static struct ins_ops load_store_ops;
 
 static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops, int max_ins_name);
-- 
2.43.0


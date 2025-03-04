Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A269F291F94
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102902; cv=none; b=E1PxoPf5usmegKG38xpOZ6Vpk4AjLE8uFl3CHYa/zxXa+Zn0oAhX2v/jU9XGxJHjUOg790VoZTHvUMQc1gD919qoa94GtRA5NRi3arwxpVM3hsw8Vbdj/5CfpvwpAaGD9lUwAZ4Kx4r5vs6mjxTSjNvqvG7hry0f710D7xetWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102902; c=relaxed/simple;
	bh=9CBRGFDSJIVeCxYnJZ4PDsBTFU2o9GXjvHa5oYl9TyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N7P7ujDkrs/UExvm15V8fMCxmjxIpXp1QWpix3ixIBk5MCwAgE5+v3t36jWhTsQSCsufQOlWk/QezpG5gX7gUsU/w2g8LWFWPcHQisO1Hu31IJtp22tjPEAvY+yfAZ19bNpOifFY4u/VPznnnxWfvm5xTm97BRe37UiGeG91OaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ttAlef0Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ttAlef0Z"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249iQ8c018704;
	Tue, 4 Mar 2025 15:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Fen3XlWCyyQpZDQ8FcJM7VSGNTr5MTEdn+tysx1fD
	Ek=; b=ttAlef0ZohYv1/H6cQ9jBjNuBHgWznaYSkiaSNYt0wgvm72kR9GJhH9EB
	H+bxGWF+U/huPYtJlceiBXdekJCb5d7X4WjzBaJ9dlQVVQOmVLMEKFeJzTjx1V7R
	1jUAJYZCCHC0C83qvf0yXudk305zhdp7xDV4uFSA4zXwlR2slax6ZodAFHGXuiJH
	7P/B78dXKdrTUpRPChmk6IT6YhYd7UL+SqL26v/UTgynPkBbi4+h1TGShDqaU8qA
	hYBfpj3y0SPHnN5DMHamfYzViQXQ1KBQZGhP19A7IsrVK3ZnrvRcNHxzqWxyKnkq
	isfM/N2mEA1sWMadDq++81EbR2IVw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kmymqr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 15:41:30 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 524FbmGF003866;
	Tue, 4 Mar 2025 15:41:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kmymqr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 15:41:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524FP48T020936;
	Tue, 4 Mar 2025 15:41:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djne3e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 15:41:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524FfPBa47645070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 15:41:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9F672004B;
	Tue,  4 Mar 2025 15:41:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4343520040;
	Tue,  4 Mar 2025 15:41:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.255.217])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 15:41:18 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, hbathini@linux.vnet.ibm.com,
        Aditya.Bodkhe1@ibm.com, Tejas.Manhas1@ibm.com
Subject: [PATCH 1/2] tools/perf: Add field to annotation options to determine disassembler used
Date: Tue,  4 Mar 2025 21:11:13 +0530
Message-Id: <20250304154114.62093-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BaduIInFugDUIW2RFxABz7HBwDhsQ3Pi
X-Proofpoint-GUID: 0ONVAa403qbCU97AL9kkQXzl-xwulBj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040122

When doing "perf annotate", perf tool provides option to
use specific disassembler like llvm/objdump/capstone. The
order picked is to use llvm first and if that fails fallback
to objdump ie to use PERF_DISASM_LLVM, PERF_DISASM_CAPSTONE
and PERF_DISASM_OBJDUMP

In powerpc, when using "data type" sort keys, first preferred
approach is to read the raw instruction from the DSO. In objdump
is specified in "--objdump" option, it picks the symbol disassemble
using objdump. Currently disasm_line__parse_powerpc() function
uses length of the "line" to determine if objdump is used.
But there are few cases, where if objdump doesn't recognise the
instruction, the disassembled string will be empty.

Example:

     134cdc:	c4 05 82 41 	beq     1352a0 <getcwd+0x6e0>
     134ce0:	ac 00 8e 40 	bne     cr3,134d8c <getcwd+0x1cc>
     134ce4:	0f 00 10 04 	pld     r9,1028308
====>134ce8:	d4 b0 20 e5
     134cec:	16 00 40 39 	li      r10,22
     134cf0:	48 01 21 ea 	ld      r17,328(r1)

So depending on length of line will give bad results.

Add a new filed to annotation options structure,
"struct annotation_options" to save the disassembler used.
Use this info to determine if disassembly is done while
parsing the disasm line.

Reported-by: Tejas Manhas <Tejas.Manhas1@ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/util/annotate.h |  1 +
 tools/perf/util/disasm.c   | 22 +++++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 98db1b88daf4..30a344afd91a 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -58,6 +58,7 @@ struct annotation_options {
 	     full_addr;
 	u8   offset_level;
 	u8   disassemblers[MAX_DISASSEMBLERS];
+	u8   disassembler_used;
 	int  min_pcnt;
 	int  max_lines;
 	int  context;
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 50c5c206b70e..a53e8c4e5bca 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -48,7 +48,7 @@ static int call__scnprintf(struct ins *ins, char *bf, size_t size,
 
 static void ins__sort(struct arch *arch);
 static int disasm_line__parse(char *line, const char **namep, char **rawp);
-static int disasm_line__parse_powerpc(struct disasm_line *dl);
+static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_args *args);
 static char *expand_tabs(char *line, char **storage, size_t *storage_len);
 
 static __attribute__((constructor)) void symbol__init_regexpr(void)
@@ -968,24 +968,24 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 #define	PPC_OP(op)	(((op) >> 26) & 0x3F)
 #define	RAW_BYTES	11
 
-static int disasm_line__parse_powerpc(struct disasm_line *dl)
+static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_args *args)
 {
 	char *line = dl->al.line;
 	const char **namep = &dl->ins.name;
 	char **rawp = &dl->ops.raw;
 	char *tmp_raw_insn, *name_raw_insn = skip_spaces(line);
 	char *name = skip_spaces(name_raw_insn + RAW_BYTES);
-	int objdump = 0;
+	int disasm = 0;
 
-	if (strlen(line) > RAW_BYTES)
-		objdump = 1;
+	if (args->options->disassembler_used)
+		disasm = 1;
 
 	if (name_raw_insn[0] == '\0')
 		return -1;
 
-	if (objdump) {
+	if (disasm)
 		disasm_line__parse(name, namep, rawp);
-	} else
+	else
 		*namep = "";
 
 	tmp_raw_insn = strndup(name_raw_insn, 11);
@@ -995,7 +995,7 @@ static int disasm_line__parse_powerpc(struct disasm_line *dl)
 	remove_spaces(tmp_raw_insn);
 
 	sscanf(tmp_raw_insn, "%x", &dl->raw.raw_insn);
-	if (objdump)
+	if (disasm)
 		dl->raw.raw_insn = be32_to_cpu(dl->raw.raw_insn);
 
 	return 0;
@@ -1054,7 +1054,7 @@ struct disasm_line *disasm_line__new(struct annotate_args *args)
 
 	if (args->offset != -1) {
 		if (arch__is(args->arch, "powerpc")) {
-			if (disasm_line__parse_powerpc(dl) < 0)
+			if (disasm_line__parse_powerpc(dl, args) < 0)
 				goto out_free_line;
 		} else if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
 			goto out_free_line;
@@ -2289,16 +2289,20 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 		switch (dis) {
 		case PERF_DISASM_LLVM:
+			args->options->disassembler_used = PERF_DISASM_LLVM;
 			err = symbol__disassemble_llvm(symfs_filename, sym, args);
 			break;
 		case PERF_DISASM_CAPSTONE:
+			args->options->disassembler_used = PERF_DISASM_CAPSTONE;
 			err = symbol__disassemble_capstone(symfs_filename, sym, args);
 			break;
 		case PERF_DISASM_OBJDUMP:
+			args->options->disassembler_used = PERF_DISASM_OBJDUMP;
 			err = symbol__disassemble_objdump(symfs_filename, sym, args);
 			break;
 		case PERF_DISASM_UNKNOWN: /* End of disassemblers. */
 		default:
+			args->options->disassembler_used = PERF_DISASM_UNKNOWN;
 			goto out_remove_tmp;
 		}
 		if (err == 0)
-- 
2.43.5


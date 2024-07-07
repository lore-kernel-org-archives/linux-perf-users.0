Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568D64501B;
	Sun,  7 Jul 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720363499; cv=none; b=MRTuB5FxclxVD7StErU2VwRjUjmjfOYvuSQgdPGNAL4a5sCSPiGb5VSVUg/hTaKhW0F9fal5FDHXeJlt7oAzO+n2gQq3GrrVcADWHXS0Vu1lJcWcMKoCILSaqbsSVJo8IWRIjXN4BWp3WSjWXVI071qELOokERx5rBSKVrbT7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720363499; c=relaxed/simple;
	bh=GX+CzoLYMDtd4a5KFxNs66qJ5lVUSddg3THz5uF7TWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grtZwm9xAnldzB1pCT8FCFy9N+6HJD/kKQnec5tzWXKKNlZdjqfWN3NNJL4wUWFP8LicrnusIvvBqsuqQzOXbvJyDFXTE2RHKacZdSQ3gvC3Bt/awScH03yoOsm8ezpdZ3ktQXwILWbGfjevSO89l3l7IiOO99e5zDDxgKHFQRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lhZ156Cw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lhZ156Cw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467EHfew032185;
	Sun, 7 Jul 2024 14:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	n+6YGDag3p0zcKCJLVkO4XM6sp4nhI+1FYQgWDL6U+g=; b=lhZ156Cwu/h9vtv1
	FX8JZtAUOsqFaNGqCVZV7+kDBNGXZBSn5fx5aD0jvz7Hbpr5nrzLf7EMXETnUIPy
	znnI2/z4p38ZqWb2/NlOUGE8/iq7BSDmFAdR5VhJ1tfPpXWJeHSQHqtByKtJtCaO
	UxQPCbyUzr4c2jCK+ni346+Sta4jo4wy0Ps1WUgb4qmbBHcgoDYh/rMgUxWg4ZZg
	gKXZ5jwGUM6lmZ2OtQwcougQNGs0KIKnX0PRIL9+xAsUs0PMWyhiEpPOTztU+s3a
	YVA3LFkrPgOTsJIiBbTh1gTtSMR7STLUkHma7FmodX9osp5HSjb3KKsPJQf1cYw2
	v0t5uw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ruugcdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 14:44:48 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 467EilAZ003626;
	Sun, 7 Jul 2024 14:44:47 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ruugcdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 14:44:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 467CIJkv006916;
	Sun, 7 Jul 2024 14:44:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jfm27h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 14:44:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 467EifKs35848464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jul 2024 14:44:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56F2520049;
	Sun,  7 Jul 2024 14:44:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B17A20040;
	Sun,  7 Jul 2024 14:44:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.1.68])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jul 2024 14:44:38 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V6 05/18] tools/perf: Add support to capture and parse raw instruction in powerpc using dso__data_read_offset utility
Date: Sun,  7 Jul 2024 20:14:06 +0530
Message-Id: <20240707144419.92510-6-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240707144419.92510-1-atrajeev@linux.vnet.ibm.com>
References: <20240707144419.92510-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d6iW5LfMQxs66zmluWt_fui3pH7tKLp4
X-Proofpoint-ORIG-GUID: bZQyXm9VbxON6smvNd0YFVVzbnUJjgFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407070117

Add support to capture and parse raw instruction in powerpc.
Currently, the perf tool infrastructure uses two ways to disassemble
and understand the instruction. One is objdump and other option is
via libcapstone.

Currently, the perf tool infrastructure uses "--no-show-raw-insn" option
with "objdump" while disassemble. Example from powerpc with this option
for an instruction address is:

Snippet from:
objdump  --start-address=<address> --stop-address=<address>  -d --no-show-raw-insn -C <vmlinux>

c0000000010224b4:	lwz     r10,0(r9)

This line "lwz r10,0(r9)" is parsed to extract instruction name,
registers names and offset. Also to find whether there is a memory
reference in the operands, "memory_ref_char" field of objdump is used.
For x86, "(" is used as memory_ref_char to tackle instructions of the
form "mov  (%rax), %rcx".

In case of powerpc, not all instructions using "(" are the only memory
instructions. Example, above instruction can also be of extended form (X
form) "lwzx r10,0,r19". Inorder to easy identify the instruction category
and extract the source/target registers, patch adds support to use raw
instruction for powerpc. Approach used is to read the raw instruction
directly from the DSO file using "dso__data_read_offset" utility which
is already implemented in perf infrastructure in "util/dso.c".

Example:

38 01 81 e8     ld      r4,312(r1)

Here "38 01 81 e8" is the raw instruction representation. In powerpc,
this translates to instruction form: "ld RT,DS(RA)" and binary code
as:

   | 58 |  RT  |  RA |      DS       | |
   -------------------------------------
   0    6     11    16              30 31

Function "symbol__disassemble_dso" is updated to read raw instruction
directly from DSO using dso__data_read_offset utility. In case of
above example, this captures:
line:    38 01 81 e8

The above works well when perf report is invoked with only sort keys for
data type ie type and typeoff. Because there is no instruction level
annotation needed if only data type information is requested for. For
annotating sample, along with type and typeoff sort key, "sym" sort key
is also needed. And by default invoking just "perf report" uses sort key
"sym" that displays the symbol information.

With approach changes in powerpc which first reads DSO for raw
instruction, "perf annotate" and "perf report" + a key breaks since
it doesn't do the instruction level disassembly.

Snippet of result from perf report:

Samples: 1K of event 'mem-loads', 4000 Hz, Event count (approx.): 937238
do_work  /usr/bin/pmlogger [Percent: local period]
Percent│        ea230010
       │        3a550010
       │        3a600000

       │        38f60001
       │        39490008
       │        42400438
 51.44 │        81290008
       │        7d485378

Here, raw instruction is displayed in the output instead of human
readable annotated form.

One way to get the appropriate data is to specify "--objdump path", by
which code annotation will be done. But the default behaviour will be
changed. To fix this breakage, check if "sym" sort key is set. If so
fallback and use the libcapstone/objdump way of disassmbling the sample.

With the changes and "perf report"

Samples: 1K of event 'mem-loads', 4000 Hz, Event count (approx.): 937238
do_work  /usr/bin/pmlogger [Percent: local period]
Percent│        ld        r17,16(r3)
       │        addi      r18,r21,16
       │        li        r19,0

       │ 8b0:   rldicl    r10,r10,63,33
       │        addi      r10,r10,1
       │        mtctr     r10
       │      ↓ b         8e4
       │ 8c0:   addi      r7,r22,1
       │        addi      r10,r9,8
       │      ↓ bdz       d00
 51.44 │        lwz       r9,8(r9)
       │        mr        r8,r10
       │        cmpw      r20,r9

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/disasm.c | 101 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index a53591a6111e..646290b043b2 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -25,6 +25,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include "util.h"
+#include "sort.h"
 
 static regex_t	 file_lineno;
 
@@ -1634,6 +1635,91 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 }
 #endif
 
+static int symbol__disassemble_raw(char *filename, struct symbol *sym,
+					struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct map *map = args->ms.map;
+	struct dso *dso = map__dso(map);
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 end = map__rip_2objdump(map, sym->end);
+	u64 len = end - start;
+	u64 offset;
+	int i, count;
+	u8 *buf = NULL;
+	char disasm_buf[512];
+	struct disasm_line *dl;
+	u32 *line;
+
+	/* Return if objdump is specified explicitly */
+	if (args->options->objdump_path)
+		return -1;
+
+	pr_debug("Reading raw instruction from : %s using dso__data_read_offset\n", filename);
+
+	buf = malloc(len);
+	if (buf == NULL)
+		goto err;
+
+	count = dso__data_read_offset(dso, NULL, sym->start, buf, len);
+
+	line = (u32 *)buf;
+
+	if ((u64)count != len)
+		goto err;
+
+	/* add the function address and name */
+	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
+		  start, sym->name);
+
+	args->offset = -1;
+	args->line = disasm_buf;
+	args->line_nr = 0;
+	args->fileloc = NULL;
+	args->ms.sym = sym;
+
+	dl = disasm_line__new(args);
+	if (dl == NULL)
+		goto err;
+
+	annotation_line__add(&dl->al, &notes->src->source);
+
+	/* Each raw instruction is 4 byte */
+	count = len/4;
+
+	for (i = 0, offset = 0; i < count; i++) {
+		args->offset = offset;
+		sprintf(args->line, "%x", line[i]);
+		dl = disasm_line__new(args);
+		if (dl == NULL)
+			goto err;
+
+		annotation_line__add(&dl->al, &notes->src->source);
+		offset += 4;
+	}
+
+	/* It failed in the middle */
+	if (offset != len) {
+		struct list_head *list = &notes->src->source;
+
+		/* Discard all lines and fallback to objdump */
+		while (!list_empty(list)) {
+			dl = list_first_entry(list, struct disasm_line, al.node);
+
+			list_del_init(&dl->al.node);
+			disasm_line__free(dl);
+		}
+		count = -1;
+	}
+
+out:
+	free(buf);
+	return count < 0 ? count : 0;
+
+err:
+	count = -1;
+	goto out;
+}
 /*
  * Possibly create a new version of line with tabs expanded. Returns the
  * existing or new line, storage is updated if a new line is allocated. If
@@ -1758,6 +1844,21 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		strcpy(symfs_filename, tmp);
 	}
 
+	/*
+	 * For powerpc data type profiling, use the dso__data_read_offset
+	 * to read raw instruction directly and interpret the binary code
+	 * to understand instructions and register fields. For sort keys as
+	 * type and typeoff, disassemble to mnemonic notation is
+	 * not required in case of powerpc.
+	 */
+	if (arch__is(args->arch, "powerpc")) {
+		if (sort_order && !strstr(sort_order, "sym")) {
+			err = symbol__disassemble_raw(symfs_filename, sym, args);
+			if (err == 0)
+				goto out_remove_tmp;
+		}
+	}
+
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 	err = symbol__disassemble_capstone(symfs_filename, sym, args);
 	if (err == 0)
-- 
2.43.0


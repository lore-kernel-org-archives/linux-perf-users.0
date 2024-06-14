Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C02219EEDA;
	Fri, 14 Jun 2024 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386056; cv=none; b=gPe6ySityUhZ5GOScbeYrtn65yQBKCoSFCaRpiKPni6nddjWEYlLkptzRY2LJX3zR8xnb+90c0/uMp1+lCMWUX5ihiUMDENiZuIdfJ/6C2m6U5hEv6aKxbP6kBshZibRKagHERKchPg834cX0byEaoZGSamThUkKim7oa3ZA9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386056; c=relaxed/simple;
	bh=PVM4aLFDX57fKRYU6PasInjE7plGMRrUl4Qg7MZBivM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=myhuOSDGhLXkjFlG4YS92hu/4R9tWZltab1UPIU8IHMlBVns+o1V7sj01g382OSpxexHUZhqsJG6UeQULJ+gG00UQ2TmFIZWK5VStWBuzLS7rn9YSr5Tsyjbz5sL7aLJABKUbOhxb969lYgtMe9JmPkpaYZA8PGlgfoz0pV2g/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RxUGM7NQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RxUGM7NQ"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EFKdDt015766;
	Fri, 14 Jun 2024 17:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=2w97A3Jly/uRy
	H4Zy4+gzIr2RX9zX5VwkuBMilqcNxg=; b=RxUGM7NQ3Ckmdsc5osBMLlBPU06aW
	hFQwxr+26Tyt3zulgfcb7LtNp6O58MRxq9PMoOiElzuOz42YLAlDqkHq5NGeWkvm
	xYviGbbj6fDAFG/FnWM0Fj3CCHY36Ikizr4NThgV6XnbvMlPkyYu7dsP7Vqq8NUj
	qxDba1EgkH3EqzNv4JTLTb1vdyBelUL++mZI9VEhN2/CFNQT22/4liLaEuTY2X8O
	LNfpu39bERe8uFc7DHJ5ESS8KhVgi2fp2N7LFn/W5DUZLh+waVBhArOx1jiwDBad
	9ZeR2Gvs4/oaO1J7BfE7ssSq4OaFxB3gOKYnJ337xEFNToubvm+58yveg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrq7crhj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:26 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45EHRPcf018346;
	Fri, 14 Jun 2024 17:27:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrq7crhj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45EGlph0020077;
	Fri, 14 Jun 2024 17:27:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34nud62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45EHRIuS30868088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 17:27:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6D002004D;
	Fri, 14 Jun 2024 17:27:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB64A20043;
	Fri, 14 Jun 2024 17:27:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.82.18])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Jun 2024 17:27:15 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [V4 12/16] tools/perf: Use capstone_init and remove open_capstone_handle from disasm.c
Date: Fri, 14 Jun 2024 22:56:27 +0530
Message-Id: <20240614172631.56803-13-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5dpJ23pl7gvZZw_rkb4pa5YJbVC3UW39
X-Proofpoint-ORIG-GUID: _P2FzkUQ3qTrbBaaxRNUgGtEJrbFz7I8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_15,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=859
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140119

capstone_init is made availbale for all archs to use and updated to
enable support for CS_ARCH_PPC as well. Patch removes
open_capstone_handle and uses capstone_init in all the places.

Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/disasm.c     | 42 +++++++++++-------------------------
 tools/perf/util/print_insn.c |  3 +++
 2 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 86ff98e64890..43743ca4bdc9 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -26,6 +26,7 @@
 #include "symbol.h"
 #include "util.h"
 #include "sort.h"
+#include "print_insn.h"
 
 static regex_t	 file_lineno;
 
@@ -1517,32 +1518,6 @@ symbol__disassemble_bpf_image(struct symbol *sym,
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 #include <capstone/capstone.h>
 
-static int open_capstone_handle(struct annotate_args *args, bool is_64bit,
-				csh *handle)
-{
-	struct annotation_options *opt = args->options;
-	cs_mode mode = is_64bit ? CS_MODE_64 : CS_MODE_32;
-
-	/* TODO: support more architectures */
-	if (!arch__is(args->arch, "x86"))
-		return -1;
-
-	if (cs_open(CS_ARCH_X86, mode, handle) != CS_ERR_OK)
-		return -1;
-
-	if (!opt->disassembler_style ||
-	    !strcmp(opt->disassembler_style, "att"))
-		cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
-
-	/*
-	 * Resolving address operands to symbols is implemented
-	 * on x86 by investigating instruction details.
-	 */
-	cs_option(*handle, CS_OPT_DETAIL, CS_OPT_ON);
-
-	return 0;
-}
-
 struct find_file_offset_data {
 	u64 ip;
 	u64 offset;
@@ -1639,6 +1614,7 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	cs_insn *insn;
 	char disasm_buf[512];
 	struct disasm_line *dl;
+	bool disassembler_style = false;
 
 	if (args->options->objdump_path)
 		return -1;
@@ -1653,7 +1629,11 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 			    &is_64bit) == 0)
 		goto err;
 
-	if (open_capstone_handle(args, is_64bit, &handle) < 0)
+	if (!args->options->disassembler_style ||
+			!strcmp(args->options->disassembler_style, "att"))
+		disassembler_style = true;
+
+	if (capstone_init(maps__machine(args->ms.maps), &handle, is_64bit, disassembler_style) < 0)
 		goto err;
 
 	needs_cs_close = true;
@@ -1973,9 +1953,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	}
 
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
-	err = symbol__disassemble_capstone(symfs_filename, sym, args);
-	if (err == 0)
-		goto out_remove_tmp;
+	if (arch__is(args->arch, "x86")) {
+		err = symbol__disassemble_capstone(symfs_filename, sym, args);
+		if (err == 0)
+			goto out_remove_tmp;
+	}
 #endif
 
 	err = asprintf(&command,
diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index a76aae81d7a0..79dec5ab3bef 100644
--- a/tools/perf/util/print_insn.c
+++ b/tools/perf/util/print_insn.c
@@ -52,6 +52,9 @@ int capstone_init(struct machine *machine, csh *cs_handle, bool is64, bool disas
 	} else if (machine__normalized_is(machine, "s390")) {
 		arch = CS_ARCH_SYSZ;
 		mode = CS_MODE_BIG_ENDIAN;
+	} else if (machine__normalized_is(machine, "powerpc")) {
+		arch = CS_ARCH_PPC;
+		mode = CS_MODE_64;
 	} else {
 		return -1;
 	}
-- 
2.43.0


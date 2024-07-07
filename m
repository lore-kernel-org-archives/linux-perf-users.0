Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8A6BFA5;
	Sun,  7 Jul 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720363523; cv=none; b=fEY2SDFzsXMx5IfbF/HSTC8ljN0XIDy72O7+52HwJUg2Ra8yVoUNwDL1bOub7BFCAvnv/GNolB6HZ0EFdcHyn5q+szqlTFEo0gnggDb/juh2shT5LUtCAQRHhXyRya2liGHnB83oQYll7+mbJKFh6b1stsqq8aaKhoyEGHaSEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720363523; c=relaxed/simple;
	bh=Joi+isDm2dKXUoWM6CL7XIZZlTZxY25G/RXQiGFKo7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiiUvdlQYG/S9qOjPQ4QWJWFIN3b2csbewcUyd/Nwl3kCWIh2y8st5gDrdF9WzFT8OGfEj/FZlVQjkjDeN5DA7vsaxHyhj+rZFLn14kVVIEg7OuE2DfsP5iR56nwyTUOV5moJL0KCS0qEGl29KC0OvUMWGpWkpA/KsDJrxpzY9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m8G5jeIK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m8G5jeIK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467EMOwA006091;
	Sun, 7 Jul 2024 14:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=o7G5hpnq/gQzT
	zw7p3WmdeWsvSt7nwFZetxlF8kUpvM=; b=m8G5jeIKjZJIWa+fU6IEX1hv60z13
	GuV2tydpFF8tjkftI92thz7TEabYRJs9sZXFyIqYoE/JH7LDjXLDHViFPW5W8Ao5
	54ZYQmYBMGCB9ONF+r0tdiDeHm01LbTDPfQJCEFjf6se8miPwC41SqJ4Nhq3Amgr
	LhqSO7x4MUq+ObNmXRPKAbqftygegebwwQAmcceEGzV9S/PhePdVF2mkdUzbtTSU
	bXVZ0Z7FYbdq7DUQlIWYCzikazGnj9/aMIFe3TRaZ1XRqOugCVv1zslRQzYBd7Gr
	PimRo6+3UiQLkaXuBF9ic76XMCigZnkLkvDqg9He7YYwAyniM90SzD94A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ruugce3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 14:45:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 467EjADk004396;
	Sun, 7 Jul 2024 14:45:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ruugce0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 14:45:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 467AQCBJ014020;
	Sun, 7 Jul 2024 14:45:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407h8pagvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 14:45:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 467Ej48k17498610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jul 2024 14:45:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4CD520040;
	Sun,  7 Jul 2024 14:45:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07B4520049;
	Sun,  7 Jul 2024 14:45:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.1.68])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jul 2024 14:45:00 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V6 12/18] tools/perf: Make capstone_init non-static so that it can be used during symbol disassemble
Date: Sun,  7 Jul 2024 20:14:13 +0530
Message-Id: <20240707144419.92510-13-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240707144419.92510-1-atrajeev@linux.vnet.ibm.com>
References: <20240707144419.92510-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fTojbfMrsVP3o7qlvptqW-xcYQkOn0nH
X-Proofpoint-ORIG-GUID: frP4M0VQTnjjy-p7SaNMJQ7slSCBXT8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxlogscore=929 mlxscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407070117

symbol__disassemble_capstone in util/disasm.c calls function
open_capstone_handle to open/init the capstone. We already have a
capstone_init function in "util/print_insn.c". But capstone_init
is defined as a static function in util/print_insn.c. Change this and
also add the function in print_insn.h

The open_capstone_handle checks the disassembler_style option from
annotation_options to decide whether to set CS_OPT_SYNTAX_ATT.
Add that logic in capstone_init also and by default set it to true.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/print_insn.c | 12 +++++++++---
 tools/perf/util/print_insn.h |  5 +++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index a950e9157d2d..a76aae81d7a0 100644
--- a/tools/perf/util/print_insn.c
+++ b/tools/perf/util/print_insn.c
@@ -32,7 +32,7 @@ size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 #include <capstone/capstone.h>
 
-static int capstone_init(struct machine *machine, csh *cs_handle, bool is64)
+int capstone_init(struct machine *machine, csh *cs_handle, bool is64, bool disassembler_style)
 {
 	cs_arch arch;
 	cs_mode mode;
@@ -62,7 +62,13 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64)
 	}
 
 	if (machine__normalized_is(machine, "x86")) {
-		cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
+		/*
+		 * In case of using capstone_init while symbol__disassemble
+		 * setting CS_OPT_SYNTAX_ATT depends if disassembler_style opts
+		 * is set via annotation args
+		 */
+		if (disassembler_style)
+			cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
 		/*
 		 * Resolving address operands to symbols is implemented
 		 * on x86 by investigating instruction details.
@@ -122,7 +128,7 @@ ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpum
 	int ret;
 
 	/* TODO: Try to initiate capstone only once but need a proper place. */
-	ret = capstone_init(machine, &cs_handle, is64bit);
+	ret = capstone_init(machine, &cs_handle, is64bit, true);
 	if (ret < 0)
 		return ret;
 
diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
index 07d11af3fc1c..2c8ee41c4a5d 100644
--- a/tools/perf/util/print_insn.h
+++ b/tools/perf/util/print_insn.h
@@ -19,4 +19,9 @@ ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpum
 			 bool is64bit, const uint8_t *code, size_t code_size,
 			 uint64_t ip, int *lenp, int print_opts, FILE *fp);
 
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+#include <capstone/capstone.h>
+int capstone_init(struct machine *machine, csh *cs_handle, bool is64, bool disassembler_style);
+#endif
+
 #endif /* PERF_PRINT_INSN_H */
-- 
2.43.0


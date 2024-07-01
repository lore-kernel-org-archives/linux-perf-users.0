Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFD83A14;
	Mon,  1 Jul 2024 04:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719808530; cv=none; b=bWYpxDDTQKM/uWV/Cr7+e+BSudGGr+s73xCN85KlHmX2QHxgHxGtXvthRcjNBEQ7i5Xb3LlX9k8xGed0qcxGtUWOCQxsQjQfxx1zo3tu+Qoiej0fm6pvnG2RovyNEncajkerPJsJXRazGZPmbuqI/i/OhlAa60JwLuvYXUuh/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719808530; c=relaxed/simple;
	bh=Joi+isDm2dKXUoWM6CL7XIZZlTZxY25G/RXQiGFKo7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GjNHtp73rKD6ZyuRKWwkZ/h/o8Z4O99DwquKTKFlrD2Zt5y045MHsZzNLsMlKo1aPmPLmkyncflMxpaE05UEfpZt4TtQdgpzD86AeUkO+b4UNTlx3da5YBHiA+a5e1la16nbKhsFQeGjKuYjBVh50WFFzFXn5KYKXymtShdAgIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rxMGET1C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rxMGET1C"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4612wisZ009654;
	Mon, 1 Jul 2024 04:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=o7G5hpnq/gQzT
	zw7p3WmdeWsvSt7nwFZetxlF8kUpvM=; b=rxMGET1Cy8502f2rqMTpuI6rDmhR1
	CpZcG8Zg9prjXm8u5IfYeSMywxAjEe8HUuTpqq/30svyQFT3kQvJ7/urYgF0Sv0T
	hYCjVFUSc+KfHGmXqdV4WVPsMZYOOShFMPjXVmcf+McO4ZJstXj4mgA3Fi+8gGFh
	sCd1zyUxfY+D1gNfZFWCxmmU7zww+jV1gUjE9pWdoRefB0Yi+jlSImfKS+iWUU3F
	zD/7RkX164dlxqCc9kKVpwEtzXfWJ3nJ8f3vfWehY29xeTly25DdOY0g4h3UAEYg
	Kbr0q+EfdYE0kMZvH7Xqj/sPWW+/ik8d/J4rB2MOfI9oUSdd3thQUqmCg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403k93gacd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:35:21 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4614ZLS7026205;
	Mon, 1 Jul 2024 04:35:21 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403k93gacb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:35:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4613GIaW005961;
	Mon, 1 Jul 2024 04:35:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vktwkc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:35:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4614ZEqG49676766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 04:35:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B18F120040;
	Mon,  1 Jul 2024 04:35:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C620D20043;
	Mon,  1 Jul 2024 04:35:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.21.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 04:35:11 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V5 12/17] tools/perf: Make capstone_init non-static so that it can be used during symbol disassemble
Date: Mon,  1 Jul 2024 10:04:25 +0530
Message-Id: <20240701043430.66666-13-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240701043430.66666-1-atrajeev@linux.vnet.ibm.com>
References: <20240701043430.66666-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5W-HfEdJbAjY8p9lluu-zq-cjpyg1FoQ
X-Proofpoint-ORIG-GUID: ulK95IiY-gcJaVbdjmDzbA36L1O8-j4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_03,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 mlxlogscore=929 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010030

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


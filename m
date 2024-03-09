Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1123714C
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Mar 2024 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709969159; cv=none; b=pLT3KqXhxRmu+3nJSbOgzsKiMyDpGWNpVipR2IXLS/W4NjTWWPvfPte6tkAgFvIffEqePGzmJ19UYZrYJ1O9VwKJ1aK+sueIFdKsIuoi+OSbe/ytJDIF6iVlmkAJZ5Pz+vjYBs5wUtdXOEcHCtsAIsfw0JA/XrWo/qC9iyLgqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709969159; c=relaxed/simple;
	bh=Mipadp/clIJt89fUJ0qPnlA0p3JV4W8GLbqBJpFkd5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=um5bxCmyp1Q/xZ7GkqtZi9WggeLDg7fF0G/u0wVmyIEwyZ+u5wZsOSuheJ78HD826igQuCtIVUeDmIF0zy2tbVzzGu9PDb4L/Rlld194b8MtLhN0X6DbQ6JMO6yfhkbqJt1P5XPsTUx6cB9KfhqSPhM/MvpwPfYxb4HKKTAv4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zzb20Wdt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zzb20Wdt"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4296vrXh022362;
	Sat, 9 Mar 2024 07:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZAfASJM3DMj0Nw73XRihZAWiZqggzq2/3ytxwz8G5Y0=;
 b=Zzb20Wdtqg+mhHWcZCQgK/sXfadv7NSWh5FKdWWFCQVajwFpHxbcbHWuuJXXStwyXVC/
 Cn0PST8gbBhy3UC7SdJaV2RLbDu0Ryy/pnORCvXBcDosSPvlWPYSw5EHcXO9RqVn6BCH
 USj2gme8d9ebJkVhM3QR9HCFbDekM//gIL21uo3Zan5r0j1nscYsvy2GZU1IXx+cWg20
 KcNqhUJTJfr2y+952xa+D6F/16+sqNvwmFaarKn7UJNHyS8JLIGL33zhbvh5rfZPZSBm
 6K0vlqLxyWJjmU6UwRgE3bHHn0FMhjyAr1dWmiSbbXnQHHkVE43b0SSUZc6LygHFacVm OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wrjy389ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 Mar 2024 07:25:51 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4297Ppf8016473;
	Sat, 9 Mar 2024 07:25:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wrjy389j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 Mar 2024 07:25:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4295IAOv024193;
	Sat, 9 Mar 2024 07:25:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsvnrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 Mar 2024 07:25:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4297Pi4j28181068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 9 Mar 2024 07:25:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDFF520043;
	Sat,  9 Mar 2024 07:25:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93E7820040;
	Sat,  9 Mar 2024 07:25:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.52.192])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  9 Mar 2024 07:25:39 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH 3/3] tools/perf/arch/powerc: Add get_arch_regnum for powerpc
Date: Sat,  9 Mar 2024 12:55:13 +0530
Message-Id: <20240309072513.9418-4-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240309072513.9418-1-atrajeev@linux.vnet.ibm.com>
References: <20240309072513.9418-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LNYe5azbYKUU78hZqQFE_oH_WKsRo5q8
X-Proofpoint-GUID: tQjFiCIGc-g2K4nuS_DE8wKojJXUS1OG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403090058

The function get_dwarf_regnum() returns a DWARF register number
from a register name string. This calls arch specific function
get_arch_regnum to return register number for corresponding arch.
Add mappings for register name to register number in powerpc code:
arch/powerpc/util/dwarf-regs.c

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/dwarf-regs.c | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/powerpc/util/dwarf-regs.c
index 0c4f4caf53ac..d955e3e577ea 100644
--- a/tools/perf/arch/powerpc/util/dwarf-regs.c
+++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
@@ -98,3 +98,32 @@ int regs_query_register_offset(const char *name)
 			return roff->ptregs_offset;
 	return -EINVAL;
 }
+
+struct dwarf_regs_idx {
+	const char *name;
+	int idx;
+};
+
+static const struct dwarf_regs_idx powerpc_regidx_table[] = {
+	{ "r0", 0 }, { "r1", 1 }, { "r2", 2 }, { "r3", 3 }, { "r4", 4 },
+	{ "r5", 5 }, { "r6", 6 }, { "r7", 7 }, { "r8", 8 }, { "r9", 9 },
+	{ "r10", 10 }, { "r11", 11 }, { "r12", 12 }, { "r13", 13 }, { "r14", 14 },
+	{ "r15", 15 }, { "r16", 16 }, { "r17", 17 }, { "r18", 18 }, { "r19", 19 },
+	{ "r20", 20 }, { "r21", 21 }, { "r22", 22 }, { "r23", 23 }, { "r24", 24 },
+	{ "r25", 25 }, { "r26", 26 }, { "r27", 27 }, { "r27", 27 }, { "r28", 28 },
+	{ "r29", 29 }, { "r30", 30 }, { "r31", 31 },
+};
+
+int get_arch_regnum(const char *name)
+{
+	unsigned int i;
+
+	if (*name != 'r')
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(powerpc_regidx_table); i++)
+		if (!strcmp(powerpc_regidx_table[i].name, name))
+			return powerpc_regidx_table[i].idx;
+
+	return -ENOENT;
+}
-- 
2.43.0


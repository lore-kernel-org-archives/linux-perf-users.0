Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A01D9694
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Dec 2024 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734766716; cv=none; b=OhPhbpZ7ERFr4G8CVu0ZLC08QX5XdNu+gGbryEHWr66tqzvvmtbvMpH3sRecOqtfQN4E90m0iePg8rsifD/b38cvAGQuCigK7P0zCUDMFNrwW3asDZMwiE2LxLYCuhqlt7GoTJcWsX4nbpTV7Ouu+ozB2ogZfZPO6TLuofMlhGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734766716; c=relaxed/simple;
	bh=rGY8dOQVZqJOvQDOw/t/Rzt2d5qcG1uwGaYoAZxccx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jj7Vtlwe99WzH+MatqVtOqddtzJ5BZerNCi/qFQFMhnKgcDV1VVLANNfaIxzdqV6Dxwoi+nQGOoIfoW/d9MTBJFTUPBwl8sQ9XNz2Ma+AWen3SkekF+vhS3l3lJBHABLcnmkdw8y0bP1LXNX+Tvsq/zWE9IIMRJJwDMS/WLJqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bnjdy+9I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bnjdy+9I"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BL6rJb8025343;
	Sat, 21 Dec 2024 07:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TVC1ubvqHLX3Ds3My/HlVXsrY9Ketq9g8QiJlFvvs
	sk=; b=Bnjdy+9IG5DS74jdWedY3kZgFPea7nvgvvvPybhKN18k0DcW4sQls1uzd
	hyoWw7cQjegbiCeg1yYUNigK7BkojtZiUAT6hBIG2FV3la9EK6lw0GRwLBpBcVwe
	Ys7rLj4UmkBRJrbA4uRRZ0afoSuCDMcOb5pTaozU4pacErHClEfPCBrJG+VNIsXc
	ymckZTf84T/kJi34xJqDKmI1yU70nH2hyiGdg5bt6ZCu/p0wNnfFgwQSLoqsWJMs
	ojqJ/LyfuMf4M/+f8upsuwdBtYPwhXDzJza/foYboHx842pfi4rn3ErDIyIX5rV2
	PSKpzExrN5tPASipObmYI7EnvbWxw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43nqd1ra1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 07:38:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BL2OoDO005491;
	Sat, 21 Dec 2024 07:38:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbnntbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 07:38:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BL7cNlC48300490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Dec 2024 07:38:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0713C20043;
	Sat, 21 Dec 2024 07:38:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 529E720040;
	Sat, 21 Dec 2024 07:38:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.244.52])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Dec 2024 07:38:18 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, hbathini@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH 1/4] tools/testing/selftests/powerpc: Enable pmu selftests for power11
Date: Sat, 21 Dec 2024 13:08:07 +0530
Message-Id: <20241221073810.65802-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oWEulTUiO57gznupIt6BWTS29RTbY_LM
X-Proofpoint-ORIG-GUID: oWEulTUiO57gznupIt6BWTS29RTbY_LM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412210063

Add check for power11 pvr in the selftest utility
functions. Selftests uses pvr value to check for platform
support inorder to run the tests. pvr is also used to
send the extended mask value to capture sampling registers.

Update some of the utility functions to use hwcap2 inorder
to return platform specific bits from sampling registers.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 .../selftests/powerpc/pmu/sampling_tests/misc.c       | 11 ++++++++++-
 .../selftests/powerpc/pmu/sampling_tests/misc.h       | 10 ++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c b/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
index eac6420abdf1..c52d8bc2a5dc 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
@@ -59,6 +59,7 @@ static void init_ev_encodes(void)
 	ev_shift_thd_stop = 32;
 
 	switch (pvr) {
+	case POWER11:
 	case POWER10:
 		ev_mask_thd_cmp = 0x3ffff;
 		ev_shift_thd_cmp = 0;
@@ -129,8 +130,14 @@ int platform_check_for_tests(void)
 	 * Check for supported platforms
 	 * for sampling test
 	 */
-	if ((pvr != POWER10) && (pvr != POWER9))
+	switch (pvr) {
+	case POWER11:
+	case POWER10:
+	case POWER9:
+		break;
+	default:
 		goto out;
+	}
 
 	/*
 	 * Check PMU driver registered by looking for
@@ -499,6 +506,8 @@ static bool auxv_generic_compat_pmu(void)
 		base_pvr = POWER9;
 	else if (!strcmp(auxv_base_platform(), "power10"))
 		base_pvr = POWER10;
+	else if (!strcmp(auxv_base_platform(), "power11"))
+		base_pvr = POWER11;
 
 	return (!base_pvr);
 }
diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.h b/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.h
index 64e25cce1435..09c5abe237af 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.h
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.h
@@ -8,10 +8,12 @@
 #include <sys/stat.h>
 #include "../event.h"
 
+#define POWER11 0x82
 #define POWER10 0x80
 #define POWER9  0x4e
 #define PERF_POWER9_MASK        0x7f8ffffffffffff
 #define PERF_POWER10_MASK       0x7ffffffffffffff
+#define PERF_POWER11_MASK       PERF_POWER10_MASK
 
 #define MMCR0_FC56      0x00000010UL /* freeze counters 5 and 6 */
 #define MMCR0_PMCCEXT   0x00000200UL /* PMCCEXT control */
@@ -165,21 +167,21 @@ static inline int get_mmcr2_fcta(u64 mmcr2, int pmc)
 
 static inline int get_mmcr2_l2l3(u64 mmcr2, int pmc)
 {
-	if (pvr == POWER10)
+	if (have_hwcap2(PPC_FEATURE2_ARCH_3_1))
 		return ((mmcr2 & 0xf8) >> 3);
 	return 0;
 }
 
 static inline int get_mmcr3_src(u64 mmcr3, int pmc)
 {
-	if (pvr != POWER10)
+	if (!have_hwcap2(PPC_FEATURE2_ARCH_3_1))
 		return 0;
 	return ((mmcr3 >> ((49 - (15 * ((pmc) - 1))))) & 0x7fff);
 }
 
 static inline int get_mmcra_thd_cmp(u64 mmcra, int pmc)
 {
-	if (pvr == POWER10)
+	if (have_hwcap2(PPC_FEATURE2_ARCH_3_1))
 		return ((mmcra >> 45) & 0x7ff);
 	return ((mmcra >> 45) & 0x3ff);
 }
@@ -191,7 +193,7 @@ static inline int get_mmcra_sm(u64 mmcra, int pmc)
 
 static inline u64 get_mmcra_bhrb_disable(u64 mmcra, int pmc)
 {
-	if (pvr == POWER10)
+	if (have_hwcap2(PPC_FEATURE2_ARCH_3_1))
 		return mmcra & BHRB_DISABLE;
 	return 0;
 }
-- 
2.43.5


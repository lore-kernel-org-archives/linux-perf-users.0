Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA241EBFF0
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551672; cv=none; b=a8HbZOj+mO7P5TCG1i0DEdT/EC/l3KLfaJxayWoM8k6/m2X0d2NAbHmjWXvRE1271d81oDq1fqK2Sz7KpKZVDBvGrbdlUcAhzgP3h6X2ZA/fcQQbMSDwBX0Oqht7HmTBxEKR2Q9MSgPhaKwrqfvflK3mH+PjscdMuAD6U8lMF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551672; c=relaxed/simple;
	bh=HughF3Bss8FdmQna62c5K2ETF0JWgtTrN9DhVcEoU2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMPie0raLcnI5K+Jay/bjMPftn32QAvdjaJX2a1aE3XZawNnaWVNsZee80X6W8Ll9itgFa9jWeYxpXE66ZGESMnZMcpsLMlczLyoRninzSvVicemSWSfQdG5SwTfR4VvOIzgvaC++NiyD+4B1RWY8ZHNkhxd60H+oqfbMak7QnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=awiEtE80; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="awiEtE80"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KNGCN4024127;
	Fri, 21 Mar 2025 10:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4XjLjnWnS+ew2vEBAG7UnbXuh8vaeLiFyoddfqTAr
	TQ=; b=awiEtE80WhJRcDLJqeAqQ38/nkEk9XF+wN37hAMV4nzyEFWm9Qf6sTj3V
	gB5KOcBctT80y2CxIl38z8yRi6ue8LugmMK9G6zshAN5343MrCh4S7VkqWm0xSUp
	U/cqtTqrigF69oNkxeIGu/mhrMHx+wzk84bpwq0UJecPC6t4mrBZ4/KxBdKt0tD/
	my493OYNIaQHuIEw5o0vPDtUn+HAVb1nQxBfHf6RJP0H8xJKPb2qTDSA5rMxJfOQ
	MNnmS4goTXVu69wmlaOx8+1c4Mu/9WXg8ImECcjA74k1SK6O7pgGFMf45/atZvyQ
	9Pld5/Oz/bRyx3ldhR8CHHZWN0I4A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gk21wrkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:07:43 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52L9Yi7t023627;
	Fri, 21 Mar 2025 10:07:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gk21wrke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:07:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52L6MdXJ019192;
	Fri, 21 Mar 2025 10:07:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvpcrtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:07:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52LA7bq157672114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 10:07:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90E942004F;
	Fri, 21 Mar 2025 10:07:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61DD82004E;
	Fri, 21 Mar 2025 10:07:35 +0000 (GMT)
Received: from li-e616facc-2daa-11b2-a85c-9c7f23c3cd5e.ibm.com.com (unknown [9.39.27.250])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Mar 2025 10:07:35 +0000 (GMT)
From: Likhitha Korrapati <likhitha@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.ibm.com,
        Likhitha Korrapati <likhitha@linux.ibm.com>
Subject: [PATCH] tools/perf/arch/powerpc/util: Fix is_compat_mode build break  in ppc64
Date: Fri, 21 Mar 2025 15:37:26 +0530
Message-ID: <20250321100726.699956-1-likhitha@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AmVX1TC4-LSgmBiGagmKET8Q_c_D9Szp
X-Proofpoint-GUID: gJ0kBAn_jnj9GiitlXgT-4ewojWjdPVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=950
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210069

Commit 54f9aa1092457 ("tools/perf/powerpc/util: Add support to
handle compatible mode PVR for perf json events") introduced
to select proper JSON events in case of compat mode using
auxiliary vector. But this caused a compilation error in ppc64
Big Endian.

arch/powerpc/util/header.c: In function 'is_compat_mode':
arch/powerpc/util/header.c:20:21: error: cast to pointer from
integer of different size [-Werror=int-to-pointer-cast]
   20 |         if (!strcmp((char *)platform, (char *)base_platform))
      |                     ^
arch/powerpc/util/header.c:20:39: error: cast to pointer from
integer of different size [-Werror=int-to-pointer-cast]
   20 |         if (!strcmp((char *)platform, (char *)base_platform))
      |

Commit saved the getauxval(AT_BASE_PLATFORM) and getauxval(AT_PLATFORM)
return values in u64 which causes the compilation error.

Patch fixes this issue by changing u64 to "unsigned long".

Fixes: 54f9aa1092457 ("tools/perf/powerpc/util: Add support to handle compatible mode PVR for perf json events")
Signed-off-by: Likhitha Korrapati <likhitha@linux.ibm.com>
---
 tools/perf/arch/powerpc/util/header.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index c7df534dbf8f..0be74f048f96 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -14,8 +14,8 @@
 
 static bool is_compat_mode(void)
 {
-	u64 base_platform = getauxval(AT_BASE_PLATFORM);
-	u64 platform = getauxval(AT_PLATFORM);
+	unsigned long base_platform = getauxval(AT_BASE_PLATFORM);
+	unsigned long platform = getauxval(AT_PLATFORM);
 
 	if (!strcmp((char *)platform, (char *)base_platform))
 		return false;
-- 
2.43.5


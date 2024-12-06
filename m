Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B320ADD6;
	Fri,  6 Dec 2024 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493424; cv=none; b=LpMiYH/+knUI4TB6pljk+sLX2Gmm7BZPRjSU1DcUt/uePra5xW9mmSBhkEWaqBfOSO4Hqe6v3uJirz+CrRZIkBrvNsgWG6BpKfYwqpCfntERebzABGwq33T5xJ1MGlcEuqx2aTEPEtXDQ1SkB5QkG75THx0QASCP8NXjZcB0Qk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493424; c=relaxed/simple;
	bh=uMfKj5t1s/VO3UutWywAjUgCvMT5JcR2uY2pqRS03ek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OgXrtBIqiJyeRXDm6RuTL0PXx2Shj2QABbSg80xEpWDVMlcTKpYwTOUMMRKsr6u+bHbxbqOJ/VX52fHdjryVfi/1RCqpT5tlGyUTu+Ry4iOROq6NGtifVZRJUISayLUd2QFobgzmna7oK/TT94SKTxksaxK0jH9/BoGHrwrC608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I623HFBA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I623HFBA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67UY7n000771;
	Fri, 6 Dec 2024 13:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2VvAnUtmxhMMk6F7O3XnWBwviVIumRpdGIrNiXkcO
	oc=; b=I623HFBA1AeMiaayZmTj3kjVU75tzgchmJyHFXca7xaTnKmDHskpEBLvV
	c2i88/0hhkAr7ARLArq/VpYkdRtcfisqha4S7o3bkFhj+tUaQVinUauwW0lV709U
	HVlL9wmBP2r0gJ2OPcWVjNmwUiBcUOlIGRoHqqc9V3yUWq70+utNQlicga15Uz2L
	O18SDU564YBHegGR0ZMwuFQybgq0sVeLwcmlJbExQG2miDZbPLeXJ+JGiqmdkXaP
	TmF5f/X5HBuExPLCc8Zeae5edyy9tkugJTxFv3wdljRp5x6qF+ERbDsbMYTFHJR3
	IoV23UaBBxLVj72RwKXbUAFlt8oWA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bvxksgrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 13:56:52 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B6DupYG007143;
	Fri, 6 Dec 2024 13:56:51 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bvxksgrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 13:56:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B69mwY9007467;
	Fri, 6 Dec 2024 13:56:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jxrtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 13:56:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B6Dulmm31654516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 13:56:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83BDA20043;
	Fri,  6 Dec 2024 13:56:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5AEC20040;
	Fri,  6 Dec 2024 13:56:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.245.143])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Dec 2024 13:56:41 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Subject: [PATCH] tools/perf/arch/powerpc: Add register mask for power11 PVR in extended regs
Date: Fri,  6 Dec 2024 19:26:37 +0530
Message-Id: <20241206135637.36166-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0DRLT-rEuHGmPWYrKzBJijAP1s6fxZfy
X-Proofpoint-ORIG-GUID: dhBZ0ROkcyuB7GAbcfJlCqU6k1RPxCLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060102

Perf tools side uses extended mask to display the platform
supported register names (with -I? option) to the user
and also send this mask to the kernel to capture the extended registers
as part of each sample. This mask value is decided based on
the processor version ( from PVR ).

Add PVR value for power11 to enable capturing the extended regs
as part of sample in power11.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---

 tools/perf/arch/powerpc/util/perf_regs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index e8e6e6fc6f17..bd36cfd420a2 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -16,6 +16,7 @@
 
 #define PVR_POWER9		0x004E
 #define PVR_POWER10		0x0080
+#define PVR_POWER11		0x0082
 
 static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(r0, PERF_REG_POWERPC_R0),
@@ -207,7 +208,7 @@ uint64_t arch__intr_reg_mask(void)
 	version = (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
 	if (version == PVR_POWER9)
 		extended_mask = PERF_REG_PMU_MASK_300;
-	else if (version == PVR_POWER10)
+	else if ((version == PVR_POWER10) || (version == PVR_POWER11))
 		extended_mask = PERF_REG_PMU_MASK_31;
 	else
 		return mask;
-- 
2.43.5


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB1E82D8E;
	Mon,  1 Jul 2024 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719808527; cv=none; b=Onp+3AhrpV2klLhNo7mRvGYkJgFAThAuUYIpH6rTXPbA2XJtbEVPPxp7q+924udpnSPXRt6AHUjMXdcNfSI5ehng9Q24m04awMHoFFP5A6PanXgOtb3ikB2v9wv+CHEm2TFfcwwUjsv0/r1YyDp95KOvKKBc6dDraFMhO0ScpR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719808527; c=relaxed/simple;
	bh=KRru+HEDJEdeHPf3V/N2MPCIeOspDNRKYXQuq7Xg+9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1ew1cEgLg4n5opJvAbjwICV40wp3U5ev54ckKDDXFgHXkWRODvZHxl4NtV/5SFeEDWrxj5hHUG3C+BSgCRG4mVug9q/wGyJAFCxAP+VQAfez1HxS3si7tWVft1WFojhtCs/d3k9ny0MWISB0pBOICw2HDxMRSjP9Xen7wyHO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KCiZFA8A; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KCiZFA8A"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4614KdLC017958;
	Mon, 1 Jul 2024 04:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=EYtZ9DREGGSgj
	7qLUS/AlxbRItQ7Bmw1UST2fYrv8N4=; b=KCiZFA8A8sZIK3pO/Fqh/gH/YsSbp
	edeJ7wMACRP3GRkQ5sJm0aKoplXAzrhBus3V8NlCdBHWS+dS6YonIS3sqvXrMlwF
	e0HFhh0B/SvSDAhQ2DHmSr72YXNhDKroyIxfT+m9WjhjNJFrTEOEcHhr4pQmJCpg
	NB5S3F0NzHWEsiipFOJKmXWO5pIkV25PdGEaO9xcLLczSVpOxGctaeAJEaH7LRWJ
	Vs1uPcsRzi6wVoFVoWycW1dS1xzd8SIDNpxXDDerkvIuJsvbSwmcC2XCg1fh11x5
	SR5SLI1tB+wD79BnZ9imYRsoTG0B6wMwLwvhFVFb8fRgIHsHKZAo8uqqQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403n13827r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:35:15 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4614YrSa006865;
	Mon, 1 Jul 2024 04:35:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403n13827n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:35:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4614QBhb029205;
	Mon, 1 Jul 2024 04:35:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402x3mn7fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:35:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4614Z82D59048356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 04:35:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3740D20043;
	Mon,  1 Jul 2024 04:35:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D9F920040;
	Mon,  1 Jul 2024 04:35:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.21.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 04:35:05 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V5 10/17] tools/perf: Add more instructions for instruction tracking
Date: Mon,  1 Jul 2024 10:04:23 +0530
Message-Id: <20240701043430.66666-11-atrajeev@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: vKM-c18z6XR__EADdnQTuY0HDaTWoHZL
X-Proofpoint-ORIG-GUID: DaMwcKvUdHTLYMqgFjWZDtgH8weiYG3V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_03,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 mlxlogscore=882 impostorscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010030

Add few more instructions and use opcode as search key
to find if it is supported by the architecture. Added ones
are: addi, addic, addic., addis, subfic and mulli

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/annotate/instructions.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
index aa5ee09fa28f..aa25a336d8d0 100644
--- a/tools/perf/arch/powerpc/annotate/instructions.c
+++ b/tools/perf/arch/powerpc/annotate/instructions.c
@@ -172,6 +172,14 @@ static struct insn_offset arithmetic_ins_op_31[] = {
 	{ .name = "DIV_W_XO_FORM",	.value = 491, },
 };
 
+static struct insn_offset arithmetic_two_ops[] = {
+	{ .name = "mulli",      .value = 7, },
+	{ .name = "subfic",     .value = 8, },
+	{ .name = "addic",      .value = 12, },
+	{ .name = "addic.",     .value = 13, },
+	{ .name = "addi",       .value = 14, },
+	{ .name = "addis",      .value = 15, },
+};
 
 static int cmp_offset(const void *a, const void *b)
 {
@@ -212,6 +220,12 @@ static struct ins_ops *check_ppc_insn(u32 raw_insn)
 			if (PPC_21_30(raw_insn) == 444)
 				return &arithmetic_ops;
 		}
+	} else {
+		mem_insns_31_opcode.value = opcode;
+		ret = bsearch(&mem_insns_31_opcode, arithmetic_two_ops, ARRAY_SIZE(arithmetic_two_ops),
+				sizeof(arithmetic_two_ops[0]), cmp_offset);
+		if (ret != NULL)
+			return &arithmetic_ops;
 	}
 
 	return NULL;
-- 
2.43.0


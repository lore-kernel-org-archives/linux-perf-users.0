Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B514386E;
	Sat, 13 Jul 2024 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720889785; cv=none; b=opLZDS3klwhxAc9v6DwNNZngtGxSS4QGNa1f1skgrijzlHS/SFwGSTetCaqnA71W2alqf4KJr4RNSNySLGoXQELjBiQB0RB1XnE4Mi0ipPFerAThosPdPmofkIepD0k67g/FU29vK+SK+OPqwKvBpQNiuisQhTV4jjiDAMXC+R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720889785; c=relaxed/simple;
	bh=KRru+HEDJEdeHPf3V/N2MPCIeOspDNRKYXQuq7Xg+9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kVBZeX/gRa0g0JjX7Z8Bc9Q9DvU9zh+DU1kvlZxXIxmUJ3F0mGMPITI62eTy8HDBjmqbAOa6MKPShzN+ohE3QeZch9CYN5XoILglEYyNtBGIZxNMgcGSftcTxmY9MjoeyJNvbDwIz+QXKF44WAdNX1us9U+9nDZaRDt8xGIyq+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dZ4APYWD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dZ4APYWD"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46DGRAh2007742;
	Sat, 13 Jul 2024 16:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=EYtZ9DREGGSgj
	7qLUS/AlxbRItQ7Bmw1UST2fYrv8N4=; b=dZ4APYWD9EI1tGeYwn4GGgvQ7NJfU
	24s5GS2pe1AtswTqRmh6dEngBfsol1vF3svRbyXqLJObECe1nEvZ/VRLTRcyhNqR
	F3lZAR/wOiTA+F6J6icP1cRX3XXUVVT9vO4s6UqgqFz4EqY20I9hGHsYE8rMvcW7
	+G9i7RLqOwG+8La+bTgxJDnhGRDKgVx6Af9Wqmpbb5G6Al/AYRhfLKATZUWKB6jh
	3Oy1tGbOEiFkszAfR2qwfbt/C03Ggb8pT1J5Tu13zM702tOiY8XrHy2VIyOQIb6n
	WRtT5G8p42Vj3vZlfHt3YKqrl2VMUEvaARuedfxFlspYSIUj8/GNh0dZw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40brr2gchs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:56:14 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46DGuD0J016065;
	Sat, 13 Jul 2024 16:56:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40brr2gchm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:56:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46DDZhue006958;
	Sat, 13 Jul 2024 16:56:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jfn406y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:56:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46DGu7pw46334212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jul 2024 16:56:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A517320040;
	Sat, 13 Jul 2024 16:56:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA89D2004B;
	Sat, 13 Jul 2024 16:56:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.49.134])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jul 2024 16:56:04 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V7 10/18] tools/perf: Add more instructions for instruction tracking
Date: Sat, 13 Jul 2024 22:25:21 +0530
Message-Id: <20240713165529.59298-11-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240713165529.59298-1-atrajeev@linux.vnet.ibm.com>
References: <20240713165529.59298-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _jLhns30NEtvWNLzeT6MJNf9TxYkNtWB
X-Proofpoint-ORIG-GUID: uVp4C1W-qDBeLXrUgw7Xy3K9tzEqnizf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-13_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=871 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407130127

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


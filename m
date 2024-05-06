Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22571143C5D;
	Mon,  6 May 2024 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997986; cv=none; b=OW9JeOj9TlwaY7y+ClXNR8AfaLjuT0dk2CK2me/xaaiEyAcYj/Fh9S2ev7t59cNEOGVoZuybN/kP88LIJ5RMD43phhLsRs5RLdZ8PFZazziUcGHDSCFkQMuMHprpCGZVbk1ynTFt7JqCbQV1RxLocaotSMns2Oe88hBjRiJQOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997986; c=relaxed/simple;
	bh=slI7+hMHmf5MK81bviY1FkUShDHJeeBOoht9m5x6mnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UBLqLnSE3yyGc7M1anb2mPiNLhsMGEMI74TpY0vaQJ9zU6av9uVenq6MkRiucP5zjHfcSZtSq8NCsR0v/Up6ctXyA4sAWx1Hnc4nFS1WdjYQxSav+4G+d4C9xeFkdSo+LB99JiY7DF41qSIlcWAdOZ05ULxZMqk3ueCCNq/U2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BeW44xRG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BeW44xRG"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446CFCu4002631;
	Mon, 6 May 2024 12:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wLkTMnfbJqr5IAUHKH+kVU3WzXA6M6RgRrTO4HDUZsE=;
 b=BeW44xRG9mJWVSGfw4bOiumaMVTAuB+6QZ8vFweAXHaJzvZG6zKOslXVQg4gWzFevfE9
 copRnLvCEPonEK3JpKsZsRgOZh0U4onUd68m9HY6thvfZeYAxdM7T18EW2aR1Mgb16Ma
 uSKVrcG1V5y0UmGL8ikYD1DAJGHgzie4cP3tTMRxTega+DyqAJgImXzAEaCEzES8GC/G
 4Zh8VVPhmbqBOVarahj2OPfHfCQpKsDbxlFV2xhLJhatd8OoLyTR9tWNe+uPEUykNdGW
 YOgVoJvVMulRJlP4rkBBWTFhC4TvphTPaQVKiwi10ofhTQPc7MzzbK419xXVDNo0zYd5 /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xxy1ug0ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 12:19:34 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 446CJXPf010045;
	Mon, 6 May 2024 12:19:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xxy1ug0ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 12:19:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 446C55o5028582;
	Mon, 6 May 2024 12:19:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xwyqyyy5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 12:19:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 446CJRTF22806958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 12:19:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17F0520049;
	Mon,  6 May 2024 12:19:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57AC820063;
	Mon,  6 May 2024 12:19:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.103.211])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 May 2024 12:19:24 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        akanksha@linux.ibm.com
Subject: [PATCH V2 3/9] tools/perf: Fix a comment about multi_regs in extract_reg_offset function
Date: Mon,  6 May 2024 17:49:00 +0530
Message-Id: <20240506121906.76639-4-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com>
References: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: na_SX7JEzg2wGQrFuvtCeGq-7ivyExN1
X-Proofpoint-GUID: sWefmXAxa8eIKz0TqP702VLL31CgKUx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_07,2024-05-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060085

Fix a comment in function which explains how multi_regs field gets set
for an instruction. In the example, "mov  %rsi, 8(%rbx,%rcx,4)", the
comment mistakenly referred to "dst_multi_regs = 0". Correct it to use
"src_multi_regs = 0"

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f5b6b5e5e757..0f5e10654d09 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2093,7 +2093,7 @@ static int extract_reg_offset(struct arch *arch, const char *str,
  *   mov  0x18, %r8      # src_reg1 = -1, src_mem = 0
  *                       # dst_reg1 = r8, dst_mem = 0
  *
- *   mov  %rsi, 8(%rbx,%rcx,4)  # src_reg1 = rsi, src_mem = 0, dst_multi_regs = 0
+ *   mov  %rsi, 8(%rbx,%rcx,4)  # src_reg1 = rsi, src_mem = 0, src_multi_regs = 0
  *                              # dst_reg1 = rbx, dst_reg2 = rcx, dst_mem = 1
  *                              # dst_multi_regs = 1, dst_offset = 8
  */
-- 
2.43.0


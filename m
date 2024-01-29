Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008D5FEF9
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jan 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530154; cv=none; b=LRp8ZoXQntd6YjNWVAn79Ik4sGQmFRe0tu5xx5Wfi7B33jvi8W9t4bYVpPwB5zZ5VvuP2Gduwsl9A7WWrM/OknUQ9zdRtp7FdSZs2Ccv66VqQr+4FSczJRYzKUk1ZwKK991xHNrcNgASkkOXeGM8sml8wuueQEwCJosDerJEA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530154; c=relaxed/simple;
	bh=KUknzVHm6fDIVzPCYpYE6sCdqVSBsvXxjlBAaFX84qY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKj1jcI8vo/Lav32xtyKsibe9lmHnuJ1DtEIBv7jPTCW+RH90Pz8fnAI/NfG2J2Xw5HRWM1kQM2FFta44gTM/zArXuOOMF3C3D1p2SRxPwkBlXDfvR9LEE+5BexttlPjkt1XMdHirPjiPexr2ln3mCNtvoc9XDif+ryOUl72b/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f85O+330; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f85O+330"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40T9xXfK019941;
	Mon, 29 Jan 2024 12:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KcGhYSqbvopmT+SNtGkwaw3B+Hv9hZeMUrhNfChZ2A8=;
 b=f85O+330DA0jjM4CqpFRyqrIxEFJEImo9jjAenGI1k8MllvsW/tnRZOpvTtXAcfnuEGX
 lyda1opsdw/op6MgySmviNQIxW31+kBaeNfFzm+10Kmsr65XIwqLuaL/nvSNQ6AKZ27P
 DCBP1QGbUk5XFI7Njszbaj6lA0rRyRAeRfmxVz5I0zPAJrQ+ZG7A+vGV8dHe/BpMfgv+
 hMLUjUrqZkuZ+q3pdeD6iRBlOwfIgcc5IXUg4QKBX59RJ5iK/bxU9lJ7pAg78E3OMXtn
 U4nKUFHsgoKqDncL8FIVCPI3SPxXoFUb8APmFfrylpl7hH3Omu9oJK6o+JALpNQTRWGO og== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vwthyapbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 12:09:05 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40TBtQc3000376;
	Mon, 29 Jan 2024 12:09:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vwthyapb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 12:09:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40TBr8sP011067;
	Mon, 29 Jan 2024 12:09:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5ng10b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 12:09:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40TC915g42992162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 12:09:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34B4820040;
	Mon, 29 Jan 2024 12:09:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F60520043;
	Mon, 29 Jan 2024 12:08:59 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.204.207.44])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jan 2024 12:08:58 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH] perf/pmu-events/powerpc: Update json mapfile with Power11 PVR
Date: Mon, 29 Jan 2024 17:38:55 +0530
Message-ID: <20240129120855.551529-1-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3X0hkpYshCB14owOqCvry76HR5t7tVYN
X-Proofpoint-ORIG-GUID: u6caXPrPMFqG9q7E96_4JeigrDO73Hi9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=945 mlxscore=0
 malwarescore=0 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290087

Update the Power11 PVR to json mapfile to enable
json events. Power11 is PowerISA v3.1 compliant
and support Power10 events.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 tools/perf/pmu-events/arch/powerpc/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
index 599a588dbeb4..4d5e9138d4cc 100644
--- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
+++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
@@ -15,3 +15,4 @@
 0x0066[[:xdigit:]]{4},1,power8,core
 0x004e[[:xdigit:]]{4},1,power9,core
 0x0080[[:xdigit:]]{4},1,power10,core
+0x0082[[:xdigit:]]{4},1,power10,core
-- 
2.43.0


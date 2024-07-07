Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAEA288DB;
	Sun,  7 Jul 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720363493; cv=none; b=HRdb7eBVDglM2IY+mbs+gb6SrxikNh9xOhndvC8d5eoReRu255sJvo6by+60qw7kz8bds5okDSCXiluFmMywbaDuSk1o2TCeXRaTQw0pOSA7X3Fr2gzD5WCBJq+y4QTW49VOpx8NolptD9cJyLwH0g3XkizfUpVXY3nVTuVxsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720363493; c=relaxed/simple;
	bh=+8ou4jOda7rMv75YTQ7kLFOSOP6gThDj9zdygA14m1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nr/HwH0e74niKe49S8s5menP8LLcXONIisnpuowZa731YvwZau9ay2PSUYz2zbFY+wYQYfM8iZW81cwJjwDvCzTuuciurdX2Izw1yqrb9X9D0Ar8Ddl01DML2AWx4eKRkg4mSeQEuS86vaYe2jjuthWHNLPrcekPGeA41QuqwKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a1TPxcBs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a1TPxcBs"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467DGblK014708;
	Sun, 7 Jul 2024 14:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=gaEeJvcdxtPqR
	OzBKZFbR4JjVC2CIIbd8gbZSMkJASY=; b=a1TPxcBs+uQ145qIU8HbGVHizAWhC
	PFUwIf6dS6+SFOu4twHKnmhQ77LK2ZfKOQ7Nca0aiKex/YH87O03+OlTuvXJPCDX
	jI9zjGvc1MSld/GMtWEfq4OMA2z+e58Zn32BOnTe+FRaLsBMrulCkoFz8zF5D+Mu
	QR2eO8+VJQQjI0Mo5PqUdBQz8msGWhi3oTwogntS9WmSUoxvPDRKaQeBDD//qH37
	1EBRLrr4YIk8pOo6D4vXCkv4TKF2l03FxOYRUkOUSTh2emqymHDkXsU+VN8pEVN/
	jIQFTOJiFjw+YR7ENEYjr0zJi/lllHzDlLJXOC3HYHh2pXH2ZqLWmPWHQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ruugcdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 14:44:41 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 467EifmY003502;
	Sun, 7 Jul 2024 14:44:41 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ruugcde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 14:44:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 467E1Cqv024664;
	Sun, 7 Jul 2024 14:44:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8ttr7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 14:44:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 467EiY9835848458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jul 2024 14:44:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF50E20049;
	Sun,  7 Jul 2024 14:44:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E84AA20040;
	Sun,  7 Jul 2024 14:44:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.1.68])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jul 2024 14:44:31 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V6 03/18] tools/perf: Update TYPE_STATE_MAX_REGS to include max of regs in powerpc
Date: Sun,  7 Jul 2024 20:14:04 +0530
Message-Id: <20240707144419.92510-4-atrajeev@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: kXL_pYP3JYsmO-oZcP0ykL9Nzw-yPQvx
X-Proofpoint-ORIG-GUID: OI2VtNJOeKlFw-unLpFhOK6wUd7rYGe0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407070117

TYPE_STATE_MAX_REGS is arch-dependent. Currently this is defined
to be 16. While checking if reg is valid using has_reg_type,
max value is checked using TYPE_STATE_MAX_REGS value. Define
this conditionally for powerpc.

Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/annotate-data.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 6fe8ee8b8410..992b7ce4bd11 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -189,7 +189,11 @@ struct type_state_stack {
 };
 
 /* FIXME: This should be arch-dependent */
+#ifdef __powerpc__
+#define TYPE_STATE_MAX_REGS  32
+#else
 #define TYPE_STATE_MAX_REGS  16
+#endif
 
 /*
  * State table to maintain type info in each register and stack location.
-- 
2.43.0


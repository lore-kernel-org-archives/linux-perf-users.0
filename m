Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5E1EB39
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Mar 2024 07:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709969154; cv=none; b=irQcty2cywM3o+DydpT82gGhQoliUcv1yt6W+cDnKZwGwF4OKmd8bXFpaeB4g6mOuVJrayvl+3fRzP0kGEqnaye1OFjRRQU8pmE1Cwy1SDV9Eju5w+QvniwDaraZ55foadb/9qBqnx8cSfGCOBZTkoOHmCnIfsnlFXtON/cAIRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709969154; c=relaxed/simple;
	bh=sR+BPHJ1/sj+1OYrzbGt3pdUlfbZ2z+4FBt9JSITybU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BC6dQpOCq0CAY+1Au8918AXEsKmSmiu9PDBJTuDr/LeRT2VQTen3nw8BGWlERQQyuECs9d/f7G/FCeWwr1ANDI/8uGEqyGhW3ARVaYNC8Tg3BULr6XhopCinprB+K1yhFfwciu6F6LJQLWioQ+Z5Z0YP/YK1hfLcr/OzQwqlJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sqoXtLHF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sqoXtLHF"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42972CkG006716;
	Sat, 9 Mar 2024 07:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wR8wsx8XHoyJZG6Govc76HMoUvHf7YwLRQtEF1VahdQ=;
 b=sqoXtLHFJQAPYJvmeeqYmgLqWKhzEPiFgZ6ARxcNAlgS0sz49wRz2XYsqlY9Bos7ml+K
 3jBjHJPu7YvhHdXsLhM5REouc3bypqnYTFVCoj5AXHnZo6zeAEIf77XkCTB/EuwLyOyH
 x0tjYTQTQhQsMuCNbsySJdqxZprwWouKmc4TC6SkD5gT25S0iQcMQtneBJv46vPhyonF
 ddWp91Qo36lr5nCLedt6JslpflYcsq8GKaDQ8HkWM9bKfeg4Nr0BW+UgrFDCtvYMBG2w
 l+vx/iVH0SSzPASrc6aUrH9QTFnerlRDqMdN40hwA0LbTziOu3RUOEdsicAdawtqZhCD Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wrk1988gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 Mar 2024 07:25:44 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4297Ph34024158;
	Sat, 9 Mar 2024 07:25:43 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wrk1988fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 Mar 2024 07:25:43 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42970ik3025371;
	Sat, 9 Mar 2024 07:25:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmeu09jsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 Mar 2024 07:25:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4297Pbqs14483852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 9 Mar 2024 07:25:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E1B02004D;
	Sat,  9 Mar 2024 07:25:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8974420040;
	Sat,  9 Mar 2024 07:25:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.52.192])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  9 Mar 2024 07:25:31 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH 2/3] tools/erf/util/annotate: Set register_char and memory_ref_char for powerpc
Date: Sat,  9 Mar 2024 12:55:12 +0530
Message-Id: <20240309072513.9418-3-atrajeev@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: 1vILPxsCoA81CPPLa4vqYmwTmJvCatci
X-Proofpoint-ORIG-GUID: zx1AJFM9EJB3F8iB_AM9B92-y1JqWLqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403090058

To identify if the instruction has any memory reference,
"memory_ref_char" field needs to be set for specific architecture.
Example memory instruction:
lwz     r10,0(r9)

Here "(" is the memory_ref_char. Set this as part of arch->objdump

To get register number and access offset from the given instruction,
arch->objdump.register_char is used. In case of powerpc, the register
char is "r" (since reg names are r0 to r31). Hence set register_char
as "r".

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/annotate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ac002d907d81..d69bd6edafcb 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -216,6 +216,11 @@ static struct arch architectures[] = {
 	{
 		.name = "powerpc",
 		.init = powerpc__annotate_init,
+		.objdump =  {
+			.comment_char = '#',
+			.register_char = 'r',
+			.memory_ref_char = '(',
+		},
 	},
 	{
 		.name = "riscv64",
-- 
2.43.0


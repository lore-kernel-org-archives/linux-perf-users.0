Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C233F589
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758092; cv=none; b=R/u5rDx7J7mMOSN2mspK/bKI6DE6Tll9m2ZpSodVbKr6LNugT0kmQbxWq0IumfhudDFRhBcAqbtLYNbvHddaH+s4m/+9y9/lfG3gxV/Us+HDr+3kJxN/kVJTtHwHELU3YbD4HCfASLdcd08CIkQN/9gktah/DOe3y/6nQOgFXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758092; c=relaxed/simple;
	bh=KpbLy/07fwDDeVlXSy7tWkL0VhfEwnyepHRe91qlhL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oWfzKWWvA/DBMeQLS6zKhFYyynGENrjvbK+yFuES4QNctvJyEPI/pYsbIcVRA1Crecqvzs5iDJIqKzIXRxDQ6eIabDRuAwvff/1+6zQRgaDaJV1aimVn1CJfylF7FjR1abneQmgTxsL7XWs9MP8rtSvk7azgUtIPltbiIq2DpR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tpP6yIRn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tpP6yIRn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68741fvL3831295;
	Mon, 7 Sep 2026 05:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=IK81py3xNqHbhXYHAH+PEmk62FCb/2sK5/oaFsldy
	KM=; b=tpP6yIRnxQYg4/p2SO6Xp8Uu8cU//N9DQn/eA8SQjK7kMM4N+hiOUtuK6
	zbN4wkRG3pxVptEviPf+vsfPxLh2UtjlufqeeJfKoZqYfkvp2VhgdKr6D5pVoLxj
	oIrlokc/OkCqww8GGOJmGp8SwBROE3YTE3CApsusQzRBw3az7q65oLxIXe4H7IPw
	SyQLiYWt3u20HggNed5xbnq32fcdmmFKgy8q0UnJXT7NA8OYS4pxuzJGrjSCeKcR
	Z+4LCMUDhANJYkUPZLwnLXfojIk1QIgkShqsZVpYOMFpy9AS46zDtqt3/47Lv7m5
	EVOmtv7u12G4bo0/DU8NyaTIzbJNw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrejw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 05:14:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6875BF8X014272;
	Mon, 7 Sep 2026 05:14:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdjm32t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 05:14:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6875EZgn47514084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 05:14:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D98D22004E;
	Mon,  7 Sep 2026 05:14:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 209072004B;
	Mon,  7 Sep 2026 05:14:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.222.166])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 05:14:31 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        narnalli@in.ibm.com, vpuliyal@in.ibm.com
Subject: [PATCH] perf disasm powerpc: handle Power10 prefixed instruction continuation lines
Date: Mon,  7 Sep 2026 10:44:29 +0530
Message-Id: <20260907051429.29080-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6a9e4842 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=U-cem9rO5JdOABcjNy0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA1MSBTYWx0ZWRfX3V262781SRHm
 y93hLluLDzeQe4k/D6MUO/bvJdhjrqcp40Z9ECKcwKfMacu/diJ0K5+HNExp2c7CYfDnJyFTYXZ
 lLSp9TsOz1X4Y/qHH1oKD39kbMw6pIo=
X-Proofpoint-ORIG-GUID: Lxl2djdbADJo_3BhOuD9Mmyg_UiSuTpr
X-Proofpoint-GUID: jo92DFtmkAJwKN76m_e1KoNxOErwhZlq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA1MSBTYWx0ZWRfX6Qpnb6aG3CAM
 a/oAS7Z8hi56VqAo6GFXNlTjmCE5Jv6Lpq0pBbJsbXtQsjrzBF8LpPkDeBqEuu8CKeJ4tp5aXpL
 ezaivKWQ8T430Y6naHnVJcPUQNfhvJDxUln596Ws0I1UOsYsUVgU20ECLDeYS2OQgwEMpCEChm5
 /IVIjol+oVwnQ+3AIAhJczUPjhylKKxDWH0jtql89vlEJe0o9k4HAEwHg7+BnxgjLdJbYhfzBUZ
 OP2BfjkUqmFRLla122/U4TfKBDAB+0OPuQy3dVbii+aU1+UxPFhjiKo27A0YtEl85LF9RbRrzEJ
 0V3ABLGtPr7xVkbCW09EwcXzgcw4kw0TjCbeXj5MeD9CGWhZpUhvuAGoJoR/N3ZBvJ0jQttwwRq
 85lDcKN3i5x4plj8Vy2OxjWBxU7r48tp00rs2P2oc15bx/rasR9gaCsMp5OTvfxe+4cvYt7DWbw
 B6Bvk47our+5yPyEQtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070051

Power10 introduces prefixed instructions that are 8 bytes wide.  objdump
emits these as two lines: the first carries both the raw bytes and the
mnemonic, while the second carries only the raw bytes of the second word
with no mnemonic:

  1020900c:  0b 00 10 06  pla  r31,757280  # 102c1e2c <cctki_vi_ML_CCZ4>
  10209010:  20 8e e0 3b

disasm_line__parse_powerpc() calls disasm_line__parse() on the mnemonic
portion of the line.  disasm_line__parse() returns -1 when the name
string is empty, which causes disasm_line__new() to return NULL, which
causes symbol__parse_objdump_line() to return -1, which immediately
breaks the objdump output parsing loop in symbol__disassemble_objdump().

The result is that annotation of any function containing a prefixed
instruction stops at the continuation word and all subsequent
instructions in the function are lost.

Fix this by treating an empty mnemonic as a valid case in
disasm_line__parse_powerpc(): skip the call to disasm_line__parse() and
set the instruction name to an empty heap-allocated string instead,
allowing parsing to continue to the next line.

Reported-by: Narendra Nalli <narnalli@in.ibm.com>
Reported-by: Vijay Puliyala <vpuliyal@in.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/util/disasm.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index e263a2a8715d..8dca703a5c74 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -884,10 +884,24 @@ static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_ar
 	if (name_raw_insn[0] == '\0')
 		return -1;
 
-	if (disasm)
-		ret = disasm_line__parse(name, namep, rawp);
-	else
+	if (disasm) {
+		/*
+		 * Power10 prefixed instructions are 8 bytes and objdump emits
+		 * the second word on its own line with raw bytes but no
+		 * mnemonic, e.g.:
+		 *   1020900c:  0b 00 10 06  pla  r31,757280
+		 *   10209010:  20 8e e0 3b
+		 *
+		 * Treat a missing mnemonic as an empty instruction name rather
+		 * than a parse failure, so that parsing continues past it.
+		 */
+		if (name[0] != '\0')
+			ret = disasm_line__parse(name, namep, rawp);
+		else
+			*namep = strdup("");
+	} else {
 		*namep = "";
+	}
 
 	tmp_raw_insn = strndup(name_raw_insn, 11);
 	if (tmp_raw_insn == NULL)
-- 
2.43.0


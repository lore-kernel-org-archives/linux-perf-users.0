Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22E1BC4E;
	Fri,  7 Jun 2024 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717739024; cv=none; b=nfi4RPVYP9Tf85vWxcblErAahuq54n4xJ9yyqqEfSJqTP4eTxQgR1yWObDMVaR3K9m905jZzogT6PKi8N2hgFf4E08mbjc8//pUNzrCwVFCv09DOC1ok+4NmbU9ZhQimPBrGixEpoxDfIaA38l123TLtj9sEq+T+CR0lumW/fYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717739024; c=relaxed/simple;
	bh=jJnHVCPPJIMVdgxQBlR/yGE1vDg2hPnFvywd9Z1hGRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tgCsgDADFrfZ/ATQ10lhrMXBF2c5wNpO1oBG9Ol1+ddXq2xKFBTAoz+9CT36cetM9qoR+Z+umS62zE9Wf5znoO61AKmtSz/eUw+CScBSRLQ+G4Dvlgno687UnMV0BLw6LBgV6fuTvNbt0xg6oUNis8Rj1RiMA3a6575N3Ss/2XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J16p6hxn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J16p6hxn"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4575gML2029643;
	Fri, 7 Jun 2024 05:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=pp1; bh=50091Fs5ys3Dh9bUPL1ogFdV1OFduwx5U9QgcNiymDU=;
 b=J16p6hxnER5mFIfJ2SRVb9RXcNCH6rI9yebJDvokw5y44qDn1fV5myIL0lCufMF3ZIfY
 7BEWclrGnd9Z8n8Tl/ZfsLqjGrW3C2EPj7uHQZsqtwl3ZH5Baq1dRu2tlNr1VxZfhYtF
 OpIZuqJmMQDlVBimbgSPaT1RK6KlNGmv/lu+JOddsFRNAC01B/UykqTVCAv/lbIVOhCU
 brArxDzB50UPK3Blx0V8RYBP93bgi2O2sTzvR6UanWWzjaY9xZhmE6/dzdhsQU9lNCw5
 f2fuRht1Fyh2Tja4xzJicNFNpKStCUMh+3B21lEZKbB8jfjRBhrQCXnQNlsN3ImFjRtu Sw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykv9qr08e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 05:43:39 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4575Ii0D031147;
	Fri, 7 Jun 2024 05:43:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygeypxvuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 05:43:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4575hWdM49480024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jun 2024 05:43:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45BD02005A;
	Fri,  7 Jun 2024 05:43:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1154320043;
	Fri,  7 Jun 2024 05:43:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jun 2024 05:43:32 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, amhyung@kernel.org
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Speed up test case 70 annotate basic tests
Date: Fri,  7 Jun 2024 07:43:28 +0200
Message-Id: <20240607054328.2767887-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mIIVXpXewEmKJ9Jo2cMHCD1Bx_4p9kAb
X-Proofpoint-ORIG-GUID: mIIVXpXewEmKJ9Jo2cMHCD1Bx_4p9kAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=898 suspectscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070039

On some s390 linux machine (mostly older models) and with debug
packages installed, the test case 'perf annotate basic tests' runs
for some longer time.
Speed up the test and save the output of command perf annotate
in a temporary file. This is used to perform pattern matching via
grep command. This saves on invocation of perf annotate which
runs for some time.

Output before:
 # time bash -x tests/shell/annotate.sh >/dev/null 2>&1; echo EXIT CODE $?

 real   4m35.543s
 user   3m19.442s
 sys    1m14.322s
 EXIT CODE 0
 #
Output after:
 # time bash -x tests/shell/annotate.sh >/dev/null 2>&1; echo EXIT CODE $?

 real   2m2.881s
 user   1m30.980s
 sys    0m30.684s
 EXIT CODE 0
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/annotate.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 1db1e8113d99..b072d9b97387 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -15,12 +15,13 @@ skip_test_missing_symbol ${testsym}
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
 testprog="perf test -w noploop"
 # disassembly format: "percent : offset: instruction (operands ...)"
 disasm_regex="[0-9]*\.[0-9]* *: *\w*: *\w*"
 
 cleanup() {
-  rm -rf "${perfdata}"
+  rm -rf "${perfdata}" "${perfout}"
   rm -rf "${perfdata}".old
 
   trap - EXIT TERM INT
@@ -41,8 +42,11 @@ test_basic() {
     return
   fi
 
+  # Generate the annotated output file
+  perf annotate -i "${perfdata}" --stdio 2> /dev/null > "${perfout}"
+
   # check if it has the target symbol
-  if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${testsym}"
+  if ! grep "${testsym}" "${perfout}"
   then
     echo "Basic annotate [Failed: missing target symbol]"
     err=1
@@ -50,7 +54,7 @@ test_basic() {
   fi
 
   # check if it has the disassembly lines
-  if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${disasm_regex}"
+  if ! grep "${disasm_regex}" "${perfout}"
   then
     echo "Basic annotate [Failed: missing disasm output from default disassembler]"
     err=1
-- 
2.45.1


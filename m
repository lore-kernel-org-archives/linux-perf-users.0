Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CE31C2BE;
	Fri,  7 Jun 2024 05:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717739047; cv=none; b=DHOmmti3v/EPuRMfMrytXQ4rh8iUgfQ1Cm4LpUMbh7z/xWELmNOhENgRzTsHfEC+SrN5HNpYLMNh8PnPhpFLnOWmWJuptfpzJnbK4Tqdc9B54Tc0WLWDkS+tDlooZ0IF8wltScI2KG27lWrSav9Vn+CmoOzj/Lp13RcQAo0vS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717739047; c=relaxed/simple;
	bh=jJnHVCPPJIMVdgxQBlR/yGE1vDg2hPnFvywd9Z1hGRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mlJlGXUjg8rFc/2k4hol6ASRrEAK+zJ3TQs1fUJyogOqWxJOaVTn7DPA7YP9vEdM2R3dPpANLN8Yhg0NHryRzzZq2krtz8sitN1d/pIVMuz1XOfbXxVzN+EfhmyuuCtrwFtV/wmt1WcbuVCVAT+xG6F9xdd2wgt4bP/bMFOfoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NClsQPoG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NClsQPoG"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4575Pxgm017082;
	Fri, 7 Jun 2024 05:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=pp1; bh=50091Fs5ys3Dh9bUPL1ogFdV1OFduwx5U9QgcNiymDU=;
 b=NClsQPoGC2N5rhnvifC5POpNihW4jdJyVtqjCan43Mz0fFEhjvkv2HLpzQSm4S15IErV
 o2Y7yjciRoz2VRfep0ixEIGCyME71Tl64G7vklRTIcfseiotcMVkANc3T7YAxQati63F
 8rZ8XJug1CvOIdiX1E3+TcnfcimWxucW5q3/jUuQEPRNFFbGUfsX6dl21HrTxNFLzwip
 cAIVqEG4c94tBHe7/xkO7D6qZobNInv04XUHsKKXjcOL2MWitWgYzIE6zalN8isuGgaO
 qmp72zcm/Dq111KLkkWLFc/Mz/tnqt6Ytk4XfxXROx4x0HwkLoiJxyYWwi8qbkvQJhYi Eg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykumrg3d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 05:44:01 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45750A76008479;
	Fri, 7 Jun 2024 05:44:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygec1737g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 05:44:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4575ht4b51839292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jun 2024 05:43:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08BDC20040;
	Fri,  7 Jun 2024 05:43:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C78002004D;
	Fri,  7 Jun 2024 05:43:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jun 2024 05:43:54 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Speed up test case 70 annotate basic tests
Date: Fri,  7 Jun 2024 07:43:52 +0200
Message-Id: <20240607054352.2774936-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kEb9LOLbDiDfUjC1LoGM_Vzf0d2ghxOQ
X-Proofpoint-ORIG-GUID: kEb9LOLbDiDfUjC1LoGM_Vzf0d2ghxOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxlogscore=898 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070039

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


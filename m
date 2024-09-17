Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF9A155A4E;
	Tue, 17 Sep 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563480; cv=none; b=EqFRhCRE4FaD6kqOoKE9kgFsSi7k+vwEc8Z5wPv99yNsYdrA3XG+Hid5rhxYrndqr8lCKMZrB8wBRnu+Y/meJSl2X9fbWqQxEz93CQshIqdlwb8WjqqUzyQrA9njfrzHSl/7CkRLZcGKFnL0Dr92SfG/qHek2XcGclsH0FcUVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563480; c=relaxed/simple;
	bh=JjP7qTaiTpP4a/ZiT/Z+OaXAbXtoOHmt7PjdpUAKQME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urJxlbW7YVaYj1q3ggs2tQiadeNoCfyYl6y1mtItl3LGiX+OiRE28MMgzWEdKA1PqXmEBHL3L7HNOeC0DGuRxpN8sE631mNBjw/Cf4XDNlVp3PdFpjT7wlBnTpjJ8KkGEvaWIsNMUYnXSLQI+oqXuCrqfQTUddIlmv3hSW7QWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BosfkKcn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BosfkKcn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H3arWV019844;
	Tue, 17 Sep 2024 08:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=AWfZ8ATBorZpXhCiJK6NxRh+ya
	jtEN7MHw4OP+VQzCA=; b=BosfkKcnDUkxHHuDC7nUCHuZUda8j/1PT1qzixrrL0
	+xW6SFLAPwllrCSmNliPb2A8uTNg+hRU+pdXIgEJCX9m/wIGh1U4uLbAvRjL9PdR
	LpxayOTR8akFNox/WHNRyYYfvHYW/czZXIeRiv4CPX3WVQWigYBDEogF0CULqcDs
	UoS+WYMcBoJqbL//JG3rdfhdtZ348e9nL2cP7q3/yf9X1f6bqBwqHJJQ+oRWRgpu
	OdeeKaJotz2vHDCns4rMtaMU6apu2I3fd0b0k8IkLoCJqr6B8uKjzTvr0tHHSsPC
	l6t7FVourkvAJgb1apUdKx4TAzGQoaIcJOaYh5BM77UA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41aeg12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 08:57:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48H5XNqF000842;
	Tue, 17 Sep 2024 08:57:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nn714bbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 08:57:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48H8vJIv34210464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 08:57:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC2B62004F;
	Tue, 17 Sep 2024 08:57:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 825CE2004B;
	Tue, 17 Sep 2024 08:57:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 08:57:19 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/test: Speed up test case perf annotate basic tests
Date: Tue, 17 Sep 2024 10:57:06 +0200
Message-ID: <20240917085706.249691-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JfhsLvr55GTmMiy85U1LQv_VzXZVQB9L
X-Proofpoint-ORIG-GUID: JfhsLvr55GTmMiy85U1LQv_VzXZVQB9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170066

perf test 70 takes a long time. One culprit is the output of command
perf annotate. Per default enabled are
 - demangle symbol names
 - interleave source code with assembly code.
Disable demangle of symbols and abort the annotation
after the first 250 lines.

This speeds up the test case considerable, for example
on s390:

Output before:
 # time  perf test 70
 70: perf annotate basic tests             : Ok
 .....
 real   2m7.467s
 user   1m26.869s
 sys    0m34.086s
 #

 Output after:
 # time perf test 70
 70: perf annotate basic tests             : Ok

 real   0m3.341s
 user   0m1.606s
 sys    0m0.362s
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
---
 tools/perf/tests/shell/annotate.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index b072d9b97387..b28cd95b1d83 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -43,7 +43,7 @@ test_basic() {
   fi
 
   # Generate the annotated output file
-  perf annotate -i "${perfdata}" --stdio 2> /dev/null > "${perfout}"
+  perf annotate --no-demangle -i "${perfdata}" --stdio 2> /dev/null | head -250 > "${perfout}"
 
   # check if it has the target symbol
   if ! grep "${testsym}" "${perfout}"
@@ -62,8 +62,8 @@ test_basic() {
   fi
 
   # check again with a target symbol name
-  if ! perf annotate -i "${perfdata}" "${testsym}" 2> /dev/null | \
-	  grep -m 3 "${disasm_regex}"
+  if ! perf annotate --no-demangle -i "${perfdata}" "${testsym}" 2> /dev/null | \
+	  head -250 | grep -m 3 "${disasm_regex}"
   then
     echo "Basic annotate [Failed: missing disasm output when specifying the target symbol]"
     err=1
@@ -71,8 +71,8 @@ test_basic() {
   fi
 
   # check one more with external objdump tool (forced by --objdump option)
-  if ! perf annotate -i "${perfdata}" --objdump=objdump 2> /dev/null | \
-	  grep -m 3 "${disasm_regex}"
+  if ! perf annotate --no-demangle -i "${perfdata}" --objdump=objdump 2> /dev/null | \
+	  head -250 | grep -m 3 "${disasm_regex}"
   then
     echo "Basic annotate [Failed: missing disasm output from non default disassembler (using --objdump)]"
     err=1
-- 
2.46.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F9605C6;
	Thu, 13 Jun 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278053; cv=none; b=HuspsGSPh9UZvziSi6wdbc1wQtUHA+yB0CpH5po59Ec98O5YhrJJBg2BGlL2e/cubsFV+sIGHqZMjtsLWZy1nSMRxXla2yVtCAUNMpCoMH+7x8ilAddo1G7zMoFHMDaDj9YUpDEjJTUq5PGtFjx/4EreWk34Yi6Zb2tvcgxCFqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278053; c=relaxed/simple;
	bh=iL7CwAKS/IwL8enlPQzHrOq5sJ73P0VF652E/ZHm7zw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tM33Cb+etD8xYYY/BRp/uMZyPvCXH/QVWq0XVHOOp6+DKGqBq/BRs1PRiZCDqPALqeoqEmL/CxWwwUO2fRH9Frpca/5T5FGuFPdoFPy/3QgSOItKOhlTQ5XMqiIN2b9YT/+s849W0qaekj8BJonFGUTsyv6lR0X2oS30chBU0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LuN5eF9+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LuN5eF9+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DBKUUx025624;
	Thu, 13 Jun 2024 11:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=vH7wvLw/fbaso/2vKJV9FkAQ/J
	V6KMc2dBTHBYAqFc8=; b=LuN5eF9++GnjvHuSZ9HtyzV+RYPLz9WUyTthxDr0s0
	jo5GSA3jMPkwF77T9cE9dsLumilzhxeaFoPoMXSFq4Pzawme0JtTqTLSryninl9t
	suYOE8/4p09bI2rMY6crmAjlBzY6bp7diSw9Url4XJ4/6k/7xfW1HdfarNXuVU3s
	xA1Q+EqvBs3Y3ssRCTF7ihkdBhUVXklKXnv5sR4dbtiRUE7T9aL4bfghNTy/z6sz
	NiD4vG4JyKAnIPTNK9WWit7Y0tZW0HGnMmCCbnpNetI9bxPLvjQIk697xdvcgsDL
	gz249ZQ1gskKV1B7GYxTnqoJo/q4eEZZ8CyTyQE8IBUw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqrexs8sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 11:27:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DBHaE2028690;
	Thu, 13 Jun 2024 11:27:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn1muq45j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 11:27:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DBRK8e43057510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 11:27:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3FA620043;
	Thu, 13 Jun 2024 11:27:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A11F520040;
	Thu, 13 Jun 2024 11:27:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 11:27:20 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/test: Speed up test case perf annotate basic tests
Date: Thu, 13 Jun 2024 13:26:55 +0200
Message-Id: <20240613112655.4082737-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Dh4YQfKtkZHP9eOakg6Sfdxws854P7_g
X-Proofpoint-ORIG-GUID: Dh4YQfKtkZHP9eOakg6Sfdxws854P7_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_03,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406130082

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
2.45.2


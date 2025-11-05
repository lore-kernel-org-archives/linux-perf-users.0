Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1861426560D;
	Wed,  5 Nov 2025 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370203; cv=none; b=lQd+wsUza6qxesFOH8+dSHOo6dlXmxNWvJUj61LPwIQbIjlP0G8B7lYgcS5AHde6Cp8Uj7sIC5RMwu3D8UJAP3y2csgoRtq+8Pf77NfzDcniq3Gnw73Z09cs4Qrc+BMUCxTI9TcZhC/QPu+iCYiuKWixeJdjFjOm3TZ+sePC7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370203; c=relaxed/simple;
	bh=y0I3ywJfgU14mhdocsZghcDODSmE0AQjRwQb8FWlXZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3gepWDonnllfKxSnaTtVw8VV4BsVY94OfJySRXk5LSxPS3hriadshUNfvGwskCswfk2THkLlN1keNNhgcJ+BtIY3OBzjhnORH3LmxPCUgDPzE49huQDCRI5w2byr6TuJLcyFlov04r7pFlxSozg5DrYsTcW7NmQGKXL7VKBgPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mwvbwwrq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mwvbwwrq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5Fab8E023094;
	Wed, 5 Nov 2025 19:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OReeLvTuehb8VFolv
	BTYDo9jRGmTREs3SO7FB4+siaM=; b=mwvbwwrqb+2pAPwapOYLEF3FlhBqmoHgY
	6hs+itxePeSHPr0Zhoqr9Gn7QaL+CMClEwde2lyK8kMwTYQEuwb4ya9VHC/XRRWB
	15PCcs5JEA30bf0LjgoL3QKGNJt3RAX/I7dQjpPeYbTvHli/sR5XoAuhNDOmcpC4
	kw0971BMVU3YmCvdnmrovUmTGzJvSza4x7HOCayzIUjEKVn+9gaLxT+vbRssOUEt
	k31CODAK36G6JBXQL+btrlS/JaNQzwNbpkRiuo7pOOPD13Lp9Outgql0H+IL35JP
	WuZiLAMvkNH/VwtWjU2FqUDyhrdVLMr+/pGt2VTqoq6gAJBIa89Pg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xc3809-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:16:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5GCfwV012875;
	Wed, 5 Nov 2025 19:16:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5y821h1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:16:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5JGYbm54395314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 19:16:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA6102004B;
	Wed,  5 Nov 2025 19:16:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EED120040;
	Wed,  5 Nov 2025 19:16:34 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.135.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 19:16:34 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/5] perf test java symbol: Extract LIBJVMTI detection
Date: Wed,  5 Nov 2025 20:10:26 +0100
Message-ID: <20251105191626.34998-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105191626.34998-1-iii@linux.ibm.com>
References: <20251105191626.34998-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX6A/tTYnGNH7O
 h1inTvKNb8H3Dkj5evMtELePyMZGC99RbaEu0TT12Qw70MAtCZAvjJXDViaSXhNwZymvT6/baOG
 wzHaHIIzWevIotR7iwsCC7Jm0gsQkiPfxYk+ZwlTCGqWHA8DMLqBh2emHfb8izIWOkLYDTYMeNQ
 Dajnq/Fh7QQwPyeNNqOA2a3eioXov/Udu+ZsnbLVrJJHSBEH0Q0gWvCRIgKAKBRfw0PLwPRIp+G
 ih9DYGalG+krqPFU/J1pjPJRMTKNh7lO79cfMc4NJcgPm6a5XKWTYJ4CMzl6WfQGN2WKNoy2+qb
 wWUxnq3ihVbe0Q2CeRfqOUuDDu3+jXcB1mlThF4KBXZEEjh8zVuX/lwI2kv5/LLZQDa/GfTa4S4
 /SuojPtX7BWESiPeTsazxoaY7GBThw==
X-Proofpoint-GUID: vhD4owe5hidJS4vjW-Q7VmpWM2a_OptJ
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=690ba297 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=eP20pe4kTd3lE2_0kUEA:9
X-Proofpoint-ORIG-GUID: vhD4owe5hidJS4vjW-Q7VmpWM2a_OptJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021

Extract LIBJVMTI into lib/setup_libjvmti.sh for reuse by future tests.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/perf/tests/shell/lib/setup_libjvmti.sh | 18 ++++++++++++++++++
 tools/perf/tests/shell/test_java_symbol.sh   | 17 ++---------------
 2 files changed, 20 insertions(+), 15 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/setup_libjvmti.sh

diff --git a/tools/perf/tests/shell/lib/setup_libjvmti.sh b/tools/perf/tests/shell/lib/setup_libjvmti.sh
new file mode 100644
index 0000000000000..fab4a44f8ecb2
--- /dev/null
+++ b/tools/perf/tests/shell/lib/setup_libjvmti.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+if [ -e "$PWD/tools/perf/libperf-jvmti.so" ]; then
+	LIBJVMTI=$PWD/tools/perf/libperf-jvmti.so
+elif [ -e "$PWD/libperf-jvmti.so" ]; then
+	LIBJVMTI=$PWD/libperf-jvmti.so
+elif [ -e "$PREFIX/lib64/libperf-jvmti.so" ]; then
+	LIBJVMTI=$PREFIX/lib64/libperf-jvmti.so
+elif [ -e "$PREFIX/lib/libperf-jvmti.so" ]; then
+	LIBJVMTI=$PREFIX/lib/libperf-jvmti.so
+elif [ -e "/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so" ]; then
+	LIBJVMTI=/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so
+else
+	echo "Fail to find libperf-jvmti.so"
+	# JVMTI is a build option, skip the test if fail to find lib
+	exit 2
+fi
diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
index b1d7cd43af01a..f36c9321568c5 100755
--- a/tools/perf/tests/shell/test_java_symbol.sh
+++ b/tools/perf/tests/shell/test_java_symbol.sh
@@ -26,21 +26,8 @@ cleanup_files() {
 
 trap cleanup_files exit term int
 
-if [ -e "$PWD/tools/perf/libperf-jvmti.so" ]; then
-	LIBJVMTI=$PWD/tools/perf/libperf-jvmti.so
-elif [ -e "$PWD/libperf-jvmti.so" ]; then
-	LIBJVMTI=$PWD/libperf-jvmti.so
-elif [ -e "$PREFIX/lib64/libperf-jvmti.so" ]; then
-	LIBJVMTI=$PREFIX/lib64/libperf-jvmti.so
-elif [ -e "$PREFIX/lib/libperf-jvmti.so" ]; then
-	LIBJVMTI=$PREFIX/lib/libperf-jvmti.so
-elif [ -e "/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so" ]; then
-	LIBJVMTI=/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so
-else
-	echo "Fail to find libperf-jvmti.so"
-	# JVMTI is a build option, skip the test if fail to find lib
-	exit 2
-fi
+# shellcheck source=lib/setup_libjvmti.sh
+. "$(dirname "$0")/lib/setup_libjvmti.sh"
 
 cat <<EOF | perf record -k 1 -o "$PERF_DATA" jshell -s -J"-agentpath:$LIBJVMTI"
 int fib(int x) {
-- 
2.51.1


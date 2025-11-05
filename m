Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3B31328A;
	Wed,  5 Nov 2025 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370202; cv=none; b=k2nOVmtAdTPUU2hnDM/RmRw8p5WJseETGChd9awx6OCUYWAoaAN6B4uFSijnJSi0Qz6yZRfdAbs+By/jvdwP//1qZUA12kZ750dLEtyniAoITRnQSNEHHdZXLF4LDW11LV/HdbU2DujRgrm9KJinOqCPdKAp2LupYimxmTkjJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370202; c=relaxed/simple;
	bh=qa5CE62I4QdqMVTINDn/2L6tShJyDKFrJ7cig69/BKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwmvq+/gKA7nXOzFkoxg+vf6E/4glqQoFAXv35yv994Fl0ilSL73R2jX6hlxKvID6wKVrC67L17JK3Y5JOGttuvmuREr6kQBKRaWPRN8F+TnEKwPjgtnT8LCFvgGWmBGlAGnDtZlgazdFmBdx1OyiECmRdLWT3mtkc3wcDFjsvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AJOMHF5s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AJOMHF5s"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5FUD2O009906;
	Wed, 5 Nov 2025 19:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+fzVlHDQpgFkvnVrg
	z/csJQAUTecVeOjHoOubrzEtZQ=; b=AJOMHF5sGxUbCPTha8Z/JVt+t8aEX4AM5
	THM3aeRgX/W/FGNKMjBVLArjuKQ7p2BUC+VBUJRUZuGFP8+cxDeTG4uW7HEOqJ1X
	Jr5XiMvcUtJudSJn5Nlyi1iNwFm8SxxdNP/IPM0C0gAsEQujWrtUj+S9QkzYT0+s
	G2xTFhuU+7evKH8s6DRLcyRvw9XO9IyV+OJwvBh8YqQkSmjM5iag+QVwZ/AvAEpM
	x3lgJ7BZOqj8gstkVIaSywC5iC9zNsxUiBHFMKaStXrBFg4mL04CuO+wfqqDmARK
	MJ4S45ib/MHGkbK8qhMtDFFKiFxOd2U23hsnY22kdKpYn4iZbHmsw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xc3808-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:16:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5G7Vbv021491;
	Wed, 5 Nov 2025 19:16:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrjskjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:16:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5JGY2653674414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 19:16:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44FA52004B;
	Wed,  5 Nov 2025 19:16:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFD2320040;
	Wed,  5 Nov 2025 19:16:33 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.135.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 19:16:33 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/5] perf test java symbol: Get rid of shellcheck warnings
Date: Wed,  5 Nov 2025 20:10:25 +0100
Message-ID: <20251105191626.34998-3-iii@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX8Sd9rvdeS7pZ
 H8tK94FqHR6iIqfjZB1LHitKsktJASP6CEcxROTSld+zDrCgw6ABJqsuxqi6aJf1+slR6B7eP2q
 dcAhzS0YnV25LGjyx3tKec/DQ2ZngtSxegC7Z7sfmGwmqWly4YfdW2yml9y1jIc0yDNom38xYK1
 fiD+QmeOTWBNcCTYhgGg6jMRky0psKdpKVPh4YRhKRG+ZT84WVHIIlca6IbnVAeYD+FZLH7mM8j
 /2K6MwGKKteL6L6RN0qEGX1lshje15QGnmNtyk9jrVHtkYJcZ3vuzkUOrhchf437lX//Snuau/A
 HVhds4KmkTGVPfyRpIMiZlshtzokyRZv+P776huyO58IZrjoaq7GYC8NG1c9eeh5saPk38nK/XC
 mHuYYXBbVuwUUzOB2ETu0P3KKYFqwg==
X-Proofpoint-GUID: T5DP3SlHhtcxiDSkOJXVJw3QvJoMGPRW
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=690ba297 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=ZbB1VCf3sOdwrY-7MgYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: T5DP3SlHhtcxiDSkOJXVJw3QvJoMGPRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021

Add missing quotes and suppress the $? warnings.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/perf/tests/shell/test_java_symbol.sh | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
index 499539d1c4794..b1d7cd43af01a 100755
--- a/tools/perf/tests/shell/test_java_symbol.sh
+++ b/tools/perf/tests/shell/test_java_symbol.sh
@@ -4,6 +4,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # Leo Yan <leo.yan@linaro.org>, 2022
 
+# Allow [ $? -ne 0 ], because long commands look ugly in if statements.
+# shellcheck disable=SC2181
+
 # skip if there's no jshell
 if ! [ -x "$(command -v jshell)" ]; then
 	echo "skip: no jshell, install JDK"
@@ -13,11 +16,12 @@ fi
 PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 PERF_INJ_DATA=$(mktemp /tmp/__perf_test.perf.data.inj.XXXXX)
 
-cleanup_files()
-{
+# Shellcheck does not understand that this function is used by a trap.
+# shellcheck disable=SC2317
+cleanup_files() {
 	echo "Cleaning up files..."
-	rm -f ${PERF_DATA}
-	rm -f ${PERF_INJ_DATA}
+	rm -f "$PERF_DATA"
+	rm -f "$PERF_INJ_DATA"
 }
 
 trap cleanup_files exit term int
@@ -38,7 +42,7 @@ else
 	exit 2
 fi
 
-cat <<EOF | perf record -k 1 -o $PERF_DATA jshell -s -J-agentpath:$LIBJVMTI
+cat <<EOF | perf record -k 1 -o "$PERF_DATA" jshell -s -J"-agentpath:$LIBJVMTI"
 int fib(int x) {
 	return x > 1 ? fib(x - 2) + fib(x - 1) : 1;
 }
@@ -56,7 +60,7 @@ if [ $? -ne 0 ]; then
 	exit 1
 fi
 
-if ! DEBUGINFOD_URLS='' perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j; then
+if ! DEBUGINFOD_URLS='' perf inject -i "$PERF_DATA" -o "$PERF_INJ_DATA" -j; then
 	echo "Fail to inject samples"
 	exit 1
 fi
@@ -64,8 +68,8 @@ fi
 # Below is an example of the instruction samples reporting:
 #   8.18%  jshell           jitted-50116-29.so    [.] Interpreter
 #   0.75%  Thread-1         jitted-83602-1670.so  [.] jdk.internal.jimage.BasicImageReader.getString(int)
-perf report --stdio -i ${PERF_INJ_DATA} 2>&1 | \
-	grep -E " +[0-9]+\.[0-9]+% .* (Interpreter|jdk\.internal).*" > /dev/null 2>&1
+perf report --stdio -i "$PERF_INJ_DATA" 2>&1 |
+	grep -E " +[0-9]+\.[0-9]+% .* (Interpreter|jdk\.internal).*" >/dev/null 2>&1
 
 if [ $? -ne 0 ]; then
 	echo "Fail to find java symbols"
-- 
2.51.1


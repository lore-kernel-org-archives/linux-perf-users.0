Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F841E22EF;
	Thu, 30 Jan 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738238301; cv=none; b=lKXrSPFfDICnFWf1h98bDFkFD94d+7x2wqPYLDiJbbuttFdjsCLJePNP4dVkFuKHhC0siKh3EgLGhoJAzcb32f2m7rJ1oGV/H4izZ8o4TxJ/AukqJgBJLadVKTtNcUgzjF8K0vZ5pn7EX8yC6LJ4OuLSbq7yGEBOV7bfXSeOYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738238301; c=relaxed/simple;
	bh=Or/6fCKCqKtt5SN3Lut/GMF9jqBGeoACs4wpamdqgHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6SchQZGsDuDHMdDjbERbxme9E9Kf080W4Gfc1aoLdh7Oiy74xtUkcQ17Qf1WTj2vBEhXBkxmM783wGCxTs6dpEZV8L4Hxt24j+WxFv6sagNw/kFNVBOhOz9NTMBbMCEvwpDJZro7t3xMPV1KWhM3RLPIBRZ0gPWKw+s9i4wEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lPuOQhjU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lPuOQhjU"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U20iRO019638;
	Thu, 30 Jan 2025 11:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ASPXOmE7lC753IK6r
	fatZzvyYIr+iTWBz16mvoVF55I=; b=lPuOQhjUj5mauWxkFWGBH8oSRiWDt96AH
	R2OOn2Br2U7nUJIQM65rp5SWhV+JSJoFu+WDI4MlnJfjpxb6yCSS9xgpOhurXDJI
	/+SNKZVPGi7V4IiPDYWK24Tdr1mjgmBPQtbdp8NuiXLq061tUXL2pg7kcTYRwZZ0
	Edyz97ou0EpeaJ6bG3PtuS3qAgZSA9yJ9SVblK7T0SmeFsw5zR9VHFqSzhRLl+Ht
	Kw1X/UFGg+iRKchLVY/Q1OgFUcHwtMSifOnt/5ZhhptUfI2w61j+XnAIbsavbOZr
	5t4z3R6R1NOEXMmZ/rLb8s7928je+TAjbMlEUU27aX3wN28KkLn7g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44g08yt5vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 11:58:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50U93q3L022172;
	Thu, 30 Jan 2025 11:58:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgjwnd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 11:58:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50UBwBxH52953568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 11:58:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B4E22007B;
	Thu, 30 Jan 2025 11:58:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4419520079;
	Thu, 30 Jan 2025 11:58:11 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jan 2025 11:58:11 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@linaro.org>
Subject: [PATCH 2/2] perf test: Change event in perf test 114 perf record test subtest test_leader_sampling
Date: Thu, 30 Jan 2025 12:57:56 +0100
Message-ID: <20250130115756.3961722-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250130115756.3961722-1-tmricht@linux.ibm.com>
References: <20250130115756.3961722-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lb5VgRA2DhIz1bYfRhPs52RVHh_XNEDO
X-Proofpoint-ORIG-GUID: lb5VgRA2DhIz1bYfRhPs52RVHh_XNEDO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 mlxlogscore=884 lowpriorityscore=0 mlxscore=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300089

On s390 the event instructions can not be used for recording.
This event is only supported by perf stat.

Change the event from instructions to cycles in
subtest test_leader_sampling.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/record.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index b905acde8358..a17018181afa 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -231,7 +231,7 @@ test_cgroup() {
 
 test_leader_sampling() {
   echo "Basic leader sampling test"
-  if ! perf record -o "${perfdata}" -e "{instructions,instructions}:Su" -- \
+  if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
     perf test -w brstack 2> /dev/null
   then
     echo "Leader sampling [Failed record]"
@@ -243,10 +243,10 @@ test_leader_sampling() {
   while IFS= read -r line
   do
     # Check if the two instruction counts are equal in each record
-    instructions=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="instructions:") print $(i-1)}')
+    instructions=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
     if [ $(($index%2)) -ne 0 ] && [ ${instructions}x != ${prev_instructions}x ]
     then
-      echo "Leader sampling [Failed inconsistent instructions count]"
+      echo "Leader sampling [Failed inconsistent cycles count]"
       err=1
       return
     fi
-- 
2.48.1


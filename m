Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409518C31;
	Wed, 29 Jan 2025 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134721; cv=none; b=RLw8dLLDfE0/KuTr7rBmLQVxm82QZ68WA05j91RafdJrIVrfQhQTCGl/CfM6Fl6Jv8Z3ZNV4g4XeVjhlyslQWXJyXgNkzx9PKbIN5warVXusAmx5E6uuoSJk3OgPOj2ooLAC/iEj4bjq7fEwkwU3CkSKIyqUdgJpujOoC3X973Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134721; c=relaxed/simple;
	bh=MuAsiRgOhbRLRI3ShUHQz/qQeIbrg6uTNIEBh76sWcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbACePykj41PfX+evSMGRvQ+Lj36toLKSOcd9g4tEz+1G5HdO7xesIvB+gY7VYEqeawmEIFpeAGQ1XOarFvvsjGJ6jHWAMbqx7zEiutBkmSfh43C5JgDvmf2tef1mpbjmbsxWrk3j9AB5GVgy3Y0R+UpX5u+7XgOF+NklhQPgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RGkjOdKa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RGkjOdKa"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T184HH004465;
	Wed, 29 Jan 2025 07:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+xHDUA6VMa3g473sukbHieS+hPftczf8j8JRQ5Y/T
	o4=; b=RGkjOdKaLY/tjs68ISaDxxiscRhHiNbO5pmEydeFwvD1LrBpcb6zEx2XD
	X1Hkj+mxOyCLTraYP4XEUzBwm25AnyQ2PwDW1z7SZGR4/CwQZiXfwrc20XCvuNKI
	vIXSxB0T8b3m/DFBsnhqEyz52woe5DoBGrM5M3gkqZI/3C/2WlCZLLpDwpzSt2fH
	/uMCyn4N+AC+vcn/EatHrxOs4k4isV9eNoyHMyCO0brjYfnsf39WNinzcsAodox3
	u69E5TI4QuubG9uFH/Qkti3xRTihMfDIKLYfzOZzSgRebTYg8uJJpkc/aX5RNpj2
	0KAp4aJABNjpNPMnZeYanP4i+7Hsw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fad9h5b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 07:11:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50T3vBCH012476;
	Wed, 29 Jan 2025 07:11:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dany7jg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 07:11:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50T7Bimt31589084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 07:11:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 266F7200CD;
	Wed, 29 Jan 2025 07:11:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEBFF200CB;
	Wed, 29 Jan 2025 07:11:43 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jan 2025 07:11:43 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@linaro.org>
Subject: [PATCH 1/2 v2] perf test: Fix perf test 114 perf record test subtest precise_max for s390
Date: Wed, 29 Jan 2025 08:11:33 +0100
Message-ID: <20250129071134.4024430-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BDNm9gTeABAZLhWGf_cKiEnNvh2yBC1y
X-Proofpoint-ORIG-GUID: BDNm9gTeABAZLhWGf_cKiEnNvh2yBC1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290056

On s390 the event instructions can not be used for recording.
This event is only supported by perf stat.

Change the event instruction to cycles for subtest test_precise_max
as suggested by James Clark.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/record.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 0fc7a909ae9b..957ee10aff44 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -287,9 +287,9 @@ test_precise_max() {
     return
   fi
   # On AMD, cycles and instructions events are treated differently
-  if ! perf record -o "${perfdata}" -e "instructions:P" true 2> /dev/null
+  if ! perf record -o "${perfdata}" -e "cycles:P" true 2> /dev/null
   then
-    echo "precise_max attribute [Failed instructions:P event]"
+    echo "precise_max attribute [Failed cycles:P event]"
     err=1
     return
   fi
-- 
2.48.1


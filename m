Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01E815FD13;
	Fri, 15 Nov 2024 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653925; cv=none; b=ffsByuZxR2HC5HNyMCd/bcBK+LcjS0AuX8Fyt7q8KiyufwL1LtAwjgz4QDQaxOM3NnpZDyEUinPfI7OYD5nxRgmDBFoR2bR3kIZVaaxc3GRa4QUA7FUupMswUxztHgh919+qZWzX6cEdMBBch9LI3lmaMJEBKVJQO6i6eZwv/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653925; c=relaxed/simple;
	bh=10du59C/TjTMek/wJqaaitNg65N/1xTl/sv46eFN7Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvYpkD1v5Ci2MQUmfAF/EwWLgYL7mXOwpQp5EGD8M6SNbV4UKIoQH6BfTM0GcFJ7o/VxvTSPvMwsmiUjG9wcZK07Pdn3bkMrrjArQwaSO6CkgK0bCDzkFc15+0u4qK12vDQnMjDneQAY0mr8b302VPHTrPaT46ywys+zH3KX9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tONJMBVo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tONJMBVo"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF0knSc024160;
	Fri, 15 Nov 2024 06:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Xm88JJ/2BqYNLX0CZsa3yZ+pb86eV5BH3J808h1F8
	7A=; b=tONJMBVoXU4TOtMIIwda/+QbZCW56Ez1BYknIuXa6MhROfkZ5vtWXF74D
	SboH4tazHttsozH94WiLxPnHTiBzU41uMVGLL+NEDRqs+aO8qfQGbCyl761Baz7G
	pfVtIsOtDqhwkEeDfDPHpY5rj6/8FvT3hkg2oXRMZQqdnpKPFVyzcMLKpd5wc9zH
	simts9srMbjy/mLyD5DnUnh1SSN25MXYEcBsRBhEXk4sIbrS6QhmQeSsoe3pNVxG
	ykwm3HIbGZAukhlAlq08oOVApdP2lMu2TqLxbTTEY6c4yiSeeLuQ+9hxcVFFZbA+
	vOrPEolGfTyPq9+YkkOevilRCe78Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wu2vsm7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 06:58:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF5C7pZ029689;
	Fri, 15 Nov 2024 06:58:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjmq83v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 06:58:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AF6wYJS34013702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 06:58:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E16220043;
	Fri, 15 Nov 2024 06:58:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ECDB20040;
	Fri, 15 Nov 2024 06:58:34 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Nov 2024 06:58:34 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, james.clark@linaro.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2] perf/test: fix perf ftrace test on s390
Date: Fri, 15 Nov 2024 07:57:35 +0100
Message-ID: <20241115065735.2753032-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xzeUxkdyVjJP3Lf_7IMC0yZOOLbPUvoL
X-Proofpoint-GUID: xzeUxkdyVjJP3Lf_7IMC0yZOOLbPUvoL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=668 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150054

On s390 the perf test case ftrace sometimes fails as follows:

  # ./perf test ftrace
  79: perf ftrace tests    : FAILED!
  #

The failure depends on the kernel .config file. Some configurarions
always work fine, some do not.  The ftrace profile test mostly fails,
because the ring buffer was not large enough, and some lines
(especially the interesting ones with nanosleep in it) where dropped.

To achieve success for all our tested kernel configurations, enlarge
the buffer to store the traces complete without wrapping.
The default buffer size is too small  for all kernel configurations.
Set the buffer size of /sys/kernel/tracing/buffer_size_kb to 16 MB

Output after:
  # ./perf test ftrace
  79: perf ftrace tests     : Ok
  #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/ftrace.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
index a6ee740f0d7e..6161a8bdc251 100755
--- a/tools/perf/tests/shell/ftrace.sh
+++ b/tools/perf/tests/shell/ftrace.sh
@@ -14,6 +14,11 @@ output=$(mktemp /tmp/__perf_test.ftrace.XXXXXX)
 
 cleanup() {
   rm -f "${output}"
+  if [ "$(uname -m)" = "s390x" ]
+  then
+	echo $ftrace_size > /sys/kernel/tracing/buffer_size_kb
+  fi
+
 
   trap - EXIT TERM INT
 }
@@ -80,6 +85,12 @@ test_ftrace_profile() {
     echo "perf ftrace profile test  [Success]"
 }
 
+if [ "$(uname -m)" = "s390x" ]
+then
+	ftrace_size=$(cat /sys/kernel/tracing/buffer_size_kb)
+	echo 16384 > /sys/kernel/tracing/buffer_size_kb
+fi
+
 test_ftrace_list
 test_ftrace_trace
 test_ftrace_latency
-- 
2.47.0


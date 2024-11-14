Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A731DE4DF;
	Thu, 14 Nov 2024 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574929; cv=none; b=jtS4J0BeJezQ12MKXhlsdl1TSlFJ1ZOOHbkzPOGPT7qYpx6fAA9aNAXCRW0H8JRg/kRLJAjzeMwc2AGqjL3LnhimLfm4Fwz9aqxfqkC5JtQy/gBbxvdL3MMQ1nlx/MfMHaYZa1+zWUfzkXOd94uWPNBAJ9uk1ehBw//4X7ng6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574929; c=relaxed/simple;
	bh=33wkVH5z+Hi0e0Req1Aqd9thlLQV7c9L31n1CexDbWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nV7JZGud1li1g2fcnWmywf4B1H/WxsPD2sCJkzDHELCalyoQt8vPHJd0WgtItCDtAjGyBdnZgsW7nF0d14Se2YTf/Mc430MjqZiYndX4UwvnCvrb28KK+/6poPIELMzW6EIKZLIGSTJNNnPRkkHhJJjE2ZLgJK4t4nAXsV0kUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EKTPSeFm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EKTPSeFm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE7eVaJ012629;
	Thu, 14 Nov 2024 09:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MqeuLfUbDRNZZs8eevNfmr+SMsWmpyyfXM0xhonnd
	C4=; b=EKTPSeFmHDSlws6slYmLKgGl+OVDRMdj0AixkqPrXJCM2BaEIs/chxb9F
	e7ryueBDSK7MFOyX6MkaIr+hTr0MWoP+j1o0zkppfyr9SWf+z33EXLBkVKbVWBON
	aup06GbULV1A7GkoKZae5r2QiKKXwUYhxlouDXSqcdaIyYreA/9HTzadr8LfL1rg
	rMQ29thIklxQYV34jRiVtTXwyDuVB0/IaU3P8EjkwyKyRCgh1x1ojK/oVD6+uGv6
	gx7gQvV9BWNI4lQrnh2X5rdMqOzoEGvK2ZVHha7Bb3gojceKekizyiP87AGtsPVT
	JsAffUn7WCbNUqUxxnozB6OflV7Nw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wd0ygkay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 09:01:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADNBcJV010514;
	Thu, 14 Nov 2024 09:01:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tj2s82ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 09:01:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AE91sit27525788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 09:01:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6037A20040;
	Thu, 14 Nov 2024 09:01:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39A9820043;
	Thu, 14 Nov 2024 09:01:54 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Nov 2024 09:01:54 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, svens@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PING PATCH] perf/test: fix perf ftrace test on s390
Date: Thu, 14 Nov 2024 10:01:49 +0100
Message-ID: <20241114090149.1489811-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aSeNnrogSbAZqLgBd0SUdPkTldE5351d
X-Proofpoint-ORIG-GUID: aSeNnrogSbAZqLgBd0SUdPkTldE5351d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=763 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140065

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
---
 tools/perf/tests/shell/ftrace.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
index a6ee740f0d7e..742d6b8f34d3 100755
--- a/tools/perf/tests/shell/ftrace.sh
+++ b/tools/perf/tests/shell/ftrace.sh
@@ -80,10 +80,21 @@ test_ftrace_profile() {
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
 test_ftrace_profile
 
+if [ "$(uname -m)" = "s390x" ]
+then
+	echo $ftrace_size > /sys/kernel/tracing/buffer_size_kb
+fi
+
 cleanup
 exit 0
-- 
2.47.0


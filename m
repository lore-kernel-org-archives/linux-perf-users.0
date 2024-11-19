Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063EE29CA;
	Tue, 19 Nov 2024 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731998956; cv=none; b=e2WHHNPP2t7mf9Wc2FoO2wv47WVjqXQN/DRGB7mVE66StYijxgyBhZWK50n1QDfqlT6lZsa6CuQF6bOhsdadec2xAHzoMJEbCm0FR+CNW+ZvvZKqZUex5DHt/jaa9fn5xnloefU4k4JCmfNcXujyd1EBtvzcLqxacSv+VxNrtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731998956; c=relaxed/simple;
	bh=8LGnNifdgqrlNX4CXKFvUsjnc6CLD/Ck8HSTIpMOTE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d8ONmujp9U6/aDXu6SGSn2ng3BPv5e5JEZ6nVfSnB32c04xci0uGSyPOZ4+H2fZfkrbf9E6VUyEpLzZ9RJZY4VrOAFAzYNR5IDnV0Y+66jaMqcABVoNFe0wTyHCaxPGzvJX1J7jiXmaE+4mMN1QUK25/jGbMiDll3r0GGUI6h6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HIDPvhy7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HIDPvhy7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIHJ8c3022084;
	Tue, 19 Nov 2024 06:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NWeiptRS/j6bbEgpHMZEqolaKWIO2bboeAEBvFQH/
	64=; b=HIDPvhy7QMGLmTm8firgnQolTqlc9m6X03MhuujToDVU0eP+QY/I+B5OH
	vNHAdUDJZXiNMnROdiPSj304LQuu+8AqqU7InEEwsuSe8XAjLB5Q19mxhCbXAmag
	1jMbAu4SYAHeS5EKVTxgyQi1RUnQeLQVKc4RSvWNAnEqGDvOwMCQM+TzgDKzKvAV
	xOrHxx+qRTNvdmEHsn1Z0+tLwIkHRInlFGRk4pXs7RhfI6YG3M4u89kYWXzimzgJ
	l7Guzg/eIltiJoCOWv6gaEwGcwqTWxS+vy2K7DVBpuCss2Ni9qraSf4SfJVFFtyT
	0ud30MHJymDaqY69+4VBZ+DCDYfwQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk2vxc55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:49:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ1UxYf021983;
	Tue, 19 Nov 2024 06:49:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y6qmv1eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:49:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AJ6n7cq20906488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 06:49:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CEC020040;
	Tue, 19 Nov 2024 06:49:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3C5620043;
	Tue, 19 Nov 2024 06:49:06 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Nov 2024 06:49:06 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3] perf/test: fix perf ftrace test on s390
Date: Tue, 19 Nov 2024 07:48:56 +0100
Message-ID: <20241119064856.641446-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GSdleqlpY1Qmx78ybu6gsrJyJOXd19WL
X-Proofpoint-GUID: GSdleqlpY1Qmx78ybu6gsrJyJOXd19WL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=935 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190047

On s390 the perf test case ftrace sometimes fails as follows:

  # ./perf test ftrace
  79: perf ftrace tests    : FAILED!
  #

The failure depends on the kernel .config file. Some configurations
always work fine, some do not.  The ftrace profile test mostly fails,
because the ring buffer was not large enough, and some lines
(especially the interesting ones with nanosleep in it) where dropped.

To achieve success for all tested kernel configurations, enlarge
the buffer to store the traces completely without wrapping.
The default buffer size is too small for all kernel configurations.
Set the buffer size of for the ftrace profile test to 16 MB.

Output after:
  # ./perf test ftrace
  79: perf ftrace tests     : Ok
  #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Sven Schnelle <svens@linux.ibm.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/ftrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
index a6ee740f0d7e..a785a6274922 100755
--- a/tools/perf/tests/shell/ftrace.sh
+++ b/tools/perf/tests/shell/ftrace.sh
@@ -67,7 +67,7 @@ test_ftrace_latency() {
 
 test_ftrace_profile() {
     echo "perf ftrace profile test"
-    perf ftrace profile sleep 0.1 > "${output}"
+    perf ftrace profile -m 16M sleep 0.1 > "${output}"
     grep ^# "${output}"
     grep sleep "${output}"
     grep schedule "${output}"
-- 
2.47.0


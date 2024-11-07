Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1221DBB37;
	Thu,  7 Nov 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983014; cv=none; b=WpPT1BtKi4C85hyFiNUKATdKSGHwusbJzzyzIq9akuc1LJrER1OmWHeT+tJDhOi6ypb/Fl/301OayMVaikWSTcF5vjZttSgVX0ZlvNq2qsL0lekX6ox2DVM3IhZLzJHaFbSG1GQAjmHLgNBClrYSW3/q7QsnmvRla7HYUNjoVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983014; c=relaxed/simple;
	bh=6dvnoTqO3q8KZpVUlVWdI9dFz4kSpmWF2YL9zkud6Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cqkbM41+598ivgDoIethg7IwJp6aJyPcz8SHIK7K2a7Y6GVq2lbr38Hr7CsTbRmITFdXtPcQT3rtVzVv1A1m1MGarUyCkJ2jATlVRvfiPyuKbI4DinAOrpSGzxCTrAFFB/KX1qUKqWI36QqCktu7X4RXR4iQ3cKo7M9+eySr2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KOPfZKvy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KOPfZKvy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7CA5h7018741;
	Thu, 7 Nov 2024 12:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TJ8iE+voOCuc4XW4iWjH/BitMLRqqXjczgxUb0bSz
	pE=; b=KOPfZKvy2mttYKqbbzcJlgaCKaDpCxWBccwA3wXEVAuxBGCGfDSNmGYGy
	3S7w9e0RiRqhkVNtakyFfyH8EVqAK7T05nM93w2/drnjUIanP+IXerIC3xfC7zuj
	orPWcNq9IaXjiVv6dE3IlLblfYxbknsmjXoocMsTKDQ5EKjgBMVGwbyDKI11AT8x
	x1q88NudXcWmCm9qZQb+UJLL6mK7VcR0pwGv625tktwqRxUyBYnKL46WjU5EMvdU
	4nIgZCVJdKJx9ozFSq+P1vOo1kuGSjIP2WuZluK1l3OqcljSknfyQqC0vjnEJpIx
	7LhIvU+LCLUxCMj8KvvPaDCUEDlwg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rwag82sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 12:36:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A76q82f024314;
	Thu, 7 Nov 2024 12:34:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj83bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 12:34:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7CXxV756099190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 12:33:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DFA92004B;
	Thu,  7 Nov 2024 12:33:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0943B20043;
	Thu,  7 Nov 2024 12:33:59 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 12:33:58 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] perf/test: fix perf ftrace test on s390
Date: Thu,  7 Nov 2024 13:33:43 +0100
Message-ID: <20241107123343.1580616-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H5GZzuWxWkKvY3NeFndPVtpif9MpOGhU
X-Proofpoint-ORIG-GUID: H5GZzuWxWkKvY3NeFndPVtpif9MpOGhU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 mlxlogscore=636
 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411070098

On s390 the perf test case ftrace sometimes fails as follows:

  # ./perf test ftrace
  79: perf ftrace tests    : FAILED!
  #

The failure depends on the kernel .config file. Some configurarions
always work fine, some do not.
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


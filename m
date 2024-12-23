Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259315C14B;
	Mon, 23 Dec 2024 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734962241; cv=none; b=ZjDEm8QUH53Cd0wk0QEdjbC6EeU2bxiyoOjKEW3IzLdVA2nvxDsZagrrVx0I1qSCVqAVe0AfXLHz8/fqkG34w2UaTuxN/s7d6+LDSL4zgtz7NqtelAbid9aqtDwqaWWSvp3QD1fkhqJRV1f7KxYpFxb7y7++6edC1wSkpRau9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734962241; c=relaxed/simple;
	bh=gpVrOlzyTNPSw/0l23/VjkqC9gZ64wxlwFMI8zMErqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H4XfajHjbYZi2s0RP6jmv36IsICQWjlwxMNtR1lY90wGo/rftOKhIUAdq4VFvs1fzRRHQoHPynlE+jROwdXIAlkyK/yvOR370X60TsTEZGD8qzwYprAM8dbiZg9qprhqGNr55qqTlPu6AGHT97lNNdEZEiP85yyNwhaGKm8+nFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G+MKa3zM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G+MKa3zM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BMNbEbI016911;
	Mon, 23 Dec 2024 13:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=giDiY/GsV//L0FnDp4rsjQSuGg9HbaPr/camPdZu0
	eA=; b=G+MKa3zMUwBozCu0eU0QBkuRaBoOnxftfI8F/uw2AVOJuugAWit78evPs
	auHP0Ov5K63qW/uqMVHMPgRR+B8oSaB93bq2K6UL8ekOGUP/Ab94cv92QAVo9HhY
	zWQbHW6n1tHQ0c60VqMGgyFooPugFrSQulRq0nPzeIr+yMCjqQxzu6D2f+3qpekY
	3oD/CfLh3sa/1hXvdXrfPkRyHU3j0+VqsfGpkril+OIUeX+WClVRIkCzCC6JINai
	cF+FgtewDIo/5URkXdO0za03yfeJ0DbjsQbmzrwKaw7LTuZHhSHNJBhXif0bzJYH
	AlC1NXnFhfzNRys/0NYej64Lj+Dmw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43pvkaavrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 13:57:09 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BNDujbm005588;
	Mon, 23 Dec 2024 13:57:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43pvkaavrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 13:57:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNDomj7002278;
	Mon, 23 Dec 2024 13:57:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43p80se27m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 13:57:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BNDv5E564160236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 13:57:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F21DD20043;
	Mon, 23 Dec 2024 13:57:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B77720040;
	Mon, 23 Dec 2024 13:56:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.252.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Dec 2024 13:56:59 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH] tools/perf: Fix return code for lock_contention_prepare
Date: Mon, 23 Dec 2024 19:26:55 +0530
Message-Id: <20241223135655.8042-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H-8EwP8btbxQchzd_Jr8iecCoHyJp1tK
X-Proofpoint-ORIG-GUID: 1GsLyJGRKp9dnG_FarTL6Rl2FFt5Ee3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230121

perf lock contention returns zero exit value even if the lock contention
BPF setup failed.

   # ./perf lock con -b true
   libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
   libbpf: failed to find '.BTF' ELF section in /lib/modules/6.13.0-rc3+/build/vmlinux
   libbpf: failed to find valid kernel BTF
   libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
   libbpf: failed to find '.BTF' ELF section in /lib/modules/6.13.0-rc3+/build/vmlinux
   libbpf: failed to find valid kernel BTF
   libbpf: Error loading vmlinux BTF: -ESRCH
   libbpf: failed to load object 'lock_contention_bpf'
   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -ESRCH
   Failed to load lock-contention BPF skeleton
   lock contention BPF setup failed
   # echo $?
    0

Fix this by saving the return code for lock_contention_prepare
so that command exits with proper return code

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/builtin-lock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 208c482daa56..2226c7dd4ae6 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2049,7 +2049,8 @@ static int __cmd_contention(int argc, const char **argv)
 				goto out_delete;
 		}
 
-		if (lock_contention_prepare(&con) < 0) {
+		err = lock_contention_prepare(&con);
+		if (err < 0) {
 			pr_err("lock contention BPF setup failed\n");
 			goto out_delete;
 		}
-- 
2.43.5


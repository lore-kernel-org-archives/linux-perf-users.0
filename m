Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3917A319
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Apr 2025 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743957291; cv=none; b=ciXom6ead2vKV7S7X57Nfk9pbg6hTNrKOWr5nzapngKTkge4tM1nGg/SHCe49Ip1DUusS1XDZ8uFbzyHGXoYag6vLTHfNeTu6X8gwRzVLjWvshNnPKyQHg5GQnTno1Em1xGLKsDnCJ0+z3A5F9NrKovO0c1xa7nqn4RM0Zc+oyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743957291; c=relaxed/simple;
	bh=KnJyQbNCxq/UoYGSavUVvW4uvInWodUDBzBXu/dOk9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sm75OLclaO6NGfRkJ5HCSzNowrzLDDGikGI1rmM5yEVIvC2amtjcfl37Uk61hdCPda1IycAm5PgSrFI+ylKRhdtcRkjObegXtqbKk/vILze8RW/oPRwc4RO6v1TYY0CVwcDZgSqLk9ICKEhgr4TLhL+Ga6hUjwp6WYIWyx7dcrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gwBcdXWL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gwBcdXWL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5368uvXt027152;
	Sun, 6 Apr 2025 16:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qLFtcIKkBCr2UmXnu02eczKZYSvK24BFD+5YU178H
	rk=; b=gwBcdXWLwn/JtW4F8d0o2pAbG/ulnOIXYRU9vHxMsSvx6b/Qz7JnEDfA0
	JB10XQKFqYQy+sTE9SPoF/I3xxqkUXb5NxmOLkvMFOgAGro1p0F2dk7tWbafgr7Q
	Rj9vSngerUtzbh+KDb3tIudv74LMKHG5mz/NNzN2KhV5hvW+RH+tOdgsYSh0I2ce
	7LMYIjaYpymjDLoAZGYShMVQFfdOoEMMPmBDt7Msl+lxPbjGds2eWnkkMgruyiyl
	8RRb1hAGF2KnGUGRHrWJRk2uZOlqI5FH8m5fO52UJXbIFy3eI5U8neqsD7Y485QU
	YmZzRx784aBufN86QjYorNPN/GjTg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ubr0jrsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Apr 2025 16:34:30 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 536GYUfN006530;
	Sun, 6 Apr 2025 16:34:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ubr0jrsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Apr 2025 16:34:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 536DEq7h014473;
	Sun, 6 Apr 2025 16:34:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufuna99p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Apr 2025 16:34:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 536GYPx626870332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 6 Apr 2025 16:34:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9949020049;
	Sun,  6 Apr 2025 16:34:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 848D620040;
	Sun,  6 Apr 2025 16:34:21 +0000 (GMT)
Received: from li-e616facc-2daa-11b2-a85c-9c7f23c3cd5e.ibm.com.com (unknown [9.39.20.57])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  6 Apr 2025 16:34:21 +0000 (GMT)
From: Likhitha Korrapati <likhitha@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.ibm.com,
        Likhitha Korrapati <likhitha@linux.ibm.com>
Subject: [PATCH] tools/lib/perf: Fix -Werror=alloc-size-larger-than in cpumap.c
Date: Sun,  6 Apr 2025 22:04:12 +0530
Message-ID: <20250406163412.897313-1-likhitha@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uXAkx6ONmm2gNLmbAIULtmQvm6muFQqQ
X-Proofpoint-GUID: 7lxIQj-qXevGsWmFquYBXpGJi-Qsw3li
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-06_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504060119

perf build break observed when using gcc 13-3 (FC39 ppc64le)
with the following error.

cpumap.c: In function 'perf_cpu_map__merge':
cpumap.c:414:20: error: argument 1 range [18446744069414584320, 18446744073709551614] exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
  414 |         tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from cpumap.c:4:
/usr/include/stdlib.h:672:14: note: in a call to allocation function 'malloc' declared here
  672 | extern void *malloc (size_t __size) __THROW __attribute_malloc__
      |              ^~~~~~
cc1: all warnings being treated as errors

Error happens to be only in gcc13-3 and not in latest gcc 14.
Even though git-bisect pointed bad commit as:
'commit f5b07010c13c ("libperf: Don't remove -g when EXTRA_CFLAGS are used")',
issue is with tmp_len being "int". It holds number of cpus and making
it "unsigned int" fixes the issues.

After the fix:

  CC      util/pmu-flex.o
  CC      util/expr-flex.o
  LD      util/perf-util-in.o
  LD      perf-util-in.o
  AR      libperf-util.a
  LINK    perf
  GEN     python/perf.cpython-312-powerpc64le-linux-gnu.so

Signed-off-by: Likhitha Korrapati <likhitha@linux.ibm.com>
---
 tools/lib/perf/cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 4454a5987570..c7c784e18225 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -398,7 +398,7 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu
 int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
 {
 	struct perf_cpu *tmp_cpus;
-	int tmp_len;
+	unsigned int tmp_len;
 	int i, j, k;
 	struct perf_cpu_map *merged;
 
-- 
2.43.5


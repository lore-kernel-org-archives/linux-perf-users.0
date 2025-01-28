Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4018D626;
	Tue, 28 Jan 2025 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738069648; cv=none; b=pZ3m08/cVjdz9mcimWgsvNOcoTsrJ68SxmUR5WIAQ8rwpszRxTRJe5yAIt33lhhlod4Bl9A/8F18mrcddgGFzCbj88dd4mnLoR6GL53/qIPfZNKUcA6mN504++bBpz6WA896ClzBZWNvFJEjysP8vOGzb+/yriD6NpJbuGCHU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738069648; c=relaxed/simple;
	bh=M0GgkAi7diRrkvFbqQ0w4+ZLr6adyDXcvpODyta1Nso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5zsivuyDFlzpD0pxuifSMRnTEN7InVqYIVghWYkgnp4zWBdcWlk0hWDnXvlAppV7g78R8GeWA3lycuMS7RrLkB2xvdoDc2yYk3TZgiFKarsD5SeNLMldMPClNB3UeM3lUEHbS/Ok/1UIL+i+5phyhedRJDiMDE9z8DcGk8xIqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ef56V112; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ef56V112"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S7X2N0023118;
	Tue, 28 Jan 2025 13:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NVXo+P83o+CUvyDCJcPnMUvFwORPOkhRrQXMZqZvW
	4Q=; b=Ef56V1122c5khKR0NgetnEB5eHR3peCgsEkiCa+joMnfnfRODgb1fYcG8
	/R+lY/2KcPzAd7njFp1KJIqgk2c1iaBPIL+/xCmmai9qWomE73cS2mhI+hdELeWn
	Q1zEy2ASxvOauTbQx7EUF+jU2ZfVLshLKa4yuoPf8qgfcaovQAsHWMZglgWYlpwI
	Cbdx9Bm4t01J3CwxVo0oaeJmEWegMR12WDIpHyklxuFtobg7bTaVMBu2CaujlHfK
	twuYk3yfQ14epjzPzXUp2VxDxdficvJPGpx3fWNF+TnX52DF9k0pm6Q8X7IfEgpy
	TWzlZgnU60I2nG83Y0iTGPJ1TyfnA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44etxrsbeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 13:07:22 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50SCnJcj005318;
	Tue, 28 Jan 2025 13:07:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44etxrsbeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 13:07:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50SArMCE022538;
	Tue, 28 Jan 2025 13:07:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgjk209-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 13:07:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SD7IlT46268680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 13:07:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 194C420185;
	Tue, 28 Jan 2025 13:07:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6AAD20184;
	Tue, 28 Jan 2025 13:07:17 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 13:07:17 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Fix failing test case Session Topology
Date: Tue, 28 Jan 2025 14:06:47 +0100
Message-ID: <20250128130647.4029185-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9ngXmcVbzqwpYUQIG_v5-KLEhethhQI0
X-Proofpoint-GUID: DPNhh39z_Vr3CoqiaeqHPYGVbQvh_Ryn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501280099

Test case 37 Session topology fails on s390. I bisected this to

commit 05be17eed774 ("tool api fs: Correctly encode errno for read/write open failures")

When perf tool is invoked, it builds the perf.data file using the
following function sequence:

  #0  has_die_topology () at util/cputopo.c:223
  #1  cpu_topology__new () at util/cputopo.c:302
  ....
  #9  0x00000000012a5c7a in perf_session__write_header (...)
  	at util/header.c:3774
  #10 0x00000000011ccd64 in session_write_header (...)
	at tests/topology.c:53
  #11 0x00000000011cde9c in test__session_topology (...)
	at tests/topology.c:215
  #12 0x0000000001190276 in start_test (...)

The function has_die_topology() checks for existence of sys file
/sys/devices/system/cpu/cpu0/topology/die_cpus_list
which does not exist on s390. This function returns false and
information for all CPU dies is omitted in the
perf data file section HEADER_CPU_TOPOLOGY.

Later on the test case reads the perf.data file back using
functions.

  check_cpu_topology()
  +--> perf_session__new()

the missing CPU die information in the HEADER_CPU_TOPOLOGY section
causes the id_die field set to 0 in the session->header.env.cpu[0].

Later on when the test case result is verified, the functions

  test__session_topology()
  +--> check_cpu_topology()
       +--> aggr_cpu_id__cpu()
	    +--> aggr_cpu_id__core()
	         +--> aggr_cpu_id__cluster()
	              +--> aggr_cpu_id__die()
	                   +--> cpu__get_topology_int()
	                        +--> sysfs__read_int()

Function aggr_cpu_id__die() reads the die_id from the CPU's
/sys/devices/system/cpu/cpu0/topology/die_id file entry.
This file does not exist and function
sysfs__read_int() now returns error number -2 (ENOENT).
Structure member id.die has value of -2.

This new return value of -2 bypasses this check in function
aggr_cpu_id__die():

	/* There is no die_id on legacy system. */
        if (die == -1)
                die = 0;
and the test verification fails in:

  TEST_ASSERT_VAL("Cpu map - Die ID doesn't match",
	session->header.env.cpu[cpu.cpu].die_id == id.die)

Output before:
 # ./perf test -F 37
 37: Session topology               : FAILED!
 #

Output after:
 # ./perf test -F 37
 37: Session topology               : Ok
 #

Fixes: 05be17eed774 ("tool api fs: Correctly encode errno for read/write open failures")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 27094211edd8..05ced29385f7 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -293,7 +293,7 @@ struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
 
 	die = cpu__get_die_id(cpu);
 	/* There is no die_id on legacy system. */
-	if (die == -1)
+	if (die <= -1)
 		die = 0;
 
 	/*
-- 
2.48.1


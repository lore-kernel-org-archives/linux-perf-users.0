Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259B154429;
	Fri,  7 Jun 2024 04:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717735460; cv=none; b=QRHCS+EzJ2JdWAOdHxCGXxkIcRT31QnVBSJlMFsTrX+1g4yScSPMlsb5nqI2h/gSS7UduxqHi5SNtz+JawR85G314i5vAZur5BwJW5rXeNuqYwyKluIiQjA1oTvzAvVm9nSHeCK6l8J/zGfb4sWeQSTax+Uft98ELr82bBZxxH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717735460; c=relaxed/simple;
	bh=hRucXZWqk7DSeAInu1qmotAqAwaPW9qwK1JmNh1WSck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ev1gJnns+0lbbRdKAXu2QyZOGV/+Py5jygEvmeTaRziyfGjC8YJgJaa+I4rxdepYE4HM8wiXQjCH+/am7RAA5CuKe23fK4SUO3fNTd4dGxoyMAjUK9dqe91aiB78eHW8HP3A/ahvAs0EtNwJpSn1DYsGVRNtH/vDBTDoM6Nhr6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tu4qdWoV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tu4qdWoV"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4573quVY013539;
	Fri, 7 Jun 2024 04:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=pp1;
 bh=G+QQJDYeHEx4C6ppUgzSueeu7Er0q1bXtMD8X42znYI=;
 b=Tu4qdWoVojE21v3ibwpAKd0x6k8O5A2mYrI4wPJUQti+zNMkugQYicmYB70nR2+m6jFD
 nW5hUVh5bQDjLcVnsSynlyg33POyKMo5CDpTtWXn7CBndwODluqBES0szrCZDUN2kOI8
 83A9AyANByYnvPJyJT2z70hQEZZeQFAlqXKRo1LghfpgaqnF2g1SpzF/RnPDpX/jUOTc
 h6GvXzb1QjCkdXEleFM5qTMj8d06/Qr5XcVyD4WQYPKNuXvS1Rlf4P1kB3fBiiBM1X7e
 1hoZ9F+UQi1oOg/FgpPLG9zy6vYBkgl5Qka/oliMXH0J/4FXvzrt0o1g3HycCUUjQFPr gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yktpe8488-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 04:44:11 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4574dt5e019967;
	Fri, 7 Jun 2024 04:44:10 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yktpe8487-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 04:44:10 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4571gxgr000781;
	Fri, 7 Jun 2024 04:44:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygdyuevtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 04:44:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4574i4hj12910874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jun 2024 04:44:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 493D620040;
	Fri,  7 Jun 2024 04:44:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8931B2004B;
	Fri,  7 Jun 2024 04:44:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.45.47])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jun 2024 04:44:01 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH 2/3] tools/perf: Fix the nrcpus in perf bench futex to enable  the run when all CPU's are not online
Date: Fri,  7 Jun 2024 10:13:53 +0530
Message-Id: <20240607044354.82225-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240607044354.82225-1-atrajeev@linux.vnet.ibm.com>
References: <20240607044354.82225-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cJkhylPnuYTH2ybGdJaAGSjRhxVSC2Qz
X-Proofpoint-GUID: IhGF6qDB75rPGIJ45iERlKMb0bCXr3Lf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070032

Perf bench epoll fails as below when attempted to run on
on a powerpc system:

   ./perf bench epoll wait
   Running 'epoll/wait' benchmark:
   Run summary [PID 627653]: 79 threads monitoring on 64 file-descriptors for 8 secs.

   perf: pthread_create: No such file or directory

In the setup where this perf bench was ran, difference was that
partition had 640 CPU's, but not all CPUs were online. 80 CPUs
were online. While creating threads and using epoll_wait , code
sets the affinity using cpumask. The cpumask size used is 80
which is picked from "nrcpus = perf_cpu_map__nr(cpu)". Here the
benchmark reports fail while setting affinity for cpu number which
is greater than 80 or higher, because it attempts to set a bit
position which is not allocated on the cpumask. Fix this by changing
the size of cpumask to number of possible cpus and not the number
of online cpus.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/bench/epoll-ctl.c  | 2 +-
 tools/perf/bench/epoll-wait.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index d3db73dac66a..d66d852b90e4 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -232,7 +232,7 @@ static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
 	if (!noaffinity)
 		pthread_attr_init(&thread_attr);
 
-	nrcpus = perf_cpu_map__nr(cpu);
+	nrcpus = cpu__max_cpu().cpu;
 	cpuset = CPU_ALLOC(nrcpus);
 	BUG_ON(!cpuset);
 	size = CPU_ALLOC_SIZE(nrcpus);
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 06bb3187660a..ef5c4257844d 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -309,7 +309,7 @@ static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
 	if (!noaffinity)
 		pthread_attr_init(&thread_attr);
 
-	nrcpus = perf_cpu_map__nr(cpu);
+	nrcpus = cpu__max_cpu().cpu;
 	cpuset = CPU_ALLOC(nrcpus);
 	BUG_ON(!cpuset);
 	size = CPU_ALLOC_SIZE(nrcpus);
-- 
2.43.0


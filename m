Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F92154BEA;
	Fri,  7 Jun 2024 04:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717735463; cv=none; b=ec2RvemURnwZ7EkbRR8aJQbqXKdb02cwtT/sWLR1WxpXEInXNXZ4/JWBF8Bu0iJpotCsbSmEV1OS/fwlYWuFg3hg1+Nb+HSJXL9SOJfHKdRdRtLrJ5ZaIqRXhV25VxLtTxLVj1aCCZq2MZ7kQIkm+dG0kY0wfGunH24yMsRJsfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717735463; c=relaxed/simple;
	bh=PzXG7q6XspU4iE3vQLPGSyaufawCpYAhp3mC53xdlR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=roJWwUEBTLFoaC2DvMkJMnytlm5HF2emMzyAJir2O0+kWGOQg1j3EaIfYsFmXwpnPkongMREjxwy04/vjF4jP1h2gxnFb7z7nnVp68qd4CBgUuimTl/1o1sqvK15hK7FV24Xrq5tIaFh56Kz2KQXotXToiwH5y+NHY8xd7Da0wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iqSR7bGo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iqSR7bGo"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4574drmu006984;
	Fri, 7 Jun 2024 04:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=pp1;
 bh=MSmCYy3kCzkBPfKtM+PF9IwgOk+xiL8uw0fLUEGgDRk=;
 b=iqSR7bGoDQ+RQQ9bFsWj176vcHXhNHRMfDKk6EWsBnbwMoZnxgTaXpyQm7RYJEd8dltc
 ZkkPD+bN0PBeYhYF+pH2mmmx0g9J2vZde7XBgzsHNiCXhuFKzNQQ4fJSN5nCVHGWMwPK
 hFQFxJGKr8ThlVTa+/dUcFldatUw+K4xspbqKUOvtYeKX/gmqe/GxfZdGYu1dltDiaKP
 QYVC4mh3ig83E5/Nn//TfVmPWN2s4XdDzJchwyq1x6h9eMdChSGgwZ93jN1jJWhOOT/a
 1GPDiCn7A7YrFQ/M0wi4mYXD5ZEDSLlghk/0AmQXM4YDY/heK1MK2FhBb2HEVOBbfOa/ FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yksqq88h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 04:44:15 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4574iEB5015325;
	Fri, 7 Jun 2024 04:44:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yksqq88h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 04:44:14 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4572KB1d031114;
	Fri, 7 Jun 2024 04:44:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygeypxmx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 04:44:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4574i7CO56361218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jun 2024 04:44:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6346E20040;
	Fri,  7 Jun 2024 04:44:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0A2A2004E;
	Fri,  7 Jun 2024 04:44:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.45.47])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jun 2024 04:44:04 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH 3/3] tools/perf: Fix timing issue with parallel threads in perf bench wake-up-parallel
Date: Fri,  7 Jun 2024 10:13:54 +0530
Message-Id: <20240607044354.82225-3-atrajeev@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: iAeWnll8-PPtKbbO39Q6rzWbcDOibb3R
X-Proofpoint-ORIG-GUID: ncNaEBnBfiHX1fOPoGAwbWbQcV8v5g-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070032

perf bench futex fails as below and hangs intermittently when
attempted to run on on a powerpc system:

./perf bench futex wake-parallel
 Running 'futex/wake-parallel' benchmark:
 Run summary [PID 88588]: blocking on 640 threads (at [private] futex 0x10464b8c), 640 threads waking up 1 at a time.

[Run 1]: Avg per-thread latency (waking 1/640 threads) in 0.1309 ms (+-53.27%)
[Run 2]: Avg per-thread latency (waking 1/640 threads) in 0.0120 ms (+-31.16%)
[Run 3]: Avg per-thread latency (waking 1/640 threads) in 0.1474 ms (+-92.47%)
[Run 4]: Avg per-thread latency (waking 1/640 threads) in 0.2883 ms (+-67.75%)
[Run 5]: Avg per-thread latency (waking 1/640 threads) in 0.4108 ms (+-39.60%)
[Run 6]: Avg per-thread latency (waking 1/640 threads) in 0.7843 ms (+-78.98%)
perf: couldn't wakeup all tasks (0/1)
perf: couldn't wakeup all tasks (0/1)
perf: couldn't wakeup all tasks (0/1)
perf: couldn't wakeup all tasks (0/1)
perf: couldn't wakeup all tasks (0/1)
perf: couldn't wakeup all tasks (0/1)

In the system, where perf bench wake-up-parallel is has system
configuration of 640 cpus. After debugging, this turned out to be
a timing issue. The benchmark creates threads equal to number of
cpus and issues a futex_wait. Then it does a usleep for .1 second
before initiating futex_wake. In system configuration with more
threads, the usleep time is not enough. Patch changes the usleep
from 100000 to 200000

With the patch, ran multiple iterations and there were no issues
further seen

Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/bench/futex-wake-parallel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index 90a5b91bf139..4352e318631e 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -318,7 +318,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 		cond_broadcast(&thread_worker);
 		mutex_unlock(&thread_lock);
 
-		usleep(100000);
+		usleep(200000);
 
 		/* Ok, all threads are patiently blocked, start waking folks up */
 		wakeup_threads(waking_worker);
-- 
2.43.0


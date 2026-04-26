Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD502556E
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Apr 2026 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777185814; cv=none; b=mG+p9pLc7GUSUamasiHIcBZPK1lSkIx7eGHS0iiDcFulUGY5Hv9j/i2Zb7m+FP90+mMIUytriCxjx3bnvJz88ZSHisB3EGP8/oi2s2JExRlKWIFtyDSkRynK7bIqXRQT/4jQ28aeXDrMW5QVRKVZswuw8K7lSXDmY2s2FHQn60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777185814; c=relaxed/simple;
	bh=tNHPluP39Y2d0NgVYP5R72pyqvZtVi4B559uvxUyJik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jBuMewwvQV/iB6QoBl9eD2jh3OAb9JH2f6xAwdH+Y+6WAYWd7Gyg12yDtxXjjkJzGm0Br8mtfN8nZyv69FLXsQOlYWCbiD8Fo8hY6dj8I+2cN0/8Qhl4SriuxeHdTK5eXqShx2ySi/J0tM+4lPhYbqL7arA6/zFlo3pFKSueX9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gH9QY3Pj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gH9QY3Pj"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63Q5U6UX759455;
	Sun, 26 Apr 2026 06:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BvtwsbBAQmFfsApxt3IjotvrGVZq0fRyTEkJQ6H4G
	iA=; b=gH9QY3Pj/ypuBGLPX2eiahLyRYZMm8aTQ2N/WfftcQ9RCZWmYbHSh38JW
	1TodbPkKmrUNTUcknwVguvYpJuCtkOF1uF74cP/dftBK1sAF3N6tGjeJvSJYgWK+
	kMGdELbQbG2TYl0xSa6nO19yIDdduwStFO5BZM1BEHa0CRuj41mBXU5DcRYmucJV
	IVx7Wxhhlt2Vc0qRGkQ6FZa4i4NHxvyssN3y25x31qUWg7+VTa13B/y+yzsJbHuz
	uDsr9Ug+YwqsgMOJ8D8aPrVWtQYmtmuZOutBxBhABy4JGeyInbeUM4qF+HX7/jI1
	kT4NQX59DAZLLb2AUyv4vYH8OCCbA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8v3955-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 06:43:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63Q6cx19020166;
	Sun, 26 Apr 2026 06:43:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9eh0jtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 06:43:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63Q6hBfs19858120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Apr 2026 06:43:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A05D20043;
	Sun, 26 Apr 2026 06:43:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5457620040;
	Sun, 26 Apr 2026 06:43:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.109])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 26 Apr 2026 06:43:05 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH] powerpc tools perf: Initialize error code in auxtrace_record_init function
Date: Sun, 26 Apr 2026 12:13:01 +0530
Message-Id: <20260426064301.90614-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69edb404 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ftuLF5Up4WlwXrOVWlAA:9
X-Proofpoint-ORIG-GUID: bYUMPJ6H1heoRJh39AfiN_fYqvVf61Ci
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI2MDA2NCBTYWx0ZWRfXy+Aal/eGWTsM
 uqngYrTbES04FSB8FNE4WSD68/HBXt0Vnkt4Dvl7Ov0KQsKHG/mxWdH2ebypf8/UNNPh79T3Bmw
 02idVCyeZlNJmq8z1l8RenLJSpllNoOrYs2+hTfDftPqBTaQ4AcL3mWrD+dJxtpW9t4r9qaaefJ
 xMxMSiiSj8sgGxtxtzda09QiBhGmb04r+oFdRCAXg4sGYv7mVR3SIUQwZ63xLxywO3MZ8HdO5qB
 B43rgCSCwJ2IP0CWqGTHZam863m1ZnQa0mBM/KugpvCG7TpKDwLUJHeR6cEOA9NbCOUhp0w2th5
 K/ebcjxpC0qjxs0Ifozh9XZ5SaQ5MaKNHQUFQSwnY4E2yAcgt4mCwmNdrMNTBMXRrvV7Oteh07U
 7ZBh0lojKHSI3WokHyHH5v/hHgBA/OgF0MpEKiw6lhQycjcOo2Lw1Ir/Jah/CXytrl8Z9wOu+ub
 hYliZIycl1C1OdSxjbg==
X-Proofpoint-GUID: bWpierwrhwraEXgfOg4amxVOG0XjDD88
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604260064

perf trace record fails some cases in powerpc

 # ./perf test "perf trace record and replay"
 128: perf trace record and replay                                    : FAILED!

 # ./perf trace record sleep 1
 # echo $?
   32

This is happening because of non-zero err value from
auxtrace_record__init() function.

 static int record__auxtrace_init(struct record *rec)
 {
        int err;

        if ((rec->opts.auxtrace_snapshot_opts || rec->opts.auxtrace_sample_opts)
            && record__threads_enabled(rec)) {
                pr_err("AUX area tracing options are not available in parallel streaming mode.\n");
                return -EINVAL;
        }

        if (!rec->itr) {
                rec->itr = auxtrace_record__init(rec->evlist, &err);
                if (err)
                        return err;
        }

Here "int err" is not initialised. The code expects "err" to be set
from auxtrace_record__init() function.

Update auxtrace_record__init() in arch/powerpc/util/auxtrace.c to clear
err value in the beginning.

- Clear err value in beginning of function. Any fail later will
set appropriate return code to err.
- Even if we haven't found any event for auxtrace, perf record
should continue for other events. NULL return
will indicate that there is no auxtrace record initialized.
- Not having "err" set here will affect monitoring of other events
also because perf record will fail seeing random value in err.

With the fix,

 # ./perf trace record sleep 1
 [ perf record: Woken up 2 times to write data ]
 [ perf record: Captured and wrote 0.033 MB perf.data (228 samples) ]

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/arch/powerpc/util/auxtrace.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
index e39deff6c857..fe1ea4e222f3 100644
--- a/tools/perf/arch/powerpc/util/auxtrace.c
+++ b/tools/perf/arch/powerpc/util/auxtrace.c
@@ -71,6 +71,19 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 	struct evsel *pos;
 	int found = 0;
 
+	/*
+	 * Assign err value to zero here. Any fail later
+	 * will set appropriate return code to err.
+	 * Even if we haven't found any event for auxtrace, perf
+	 * record should continue for other events. NULL return
+	 * will indicate that there is no auxtrace record initialized.
+	 *
+	 * Not having "err" set here will affect monitoring
+	 * of other events also because perf record will fail seeing
+	 * random value in err.
+	 */
+	*err = 0;
+
 	evlist__for_each_entry(evlist, pos) {
 		if (strstarts(pos->name, "vpa_dtl")) {
 			found = 1;
-- 
2.47.3


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A43E3145
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651429; cv=none; b=HBu5RVw9Hyb3x98svJ2G8g1Fn0ywhmAuXnHvEl8P5p1azb08HvcUW7hdM03rfJ4Ploz9ncI/Bf0wIQH41Kk1Q+0LUtG8734r7eYeYYoYZ0dVLIybeS8v0/lrttq1prwJtIRMsvP0Ru52iukQ+f7Trdi0Z+UcX5MHILEEPW55Ofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651429; c=relaxed/simple;
	bh=9SwrgzkR25O3wa63KgvbU8K+vEGk3UeAZItMHnD4B/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pOaGoCnzigTnQSMEnvN8I6zD8xLyop0IfOgLygKwLRzZvpct5g/DS7ned5Bec6S11z0WwYCCvfVvrJ8EqAFguREnpGvlI1lUz8bCD/bQWOX/QhRl03M7Km6LhW+SigO6C5FLk9wMvY5avpgB0Ig/dDpMptngZAT7GT7MbbiPvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SBYRZ9S3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SBYRZ9S3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6415ZO4o3232750;
	Fri, 1 May 2026 14:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kuHqVdlej+Yn0HOXIpjPZZdn1xMOEqKbsgmm1UXRw
	MU=; b=SBYRZ9S3cwCc+ijcXzzUkgUoDzR4d3nHzz9VHawxk6E8hBaY32/8yUWZJ
	icIR5Zizr8QMY7U8XHw7rScLDVD2zYaXmQXTZ7wAfJlO9Ml+iF07wtoP7Z3Lqas1
	1Rf/2LyZQq1wce+bM6YvLmRpU/KmAVDQKxVUxiz4Kc18D8VOy2IRW3MlSJjFBhoo
	CFG0GgUuqOwlNCMl+fB/uKjXz7LLsd0ZjXdWkdGWguQo5vMH7DhOFssVaSefeP6Z
	8ypDi1agFNiHBaZOODfhGWmr02OLsf0secMtfju1xAGFOipEVMBbUim1dsBsN8U0
	BnU4Ix9vl3o0sni/Y6HgHSOQQVISQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1k39ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 14:54:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641ErnDj015289;
	Fri, 1 May 2026 14:54:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqr056-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 14:54:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 641EskPw27918840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 14:54:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1B0420043;
	Fri,  1 May 2026 14:54:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8013520040;
	Fri,  1 May 2026 14:54:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.19.167])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 May 2026 14:54:39 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH V2 1/2] powerpc tools perf: Initialize error code in auxtrace_record_init function
Date: Fri,  1 May 2026 20:24:35 +0530
Message-Id: <20260501145436.1327-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE0NCBTYWx0ZWRfXzw7Kyx3OOjLu
 GQeUXRnJ6nu6bW0s/Mykpu0fhIqoAC36qPa9GpWQ4ADRf/QJ5KcRCMiWlAEVOk+7fMVFHq55w05
 2Kb660OGsup3VT00U7tkqsYtDD1hrCgEG6VE931M3C5zWWQshV6ux4mkHeLTpJjoztrBwh+1Z+w
 5v4d9lNJYq7fhZn6GdWYZqotcaMDMSiIpaceepzdsFkzGabaZ+7ZTtmnXeMRny+16G77l45LZ+A
 UFlC8wZgy8tL4YppsA2mqFWyNWF1VQbzGDMV0qO6CSHbxfQqmI5It3+X20ZBImXrcv+4xyXgwz4
 P6sh9pyrBZo7jtj39V6QlI6rH1mFTJn+LNh+F3sD8JPQP48T1rW/IxNe47Gojc+QCBomStMPKaL
 xl23mu6GVCMEmX6cHgT7OlMIlVur1KQmU4T2U/8IrMJMZY5T5BFlrtsqQto2CbzhR8A54J7AP1M
 H/Gw2KqoxFv3vKUNJUw==
X-Proofpoint-GUID: HIVe6_rP_G6RzeSe3zHGvRG6kq2VIf2S
X-Proofpoint-ORIG-GUID: wYbumdJK_kxEKnTysEdaOU5mWy_afGsX
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f4beba cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=UYfmDeaf6v5XVjAx5qsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010144

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

Set err to -EINVAL before invoking auxtrace_record__init() in
builtin-record.c

With the fix,

 # ./perf trace record sleep 1
 [ perf record: Woken up 2 times to write data ]
 [ perf record: Captured and wrote 0.033 MB perf.data (228 samples) ]

Fixes: 1dbfaf94cf66 ("perf powerpc: Add basic CONFIG_AUXTRACE support for VPA pmu on powerpc")
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
v1 -> v2
Addressed review comment from Adrian:
- Set err to -EINVAL before invoking auxtrace_record__init() in
  builtin-record.c
- Added kernel-doc to auxtrace_record__init() in tools/perf/util/auxtrace.c
Addressed review comment from Namhyung:
- Added fixes tag

 tools/perf/arch/powerpc/util/auxtrace.c | 6 ++++++
 tools/perf/builtin-record.c             | 1 +
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
index e39deff6c857..4600a1661b4f 100644
--- a/tools/perf/arch/powerpc/util/auxtrace.c
+++ b/tools/perf/arch/powerpc/util/auxtrace.c
@@ -71,6 +71,12 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 	struct evsel *pos;
 	int found = 0;
 
+	/*
+	 * Set err value to zero here. Any fail later
+	 * will set appropriate return code to err.
+	 */
+	*err = 0;
+
 	evlist__for_each_entry(evlist, pos) {
 		if (strstarts(pos->name, "vpa_dtl")) {
 			found = 1;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4a5eba498c02..708825747af5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -865,6 +865,7 @@ static int record__auxtrace_init(struct record *rec)
 	}
 
 	if (!rec->itr) {
+		err = -EINVAL;
 		rec->itr = auxtrace_record__init(rec->evlist, &err);
 		if (err)
 			return err;
-- 
2.47.3


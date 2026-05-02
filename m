Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B8299927
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777707592; cv=none; b=S3hK/1TTFiShLy3NaVx37UTWllqKgNfxf4WIbr3/6V+nU7o7wAtMMfK6YKkpX5vuejm50yRLFZyQDaGNxeS0EGRT8mQ/JlU42OKxDH6BDeB5l9WdK0gGlTX9+X6oYr90o9YMkJuDtje8Qk4b+1wCuPXvI3uG3LjUrWNUf6I3TbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777707592; c=relaxed/simple;
	bh=9SwrgzkR25O3wa63KgvbU8K+vEGk3UeAZItMHnD4B/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JyurIu/51XIYcYiVHxTnxuFp7SvSGwvofQXWhm9b3VihBBiLAb2DMmvdo7kZ8S2olw2CV5I6HOqi2Uvw5u9S5k7KVnz/0Qn49d7iOrY9sDZDM93qW9qFljWR1nmmZFIwcTjg1ZzLp9Z+xm9LvCgrNRphdJQYu0EMQZlZ6NGBzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IHeGCvdB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IHeGCvdB"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64247LEv1938915;
	Sat, 2 May 2026 07:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kuHqVdlej+Yn0HOXIpjPZZdn1xMOEqKbsgmm1UXRw
	MU=; b=IHeGCvdBRPF5yNTkkXD+5XUV61qAA08Q5YVwGz93HJgAQ9OwuAYn6Hw5n
	p2EOataiNFdzgEzuzE8v7556q+nNLlpmoq1Hyy0Atf5baxwZCFhH+4eXIiXL4rT4
	N8aX8lS4Yy/sa77aSAZVR2ZC+LA2T6RJT2Trr6vcRpAtgituP1Ees3aCLHZ5vJ7q
	FH0x98lCDoyATPWAAs2DLP72y78JEesXJNdjDlP5R4MlX9v2HL06EpITyHDSrIwA
	G2KNaqvGJYHaSak1dl77W6EVAJdG395QlgNZ93K1vovFE6mYAK+alQt4yN+DCO8H
	sgtXGd3MY5hXcspSEh2zWb8+BnROA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y10cud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 07:39:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6427ONLf012196;
	Sat, 2 May 2026 07:39:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dw9jyrh2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 07:39:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6427dZsf46858516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 May 2026 07:39:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 834972004D;
	Sat,  2 May 2026 07:39:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12D072004B;
	Sat,  2 May 2026 07:39:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.223.37])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  2 May 2026 07:39:29 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH V3 1/2] powerpc tools perf: Initialize error code in auxtrace_record_init function
Date: Sat,  2 May 2026 13:09:23 +0530
Message-Id: <20260502073924.99965-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: lw-988zIJr5QU8gl66kiA5tnWNY3MCsF
X-Proofpoint-GUID: xDSIgA-yTN_XAIv3DgRf4hiiHfe4eeVb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDA3MyBTYWx0ZWRfX/AcJJDisEpPs
 NXzKo6qG33ApHSPy4TbfjDCDuZsEoYpPvRkXV2EF0KcLZs/zFKcQSjiU3O1y2mpAMa/QHFnAeSp
 Vskd+vck1L1gj/VdCZcmRxAVbVC6aGD/lRVsZgh9hPDfWvKWxIwNSXNsFRjpIRA5RW99O5B0BDo
 01BoiRVuJVTR0VhaU8tuySeIEjO2l2TAatbirI26Gy+yTNFk0xAgFE+TbpejiW3kCA/nrBn5M3o
 se8wKvwvIwUsp6BPox4lwryhbYxNHMp7QnKnm/ywcskAkn0DoHDlVCsZ6ph+CO9jtadq0DpRUl1
 cD7F/6dn4tR6zfso20dIn8Yuqmbim5W6b4gy/7PQd26EobN7CaDjpmxsR/3ocXoPydCA8koREmu
 yg2RrRZwxr4jOsnZPc5jUSMRmpwnPHrnbIJtbgHzUhFRR/BTDP9IpvL4PRTMcv49Vl49i3A+aRW
 pWwDDGB2Y93DTioJmwQ==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69f5aa3d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=UYfmDeaf6v5XVjAx5qsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-02_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605020073

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


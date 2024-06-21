Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79815D1;
	Fri, 21 Jun 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990391; cv=none; b=D5j/61btjUHea3D45y2AjWcsD/mLnAV+NMIJF2sr5pgvLQ2HgPXRBVM4VmQ8mEvZmu2kQHWTn/3OmY35SYzHV8hJy5CLbrIpQqRkWi/I9LIoePX0iI599Y1bmVgq9H6OK/RsoZ2baPnomJBl+6fnMCc2OK0tBwsoTPuBijx//4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990391; c=relaxed/simple;
	bh=y9kbB7HFUrCLqdBJ41fu7SZ/WYPPcl+gMB2WfRzL49w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIWZqjdcpamds/fxEzAhUnPIgm5kgUV3so8Qm1QgO/hE286NYjM5GLaGTDTMVkfs4LHl8rL2W/eAnxCAVUT41+mg2BYiVRMbetWtk+/1S1HnmChilKlK/peCbpMl6XiiA9EXRSycUpF02MvNBC+p/PWD5vNia6ikPGwE4neZ92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IlMkybCE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IlMkybCE"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LHDQTR005485;
	Fri, 21 Jun 2024 17:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=4xu5lsln1wbQg+E6FFWcUNL78KQ5JaTOAnoVCEW
	nK+A=; b=IlMkybCE3hRqBuYXS4ObLA3y8wzqqXvRPoHratbBdflqikxRTiPilZd
	Ztcutx+VrO5sYpxXBN/PBnFK5elOqV6jbK1a+yfDtFHw7ScWDi1JKWm9kf51pQR2
	Hl394De/NomO10Er+P00eUIpu1X0A1qqpFhYoIv+YIchr3v/z6NYGREBeNXoX0wS
	9BYqLqz7WkXLyRrEFvD826P8HTFDxjCRfbhwmEkfhF4talQgBO8TcprebbyaACdF
	CxFLqipZv9ZaNstFzzTx6AxjbOkKJeEQMwUQhiXDboH2ZbagMrm68tFk9YnaJcOW
	IVoX9M8jO1f3cK/GMuwZ4OvjbWVXGMA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywdqu009g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 17:19:28 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45LHJStu016671;
	Fri, 21 Jun 2024 17:19:28 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywdqu009c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 17:19:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45LFlxR4007675;
	Fri, 21 Jun 2024 17:19:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrspga7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 17:19:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45LHJNCn22151700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 17:19:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C13B2004F;
	Fri, 21 Jun 2024 17:19:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59F102004D;
	Fri, 21 Jun 2024 17:19:17 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.41.60])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 17:19:17 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        Chen Yu <yu.c.chen@intel.com>, Fernand Sieber <sieberf@amazon.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v2] perf sched replay: Fix -r/--repeat command line option for infinity
Date: Fri, 21 Jun 2024 22:49:09 +0530
Message-ID: <20240621171909.24119-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N_lTH6tjQfc1gIIj_6KegK2FRTHQCFLq
X-Proofpoint-GUID: _GzKlr0hmKVkwa0iaYcFrGDjmAkJp2Zb
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210122

Currently, the -r/--repeat option accepts values from 0 and complains
for -1. The help section specifies:
-r, --repeat <n>      repeat the workload replay N times (-1: infinite)

The -r -1 option raises an error because replay_repeat is defined as
an unsigned int.

In the current implementation, the workload is repeated n times when
-r <n> is used, except when n is 0.

When -r is set to 0, the workload is also repeated once. This happens
because when -r=0, the run_one_test function is not called. (Note that
mutex unlocking, which is essential for child threads spawned to emulate
the workload, happens in run_one_test.) However, mutex unlocking is
still performed in the destroy_tasks function. Thus, -r=0 results in the
workload running once coincidentally.

To clarify and maintain the existing logic for -r >= 1 (which runs the
workload the specified number of times) and to fix the issue with infinite
runs, make -r=0 perform an infinite run.

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reviewed-by: James Clark <james.clark@arm.com>

---
Changes in v2:
- Kept the existing 'for' loop and added a condition for infinite
  looping. (James Clark)
- This change also ensures that integer overflow doesn't occur when
  'replay_repeat' is zero.
- Add Reviewed-by tag from James Clark.
- Rebase against perf-tools-next commit 788c5160526a ("perf vendor
  events: Add westmereex counter information")
- Link to v1: https://lore.kernel.org/all/20240618112907.15131-1-vineethr@linux.ibm.com/

 tools/perf/Documentation/perf-sched.txt |  7 +++++++
 tools/perf/builtin-sched.c              | 11 ++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index a216d2991b19..f1be8f0b249e 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -202,6 +202,13 @@ OPTIONS for 'perf sched timehist'
 --state::
 	Show task state when it switched out.
 
+OPTIONS for 'perf sched replay'
+------------------------------
+
+-r::
+--repeat <n>::
+	repeat the workload n times (0: infinite). Default is 10.
+
 SEE ALSO
 --------
 linkperf:perf-record[1]
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8cdf18139a7e..51b3dea404bc 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3383,8 +3383,13 @@ static int perf_sched__replay(struct perf_sched *sched)
 	sched->thread_funcs_exit = false;
 	create_tasks(sched);
 	printf("------------------------------------------------------------\n");
-	for (i = 0; i < sched->replay_repeat; i++)
-		run_one_test(sched);
+	if (sched->replay_repeat == 0) {
+		while (1)
+			run_one_test(sched);
+	} else {
+		for (i = 0; i < sched->replay_repeat; i++)
+			run_one_test(sched);
+	}
 
 	sched->thread_funcs_exit = true;
 	destroy_tasks(sched);
@@ -3548,7 +3553,7 @@ int cmd_sched(int argc, const char **argv)
 	};
 	const struct option replay_options[] = {
 	OPT_UINTEGER('r', "repeat", &sched.replay_repeat,
-		     "repeat the workload replay N times (-1: infinite)"),
+		     "repeat the workload replay N times (0: infinite)"),
 	OPT_PARENT(sched_options)
 	};
 	const struct option map_options[] = {
-- 
2.31.1


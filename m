Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6E6BB4B;
	Sun,  7 Jul 2024 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720376876; cv=none; b=feyvqyTC9ADoShAMhd/ZFU0ShqcGtxlNqRbLFbzF2NWrCv6o5V3QZ2xUwTWnE3nhNtI/B1hNsIVIN/LtltDGig6AL/aXIj7gZod5btCvc7X5b2+G8SjqkJCZmm+ToUxb6zs5/62uTPdkgV/GF8PhzXFelMtD4n0q9KPv3Dya/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720376876; c=relaxed/simple;
	bh=L8bFw41LpywlaulH96WKaKwvZ5S/BthG4xTZM34NyfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EosB7U0F279jR/j5ktDaarS/4MVmCT24a2h0Rjxw7n1wu3JOOaBfqNBcMZZ2wipuAkOWwt7ZwopyGP/pHvLEGfC0vxnQO50ug7idjlO+xuVJfcs+e728pj/+3kQMQ87vqSnyJ/7Xqd7OeQ2gOP2rzEP/talbZ9lpPTIad0Q2DQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SADxOXUR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SADxOXUR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467HxChL027372;
	Sun, 7 Jul 2024 18:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=/lHBQeBbgCwZ3gj/Ek/o4Hwr7KKtFFgx93tBgH0
	nUiI=; b=SADxOXURPr5PvM5HW6ttuK/K3xgSROhpcHf9V4B139TCB3VMzA1Iz4O
	FQnrlOLUlFychrcPpf5p7w4WiPn9IfO+xUJutu3XSnXo8efNo774sfc00OaP+uSe
	BkM56+r34QGQfE8nVrZskpqlebN8II4on3uPceezcs+T0beKJtAor1BwHI7Z6L4Y
	goi5lBOXV02HusfZ7Fr2s5O+iKiX7ysxvR/DS4TmYiQMCFO3IcJTSy++gfLtrKmv
	Ox7Uqzfaj6yCaDv32MfyYIN/P7zPam75ieAoN/VVoSMwY8gVD2x/xfMMgqUwC5FW
	freZKt6lBtzaaX9yNt0poYZwOfB1zdg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ux90dwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 18:27:37 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 467IRagf032004;
	Sun, 7 Jul 2024 18:27:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ux90dw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 18:27:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 467H4Vu0013992;
	Sun, 7 Jul 2024 18:27:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jy2tvrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 18:27:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 467IRWbT57606526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jul 2024 18:27:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 055182004E;
	Sun,  7 Jul 2024 18:27:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C7D320040;
	Sun,  7 Jul 2024 18:27:24 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.85.13])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jul 2024 18:27:24 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v6 0/3] Introduce --task-name and --fuzzy-name options in perf sched map
Date: Sun,  7 Jul 2024 23:57:13 +0530
Message-ID: <20240707182716.22054-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hYrrIQmHR-w-WRvtOAKEa-JTGpKAP1NJ
X-Proofpoint-GUID: nYAzJKeFqFLtOPnTK56Au8Dywklwjye8
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
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407070151

This patch-set aims to reduce the amount of output printed on the terminal
when using perf sched map, allowing users to focus only on the tasks of
interest.

This helps in visualizing how a benchmark or a task is spread over
the available CPUs while also knowing which CPUs are idle(.) and which
are not(-). This will be more useful as number of CPUs increase.

Changelog:
=========
Changes in v6:
- Utilize strlist for simplified task matching. (Namhyung Kim)
- Include relevant symbols while printing row for sched-out. (Namhyung Kim)
- Rebase against perf-tools-next commit 608c3b1e612a ("perf install:
  Don't propagate subdir to Documentation submake")
- Link to v5: https://lore.kernel.org/all/20240626091550.46707-1-vineethr@linux.ibm.com/

Changes in v5:
- Split the changes into different commits. (Namhyung Kim)
- Rebase against perf-tools-next commit c7a5592e8e4d ("perf mem: Fix a
  segfault with NULL event->name")
- Link to v4: https://lore.kernel.org/all/20240618180708.14144-1-vineethr@linux.ibm.com/

Changes in v4:
- Handle possible memory allocation failures. (Chen Yu)
- Link to v3: https://lore.kernel.org/all/20240617125006.31654-1-vineethr@linux.ibm.com/

Changes in v3:
- Print the sched-out timestamp as a row when using the --command-name
  option. (Namhyung Kim)
- Refactor the code.
- Rebase against perf-tools-next commit eae7044b67a6 ("perf hist: Honor
  symbol conf.skip_empty")
- Link to v2: https://lore.kernel.org/all/20240608124915.33860-1-vineethr@linux.ibm.com/

Changes in v2:
- Add support for giving multiple command-names in CSV. (Namhyung Kim)
- Add fuzzy name matching option. (Chen Yu)
- Add Reviewed-and-tested-by tag from Athira Rajeev.
- Rebase against perf-tools-next commit d2307fd4f989 ("perf maps: Add/use
  a sorted insert for fixup overlap and insert")
- Link to v1: https://lore.kernel.org/all/20240417152521.80340-1-vineethr@linux.ibm.com/

Madadi Vineeth Reddy (3):
  perf sched map: Add task-name option to filter the output map
  perf sched map: Add support for multiple task names using CSV
  perf sched map: Add --fuzzy-name option for fuzzy matching in task
    names

 tools/perf/Documentation/perf-sched.txt |  10 ++
 tools/perf/builtin-sched.c              | 175 +++++++++++++++++++-----
 2 files changed, 149 insertions(+), 36 deletions(-)

-- 
2.43.2


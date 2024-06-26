Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADAE16FF5F;
	Wed, 26 Jun 2024 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393383; cv=none; b=hknFPVqqrRBo5IHk8jbxiJkyu6MEIcpit2zPUFcXocBum1WYXe9OoXlfF/r9HaRJbn0E34S7rPV3GAoIzvvn31ZBF8bGfIwUEXEaJvknOEr0WCoYFSTlCRgHmz7/J2wBxZfrM+WWkEyNFIOcfCw5udfcQ5b2XDSKCyLDswzkB2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393383; c=relaxed/simple;
	bh=wwMKvTP5ix+jQqsN6j7YJMV47ttdquG+q3DZ1VedhmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+9k8p7Zsmgc1UECn88Ut+aC4zDLs5ZLquAQatPu16mrS52bUoEMizmw/wbRgzz5+vuprNLxRbg75h3aSQKBnTF76pm0KzyQ7wJqsLIb/iU+1p5gXS2776RgzrlapMwuTVwoLaeoU43oHXtEFEYnPLTv45OEbHyZG9IwhFnyUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UMH8gDM4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UMH8gDM4"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q8QlVs007520;
	Wed, 26 Jun 2024 09:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=CoJm/UwfgFASPfG3yn4p2poc7RwIzICa/4+EoHD
	wo7s=; b=UMH8gDM4QrQUVGjPixdAhTuGFk5UK/H/Nuq6I7B67Nq+8ndoiwPwfZS
	qdri7EpI26N7+zmBdxAVVSDr4/EBF+gm/E3f+MXyvHKLWwghkceyJwEsQm/xO+Ot
	QgFTijHeXTeSf3Kvd5P4cXaHQaTCT9xz80vUUnS1PwPoEDZYY2aLkKBWlLtIxrYO
	3b76I1w5TzQbbOd9tsUBJDUvaQpIr21BlHq2hBApwZccpLh9vcomzm9bETtQaQzN
	47QukyRfPjEBTZaf+RObf+vsekrgMX+YrKM5CQDWhgzrM38aqE2ZiOT9eKLZ9f0A
	hnNPV7NqljOCp3r/YleT9/PlhOQPfBw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400emg897y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 09:16:07 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45Q9G6Ur018726;
	Wed, 26 Jun 2024 09:16:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400emg897v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 09:16:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45Q8MXQB018096;
	Wed, 26 Jun 2024 09:16:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xubkty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 09:16:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45Q9G16I54591858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 09:16:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A451820040;
	Wed, 26 Jun 2024 09:16:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 201D720043;
	Wed, 26 Jun 2024 09:15:55 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.51.102])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Jun 2024 09:15:54 +0000 (GMT)
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
        Fernand Sieber <sieberf@amazon.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v5 0/3] Introduce --task-name and --fuzzy-name options in perf sched map
Date: Wed, 26 Jun 2024 14:45:47 +0530
Message-ID: <20240626091550.46707-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JSUDXZ_NcT2HZeT1nglUdce-ZbOndBRJ
X-Proofpoint-ORIG-GUID: 3EzdLUgJiKzl445pTNncxoAjA6FCWjLa
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
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260067

This patchset aims to reduce the amount of output printed on the terminal
when using perf sched map, allowing users to focus only on the tasks of
interest.

This helps in visualizing how a benchmark or a task is spread over
the available CPUs while also knowing which CPUs are idle(.) and which
are not(-). This will be more useful as number of CPUs increase.

Changelog:
=========
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
 tools/perf/builtin-sched.c              | 224 ++++++++++++++++++++----
 2 files changed, 198 insertions(+), 36 deletions(-)

-- 
2.43.2


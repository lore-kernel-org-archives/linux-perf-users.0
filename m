Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70E3D76;
	Mon, 12 May 2025 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747029497; cv=none; b=PthjqxLW0M/ndeWLahG7QN5ZGgjxaeyKtnR6VSLy2Nx1P0wX0vTh6FQa62/CfB9jtIp+DpoKr6NSDM3vi48USVcUvD33OJ+717OnhJQnNgkyduwO2RZiaUX7qlJOLscs1DyVacEqEyQaZnZZhM1bHnyUcU94tOUovbrA5wmQtQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747029497; c=relaxed/simple;
	bh=/fo4/dqq/k7q5+7//gDNv58aH/NXlGOmM31G2Yo2oFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkjNPxE+aPwZQ7DvS6vcs2yKacw6d6XHkv2niKapDVkb/K/NDRZIFognRZmNTzzeLJMS1hQxrhllKXKdIGVCoiTm7iJ73/PK7gWvtuWuKlr2aE4R7UfPgFCzx9HPysQ6EvOK1PEghDB9KRJ8GxwM1hRHNbVe0qqmmIoobJ21hLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K9b3DKIf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K9b3DKIf"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BKnxXB026314;
	Mon, 12 May 2025 05:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=z/UX0girOYkn/R2O7kvURqXu7DuNBAZfnL80qGVyz
	uo=; b=K9b3DKIf1V0kFNxeWMOsl1yyMsV8AQKGPEiufWnD1Qkl9tA+jok3zc85S
	zahrlW3qk3cRjd8jzJbkWGKIajpJ74qNq/YYeOCr/6OaUf1/h3vEFKUHcvES5oD0
	avNtH0The605Rl7w0dW4pbEP9fZfU+J9Aec8Ho9J9StzGwI3a4jg+D03w+xhSQZJ
	8zi3zJQrKStVlCKHpQXZsVlzmgD833hLVkOtog0cEjxUXrhWv75xK56oycH2dkpF
	sPRJh6BoYeP27dqXDOqMLblgavsMnzan5OpSXAA8gz6QQBrRhZjsNfJE7R8/s9xe
	NRA2UkdUwycGlN102M/LqWdikhxaQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46jue6ae67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 05:58:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54C5qb6s023625;
	Mon, 12 May 2025 05:57:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46jue6ae63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 05:57:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C1UUUF012021;
	Mon, 12 May 2025 05:57:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jku248c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 05:57:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54C5vtZb50856290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 05:57:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 957FA200A5;
	Mon, 12 May 2025 05:57:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B18EE200A4;
	Mon, 12 May 2025 05:57:52 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.39.26.83])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 05:57:52 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com
Subject: [PATCH v2 0/4] perf python: Add missing infra pieces for counting perf events
Date: Mon, 12 May 2025 11:27:41 +0530
Message-ID: <20250512055748.479786-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jxa1AhOCagYGbrbAMICS-gKofuBURjnr
X-Authority-Analysis: v=2.4 cv=TbmWtQQh c=1 sm=1 tr=0 ts=68218de8 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=dt9VzEwgFbYA:10 a=8WUrXVI0zEtRuHCVLLgA:9
X-Proofpoint-GUID: gCg9-ozpaZQw90rDlrmuqWzd46ctKWHy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA1OCBTYWx0ZWRfX+QIkLvgvbgWM 2f2/arBRcEBHyg7d8h5jcKFQnHkWM4UOCgnrTCNInRX1GLZxY7TMu2DDTmW5BNpNPp+mtmzQNPt DT4j727hLunO72WhHlb6mP5VIcmSY5LAswORD/pgu4IwaGkkJTfpxtp3sEZz/RhGEfVfVkAtygp
 C+XszRiCO+KYfv8zUccz7k3Q0KsqfeB9fxIp5v70MiaEOyGQUz0AUNSOiaKDElojclRtFiggIbB qMzi8DszAHUgdo2E774+swF6XyqTPqo/m5zz95WB+QIirw2A2MXxjzCfFM4bdtqBwPrztqpkyo9 4Ps7U/vO8UgJQpHkD6UKoU/S/mtVr7w10Ewt9xSZrPscEA7/9wYaSCI5Gjsx6nGpWGY+cQ9ApdI
 HYOtYo6Ytu7MxkuyXdy7jlKxmT2NCIb91bXA6trvN7ej+knKdr1GMxHqVkI0j38oGZ5TKwpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_02,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120058

Add the missing infra code in the perf python bindings for measuring and
reading the counter values for the given perf event. Demonstrate the
usage of this with counting.py - a python version of counting.c

v1 -> v2:
1. Use the existing iteration support for evlist
2. Drop the use of next method
3. Use existing helper functions for python example

Gautam Menghani (4):
  perf python: Add support for perf_counts_values to return counter data
  perf python: Add evsel read method
  perf python: Add evlist close support
  perf python: Add counting.py as example for counting perf events

 tools/perf/python/counting.py |  33 +++++++++
 tools/perf/util/python.c      | 131 +++++++++++++++++++++++++++++++++-
 2 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/python/counting.py

-- 
2.49.0


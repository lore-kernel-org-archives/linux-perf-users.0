Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7543CE76
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903543; cv=none; b=nrGd6Kb1xBReh1psrpoDAmZSEHlT2fvZtT8r5A1316FXIw2vnbs8a6QMQ8GRpX49Pp6tQY2kvAYRNKGGzZEjQAu5gCZlPFBF3K/3yHWnenMRjEjPkMS5HPpL0SKZaoWUABvUJDgQiIW59CtcqyQe3ttD8FfbvAcax8A5uxf+WaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903543; c=relaxed/simple;
	bh=WlSecn1X8hG1XNq6/CPTgzDfY82p6p/48tiiL6k1OLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NzP7IbaUD/yJ4RSSjwUb7W4dU4OsrfEjIJ0B2w42X0zLpJDj5GFQpkt3JOcdDjdhuZ5SG2AhuCFmV0jZhRZS1cVR7LN43jItL3SZ8qKdVXLRKBZdC9ZvZTJBepTQxF8wZKX3lab7NuVE14XU2yWXGCS8sOjC2/qiT1ILAjdeYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SAtvlz0D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SAtvlz0D"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODg2981994686;
	Fri, 24 Jul 2026 14:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gJDwNNHRg/V9p64WyFdbjNg9L2skeIGL5SnPkd5M4
	5Q=; b=SAtvlz0D2QeQ9U3BuGFbII/BHBDBKawSyyGKDWDwm3EUSySWk/NwTgEjk
	zbDcQlNkbhcuCwrzr/zEPUjwEUlQ3QduxZNnbyBx3gaYgQxL/wcopZzaAMs0UIJ/
	9qpzfGdyD9fdvoCXq2E/GIlQoqSsCT5imrj2MxFqB6P/14DN0jLhQBslgpF3edCB
	GxjRsgZ3uW08hvOjRUOaFlPck+JOdpwsPaCQp6eLKy/uiQ9T0R0XA6INxIuEm7kE
	dy6NeUhm66nYgHziDy+VhMSbhEJxqEEc9emjRRNUsLBv3YSI33uh7BtZbguxKGcS
	Q5YnDGYGiWQE5XewiTDqr2cC92mKg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahmfxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:32:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OEJcxq031263;
	Fri, 24 Jul 2026 14:32:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6whcqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:32:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEW7l134865468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:32:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF6FA20217;
	Fri, 24 Jul 2026 14:13:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 000A62021C;
	Fri, 24 Jul 2026 14:13:18 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.22.34])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:13:18 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v3 0/5] perf trace-event: Fix security bugs in trace-event-read.c and trace-event.c
Date: Fri, 24 Jul 2026 19:43:11 +0530
Message-ID: <20260724141316.99507-1-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: E6hTu7Hy7LaqXJ7txrjdgiNJcsr65_aC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX9/fM4pvbwQNX
 OskAKp03VO9PKwDr8BDIVKl4FlsrbWMBwnJ0sAAuNsbNtTt955yCSYoJbh3uMqLS8kQaKwgPu/e
 SWPSZxAtJRt4JhpdUBZwHJ5Kd4qRmddsi4WOXOmmGMytppMx9DaBxP9LjpQ2rQPmZYfpLjhDpnY
 ZCb2zKL7bK96D/F9c+yhX9jNSIatURX8a4qj8rMUg5OGpNDQ1gXR/7NhDUyWMmJbFg74hNT+NNg
 x/nE/yGFG8OaEOAmKo0bzf+NZzCV1ecUsZ0HYGxb2DUITqiM4mcTnYHtKs1uFtta5w2wEKyJCb2
 bTuQkkm/Zjw8xwyjjb/rnMU855ELv4JM40h5+wkp//D4ChfaHIGrvidaGxg6MwEgvD0JmtaoU2X
 Uz4zKz6l7gmL595jUk7H6YmH3l++xnsiwJaeajjQ6OH5kJ4q/N4ToFOdBdBnQRzbjJEXTvTa1Cs
 8xfX1i5sp/XZ730Y5Nw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfXziqfvyYCPd9b
 1TaDuMEY9rVXKebbZNvJeyHiPmbBG+MvbYZmktwpGvKl7hHiG07ZrcR0sbFJ3Vc+ktArLRlUTC7
 41/TNd1cjVYyHJcP7UBR3wwCl34+Zys=
X-Proofpoint-GUID: mda5cVLL2Vmb8-pOPFlshmjyNNROiJv0
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a63776c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_TZ-ywmwFNITdAXsKjsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240128

This series fixes five security issues in trace-event-read.c and
trace-event.c:
1. Stack buffer overflow in read_string() when a string exceeds
   BUFSIZ, due to a missing bounds check.
2. Integer truncation when passing 64-bit sizes into do_read() and
   skip(), which use 'int' parameters, causing uninitialized memory
   to be dumped and parsers to read out of bounds.
3. Double free / use-after-free in trace_event__cleanup(): it frees
   t->pevent but never clears the pointer, so calling it twice on
   the same trace_event touches already-freed memory.
4. Heap buffer overflow in read_ftrace_printk(): size + 1 can
   overflow to 0 in malloc(), allocating a tiny buffer while a huge
   read is still attempted into it.
5. Infinite loop in skip(): it does not check do_read()'s return
   value, so a crafted size can spin the loop indefinitely.

Patches 4 and 5 are latent bugs that patch 2's type fix exposes by
removing accidental truncation that had been masking them.

Tanushree Shah (5):
  perf trace-event: Fix buffer overflow in read_string()
  perf trace-event: Fix integer truncation in do_read() and skip()
  perf trace-event: Avoid double free in trace_event__cleanup()
  perf trace-event: Fix heap buffer overflow in read_ftrace_printk()
  perf trace-event: Fix infinite loop in skip()

 tools/perf/util/trace-event-read.c | 48 +++++++++++++++++++-----------
 tools/perf/util/trace-event.c      |  4 +++
 2 files changed, 35 insertions(+), 17 deletions(-)

---
Changes in v3:
- Added new patch to fix double free in trace_event__cleanup().
- Added new patch to fix heap buffer overflow in read_ftrace_printk().
- Added new patch to fix infinite loop in skip().

Changes in v2:
- Added new patch to fix integer truncation in do_read() and skip().
- Organized as patch series to separate the two security fixes.

v1: https://lore.kernel.org/linux-perf-users/20260722113552.191143-3-tshah@linux.ibm.com/
--
2.47.3


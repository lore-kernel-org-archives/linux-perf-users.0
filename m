Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B51A0BD1;
	Tue,  3 Sep 2024 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359025; cv=none; b=cNxTw+KhMwkHbO2r+585TcLxZEgDhPRibmXW8Eh1e+E3fBiBvQvr0J1ZoPvLq1QXd0R37Hax0iCgDB8IOie/guThx/fGMTih3t6AKbSblNI3TsTaFm6gaQtrf0v+ISS1p4IhMYTg3uwIuW87XYZNBrRFJ/qKKoR55MK7Bq4C4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359025; c=relaxed/simple;
	bh=HtTXvyXL0t075SkW+2R69WyTTPZ77K7LQtBonB5584Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6lb7MpGQ06v0qvwJXSAvmk4DCsMeiMAROQ37ALopBhCZAHKSdQf8dec6LxSwYzQMaWz9ZIwvcHwoCxtAvLgMednQH4GPqV/nKCpdlEHW/cKepoXCYPa36WN6ILKsTi8xj+WMmLkfgxe6ae6HIEvOZ332g13cAyEvAEZV89dWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OTFPGjoT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OTFPGjoT"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482JqK2x007153;
	Tue, 3 Sep 2024 10:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=n5yPhY3ol5jVsAopBeJrPEohXc
	V0OSCpXG1Ad0tDnko=; b=OTFPGjoTSXx884/a2+cujVCozUVO1E6gyns2/j3FTN
	/GPT6phlg+Y5JGaC4T33+hH+P856zCIe6Cek54i7fJVQFlBvFOCKsX2LTzanfcwH
	6bDjrG9qztaC60vCgch5ZOjbbRIx+LnT+rr15LePU8001qfKWlf7hHquoE1V1kmy
	1TJSwAoDgOWH/RSvtsRO95xhLiK/nmZCwv/492l7D4Hkbo3oVSnLaStuNY1RAhUS
	xRkYcpzX6vJQEGZLKlHr1tluENjifT+2chfeMatMPgQqVA1dtzdOOTTH07Tywglm
	JLDa34ctXcsqzfaSJ4/3VXsHkm8mg8toAQDki2Dz8RLw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btwaw3rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 10:23:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 483ANVtx003338;
	Tue, 3 Sep 2024 10:23:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btwaw3rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 10:23:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4836aJMA018602;
	Tue, 3 Sep 2024 10:23:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw12dcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 10:23:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 483ANRrx22348294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Sep 2024 10:23:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C71DE20043;
	Tue,  3 Sep 2024 10:23:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B277120040;
	Tue,  3 Sep 2024 10:23:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  3 Sep 2024 10:23:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 3CF32E0195; Tue,  3 Sep 2024 12:23:27 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH] uprobes: use kzalloc to allocate xol area
Date: Tue,  3 Sep 2024 12:23:12 +0200
Message-ID: <20240903102313.3402529-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OM5PsIsq-wzPM9q1uSVnhVQbUAtNH0gV
X-Proofpoint-GUID: 5AJS08hp4KWAEXMiJEWqvQ8jAsLqTkfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=805
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030081

To prevent unitialized members, use kzalloc to allocate
the xol area.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/events/uprobes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 73cc47708679..50d7949be2b1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1489,7 +1489,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	struct xol_area *area;
 	void *insns;
 
-	area = kmalloc(sizeof(*area), GFP_KERNEL);
+	area = kzalloc(sizeof(*area), GFP_KERNEL);
 	if (unlikely(!area))
 		goto out;
 
@@ -1499,7 +1499,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 		goto free_area;
 
 	area->xol_mapping.name = "[uprobes]";
-	area->xol_mapping.fault = NULL;
 	area->xol_mapping.pages = area->pages;
 	area->pages[0] = alloc_page(GFP_HIGHUSER);
 	if (!area->pages[0])
-- 
2.43.0


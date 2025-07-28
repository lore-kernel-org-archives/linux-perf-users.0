Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C71D7995;
	Mon, 28 Jul 2025 06:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682410; cv=none; b=cFirODJ7Mfvzj/CgeLBb6VSuZhEbJQp/H2u/gmFCG4x0hnCVo+gY+bBWAw2+eNGaYwyU4jL1GxK6QHzZ7aqXkDhdybBv8+tRnT55rcEWxunLWoBmbNmcspFjP5nGd4Rvb3z9L4qBj1loUo0TffmsTg6cZc9JHxdbZ95rl1W3UtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682410; c=relaxed/simple;
	bh=+SpQp5k+dSm+VowT1vpWGXLhuaNHHNcLJ9PAufaxNwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HgKOEzbBpgivGaMz8vlF5TmhMNrbCilvL43pyhjDjCxyKA3MVIg4pB2m2UnWLeCOenozrtyFMxjO7mM+wIxhz0Bu6LwrDK4k670rWS62z+A9FZOBcLovJoOlQ1AbuV4bXp6R/A8WOYWOuQ9mp1xQbplHBAVS8N3xPCSeBsLe/Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E4LkIScR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E4LkIScR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56REoaYR029728;
	Mon, 28 Jul 2025 05:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ITq+MgH58jemDKsFvf+K5CorgLIfnkTscklFxBT7x
	Cc=; b=E4LkIScR/QJJEYZug4cyBpQFCC+4cGuSj4BaWO5TwTegOHBmC0ay4S3wJ
	twY4vzpFozaLHsVaLbdei0vmjfdCgGi4SZHRU7vGvuDKvPse7WBc6N+aJ5RKz+mt
	UVedphNcV4/Dls3zyu88axSJQmWmALroE+TXBcp5rePD99X5v11y0io6+SOKhK3U
	klJg+1WXHmjShxdVsTKW7JF/fgXK4o+HKy1THC5IkiXbJvPpy4NdGBWjvai94E+k
	LbxGeTPhzhlFp5l6qVXL+s5iGHD2xh++um6E6vWH3arw1QwNl3mf4/bqpYzkNnhs
	pXsAXFeYbAclIbiRECHfdeP6fDtPA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcfq7dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 05:59:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56S5xrkO022419;
	Mon, 28 Jul 2025 05:59:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcfq7dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 05:59:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56S1kSSF006252;
	Mon, 28 Jul 2025 05:59:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjkv84e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 05:59:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56S5xmAM53084622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 05:59:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEBED20043;
	Mon, 28 Jul 2025 05:59:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FA382004B;
	Mon, 28 Jul 2025 05:59:45 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.124.209.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Jul 2025 05:59:45 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf python: Add an example for sampling
Date: Mon, 28 Jul 2025 11:29:26 +0530
Message-ID: <20250728055937.58531-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0MiBTYWx0ZWRfXwbkkgtZD27bE
 H9ICkJHcICcUddi92KfQnVA7sgt8iBo9h0kA++hZIGvPHxoRDygo+ZM6cX1Easy5dWYoChTMkis
 DSMZmTl0jMJ8KkhMc4y1PqRmS6BotEROzBB181dEj1XXGn1ZGdR2lnSowFHoWf/U4vT8LlG0agY
 rtrSOEKYL7kFbR/dJHJreLUX1rV2bVJRAZz/dHiXqGEP0eXUkjGwSSrd+cgYVnGEi699b/AlTiE
 MxoLX6nCIb/v7M8Or9+h3XhHg4x2/732h244+CgPztQoIqOvM73CDjTB4f0H3ws0sbGpWp8Y8ZO
 qbl+gsELpaVuWTXHLeJZuO792dyo26fhXjh78e0a/lV1AN7Z16sFHjogcyC4N6wJbTqdO1FSoIK
 //FTUd1bDjzi5o5FHX5dNTG4QabfH+Zv3KIM7n2QYCQCziY8BKOMvea9kyBRRduqHP4huVsh
X-Proofpoint-ORIG-GUID: 9O8Uv4lXej472yh_Hz6q9RzYi8cytbRR
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=688711da cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Wb1JkmetP80A:10 a=t4_jG_yIud4H_G3xeh4A:9
X-Proofpoint-GUID: 3j_gcEsKLfkUtVBqvC-Isu8WtGfyfOsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=932 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280042

Add an example for sampling events with python. Patch 1 adds support for
record_opts struct and patch 2 adds an example for sampling. The example
also demonstrates usage of the record_opts struct to customize the evsel
initialization from python.

Gautam Menghani (2):
  perf python: Add support for record_opts struct
  perf python: Add sampling.py as example for sampling

 tools/perf/python/sampling.py |  49 +++++++++
 tools/perf/util/python.c      | 186 +++++++++++++++++++++++++++++++++-
 2 files changed, 232 insertions(+), 3 deletions(-)
 create mode 100755 tools/perf/python/sampling.py

-- 
2.49.0


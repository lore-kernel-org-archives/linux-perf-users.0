Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FF136658;
	Thu, 13 Mar 2025 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852317; cv=none; b=dkUVDYdaSQ3KI51f1twFkpwCe6PPMqCFHGfPzCsNmT3ShFt4J0CZQzOydjgh8pAlw08t/usHezEz4I1hYwRneafFsu/aja/1/PqE6a0Bcpt6OOPZBrf8SB06PCW4EntwsE/NWcLIahinwheu0WlUgZGh4Bgup0/kh0VpM+U7u1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852317; c=relaxed/simple;
	bh=tKuCtmvXOdt+AmllmsoMKicAwHKejG4OsQunB/NEQzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzW3Kwck1JGdF/dONfosYgDZbNpgtnQDdnjX7Z87Jr+I9PLZVLuR44JG6VhvLA4v/TpMSfdNjzJAtI6fWfYnqPzorn9C571d6jbmRIW6CEBI5QbmF69FeZJKJyJYRpNhzrSgctR7vL0MM3xdPTe/TnPCkBO6kdK35XG33bHkPlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mlRobX8o; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mlRobX8o"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CKpsiT001694;
	Thu, 13 Mar 2025 07:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cuS3jWuXoeuyqn3bc3ZtJaqyJqW7eyviiq59ToDvh
	4w=; b=mlRobX8oSd4dho5GemY11hLtnfz5vX/aY5CHMbIUYOaZqMi29QW56Y9W0
	LtzVQnPVRZzauSx/RUzRZD4fCDo+YmwJkvS6EOODjt+xM6JQ04pj1vqt/VqPzFdv
	4Rigc7yBZSOjDPFZBTmsv8TVszFFlVAS+4HzFmVvvRuS27oI+4kYzR6Ap6eZD3c9
	2RpapYhUuCVB0UJyf1klPnkH/5ASLZoZDf5ZvrLnmno7/P9J5hWHeNFefIhJ0IgP
	Dm6x1TrdQqKVrtTuybnZULxZWN66BpLrmtWsRjSFZHgYZjeEzS9C2B1S4kh7dt7C
	ZdC9kHuaPmWDMUmfKRpkkdmVn73KA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhp5a9we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 07:51:40 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52D7ceZe006960;
	Thu, 13 Mar 2025 07:51:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhp5a9wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 07:51:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52D57tdG012259;
	Thu, 13 Mar 2025 07:51:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrgjr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 07:51:39 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52D7pbm755116226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 07:51:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7176C2004D;
	Thu, 13 Mar 2025 07:51:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0760E2004B;
	Thu, 13 Mar 2025 07:51:35 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.in.ibm.com (unknown [9.204.206.66])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Mar 2025 07:51:34 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] Introduce a C extension module to allow libperf usage from python
Date: Thu, 13 Mar 2025 13:21:21 +0530
Message-ID: <20250313075126.547881-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IF02UFWGKyGJ7jdDIdZnYsaAFye6aSy_
X-Proofpoint-ORIG-GUID: UArhdnRPi98sG5T0--iKaEKp1kXVuPIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=888 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130058

In this RFC series, we are introducing a C extension module to allow
python programs to call the libperf API functions. Currently libperf can
be used by C programs, but expanding the support to python is beneficial
for python users.

The structure of the patch series is as follows:
1. Patch 1 : Create wrappers for the perf structs which are used by
examples/counting.c

2. Patch 2: Create the C extension module that maps and exposes the
libperf functions to python programs

2. Patch 3: A python variant of counting.c - counting.py to demonstrate
the usage of libperf from python

We have not added support for entire libperf, as we want to get
community feedback on the approach taken in this series.

Gautam Menghani (3):
  libperf: Introduce wrappers for perf structs to be exposed to python
  libperf: Introduce a C extension module for python
  libperf: Add counting.py example to demonstrate libperf usage from
    python

 tools/lib/perf/Build                          |   1 +
 .../perf/Documentation/examples/counting.py   |  74 +++
 tools/lib/perf/Makefile                       |  12 +-
 tools/lib/perf/include/perf/py_perf.h         | 431 ++++++++++++++++++
 tools/lib/perf/libperf.map                    |   1 +
 tools/lib/perf/py_perf.c                      | 262 +++++++++++
 6 files changed, 779 insertions(+), 2 deletions(-)
 create mode 100755 tools/lib/perf/Documentation/examples/counting.py
 create mode 100644 tools/lib/perf/include/perf/py_perf.h
 create mode 100644 tools/lib/perf/py_perf.c

-- 
2.47.0


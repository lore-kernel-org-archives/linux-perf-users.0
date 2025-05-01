Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E9E1DF98B;
	Thu,  1 May 2025 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746092234; cv=none; b=NxvYWoUOWl0ujQlNKt0x4Xux6XieXlkcdrSmSPgRHm6hTblQwupPYl4d+Zv62JLIrbN78NuHRv3oOwi4DdTPfnFVY1CeJGHn1vsA24WH1ghI19Tcl/ElMaPn1ZiG3pMWrIshgDpuPYDwk8SGtialhuYI63AruF3ELOMiuw3waJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746092234; c=relaxed/simple;
	bh=5TVxRuUsvxeKsl81HyL6zYDQvld+upRtFi070TXtXvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XHfFJTG6Xh4DSGILk4w48ob1JV+PUj/pDi/KJbqtw2YfZtFOPNnvZcuXJr8iFR7vh4qsFpatHINnXQ9CsAAT2kmvTgsTapOqlXbU8B68JwDHyq5M6BjcoNyB41KKHDM8smsEqPKhyBt2hYhdbHnAS7ZRFunkHGRb2KFBMyvvYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pxQXTZxI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pxQXTZxI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UL3FN8022002;
	Thu, 1 May 2025 09:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Vrq5euhucGh4sFveToiJoGlg63GGSwrwLyHPglf6w
	vA=; b=pxQXTZxIp8M7UIz++wquPZQJ/+vTR/MTHCTUpYM1HT9Pw+5W6ND5O0u61
	dAsqSqI7nwwmF6dpRQkFdrGxACuGAjqu0843m3Ckp/avA/oh/0vq7Qf5lLxx3MOK
	HXWIqyxqtDf4OfSZsEj6v/QT8woGZIJQHxgZ/T3j8Gf+5tlJJO03zv4P8mJmdlK4
	Kj/tjDkV0Ka2Yt8H0dtmVfUXyC6StzSHkcqud+RaJ9ekQIOxiYUQKHj5mnCVgHoG
	Pac+wbhTaQOusSuA1QypxUUNrMfv7luve37ZEu/ZR02xG0P/qmi7apjDo5OrqLa2
	Inh8u/mAscLf8urwMm8B1hlDSq2Yw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46buekjbhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:36:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5419anO2004139;
	Thu, 1 May 2025 09:36:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46buekjbhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:36:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5415BH9F000675;
	Thu, 1 May 2025 09:36:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atpm7dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:36:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5419ah2u56361412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 09:36:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D477120043;
	Thu,  1 May 2025 09:36:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E69B20040;
	Thu,  1 May 2025 09:36:40 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.124.221.47])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 May 2025 09:36:40 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com
Subject: [PATCH 0/4] perf python: Add missing infra pieces for counting perf events
Date: Thu,  1 May 2025 15:06:26 +0530
Message-ID: <20250501093633.578010-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA3MiBTYWx0ZWRfXyRAvlHq8pW6F byIwUEfIm9mHBGoj4COIIYfYOSMy8QAeldpQPltv3j40aYu7jol0mDL6xy/YDe3obCqt0BM8krb zVjsErlcG9ToQxzgV/HbAPPeOxtniWGUS7CPBV0srIly4M2a2nJMYlb+pLBLS6+++6aDp4YL0b6
 QrEE2Gtn7S8y4PKKDfbfWCm140HBqEJ7LSxhNGFBGI3haZTtrJYFv6zxJ+oRnMN13aH4SR/yvpQ iiENYMZfX8xKjV9aVcXGTJLpDYsCv2Mv4xzA3n2PJ/zbu5u4dT1TYXyL8EbzXIfzWq/3BbUSBFg OmsKiC21sEG8Woxvmns+tbrqKUVmilOzxVkA5dyK0YGN+8jWHbAysPe37QR1jv8g1PYMQFKsM9B
 UxMA0aSqxJAnN02WdVm4M6IboJcE8FmSkH3a9bV59yraKNu7MgNDyvroqW9Aeppl2kUabNYt
X-Authority-Analysis: v=2.4 cv=Io0ecK/g c=1 sm=1 tr=0 ts=681340b1 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=Wi2F9hvkSztuHusd8C0A:9
X-Proofpoint-ORIG-GUID: gGeeGpRApqZf9zMzzDR2y7A9TeYelspe
X-Proofpoint-GUID: TdQzQYuP8WE8fEThWyb5_ghYPbQwRoAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505010072

Add the missing infra code in the perf python bindings for measuring and
reading the counter values for the given perf event. Demonstrate the
usage of this with counting.py - a python version of counting.c

Gautam Menghani (4):
  perf python: Add support for perf_counts_values to return counter data
  perf python: Add evsel read method
  perf python: Add evlist close and next methods
  perf python: Add counting.py as example for counting perf events

 tools/perf/python/counting.py |  42 +++++++++
 tools/perf/util/python.c      | 162 +++++++++++++++++++++++++++++++++-
 2 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/python/counting.py

-- 
2.49.0


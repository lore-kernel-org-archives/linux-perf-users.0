Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C34214EC5B
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091488; cv=none; b=qjuazX/sseks4tp8y4BKhkT75PjJxX7ZtZLxA4Tuftl15/XWxxTyo/Jd5xwSP5QLk6G/5P0ms3jsg4CC+ghGTg+IOqCDkBmLWpRsbNL3gRe26Le5J1Id8VenSfZ6iFAyoJeGidZ4Hd/wQlvicz2h1ydHeOCRiOqTxxxWx+mQutg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091488; c=relaxed/simple;
	bh=FTGJx2ci5UwBiw7lRUgttATgya8FzeHMyOb9K70OohM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=l+BxpY0qac2rFJtpH3ZBwq8qFf4A7AuMf3+m9Qiu8Za085kuy/OM47NlcXUHss04esKfFSsJqvuvsVe5KQiubi2CPjZ16wq1qLUXncQxF1WZU/f9MiX5fE3LG77JVA6LGxD3BBcOtFFy+RupH2fTB3s72cxf1SPU8J9aiQzx2Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZjXzjWIe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZjXzjWIe"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DCncIU029606;
	Wed, 13 Aug 2025 13:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=KHtx0KeCB7hPY38xLvMBUDJmEnqb
	5S3273DoLEIUgsM=; b=ZjXzjWIe0Ar4w5c2wfJgd1aeYDxuS7ZYSopRmLWsOzTz
	EkLKaKHfFUyGi8BqE3a2hSdF0q+dUw1icuYoZnTHvdkRGHZRZRPvEqvkURUAVNVY
	dt1DlAQL1Vh9zSNjOs+oqSL18nsm3U61rFyMtnJ8lY12AVwtEcSKoSUIDUJkirpM
	9jKH2gq9xDbTxQID0eSL+4ub2svQsI5xf18373lTeYR6ruqeiZNLCx0JpMCdiKEA
	TmYndrYK/BkHgtUVjsyoQ1tg1J8ZhU8YqYOmDgJvCDCSakomVsuCodSi75YNiIMm
	rWVYyRgRrO1WsJAKz8PMxIhqnXW6h9cKBVoQUctr5w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudcpcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 13:24:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57DC9I0T028658;
	Wed, 13 Aug 2025 13:24:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5n7afk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 13:24:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57DDOceY51773862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 13:24:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8327D20063;
	Wed, 13 Aug 2025 13:24:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60ECA20040;
	Wed, 13 Aug 2025 13:24:38 +0000 (GMT)
Received: from [9.152.212.130] (unknown [9.152.212.130])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 13:24:38 +0000 (GMT)
Message-ID: <f6541c46-d194-4f1f-b4d8-030828f9b272@linux.ibm.com>
Date: Wed, 13 Aug 2025 15:24:38 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Jan Polensky <japo@linux.ibm.com>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Regression: perf script report flamegraph dumps core
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfXwFK9gpuz0UDA
 I3arROS0X2AYswMwK+Jqw3L95oe1Fn74BAKuLC9T+yk14K8tRL8eYL1+a3/vJAT78BDTkRzum4Q
 xjrwm/kRieXykEEFRt9u5SDZuU99ti8UxZ2ZxL9mT2DUM8XtA9SHAYkbqsR4vQAyjsLSUVGeV6d
 C+CkuzLal2UbRaqPo9SwT/Qj3ADidprmzPZyWOtmduCpkEV+jXDilHdWdwFZLZ/Sm01B5wnAIuh
 NXH80tE6ad7HfA++RFLdHHMlTjRChnvw0IkdGo4QCvwGK/i1Dxy9ao73f6RdRXmpGPhvOH9dA7/
 39moviQLTKkMxAzpi+vuONbcDVb+0IuiFNEdfIZ/f/de5/qOhRE1tF0UOsorKSXplAnrtzRGOVz
 zGNQSVWf
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689c921b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=nTytL9qogadzHEVTUOIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: repQTBwX3vN_oAbafyMRLJ_gD1Z4L5D0
X-Proofpoint-ORIG-GUID: repQTBwX3vN_oAbafyMRLJ_gD1Z4L5D0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

Hi all,

Running the following commands on 6.17.0rc1 produces a core dump
sometimes (actually almost on every invocation on my system):

 # perf record -- find / -xdev > /dev/null
 [ perf record: Woken up 2 times to write data ]
 [ perf record: Captured and wrote 0.104 MB perf.data (2321 samples) ]
 #
 # perf script -s /usr/libexec/perf-core/scripts/python/flamegraph.py -i perf.data
 Segmentation fault (core dumped)

 # perf script report flamegraph
 /usr/libexec/perf-core/scripts/python/bin/flamegraph-report: line 3: \
 206665 Segmentation fault      (core dumped)
 #


However when option -d is specified, the commands succeed:

 # perf script report flamegraph -d
 Misordered timestamps: 0
 dumping data to flamegraph.html

 # ll flamegraph.html
 -rw-r--r--. 1 root root 69686 Aug 13 15:02 flamegraph.html

 # perf script -s /usr/libexec/perf-core/scripts/python/flamegraph.py -d -i perf.data
 Misordered timestamps: 0
 dumping data to flamegraph.html

 # ll flamegraph.html
 -rw-r--r--. 1 root root 69686 Aug 13 15:02 flamegraph.html

Again executing
 # perf script -s /usr/libexec/perf-core/scripts/python/flamegraph.py -D -i perf.data
reveals
 ....
 many entries
 ...
 23874506376796 0x42c0 [0x28]: PERF_RECORD_SAMPLE(IP, 0x1): \
                 209863/209863: 0x1da6f281d0c period: 1250000 addr: 0
 ... thread: find:209863
 ...... dso: /usr/lib/debug/lib/modules/6.17.0-20250812.rc1.git4.2810b7c15886.63.fc42.s390x/vmlinux

 0x42e8@perf.data [0x28]: event: 9
.
. ... raw event: size 40 bytes
.  0000:  00 00 00 09 00 01 00 28 00 00 01 d9 ee e3 70 ea  .......(......p.
.  0010:  00 03 33 c7 00 03 33 c7 00 00 15 b6 b7 78 c8 c2  ..3...3......x..
.  0020:  00 00 00 00 00 13 12 d0                          ........

23874506377410 0x42e8 [0x28]: PERF_RECORD_SAMPLE(IP, 0x1): \
                209863/209863: 0x1d9eee370ea period: 1250000 addr: 0
 ... thread: find:209863
 ...... dso:
Segmentation fault (core dumped)


Is this a known issue? Just asking before I start digging.

Thanks a lot.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


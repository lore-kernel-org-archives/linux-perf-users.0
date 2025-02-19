Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B691DED51
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962673; cv=none; b=j5tu1SJbOfwnZ+xKxwJH1J2LZCx9bMfcHWl+ljBeiCxQACrChZw10df2PyiiU0UGBjXR/ffUpAbdbLj8uo1A+/KGXYy4moiJ2PuV9MiipbX2OtXLFPe2ndLgYN0GidX8QILSONDz+WQazPj1yke++3eqyHigMeKvVsvkY1Bki3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962673; c=relaxed/simple;
	bh=sXCCefIdgQ3NB9TFv5hsQtdwO7MhuwA0h0icDPzP/Z0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MndsdR2C41+gcTb4fDWXgfKbp42E9OHW3z7zg7ZHp7RnZUQCfXSu8N67JWoWSrggkYZf62okDe6BfUH5yhgDKBEEgMTsDnp4QCbzIpGe9IeWF788skpVOhCp6d/Hg5dTO1psYXU499V9iAezTAFZ6nirgyDd1rU+/JolGPL5lOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=olKLtH5U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="olKLtH5U"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J75DpC022176
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 10:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=JZKZX1jIPg1zNBISVkhmiqupB8zB
	e1ifilqCHv8eHMc=; b=olKLtH5U7XO/At5U3puLtGIaqzuXWowvfcarxfOrupY4
	yExScZ0N02aQe520Ec3JfP8xLGobFNgrsYwgF3rHR4Bdr5MJRMt/VL5shDdVG5mF
	OrtZSulbpokQpYu4usuumTDowvkIRwLCOcAMM1n5Vt09V6UdLMr91L1bDpPFIZbY
	mKcjPnkhd18Bwux0/ZZ4HXNQP8QmCEZXQ9DC94kLO/IBR3+wJZZn3vAT4eSE3Bg9
	KVpXy1zWk7zYxAbgZIU5hmzT4ieBdJ6/r2XRadsQCi/g7x3/zLOM7cPyoCz0KyIO
	pnlYVXhXmclfk0JMmwzWsOCIMcBMssyrQ1qiEBy/2Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wahjs35p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 10:57:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51JAWhmR003388
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 10:57:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wahjs35k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 10:57:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JADCG6030138;
	Wed, 19 Feb 2025 10:57:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01x3mk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 10:57:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JAvlag35520894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 10:57:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6444420043;
	Wed, 19 Feb 2025 10:57:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3920C20040;
	Wed, 19 Feb 2025 10:57:47 +0000 (GMT)
Received: from [9.171.69.222] (unknown [9.171.69.222])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 10:57:47 +0000 (GMT)
Message-ID: <e2c7e654-5608-4206-ab3a-2a63b54cbc35@linux.ibm.com>
Date: Wed, 19 Feb 2025 11:57:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: perf record question regarding grouped events
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yJ5Jp9KGxRK2U65gkMDKhttbP2zErvdp
X-Proofpoint-ORIG-GUID: LFziUcWoCtUwqM-J4dQIbCtg67qVhuww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190084

Hi all,

I have a question on the intended usage of the grouped events as
in test case 114 perf record tests subtest 'Basic leader sampling' test
where this command is executed:

 # perf record -vv -e '{cycles,cycles}:uS' -- ...

In the debug output the following 2 event are installed:

 ------------------------------------------------------------
 perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0 (PERF_COUNT_HW_CPU_CYCLES)
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
  read_format                      ID|GROUP|LOST
  disabled                         1
  exclude_kernel                   1
  exclude_hv                       1
  freq                             1
  sample_id_all                    1
 ------------------------------------------------------------
 sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
 ------------------------------------------------------------
 perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0 (PERF_COUNT_HW_CPU_CYCLES)
  sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
  read_format                      ID|GROUP|LOST
  exclude_kernel                   1
  exclude_hv                       1
  sample_id_all                    1
 ------------------------------------------------------------
 sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8 = 6

What puzzles me is that the first event with file descriptor 5
is installed for sampling. The second event with file descriptor 6
is installed for counting because event attribute members
attr::freq and attr::sample_freq are zero.

So of the 2 cycles events installed, the group leader is sampling
and the other event is counting.

Is this understanding correct?
The test then checks if the number of samples matches the count
from the counting event?

I have a question on the intended usage of the grouped events as
in test case 114 perf record tests subtest 'Basic leader sampling' test
where this command is executed:

 # perf record -vv -e '{cycles,cycles}:uS' -- ...

In the debug output the following 2 event are installed:

 ------------------------------------------------------------
 perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0 (PERF_COUNT_HW_CPU_CYCLES)
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
  read_format                      ID|GROUP|LOST
  disabled                         1
  exclude_kernel                   1
  exclude_hv                       1
  freq                             1
  sample_id_all                    1
 ------------------------------------------------------------
 sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
 ------------------------------------------------------------
 perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0 (PERF_COUNT_HW_CPU_CYCLES)
  sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
  read_format                      ID|GROUP|LOST
  exclude_kernel                   1
  exclude_hv                       1
  sample_id_all                    1
 ------------------------------------------------------------
 sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8 = 6

What puzzles me is that the first event with file descriptor 5
is installed for sampling. The second event with file descriptor 6
is installed for counting because event attribute members
attr::freq and attr::sample_freq are zero.

So of the 2 cycles events installed, the group leader is sampling
and the other event is counting.

Is this understanding correct?
The test then checks if the number of samples matches the count
from the counting event?

Thanks a lot for your help.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


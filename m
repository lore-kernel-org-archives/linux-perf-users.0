Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDE61E50E
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Jul 2025 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966494; cv=none; b=Q6zfu/y4mjWtPaHZJEnEkGW/Kkd9Nhu8Gctd60e4A4EwQhIgzW4QbwS7Swv5Wrhyw+Vqfe/r+7rsSmoYHJDe911K5Ay0ewNKHNp2Ezzju/Eepv/MRppQhgYqZBsRiMQ5RpbPtK4G42LaxY9KZiVFxOzx3yW9otQJmf7DfvBrA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966494; c=relaxed/simple;
	bh=mY0JldIjWw6luGuYgjIWmYSUo0JrHC+sRs7wvVyW4dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCfm5d5c+igiYbJTvRCdKPhIwhmGswYhF0nrcUXM0k0NsliO6pb5+bGu8GJabX1C/gxJMLAIgPhKbf+TOJu0jWWRBKJWYgF5UBIoqadpYXyymWpYaPYX8CxgwOe+tQ0cj9I3KuVWpcUrHeHklhaDBchsPJp3Y1bHGVBq8L0eLqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kza0Zl0Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kza0Zl0Z"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VAQ3Vl015097;
	Thu, 31 Jul 2025 12:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UUqDwJ
	ueHrhdKn+SADu/j4fXVgwvDsJVja+s2czVP2Q=; b=Kza0Zl0ZGIS/Kxc5TrFHZx
	vMvSZYC4Rf7A3noUo4/Gjd9enhkp/CxdKFbkzR5AW6VkMsxrIzLXoGwDsFHFQ57m
	w6DcPxYlYp/IpYKbIgoi0GxcgOXyb7D+bxIyDPe9C2dWCUpdsIY0z3mgWfyLoXTR
	xsezwCypv9fSgSfvatJtctLDkWIkPDMCa5hA8pNqd1dla6mTwPPk5fz5GZlaPJQF
	a1UTKU5NwIYXe7LMgzMPukW2OP+8pqU8P2xTVA4HbpxddHHkwqAod6Pd5GAkQnLH
	6r44EDxdd+0/uGf6fj4HlRvMHd12mrfBYIpwrmReAiTPTZlaVetBpn0Sbw8BLhfg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfr2m43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 12:54:47 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56VCkkHp013531;
	Thu, 31 Jul 2025 12:54:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfr2m3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 12:54:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56VBdpco018293;
	Thu, 31 Jul 2025 12:54:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485abpcg1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 12:54:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56VCshs019595628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 12:54:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 696C82004B;
	Thu, 31 Jul 2025 12:54:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0952220040;
	Thu, 31 Jul 2025 12:54:42 +0000 (GMT)
Received: from [9.79.202.156] (unknown [9.79.202.156])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Jul 2025 12:54:41 +0000 (GMT)
Message-ID: <fa7e2b4b-0b13-42a0-a023-90270ae22014@linux.ibm.com>
Date: Thu, 31 Jul 2025 18:24:41 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Introduce structure for shell tests
To: Jakub Brnak <jbrnak@redhat.com>, vmolnaro@redhat.com
Cc: acme@kernel.org, acme@redhat.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, mpetlan@redhat.com,
        namhyung@kernel.org
References: <20250113182605.130719-1-vmolnaro@redhat.com>
 <20250721132642.40906-1-jbrnak@redhat.com>
Content-Language: en-US
From: tejas05 <tejas05@linux.ibm.com>
In-Reply-To: <20250721132642.40906-1-jbrnak@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA4OCBTYWx0ZWRfXxyyqIDEPmxnA
 Z6ipWLKtpLtXUcuZaDQ2SwLG5pS+9DComJVWhUdAyywbZW5yiBekKzjgI0t0qB7pSOtYy+Lw5tl
 yT3h4EUbBFjm7tQrmGwy0e39pHzKvFku59jXhSs1A0ab/wUJTH4EXiUIsDXJu38zOyG1HP4WKd6
 dJbmfJ9P4Z5eABbG2TzV7uiMlXzWh8HPLxggMl93zCgW/bUrQALxGsQlt5ZRf3nn9xGsbtT5dCn
 ah5LUKCQHUUd5yb3fFpCQv3TRuocF1/Y2lwH/v2rceu6ItBfZ9Z+FLaGqohUdXd7uo5cE4HO9YQ
 lpwwqx4Pbelc1tb41Er9z4J4m0iMdSbt4gIFD753rhR0oMZZNgiNvmzYxgLhuIuR7gTJjWFfG1W
 AMkP5igclUpUTq4NgFpwJ4V7lGnVR+j6l2QZ0Y4fQefePfLw0mIZ4gcLLBJVGF7WX9oGUMHJ
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=688b6797 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=lXTSEWvqIlZpsw59VNQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Y6GJYL8p0K65R-1Xo0KAoWetzBhpyxjD
X-Proofpoint-ORIG-GUID: 0REaxn-Nd7Yv7aSi1ITFZGzk_j-SVFHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=590 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310088


On 7/21/25 18:56, Jakub Brnak wrote:

> Hi Arnaldo,
>
> This series of Veronika's patches as a part of upstreaming effort of perftool-testsuite has been rebased on the latest perf-tools-next branch and should now apply cleanly.
> Patches 01/10, 02/10, and 05/10 from the v2 have been dropped as they were already accepted upstream.
>
> Thanks,
> Jakub Brnak
>
> Veronika Molnarova (7):
>    perf test perftool_testsuite: Use absolute paths
>    perf tests: Create a structure for shell tests
>    perf test: Provide setup for the shell test suite
>    perftool-testsuite: Add empty setup for base_probe
>    perf test: Introduce storing logs for shell tests
>    perf test: Format log directories for shell tests
>    perf test: Remove perftool drivers
>
>   tools/perf/tests/builtin-test.c               | 137 +++++++++-
>   tools/perf/tests/shell/base_probe/setup.sh    |  13 +
>   .../base_probe/test_adding_blacklisted.sh     |  13 +-
>   .../shell/base_probe/test_adding_kernel.sh    |  53 ++--
>   .../perf/tests/shell/base_probe/test_basic.sh |  19 +-
>   .../shell/base_probe/test_invalid_options.sh  |  11 +-
>   .../shell/base_probe/test_line_semantics.sh   |   7 +-
>   tools/perf/tests/shell/base_report/setup.sh   |   6 +-
>   .../tests/shell/base_report/test_basic.sh     |  47 ++--
>   tools/perf/tests/shell/common/init.sh         |   4 +-
>   .../tests/shell/perftool-testsuite_probe.sh   |  24 --
>   .../tests/shell/perftool-testsuite_report.sh  |  23 --
>   tools/perf/tests/tests-scripts.c              | 258 +++++++++++++++---
>   tools/perf/tests/tests-scripts.h              |  15 +
>   tools/perf/tests/tests.h                      |   8 +-
>   15 files changed, 465 insertions(+), 173 deletions(-)
>   create mode 100755 tools/perf/tests/shell/base_probe/setup.sh
>   delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
>   delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh

Hello,

I am seeing this testcase skip and fail on powerpc. The test was skipping and when run in verbose it showed failures in
perf/tests/shell/base_report/setup.sh.

# ./perf test "perftool"
115: perftool-testsuite :: perf_probe                                :
115.1: perf_probe :: Reject blacklisted probes                       : Running (1 act
115.1: perf_probe :: Reject blacklisted probes                       : Ok
115.2: perf_probe :: Add probes, list and remove them                : Running (1 act
115.2: perf_probe :: Add probes, list and remove them                : Ok
115.3: perf_probe :: Basic perf probe functionality                  : Running (1 act
115.3: perf_probe :: Basic perf probe functionality                  : Ok
115.4: perf_probe :: Reject invalid options                          : Running (1 act
115.4: perf_probe :: Reject invalid options                          : Ok
115.5: perf_probe :: Check patterns for line semantics               : Running (1 act
115.5: perf_probe :: Check patterns for line semantics               : Ok
116: perf_report :: Basic perf report options                        : Running (1 act
116: perf_report :: Basic perf report options                        : Skip

# ./perf test 116 -vv
116: perftool-testsuite :: perf_report:
116: perf_report :: Basic perf report options                        : Running (1 act
--- start ---
test child forked, pid 2671
-- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
==================
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.099 MB /tmp/perf_test_perftool_testsuite____perf_report.eAUy69/perf_report/perf.data.1 (767 samples) ]
==================
/root/perf-tools-next/tools/perf/tests/shell/base_report/setup.sh: line 43: ../common/check_all_patterns_found.pl: No such file or directory
-- [ FAIL ] -- perf_report :: setup :: prepare the perf.data.1 file (output regexp parsing)
## [ FAIL ] ## perf_report :: setup SUMMARY :: 1 failures found
---- end(-4) ----

116: perf_report :: Basic perf report options                        : Skip

In other instances where /common/check_all_patterns_found.pl is used is has $DIR_PATH appended to it, something similar should also be used here.

Thanks & Regards,
Tejas Manhas


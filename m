Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9FC3ADB98;
	Fri, 24 Jul 2026 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882970; cv=none; b=iPRaX2Oza2XRTTrIHzc+zl/C7IMJojhP4Kybl4ABGh4xcBHZnP9ISr/PTgJw7tU3Qq97+zrwmQgdqLZ06hLYjK1N8w1nBUQ34TwGanN/8aJOkWBQM6yUK+JALvdGMk5x/8nfZUHcQJHdO1Mlkq8HSah/k2BYzp//lWbNHKLWwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882970; c=relaxed/simple;
	bh=ejJjpB6+CE7+pwhXTPIqM62pob4H8745ZWjHUeff8W4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dsHALZqgK8A030cSCZMoqMXajPJVS9NbYNuZB7ikr8lJVckz2xat+Zj9qr9LeaEHw+ArRZ8tOriMCPcY7Lx9ZtQrcqBwEIuw620RkBm8olGQAzkbO9gYd8oT6CmVuZhtvIKFst/CInHiI7HgjTqe+9i+73coJ6piaTDBU0jbQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I2IfO3ic; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I2IfO3ic"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5Be1H3220091;
	Fri, 24 Jul 2026 08:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ejJjpB
	6+CE7+pwhXTPIqM62pob4H8745ZWjHUeff8W4=; b=I2IfO3icRsTF6A1S3ndBxV
	xzSsRJC1zdY7h/tutM1kOLDU/GEG+ws+Tm66rX2cScpMrnU9UiJL2wsmqtJOwPkt
	9F49def1Ir9IdBU5v2JINm+Z2q3xCvMN+tI5Hof+qalB4/YwAr6LlqUv6RB3n5et
	DEuvudKPRVfF9Sr4HPgXGadAxaCS09ZTo3a9C8UbDVlafeVsCvYZBsJ9Jw2AZmnr
	NRjbn3YG81N90n1/watORrvkCcM60283Gk1uEPjoLw2K+ZNpaV9Z4ecoW6js0Ysv
	MBE47cZ7oRdPf8ihscKm81sFF++g4NfhF7AJ0akYwqHwno5YiuyjspLPg8HEoCCw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77auut6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:49:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O8Ybf0026481;
	Fri, 24 Jul 2026 08:49:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gqydd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 08:49:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O8nPMH52494776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 08:49:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DD24200EA;
	Fri, 24 Jul 2026 08:49:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60D44200EC;
	Fri, 24 Jul 2026 08:49:24 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.110])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 08:49:24 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V2 4/6] tools/perf: Add powerpc callback support for
 arch_perf_record__need_read
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260720111824.E37591F00A3A@smtp.kernel.org>
Date: Fri, 24 Jul 2026 14:18:58 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9749A98-400E-4A53-B285-05D2E9000954@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
 <20260720105218.14277-5-atrajeev@linux.ibm.com>
 <20260720111824.E37591F00A3A@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pYqw4eogtL3OSNZv3W8Xesgryde-vaJ4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX4HhUAMlIWkEu
 iDf0xPlETlaSI04fL57rKZOhf9p97TEhJZxrRQciLuztneEZunaHuFUB/3pjagzLhoqfO2eXTyB
 6TeYDb8hqpt/vaH/t+fl3/ASSjZe2Js=
X-Proofpoint-GUID: pYqw4eogtL3OSNZv3W8Xesgryde-vaJ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX4j5HZxB2M18B
 K8vxLiMXoEAlMpFoyXiZ7XlGo+OrVIvPJ3L9dSLhumQ/3yHvqN+ZJA8Qv0wMXwgmdaaTt8NNWxL
 dseNUPy/3bh2/QhIhb9XrPADai9NHxHD/r1GCu559MQcucLL7jSLmyZDfFc1+Y51HpgWFM/8l3I
 jjZOIdpnWqrSZ6EMOSPI/AIZ+KYRwR4rTmP8m4TdupqmXjwTIUYoT/ISLNYdDE+X+oHLLgXIEv4
 hVl9wWaILB69Dep27/IX/TkBAWnX1a7wsAjl/ufApOKULOVC9U7/aMqBQft0FBIoRXv5fulDstU
 Xj26h+fD/VkC3AGfaknSB2J9RFMKQdLFJr8MbOPhN38/Gs/TSFtE6Zmwim6dCCaXm9hDuqvF614
 NNuQD05Ol32XhX3JuLFLw30PQtnHrOX8N/6Bzf5pz//oPW/1QVT/bpPtAIrlvBftY/2zPf/ypR1
 wjN1uJfTdM4y/RIUHag==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a632717 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=i58RzWYn4e0uB39s-5EA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240078



> On 20 Jul 2026, at 4:48=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential =
issue(s) to consider:
> - [Medium] The function identifies HTM events using a highly brittle =
prefix match on the event name (`strstarts(evsel->name, "htm")`), which =
will erroneously match unrelated user-named events or tracepoints.
> - [Low] The file uses `strcmp()` and `bool` but fails to explicitly =
include the standard POSIX headers `<string.h>` and `<stdbool.h>`, =
violating the subsystem musl compatibility guidelines.
> - [Low] The string comparison against 'dummy:u' is mathematically =
unreachable and constitutes dead code.
> --
>=20
> --- Patch [4]: [PATCH V2 4/6] tools/perf: Add powerpc callback support =
for arch_perf_record__need_read ---
> commit 08efcd22d3e33aa6575dbd818f05eb3b46a80a92
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Add powerpc callback support for =
arch_perf_record__need_read
>=20
> Implement the arch_perf_record__need_read() architecture-specific hook
> for powerpc in arch/powerpc/util/evsel.c. The hook reads event counts =
for
> open htm evsels to determine if data is pending.
>=20
>> diff --git a/tools/perf/arch/powerpc/util/evsel.c =
b/tools/perf/arch/powerpc/util/evsel.c
>> index 2f733cdc8dbbe..8f2805a680261 100644
>> --- a/tools/perf/arch/powerpc/util/evsel.c
>> +++ b/tools/perf/arch/powerpc/util/evsel.c
>> @@ -1,8 +1,77 @@
>> // SPDX-License-Identifier: GPL-2.0
>> #include <stdio.h>
>> +#include <linux/string.h>
>> #include "util/evsel.h"
>> +#include "util/record.h"
>> +#include "util/evlist.h"
>> +#include "util/debug.h"
>> +#include <internal/xyarray.h>
>=20
> [Severity: Low]
> Does this file need to explicitly include <string.h> and <stdbool.h>?
>=20
> This file uses bool and strcmp(), but relies on implicit inclusion or
> <linux/string.h>. Compiling perf against musl libc requires direct =
inclusion
> of standard POSIX headers for these types and functions to avoid build
> failures.

Sure, will add in V3
>=20
> [ ... ]
>=20
>> +int arch_perf_record__need_read(struct evlist *evlist)
>> +{
>> + struct evsel *evsel;
>=20
> [ ... ]
>=20
>> + /* Read HTM event counts to check if more data is available */
>> + evlist__for_each_entry(evlist, evsel) {
>> + struct xyarray *xy =3D evsel->core.sample_id;
>> +
>> + if (!evsel->name || !strstarts(evsel->name, "htm"))
>> + continue;
>=20
> [Severity: Medium]
> Is it safe to identify HTM events using a prefix match on the event =
name?
>=20
> If a user traces a standard event and names it with an "htm" prefix =
(e.g.,
> perf record -e cpu-cycles/name=3Dhtm_cycles/), this hook would falsely
> identify it as an HTM event and read its event count.
>=20
> For standard events, this count contains the actual accumulated hits, =
not the
> 0/1 driver staging flag, causing total_pending_bytes to always be > 0. =
Would
> this force arch_perf_record__need_read() to always return 1 and cause =
the
> drain loop in record__final_data() to instantly abort with a spurious =
warning
> about making no forward progress?
>=20
> Would it be more robust to identify these events by checking the PMU =
type
> instead of the name?

I will have change in V3 to use evsel_pmu_name instead
>=20
>> +
>> + if (!strcmp(evsel->name, "dummy:u"))
>> + continue;
>=20
> [Severity: Low]
> Is this string comparison reachable?
>=20
> The loop explicitly filters events above with:
> if (!evsel->name || !strstarts(evsel->name, "htm")) continue;
>=20
> Because "dummy:u" does not start with "htm", any "dummy:u" event is =
already
> caught and skipped by the first condition, making this check dead =
code.
Correct, this is a redundant check.=20

Thanks
Athira
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260720105218.14277-1-atrajeev@linux.ibm.c=
om?part=3D4


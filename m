Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46275353EE0;
	Mon, 20 Jul 2026 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543153; cv=none; b=V8OnlJAyP1HtBVuH55EEG6bXsYSliu2hA3kehww0MJsqUCZKBU8NhQ0qSLSr7lvA29Iiygr41WlLKbZER73BniSERJG3WRCV2lT8jqqYrfgT2WFdI1bj+tOnwZK+tgjNYh4vizLIYWGqm10AYW73wt0fozLPv9RTMmDS4rdmh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543153; c=relaxed/simple;
	bh=fOadGIdJY6gAikTGWr+Xo9f9UQc8S6PY+BodjZcYW2g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=t4bcpUPxmrWEe0g0EJkgEqc5S3oHfEk/kY4n3w4ecDOUQGnw2sdzdhkgKGnMgtBhvHRuBrUMleUYPoYm+cudl6tlS1gG3/XEP2IArlkWMUcfRo4/AvNVl+gQoScICicitGA6G4IQrSqzdgWXCA40kzfxFBtrljhxRw9EChX3d4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JVsXmFJy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JVsXmFJy"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABjGP1811444;
	Mon, 20 Jul 2026 10:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NPU/7x
	oYGRRr4FWZxFSN67gmJpDUDSyGkxZ2+Mp8v9Y=; b=JVsXmFJyMfpUKwY4c5HOqv
	ki/fi/hSS9fRHtOVv0vkJsld6BD4HlJzuA3Wh3ijMjB7HfyvavIVHWaL416tW507
	kViA2Ch5+4oRLVHqlQWQUqAmrsdkmvkDOe6pZc8aI6Gc2pnyAD8aC+5LzPZeG52H
	Mwy1FtPvbNp8G8Kgau5jOH9ADxy0lNWgXnbJ6T+xK6fZ0XjZAvoGXx1Ug0hzi++0
	mUnX9nQaPv6KTC/NBBYioUSBulOuzLoHoGkrvWRxM9FqeC9jlQ0BeeaBKchV5ZCe
	uzgLt4jhxS+5IwBr5Jb3Ifm2wv/4sxeTsueDon6IEpiEE4oJRi/YHhu5EWidNsjg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fxpgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:25:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAJd1r029884;
	Mon, 20 Jul 2026 10:25:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g4y2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:25:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAPltt61604170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:25:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 890CA2006A;
	Mon, 20 Jul 2026 10:25:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E140520063;
	Mon, 20 Jul 2026 10:25:46 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Jul 2026 10:25:46 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 4/9] tools/perf: Add powerpc callback support for
 arch_record__collect_final_data
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260701085512.E9C3A1F000E9@smtp.kernel.org>
Date: Mon, 20 Jul 2026 15:55:34 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B450DA7-95C9-47D6-A795-4D90AD0C1B2A@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
 <20260701084115.80383-5-atrajeev@linux.ibm.com>
 <20260701085512.E9C3A1F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfX7O3KcKB//DGe
 Ud1uucWPWheQ3q/LK2TiLo83nO7Z7xpsfxl1PpUroOUrn5dV7USTd0JK8gFitHIDRlIIn01DWi2
 E1kIJTmtM0layW0ik21S6QXXsp4S2pnCESi3gcoZClJNGdW4Gv/7NveBqxW8n/vXI8hp2nheTBe
 Kxx4iey77NdiMRJvO09Kc2VgXicAuWaRFUTcTheaqnWpczyqJ4GfqSspZKSPhGiCEzzomWINw7J
 VWuuPsC34C4pj26EV2K+97VQ/9B4gwDsYXqdC5HQNROz2qHBCBdE6EGcnuVWIvHFE+hdIIgaze7
 U6lbP5Q0NcLtDXEx6JPo78nKhGjrkKTf6dacFPoh9Ut/XStA2O4FxOj+d06ETUU7bQ7bRj0XERn
 t8+QLD7JE4UVh8+waU+o1hYY3iCCaK6znZiTjJk2ubi74J6ZMMAjLlB248Z2fuqhrRlGUGfdjV7
 7Xzvujyow59DaJf++fg==
X-Proofpoint-GUID: LfWYJ4KbILrz0nrtVjczsJotbhqmYXS6
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5df7ae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=pU_tUekmDu7BBBPSybIA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfX8SXI9q/GaSS+
 Wygn0xzN52YIIFWcIzr/2n8Ycu5HVQuwo0h7020o8ECY8xB0FB/rYZUq5RlZSC5F351A+qwuB+4
 q+fSLXe5JOxCiUfcc5oXpbwvY544Y4g=
X-Proofpoint-ORIG-GUID: LfWYJ4KbILrz0nrtVjczsJotbhqmYXS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200114



> On 1 Jul 2026, at 2:25=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 6 potential =
issue(s) to consider:
> - [High] Direct access to `evsel->name` without NULL checks causes a =
segmentation fault.
> - [High] Premature loop termination in `arch_perf_record__need_read` =
due to artificial overwriting of loop variables.
> - [High] Unconditional compilation of PowerPC-specific execution logic =
globally overrides a cross-platform weak symbol.
> - [High] The negative error return value from `perf_evsel__read()` is =
ignored, leading to premature termination of trace data collection.
> - [Medium] The functions and callbacks described in the commit message =
are completely missing from the implemented code.
> - [Low] Malformed include path directive `../../../util/record.h` =
causes a build failure.
Thanks for the review and mentioning these issues
V2 will add these checks:
- Check for evsel before accessing name
- Move the arch specific function to arch/powerpc/util
- Fix the function name in commit message
- Proper path for record.h

Thanks
Athira

> --
>=20
> commit dee0b2f32508f51e2b57675240fda0c4192160d5
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Add powerpc callback support for =
arch_record__collect_final_data
>=20
> This patch adds an architecture-specific hook to collect additional =
HTM trace
> data before closing events. It reads the HTM event counts to determine =
if
> more data is available to be written to the perf data file.
>=20
>>    Add arch_record__collect_final_data to collect additional
>>    data before closing the event. Define the callback in
>>    util/powerpc-htm.c
> [ ... ]
>>    the event using evlist__enable after reading event using
>>    htm_read_data function. The perf_evsel__read returns zero, when
>=20
> [Severity: Medium]
> The commit message mentions adding arch_record__collect_final_data and
> reading events using the htm_read_data function. However, the =
implemented
> code defines arch_perf_record__need_read and uses perf_evsel__read =
instead.
> Could the commit message be updated to match the actual =
implementation?
>=20
>> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
>> index 5e2265018826f..4d79662e88266 100644
>> --- a/tools/perf/util/Build
>> +++ b/tools/perf/util/Build
>> @@ -142,6 +142,7 @@ perf-util-y +=3D hisi-ptt.o
>> perf-util-y +=3D hisi-ptt-decoder/
>> perf-util-y +=3D s390-cpumsf.o
>> perf-util-y +=3D powerpc-vpadtl.o
>> +perf-util-y +=3D powerpc-htm.o
>=20
> [Severity: High]
> Does unconditionally adding powerpc-htm.o here cause it to be compiled =
for
> all architectures? Since it defines arch_perf_record__need_read =
globally,
> this could override the weak symbol in builtin-record.c and =
incorrectly
> execute PowerPC-specific logic on other architectures like x86 or ARM.
>=20
>> diff --git a/tools/perf/util/powerpc-htm.c =
b/tools/perf/util/powerpc-htm.c
>> new file mode 100644
>> index 0000000000000..5043ff41a609e
>> --- /dev/null
>> +++ b/tools/perf/util/powerpc-htm.c
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * HTM support
>> + */
>> +
>> +#include "../../../util/record.h"
>=20
> [Severity: Low]
> Will this include path resolve correctly during the build? It appears =
to
> point outside the normal include directories for the perf tool, which =
might
> result in a compile-time failure.
>=20
> [ ... ]
>> +int arch_perf_record__need_read(struct evlist *evlist)
>> +{
>> + struct evsel *evsel;
>> + int found_htm =3D 0;
>> +
>> + /* there was an error during record__open */
>> + if (!evlist)
>> + return 0;
>> +
>> + /* First, check if any HTM events exist */
>> + evlist__for_each_entry(evlist, evsel) {
>> + if (strstr(evsel->name, "htm") !=3D NULL)
>=20
> [Severity: High]
> Can evsel->name be NULL here? For raw hardware events or events before
> parsing has dynamically assigned a name, passing a NULL pointer to =
strstr
> or strcmp will cause a segmentation fault.
>=20
> [ ... ]
>> + for (int x =3D 0; x < xyarray__max_x(xy); x++) {
>> + for (int y =3D 0; y < xyarray__max_y(xy); y++) {
>> + struct perf_counts_values count;
>> +
>> + if (!strcmp(evsel->name, "dummy:u"))
>> + continue;
>> +
>> + if (strstr(evsel->name, "htm")) {
>> + perf_evsel__read(&evsel->core, x, y, &count);
>=20
> [Severity: High]
> Does this properly handle failures from perf_evsel__read()? It returns =
a
> negative error code on failure and leaves the count struct =
uninitialized or
> zeroed. If ignored, count.val could evaluate to 0 below, causing the =
trace
> data collection to terminate prematurely.
>=20
>> + y =3D xyarray__max_y(xy);
>> + x =3D xyarray__max_x(xy);
>=20
> [Severity: High]
> Are these assignments intentionally overwriting the loop iteration =
variables?
> This forcefully terminates both the inner and outer loops after =
checking
> only the very first CPU and thread index (0, 0), preventing the =
iteration
> from checking any of the remaining CPUs.
>=20
>> + }
>> + if (!count.val)
>> + return 0;
>> + }
>> + }
>> + }
>> +
>> + return 1;
>> +}
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260701084115.80383-1-atrajeev@linux.ibm.c=
om?part=3D4


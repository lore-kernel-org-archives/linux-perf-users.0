Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD09185939
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103024; cv=none; b=CEuFH8J+LmvsIMJqIu1vd6kTkyI0CE4VLNv5eP2F9mWW1Ur99APYA0g7FOiok2R36UL+qLzfup5QwErkCwq7eD/TXFw4i4W4iU97sBfalSyqok7xmfi/OQaSR1kPCmyWDIkUiFoJfI7bHDH0oZwrKuZbP6ToNaInCHayOOA86vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103024; c=relaxed/simple;
	bh=dAYSxyeE2xrHlPukDF0m1OhG/lb5ARpJxHiPfobv8QM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=e9YpmV8gA+W9zUh7ggs3cjN2F9nOCTa+4LmOizb7E3LPCFHJxrDVS8FpjfK8p279VG6PwOqIKNrYlnGZ4/G4P9VG4lQWuYs5GOnoe+K29Wf22WVTGapY5yFW6Xw9eK7mFNyFjpNSyq4eOVwkgMsLtR30rmx6/BLyjg6th0+RBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eJAnY8r2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eJAnY8r2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GHUKTg022043;
	Wed, 16 Oct 2024 18:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VruusQ
	ONQFjzT9HW1JV4XihdJJFRYObHq45UpBeErO8=; b=eJAnY8r2jyzHnKgQ3QnkfJ
	okzLCdIpoZ/N1Hflc+sItSAZjctNtVD55CYV2PmAA63/DUuShGVsxUyMci/ULuZp
	BWJ1wKcuZePK4TcLKsU+jNZpvprguF3NTRi/JWP1v1X4mFUUfyN3Zz51ZjKtjf/z
	N6s8PK5YHIRzIqm9SAyF8N+a4R5LIkIjy/9ekHgaHX2yJbE3pwVJXQjCBHPm4bq2
	8SYqN4QIlFi1iNW9lVspX6Jq2rTqo8LxEZKL8h1lP4oAs5nIpN777hGEmHEdIYvF
	cjVZxso61MYDlAlhwwlSEhF2rlmO/Hi6gWYHe3JWKGOOVkNmeUGbD4lBNG7i3QhA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ahxj06tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:23:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GINYtH004060;
	Wed, 16 Oct 2024 18:23:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ahxj06tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:23:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GHxY7V005215;
	Wed, 16 Oct 2024 18:23:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285njak7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:23:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49GINT2j54133186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 18:23:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF35920043;
	Wed, 16 Oct 2024 18:23:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E58520040;
	Wed, 16 Oct 2024 18:23:24 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.242.239])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 18:23:23 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] tools/perf/tests: Fix compilation error with strncpy in
 tests/tool_pmu
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <CAP-5=fWQsQp3WgJcLvZWsBsiJ2VzxP6j2kOfd5Hrzi0oBUNy2g@mail.gmail.com>
Date: Wed, 16 Oct 2024 23:53:10 +0530
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        hbathini@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E64BA2C9-3046-4C96-ACB8-A4F0D99BDA40@linux.vnet.ibm.com>
References: <20241013173742.71882-1-atrajeev@linux.vnet.ibm.com>
 <Zw1UXbWTS9Gk3lmw@google.com>
 <8B5B2251-E41E-4584-881E-61A468AFB222@linux.vnet.ibm.com>
 <CAP-5=fWQsQp3WgJcLvZWsBsiJ2VzxP6j2kOfd5Hrzi0oBUNy2g@mail.gmail.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dbADMUnoAbi2KqOhgH4vZM8ROHXSU7HI
X-Proofpoint-ORIG-GUID: 6r9WWZlP-1id1hj75wgGiZ0uRW2Halng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160115



> On 16 Oct 2024, at 8:36=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> On Wed, Oct 16, 2024 at 5:30=E2=80=AFAM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
>>=20
>>=20
>>=20
>>> On 14 Oct 2024, at 10:56=E2=80=AFPM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>>>=20
>>> Hello Athira,
>>>=20
>>> On Sun, Oct 13, 2024 at 11:07:42PM +0530, Athira Rajeev wrote:
>>>> perf fails to compile on systems with GCC version11
>>>> as below:
>>>>=20
>>>> In file included from /usr/include/string.h:519,
>>>>                from =
/home/athir/perf-tools-next/tools/include/linux/bitmap.h:5,
>>>>                from =
/home/athir/perf-tools-next/tools/perf/util/pmu.h:5,
>>>>                from =
/home/athir/perf-tools-next/tools/perf/util/evsel.h:14,
>>>>                from =
/home/athir/perf-tools-next/tools/perf/util/evlist.h:14,
>>>>                from tests/tool_pmu.c:3:
>>>> In function =E2=80=98strncpy=E2=80=99,
>>>>   inlined from =E2=80=98do_test=E2=80=99 at tests/tool_pmu.c:25:3:
>>>> /usr/include/bits/string_fortified.h:95:10: error: =
=E2=80=98__builtin_strncpy=E2=80=99 specified bound 128 equals =
destination size [-Werror=3Dstringop-truncation]
>>>>  95 |   return __builtin___strncpy_chk (__dest, __src, __len,
>>>>     |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>  96 |                                   __glibc_objsize (__dest));
>>>>     |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>=20
>>>> The compile error is from strncpy refernce in do_test:
>>>> strncpy(str, tool_pmu__event_to_str(ev), sizeof(str));
>>>>=20
>>>> This behaviour is not observed with GCC version 8, but observed
>>>> with GCC version 11 . This is message from gcc for detecting
>>>> truncation while using strncpu. Use snprintf instead of strncpy
>>>> here to be safe.
>>>>=20
>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>>=20
>>> I found this issue now and thanks for the quick fix.  I will push to
>>> perf-tools-next soon.
>>>=20
>>> Thanks,
>>> Namhyung
>>>=20
>>=20
>> Sure
>>=20
>> Thanks Namhyung for pulling in the change
>>=20
>> Athira
>=20
> Thanks for the fixes. As this is test code I don't think performance,
> style, etc. matter much. The GCC strncpy warnings are annoying imo,
> I'm not sure it makes sense for them to be enabled. I see in the
> kernel lots of "sizeof(foo)-1" as a workaround. strlcpy looks like a
> better alternative but it gets a checkpatch warning as in the kernel
> strscpy is preferred. Perhaps we should create a strscpy shim.
>=20

IIUC, strscpy is defined in kernel source and is currently not used in =
tools side.

Ian,
Your point here is that we can create an interface in tools side so that =
we can later safely use strscpy in cases like this ?

Thanks
Athira

> Thanks,
> Ian
>=20
>>>> ---
>>>> tools/perf/tests/tool_pmu.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/tools/perf/tests/tool_pmu.c =
b/tools/perf/tests/tool_pmu.c
>>>> index 94d0dd8fd3cb..297cc8c55579 100644
>>>> --- a/tools/perf/tests/tool_pmu.c
>>>> +++ b/tools/perf/tests/tool_pmu.c
>>>> @@ -22,7 +22,7 @@ static int do_test(enum tool_pmu_event ev, bool =
with_pmu)
>>>> if (with_pmu)
>>>> snprintf(str, sizeof(str), "tool/%s/", tool_pmu__event_to_str(ev));
>>>> else
>>>> - strncpy(str, tool_pmu__event_to_str(ev), sizeof(str));
>>>> + snprintf(str, sizeof(str), "%s", tool_pmu__event_to_str(ev));
>>>>=20
>>>> parse_events_error__init(&err);
>>>> ret =3D parse_events(evlist, str, &err);
>>>> --
>>>> 2.43.5



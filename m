Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2B218842
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Feb 2025 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795168; cv=none; b=LMah55LnfKunQrbpLMNGtu5gdhihwivNmJmdcJcs38AjcW1TmEh587idRTdmd7Zkh1dc0PtoZgrjlh7O9bDiSnhY0035/BEJGdE4e2OqW0bR/uVcRmx1pp7Ub2AtvdEo4cixbfJT2vTouZT0U3g4z+jbx7Oifa8E9liLyQDVLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795168; c=relaxed/simple;
	bh=vwvH4KtIOYM/cLE8/DJjpq8OSxyLO+ugq1qoW/WeVsU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FYYDFMGck+Y7IktHSHWuWW9Nv/0QnBJVK/rPhkja3gnZ8/1J3Iz8pOZRhSH4nryo88FCqwyNZOHbNl3D4aO+gEAKeNzWc+NaRgo+dIZ/TQOVgx05EaS6lYxmcNDVsHvIDclyrHFqlAyNoCF6c7FZIAZSZq0HpNod7801zb3NfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i4uV4dI3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i4uV4dI3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H7WkFp025556;
	Mon, 17 Feb 2025 12:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4VKw9C
	3nSKpJ7C5bxloJo4w3wslMmJAucN4BmnqbP54=; b=i4uV4dI3s8Fmjw/CzlQYVo
	TjngvZBpbpmCnkcS4IrF5tajkdipB66h6zJSOL8WKW12G4Os7rI6ZAoWvu8yDir3
	q3xhbrK/zqIy3UQ5wFaA9jTPw7p1Z0a0nP1HylMkHQLD6X/l/nai4K1bB3CZEbeA
	X52hcXDkeTZrm5HGh07nixN6DmqMRGId1n+LWCqbvdlgfz+k2OYN1+ZtSvd3BA43
	LiZQDLpbeqUsU0/6fZ2Xg3ttUieXKrRHtWnwdLLqJHZzmej/EtzRSH+YDnBYOJ9t
	VtCO9cyESyRu0DhEqVNt4d0B/84WYeUQi25NuIvJHcQv0e5ZOf0Smumyf6cCqlmw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44v0tp1c7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 12:25:58 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51HCFxUf011215;
	Mon, 17 Feb 2025 12:25:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44v0tp1c7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 12:25:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H8U3WO003891;
	Mon, 17 Feb 2025 12:25:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u68np148-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 12:25:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51HCPrgF53674490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 12:25:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4820320043;
	Mon, 17 Feb 2025 12:25:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 556DF20040;
	Mon, 17 Feb 2025 12:25:47 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.241.34])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Feb 2025 12:25:46 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] tools/perf: Add check to tool pmu tests to ensure if the
 event is valid
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <Z61oWlOoyF0BKwYV@google.com>
Date: Mon, 17 Feb 2025 17:55:33 +0530
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BCC6464B-C112-4C00-B58D-62F4B1EB0F46@linux.ibm.com>
References: <20250212185438.15251-1-atrajeev@linux.vnet.ibm.com>
 <Z61oWlOoyF0BKwYV@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@linaro.org>
X-Mailer: Apple Mail (2.3776.700.51)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ms6mcnvRpME2DgEE77fwcaGEbwsiqXxN
X-Proofpoint-ORIG-GUID: 0hoxVe_OD-FkEb30E07nK7le8zWycRKe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170105



> On 13 Feb 2025, at 9:04=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> On Thu, Feb 13, 2025 at 12:24:38AM +0530, Athira Rajeev wrote:
>> "Tool PMU" tests fails on powerpc as below:
>>=20
>>   12.1: Parsing without PMU name:
>>   --- start ---
>>   test child forked, pid 48492
>>   Using CPUID 0x00800200
>>   Attempt to add: tool/duration_time/
>>   ..after resolving event: tool/config=3D0x1/
>>   duration_time -> tool/duration_time/
>>   Attempt to add: tool/user_time/
>>   ..after resolving event: tool/config=3D0x2/
>>   user_time -> tool/user_time/
>>   Attempt to add: tool/system_time/
>>   ..after resolving event: tool/config=3D0x3/
>>   system_time -> tool/system_time/
>>   Attempt to add: tool/has_pmem/
>>   ..after resolving event: tool/config=3D0x4/
>>   has_pmem -> tool/has_pmem/
>>   Attempt to add: tool/num_cores/
>>   ..after resolving event: tool/config=3D0x5/
>>   num_cores -> tool/num_cores/
>>   Attempt to add: tool/num_cpus/
>>   ..after resolving event: tool/config=3D0x6/
>>   num_cpus -> tool/num_cpus/
>>   Attempt to add: tool/num_cpus_online/
>>   ..after resolving event: tool/config=3D0x7/
>>   num_cpus_online -> tool/num_cpus_online/
>>   Attempt to add: tool/num_dies/
>>   ..after resolving event: tool/config=3D0x8/
>>   num_dies -> tool/num_dies/
>>   Attempt to add: tool/num_packages/
>>   ..after resolving event: tool/config=3D0x9/
>>   num_packages -> tool/num_packages/
>>=20
>>   ---- unexpected signal (11) ----
>>   12.1: Parsing without PMU name                                      =
: FAILED!
>>=20
>> Same fail is observed for "Parsing with PMU name" as well.
>>=20
>> The testcase loops through events in tool_pmu__for_each_event()
>> and access event name using "tool_pmu__event_to_str()".
>> Here tool_pmu__event_to_str returns null for "slots" event
>> and "system_tsc_freq" event. These two events are only applicable
>> for arm64 and x86 respectively. So the function =
tool_pmu__event_to_str()
>> skips for unsupported events and returns null. This null value is
>> causing testcase fail.
>>=20
>> To address this in "Tool PMU" testcase, add a helper function
>> tool_pmu__all_event_to_str() which returns the name for all
>> events mapping to the tool_pmu_event index including the
>> skipped ones. So that even if its a skipped event, the
>> helper function helps to resolve the tool_pmu_event index to
>> its mapping event name. Update the testcase to check for null event
>> names before proceeding the test.
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>=20
> Please take a look at:
> =
https://lore.kernel.org/r/20250212163859.1489916-1-james.clark@linaro.org
>=20
> Thanks,
> Namhyung

Hi,

Sure thanks for the fix James

Thomas,
Thanks for testing this patch.  But James already fixed this with a =
different patch and it is part of perf-tools-next
=
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/c=
ommit/?h=3Dperf-tools-next&id=3D615ec00b06f78912c370b372426190768402a5b9

Please test with latest perf-tools-next=20

Thanks
Athira

>=20
>> ---
>> tools/perf/tests/tool_pmu.c | 12 ++++++++++++
>> tools/perf/util/tool_pmu.c  | 17 +++++++++++++++++
>> tools/perf/util/tool_pmu.h  |  1 +
>> 3 files changed, 30 insertions(+)
>>=20
>> diff --git a/tools/perf/tests/tool_pmu.c =
b/tools/perf/tests/tool_pmu.c
>> index 187942b749b7..e468e5fb3c73 100644
>> --- a/tools/perf/tests/tool_pmu.c
>> +++ b/tools/perf/tests/tool_pmu.c
>> @@ -19,6 +19,18 @@ static int do_test(enum tool_pmu_event ev, bool =
with_pmu)
>> return TEST_FAIL;
>> }
>>=20
>> + /*
>> +  * if tool_pmu__event_to_str returns NULL, Check if the event is
>> +  * valid for the platform.
>> +  * Example:
>> +  * slots event is only on arm64.
>> +  * system_tsc_freq event is only on x86.
>> +  */
>> + if (!tool_pmu__event_to_str(ev) && =
tool_pmu__skip_event(tool_pmu__all_event_to_str(ev))) {
>> + ret =3D TEST_OK;
>> + goto out;
>> + }
>> +
>> if (with_pmu)
>> snprintf(str, sizeof(str), "tool/%s/", tool_pmu__event_to_str(ev));
>> else
>> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
>> index 3a68debe7143..572422797f6e 100644
>> --- a/tools/perf/util/tool_pmu.c
>> +++ b/tools/perf/util/tool_pmu.c
>> @@ -60,6 +60,15 @@ int tool_pmu__num_skip_events(void)
>> return num;
>> }
>>=20
>> +/*
>> + * tool_pmu__event_to_str returns only supported event names.
>> + * For events which are supposed to be skipped in the platform,
>> + * return NULL
>> + *
>> + * tool_pmu__all_event_to_str returns the name for all
>> + * events mapping to the tool_pmu_event index including the
>> + * skipped ones.
>> + */
>> const char *tool_pmu__event_to_str(enum tool_pmu_event ev)
>> {
>> if ((ev > TOOL_PMU__EVENT_NONE && ev < TOOL_PMU__EVENT_MAX) &&
>> @@ -69,6 +78,14 @@ const char *tool_pmu__event_to_str(enum =
tool_pmu_event ev)
>> return NULL;
>> }
>>=20
>> +const char *tool_pmu__all_event_to_str(enum tool_pmu_event ev)
>> +{
>> + if (ev > TOOL_PMU__EVENT_NONE && ev < TOOL_PMU__EVENT_MAX)
>> + return tool_pmu__event_names[ev];
>> +
>> + return NULL;
>> +}
>> +
>> enum tool_pmu_event tool_pmu__str_to_event(const char *str)
>> {
>> int i;
>> diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
>> index a60184859080..da76808ae71e 100644
>> --- a/tools/perf/util/tool_pmu.h
>> +++ b/tools/perf/util/tool_pmu.h
>> @@ -30,6 +30,7 @@ enum tool_pmu_event {
>> for ((ev) =3D TOOL_PMU__EVENT_DURATION_TIME; (ev) < =
TOOL_PMU__EVENT_MAX; ev++)
>>=20
>> const char *tool_pmu__event_to_str(enum tool_pmu_event ev);
>> +const char *tool_pmu__all_event_to_str(enum tool_pmu_event ev);
>> enum tool_pmu_event tool_pmu__str_to_event(const char *str);
>> bool tool_pmu__skip_event(const char *name);
>> int tool_pmu__num_skip_events(void);
>> --=20
>> 2.43.5



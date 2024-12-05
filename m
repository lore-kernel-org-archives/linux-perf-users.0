Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52F221475
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Dec 2024 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418146; cv=none; b=Kr47FbEHISW79GpLmNGvknnXi34PL1yBTeRn403ch40FhalPLxq7CBWSeYGb1KlWHOhIY3+TJioPDVc3eS5MpZPK750yZMKnNoKlJjt1Lij7Xhm0v8GgT34haHepyts3YtV/edXIY9jxonHa0rDmR+hqlURMaU4/d/8Cf6/nLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418146; c=relaxed/simple;
	bh=tPOodBjjaox/eV60N5Af15xIYf8KC4ycjii4PyRt1VE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sb/AzfPUUsFeF7LOkS1UvXjmYO+E5qTC97X2MwqIn/x9rYb8NtyuwmOW0G+ZErsMSEXzvqPoyJEAwE1dQojkcBDIuREcnqT+4zabouSg12hiiYwFUs5P20sEkzdCjKWH0qiA2eKxF5s8b8OCKMryegbdvQDIyyqJaq8ZpPvsP+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rcYpE6Nt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rcYpE6Nt"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5A0vwr028244;
	Thu, 5 Dec 2024 17:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=frwOND
	kJLaxJoiI+osa63+rM+Vm6eJIPVZMFYHSznsQ=; b=rcYpE6NtuYVqbRbg3BYLVN
	9GNCawW+KjSPKK98WXpn/HsH33zoc03NmpjFcHDv0L7EecyfiMMP7yz7jF7pGffn
	Xniw4abELS3pUJj5FCUlVNpQBCDoJ78/JnAI1+ya0mDeaq4JDv/jOdUYlW/d2bq+
	o4o8zMND+gOZHmccSnRFlegC/8nmmil7Ddk8gebldEaGygEUDDzjyZ5cE8f6raNI
	wLybcPtsF94vBguQaVwc7OZbQUbCrull2Z+Xbhvna1uMqoTu6U4pXeqzTMuifbkv
	2n8kFTn1MIMiRP2b0HIUY0uLdoSS+5MrNpnH+swQpc/ByVgeXNQl9VqMhLBSnZKQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ba1yj2e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 17:02:12 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B5GqN07009734;
	Thu, 5 Dec 2024 17:02:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ba1yj2e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 17:02:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5EiLad005580;
	Thu, 5 Dec 2024 17:02:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43a2kxsg9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 17:02:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B5H27Dm50594132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Dec 2024 17:02:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 911B220043;
	Thu,  5 Dec 2024 17:02:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A63820040;
	Thu,  5 Dec 2024 17:02:01 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.245.236])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  5 Dec 2024 17:02:01 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] tools/perf/tests/expr: Make the system_tsc_freq test only
 for intel
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Z09K5orKhWbeOGLV@google.com>
Date: Thu, 5 Dec 2024 22:30:32 +0530
Cc: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@linaro.org>, tmricht@linux.ibm.com,
        acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6BF58F8-99C2-40A4-8500-AF2E3CEB7308@linux.vnet.ibm.com>
References: <20241022140156.98854-1-atrajeev@linux.vnet.ibm.com>
 <ZyF2-XNUh38p_5Gg@google.com>
 <B72F330F-2A56-41B0-ABED-FCA7DC9EE711@linux.vnet.ibm.com>
 <CAP-5=fXCYURva6Q8ktRVmnf2QCcsr-E3fPn327k0JRCw_9fn3A@mail.gmail.com>
 <BBF1A4DC-3BD9-4377-BE2F-CBEFE55F0497@linux.vnet.ibm.com>
 <20241107135606.GA47850@e132581.arm.com>
 <0F805B2F-35CC-4E0C-BD2F-84552C4C528E@linux.vnet.ibm.com>
 <Z09K5orKhWbeOGLV@google.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: txM6-swvmW2dZw1Ge5xgj3n6iE9Yw4CM
X-Proofpoint-GUID: x75Afcoi4ov0SpggGGPeU_2wYBKCSNqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050124



> On 3 Dec 2024, at 11:46=E2=80=AFPM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> Hello,
>=20
> On Fri, Nov 08, 2024 at 10:50:10AM +0530, Athira Rajeev wrote:
>>=20
>>=20
>>> On 7 Nov 2024, at 7:26=E2=80=AFPM, Leo Yan <leo.yan@arm.com> wrote:
>>>=20
>>> Hi Athira,
>>>=20
>>> On Wed, Nov 06, 2024 at 03:04:57PM +0530, Athira Rajeev wrote:
>>>=20
>>> [...]
>>>=20
>>>>> Hi Athira,
>>>>>=20
>>>>> sorry for the breakage and thank you for the detailed explanation. =
As
>>>>> the code will run on AMD I think your change will break that - . =
It is
>>>>> probably safest to keep the ".. else { .." for this case but guard =
it
>>>>> in the ifdef.
>>>>>=20
>>>>=20
>>>> Hi Ian
>>>>=20
>>>> Thanks for your comments. Does the below change looks good ?
>>>>=20
>>>> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
>>>> index e3aa9d4fcf3a..f5b2d96bb59b 100644
>>>> --- a/tools/perf/tests/expr.c
>>>> +++ b/tools/perf/tests/expr.c
>>>> @@ -74,14 +74,12 @@ static int test__expr(struct test_suite *t =
__maybe_unused, int subtest __maybe_u
>>>>   double val, num_cpus_online, num_cpus, num_cores, num_dies, =
num_packages;
>>>>   int ret;
>>>>   struct expr_parse_ctx *ctx;
>>>> -    bool is_intel =3D false;
>>>>   char strcmp_cpuid_buf[256];
>>>>   struct perf_pmu *pmu =3D perf_pmus__find_core_pmu();
>>>>   char *cpuid =3D perf_pmu__getcpuid(pmu);
>>>>   char *escaped_cpuid1, *escaped_cpuid2;
>>>>=20
>>>>   TEST_ASSERT_VAL("get_cpuid", cpuid);
>>>> -    is_intel =3D strstr(cpuid, "Intel") !=3D NULL;
>>>>=20
>>>>   TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
>>>>=20
>>>> @@ -244,11 +242,13 @@ static int test__expr(struct test_suite *t =
__maybe_unused, int subtest __maybe_u
>>>>   if (num_dies) // Some platforms do not have CPU die support, for =
example s390
>>>>       TEST_ASSERT_VAL("#num_dies >=3D #num_packages", num_dies >=3D =
num_packages);
>>>>=20
>>>> +#if defined(__i386__) && defined(__x86_64__)
>>>>   TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, =
"#system_tsc_freq") =3D=3D 0);
>>>> -    if (is_intel)
>>>> +    if (strstr(cpuid, "Intel") !=3D NULL)
>>>>       TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
>>>>   else
>>>>       TEST_ASSERT_VAL("#system_tsc_freq =3D=3D 0", fpclassify(val) =
=3D=3D FP_ZERO);
>>>> +#endif
>>>>=20
>>>>   /*
>>>>    * Source count returns the number of events aggregating in a =
leader
>>>=20
>>> I confirmed the change above fixes the failure on Arm64.
>>>=20
>>> Tested-by: Leo Yan <leo.yan@arm.com>
>> Thanks Leo Yan for testing.
>>=20
>> Hi Ian,
>>=20
>> If the change above looks good, I will post a V2 . Please share your =
review comments
>=20
> Sorry for the delay, it looks good to me.  Can you please send the v2?

Hi Namhyung

Thanks for checking on this.
I will test with the latest version sent by Ian and respond with the =
results soon

Thanks
Athira Rajeev
>=20
> Thanks,
> Namhyung



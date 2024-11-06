Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88A1DD533
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887755; cv=none; b=XqgjsBjfvD+BY9uSthb82j6KfoVXDYA+kdFKf7mP8fNqXiE6ZrmXL/nttNS2OH0Y7oTF4dr8WWDpNcfBE4oNcAT9A/Whb+7ADP/IfnGsGWCfBZSUT/2X3WM86spjLm8MCXivSimHR1XCuoJbZR0Z1t9PitTraEulOKsa++EQG/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887755; c=relaxed/simple;
	bh=3dXOeMk4LAH/KvvmglUylkbrkJSq2uyTamPXlQ5M8sU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZZxwAsWR3QxTDXhdbQW/bjWgLEnx70moIEoP4q+ik6cmH5ge6BdbcCtpT+z6YAGAPlzw2rvKd7V1xxLvXKgCrzcMfltWUE2Nov5tKxvlLmr8luE1Yun5snOtGHs4EfDSibA7ghunKxOed2kvLQIMMuNfPQepaW5UFpVKVHqIMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KAlykOW8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KAlykOW8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A69eNHG028661;
	Wed, 6 Nov 2024 10:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uzAxsW
	9qe7LGL5fm8R1C+c+yvZP1tPYHwYmHN3cXmH8=; b=KAlykOW8xJAEvp+Sz+CbwW
	D+g+I2CeHXH85klys6MQEp0WyOWAyQw4oo4LOjZ+Up+w7YKOnGCj6XBmopj/UaDV
	wCUV2XDj3N3ATicul0IWw5m+HesOYD4Af35udkWGna57NTOoVDOREBOKfHrUHVqL
	1skxUawCkIu5O/wIViL4BRGc9knSjQYvjkYU7c5Plnespaew5rpocl8E/e5TeaRO
	6E4mQyPZOr2nAUOBBeZzc8sWOAIhTjA8/Gmyxf3fRhIy9urWNxX7tdYjMjyFCBsf
	MmrMoNLOyTgI2s2o9w1dNNDFVeLM7zO+yRu2wuKlP9vnA7kvPX+iVvlvPAWpecSQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r61a03d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 10:09:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A6A91KX019771;
	Wed, 6 Nov 2024 10:09:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r61a03d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 10:09:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A64C8ux024707;
	Wed, 6 Nov 2024 09:35:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42nxds5xqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 09:35:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A69ZLY949545682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 09:35:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1620420043;
	Wed,  6 Nov 2024 09:35:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3147920040;
	Wed,  6 Nov 2024 09:35:12 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.245.90])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Nov 2024 09:35:11 +0000 (GMT)
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
In-Reply-To: <CAP-5=fXCYURva6Q8ktRVmnf2QCcsr-E3fPn327k0JRCw_9fn3A@mail.gmail.com>
Date: Wed, 6 Nov 2024 15:04:57 +0530
Cc: Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>,
        tmricht@linux.ibm.com, acme@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        hbathini@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BBF1A4DC-3BD9-4377-BE2F-CBEFE55F0497@linux.vnet.ibm.com>
References: <20241022140156.98854-1-atrajeev@linux.vnet.ibm.com>
 <ZyF2-XNUh38p_5Gg@google.com>
 <B72F330F-2A56-41B0-ABED-FCA7DC9EE711@linux.vnet.ibm.com>
 <CAP-5=fXCYURva6Q8ktRVmnf2QCcsr-E3fPn327k0JRCw_9fn3A@mail.gmail.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vCs21PnQ_Yy-cy98M-4_ISc85Rw7ajqW
X-Proofpoint-ORIG-GUID: wh0OOK27BzqAMJwFkxzJpS0din53RmeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060082



> On 5 Nov 2024, at 2:14=E2=80=AFAM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> On Sun, Nov 3, 2024 at 8:17=E2=80=AFPM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
>>=20
>>=20
>>=20
>>> On 30 Oct 2024, at 5:29=E2=80=AFAM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>>>=20
>>> Hello,
>>>=20
>>> On Tue, Oct 22, 2024 at 07:31:56PM +0530, Athira Rajeev wrote:
>>>> The "Simple expression parser" test fails on powerpc
>>>> as below:
>>>>=20
>>>> parsing metric: #system_tsc_freq
>>>> Unrecognized literal '#system_tsc_freq'literal: #system_tsc_freq =3D =
nan
>>>> syntax error
>>>> FAILED tests/expr.c:247 #system_tsc_freq
>>>> ---- end(-1) ----
>>>> 7: Simple expression parser  : FAILED!
>>>>=20
>>>> In the test, system_tsc_freq is checked as below:
>>>>=20
>>>> if (is_intel)
>>>>   TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
>>>> else
>>>>=20
>>>> But commit 609aa2667f67 ("perf tool_pmu: Switch to standard
>>>> pmu functions and json descriptions")' changed condition in
>>>=20
>>> Probably need to put it as Fixes: tag.
>>>=20
>>>=20
>>>> tool_pmu__skip_event so that system_tsc_freq event should
>>>> only appear on x86
>>>>=20
>>>> +#if !defined(__i386__) && !defined(__x86_64__)
>>>> +       /* The system_tsc_freq event should only appear on x86. */
>>>> +       if (strcasecmp(name, "system_tsc_freq") =3D=3D 0)
>>>> +               return true;
>>>> +#endif
>>>>=20
>>>> After this commit, the testcase breaks for expr__parse of
>>>> system_tsc_freq in powerpc case. Fix the testcase to have
>>>> complete system_tsc_freq test within "is_intel" check.
>>>=20
>>> Ian, are you ok with this?
>>>=20
>>> Thanks,
>>> Namhyung
>>>=20
>>=20
>> Hi Ian
>>=20
>> If the change looks good to you, I will send a V2 with Fixes tag =
added. Please share your review comments
>>=20
>> Hi James, Thomas
>>=20
>> Looking for help to test since in non-intel platform, this test will =
fail without the patch
>=20
>=20
> Hi Athira,
>=20
> sorry for the breakage and thank you for the detailed explanation. As
> the code will run on AMD I think your change will break that - . It is
> probably safest to keep the ".. else { .." for this case but guard it
> in the ifdef.
>=20

Hi Ian

Thanks for your comments. Does the below change looks good ?

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index e3aa9d4fcf3a..f5b2d96bb59b 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -74,14 +74,12 @@ static int test__expr(struct test_suite *t =
__maybe_unused, int subtest __maybe_u
    double val, num_cpus_online, num_cpus, num_cores, num_dies, =
num_packages;
    int ret;
    struct expr_parse_ctx *ctx;
-    bool is_intel =3D false;
    char strcmp_cpuid_buf[256];
    struct perf_pmu *pmu =3D perf_pmus__find_core_pmu();
    char *cpuid =3D perf_pmu__getcpuid(pmu);
    char *escaped_cpuid1, *escaped_cpuid2;
=20
    TEST_ASSERT_VAL("get_cpuid", cpuid);
-    is_intel =3D strstr(cpuid, "Intel") !=3D NULL;
=20
    TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
=20
@@ -244,11 +242,13 @@ static int test__expr(struct test_suite *t =
__maybe_unused, int subtest __maybe_u
    if (num_dies) // Some platforms do not have CPU die support, for =
example s390
        TEST_ASSERT_VAL("#num_dies >=3D #num_packages", num_dies >=3D =
num_packages);
=20
+#if defined(__i386__) && defined(__x86_64__)
    TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, =
"#system_tsc_freq") =3D=3D 0);
-    if (is_intel)
+    if (strstr(cpuid, "Intel") !=3D NULL)
        TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
    else
        TEST_ASSERT_VAL("#system_tsc_freq =3D=3D 0", fpclassify(val) =3D=3D=
 FP_ZERO);
+#endif
=20
    /*
     * Source count returns the number of events aggregating in a leader


Thanks
Athira
> Thanks,
> Ian
>=20
>> Thanks
>> Athira
>>=20
>>>>=20
>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>>> ---
>>>> tools/perf/tests/expr.c | 7 +++----
>>>> 1 file changed, 3 insertions(+), 4 deletions(-)
>>>>=20
>>>> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
>>>> index e3aa9d4fcf3a..eb3bd68fc4ce 100644
>>>> --- a/tools/perf/tests/expr.c
>>>> +++ b/tools/perf/tests/expr.c
>>>> @@ -244,11 +244,10 @@ static int test__expr(struct test_suite *t =
__maybe_unused, int subtest __maybe_u
>>>> if (num_dies) // Some platforms do not have CPU die support, for =
example s390
>>>> TEST_ASSERT_VAL("#num_dies >=3D #num_packages", num_dies >=3D =
num_packages);
>>>>=20
>>>> - TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, =
"#system_tsc_freq") =3D=3D 0);
>>>> - if (is_intel)
>>>> + if (is_intel) {
>>>> + TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, =
"#system_tsc_freq") =3D=3D 0);
>>>> TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
>>>> - else
>>>> - TEST_ASSERT_VAL("#system_tsc_freq =3D=3D 0", fpclassify(val) =3D=3D=
 FP_ZERO);
>>>> + }
>>>>=20
>>>> /*
>>>> * Source count returns the number of events aggregating in a leader
>>>> --
>>>> 2.43.5



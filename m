Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8D224AF8
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Dec 2024 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420819; cv=none; b=T4WqguH2mzc+Jx7kgl1Qvm2Gv0kLCS8bvTKxpb6tiU11lk6geyfcokNPy/h6ex003LdV1jxmCGldQYHMqBNuHHVv4rBtrILljOfZ2HfXQPdHLNgacSZMYgXjMpjo4yH0N39Dmm/xgGF9kkFsVDXS8BhTrzCpmIOMyibKd3T8eFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420819; c=relaxed/simple;
	bh=C/p2xJRvVZ9us+tcZTn/AoPnN/k5wxiZkXpR7l25fYE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GMk54fCjJiDgJ+fVxJ5M4ATGUlux43Or2rwjpMYngGsPVXYoavGpaR522QjeBG+VPUEEMSBZam5KjyietnKoNb0ZhdnEN7gMwHT2atLTPvSzDuvAGp+yJpCyph4s4TazZpDdCXvpSUgnmoyHDQKCkTqage9L7t0A0Jh1s1fwtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DjQ8egvF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DjQ8egvF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5FesFv031219;
	Thu, 5 Dec 2024 17:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lYSYoi
	hjG2eFL1YIoKOt6+AplEmbyKBmWaTidd4eHvQ=; b=DjQ8egvFKwggmfDfF8/Xcr
	6SI+FoPAKpfLENHIvdaruT8ZL7L5LaXLTDIKraidg5kPyBd++xzFAsBaqBVFHZM0
	htrsy6L6M3/U9FrU0vqeGhmKBXCfxfEXjFdBvw8zcC8kIFiEVZT7E7xDM5O2u8gg
	N5Fky0xMdxmXy7VHXsWyxKrkKUbeDN1/reaIRTjgBY1X/hvWMZPeuZtx4fDW6+B2
	bo/59Qf7QZJuDiqsA/R6lWIai8eo6S30z2P4Hq7L/+GLaRvYHkkKWsL9inrLVXoB
	bgQZjbKrQ0GDTV37HdskPFixyxHbu9EJZnBx9kSnjyYl1jk6AdhsOshL4DBqRgRg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b6hb3hxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 17:46:48 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B5Hi6Rs025568;
	Thu, 5 Dec 2024 17:46:47 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b6hb3hxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 17:46:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5GAq9Z007467;
	Thu, 5 Dec 2024 17:46:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jtvqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 17:46:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B5HkgEf34669168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Dec 2024 17:46:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6963420043;
	Thu,  5 Dec 2024 17:46:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7F3A20040;
	Thu,  5 Dec 2024 17:46:36 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.245.236])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  5 Dec 2024 17:46:36 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] tools/perf/tests/base_probe: Fix check for the count of
 existing probes in test_adding_kernel
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <1da9544-1e17-3830-49f9-6a6d78439e71@redhat.com>
Date: Thu, 5 Dec 2024 23:16:23 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        hbathini@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A1D31B9-6555-4550-BB8F-171402C6D88A@linux.vnet.ibm.com>
References: <20241014153910.85536-1-atrajeev@linux.vnet.ibm.com>
 <941c3d6a-fc2-3fcf-5ab2-597dcf712c16@redhat.com>
 <0FEA83FD-BBC9-4E83-82D6-044141E86F76@linux.vnet.ibm.com>
 <1da9544-1e17-3830-49f9-6a6d78439e71@redhat.com>
To: Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l7XD6oizhTv72z-fWJmvemkVeWFZXl3o
X-Proofpoint-GUID: TLi-ki336M_jxNZCz-7B6k28BOdSNTWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050128



> On 14 Nov 2024, at 3:35=E2=80=AFPM, Michael Petlan =
<mpetlan@redhat.com> wrote:
>=20
> On Sun, 3 Nov 2024, Athira Rajeev wrote:
>>> On 17 Oct 2024, at 3:44=E2=80=AFPM, Michael Petlan =
<mpetlan@redhat.com> wrote:
>>>=20
>>> On Mon, 14 Oct 2024, Athira Rajeev wrote:
> [...]
>>>=20
>>> I am wondering how it could happen that there were other
>>> probes in the system?
>>=20
>> Hi Michael,
>>=20
> Hello Athira.
>=20
>> Sorry for the late response.
>>=20
>> Yes, there are uprobes listed as part of =E2=80=9Cperf probe=E2=80=9D =
in the environment where I saw the test needing this change. Sharing the =
result below from perf probe:=20
>>=20
>> # ./perf probe -l
>>  uprobes:p_uprobe_dns_events_osquery4026531841 (on getaddrinfo in XX)
>>  uprobes:p_uprobe_dns_events_osquery4026532336 (on 0x129a60 in XX)
>>  uprobes:p_uprobe_dns_events_osquery4026532344 (on 0x129a60 in XX)
>>  uprobes:p_uprobe_ebpf_compat_check_osquery (on __GI___backtrace in =
XX)
>>  uprobes:p_uprobe_sys_hook_osquery (on backtrace_symbols in XX)
>>=20
>> These can=E2=80=99t be removed.
>>=20
>> # ./perf probe -d uprobes:p_uprobe_dns_events_osquery4026531841
>> Removed event: uprobes:p_uprobe_dns_events_osquery4026531841
>> Failed to delete event: Device or resource busy
>>  Error: Failed to delete events.
>>=20
>=20
> Ah, this is interesting, I have never hit that. However, it makes =
sense,
> if the resource is busy.
>=20
> However, in that case it comes to my mind that in general, these tests
> should not be run in any production environment, where one could rely =
on
> some probes will exist, etc. In case some of the probes above was not
> busy, it'd be probably cleaned up by the testcase, which might be =
unexpected
> by the creator/user of the uprobes... Maybe we should get rid of the
> probe cleaning for that cases, but I'd prefer to keep it.
>=20
>> Considering above scenario, patch here takes the probe count using:
>> NO_OF_PROBES=3D`$CMD_PERF probe -l $TEST_PROBE| wc -l`
>>=20
>> Also similarly looks for TEST_PROBE in result log in case of probe =
=E2=80=94del as well
>>=20
>> Any comments Michael ?
>>=20
> Yes, we probably should tweak it as you suggest.

Hi,

Thanks for checking Michael.

If the patch looks good, can we please get this pulled in ?

Thanks
Athira
>=20
> Thanks,
> Michael
>=20
>=20
>> Thanks
>> Athira
>>=20
>>>=20
>>> Cheers,
>>>=20
>>> Michael
>>>=20
>>>>=20
>>>> Example, in the system where this failed, already some
>>>> probes were default added. So count became 10
>>>> ./perf probe -l | wc -l
>>>> 10
>>>>=20
>>>> So to be specific for "inode_permission", restrict the
>>>> probe count check to that probe point alone using :
>>>> NO_OF_PROBES=3D`$CMD_PERF probe -l $TEST_PROBE| wc -l`
>>>>=20
>>>> Similarly while removing the probe using "probe --del *",
>>>> ( removing all probes ), check uses:
>>>>=20
>>>> ../common/check_all_lines_matched.pl "Removed event: =
probe:$TEST_PROBE"
>>>>=20
>>>> But if there are other probes in the system, the log will
>>>> contain reference to other existing probe too. Hence change
>>>> usage of check_all_lines_matched.pl to check_all_patterns_found.pl
>>>> This will make sure expecting string comes in the result
>>>>=20
>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>>> ---
>>>> tools/perf/tests/shell/base_probe/test_adding_kernel.sh | 4 ++--
>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git =
a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh =
b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
>>>> index d541ffd44a93..f8b5f096d0d7 100755
>>>> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
>>>> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
>>>> @@ -169,7 +169,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE =
"force-adding probes :: second pr
>>>> (( TEST_RESULT +=3D $? ))
>>>>=20
>>>> # adding existing probe with '--force' should pass
>>>> -NO_OF_PROBES=3D`$CMD_PERF probe -l | wc -l`
>>>> +NO_OF_PROBES=3D`$CMD_PERF probe -l $TEST_PROBE| wc -l`
>>>> $CMD_PERF probe --force --add $TEST_PROBE 2> =
$LOGS_DIR/adding_kernel_forceadd_03.err
>>>> PERF_EXIT_CODE=3D$?
>>>>=20
>>>> @@ -205,7 +205,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE =
"using doubled probe"
>>>> $CMD_PERF probe --del \* 2> =
$LOGS_DIR/adding_kernel_removing_wildcard.err
>>>> PERF_EXIT_CODE=3D$?
>>>>=20
>>>> -../common/check_all_lines_matched.pl "Removed event: =
probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < =
$LOGS_DIR/adding_kernel_removing_wildcard.err
>>>> +../common/check_all_patterns_found.pl "Removed event: =
probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < =
$LOGS_DIR/adding_kernel_removing_wildcard.err
>>>> CHECK_EXIT_CODE=3D$?
>>>>=20
>>>> print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "removing multiple =
probes"
>>>> --=20
>>>> 2.43.5
>>=20
>>=20


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0A2EB86A
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920541; cv=none; b=f924OuJof2oGlcQTlUti7HqklV3lz6MRsmkbiFpjhwEJ+YcmbwjFySIjH25zF29r4s6z8DJJFD8JMDnGsR9kiHpEL1Y5UvhpoGUaQt5A8T3EffOxHIo7OVQIuHDX7EqG8mNinQwHEcOr1E1oTpxDIbDMmD5l3qzj7y8fMi3lanU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920541; c=relaxed/simple;
	bh=ImCQ6d2lDlUWoNtKuxUNsT6PKMAZ4bZVEydtzfEcfF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uo5Q9k4pjvbBHLRamIunHDPH2O4G6nBFV8DxjdHPW7Qys+tTZPSeFkovfNN5Yx9fcxh2X7YcxghkwrtH49h7cC+Dj47WofdIiAT1byjDFb1zBJEE2uNoD53sG77TcqufB1GKHDi8Yii168UFA/OR5sr65n1gOUoH70DH/Ege2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mA1qz7yj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mA1qz7yj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5983RTSo013268;
	Wed, 8 Oct 2025 10:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ToRaCL
	6EYUxB23El/lZOss43SWjhCUyjwz5ysCsoy78=; b=mA1qz7yjWXv9Q+ewo6z2yq
	gKgdCfuJKzJcZYDBULL1zHoX7NBtzf0Fwq+HuyBidkxlDI0VaxquXxh+aylTRVYH
	W8qALdbcE2j8I6w7XdXrN0e9Eu2nkyKGX4nMI828u/36aPY0ZZrEmifo85z8Ru+e
	JEyoRLEVJR98PPRaIc4m02AdcMAxG0jCCbl0hdg5Aw7Eh+vy5lYsOxaKaq73TbQQ
	7rh/F5kxM8/eFJWxkZ9YE0izKQyxVBXw7PpSmaSVIr1dc0xb7LxVauhB13nBJlpp
	jDyAd6U6M+lSstmRhXApwd1E7TWLTWAAufsgHDks3p5o1MDjUOkiOUUZwHMJN/6g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0pkxc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 10:48:44 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 598AfnKt003388;
	Wed, 8 Oct 2025 10:48:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0pkxby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 10:48:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5987RLGq021218;
	Wed, 8 Oct 2025 10:48:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kgm1frgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 10:48:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 598AmfPW40435996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 10:48:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CD4120043;
	Wed,  8 Oct 2025 10:48:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C68A2005A;
	Wed,  8 Oct 2025 10:48:41 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Oct 2025 10:48:41 +0000 (GMT)
Message-ID: <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com>
Date: Wed, 8 Oct 2025 12:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: James Clark <james.clark@linaro.org>, Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        dapeng1.mi@linux.intel.com
References: <20251001195047.541745-2-ashelat@redhat.com>
 <906a9e47-ec19-4897-bbc0-06101d7afd24@linux.ibm.com>
 <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
 <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XvT3+FF9 c=1 sm=1 tr=0 ts=68e6418c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=jG6JC8piQt_4cliN:21 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=_YuDahbZGq4wDAqHexcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: CPMU_1_m3AqChhlXDX7DZrdI_8X_N9yg
X-Proofpoint-GUID: 6OSi62SFxxgBwKUewt__XTEVK45t9hXY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwOSBTYWx0ZWRfX3/rNaCfUCsw5
 0uChvzYROY/w4llIAnv0kCgUjrvrfOOG0e1wL5p+7GY9yxN+RSiimgGLc45BcCUK7DmvigSwr3I
 /K7k9XWEC1zawyop2ln9a325QEmq+bq3m693jC7rEheTkeoYoi0oG9vc/J8Odnv/JYjHEZh/zzr
 UCOPJJPKvD/Lisd0yKpcqMjsJ3qDkRSi1whXtwUEz/GkJLtwxcUZdT8VKZtU80v6Idpob0IPagp
 vBjpNFWO1+Zb/r855/NpVNiwD14UsziLM02ai9nZLU3/Q0m3RUVL2fmuszzo593Iqx03sL6oNag
 zh4E2o8dUtmtG2YMPcw6cEOLzNjDn/DX8iErYuIM3PllUiik2OebxTt9Z8ttux3ZKBxpnGl+i7L
 8YJP8MgJzgPIvCF/et7CHyfz0jY/5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040009

On 10/7/25 14:34, James Clark wrote:
> 
> 
> On 07/10/2025 6:47 am, Thomas Richter wrote:
>> On 10/2/25 15:39, Anubhav Shelat wrote:
>>> On Oct 1, 2025 at 9:44 PM, Ian Rogers wrote:
>>>> If cycles is 0 then this will always pass, should this be checking a
>>> range?
>>>
>>> Yes you're right this will be better.
>>>
>>> On Oct 2, 2025 at 7:56 AM, Thomas Richter wrote:
>>>> Can we use a larger range to allow the test to pass?
>>>
>>> What range do you get on s390? When I do group measurements using "perf
>>> record -e "{cycles,cycles}:Su" perf test -w brstack" like in the test I
>>> always get somewhere between 20 and 50 cycles difference. I haven't tested
>>> on s390x, but I see no cycle count difference when testing the same command
>>> on x86. I have observed much larger, more varied differences when using
>>> software events.
>>>
>>> Anubhav
>>>
>>
>> Here is the output of the
>>
>>   # perf record  -e "{cycles,cycles}:Su" -- ./perf test -w brstack
>>   # perf script | grep brstack
>>
>> commands:
>>
>> perf 1110782 426394.696874:    6885000 cycles:           116fc9e brstack_bench+0xae (/r>
>> perf 1110782 426394.696875:    1377000 cycles:           116fb98 brstack_foo+0x0 (/root>
>> perf 1110782 426394.696877:    1377000 cycles:           116fb48 brstack_bar+0x0 (/root>
>> perf 1110782 426394.696878:    1377000 cycles:           116fc94 brstack_bench+0xa4 (/r>
>> perf 1110782 426394.696880:    1377000 cycles:           116fc84 brstack_bench+0x94 (/r>
>> perf 1110782 426394.696881:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>> perf 1110782 426394.696883:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>> perf 1110782 426394.696884:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>> perf 1110782 426394.696885:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>> perf 1110782 426394.696887:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>> perf 1110782 426394.696888:    1377000 cycles:           116fc98 brstack_bench+0xa8 (/r>
>> perf 1110782 426394.696890:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>> perf 1110782 426394.696891:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
>> perf 1110782 426394.703542:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>> perf 1110782 426394.703542:   30971975 cycles:           116fb7c brstack_bar+0x34 (/roo>
>> perf 1110782 426394.703543:    1377000 cycles:           116fc76 brstack_bench+0x86 (/r>
>> perf 1110782 426394.703545:    1377000 cycles:           116fc06 brstack_bench+0x16 (/r>
>> perf 1110782 426394.703546:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
>> perf 1110782 426394.703547:    1377000 cycles:           116fc20 brstack_bench+0x30 (/r>
>> perf 1110782 426394.703549:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
>> perf 1110782 426394.703550:    1377000 cycles:           116fcbc brstack_bench+0xcc
>>
>> They are usual identical values beside one or two which are way off. Ignoring those would
>> be good.
>>
> 
> FWIW I ran 100+ iterations my Arm Juno and N1SDP boards and the test passed every time.
> 
> Are we sure there isn't some kind of race condition or bug that the test has found? Rather than a bug in the test?
There is always a possibility of a bug, that can not be ruled out for certain.
However as LPARs on s390 run on top of a hypervisor, there is a chance for the 
linux guest being stopped while hardware keeps running.

I see these runoff values time and again, roughly every second run fails with
one runoff value

Hope this helps

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

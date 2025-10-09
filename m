Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C92D7814
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012104; cv=none; b=G+rPfIdcDn52BRPWxv9yPRiAzgS2ugIaznvQINSUM6F0NTOVJgzdiW6JTsACppn5V3BJ880ozp5Xm69hQepzJb+vvpF8BB7zPHs4t0coISdw+DcaOc5eR3Eym5yNAtbTjqzfAgR1hnAc4clsy36xv35woAoUuh/xDeupiF+5gxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012104; c=relaxed/simple;
	bh=INhyPE0RCkvkQ6onPPmGgKKr+zvC7FdUqWRaosHi+qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9JZv8CZ5FSaoqdluAZov2XT02RX+phg5QJ+zx3TaefusXOtXAzMB0JFqvbg5Ek4re4S4HlOOaXb59IPOyjohiFFSTYBpnrc6W+S0j6HDAOpFy4lAe8lwI6GpsdVUmoEpVeJrwsx/lVarsBYbkWHv5ErbkiOXg54A3sco/ZLCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PGz4olvs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PGz4olvs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5994eugH031175;
	Thu, 9 Oct 2025 12:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tKD+Vu
	vA1D73jcFIUT9y2/gJd+XQMhFcVokPJXE+qrs=; b=PGz4olvsc2sIafOCoGKFUF
	o+/qtiCg9NFwgHwLFJITE9pzQDfUV+UznD+NQb+fR8cFUWEtthN6wqnEk47gblFE
	Lj0matNEMyZR9P0RkVPqhjzbfnyYeS/kmgC799LT9gPPHim6bN+Wa1KZmJzg/ISf
	C270WT7u58BVGG5TM8wOa7smCynE95lYVgK1P3kFa/bdgsBrZhgVQHGibb6sjchw
	y1jnWP3qHTdmrS/vRAJ4NCDS4IlM/y+pBaeUINacwqkczW7LS6nDGP5OEi+h3hep
	o88dbLAwQEqSIsja9y4TDgLZlW4ELLR/KNjiVS/i8wpyW0Nz9uZo+g+0Lyk7a2lg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81mh1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 12:14:47 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 599CDS87031911;
	Thu, 9 Oct 2025 12:14:46 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81mh1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 12:14:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 599CAtj4026053;
	Thu, 9 Oct 2025 12:14:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvammcxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 12:14:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599CEiWH33817042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 12:14:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1916E200EF;
	Thu,  9 Oct 2025 12:14:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3266200EE;
	Thu,  9 Oct 2025 12:14:43 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 12:14:43 +0000 (GMT)
Message-ID: <7447666a-4af2-4565-b008-54a9fd40a2bf@linux.ibm.com>
Date: Thu, 9 Oct 2025 14:14:43 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: James Clark <james.clark@linaro.org>, Anubhav Shelat
 <ashelat@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc: mpetlan@redhat.com, acme@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        dapeng1.mi@linux.intel.com
References: <20251001195047.541745-2-ashelat@redhat.com>
 <906a9e47-ec19-4897-bbc0-06101d7afd24@linux.ibm.com>
 <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
 <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
 <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com>
 <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RBm2z0SMwQ6axp5s0V2ea1Kr0Pt6RP0K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9fA0rI6bvBlm
 x502ISu3EiF0upNz+4NCVZJarsjWYScU6+/iCEuZcBrUNYDOexMd3ZEYuI+x2Di6TnKWC5OMNKM
 KSoWrOJSLWQ4WWItjvQXo7Q57g4PI3ZzAfRnMbI7zUgis9T3qusEpr47bz9U1ZBabjsK0iyp5pW
 cA3P8k67VaSaDn2BhyMtY9+eFJohf7/7rk9XvK4khfK2wYJG5jEhyhpMw2ogiW7rPNKHnJE+wae
 Pows5NmCV0Upym8ZlatYy+7kVMaBN47n4kV2P6qWIEXUc6Lr9PNgTn9hfZQd/UDVMX6UqCEAdD1
 Fkm74KHnTefWabnAdD4Q6apgKiBj6t3HoMlWqLklPP85RUXWqfZZglUHZcra8Vc5zPh4/A8LRDg
 ZVtPXb4KO+g5H49EQabz+uI6Ghchxg==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e7a737 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=jG6JC8piQt_4cliN:21 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=yloKFQ5gKZcikTTLyzgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: HtFC3wef9GsP_CA5gnScm6_qYqL8ud_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/8/25 13:24, James Clark wrote:
> 
> 
> On 08/10/2025 11:48 am, Thomas Richter wrote:
>> On 10/7/25 14:34, James Clark wrote:
>>>
>>>
>>> On 07/10/2025 6:47 am, Thomas Richter wrote:
>>>> On 10/2/25 15:39, Anubhav Shelat wrote:
>>>>> On Oct 1, 2025 at 9:44 PM, Ian Rogers wrote:
>>>>>> If cycles is 0 then this will always pass, should this be checking a
>>>>> range?
>>>>>
>>>>> Yes you're right this will be better.
>>>>>
>>>>> On Oct 2, 2025 at 7:56 AM, Thomas Richter wrote:
>>>>>> Can we use a larger range to allow the test to pass?
>>>>>
>>>>> What range do you get on s390? When I do group measurements using "perf
>>>>> record -e "{cycles,cycles}:Su" perf test -w brstack" like in the test I
>>>>> always get somewhere between 20 and 50 cycles difference. I haven't tested
>>>>> on s390x, but I see no cycle count difference when testing the same command
>>>>> on x86. I have observed much larger, more varied differences when using
>>>>> software events.
>>>>>
>>>>> Anubhav
>>>>>
>>>>
>>>> Here is the output of the
>>>>
>>>>    # perf record  -e "{cycles,cycles}:Su" -- ./perf test -w brstack
>>>>    # perf script | grep brstack
>>>>
>>>> commands:
>>>>
>>>> perf 1110782 426394.696874:    6885000 cycles:           116fc9e brstack_bench+0xae (/r>
>>>> perf 1110782 426394.696875:    1377000 cycles:           116fb98 brstack_foo+0x0 (/root>
>>>> perf 1110782 426394.696877:    1377000 cycles:           116fb48 brstack_bar+0x0 (/root>
>>>> perf 1110782 426394.696878:    1377000 cycles:           116fc94 brstack_bench+0xa4 (/r>
>>>> perf 1110782 426394.696880:    1377000 cycles:           116fc84 brstack_bench+0x94 (/r>
>>>> perf 1110782 426394.696881:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>> perf 1110782 426394.696883:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>> perf 1110782 426394.696884:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>> perf 1110782 426394.696885:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>> perf 1110782 426394.696887:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>> perf 1110782 426394.696888:    1377000 cycles:           116fc98 brstack_bench+0xa8 (/r>
>>>> perf 1110782 426394.696890:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>> perf 1110782 426394.696891:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
>>>> perf 1110782 426394.703542:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>> perf 1110782 426394.703542:   30971975 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>>> perf 1110782 426394.703543:    1377000 cycles:           116fc76 brstack_bench+0x86 (/r>
>>>> perf 1110782 426394.703545:    1377000 cycles:           116fc06 brstack_bench+0x16 (/r>
>>>> perf 1110782 426394.703546:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
>>>> perf 1110782 426394.703547:    1377000 cycles:           116fc20 brstack_bench+0x30 (/r>
>>>> perf 1110782 426394.703549:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
>>>> perf 1110782 426394.703550:    1377000 cycles:           116fcbc brstack_bench+0xcc
>>>>
>>>> They are usual identical values beside one or two which are way off. Ignoring those would
>>>> be good.
>>>>
>>>
>>> FWIW I ran 100+ iterations my Arm Juno and N1SDP boards and the test passed every time.
>>>
>>> Are we sure there isn't some kind of race condition or bug that the test has found? Rather than a bug in the test?
>> There is always a possibility of a bug, that can not be ruled out for certain.
>> However as LPARs on s390 run on top of a hypervisor, there is a chance for the
>> linux guest being stopped while hardware keeps running.
>>
> 
> I have no idea what's going on or how that works, so maybe this question is useless, but doesn't that mean that guests can determine/guess the counter values from other guests? If the hardware keeps the counter running when the guest isn't, that sounds like something is leaking from one guest to another? Should the hypervisor not be saving and restoring context?

I have not enough knowledge myself to answer that. But I try to find out.
However I guess that the hypervisor saves and restores context in term of other guests.
Maybe the hypervisor does some work on behalf of the currently running guest?
I'll start digging...

> 
>> I see these runoff values time and again, roughly every second run fails with
>> one runoff value
>>
>> Hope this helps
>>
> 
> That may explain the issue for s390 then, but I'm assuming it doesn't explain the issues on Arm if the failures there aren't in a VM. But even if they were in a VM, the PMU is fully virtualised and the events would be stopped and resumed when the guest is switched out.
> 
> James
> 
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

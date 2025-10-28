Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9592F5A2E
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656169; cv=none; b=vCKjEZHZjTwyLnbsoQDvDhm/9rO1+BS+QhItQxJzxqAqbaWfa6i+gCDzF4xtq/jXviHHOhUTh8k0DSieRUJVyYRv7WhXFIO9ayYzHxe7m6EYxuCO+DWIN8qvmdpCwz7+emuYWI3Xcx8AXLv38U6duRLjd/pSVBIsY/oQJGxxjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656169; c=relaxed/simple;
	bh=ONjoRTLOT2jgiD5fcVP3ZC364SmC72ppHMJiHD9zbz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gm8/qggfW6GCMVWL4BtBqO9eYAyWWoRd3O3+cLOH9y00KsQSBqxNGwLXNsJNDRHafh0HX8iMkWsMcmYtAqY741t5hb4wVQnvFhcj3fDABMs7qZ4Mq/cRdBcojV86WaLAOjGzldMjpcDv2ZwVdBD+ZfqgeEpesU/cewJMesRtpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BKYGsqZs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BKYGsqZs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S1jwBg012355;
	Tue, 28 Oct 2025 12:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Mln2P+
	U7VbcKhSH1gw1mdaMoJlNQuF71hk7VEKFng1A=; b=BKYGsqZs0fHNIxd+S98k1F
	mmmje3kUaoo5tkZ3j5JKbSisJOG6c3HRz7mgn8kRz5EAUl7lJ1ZKlLjsVgDpwFnT
	8piLAFHjAAAisBRbuMYRc4BVBzQ/7tZJkMKbD8kEuPupxw+5mGrLwCTbdz/RBVHV
	GkBjaKnzSmq9kg1bn3k0xGa3MKJxYDvwIPsESJlG/RCGZZr7PTCyS6Obx3PZJD8Z
	0qkgF4PffodJTaL1VHVvq6AmTgQNjhPlbunS2uDopNriPXEPzRc3Wy/Y2zEwqbjS
	2iSwoOXQI/gCSxQ4Wa70j+w5G0ZfMUGKVqDuI3YK0dikKlPgdkPkZo8j09F83cFQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81uyem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 12:55:51 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59SCPhwp003533;
	Tue, 28 Oct 2025 12:55:50 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81uyeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 12:55:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBdDrN022022;
	Tue, 28 Oct 2025 12:55:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a18vs2vpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 12:55:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59SCtm2g44040522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 12:55:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB68220043;
	Tue, 28 Oct 2025 12:55:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 922A420040;
	Tue, 28 Oct 2025 12:55:47 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 12:55:47 +0000 (GMT)
Message-ID: <2e756e75-7dc9-4838-8651-ca1a0f056966@linux.ibm.com>
Date: Tue, 28 Oct 2025 13:55:47 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "perf test: Allow tolerance for leader sampling
 test"
To: James Clark <james.clark@linaro.org>, Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        dapeng1.mi@linux.intel.com
References: <20251023132406.78359-2-ashelat@redhat.com>
 <5b02372a-f0be-4d3a-a875-c5ea65f2bafe@linux.ibm.com>
 <CA+G8Dh+DaVp1XVHm=Hh1aLP=5YOmChTRu4=nSUAwTKJO-a4LDw@mail.gmail.com>
 <f674d1eb-c492-4dec-a49c-8b40833741a4@linaro.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <f674d1eb-c492-4dec-a49c-8b40833741a4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=6900bd57 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=-Cr7v3R9RP6f0URDjZ8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: IVOTnQ1zlCicHdV9VyR433iTy1K6lwdV
X-Proofpoint-GUID: mBnVcu1Q3egBtfgjqo8TbpxNfI6_CzM6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX/MSQnC4X9FMm
 evwUVCKBZyH3aYYqQEr49oWx/MopD8h+0aoxNpKQrd4+jNFGEJ/05DVRDbJK1UbuKLBC7JA+GuF
 g1J4CseWb2w5Fw4HLjsGThGeuLJgd9qXU8+K2whrh3h+MPLOdDHeFWZeoJC7iuwFCbXgd74Ox8x
 14FQFLQh1lkEiO+0xdv0KDXIncIerVy7vEOFQcTOXz5R6I8R7GY0RZTYEiFECxTN/i/AS7D1AtG
 YVMjYAXco1I6Nasm6+lAhSsxvQneF0SiZpDj6btARa30pd4J5qLtN2mh5VUBqhgbqRSomzQ8j7N
 Tjn8mhjYu6ogZVquwWhQE5adkeWsm1c2O6CCja648l76Lj7An4dmSdKZAsw7Kis4gI9lpVwJgOW
 AjHJtq7FXbMRMz0oMfu3fs+o3JnIIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024

On 10/28/25 12:30, James Clark wrote:
> 
> 
> On 24/10/2025 6:21 pm, Anubhav Shelat wrote:
>> The issue on arm is similar. Failing about half the time, with 1
>> failing case. So maybe the same issue on arm.
>>
>> Anubhav
>>
> 
> You mentioned on the other thread that it's failing "differently", can you expand on that? I'm wondering why you sent the revert patch then?
> 
> As I mentioned before I'm not seeing any issues. Can you share the kernel version that you tested on and your kernel config? And can you share the same outputs that I asked Thomas for below please.
> 
>> On Fri, Oct 24, 2025 at 9:40 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>
>>> On 10/23/25 15:24, Anubhav Shelat wrote:
>>>> This reverts commit 1c5721ca89a1c8ae71082d3a102b39fd1ec0a205.
>>>>
>>>> The throttling bug has been fixed in 9734e25fbf5a perf: Fix the throttle
>>>> logic for a group. So this commit can be reverted.
>>>>
>>>> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
>>>> ---
>>>>   tools/perf/tests/shell/record.sh | 33 ++++++--------------------------
>>>>   1 file changed, 6 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>>>> index 0f5841c479e7..13e0d6ef66c9 100755
>>>> --- a/tools/perf/tests/shell/record.sh
>>>> +++ b/tools/perf/tests/shell/record.sh
>>>> @@ -267,43 +267,22 @@ test_leader_sampling() {
>>>>       err=1
>>>>       return
>>>>     fi
>>>> -  perf script -i "${perfdata}" | grep brstack > $script_output
>>>> -  # Check if the two instruction counts are equal in each record.
>>>> -  # However, the throttling code doesn't consider event grouping. During throttling, only the
>>>> -  # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
>>>> -  # let's set the tolerance rate to 80%.
>>>> -  # TODO: Revert the code for tolerance once the throttling mechanism is fixed.
>>>>     index=0
>>>> -  valid_counts=0
>>>> -  invalid_counts=0
>>>> -  tolerance_rate=0.8
>>>> +  perf script -i "${perfdata}" | grep brstack > "${script_output}"
>>>>     while IFS= read -r line
>>>>     do
>>>> +    # Check if the two instruction counts are equal in each record
>>>>       cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
>>>>       if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
>>>>       then
>>>> -      invalid_counts=$(($invalid_counts+1))
>>>> -    else
>>>> -      valid_counts=$(($valid_counts+1))
>>>> +      echo "Leader sampling [Failed inconsistent cycles count]"
>>>> +      err=1
>>>> +      return
>>>>       fi
>>>>       index=$(($index+1))
>>>>       prev_cycles=$cycles
>>>>     done < "${script_output}"
>>>> -  total_counts=$(bc <<< "$invalid_counts+$valid_counts")
>>>> -  if (( $(bc <<< "$total_counts <= 0") ))
>>>> -  then
>>>> -    echo "Leader sampling [No sample generated]"
>>>> -    err=1
>>>> -    return
>>>> -  fi
>>>> -  isok=$(bc <<< "scale=2; if (($invalid_counts/$total_counts) < (1-$tolerance_rate)) { 0 } else { 1 };")
>>>> -  if [ $isok -eq 1 ]
>>>> -  then
>>>> -     echo "Leader sampling [Failed inconsistent cycles count]"
>>>> -     err=1
>>>> -  else
>>>> -    echo "Basic leader sampling test [Success]"
>>>> -  fi
>>>> +  echo "Basic leader sampling test [Success]"
>>>>   }
>>>>
>>>>   test_topdown_leader_sampling() {
>>>
>>> I disagree here. Reverting this patch cause the test case to fail very often on s390.
>>> The test fails about every 2nd run, because the is one run-away value out of many.
>>> Here is an example:
> 
> I suppose that depends on what the reason for the failure is. I don't think we've gotten to the bottom of that yet. It's ok to have a test failure if the actual behaviour doesn't match the intented behaviour.
> 
> At the moment it looks like we're trying to hide some defect with a tolerance value. This makes the test less useful, and it also wastes developer time when the tolerance value will inevitably be increased and increased with more and more investigations until it tests nothing. Not having any tolerance to begin with will make this less likely to happen.
> 
>>>
>>> # ./perf record -e "{cycles,cycles}:Su" -- perf test -w brstack
>>> [ perf record: Woken up 2 times to write data ]
>>> [ perf record: Captured and wrote 0.015 MB perf.data (74 samples) ]
>>> [root@b83lp65 perf]# perf script | grep brstack
>>>              perf  136408 340637.903395:    1377000 cycles:           1171606 brstack_foo+0x1e (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.903396:    1377000 cycles:           1171664 brstack_bench+0x24 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.903396:    1377000 cycles:           11716d4 brstack_bench+0x94 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.903397:    1377000 cycles:           11716d4 brstack_bench+0x94 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.903398:    1377000 cycles:           11716e8 brstack_bench+0xa8 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.903398:    1377000 cycles:           1171606 brstack_foo+0x1e (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.903399:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910844:    1377000 cycles:           11716e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910844:   39843371 cycles:           11716e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910845:    1377000 cycles:           1171632 brstack_foo+0x4a (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910846:    1377000 cycles:           1171692 brstack_bench+0x52 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910847:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910847:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910848:    1377000 cycles:           1171598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910848:    1377000 cycles:           11715e8 brstack_foo+0x0 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910849:    1377000 cycles:           11717ae brstack+0x86 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910850:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910850:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910851:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910851:    1377000 cycles:           117159e brstack_bar+0x6 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910852:    1377000 cycles:           1171598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910853:    1377000 cycles:           117179e brstack+0x76 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910853:    1377000 cycles:           1171606 brstack_foo+0x1e (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910854:    1377000 cycles:           11716d4 brstack_bench+0x94 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910855:    1377000 cycles:           1171612 brstack_foo+0x2a (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910855:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910856:    1377000 cycles:           1171598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910856:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>>              perf  136408 340637.910857:    1377000 cycles:           1171632 brstack_foo+0x4a (/root/linux/tools/perf/perf)
>>> .... many more lines with identical cycles value.
>>>
>>> I have contacted our hardware/firmware team, but have not gotten a response back.
>>> I still think this has to do with s390 LPAR running under hyperviser control and I do not know what
>>> happens when the hipervisor kicks in.
>>>
>>> I agree with James Clark that this should be handled transperently by the hipervisor, that means
>>> stopping the LPAR should stop the CPU measurement unit, before giving control to a different lpar.
>>>
>>> But what happens when the hipervisor just kicks in and returns to the same LPAR again? Or does
>>> some admin work on behalf of this LPAR. As long as I can not answer this question, I would like
>>> to keep some ratio to handle run-away values.
>>>
>>> As said before, this happens in roughly 50% of the runs...
>>>
>>> Here is a run where the test succeeds without a run-away value:
>>>
>>> # ./perf record -e "{cycles,cycles}:Su" -- perf test -w brstack
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 0.015 MB perf.data (70 samples) ]
>>> # perf script | grep brstack
>>>              perf  136455 341212.430466:    1377000 cycles:           117159e brstack_bar+0x6 (/root/linux/tools/perf/perf)
>>>              perf  136455 341212.430467:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>>              perf  136455 341212.430468:    1377000 cycles:           1171612 brstack_foo+0x2a (/root/linux/tools/perf/perf)
>>>              perf  136455 341212.430468:    1377000 cycles:           1171656 brstack_bench+0x16 (/root/linux/tools/perf/perf)
> 
> I'm a bit confused how the instruction pointers and timestamps are different. Shouldn't the counters be part of a single sample?
> 

Two diffenrent runs on the same machine. The different addresses are most likely from different load addresses of the
libraries and executables.

> Which kernel version is this exactly?
The kernel was built last night from our build machine. It is
# uname -a
Linux b83lp69.lnxne.boe 6.18.0-20251027.rc3.git2.fd57572253bc.63.fc42.s390x+git #1 SMP Mon Oct 27 20:06:12 CET 2025 s390x GNU/Linux

So latest kernel code from upstream

> 
> Can you skip the grep, we only care about the samples and not what process it happened to be in so that might be hiding something. And can you share the raw dump of a sample (perf report -D). One sample that has the matching counts and one that doesn't.
> 
> Mine look like this, although I can't share one that doesn't match because I can't reproduce it:
> 
> 0 1381669508860 0x24b20 [0x70]: PERF_RECORD_SAMPLE(IP, 0x2): 1136/1136: 0xaaaac8f51588 period: 414710 addr: 0
> ... sample_read:
> .... group nr 2
> ..... id 0000000000000336, value 00000000000f38f0, lost 0
> ..... id 0000000000000337, value 00000000000f38f0, lost 0
>  ... thread: stress:1136
>  ...... dso: /usr/bin/stress
>  ... thread: stress:1136
>  ...... dso: /usr/bin/stress
> 
> 
When I skip the grep it actually gets worse, there re more run away values:
# perf record -e "{cycles,cycles}:Su" -- perf test -w brstack 
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.012 MB perf.data (50 samples) ]
# perf script | head -20
            perf  919810  6726.456179:    2754000 cycles:       3ff95608ec8 _dl_map_object_from_fd+0xb18 (/usr/lib/ld64.so.1)
            perf  919810  6726.456179:   58638457 cycles:       3ff95608ec8 _dl_map_object_from_fd+0xb18 (/usr/lib/ld64.so.1)
            perf  919810  6726.456182:    1377000 cycles:       3ff9560a696 check_match+0x76 (/usr/lib/ld64.so.1)
            perf  919810  6726.456182:    1377000 cycles:       3ff9560fa6a _dl_relocate_object_no_relro+0x5fa (/usr/lib/ld64.so.1)
            perf  919810  6726.456182:    1377000 cycles:       3ff9560ac04 do_lookup_x+0x404 (/usr/lib/ld64.so.1)
            perf  919810  6726.456183:    1377000 cycles:       3ff9560f9fa _dl_relocate_object_no_relro+0x58a (/usr/lib/ld64.so.1)
            perf  919810  6726.456183:    4131000 cycles:       3ff9560f970 _dl_relocate_object_no_relro+0x500 (/usr/lib/ld64.so.1)
            perf  919810  6726.456183:    2754000 cycles:       3ff9560b48c _dl_lookup_symbol_x+0x5c (/usr/lib/ld64.so.1)
            perf  919810  6726.456183:    1377000 cycles:       3ff9560ac1c do_lookup_x+0x41c (/usr/lib/ld64.so.1)
            perf  919810  6726.456183:    1377000 cycles:       3ff9560b4b6 _dl_lookup_symbol_x+0x86 (/usr/lib/ld64.so.1)
            perf  919810  6726.456184:    1377000 cycles:       3ff9560abac do_lookup_x+0x3ac (/usr/lib/ld64.so.1)
            perf  919810  6726.456184:    1377000 cycles:       3ff9560b4b6 _dl_lookup_symbol_x+0x86 (/usr/lib/ld64.so.1)
            perf  919810  6726.456184:    1377000 cycles:       3ff9560a706 check_match+0xe6 (/usr/lib/ld64.so.1)
            perf  919810  6726.456184:    2754000 cycles:       3ff9560f970 _dl_relocate_object_no_relro+0x500 (/usr/lib/ld64.so.1)
            perf  919810  6726.456185:    8262000 cycles:       3ff94b28520 mi_option_init+0x80 (/usr/lib64/libpython3.13.so.1.0)
            perf  919810  6726.456185:    1377000 cycles:       2aa015527f4 brstack_bench+0x94 (/usr/bin/perf)
            perf  919810  6726.456185:    1377000 cycles:       2aa01552804 brstack_bench+0xa4 (/usr/bin/perf)
            perf  919810  6726.456185:    1377000 cycles:       2aa015526ec brstack_bar+0x34 (/usr/bin/perf)
            perf  919810  6726.456185:    1377000 cycles:       2aa01552808 brstack_bench+0xa8 (/usr/bin/perf)
            perf  919810  6726.456186:    1377000 cycles:       2aa01552760 brstack_bench+0x0 (/usr/bin/perf)

# 

And here is the output of the first entry (_dl_map_object), the value of both counters are different:
6726456179732 0x1b88 [0x68]: PERF_RECORD_SAMPLE(IP, 0x2): 919810/919810: 0x3ff95608ec8 period: 1377000 addr: 0
... sample_read:
.... group nr 2
..... id 0000000000001fbe, value 00000000002a05d0, lost 0
..... id 0000000000001fde, value 00000000037ec079, lost 0
 ... thread: perf:919810
 ...... dso: /usr/lib/ld64.so.1
 ... thread: perf:919810
 ...... dso: /usr/lib/ld64.so.1


In fact there are no entries with are identical. The counters always differ.
The counter with id 1fde is has 2 diffenrent values:

❯ perf report -D|grep 0000000000001fde
..... id 0000000000001fde, value 00000000037ec079, lost 0
.....
..... id 0000000000001fde, value 00000000037ec079, lost 0
..... id 0000000000001fde, value 00000000049dc845, lost 0

The counter with id 1fbe has always diffenrent values, its increment is
(most of the time) 1377000, or sometimes multiple thereof:

❯ perf report -D|grep 0000000000001fbe
..... id 0000000000001fbe, value 00000000002a05d0, lost 0
..... id 0000000000001fbe, value 00000000003f08b8, lost 0
..... id 0000000000001fbe, value 0000000000540ba0, lost 0
..... id 0000000000001fbe, value 0000000000690e88, lost 0
..... id 0000000000001fbe, value 00000000007e1170, lost 0
..... id 0000000000001fbe, value 0000000000bd1a28, lost 0
..... id 0000000000001fbe, value 0000000000e71ff8, lost 0
..... id 0000000000001fbe, value 0000000000fc22e0, lost 0
..... id 0000000000001fbe, value 00000000011125c8, lost 0
..... id 0000000000001fbe, value 00000000012628b0, lost 0
..... id 0000000000001fbe, value 00000000013b2b98, lost 0
..... id 0000000000001fbe, value 0000000001502e80, lost 0
..... id 0000000000001fbe, value 00000000017a3450, lost 0
..... id 0000000000001fbe, value 0000000001f845c0, lost 0
..... id 0000000000001fbe, value 00000000020d48a8, lost 0
..... id 0000000000001fbe, value 0000000002224b90, lost 0
..... id 0000000000001fbe, value 0000000002374e78, lost 0
..... id 0000000000001fbe, value 00000000024c5160, lost 0

So it looks like there is some issue with this test. Thanks for pointing this out.
I will look into this.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B42FA0D4
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860203; cv=none; b=fYxrp7BNUNY5LK5RbxcgsB/DzU7/g52LehRoJMFQmso72+dvKIr0E0VWfw8zvhH3ynvlBjzG2Ff93Q86WY2HYoi7PUbBNgTup8MyJNgkeO0XJPumcf2TqDYzywx3EBwnN6o10CIi1Vherf3MROrefyqBvZKHzDcWxfJD45Cd0KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860203; c=relaxed/simple;
	bh=KUqfoqK2xJd3G57YhxgL5howM24CHaxvoXz15ohWQBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSc/tyu3iNa5Cbl4pi22PYq7eIK74Kn3e7923JifYKKMEIYVZdk82uRcUwF9YoMnWa3ZMEut3zI36vBbzuN7H0cK5flw5tBXlK0Iu+YceD3Z+q154c2Z3hb0K4oEWRmQJiFszbqO1A47gEJaDzoDZlAeiFxcglh8lro2GGs0e70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=keb/Ibff; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="keb/Ibff"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAL2DmQ026220;
	Tue, 11 Nov 2025 11:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wOYKM6
	OytA48P/2PYRvnt5/lUI4xvtNs1XmMLTcOzVo=; b=keb/IbffdxOp314QCgFFEf
	VGOzO/CajW4tuN76hN/OfDwyp0ZYLwQPxN/u4oFpdlCu7Pxk9mypLYjtGGhEhHv1
	fnbwEk7NdxMlG4T9w0UyA8Af5n8OJ3nV6bXFQOHOYLBrAClDBsKad3XS3uqHGhI4
	1j2Pi63cYJonJ0WWWU/rJAs67F7nQTwdENgZ290dwDAyhPk0SIPMNCPwv3CzZ0B0
	g6gAdBvwIxApz7ifQCZlkgIesKbjeg1evoA/R4JcOGkfCeiqKUvpkrmde4HU1x1i
	gkwEhuNWnz+CgFh8sX6RVUrU0wJVmaNomhMllVNNEzkbioJdQeQtMyt8A7YhT8yw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk84sxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 11:23:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ABBN3H0013552;
	Tue, 11 Nov 2025 11:23:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk84sxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 11:23:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB9tdBA011562;
	Tue, 11 Nov 2025 11:23:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1a65y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 11:23:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ABBN0va54395282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 11:23:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ADA020043;
	Tue, 11 Nov 2025 11:23:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C8E720040;
	Tue, 11 Nov 2025 11:23:00 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Nov 2025 11:23:00 +0000 (GMT)
Message-ID: <38c9bd83-d823-4b84-9f1d-ad0b58f20a4c@linux.ibm.com>
Date: Tue, 11 Nov 2025 12:22:59 +0100
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
 <2e756e75-7dc9-4838-8651-ca1a0f056966@linux.ibm.com>
 <be8f4890-1c45-4116-9c9f-1e40e908747b@linaro.org>
 <a6218625-a08e-4466-837d-7bdd0c8631a5@linux.ibm.com>
 <1826ae90-b36b-4cde-b895-623cab4e1b08@linaro.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <1826ae90-b36b-4cde-b895-623cab4e1b08@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX8YmQxhbPxxf4
 f5lZW5FmHVLsOmx8/GeeCuK0wazivBGDlhzlRRTvXE8fABlW/FeB4PrxE1TyZ8aMdo+Zi9+FtfZ
 rHFnoRdCLlPmXNSsdurIISah6dfQUyWj7UpxvmoFTjtKJoGQVYyWYYFj+39sanWjk7SDVqR/V4h
 7ObNH91X9nBrWO84s8NNpz7asRBuKih50u36gwDpVpwmyUALNGRllxV/2IfmLhUKRHIha3oRI3l
 a18dGja1DkinwXj1Is80wnLPnybPrt1uDRCo1hjMFx7ALn1JaDvz8tNgSxFhD2Ip8QYFZlVYeIj
 an2jERi7Kkii+pVTm6eMtO02HpMd4yot3je0IfV2A3sN0EwfrUf6fTXv7B15nfanwDGJcdAfISU
 1RY1b/gix7TCcz0Yx+o5oPctvZe1xw==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=69131c98 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M3olQ3nhQw4BDS301XIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: WfyVCnwCVMRB7Uto_RTp7RLXQz2zyXkf
X-Proofpoint-GUID: UUDV8_mWjXzRDV0TFNNiJL8BzkxxxWbr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

On 10/29/25 10:25, James Clark wrote:
> 
> 
> On 29/10/2025 7:37 am, Thomas Richter wrote:
>> On 10/28/25 16:23, James Clark wrote:
>>>
>>>
>>> On 28/10/2025 12:55 pm, Thomas Richter wrote:
>> .....
>>
>>>> When I skip the grep it actually gets worse, there re more run away values:
>>>> # perf record -e "{cycles,cycles}:Su" -- perf test -w brstack
>>>> [ perf record: Woken up 2 times to write data ]
>>>> [ perf record: Captured and wrote 0.012 MB perf.data (50 samples) ]
>>>> # perf script | head -20
>>>>               perf  919810  6726.456179:    2754000 cycles:       3ff95608ec8 _dl_map_object_from_fd+0xb18 (/usr/lib/ld64.so.1)
>>>>               perf  919810  6726.456179:   58638457 cycles:       3ff95608ec8 _dl_map_object_from_fd+0xb18 (/usr/lib/ld64.so.1)
>>>>               perf  919810  6726.456182:    1377000 cycles:       3ff9560a696 check_match+0x76 (/usr/lib/ld64.so.1)
>>>>               perf  919810  6726.456182:    1377000 cycles:       3ff9560fa6a _dl_relocate_object_no_relro+0x5fa (/usr/lib/ld64.so.1)
>>>
>>> Can you share the raw output for the second sample as well? Or even the whole file would be better.
>>
>> Ok I will append a perf.data from today and hopefully it will be delivered to you:
>> See attachment perf.data.tmrs390 (binary file, big endian from s390)
>>
>>>
>>> It's the addresses from this sample that are confusing. 0x3ff95608ec8 is the same for both counters on the first sample (correctly), but the second sample has 0x3ff9560a696 and 0x3ff9560fa6a even though the cycles counts are the same.
>>>
>>
>> Command
>>    ./perf record -r 99 -e "{cycles,cycles}:Su" -- ./perf test -w brstack
>> is testing leadership group sampling in tests/shell/record.sh and
>> fails most of the time on s390.
>>
>> The command opens event cycles (as group leader) for sampling and the s390
>> sampling facility is started with default frequency of 4000.
>> This can be seen in the debug output:
>>
>> perf record opening and mmapping events
>> Opening: cycles
>> ------------------------------------------------------------
>> perf_event_attr:
>>    type                             0 (PERF_TYPE_HARDWARE)
>>    size                             136
>>    config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>>    { sample_period, sample_freq }   4000
>>    sample_type                      IP|TID|TIME|READ|ID|PERIOD
>>    read_format                      ID|GROUP|LOST
>>    disabled                         1
>>    inherit                          1
>>    exclude_kernel                   1
>>    exclude_hv                       1
>>    mmap                             1
>>    comm                             1
>>    freq                             1
>>    enable_on_exec                   1
>>    task                             1
>>    sample_id_all                    1
>>    mmap2                            1
>>    comm_exec                        1
>>    ksymbol                          1
>>    bpf_event                        1
>>    build_id                         1
>> ....
>> Next event cycles is opened in the s390 counting facility:
>> Opening: cycles
>> perf_event_attr:
>>    type                             0 (PERF_TYPE_HARDWARE)
>>    size                             136
>>    config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>>    sample_type                      IP|TID|TIME|READ|ID|PERIOD
>>    read_format                      ID|GROUP|LOST
>>    inherit                          1
>>    exclude_kernel                   1
>>    exclude_hv                       1
>>    sample_id_all                    1
>>
>> So now there are 2 hardware events when are mapped on s390 to
>>   1. event handled by CPU Measurement sampling facility, hardware writes 32 byte
>>      large samples to buffers. The frequency of 4000 Hz translates
>>      to a sample every 1300000 instructions. Interrupt driven.
>>   2. event handled by CPU Measurement  counting facilitly, hardware
>>      runs in the background and increments counters accordingly.
>>      All available counters (about 400) are running in the background
>>      and read via assembler instruction until stopped. No interrupts.
>>
>> If I understand this setup correctly, the first event is the group
>> leader and either both events run and are active or non of them.
>> That is the reason why both values should be identitical
>> Is this true?
>>
>> Now given two independent CPU measurement units on s390, one running
>> in the background incrementing counters, the other interrupt driven
>> reading samples, there is always room the both counters to differ.
>> The question is how much and how often.
>>
>> When I look at the debug output of the perf.data file; I get this:
>>
>> 55805554120788 0x22a8 [0x68]: PERF_RECORD_SAMPLE(IP, 0x2):
>>                  14135/14135: 0x3ff9ae90340 period: 1300000 addr: 0
>> ... sample_read:
>> .... group nr 2
>> ..... id 00000000000000b4, value 000000000115b5c0, lost 0
>> ..... id 00000000000000bc, value 000000000195ac03, lost 0
>>   ... thread: perf:14135
>>   ...... dso: /usr/lib/ld64.so.1
>>
>> The first value is the count from the sampling event, it gets
>> incremented with 4000 Hz frequency:
>>
>>   # perf report -D -i/tmp/perf.data.tmrs390|grep 00000000000000b4,|head -10
>> ..... id 00000000000000b4, value 000000000101dfa0, lost 0
>> ..... id 00000000000000b4, value 000000000115b5c0, lost 0
>> ..... id 00000000000000b4, value 00000000013d6200, lost 0
>> ..... id 00000000000000b4, value 0000000001513820, lost 0
>> ..... id 00000000000000b4, value 0000000001650e40, lost 0
>> ..... id 00000000000000b4, value 00000000018cba80, lost 0
>> ..... id 00000000000000b4, value 0000000001a090a0, lost 0
>> ..... id 00000000000000b4, value 0000000001b466c0, lost 0
>> ..... id 00000000000000b4, value 0000000001c83ce0, lost 0
>> ..... id 00000000000000b4, value 0000000001dc1300, lost 0
>>
>> value 115b5c0 - 101dfa0 = 13d620 --> 1300000 period time.
>> So that value always increments by period time.
>>
>> The other counter id is:
>>   # perf report -D -i/tmp/perf.data.tmrs390|grep 00000000000000bc,| sort | uniq -d
>> ..... id 00000000000000bc, value 000000000195ac03, lost 0
>> ..... id 00000000000000bc, value 0000000002fd8b45, lost 0
>> ..... id 00000000000000bc, value 0000000005f0b1ce, lost 0
>>   #
>> It reads out the value of counter 0 (cycles) 85 times, but has only 3 different
>> values.
>>
>> Anyway what does perf script print out? The value of the samples frequency?
>> Where does perf record read out the value of the counter event?
>> Any ideas where to start debugging?
>>
>> Thanks a lot.
>>
> 
> I think your PMU is just broken when setup for sampling events. The second counter is not being reset to zero to begin with, and then it doesn't increment after the first sample. I don't think your issues are to do with virtualisation.
> 
> The reason I was confused about the addresses in the Perf script output is because Perf discards samples where the counter didn't increment:
> 
>     /*
>      * There's no reason to deliver sample
>      * for zero period, bail out.
>      */
>     if (!sample->period)
>         return 0;
> 
> I'm not really sure about the logic for this because it breaks the assumption that the Perf script output has one line for each counter. And counters not increasing is information in itself which should be displayed.
> 
> If I comment out this line, then the output looks like I would expect and plainly shows your issue:
> 
> perf 55805.554110: 15600000 cycles: 3ff9ae95194 (lib/ld64.so.1)
> perf 55805.554110: 26586115 cycles: 3ff9ae95194 (lib/ld64.so.1)
> perf 55805.554117:  1300000 cycles: 3ff9ae8bb3e (lib/ld64.so.1)
> perf 55805.554117:        0 cycles: 3ff9ae8bb3e (lib/ld64.so.1)
> perf 55805.554120:  1300000 cycles: 3ff9ae90340 (lib/ld64.so.1)
> perf 55805.554120:        0 cycles: 3ff9ae90340 (lib/ld64.so.1)
> 
> Now we always have pairs of samples, and you can see that your second cycle counter isn't doing anything.
> 
> 

James,
the counter above being always 0 come from the fact that the group uses modifier :u
for user space, the cycles event are invoked without :u modifier.
On s390 you need to use -e "{cycles,cycles}:S"

I disagree with your assessment completely. I have spent quite some time
debugging this and come to a different finding. I executed this command
on the latest kernel:

 # uname -a
 Linux b83lp65.lnxne.boe 6.18.0-rc4d-perf+ #84 SMP Fri Nov  7 09:24:44 CET 2025 s390x GNU/Linux
 # /root/linux/tools/perf/perf record -e "{cycles,cycles}:S" \
        -- taskset -c 0 /root/linux/tools/perf/perf test -w brstack 5000000 2>/dev/null

I also had your suggestion patched into the perf script code:
 # git diff
 diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 09af486c83e4..212bca671a49 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1212,9 +1212,9 @@ static int deliver_sample_value(struct evlist *evlist,
        /*
         * There's no reason to deliver sample
         * for zero period, bail out.
-        */
        if (!sample->period)
                return 0;
+        */

        evsel = container_of(sid->evsel, struct evsel, core);
        return tool->sample(tool, event, sample, evsel, machine);
 #

The output of perf script is now (always in pairs of 2 lines):

taskset    7005   332.357459:    1377000 cycles:       3ff9db4611a find_module_idx+0x8a (/usr/lib64/libc.so.6)
taskset    7005   332.357459:    1948445 cycles:       3ff9db4611a find_module_idx+0x8a (/usr/lib64/libc.so.6)
   perf    7005   332.368619:    1377000 cycles:       3ffe03a4fa6 xas_reload+0x36 ([kernel.kallsyms])
   perf    7005   332.368619:   61344023 cycles:       3ffe03a4fa6 xas_reload+0x36 ([kernel.kallsyms])
   perf    7005   332.368624:    1377000 cycles:       3ffe0b53624 mas_empty_area_rev+0x3c4 ([kernel.kallsyms])
   perf    7005   332.368624:      25448 cycles:       3ffe0b53624 mas_empty_area_rev+0x3c4 ([kernel.kallsyms])
   perf    7005   332.368626:    1377000 cycles:       3ffadf81606 _dl_catch_exception+0xb6 (/usr/lib/ld64.so.1)
   perf    7005   332.368626:      12182 cycles:       3ffadf81606 _dl_catch_exception+0xb6 (/usr/lib/ld64.so.1)
   perf    7005   332.368628:    1377000 cycles:       3ffadf8c9b2 _dl_add_to_namespace_list+0x42 (/usr/lib/ld64.so.1)
   perf    7005   332.368628:      11392 cycles:       3ffadf8c9b2 _dl_add_to_namespace_list+0x42 (/usr/lib/ld64.so.1)
   perf    7005   332.368630:    1377000 cycles:       3ffe0b4f800 mas_prev+0x0 ([kernel.kallsyms])
   perf    7005   332.368630:      11476 cycles:       3ffe0b4f800 mas_prev+0x0 ([kernel.kallsyms])


Now to the debugging and investigation:
1. With command
       perf record -e '{cycles,cycles}:S' -- ....
   the first cycles event start sampling.
   On s390 this sets up sampling with a frequency of 4000 Hz.
   This translates to hardware sample rate of 1377000 instructions per
   micro-second to meet a frequency of 4000 HZ.

2. With first event cycles now sampling into a hardware buffer, an interrupt
   is triggered each time a sampling buffer gets full. The interrupt handler
   is then invoked and debug output shows the processing of samples.
   The size of one hardware sample is 32 bytes. With an interrupt triggered
   when the hardware buffer page of 4KB gets full, the interrupt handler
   processes 128 samples.
   (This is taken from s390 specific fast debug data gathering)
   2025-11-07 14:35:51.977248  000003ffe013cbfa  perf_event_count_update event->count 0x0 count 0x1502e8
   2025-11-07 14:35:51.977248  000003ffe013cbfa  perf_event_count_update event->count 0x1502e8 count 0x1502e8
   2025-11-07 14:35:51.977248  000003ffe013cbfa  perf_event_count_update event->count 0x2a05d0 count 0x1502e8
   2025-11-07 14:35:51.977252  000003ffe013cbfa  perf_event_count_update event->count 0x3f08b8 count 0x1502e8
   2025-11-07 14:35:51.977252  000003ffe013cbfa  perf_event_count_update event->count 0x540ba0 count 0x1502e8
   2025-11-07 14:35:51.977253  000003ffe013cbfa  perf_event_count_update event->count 0x690e88 count 0x1502e8
   2025-11-07 14:35:51.977254  000003ffe013cbfa  perf_event_count_update event->count 0x7e1170 count 0x1502e8
   2025-11-07 14:35:51.977254  000003ffe013cbfa  perf_event_count_update event->count 0x931458 count 0x1502e8
   2025-11-07 14:35:51.977254  000003ffe013cbfa  perf_event_count_update event->count 0xa81740 count 0x1502e8

3. The value is constantly increasing by the number of instructions executed
   to generate a sample entry.  This is the first line of the pairs of lines.
   count 0x1502e8 --> 1377000

   # perf script | grep 1377000 | wc -l
   214
   # perf script | wc -l
   428
   #
   That is 428 lines in total, and half of the lines contain value 1377000.

4. The second event cycles is opened against the counting PMU, which is an
   independent PMU and is not interrupt driven.  Once enabled it runs in the
   backgroud and keeps running, incrementing silently about 400+
   counters. The counter values are read via assembly instructions.

   This second counter PMU's read call back function is called when the
   interrupt handler of the sampling facility processes each sample. The
   function call sequence is:

   perf_event_overflow()
   +--> __perf_event_overflow()
        +--> __perf_event_output()
               +--> perf_output_sample()
                    +--> perf_output_read()
                         +--> perf_output_read_group()
                                  for_each_sibling_event(sub, leader) {
                values[n++] = perf_event_count(sub, self);
                printk("%s sub %p values %#lx\n", __func__, sub, values[n-1]);
                                  }

   The last function perf_event_count() is invoked on the second event cylces
   *on* the counting PMU. An added printk statement shows the following lines
   in the dmesg output:

   # dmesg|grep perf_output_read_group |head -10
   [  332.368620] perf_output_read_group sub 00000000d80b7c1f values 0x3a80917 (1)
   [  332.368624] perf_output_read_group sub 00000000d80b7c1f values 0x3a86c7f (2)
   [  332.368627] perf_output_read_group sub 00000000d80b7c1f values 0x3a89c15 (3)
   [  332.368629] perf_output_read_group sub 00000000d80b7c1f values 0x3a8c895 (4)
   [  332.368631] perf_output_read_group sub 00000000d80b7c1f values 0x3a8f569 (5)
   [  332.368633] perf_output_read_group sub 00000000d80b7c1f values 0x3a9204b
   [  332.368635] perf_output_read_group sub 00000000d80b7c1f values 0x3a94790
   [  332.368637] perf_output_read_group sub 00000000d80b7c1f values 0x3a9704b
   [  332.368638] perf_output_read_group sub 00000000d80b7c1f values 0x3a99888
   #

  This correlates with the output of
   # perf report -D | grep 'id 00000000000000'|head -10
   ..... id 0000000000000006, value 00000000001502e8, lost 0
   ..... id 000000000000000e, value 0000000003a80917, lost 0 --> line (1) above
   ..... id 0000000000000006, value 00000000002a05d0, lost 0
   ..... id 000000000000000e, value 0000000003a86c7f, lost 0 --> line (2) above
   ..... id 0000000000000006, value 00000000003f08b8, lost 0
   ..... id 000000000000000e, value 0000000003a89c15, lost 0 --> line (3) above
   ..... id 0000000000000006, value 0000000000540ba0, lost 0
   ..... id 000000000000000e, value 0000000003a8c895, lost 0 --> line (4) above
   ..... id 0000000000000006, value 0000000000690e88, lost 0
   ..... id 000000000000000e, value 0000000003a8f569, lost 0 --> line (5) above

Summary:
- Above command starts the CPU sampling facility, with runs interrupt
  driven when a 4KB page is full. An interrupt processes the 128 samples
  and calls eventually perf_output_read_group() for each sample to save it
  in the event's ring buffer.

- At that time the CPU counting facility is invoked to read the value of
  the event cycles. This value is saved as the second value in the
  sample_read structure.

- The first and odd lines in the perf script output displays the period
  value between 2 samples being created by hardware. It is the number
  of instructions executes before the hardware writes a sample.

- The second and even lines in the perf script output displays the number
  of CPU cycles needed to process each sample and save it in the event's ring
  buffer.

These 2 different values can never be identical on s390.
In fact I think this test case is not valid for s390. Or we have to
compare the odd numbered lines to each other (1 with 3, 3 with 5 and so on)
and the even lines (2 with 4, 4 with 6 and so on) to each other.

Any ideas or comments?


Thanks a lot.          
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

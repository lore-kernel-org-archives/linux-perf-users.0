Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684DC2F9980
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944611; cv=none; b=CnruYdfzoM5KqvUfAAlTU2X62mXpDScjONhQbL+OvKXZ6HW3p4ea1aKmXKQ+Ar7cvbrvHjd6UeBG4ecV99y+cMk71T8QzuBIx9UsO/sBFE25wxhrKR07cifYPdq78kjgVAGfaHjsDCfNJilBeWPGw0silUYJwNPeFN2TJpXURUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944611; c=relaxed/simple;
	bh=N7n3A1yeTn9p3Et9Q8hTfwVDAJS98UPFZp9zrLVCEjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3gc1gRtpJzAiOKAQHqttXJyqliKJ7i5sxVL4sfL8vYnu9MYOvbBo2T8qkfKNrSbOhJ66JtdQnr24m+Is6K8NPmuskfgEfBAqDEluzmu766SbfANRsjiR6CmtGiHpAEvVoUDOfzIq+oKXc1+pJnrd00ndjrOrQDeP4ZKSoE0pdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZUh/Ru1k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZUh/Ru1k"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC9YZVU004045;
	Wed, 12 Nov 2025 10:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=omZDWU
	YavysEU2nPetmZHosMiJ6FtEOWvrZTjNhWvhI=; b=ZUh/Ru1kPysWhohZLRgkgE
	unxmfFcBcP7Y7kHfkKHXJOUv98WPDNVBejXTmXgxZ8VNF20AioZzpEZSIO/7TgOt
	wvNWy05tWWcpou40l8tsDg/E+OBSi/reeiz8ffVZC+YbgLCoEVaBxXheNVDGnJP7
	MKIY0KTW8ErLOxHqhQZyi7yanAP1lTUGFwQGSFa4gO+FjGLiIcVIdH+YDImUCm7T
	/tjEMvIySGZdCgWp8NoWejEmRFjq5eakhmExtb3En4SSFTEtXe1epgfjtQWxGFFJ
	Khm07b+T1aGIeApNYkI6pmP12NBQuGb1ETg36G2GPg9a6q5i6GmP4Km1jafE3LYQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj8s1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 10:47:43 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACAkjnH020576;
	Wed, 12 Nov 2025 10:47:43 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj8s16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 10:47:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC9nAW5004735;
	Wed, 12 Nov 2025 10:47:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjxysqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 10:47:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACAldk312583284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 10:47:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC6B12004E;
	Wed, 12 Nov 2025 10:47:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C1E72004D;
	Wed, 12 Nov 2025 10:47:39 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 10:47:39 +0000 (GMT)
Message-ID: <0862c069-8c12-42f0-9a9b-2580daad56d1@linux.ibm.com>
Date: Wed, 12 Nov 2025 11:47:39 +0100
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
 <38c9bd83-d823-4b84-9f1d-ad0b58f20a4c@linux.ibm.com>
 <42a066c9-8be3-432c-8cd2-5311c26e7b36@linaro.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <42a066c9-8be3-432c-8cd2-5311c26e7b36@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=691465cf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zcRdcAmisvY7PQ1NQ9YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX8SV0IuaI7e8E
 DViNlYuiiVTvfmVNKurM3ZJDd7GI+NcyfDGRYUlHVPRqfsA5PlwxN7uLDMO8cXeo9zEZ5NCqBHA
 7ksHxVNTWqvn/McFYK2PqREutKmmPZHwnjnFrWgIKGb21gBZpBYOpl5e+d/celKFd+5RhFfRpNS
 oiS/asYQXpkK2NRSJW00cmXDIjDX00X1lv3/LXlOUqGuJJtSBYtDszXfe3hcz3QeJDfpP5a3s2B
 YMv+8TSPmDwsRy383WQVb2CV5czlPviUM0zoPG5vkzTYL5o7CZn/9bwGbZqEUGXcefY3lkPVtgV
 wcwRMEJel+BVw3zvX8Wa6yRGFPiTVMT4VPuh1UFcQxZqePy2tlRQNuA3Bn6aUiFuJ7Wn2jezn/x
 7UESEWyAK54WbYfUdNVYfixKgkAP5g==
X-Proofpoint-GUID: JO1CIshxyVdKCtstDyfr4h7ceItS_iH4
X-Proofpoint-ORIG-GUID: DcaZpuPRudMRa4wzuxQGB_sh4mz9PekH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

On 11/11/25 15:03, James Clark wrote:

.....

>>
>> James,
>> the counter above being always 0 come from the fact that the group uses modifier :u
>> for user space, the cycles event are invoked without :u modifier.
>> On s390 you need to use -e "{cycles,cycles}:S"
> 
> I'm not following why :u should make a difference. I see from your explanation below that you have two different types of counter and the first event runs on the buffered one and the other on a simple PMU counter, but how does that translate to userspace filtering making a difference?
> 

Well, s390 counters are 
 # ls -l /sys/devices/cpum_cf/events/*CPU_CYCLES
-r--r--r-- 1 root root 4096 Nov 12 11:10 /sys/devices/cpum_cf/events/CPU_CYCLES
-r--r--r-- 1 root root 4096 Nov 12 11:10 /sys/devices/cpum_cf/events/PROBLEM_STATE_CPU_CYCLES
 # cat /sys/devices/cpum_cf/events/*CPU_CYCLES
 event=0x0000
 event=0x0020
 # 

The generic event cycles is translated to CPU_CYCLES and user space cycles are counted with
a different counter named PROBLEM_STATE_CPU_CYCLES

So 2 different counters, in 2 different counter sets, one started one not started.

>> I disagree with your assessment completely. I have spent quite some time
>> debugging this and come to a different finding. I executed this command
>> on the latest kernel:
>>
>>   # uname -a
>>   Linux b83lp65.lnxne.boe 6.18.0-rc4d-perf+ #84 SMP Fri Nov  7 09:24:44 CET 2025 s390x GNU/Linux
>>   # /root/linux/tools/perf/perf record -e "{cycles,cycles}:S" \
>>          -- taskset -c 0 /root/linux/tools/perf/perf test -w brstack 5000000 2>/dev/null
>>
>> I also had your suggestion patched into the perf script code:
>>   # git diff
>>   diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 09af486c83e4..212bca671a49 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -1212,9 +1212,9 @@ static int deliver_sample_value(struct evlist *evlist,
>>          /*
>>           * There's no reason to deliver sample
>>           * for zero period, bail out.
>> -        */
>>          if (!sample->period)
>>                  return 0;
>> +        */
>>
>>          evsel = container_of(sid->evsel, struct evsel, core);
>>          return tool->sample(tool, event, sample, evsel, machine);
>>   #
>>
>> The output of perf script is now (always in pairs of 2 lines):
>> > taskset    7005   332.357459:    1377000 cycles:       3ff9db4611a find_module_idx+0x8a (/usr/lib64/libc.so.6)
>> taskset    7005   332.357459:    1948445 cycles:       3ff9db4611a find_module_idx+0x8a (/usr/lib64/libc.so.6)
>>     perf    7005   332.368619:    1377000 cycles:       3ffe03a4fa6 xas_reload+0x36 ([kernel.kallsyms])
>>     perf    7005   332.368619:   61344023 cycles:       3ffe03a4fa6 xas_reload+0x36 ([kernel.kallsyms])
>>     perf    7005   332.368624:    1377000 cycles:       3ffe0b53624 mas_empty_area_rev+0x3c4 ([kernel.kallsyms])
>>     perf    7005   332.368624:      25448 cycles:       3ffe0b53624 mas_empty_area_rev+0x3c4 ([kernel.kallsyms])
>>     perf    7005   332.368626:    1377000 cycles:       3ffadf81606 _dl_catch_exception+0xb6 (/usr/lib/ld64.so.1)
>>     perf    7005   332.368626:      12182 cycles:       3ffadf81606 _dl_catch_exception+0xb6 (/usr/lib/ld64.so.1)
>>     perf    7005   332.368628:    1377000 cycles:       3ffadf8c9b2 _dl_add_to_namespace_list+0x42 (/usr/lib/ld64.so.1)
>>     perf    7005   332.368628:      11392 cycles:       3ffadf8c9b2 _dl_add_to_namespace_list+0x42 (/usr/lib/ld64.so.1)
>>     perf    7005   332.368630:    1377000 cycles:       3ffe0b4f800 mas_prev+0x0 ([kernel.kallsyms])
>>     perf    7005   332.368630:      11476 cycles:       3ffe0b4f800 mas_prev+0x0 ([kernel.kallsyms])
>>
> 
> The above patch won't make a difference to this output because none of them are 0. You get exactly the same output with or without the patch.
> 
> I only showed that this part of the code was hiding the original issue where most of the second counter values were 0. That seems to not be the case if you remove :u as you found, but isn't related to this part.
> 

Agreed

> I kind of see why :u results in 0 counts, because you're only counting the time between when the buffered counter fills up and interrupted and when you generated the other samples. But I don't get why that has to be the case. Couldn't you leave the other counters running and then they would count everything between samples?
> 
>>
>> Now to the debugging and investigation:
>> 1. With command
>>         perf record -e '{cycles,cycles}:S' -- ....
>>     the first cycles event start sampling.
>>     On s390 this sets up sampling with a frequency of 4000 Hz.
>>     This translates to hardware sample rate of 1377000 instructions per
>>     micro-second to meet a frequency of 4000 HZ.
> 
> 1377000 instructions per sample? I'm assuming per micro-second is a mistake.

Here is the maths:
# cat /proc/service_levels 
CPU-MF: Counter facility: version=3.8 authorization=002f
CPU-MF: Sampling facility: min_rate=22032 max_rate=180464112 cpu_speed=5508
CPU-MF: Sampling facility: mode=basic sample_size=32
CPU-MF: Sampling facility: mode=diagnostic sample_size=171
...

So the cpu_speed of 5508 (machine type z17) means 5508 CPU cycles per micro second. Document SA23-2260-08 page 2-35
5508 * 1000000 = 5508000000b / 4000 --> 1377000 CPU cycles between hardware write a sample.

> 
> As in, it sets the counter to roll over and take a sample every 1377000 cycles (instructions?), which ends up being 4000 samples per second.
> 
>>
>> 2. With first event cycles now sampling into a hardware buffer, an interrupt
>>     is triggered each time a sampling buffer gets full. The interrupt handler
>>     is then invoked and debug output shows the processing of samples.
>>     The size of one hardware sample is 32 bytes. With an interrupt triggered
>>     when the hardware buffer page of 4KB gets full, the interrupt handler
>>     processes 128 samples.
>>     (This is taken from s390 specific fast debug data gathering)
>>     2025-11-07 14:35:51.977248  000003ffe013cbfa  perf_event_count_update event->count 0x0 count 0x1502e8
>>     2025-11-07 14:35:51.977248  000003ffe013cbfa  perf_event_count_update event->count 0x1502e8 count 0x1502e8
>>     2025-11-07 14:35:51.977248  000003ffe013cbfa  perf_event_count_update event->count 0x2a05d0 count 0x1502e8
>>     2025-11-07 14:35:51.977252  000003ffe013cbfa  perf_event_count_update event->count 0x3f08b8 count 0x1502e8
>>     2025-11-07 14:35:51.977252  000003ffe013cbfa  perf_event_count_update event->count 0x540ba0 count 0x1502e8
>>     2025-11-07 14:35:51.977253  000003ffe013cbfa  perf_event_count_update event->count 0x690e88 count 0x1502e8
>>     2025-11-07 14:35:51.977254  000003ffe013cbfa  perf_event_count_update event->count 0x7e1170 count 0x1502e8
>>     2025-11-07 14:35:51.977254  000003ffe013cbfa  perf_event_count_update event->count 0x931458 count 0x1502e8
>>     2025-11-07 14:35:51.977254  000003ffe013cbfa  perf_event_count_update event->count 0xa81740 count 0x1502e8
>>
>> 3. The value is constantly increasing by the number of instructions executed
>>     to generate a sample entry.  This is the first line of the pairs of lines.
>>     count 0x1502e8 --> 1377000
>>
>>     # perf script | grep 1377000 | wc -l
>>     214
>>     # perf script | wc -l
>>     428
>>     #
>>     That is 428 lines in total, and half of the lines contain value 1377000.
>>
>> 4. The second event cycles is opened against the counting PMU, which is an
>>     independent PMU and is not interrupt driven.  Once enabled it runs in the
>>     backgroud and keeps running, incrementing silently about 400+
>>     counters. The counter values are read via assembly instructions.
>>
>>     This second counter PMU's read call back function is called when the
>>     interrupt handler of the sampling facility processes each sample. The
>>     function call sequence is:
>>
>>     perf_event_overflow()
>>     +--> __perf_event_overflow()
>>          +--> __perf_event_output()
>>                 +--> perf_output_sample()
>>                      +--> perf_output_read()
>>                           +--> perf_output_read_group()
>>                                    for_each_sibling_event(sub, leader) {
>>                  values[n++] = perf_event_count(sub, self);
>>                  printk("%s sub %p values %#lx\n", __func__, sub, values[n-1]);
>>                                    }
>>
>>     The last function perf_event_count() is invoked on the second event cylces
>>     *on* the counting PMU. An added printk statement shows the following lines
>>     in the dmesg output:
>>
>>     # dmesg|grep perf_output_read_group |head -10
>>     [  332.368620] perf_output_read_group sub 00000000d80b7c1f values 0x3a80917 (1)
>>     [  332.368624] perf_output_read_group sub 00000000d80b7c1f values 0x3a86c7f (2)
>>     [  332.368627] perf_output_read_group sub 00000000d80b7c1f values 0x3a89c15 (3)
>>     [  332.368629] perf_output_read_group sub 00000000d80b7c1f values 0x3a8c895 (4)
>>     [  332.368631] perf_output_read_group sub 00000000d80b7c1f values 0x3a8f569 (5)
>>     [  332.368633] perf_output_read_group sub 00000000d80b7c1f values 0x3a9204b
>>     [  332.368635] perf_output_read_group sub 00000000d80b7c1f values 0x3a94790
>>     [  332.368637] perf_output_read_group sub 00000000d80b7c1f values 0x3a9704b
>>     [  332.368638] perf_output_read_group sub 00000000d80b7c1f values 0x3a99888
>>     #
>>
>>    This correlates with the output of
>>     # perf report -D | grep 'id 00000000000000'|head -10
>>     ..... id 0000000000000006, value 00000000001502e8, lost 0
>>     ..... id 000000000000000e, value 0000000003a80917, lost 0 --> line (1) above
>>     ..... id 0000000000000006, value 00000000002a05d0, lost 0
>>     ..... id 000000000000000e, value 0000000003a86c7f, lost 0 --> line (2) above
>>     ..... id 0000000000000006, value 00000000003f08b8, lost 0
>>     ..... id 000000000000000e, value 0000000003a89c15, lost 0 --> line (3) above
>>     ..... id 0000000000000006, value 0000000000540ba0, lost 0
>>     ..... id 000000000000000e, value 0000000003a8c895, lost 0 --> line (4) above
>>     ..... id 0000000000000006, value 0000000000690e88, lost 0
>>     ..... id 000000000000000e, value 0000000003a8f569, lost 0 --> line (5) above
>>
>> Summary:
>> - Above command starts the CPU sampling facility, with runs interrupt
>>    driven when a 4KB page is full. An interrupt processes the 128 samples
>>    and calls eventually perf_output_read_group() for each sample to save it
>>    in the event's ring buffer.
>>
>> - At that time the CPU counting facility is invoked to read the value of
>>    the event cycles. This value is saved as the second value in the
>>    sample_read structure.
>>
>> - The first and odd lines in the perf script output displays the period
>>    value between 2 samples being created by hardware. It is the number
>>    of instructions executes before the hardware writes a sample.
>>
>> - The second and even lines in the perf script output displays the number
>>    of CPU cycles needed to process each sample and save it in the event's ring
>>    buffer.

....

>> Thanks a lot.
> 
> I agree, it looks like the test in its current form isn't valid and shouldn't be run on s390.
> 
> Does this buffered hardware counter only support the cycles event? Or does it support any event but there is only one instance of it?
> 
> Because if it only supports the cycles event then we can just change the test to count branches which would force it to run on a simple counter instead. If it supports any event then I think the test (or sample read as a whole) can never work.
> 
> You'd still probably want to update the PMU to reject sample read events that run on the buffered counter, whether it's only for cycles or not. That would prevent people from being confused outside of the test as well.
> 
We can disable this leader sampling test for s390, because we only have one event.
Or I change the command line invocation to this:

# git diff tests/shell/record.sh
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 0f5841c479e7..4d2557b85606 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -260,7 +260,7 @@ test_uid() {
 
 test_leader_sampling() {
   echo "Basic leader sampling test"
-  if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
+  if ! perf record -o "${perfdata}" -e "{cpum_sf/SF_CYCLES_BASIC/,cycles}:S" -- \
     perf test -w brstack 2> /dev/null
   then
     echo "Leader sampling [Failed record]"
@@ -432,18 +432,18 @@ if [[ $default_fd_limit -lt $min_fd_limit ]]; then
        ulimit -Sn $min_fd_limit
 fi

It installs the sampling using a different perf_event::attr::type and
perf_event::attr::config combination for sampling. It now operates on
two sampling event which run in sync.

Leads to this result:
# for i in $(seq 10); do ./perf test 124; done
124: perf record tests                                               : Ok
124: perf record tests                                               : Ok
124: perf record tests                                               : Ok
124: perf record tests                                               : Ok
124: perf record tests                                               : Ok
124: perf record tests                                               : Ok
124: perf record tests                                               : Ok
124: perf record tests                                               : Ok
124: perf record tests                                               : Ok
124: perf record tests                                               : Ok
# 

Should I submit a patch for that?

Thanks
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

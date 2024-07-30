Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906A19580A;
	Tue, 30 Jul 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347656; cv=none; b=OcucSKcAdJLGUvtTbO4s1B+g2cFZncQmPfGdDgqx3GMoEzQxADZxCaKwcgPoXPvl7YQNf6wsYgrrwHzA8gJpguLlg/BDcMP3ae+MyvDbD6hE0pDX5356VBfEpnqrwU8rzkhQ1KiPhntLpcg6rp3yaWPdppKRHG+iJbVgpDDezq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347656; c=relaxed/simple;
	bh=pwKZiGZAujQD7D4RuRu8JQ17dESggXmhbAlT2ChcGCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4PktrcnJTbUCg/5+/AR8Zhq9/kCb5vGddDn1BSgX/isZ1GhlLclWdgJhQff5wAksXtpT5BWRblea/VjnI8wyzm/jKVYL/aM1b/CdiaDe/vwmksy50dClYH/Mi3QbtxdfF/WuF3fDSC1hp+ehk+cDLrcprIYloCPLbBb52SZZx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ctPJ8ghQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ctPJ8ghQ"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UDSraG026065;
	Tue, 30 Jul 2024 13:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=g
	ZHSpDNLW7/ic3xX2uCFv3XHxzx42EWTKrK3ivaCBuE=; b=ctPJ8ghQS5lD8fJx2
	WMHJktvyFz0pl/PEdNpWFqqIDcRvPIeLunmFGIstZC9kVm8/TnmDX/q5fON/vF3s
	Ca2k8du/89mK1WUt8AdVOZ3dyddU5x0sVKA2XSp1T6Tupv7FsutMzsOgKn1AU0Kj
	Nj0GXSRHbWAjQL3VP9aoS35+zCgg7PzFGR4Og5RyApExpBMT/PyOlNnT8RCWTE1J
	weWJxPNS+MNZnJcU2K7hsTRtRudSnJtEOt//Sub5Pwb2eFJ06WlKMaBlyaiSM2f/
	qNgXv433VCCb9c8kMSNaRLk/BprhKBjvIpY7WFkXqnDkn19BUn63YjPyrzgzTWnm
	yrrUw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q13a81s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 13:54:04 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46UDs3HF004250;
	Tue, 30 Jul 2024 13:54:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q13a81s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 13:54:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46UAmJQV018928;
	Tue, 30 Jul 2024 13:54:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7pmxtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 13:54:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46UDrvuj54919622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 13:53:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA8B520043;
	Tue, 30 Jul 2024 13:53:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 083FD20040;
	Tue, 30 Jul 2024 13:53:54 +0000 (GMT)
Received: from [9.179.1.74] (unknown [9.179.1.74])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jul 2024 13:53:53 +0000 (GMT)
Message-ID: <6a737273-3ab5-44eb-8aea-55cd66ea33b4@linux.ibm.com>
Date: Tue, 30 Jul 2024 19:23:53 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events power10: Update JSON/events
To: Disha Goel <disgoel@linux.ibm.com>, acme@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc: atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        akanksha@linux.ibm.com, linux-perf-users@vger.kernel.org,
        maddy@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.ibm.com
References: <20240723052154.96202-1-kjain@linux.ibm.com>
 <7ccf31b5-7eaf-4b42-bf9c-b48d1fa5c2cf@linux.ibm.com>
Content-Language: en-US
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <7ccf31b5-7eaf-4b42-bf9c-b48d1fa5c2cf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1kJSINnPJJRAZRR0tBEsGNIe3nHlVOPv
X-Proofpoint-GUID: pMJ6nwo3dMBm0N3x2aaS2CW7aYkDA1zQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300095



On 7/23/24 12:35, Disha Goel wrote:
> On 23/07/24 10:51 am, Kajol Jain wrote:
> 
>> Update JSON/events for power10 platform with additional events.
>> Also move PM_VECTOR_LD_CMPL event from others.json to
>> frontend.json file.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> 
> I have tested the patch on power10 machine. Looks good to me.
> 

Hi Disha,
   Thanks for testing this patch.

Thanks,
Kajol Jain

> Tested-by: Disha Goel <disgoel@linux.ibm.com>
> 
>> ---
>>   .../arch/powerpc/power10/frontend.json        |   5 +
>>   .../arch/powerpc/power10/others.json          | 100 +++++++++++++++++-
>>   2 files changed, 100 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
>> b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
>> index 5977f5e64212..53660c279286 100644
>> --- a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
>> +++ b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
>> @@ -74,6 +74,11 @@
>>       "EventName": "PM_ISSUE_KILL",
>>       "BriefDescription": "Cycles in which an instruction or group of
>> instructions were cancelled after being issued. This event increments
>> once per occurrence, regardless of how many instructions are included
>> in the issue group."
>>     },
>> +  {
>> +    "EventCode": "0x44054",
>> +    "EventName": "PM_VECTOR_LD_CMPL",
>> +    "BriefDescription": "Vector load instruction completed."
>> +  },
>>     {
>>       "EventCode": "0x44056",
>>       "EventName": "PM_VECTOR_ST_CMPL",
>> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/others.json
>> b/tools/perf/pmu-events/arch/powerpc/power10/others.json
>> index fcf8a8ebe7bd..53ca610152fa 100644
>> --- a/tools/perf/pmu-events/arch/powerpc/power10/others.json
>> +++ b/tools/perf/pmu-events/arch/powerpc/power10/others.json
>> @@ -94,11 +94,6 @@
>>       "EventName": "PM_L1_ICACHE_RELOADED_ALL",
>>       "BriefDescription": "Counts all instruction cache reloads
>> includes demand, prefetch, prefetch turned into demand and demand
>> turned into prefetch."
>>     },
>> -  {
>> -    "EventCode": "0x44054",
>> -    "EventName": "PM_VECTOR_LD_CMPL",
>> -    "BriefDescription": "Vector load instruction completed."
>> -  },
>>     {
>>       "EventCode": "0x4D05E",
>>       "EventName": "PM_BR_CMPL",
>> @@ -108,5 +103,100 @@
>>       "EventCode": "0x400F0",
>>       "EventName": "PM_LD_DEMAND_MISS_L1_FIN",
>>       "BriefDescription": "Load missed L1, counted at finish time."
>> +  },
>> +  {
>> +    "EventCode": "0x00000038BC",
>> +    "EventName": "PM_ISYNC_CMPL",
>> +    "BriefDescription": "Isync completion count per thread."
>> +  },
>> +  {
>> +    "EventCode": "0x000000C088",
>> +    "EventName": "PM_LD0_32B_FIN",
>> +    "BriefDescription": "256-bit load finished in the LD0 load
>> execution unit."
>> +  },
>> +  {
>> +    "EventCode": "0x000000C888",
>> +    "EventName": "PM_LD1_32B_FIN",
>> +    "BriefDescription": "256-bit load finished in the LD1 load
>> execution unit."
>> +  },
>> +  {
>> +    "EventCode": "0x000000C090",
>> +    "EventName": "PM_LD0_UNALIGNED_FIN",
>> +    "BriefDescription": "Load instructions in LD0 port that are
>> either unaligned, or treated as unaligned and require an additional
>> recycle through the pipeline using the load gather buffer. This
>> typically adds about 10 cycles to the latency of the instruction. This
>> includes loads that cross the 128 byte boundary, octword loads that
>> are not aligned, and a special forward progress case of a load that
>> does not hit in the L1 and crosses the 32 byte boundary and is
>> launched NTC. Counted at finish time."
>> +  },
>> +  {
>> +    "EventCode": "0x000000C890",
>> +    "EventName": "PM_LD1_UNALIGNED_FIN",
>> +    "BriefDescription": "Load instructions in LD1 port that are
>> either unaligned, or treated as unaligned and require an additional
>> recycle through the pipeline using the load gather buffer. This
>> typically adds about 10 cycles to the latency of the instruction. This
>> includes loads that cross the 128 byte boundary, octword loads that
>> are not aligned, and a special forward progress case of a load that
>> does not hit in the L1 and crosses the 32 byte boundary and is
>> launched NTC. Counted at finish time."
>> +  },
>> +  {
>> +    "EventCode": "0x000000C0A4",
>> +    "EventName": "PM_ST0_UNALIGNED_FIN",
>> +    "BriefDescription": "Store instructions in ST0 port that are
>> either unaligned, or treated as unaligned and require an additional
>> recycle through the pipeline. This typically adds about 10 cycles to
>> the latency of the instruction. This only includes stores that cross
>> the 128 byte boundary. Counted at finish time."
>> +  },
>> +  {
>> +    "EventCode": "0x000000C8A4",
>> +    "EventName": "PM_ST1_UNALIGNED_FIN",
>> +    "BriefDescription": "Store instructions in ST1 port that are
>> either unaligned, or treated as unaligned and require an additional
>> recycle through the pipeline. This typically adds about 10 cycles to
>> the latency of the instruction. This only includes stores that cross
>> the 128 byte boundary. Counted at finish time."
>> +  },
>> +  {
>> +    "EventCode": "0x000000C8B8",
>> +    "EventName": "PM_STCX_SUCCESS_CMPL",
>> +    "BriefDescription": "STCX instructions that completed
>> successfully. Specifically, counts only when a pass status is returned
>> from the nest."
>> +  },
>> +  {
>> +    "EventCode": "0x000000D0B4",
>> +    "EventName": "PM_DC_PREF_STRIDED_CONF",
>> +    "BriefDescription": "A demand load referenced a line in an active
>> strided prefetch stream. The stream could have been allocated through
>> the hardware prefetch mechanism or through software."
>> +  },
>> +  {
>> +    "EventCode": "0x000000F880",
>> +    "EventName": "PM_SNOOP_TLBIE_CYC",
>> +    "BriefDescription": "Cycles in which TLBIE snoops are executed in
>> the LSU."
>> +  },
>> +  {
>> +    "EventCode": "0x000000F084",
>> +    "EventName": "PM_SNOOP_TLBIE_CACHE_WALK_CYC",
>> +    "BriefDescription": "TLBIE snoop cycles in which the data cache
>> is being walked."
>> +  },
>> +  {
>> +    "EventCode": "0x000000F884",
>> +    "EventName": "PM_SNOOP_TLBIE_WAIT_ST_CYC",
>> +    "BriefDescription": "TLBIE snoop cycles in which older stores are
>> still draining."
>> +  },
>> +  {
>> +    "EventCode": "0x000000F088",
>> +    "EventName": "PM_SNOOP_TLBIE_WAIT_LD_CYC",
>> +    "BriefDescription": "TLBIE snoop cycles in which older loads are
>> still draining."
>> +  },
>> +  {
>> +    "EventCode": "0x000000F08C",
>> +    "EventName": "PM_SNOOP_TLBIE_WAIT_MMU_CYC",
>> +    "BriefDescription": "TLBIE snoop cycles in which the Load-Store
>> unit is waiting for the MMU to finish invalidation."
>> +  },
>> +  {
>> +    "EventCode": "0x0000004884",
>> +    "EventName": "PM_NO_FETCH_IBUF_FULL_CYC",
>> +    "BriefDescription": "Cycles in which no instructions are fetched
>> because there is no room in the instruction buffers."
>> +  },
>> +  {
>> +    "EventCode": "0x00000048B4",
>> +    "EventName": "PM_BR_TKN_UNCOND_FIN",
>> +    "BriefDescription": "An unconditional branch finished. All
>> unconditional branches are taken."
>> +  },
>> +  {
>> +    "EventCode": "0x0B0000016080",
>> +    "EventName": "PM_L2_TLBIE_SLBIE_START",
>> +    "BriefDescription": "NCU Master received a TLBIE/SLBIEG/SLBIAG
>> operation from the core. Event count should be multiplied by 2 since
>> the data is coming from a 2:1 clock domain and the data is time sliced
>> across all 4 threads."
>> +  },
>> +  {
>> +    "EventCode": "0x0B0000016880",
>> +    "EventName": "PM_L2_TLBIE_SLBIE_DELAY",
>> +    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG command
>> was held in a hottemp condition by the NCU Master. Multiply this count
>> by 1000 to obtain the total number of cycles. This can be divided by
>> PM_L2_TLBIE_SLBIE_SENT to obtain the average time a
>> TLBIE/SLBIEG/SLBIAG command was held. Event count should be multiplied
>> by 2 since the data is coming from a 2:1 clock domain and the data is
>> time sliced across all 4 threads."
>> +  },
>> +  {
>> +    "EventCode": "0x0B0000026880",
>> +    "EventName": "PM_L2_SNP_TLBIE_SLBIE_DELAY",
>> +    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG that
>> targets this thread's LPAR was in flight while in a hottemp condition.
>> Multiply this count by 1000 to obtain the total number of cycles. This
>> can be divided by PM_L2_SNP_TLBIE_SLBIE_START to obtain the overall
>> efficiency. Note: ’inflight’ means SnpTLB has been sent to core(ie
>> doesn’t include when SnpTLB is in NCU waiting to be launched serially
>> behind different SnpTLB). The NCU Snooper gets in a ’hottemp’ delay
>> window when it detects it is above its TLBIE/SLBIE threshold for
>> process SnpTLBIE/SLBIE with this core. Event count should be
>> multiplied by 2 since the data is coming from a 2:1 clock domain and
>> the data is time sliced across all 4 threads."
>>     }
>>   ]

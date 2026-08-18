Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB03153BE9;
	Tue, 18 Aug 2026 06:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033635; cv=none; b=u9L9PPUP4uIRqblmVkMr22WH8sqV+Iu29TkH4RLd2D8Lb1X/or9C01zkWs1I0hSfeZVEYnPcpsdJmui2njzSUdMiCyTXTwv2543ann/fK02AAmOrEsceCg1BQHpLdutWEzt0JoflvMaR3jopDbOLhNZ7Z5Savb97AlfDvAfcFsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033635; c=relaxed/simple;
	bh=xhzJIgd86SbzZOE6lz2mPiesFcVWbzdwiUw8/cpBgDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dJy/IrPqjE4yD2d4UDkJFsmCxOjU6n65eZYXtqjfOmR+mzuEtp+cTM99waDq1WcHvp8Qo16qAtZRWlZp6j3By0BiQ3DbttFEoQcRJWtx8FYU95OYax6cQxCpaD3kvausK8bqc07eRmwXhMkH38lcNthkZVGEbEf4GawBKZOsPVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hPKC05Q4kz3LdNf;
	Tue, 18 Aug 2026 14:13:32 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hPKC022BGz3LdNf;
	Tue, 18 Aug 2026 14:13:32 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id A9E78319195A;
	Tue, 18 Aug 2026 14:10:05 +0800 (CST)
Received: from [172.25.61.61] (172.25.61.61) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 18 Aug
 2026 14:13:31 +0800
Message-ID: <b6480f49-eb28-4848-b016-55de34fd525b@hygon.cn>
Date: Tue, 18 Aug 2026 14:13:31 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf vendor events hygon: Add Hygon Data Fabric
 PMU events and metrics
To: Ian Rogers <irogers@google.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<sandipan.das@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>
References: <20260804065606.27532-1-liuqi@hygon.cn>
 <20260804065606.27532-3-liuqi@hygon.cn>
 <CAP-5=fX0nXLsMZMRYb9PHd=OF47BG9RVDPBxnsoFg=yM9NgWOg@mail.gmail.com>
 <7694c07c-cfa8-4b5e-a2e4-046f8df94a3a@hygon.cn>
 <CAP-5=fUWh_1WnMuGV7KO2DB1xdzfxuTuE1KG_e-KS+nqB3t=VA@mail.gmail.com>
Content-Language: en-US
From: Qi Liu <liuqi@hygon.cn>
In-Reply-To: <CAP-5=fUWh_1WnMuGV7KO2DB1xdzfxuTuE1KG_e-KS+nqB3t=VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)



On 8/18/2026 12:28 PM, Ian Rogers wrote:
> On Mon, Aug 17, 2026 at 8:12 PM Qi Liu <liuqi@hygon.cn> wrote:
>> Hi Ian，
>>
>> Thanks for your reply:)
>>
>> On 8/18/2026 6:12 AM, Ian Rogers wrote:
>>> On Tue, Aug 4, 2026 at 12:00 AM Qi Liu <liuqi@hygon.cn> wrote:
>>>>
>>>> Add perf JSON event definitions and metrics for the Hygon Data Fabric (DF)
>>>> uncore PMU.
>>>>
>>>> Signed-off-by: Qi Liu <liuqi@hygon.cn>
>>>> ---
>>>>    tools/perf/pmu-events/Build                   |   2 +-
>>>>    .../arch/x86/hygonm1/data-fabric.json         |  87 ++++++++++
>>>>    .../arch/x86/hygonm4/data-fabric.json         | 122 ++++++++++++++
>>>>    .../arch/x86/hygonm6/data-fabric.json         | 154 ++++++++++++++++++
>>>>    tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +
>>>>    tools/perf/pmu-events/jevents.py              |   2 +
>>>>    6 files changed, 369 insertions(+), 1 deletion(-)
>>>>    create mode 100644 tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
>>>>    create mode 100644 tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
>>>>    create mode 100644 tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
>>>>
>>>> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
>>>> index 372773b998e4..79a9b4cad202 100644
>>>> --- a/tools/perf/pmu-events/Build
>>>> +++ b/tools/perf/pmu-events/Build
>>>> @@ -95,7 +95,7 @@ endif
>>>>
>>>>    ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),x86 all))
>>>>    # Generate Intel Json
>>>> -INTELS := $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
>>>> +INTELS := $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v hygon|grep -v mapfile.csv)
>>>>    INTEL_METRICS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.json)
>>>>    INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json)
>>>>    GEN_JSON += $(INTEL_METRICS) $(INTEL_METRICGROUPS)
>>>> diff --git a/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json b/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
>>>> new file mode 100644
>>>> index 000000000000..99c243bd9ba0
>>>> --- /dev/null
>>>> +++ b/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
>>>> @@ -0,0 +1,87 @@
>>>> +[
>>>> +  {
>>>> +    "EventName": "cpu_read_requests_cs_0",
>>>> +    "BriefDescription": "The number of CPU read requests to memory: Data (64B): CS0",
>>>
>>> Does "Data (64B)" mean that each count should be scaled by 64 and the
>>> units are bytes? In which case adding:
>>> "ScaleUnit": "64Bytes",
>>> Would cause the count to be multiplied by 64 in the perf stat output
>>> and the unit Bytes to be added.
>>>
>> Thank you for pointing this out. Yes, for these CPU memory-request events, Data
>> (64B) means that each count represents a 64-byte data unit. I will add
>> "ScaleUnit": "64Bytes" so that perf stat reports the scaled value in Bytes.
>>
>> The I/O request events are different: each request may carry either 32B or 64B,
>> so I will keep those unscaled and retain the separate minimum/maximum bandwidth
>> metrics.
> 
> Sounds good to me. Fwiw, in other drivers I've scaled by 64 and then
> when the bandwidth is below expectations the explanation are 32B
> requests.
> 
Thank you for the suggestion. I agree that 64B is the common case, will add 
"ScaleUnit": "64Bytes" for the I/O request events and document the possible 
32B-request caveat.

>>> Would it be possible to define terms like CS0?
>> Thank you. I will replace uses such as CS0 with Coherent Slave 0 (CS0) in the
>> event descriptions.
> 
> Thanks for adding the definition! The Linux coding style advocates
> against adding new usage of the term slave:
> https://www.kernel.org/doc/Documentation/process/coding-style.rst
> Maybe subordinate to keep the initials the same.
> 
Thank you for pointing this out. I will use “Coherent Subordinate” in the event 
descriptions while retaining the existing CS abbreviation and event names.

Thanks,
Qi

>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x07",
>>>> +    "ConstId": "0x0",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_read_requests_cs_1",
>>>> +    "BriefDescription": "The number of CPU read requests to memory: Data (64B): CS1",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x07",
>>>> +    "ConstId": "0x1",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_write_requests_cs_0",
>>>> +    "BriefDescription": "The number of CPU write requests to memory: Data (64B): CS0",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x08",
>>>> +    "ConstId": "0x0",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_write_requests_cs_1",
>>>> +    "BriefDescription": "The number of CPU write requests to memory: Data (64B): CS1",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x08",
>>>> +    "ConstId": "0x1",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_read_requests_cs_0",
>>>> +    "BriefDescription": "The number of inbound I/O read requests to memory: Data (32B or 64B): CS0",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x0F",
>>>> +    "ConstId": "0x0",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_read_requests_cs_1",
>>>> +    "BriefDescription": "The number of inbound I/O read requests to memory: Data (32B or 64B): CS1",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x0F",
>>>> +    "ConstId": "0x1",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_write_requests_cs_0",
>>>> +    "BriefDescription": "The number of inbound I/O write requests to memory: Data (32B or 64B): CS0",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x70",
>>>> +    "ConstId": "0x0",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_write_requests_cs_1",
>>>> +    "BriefDescription": "The number of inbound I/O write requests to memory: Data (32B or 64B): CS1",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x70",
>>>> +    "ConstId": "0x1",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "MetricName": "cpu_memory_bandwidth",
>>>> +    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 + cpu_write_requests_cs_0 + cpu_write_requests_cs_1) * 64 / (duration_time * 1e6)",
>>>> +    "BriefDescription": "Total CPU memory access bandwidth",
>>>> +    "MetricGroup": "DF_Memory_BW",
>>>> +    "ScaleUnit": "1MB/s"
>>>> +  },
>>>> +  {
>>>> +    "MetricName": "io_memory_max_bandwidth",
>>>> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_write_requests_cs_0 + io_write_requests_cs_1) * 64 / (duration_time * 1e6)",
>>>> +    "BriefDescription": "Maximum inbound I/O memory access bandwidth (upper bound, assuming 64B per request. Actual inbound I/O requests may be 32B or 64B)",
>>>> +    "MetricGroup": "DF_Memory_BW",
>>>> +    "ScaleUnit": "1MB/s"
>>>> +  },
>>>> +  {
>>>> +    "MetricName": "io_memory_min_bandwidth",
>>>> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_write_requests_cs_0 + io_write_requests_cs_1) * 32 / (duration_time * 1e6)",
>>>> +    "BriefDescription": "Minimum inbound I/O memory access bandwidth (lower bound, assuming 32B per request. Actual inbound I/O requests may be 32B or 64B)",
>>>> +    "MetricGroup": "DF_Memory_BW",
>>>> +    "ScaleUnit": "1MB/s"
>>>> +  }
>>>> +]
>>>> diff --git a/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json b/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
>>>> new file mode 100644
>>>> index 000000000000..f32dcea7061c
>>>> --- /dev/null
>>>> +++ b/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
>>>> @@ -0,0 +1,122 @@
>>>> +[
>>>> +  {
>>>> +    "EventName": "cpu_read_requests_cs_0",
>>>> +    "BriefDescription": "The number of CPU read requests to memory: Data (64B): CS0",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x07",
>>>> +    "ConstId": "0x0",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_read_requests_cs_1",
>>>> +    "BriefDescription": "The number of CPU read requests to memory: Data (64B): CS1",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x07",
>>>> +    "ConstId": "0x1",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_read_requests_cs_2",
>>>> +    "BriefDescription": "The number of CPU read requests to memory: Data (64B): CS2",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x07",
>>>> +    "ConstId": "0x2",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_write_requests_cs_0",
>>>> +    "BriefDescription": "The number of CPU write requests to memory: Data (64B): CS0",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x08",
>>>> +    "ConstId": "0x0",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_write_requests_cs_1",
>>>> +    "BriefDescription": "The number of CPU write requests to memory: Data (64B): CS1",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x08",
>>>> +    "ConstId": "0x1",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_write_requests_cs_2",
>>>> +    "BriefDescription": "The number of CPU write requests to memory: Data (64B): CS2",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x08",
>>>> +    "ConstId": "0x2",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_read_requests_cs_0",
>>>> +    "BriefDescription": "The number of inbound I/O read requests to memory: Data (32B or 64B): CS0",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x0F",
>>>> +    "ConstId": "0x0",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_read_requests_cs_1",
>>>> +    "BriefDescription": "The number of inbound I/O read requests to memory: Data (32B or 64B): CS1",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x0F",
>>>> +    "ConstId": "0x1",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_read_requests_cs_2",
>>>> +    "BriefDescription": "The number of inbound I/O read requests to memory: Data (32B or 64B): CS2",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x0F",
>>>> +    "ConstId": "0x2",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_write_requests_cs_0",
>>>> +    "BriefDescription": "The number of inbound I/O write requests to memory: Data (32B or 64B): CS0",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x70",
>>>> +    "ConstId": "0x0",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_write_requests_cs_1",
>>>> +    "BriefDescription": "The number of inbound I/O write requests to memory: Data (32B or 64B): CS1",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x70",
>>>> +    "ConstId": "0x1",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_write_requests_cs_2",
>>>> +    "BriefDescription": "The number of inbound I/O write requests to memory: Data (32B or 64B): CS2",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x70",
>>>> +    "ConstId": "0x2",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "MetricName": "cpu_memory_bandwidth",
>>>> +    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 + cpu_read_requests_cs_2 + cpu_write_requests_cs_0 + cpu_write_requests_cs_1 + cpu_write_requests_cs_2) * 64 / (duration_time * 1e6)",
>>>> +    "MetricConstraint": "NO_GROUP_EVENTS",
>>>> +    "BriefDescription": "Total CPU memory access bandwidth",
>>>> +    "MetricGroup": "DF_Memory_BW",
>>>> +    "ScaleUnit": "1MB/s"
>>>> +  },
>>>> +  {
>>>> +    "MetricName": "io_memory_max_bandwidth",
>>>> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_read_requests_cs_2 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_write_requests_cs_2) * 64 / (duration_time * 1e6)",
>>>> +    "MetricConstraint": "NO_GROUP_EVENTS",
>>>> +    "BriefDescription": "Maximum inbound I/O memory access bandwidth (upper bound, assuming 64B per request. Actual inbound I/O requests may be 32B or 64B)",
>>>> +    "MetricGroup": "DF_Memory_BW",
>>>> +    "ScaleUnit": "1MB/s"
>>>> +  },
>>>> +  {
>>>> +    "MetricName": "io_memory_min_bandwidth",
>>>> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_read_requests_cs_2 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_write_requests_cs_2) * 32 / (duration_time * 1e6)",
>>>> +    "MetricConstraint": "NO_GROUP_EVENTS",
>>>> +    "BriefDescription": "Minimum inbound I/O memory access bandwidth (lower bound, assuming 32B per request. Actual inbound I/O requests may be 32B or 64B)",
>>>> +    "MetricGroup": "DF_Memory_BW",
>>>> +    "ScaleUnit": "1MB/s"
>>>> +  }
>>>> +]
>>>> diff --git a/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json b/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
>>>> new file mode 100644
>>>> index 000000000000..bff5c0959d82
>>>> --- /dev/null
>>>> +++ b/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
>>>> @@ -0,0 +1,154 @@
>>>> +[
>>>> +  {
>>>> +    "EventName": "cpu_read_requests_cs_0",
>>>> +    "BriefDescription": "The number of CPU read requests to memory: Data (64B): CS0",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x07",
>>>> +    "ConstId": "0x0",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_read_requests_cs_1",
>>>> +    "BriefDescription": "The number of CPU read requests to memory: Data (64B): CS1",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x07",
>>>> +    "ConstId": "0x1",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_read_requests_cs_2",
>>>> +    "BriefDescription": "The number of CPU read requests to memory: Data (64B): CS2",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x07",
>>>> +    "ConstId": "0x2",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_read_requests_cs_3",
>>>> +    "BriefDescription": "The number of CPU read requests to memory: Data (64B): CS3",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x07",
>>>> +    "ConstId": "0x3",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_write_requests_cs_0",
>>>> +    "BriefDescription": "The number of CPU write requests to memory: Data (64B): CS0",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x08",
>>>> +    "ConstId": "0x0",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_write_requests_cs_1",
>>>> +    "BriefDescription": "The number of CPU write requests to memory: Data (64B): CS1",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x08",
>>>> +    "ConstId": "0x1",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_write_requests_cs_2",
>>>> +    "BriefDescription": "The number of CPU write requests to memory: Data (64B): CS2",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x08",
>>>> +    "ConstId": "0x2",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "cpu_write_requests_cs_3",
>>>> +    "BriefDescription": "The number of CPU write requests to memory: Data (64B): CS3",
>>>> +    "EventCode": "0x2",
>>>> +    "UMask": "0x08",
>>>> +    "ConstId": "0x3",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_read_requests_cs_0",
>>>> +    "BriefDescription": "The number of inbound I/O read requests to memory: Data (32B or 64B): CS0",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x0F",
>>>> +    "ConstId": "0x0",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_read_requests_cs_1",
>>>> +    "BriefDescription": "The number of inbound I/O read requests to memory: Data (32B or 64B): CS1",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x0F",
>>>> +    "ConstId": "0x1",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_read_requests_cs_2",
>>>> +    "BriefDescription": "The number of inbound I/O read requests to memory: Data (32B or 64B): CS2",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x0F",
>>>> +    "ConstId": "0x2",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_read_requests_cs_3",
>>>> +    "BriefDescription": "The number of inbound I/O read requests to memory: Data (32B or 64B): CS3",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x0F",
>>>> +    "ConstId": "0x3",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_write_requests_cs_0",
>>>> +    "BriefDescription": "The number of inbound I/O write requests to memory: Data (32B or 64B): CS0",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x70",
>>>> +    "ConstId": "0x0",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_write_requests_cs_1",
>>>> +    "BriefDescription": "The number of inbound I/O write requests to memory: Data (32B or 64B): CS1",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x70",
>>>> +    "ConstId": "0x1",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_write_requests_cs_2",
>>>> +    "BriefDescription": "The number of inbound I/O write requests to memory: Data (32B or 64B): CS2",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x70",
>>>> +    "ConstId": "0x2",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "EventName": "io_write_requests_cs_3",
>>>> +    "BriefDescription": "The number of inbound I/O write requests to memory: Data (32B or 64B): CS3",
>>>> +    "EventCode": "0x3",
>>>> +    "UMask": "0x70",
>>>> +    "ConstId": "0x3",
>>>> +    "Unit": "HYGON_DF"
>>>> +  },
>>>> +  {
>>>> +    "MetricName": "cpu_memory_bandwidth",
>>>> +    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 + cpu_read_requests_cs_2 + cpu_read_requests_cs_3 + cpu_write_requests_cs_0 + cpu_write_requests_cs_1 + cpu_write_requests_cs_2 + cpu_write_requests_cs_3) * 64 / (duration_time * 1e6)",
>>>> +    "MetricConstraint": "NO_GROUP_EVENTS",
>>>> +    "BriefDescription": "Total CPU memory access bandwidth",
>>>> +    "MetricGroup": "DF_Memory_BW",
>>>> +    "ScaleUnit": "1MB/s"
>>>> +  },
>>>> +  {
>>>> +    "MetricName": "io_memory_max_bandwidth",
>>>> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_read_requests_cs_2 + io_read_requests_cs_3 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_write_requests_cs_2 + io_write_requests_cs_3) * 64 / (duration_time * 1e6)",
>>>> +    "MetricConstraint": "NO_GROUP_EVENTS",
>>>> +    "BriefDescription": "Maximum inbound I/O memory access bandwidth (upper bound, assuming 64B per request. Actual inbound I/O requests may be 32B or 64B)",
>>>> +    "MetricGroup": "DF_Memory_BW",
>>>> +    "ScaleUnit": "1MB/s"
>>>> +  },
>>>> +  {
>>>> +    "MetricName": "io_memory_min_bandwidth",
>>>> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_read_requests_cs_2 + io_read_requests_cs_3 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_write_requests_cs_2 + io_write_requests_cs_3) * 32 / (duration_time * 1e6)",
>>>> +    "MetricConstraint": "NO_GROUP_EVENTS",
>>>> +    "BriefDescription": "Minimum inbound I/O memory access bandwidth (lower bound, assuming 32B per request. Actual inbound I/O requests may be 32B or 64B)",
>>>> +    "MetricGroup": "DF_Memory_BW",
>>>> +    "ScaleUnit": "1MB/s"
>>>> +  }
>>>> +]
>>>> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
>>>> index 50a403b429b1..ba17117245d1 100644
>>>> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
>>>> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
>>>> @@ -45,3 +45,6 @@ AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
>>>>    AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen4,core
>>>>    AuthenticAMD-26-([12467][[:xdigit:]]|[[:xdigit:]]),v1,amdzen5,core
>>>>    AuthenticAMD-26-[[:xdigit:]]+,v1,amdzen6,core
>>>> +HygonGenuine-24-[0123],v1,hygonm1,core
>>>> +HygonGenuine-24-[45],v1,hygonm4,core
>>>> +HygonGenuine-24-(1[012345678]|[6789ABCDEF]),v1,hygonm6,core
>>>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>>>> index 376dc2d24162..63ae3a763a4f 100755
>>>> --- a/tools/perf/pmu-events/jevents.py
>>>> +++ b/tools/perf/pmu-events/jevents.py
>>>> @@ -294,6 +294,7 @@ class JsonEvent:
>>>>              'L3PMC': 'amd_l3',
>>>>              'DFPMC': 'amd_df',
>>>>              'UMCPMC': 'amd_umc',
>>>> +          'HYGON_DF': 'hygon_df',
>>>>              'cpu_core': 'cpu_core',
>>>>              'cpu_atom': 'cpu_atom',
>>>>              'ali_drw': 'ali_drw',
>>>> @@ -390,6 +391,7 @@ class JsonEvent:
>>>>            ('Invert', 'inv='),
>>>>            ('SampleAfterValue', 'period='),
>>>>            ('UMask', 'umask='),
>>>> +        ('ConstId', 'constid='),
>>>
>>> Is Const a shortening of Constant? It seems a little redundant in the
>>> format name. Would CsId be more intention revealing? I don't know what
>>> CS means, but this at least looks a little more intuitive to me than
>>> Constant :-)
>>>
>> Thank you for the suggestion. ConstId stands for Component Select ID. It
>> identifies the selected Data Fabric component instance, and I agree that the
>> current name is not particularly intuitive. I will rename it to CompId
>> (Component ID) in the next revision.
> 
> Many thanks!
> Ian
> 
>> Thanks,
>> Qi> Thanks,
>>> Ian
>>>
>>>>            ('NodeType', 'type='),
>>>>            ('RdWrMask', 'rdwrmask='),
>>>>            ('EnAllCores', 'enallcores='),
>>>> --
>>>> 2.34.1
>>>>
>>>>
>>>>
>>>
>>
>>
> 



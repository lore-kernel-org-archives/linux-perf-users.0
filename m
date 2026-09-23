Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7423BBFD6;
	Wed, 23 Sep 2026 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154084; cv=none; b=RCxuUsAXLFgPBckT9K20oyt4qDURSBYILfZ14JnR4W8/0drZ4KL39Z/VlHdRRtlydc2wcK5hrqkK3M0JLwPVUwZBnLcV4QMeBnfSZ6xAozRFBD4se+Rfm9G2lqF2X02CuVc0jLfl2JTG/TOlgNJWuN90SBqCik8M6OEWsPiNp34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154084; c=relaxed/simple;
	bh=eaDRSMhxRUUCK8R+oUyIpxydo2lKh37HrMtX6/5Mmbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eHa7nZ/9DGIh2rATEmS4a/hjP0ZlOehcwjx6th3zJsvTrkGzvJUtX2a5K3LYTIwugrmjXjuh0oG6gqhqtbvtyRwPA98YZe9rTALy7Ai/MraoPJUosfd6H364LYGRVtMVAMY8P7rH+KC0rToHWGc5WzgZVO/AztaVYv81MGhNn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hqWCP5wfczTSdw;
	Wed, 23 Sep 2026 17:00:49 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hqWCM1QqJzTSds;
	Wed, 23 Sep 2026 17:00:47 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 499A63027FF0;
	Wed, 23 Sep 2026 16:56:16 +0800 (CST)
Received: from [127.0.0.1] (10.0.235.124) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 23 Sep
 2026 17:00:36 +0800
Message-ID: <78aec2a6-e1e8-4260-806d-cbe90e0faaa1@hygon.cn>
Date: Wed, 23 Sep 2026 17:00:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] perf vendor events hygon: Add Hygon Data Fabric
 PMU events and metrics
To: Sandipan Das <sandipan.das@amd.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<ravi.bangoria@amd.com>, <irogers@google.com>, <x86@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>
References: <20260818100118.12944-1-liuqi@hygon.cn>
 <20260818100118.12944-3-liuqi@hygon.cn>
 <79ff1562-d910-418c-b5b5-92d217cdc568@amd.com>
Content-Language: en-US
From: Qi Liu <liuqi@hygon.cn>
In-Reply-To: <79ff1562-d910-418c-b5b5-92d217cdc568@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

Hi Sandipan,

Sorry for the delayed reply.

On 8/19/2026 1:11 PM, Sandipan Das wrote:
> On 18-08-2026 15:31, Qi Liu wrote:
>> Add perf JSON event definitions and metrics for the Hygon Data Fabric (DF)
>> uncore PMU.
>>
>> Signed-off-by: Qi Liu <liuqi@hygon.cn>
>> ---
>>   tools/perf/pmu-events/Build                   |   2 +-
>>   .../arch/x86/hygonm1/data-fabric.json         |  95 ++++++++++
>>   .../arch/x86/hygonm4/data-fabric.json         | 134 ++++++++++++++
>>   .../arch/x86/hygonm6/data-fabric.json         | 170 ++++++++++++++++++
>>   tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +
>>   tools/perf/pmu-events/jevents.py              |   2 +
>>   6 files changed, 405 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
>>   create mode 100644 tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
>>   create mode 100644 tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
>>
>> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
>> index 372773b998e4..79a9b4cad202 100644
>> --- a/tools/perf/pmu-events/Build
>> +++ b/tools/perf/pmu-events/Build
>> @@ -95,7 +95,7 @@ endif
>>   
>>   ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),x86 all))
>>   # Generate Intel Json
>> -INTELS := $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
>> +INTELS := $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v hygon|grep -v mapfile.csv)
>>   INTEL_METRICS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.json)
>>   INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json)
>>   GEN_JSON += $(INTEL_METRICS) $(INTEL_METRICGROUPS)
>> diff --git a/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json b/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
>> new file mode 100644
>> index 000000000000..8c6a8e9ba9a5
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
>> @@ -0,0 +1,95 @@
>> +[
>> +  {
>> +    "EventName": "cpu_read_requests_cs_0",
>> +    "BriefDescription": "Number of CPU read requests to memory in 64-byte units for Coherent Subordinate 0 (CS0).",
> 
> Coherent Station is the correct term, if you go by the terminology in AMD
> PPRs. Since CSes are the interfaces between the data fabric and the memory
> controllers (UMCs), it may be better to rephrase the descriptions as read
> or write requests to DRAM channel 0..N which are backed by UMC 0..N and
> CS 0..N.

Thanks,I will update "Coherent Subordinate" to "Coherent Station".

Yes, CSes provide the interface between the data fabric and UMCs. Since the 
UMC-to-DRAM-channel topology may vary across platforms, would it be reasonable 
to avoid referring to DRAM channels in the event descriptions?

I was thinking of wording the description as follows:
   "Number of CPU read requests associated with Coherent Station 0 (CS0) and the 
UMC."

> 
>> +    "EventCode": "0x2",
>> +    "UMask": "0x07",
>> +    "CompId": "0x0",
>> +    "Unit": "HYGON_DF",
>> +    "ScaleUnit": "64Bytes"
> 
> As the naming suggests, my understanding is that these events count the
> number of requests and each request carries a 64-byte payload. Perhaps
> the ScaleUnit needs to be factored into the bandwidth metrics instead of
> the individual events.
> 

Thanks,I will remove the "64Bytes" ScaleUnit from the individual request
events in v6.

The bandwidth MetricExprs already apply the payload size: * 64 for the
CPU bandwidth and I/O upper-bound metrics, and * 32 for the I/O
lower-bound metric. I plan to retain those conversions in the metrics.

Does that match your suggestion?

Thanks,
Qi





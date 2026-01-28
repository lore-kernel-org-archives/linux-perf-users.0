Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A0346FA8
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592997; cv=none; b=M7rke+OGxHkkr+OmqNdFX5t1apsextaz83INVYK8jpTnxvzoLKenwehUEa6326qCY8Yx+AYEgZ4N6jwahQUkIjse+69ArknHq9qf8r9a7OszsTEMCIP22/rsLgFGi8XPgdDo/zw2gI+plDYhiD/L8B7Qe5jHOKZwHESIhZyruxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592997; c=relaxed/simple;
	bh=/uC7aNV9amlBzPrhhufTmDfbCA17HBx2GKUUDq1+IJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIWNt5ubOrLOkQf/pn30kN6AthWzlzv/vvOELaaT4L/QzbSfBA+vyGalma7Sd8kp0WcbVe8dUAlu6iAnt6L3qia+x26WTCB7TieZJpDPwuW73Byj6033QIqwodG01EQp5MHRmBwuy7Cis6N/QpUux51Iv3uB7xHWAr+TGIIID90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dG71KE7k; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dG71KE7k"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43284ed32a0so3925806f8f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 01:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769592994; x=1770197794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DhF98Nun2om+lYN0JL6mwSJXbtKFe/yYyeyl1TtEz3I=;
        b=dG71KE7kpxiyPenfxxeUrV0UfFdSFGJ1bmHG7uxyFUth9c3yFzJSXd2gWc1t5sdCgc
         81S0udSd2krx5IeZ1od3ooBtamv781h1SXEwgELG4/GyjJjQ2IUt9rKmcCrehQ/rKBkV
         Cxo/Tv82NWk8uPYGS3B8+q7BclRmhR7WycGi0s6bs/8z1mboVoWX8t4z99hmGV4DmK8S
         1i9HscDHczThS+fUJFEkqnAb8howqsSUJeI6xtflRk/wuZXRIaxUbYMLyNBj3g8FT/Zo
         WMhTFJj4ej7t/J1pHSoG0SdIvKJvGv3TUqUsUYEkKmnswoXe/EpG7vFXIDgELVgR7/kU
         E1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769592994; x=1770197794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhF98Nun2om+lYN0JL6mwSJXbtKFe/yYyeyl1TtEz3I=;
        b=A7MQGQaOkzUxtLOLK2IcGHln7xgg3F8J6bHiwPYl7LHwD2L2nZQYVGH0wOiionC+E7
         oOgzMUX80s6q09h05cprxnEunk5blavL1mGIxWZ1Y0OKdmtY5IRBsdwlVKZzWw1MCvto
         zefDvDzxRZ2D05f1n6X/2jHEN7eMsYwli9SRwKivgTN4fmtl1QBwFaOwIcHzII21RFo2
         OmkUh85RXyU02mlKjWa8oEwT9HqJknkAnG1MVEqxfhRSiO/HrJhpgs6qn8VJtP6Imc9E
         LHZnaQCF/rFp5pmcuQESSnWOTXgHrw6u+LQAJziPK9U5SE+88YaUKtQSLuJ3FYYlZMmS
         b7Tg==
X-Forwarded-Encrypted: i=1; AJvYcCX+z/Mxca7j1f/aN9CkqfCqUqui381mIzh2JzpDz1OBwIpUrUr4zwlUBcrG5Vm66cpZWY7mtUjuhffXKB+8Y8hq@vger.kernel.org
X-Gm-Message-State: AOJu0YzYIJ3R+46Dfs1LDETgH0AgTw7O2wjAOAHqjSk6OTstJw5hYqdo
	SLjJCmmOBMuCOWaLuoRDQhITNZEXiPupxd9Jeto5PfEEYYd7IJN24qdOZbWK4urPmRo=
X-Gm-Gg: AZuq6aJWKanFYwRpbyEDt0tNpMAU1yXuDwXjqph0QHv9Xt21oTSEVcCsb5twlNK0X5t
	EMzhoPLbdVIGquI2upT/6bj2gOfh0spmo0nI3qSSy5atMgEdLrG5/rncXbiMkr8mwxfWkJER/3Z
	YWshzMOxB+mgj3gTsWUChGvXC0ZlN3BLYo+lZZw7gNz/FZ0QVolDJC7UJjJ03JgCwE6a5JksEku
	pamvUo/rg8O3lYltR9jWfcqllErwKIunAZbpca1LdbnTCo4dHEnYLtTRuIU36rSI4saPcNwzwfu
	TbeedhuIE9z7JVcThHZbroYMaaqq7lRkPuXwT2TAiXpieAJmxhoE9sJGnOQVKdCGu7eCldBe3xX
	E9LirEeFDTd4/iccbcbX5KfwSrrNRH2X8KhvVOvv60Gcx/TduO7lrwE1ZYD4xjP8QCusHHrxLSP
	Z0p8ZZTjOXeeaw6k5hnIFKoTyP2xs=
X-Received: by 2002:a5d:5f43:0:b0:435:907f:e439 with SMTP id ffacd0b85a97d-435dd05c4bamr6010824f8f.18.1769592994091;
        Wed, 28 Jan 2026 01:36:34 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4762sm5489795f8f.6.2026.01.28.01.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 01:36:33 -0800 (PST)
Message-ID: <40988c57-ee6f-4693-afe4-2615dc43f395@linaro.org>
Date: Wed, 28 Jan 2026 09:36:32 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64: Add Tegra410 Olympus PMU events
To: Ian Rogers <irogers@google.com>, Besar Wicaksono <bwicaksono@nvidia.com>
Cc: john.g.garry@oracle.com, will@kernel.org, mike.leach@linaro.org,
 leo.yan@linux.dev, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, adrian.hunter@intel.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 tmakin@nvidia.com, vsethi@nvidia.com, rwiley@nvidia.com, skelley@nvidia.com,
 ywan@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com, mochs@nvidia.com
References: <20260127225909.3296202-1-bwicaksono@nvidia.com>
 <CAP-5=fUxhbR1xs1f9mrkcUXZZNLrVqDG0ebhwW--WtgVRnNxNw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fUxhbR1xs1f9mrkcUXZZNLrVqDG0ebhwW--WtgVRnNxNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28/01/2026 8:03 am, Ian Rogers wrote:
> On Tue, Jan 27, 2026 at 3:00 PM Besar Wicaksono <bwicaksono@nvidia.com> wrote:
>>
>> Add JSON files for NVIDIA Tegra410 Olympus core PMU events.
>> Also updated the common-and-microarch.json.
>>
>> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
>> ---
>>   .../arch/arm64/common-and-microarch.json      |  90 +++
>>   tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
>>   .../arch/arm64/nvidia/t410/branch.json        |  45 ++
>>   .../arch/arm64/nvidia/t410/brbe.json          |   6 +
>>   .../arch/arm64/nvidia/t410/bus.json           |  48 ++
>>   .../arch/arm64/nvidia/t410/exception.json     |  62 ++
>>   .../arch/arm64/nvidia/t410/fp_operation.json  |  78 ++
>>   .../arch/arm64/nvidia/t410/general.json       |  15 +
>>   .../arch/arm64/nvidia/t410/l1d_cache.json     | 122 +++
>>   .../arch/arm64/nvidia/t410/l1i_cache.json     | 114 +++
>>   .../arch/arm64/nvidia/t410/l2d_cache.json     | 134 ++++
>>   .../arch/arm64/nvidia/t410/ll_cache.json      | 107 +++
>>   .../arch/arm64/nvidia/t410/memory.json        |  46 ++
>>   .../arch/arm64/nvidia/t410/metrics.json       | 722 ++++++++++++++++++
>>   .../arch/arm64/nvidia/t410/misc.json          | 646 ++++++++++++++++
>>   .../arch/arm64/nvidia/t410/retired.json       |  94 +++
>>   .../arch/arm64/nvidia/t410/spe.json           |  42 +
>>   .../arm64/nvidia/t410/spec_operation.json     | 230 ++++++
>>   .../arch/arm64/nvidia/t410/stall.json         | 145 ++++
>>   .../arch/arm64/nvidia/t410/tlb.json           | 158 ++++
>>   20 files changed, 2905 insertions(+)
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/brbe.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/bus.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/exception.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/fp_operation.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/general.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/l1d_cache.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/l1i_cache.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/l2d_cache.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/ll_cache.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/memory.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/misc.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/retired.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/spe.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/spec_operation.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/stall.json
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/tlb.json
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
>> index 468cb085d879..6af15776ff17 100644
>> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
>> +++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
>> @@ -179,6 +179,11 @@
>>           "EventName": "BUS_CYCLES",
>>           "BriefDescription": "Bus cycle"
>>       },
>> +    {
>> +        "EventCode": "0x001E",
>> +        "EventName": "CHAIN",
>> +        "BriefDescription": "Chain a pair of event counters."
>> +    },
> 
> Cool stuff :-)
> 
> For wider counters AMD does something similar, but should this be an
> implementation detail rather than an exposed event? How does it
> operate as an event?
> 

CHAIN should be excluded from the json, it's used internally by the 
driver when you want 64 bit counters. Userspace can't use it because it 
can't control where counters are placed to make sure they're adjacent.

> [snip]
>> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> index bb3fa8a33496..7f0eaa702048 100644
>> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> @@ -46,3 +46,4 @@
>>   0x00000000500f0000,v1,ampere/emag,core
>>   0x00000000c00fac30,v1,ampere/ampereone,core
>>   0x00000000c00fac40,v1,ampere/ampereonex,core
>> +0x000000004e0f0100,v1,nvidia/t410,core
>> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
>> new file mode 100644
>> index 000000000000..532bc59dc573
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
>> @@ -0,0 +1,45 @@
>> +[
>> +    {
>> +        "ArchStdEvent": "BR_MIS_PRED",
>> +        "PublicDescription": "The Event counts Branches which are speculatively executed and mis-predicted."
> 
> nit: The capitalization on Event and Branches, as well as other words,
> is a little unusual.
> 

If there's nothing specific to this CPU then the public description 
could be left out entierly. The common strings already say the same 
thing as this:

     {
         "PublicDescription": "Mispredicted or not predicted branch
                               speculatively executed",
         "EventCode": "0x10",
         "EventName": "BR_MIS_PRED",
         "BriefDescription": "Mispredicted or not predicted branch
                              speculatively executed"
     },


> [snip]
>> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
>> new file mode 100644
>> index 000000000000..18c2fd58ee9e
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
>> @@ -0,0 +1,722 @@
>> +[
>> +    {
>> +        "MetricName": "backend_bound",
>> +        "MetricExpr": "100 * (STALL_SLOT_BACKEND / CPU_SLOT)",
>> +        "BriefDescription": "This metric is the percentage of total slots that were stalled due to resource constraints in the backend of the processor.",
>> +        "ScaleUnit": "1percent of slots",
>> +        "MetricGroup": "TopdownL1"
> 
> Note, on x86 we place TopdownL1 in the Default metric group so it is
> shown by `perf stat` when it isn't given events or metrics to compute.
> Perhaps you want to do something similar?
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json?h=tmp.perf-tools-next#n116
> 
> Thanks,
> Ian

That's currently true for the Arm topdown metrics in sbsa.json, but we 
probably don't actually want this because there aren't enough counters 
for the perf stat defaults plus topdown and it results in multiplexing 
and bad results.

I was planning to change it but we also don't currently expose the 
number of counters available either...



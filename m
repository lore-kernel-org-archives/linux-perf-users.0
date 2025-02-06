Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1323956E;
	Thu,  6 Feb 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861876; cv=none; b=NoWX0yQ3z+OJ0XloqTeu+TpeD7Rc9UlghyQrn3oTRvqHx3Snk/Up7w5bpjAKtZhbXFv9JcCWHc3EFv3LG4EsD+dc9JAwbGTChSegKOziG66nFcnYj5OWxCYuOuxC/1jUyGJgkap1cNOXG6lWH0ibxuDI+F7XGfDDRtX+9iGd07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861876; c=relaxed/simple;
	bh=cWxBWTwqpP2nCNfz/yrKSUX4s5IM1deX21iZp/tEi00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bq0nsmHMUaGQorVJqYriBB2CYu4dAoX+fS2sSJ81BKU7/FNY87kOsETecZgilkOwwPlNOqlRMKO04BInY10m0Si+Dh9uxrqMyrqiHGRjn3jlFGtO4lhJ/UBOeYUuIX8Cls8cFFDl/L8A6fN0NA7sli6M65OW3L9LJmwuEuqPXXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYW3UQiq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYW3UQiq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738861874; x=1770397874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cWxBWTwqpP2nCNfz/yrKSUX4s5IM1deX21iZp/tEi00=;
  b=ZYW3UQiqqjUw41pWJDibI2JktVh+ogGswXBbfPH7E8VbWmPzfT7b/NtA
   vWjdONk5qOQ7DvQZ4EOkgbZBxER+v0KmmjLx1KqU/2pzLJUheKQbwEtRi
   UmCl3MhNIZSwpKvsVGJRT9xLXswUoc8xoUxTnDHsFVPt1ybKBWYUpyGgs
   0srtnOiGYcgBTz8WoTxlp6KWT3+JVv58HyKh8zGiP1IDpfnYzlBL5iPtq
   AdW0XJ1YyxQKXqXtMpY0k64iWa477lu5CajMiAfqKSaxqjA3WHt+PKgPU
   4WsmhBZsJD3sCjwYLVg6viMeJ+XYOqT89igaqKFgLBnU6yntJ5M5Vn5lF
   g==;
X-CSE-ConnectionGUID: O+xE7auVQsKp79DJ6YmJXA==
X-CSE-MsgGUID: lFzYNQbLRAK5ttwc09IkTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="57023362"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="57023362"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 09:11:13 -0800
X-CSE-ConnectionGUID: 6ojfdq7xRte5Xpncwd9ykA==
X-CSE-MsgGUID: GF6P6KGSRl6qZO5krlSoNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111120171"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 09:11:12 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E992A20B5713;
	Thu,  6 Feb 2025 09:11:10 -0800 (PST)
Message-ID: <51732c12-b5d7-4b81-8ea5-79e87b87795d@linux.intel.com>
Date: Thu, 6 Feb 2025 12:11:09 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/24] perf vendor events: Update/add Graniterapids
 events/metrics
To: Ian Rogers <irogers@google.com>, Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>,
 Samantha Alt <samantha.alt@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>,
 Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>
References: <20250205173140.238294-1-irogers@google.com>
 <20250205173140.238294-12-irogers@google.com>
 <7692d2d6-16d5-4f50-8c3a-37f1db356426@linux.intel.com>
 <CAP-5=fU+9MgMbQKpFix+Jw8k+-_yfAs-F+FYE4CmTWxevPmd-A@mail.gmail.com>
 <9fa56c75-2ee6-4901-9e04-0ec23412fd62@linux.intel.com>
 <CAP-5=fWpbXSwZq5biRZ1fjcSJY2DO4g=cv-0K8jZ1Gzv3bOfhA@mail.gmail.com>
 <58e08371-8d43-4f84-baaf-64b0af95c7cb@linux.intel.com>
 <CAP-5=fX+u_Un-WYKA35sc366kniuXFVfRDT+dzWd-axTG5PmpA@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fX+u_Un-WYKA35sc366kniuXFVfRDT+dzWd-axTG5PmpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-02-06 11:40 a.m., Ian Rogers wrote:
> On Thu, Feb 6, 2025 at 6:32 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>> On 2025-02-05 4:33 p.m., Ian Rogers wrote:
>>> On Wed, Feb 5, 2025 at 1:10 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>> On 2025-02-05 3:23 p.m., Ian Rogers wrote:
>>>>> On Wed, Feb 5, 2025 at 11:11 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>>
>>>>>> On 2025-02-05 12:31 p.m., Ian Rogers wrote:
>>>>>>> +    {
>>>>>>> +        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>>>>>>> +        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
>>>>>>> +        "MetricGroup": "BvUW;TmaL1;TopdownL1;tma_L1_group",
>>>>>>> +        "MetricName": "tma_retiring",
>>>>>>> +        "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>>>>>>> +        "MetricgroupNoGroup": "TopdownL1",
>>>>>>> +        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>>>>>>> +        "ScaleUnit": "100%"
>>>>>>> +    },
>>>>>>
>>>>>> The "Default" tag is missed for GNR as well.
>>>>>> It seems the new CPUIDs are not added in the script?
>>>>>
>>>>> Spotted it, we need to manually say which architectures with TopdownL1
>>>>> should be in Default because it was insisted upon that pre-Icelake
>>>>> CPUs with TopdownL1 not have TopdownL1 in Default. As you know, my
>>>>> preference would be to always put TopdownL1 metrics into Default.
>>>>>
>>>>
>>>> For the future platforms, there should be always at least TopdownL1
>>>> support. Intel even adds extra fixed counters for the TopdownL1 events.
>>>>
>>>> Maybe the script should be changed to only mark the old pre-Icelake as
>>>> no TopdownL1 Default. For the other platforms, always add TopdownL1 as
>>>> Default. It would avoid manually adding it for every new platforms.
>>>
>>> That's fair. What about TopdownL2 that is currently only in the
>>> Default set for SPR?
>>>
>>
>> Yes, the TopdownL2 is a bit tricky, which requires much more events.
>> Could you please set it just for SPR/EMR/GNR for now?
>>
>> I will ask around internally and make a long-term solution for the
>> TopdownL2.
> 
> Thanks Kan, I've updated the script the existing way for now. Thomas
> saw another issue with TSC which is also fixed. I'm trying to
> understand what happened with it before sending out v6:
> https://lore.kernel.org/lkml/4f42946ffdf474fbf8aeaa142c25a25ebe739b78.camel@intel.com/
> """
> There are all some errors like this,
> 
> Testing tma_cisc
> Metric contains missing events
> Cannot resolve IDs for tma_cisc: cpu_atom@TOPDOWN_FE_BOUND.CISC@ / (5
> * cpu_atom@CPU_CLK_UNHALTED.CORE@)
> """
> But checking the json I wasn't able to spot a model with the metric
> and without these json events. Knowing the model would make my life
> easier :-)
> 

The problem should be caused by the fundamental Topdown metrics, e.g.,
tma_frontend_bound, since the MetricThreshold of the tma_cisc requires
the Topdown metrics.

$ ./perf stat -M tma_frontend_bound
Cannot resolve IDs for tma_frontend_bound:
cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (8 * cpu_atom@CPU_CLK_UNHALTED.CORE@)


The metric itself is correct.

+        "BriefDescription": "Counts the number of issue slots that were
not consumed by the backend due to frontend stalls.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (8 *
cpu_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_frontend_bound",
+        "MetricThreshold": "(tma_frontend_bound >0.20)",
+        "MetricgroupNoGroup": "TopdownL1",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },

However, when I dump the debug information,
./perf stat -M tma_frontend_bound -vvv

I got below debug information. I have no idea where the slot is from.
It seems the perf code mess up the p-core metrics with the e-core
metrics. But why only slot?
It seems a bug of perf tool.

found event cpu_atom@CPU_CLK_UNHALTED.CORE@
found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
found event slots
Parsing metric events
'{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/,slots/metric-id=slots/}:W'


Thanks,
Kan

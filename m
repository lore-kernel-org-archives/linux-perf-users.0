Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC41DAC81;
	Wed,  5 Feb 2025 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789830; cv=none; b=IHSNU2TkO/KV/601CkL/2YcR48C8cvwhbFZ+5kmx+NNmBXLJG0cgvzO1e6vQxf4nN9ENrIuCA3lMjtAcQb7gw+3IFY6ItshPim62xFrKTq++2Fh7YC32Agg/Zh86Ut5CKa37NUFmkETbjt/NRFJDcrFre8nk8plVShkn2Sc25Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789830; c=relaxed/simple;
	bh=waEsR76JgTt8wCqm9KYbGxyj3uS9lAiElYbWB5829Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADVKZGP3syb1/dM1Qy7EWVb1Mx/sUmK68N9yCHRtmg97D3IGDqD5vZx2g+wFtoYfl5RIVd+93p7lX+3HwXMFi4AHG0TeUnTaDhD1DmxU/X6whpOySjCqUJC93oWcPFplmw1HjnFfSEdJtCUcVR8ZCHU7mlen72yH4/DnkNvhcPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7rVNN6T; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7rVNN6T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738789829; x=1770325829;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=waEsR76JgTt8wCqm9KYbGxyj3uS9lAiElYbWB5829Ks=;
  b=k7rVNN6TSqg6C56wamlWy52zQaEKS6+3vbDWqGVAsntFITxFogvy8ouD
   zR8ckJCjuuo7c5nd/iVPhzrZAgI1EPNiZOFPvf9wKKH1yL7IBfl81FgV8
   lf6rh4Mx1wHQTpiMaVYTSTKPiiLAUrICO0xH23qD6r7YNlvsT5BGc5S4p
   I0ViWIemepi2Lj9ZDXINMJQjqFpl0S6/GrmEFweDGNJDFqBImrV5b1W3X
   KGasucXJy5YtfSUM9JI4xPLmFo7ydZTaHniVHlEyj8HGsS4d/ez02wLSJ
   5E0nnfmtYTL6CUFakvcmX0HGdREAC/4Cy+NO9Nras9TUnqdawOXcWwRlv
   Q==;
X-CSE-ConnectionGUID: lyfHZFyoRbi+b2JCxx7DSg==
X-CSE-MsgGUID: UEBeTuWeQWSUqTKwqNsNAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39402713"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="39402713"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 13:10:28 -0800
X-CSE-ConnectionGUID: 6kdtUtOtSfyTqUKOezmubw==
X-CSE-MsgGUID: ci/i+2ncR7eIhnmVAkdyLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110866738"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 13:10:27 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 998EC20B5713;
	Wed,  5 Feb 2025 13:10:24 -0800 (PST)
Message-ID: <9fa56c75-2ee6-4901-9e04-0ec23412fd62@linux.intel.com>
Date: Wed, 5 Feb 2025 16:10:22 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/24] perf vendor events: Update/add Graniterapids
 events/metrics
To: Ian Rogers <irogers@google.com>
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
 Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>,
 Thomas Falcon <thomas.falcon@intel.com>
References: <20250205173140.238294-1-irogers@google.com>
 <20250205173140.238294-12-irogers@google.com>
 <7692d2d6-16d5-4f50-8c3a-37f1db356426@linux.intel.com>
 <CAP-5=fU+9MgMbQKpFix+Jw8k+-_yfAs-F+FYE4CmTWxevPmd-A@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fU+9MgMbQKpFix+Jw8k+-_yfAs-F+FYE4CmTWxevPmd-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-02-05 3:23 p.m., Ian Rogers wrote:
> On Wed, Feb 5, 2025 at 11:11 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2025-02-05 12:31 p.m., Ian Rogers wrote:
>>> +    {
>>> +        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>>> +        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
>>> +        "MetricGroup": "BvUW;TmaL1;TopdownL1;tma_L1_group",
>>> +        "MetricName": "tma_retiring",
>>> +        "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>>> +        "MetricgroupNoGroup": "TopdownL1",
>>> +        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>
>> The "Default" tag is missed for GNR as well.
>> It seems the new CPUIDs are not added in the script?
> 
> Spotted it, we need to manually say which architectures with TopdownL1
> should be in Default because it was insisted upon that pre-Icelake
> CPUs with TopdownL1 not have TopdownL1 in Default. As you know, my
> preference would be to always put TopdownL1 metrics into Default.
> 

For the future platforms, there should be always at least TopdownL1
support. Intel even adds extra fixed counters for the TopdownL1 events.

Maybe the script should be changed to only mark the old pre-Icelake as
no TopdownL1 Default. For the other platforms, always add TopdownL1 as
Default. It would avoid manually adding it for every new platforms.

Thanks,
Kan


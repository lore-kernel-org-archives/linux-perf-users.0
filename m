Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C1236427;
	Thu,  6 Feb 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852331; cv=none; b=OenKnP/f+d37iGWz8UnqvHe2pUx4TYYttHJkrV9RPfS5SgC7BtkTJlJXchGzsaawcyGnpqtKWYM5dQKmhY4reGWevJihoOTfX2uj6q3WWNt9/+r3ktNhTitC7m+quRnQh13VENwEsHWmOdsCLZU7eBlgFIo4qNHjJjK/k0OL+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852331; c=relaxed/simple;
	bh=G5dh0UKXIi+e1dh9vbIu0vvEm9Mf7XSH5g3nKKaAbFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkDibjNVv+oy5AsxvkydMNu/8OP8NS5D/44QmxQ18TmyyAkknwDZEKLRlM5g3toLIKz8zuvzhR4EozJigVD2W8xbWtHppW1FitVtAA303YMGjb7ncdmJW5VkUfic9YydtgSrh8NIuis9VRPXJcDdL7yCJdmzoFfUuo7z1RI10KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hx1GuIOQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hx1GuIOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738852329; x=1770388329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G5dh0UKXIi+e1dh9vbIu0vvEm9Mf7XSH5g3nKKaAbFk=;
  b=Hx1GuIOQ2UI/qnBsToLMluRIc5RvA/jz3HkKOxFUgAJfXMe48Pdfs3nb
   FOjZAI2yN4GtzHWlUw09wWa4jcW61E7yF25Oz3Ogd6c6Ze+C8TD8XaRSf
   0XNfBUKip0/l7oxz+fps0jzXhAOUM0MCakXIIKzrVTUBdeXiZ/KrjmS0U
   ZO1JfTygJz7nih7r8vt/c4OL617l4EK/76IBju55asPfEo6xnuoH2hrRr
   gnsMs0bdMKG27T3/0zf3JFVnDl/cBqYNbdlYjtX22uUBEWsybUSu8R5UD
   /griJU5B5LTaAVNBPpEMaAnumJkOvdJFeNjoWNNkA2Ukhy4JG+xfeHo7X
   w==;
X-CSE-ConnectionGUID: n8/XKwS/Tvm2v9S/qiqoVA==
X-CSE-MsgGUID: 5p0Z9cmiT+KDDTXjR7eeIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="61934737"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="61934737"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 06:32:09 -0800
X-CSE-ConnectionGUID: xdikWh++SZuyxgRRLP6D2w==
X-CSE-MsgGUID: FzOoPO+bTdSRmEIO54eT9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116419574"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 06:32:08 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id CE4F120B5713;
	Thu,  6 Feb 2025 06:32:06 -0800 (PST)
Message-ID: <58e08371-8d43-4f84-baaf-64b0af95c7cb@linux.intel.com>
Date: Thu, 6 Feb 2025 09:32:04 -0500
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
 <9fa56c75-2ee6-4901-9e04-0ec23412fd62@linux.intel.com>
 <CAP-5=fWpbXSwZq5biRZ1fjcSJY2DO4g=cv-0K8jZ1Gzv3bOfhA@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fWpbXSwZq5biRZ1fjcSJY2DO4g=cv-0K8jZ1Gzv3bOfhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-02-05 4:33 p.m., Ian Rogers wrote:
> On Wed, Feb 5, 2025 at 1:10 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>> On 2025-02-05 3:23 p.m., Ian Rogers wrote:
>>> On Wed, Feb 5, 2025 at 11:11 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>> On 2025-02-05 12:31 p.m., Ian Rogers wrote:
>>>>> +    {
>>>>> +        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
>>>>> +        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
>>>>> +        "MetricGroup": "BvUW;TmaL1;TopdownL1;tma_L1_group",
>>>>> +        "MetricName": "tma_retiring",
>>>>> +        "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
>>>>> +        "MetricgroupNoGroup": "TopdownL1",
>>>>> +        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
>>>>> +        "ScaleUnit": "100%"
>>>>> +    },
>>>>
>>>> The "Default" tag is missed for GNR as well.
>>>> It seems the new CPUIDs are not added in the script?
>>>
>>> Spotted it, we need to manually say which architectures with TopdownL1
>>> should be in Default because it was insisted upon that pre-Icelake
>>> CPUs with TopdownL1 not have TopdownL1 in Default. As you know, my
>>> preference would be to always put TopdownL1 metrics into Default.
>>>
>>
>> For the future platforms, there should be always at least TopdownL1
>> support. Intel even adds extra fixed counters for the TopdownL1 events.
>>
>> Maybe the script should be changed to only mark the old pre-Icelake as
>> no TopdownL1 Default. For the other platforms, always add TopdownL1 as
>> Default. It would avoid manually adding it for every new platforms.
> 
> That's fair. What about TopdownL2 that is currently only in the
> Default set for SPR?
> 

Yes, the TopdownL2 is a bit tricky, which requires much more events.
Could you please set it just for SPR/EMR/GNR for now?

I will ask around internally and make a long-term solution for the
TopdownL2.

Thanks,
Kan


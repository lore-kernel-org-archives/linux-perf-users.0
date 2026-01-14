Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74612ED860;
	Wed, 14 Jan 2026 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768419669; cv=none; b=fb032k6upSsXS180vyldrhJ0WY7NFDPxhCMgGcFN8bY45v3hHH6EjHj3Xnq3pXKrh8rnTHbMtErf12zVeTH+evCL/ST8Mi/4UIrTLkb0nXZW9fmswqWX0eCZ4DGDzAN7WMqzWogP8gy54/mmAHqGuENNZE4xokXhBjjn6Tvctvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768419669; c=relaxed/simple;
	bh=DN/GWJs7D4FPz1BXfAcl6CVxk1pa8nLpJufe5qzlkcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cq/0bHmObvR/nkvEn1YKD+K0Jr7OyMO77UMF5dseLgVKumrY9qlxSocCAhbNx6tbxmPC2XJ8DjHveu+1A601Hq7TW7bcN/hsCnKp3KwsWpzbilAGkSNoIitetiYE9zlEmH5S91NW1Sc9DhMj6CUzlNwhvixzl9JcwOnWyIFcrZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhyrpAEn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhyrpAEn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768419668; x=1799955668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DN/GWJs7D4FPz1BXfAcl6CVxk1pa8nLpJufe5qzlkcs=;
  b=FhyrpAEnR9oAHteH49PSSnjw1rFvWMt4sTS2i/Hym8tyj47J5gmyA28J
   Tb+R0muYOfVgAJFMJTay0AucZABHguF7QFYkHXlytUPKjlxhaj5czRsPy
   gZ9UoHlZY4Bv1ehndI5rAc/oJXdO6KoCObo/twBMQUwC7S4EV4f9yI4EO
   nzJMsOei7dVdmxDFsCVTHrv0r3jWxwbPabhNax25vWKyr6KlyrdmO+9+a
   +xGeIEnzxpjF0LPl7FwjvftDdO1uv/ZAK33sjLO9zJ7x8fAj1c+yNQxE0
   UH56Iol7X6Qz+EIXXpiz0PkQA9xMq11rDNo+T3RDSxgRlZ86pA92j8Kj7
   Q==;
X-CSE-ConnectionGUID: pa5yGqsrQ8SyDfJL6rdcYg==
X-CSE-MsgGUID: h3aT1a2UT8qtHAFeKHMuNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69461217"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69461217"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 11:41:07 -0800
X-CSE-ConnectionGUID: m9prxPW+R1eTFhnlNV0b5w==
X-CSE-MsgGUID: IxTKF8sIQZuW3jGiyw2MXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="242318440"
Received: from malili-mobl.amr.corp.intel.com (HELO [10.125.2.97]) ([10.125.2.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 11:41:07 -0800
Message-ID: <e7d74d9d-cb45-4f5f-8e44-502dd7c4bcff@intel.com>
Date: Wed, 14 Jan 2026 11:41:06 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix iounmap() leak on global_init
 failure
To: Markus Elfring <Markus.Elfring@web.de>, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Stephane Eranian <eranian@google.com>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260113002539.408943-1-zide.chen@intel.com>
 <6213d28c-7377-44c2-92c6-0dc34cfdf60a@web.de>
 <fc565620-a3ef-4a28-bfb8-87bb5ce135f5@intel.com>
 <77078fe5-23fa-4278-b32f-f655f0760be1@web.de>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <77078fe5-23fa-4278-b32f-f655f0760be1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/13/2026 11:51 PM, Markus Elfring wrote:
>>>> If domain->global_init() fails in __parse_discovery_table(), the
>>>> mapped MMIO region is not released before returning, resulting in
>>>> an iounmap() leak.
>>>
>>> How do you think about to avoid a bit of duplicate source code here?
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.19-rc5#n526
>>
>> Thank you for the suggestion!
>>
>> Yes, I agree this is better.
> 
> Thanks for this positive feedback.
> 
> 
>> In V1 I followed the existing style in this API.
> 
> This variant might be nicer for backporting.
> 
> 
>> I will post a v2 with this change:
>>
>> @@ -264,6 +264,7 @@ static int __parse_discovery_table(struct
>> uncore_discovery_domain *domain,
>>         struct uncore_unit_discovery unit;
>>         void __iomem *io_addr;
>>         unsigned long size;
>> +       int ret = 0;
>>         int i;
> 
> Would scope adjustments become helpful for any of these local vartiables?

Yes, I agree that moving int i into the for loop would be better, but
I’d prefer to keep this patch focused and leave that change for future
cleanup.


> 
>>         size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
>> @@ -273,21 +274,23 @@ static int __parse_discovery_table(struct
> …
>> -       if (domain->global_init && domain->global_init(global.ctl))
>> -               return -ENODEV;
>> +       if (domain->global_init && domain->global_init(global.ctl)) {
>> +               ret = -ENODEV;
>> +               goto out;
>> +       }
> …
>>         *parsed = true;
>> +
>> +out:
> 
> Would an other label be a bit clearer here?
> 
> unmap_io:

It seems that the perf driver generally uses simple labels such as done,
out, or err.  Additionally, since there is only a single error path
here, I would prefer to keep the label out for style consistency.

> 
>>         iounmap(io_addr);
>> -       return 0;
>> +       return ret;
>>  }
>>
>>  static int parse_discovery_table(struct uncore_discovery_domain
>>
>>> See also once more:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n94
> 
> Will another imperative wording become helpful for an improved change description?

Sure, I’ll try my best to improve the description.

>> Are you suggesting that I add a Closes tag?
> 
> It depends …
> 
> 
>> This issue was reported by Intel internal LKP, and there is no public
>> URL available.
> 
> Thanks for such a bit of background information.
> Some contributors would appreciate further hints on involved development tools
> (and known source code analysis approaches).

I may add the following report to the commit message for additional context:

    Unverified Error/Warning (likely false positive, kindly check if
    interested):
        arch/x86/events/intel/uncore_discovery.c:293:2-8:
        ERROR: missing iounmap; ioremap on line 288 and execution via
        conditional on line 292

> Regards,
> Markus


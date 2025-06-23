Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196DE22DA13;
	Mon, 23 Jun 2025 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668102; cv=none; b=uUkzC+NOMllI8svU44J/VCddqbr1lhD/t8NfXTntx2M6xmo6imAyMavhfAFwiivWv+cIuoxNx4Zy+cqDCVe7A57atgD8UMyZ08AM2+DqDCUJhc0A6sdx9VlCluLnRO/hce1PPV4wRHUtA4l9sHXpYEWwwsdiWEL3lE/3+LUFW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668102; c=relaxed/simple;
	bh=bI5qpKrePyWR3ZC4OInwrwjLF7Sxg7kIndRp1u/5pUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3KPltgvsE9tOo5Gcc0CX25s5SzemtYGV8+NEAjTGgyFFxRTXt0WAqznwXbaoqP8N0sIMsRVH4G7QAKfvmGfg3ANvBa+BONopn/3SXYVQc7YqFgm6fqhCc8Zvp6byYJXOOBTwnsW2V7g7sQ3fbAG2DTskDOjEHgmaSmT3bQAO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNimj2B7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNimj2B7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750668102; x=1782204102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bI5qpKrePyWR3ZC4OInwrwjLF7Sxg7kIndRp1u/5pUI=;
  b=UNimj2B7kLANx3deUR+LMenjUVTl7TMsbaX/Z9n/nacsYOsf0dyU3A3b
   dCkNre9CkspNTpVBmizfXLGdtNIWryCrZZcNfI1csNDLRaeyu8IjCzgjb
   RMOwgj7vCw752gZyfFEd+AdlwxikYKPF6IBREgbWw2nZZnXIDKRUjbXsS
   4gJNGZGkstNGSbquSoxUzf+ejeVwY/0p2UCNPN4inCHXsuywGT9Zd5esV
   xUBWLKBZh4X69SzgFSJ6ynK7d/e8ba8sRpde2Qn+xbB6mGR+wivDyh8R6
   M+5Nev7SrzFJLtY8FMKVEn7BlcwbJtQ6TKdzK57drE5Avk87A4Z2F1ap3
   A==;
X-CSE-ConnectionGUID: DsMADuCVRvW7dAaSz/NgfA==
X-CSE-MsgGUID: dpCeHh3xSwWTF1avJ78Jaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52998319"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52998319"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 01:41:41 -0700
X-CSE-ConnectionGUID: 6TZh55zbSWiJ7K2jfF1Sqw==
X-CSE-MsgGUID: MnFqF9Z5ROyn1SoihMeprw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="157027555"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.144]) ([10.124.245.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 01:41:37 -0700
Message-ID: <24cfe3f8-2d3f-442c-8adf-5b7446776147@linux.intel.com>
Date: Mon, 23 Jun 2025 16:41:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 07/13] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
 <20250620103909.1586595-8-dapeng1.mi@linux.intel.com>
 <20250621092001.GT1613376@noisy.programming.kicks-ass.net>
 <8f6effaf-0a4b-411e-8e12-57f3c83069c2@linux.intel.com>
 <20250623072850.GN1613200@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250623072850.GN1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/23/2025 3:28 PM, Peter Zijlstra wrote:
> On Mon, Jun 23, 2025 at 09:17:23AM +0800, Mi, Dapeng wrote:
>> On 6/21/2025 5:20 PM, Peter Zijlstra wrote:
>>> On Fri, Jun 20, 2025 at 10:39:03AM +0000, Dapeng Mi wrote:
>>>
>>>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>>>> index b6eface4dccd..72b925b8c482 100644
>>>> --- a/arch/x86/events/intel/ds.c
>>>> +++ b/arch/x86/events/intel/ds.c
>>>> @@ -625,13 +625,22 @@ static int alloc_pebs_buffer(int cpu)
>>>>  	int max, node = cpu_to_node(cpu);
>>>>  	void *buffer, *insn_buff, *cea;
>>>>  
>>>> -	if (!x86_pmu.ds_pebs)
>>>> +	if (!intel_pmu_has_pebs())
>>>>  		return 0;
>>>>  
>>>> -	buffer = dsalloc_pages(bsiz, GFP_KERNEL, cpu);
>>>> +	/*
>>>> +	 * alloc_pebs_buffer() could be called by init_arch_pebs_buf_on_cpu()
>>>> +	 * which is in atomic context.
>>>> +	 */
>>>> +	buffer = dsalloc_pages(bsiz, preemptible() ? GFP_KERNEL : GFP_ATOMIC, cpu);
>>>>  	if (unlikely(!buffer))
>>>>  		return -ENOMEM;
>>> Here we go again.. that is CPU_STARTING context, that has IRQs disabled
>>> and as such no allocation is allowed. Not even GFP_ATOMIC -- this will
>>> break PREEMPT_RT.
>> Thanks. So we could have to follow what current legacy PEBS does and defer
>> the PEBS buffer allocation until creating perf events
>> (x86_reserve_hardware()). 
> The normal way to do this kind of thing is allocate in prepare, use in
> starting, and the reverse on down, stop using in dying and free in dead.
>
> Specifically we have the callbacks:
>
> CPUHP_PERF_X86_PREPARE  -> x86_pmu.cpu_prepare()   / x86_pmu.cpu_dead()
> CPUHP_PERF_X86_STARTING -> x86_pmu.cpu_starting()  / x86_pmu.cpu_dying()
>
> to arrange for just such a setup.

Sure. Would do. Thanks.


>

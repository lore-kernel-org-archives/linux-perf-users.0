Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85E1FFC7B;
	Wed, 16 Apr 2025 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765419; cv=none; b=GWV/k9CSvw7ZcxWc2eCBqHFtj8XjplqgAsvgc890OxKfAQeMsOj1HFvUmwgOfH6lelJPPesukQ9e85CmVkN3vrvwTNJXFwHolirybtsmaQkZKS6GtaJ4OHNF8nNamNgaarVMHVemFOZO0+3Jjc+uBJySAq0MmTjLgMh2RBXQRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765419; c=relaxed/simple;
	bh=FD0iaAe27y+WPApOkpURJpfi7Zsp8bjMYlZBsbsTXfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bu8rYTeK+ZjsnOTypTbLQzeyJeOqxWchk93hUsJulMY+zIAD98zRF8sselikg3CPeF8LmbAt4GSAj+a0A8ToTEMQLf2xBAR6i83bivDC6EhNR+tQpNos2ay09Aq9497UFhnlOo4vUzwOzqDez+oIXtWr5IHjgixEbJAqlNAlTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFL1UDW5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFL1UDW5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744765417; x=1776301417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FD0iaAe27y+WPApOkpURJpfi7Zsp8bjMYlZBsbsTXfE=;
  b=iFL1UDW5oWfRQDWQ+A9rbISWnNPq4g8+f8l56advFSN7wzkrgmajABMS
   JC028ePkM0qYXtA53+oDY5UQq07KVWxAVplySx4pATD/6jMUW4DMs7s7Q
   UTKR8yp/ZI1WIVh60pfyjWYd5TlGyurSMV7FeWiz+pWSjbxwCzgBTSzP6
   lCsGv9+fb7GdnJ3IJ47flRI6v5jdIf70kyaws2+C3UW44ygdFTcncEKU/
   +XxiXxmPn2ooa2kgZObgQzKM0DtUUk9tjMONVQGk7CCpmYcFRJCR4cjFK
   uhcHHLPEOIZ6cwaZjUnt9gE27khsUJKO6MuhPhJU7SSnROKJy5J3+HYcf
   Q==;
X-CSE-ConnectionGUID: WCk4qPgDRpmzJEluaWyJiw==
X-CSE-MsgGUID: 8EsDX4+1Raq0ETzc/k9bLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="48994112"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="48994112"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 18:03:36 -0700
X-CSE-ConnectionGUID: gG1IwMHAQ0qwDVE1RNINQA==
X-CSE-MsgGUID: PZDnM1ZyTuyNAceGKTpDPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130244675"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 18:03:33 -0700
Message-ID: <5a9f25a8-7679-4619-8fa1-97ab86dc6104@linux.intel.com>
Date: Wed, 16 Apr 2025 09:03:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 11/22] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-12-dapeng1.mi@linux.intel.com>
 <20250415134829.GB4031@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250415134829.GB4031@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/15/2025 9:48 PM, Peter Zijlstra wrote:
> On Tue, Apr 15, 2025 at 11:44:17AM +0000, Dapeng Mi wrote:
>
>> +void fini_arch_pebs_buf_on_cpu(int cpu)
>> +{
>> +	if (!x86_pmu.arch_pebs)
>> +		return;
>> +
>> +	release_pebs_buffer(cpu);
>> +	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, 0, 0);
>> +}
> So first we free the pages, and then we tell the hardware to not write
> into them again.
>
> What could possibly go wrong :-)

Oh, yes. Thanks for pointing this. I would exchange the sequence.



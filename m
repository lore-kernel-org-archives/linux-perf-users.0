Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F7E3FB044;
	Fri, 29 May 2026 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067019; cv=none; b=GJkAJSmu+pHQ5PZDICrhdXwwOhGNUILuowHZ85KbJHsHsW7A0wzo7S0VSgMM/NOhqJ89h3QIxMf+6+DdBmqpYeXz9TpYdLuF0AhMhGDxTqqyG28VmANpfXgR2HXvyfh8aw3L4vab/Z2bZFFR4rkP5kSFkxui7HuWP6eQCyoUZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067019; c=relaxed/simple;
	bh=9AnnZIbKQypLAPZNrTzYOc5qZpIrCk1JMyeWrdXQRAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABZDiCpOlZ10UJdPtqKv/GP5XNg04mWFa4sp5Z5va/D3WXbz4M1HKBDVQN5ViZkgivZ+Kx1AeGlGC7MUdEP5T7ixwYC61TsMxmGj9twf9lRq0+D/tts+eF3yLCDyCXJrNHE6DrEgQy8nI/SfSrFDZrrzPt3LZGmCr1xH8UEwC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eg7efXTN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eg7efXTN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780067017; x=1811603017;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9AnnZIbKQypLAPZNrTzYOc5qZpIrCk1JMyeWrdXQRAs=;
  b=Eg7efXTNWSOikbpaHV0qX96TNe6OoB2fzYvB/RgQZnEvBWg1mhWFoC0y
   sAZCJDxXoCC0VIx/7wxSpHvLXi/gKj5s26Y1Rkqfyx7vddCPTbouAt/SZ
   StKjNFW/xTczUF/jOlL7RaWoCOzikzS3cgy2RPCq/nuu3Xs7ZHimErYQu
   NI0W1XVWRCR7QJ/uc8rxS7GOMfvKaqVIX3NSSXAz8VLBLEoE90cLXRxcT
   8daiMPVKmrbDMTlDuwOTNNQjOE03UuQqfGGQ+sqp1VY4fc8DuaigyLw/n
   /tT7ER2NEEplpxbV6RmUeR6JgoD2ntQ/w33fb07mtY0ICI2vZcEmeSP3j
   Q==;
X-CSE-ConnectionGUID: s3VsnkYKQbyCv70Wd5N9/w==
X-CSE-MsgGUID: nrJK+GzGTQylVexEFF2ztg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91604431"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="91604431"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 08:03:33 -0700
X-CSE-ConnectionGUID: juO8dglMT7iYbwX3njG2Pg==
X-CSE-MsgGUID: VX6OBjfqSJ2Jif7g6ywtqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="244704127"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 08:03:32 -0700
Message-ID: <882972ce-2c2c-49ad-b2ec-f1c20cc3ff70@intel.com>
Date: Fri, 29 May 2026 10:03:31 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/7] perf/x86/intel/uncore: Implement global init
 callback for GNR uncore
To: Peter Zijlstra <peterz@infradead.org>,
 "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260527151154.130505-1-zide.chen@intel.com>
 <20260527151154.130505-7-zide.chen@intel.com>
 <507feaea-25fc-4111-a39b-648ce44e3316@linux.intel.com>
 <03ad940f-747b-432c-9dca-1be305ee5cc7@intel.com>
 <93acba88-3f6a-43dc-8392-63d977fb2dfa@linux.intel.com>
 <20260529105537.GG3493090@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260529105537.GG3493090@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/29/2026 5:55 AM, Peter Zijlstra wrote:
> On Fri, May 29, 2026 at 04:47:39PM +0800, Mi, Dapeng wrote:
>>
>> On 5/29/2026 2:14 AM, Chen, Zide wrote:
>>>
>>> On 5/28/2026 1:46 AM, Mi, Dapeng wrote:
>>>> On 5/27/2026 11:11 PM, Zide Chen wrote:
>>>>> On Sierra Forest and Clearwater Forest, the FRZ_ALL bit in the global
>>>>> control register defaults to 0 at boot, but UBOX PMON units do not
>>>>> work until the global control register is explicitly written with 0
>>>>> to trigger hardware initialization properly.
>>>>>
>>>>> Implement the generic uncore_msr_global_init() callback and add it to
>>>>> gnr_uncore_init[], which is shared by GNR, GRR, SRF, and CWF.
>>>> Need a "Fixes" tag?
>>> No Fixes tag needed. This is a hardware initialization workaround rather
>>> than a fix for a software bug. The register defaults to 0, but the
>>> hardware requires an explicit write to trigger PMON functionality.
>>
>> Zide, per my understanding, some uncore PMUs can't work for SRF and CWF
>> without this change. Is it right? If so, we need to add a "Fixes" tag to
>> ensure this patch is merged to the corresponding stable branches. Thanks.
> 
> If you all agree on Fixes tags, then those patches that end up getting
> one should be at the front of the series.
> 
> I was about to pick this up, but if you guys want to send a new series,
> let me know and I'll hold off.

Yes, please hold off and I can send out a new series to add a Fixes tag,
fix the missing '---' in patch 5/7, etc.


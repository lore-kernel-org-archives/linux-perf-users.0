Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B951F4F1;
	Wed, 12 Nov 2025 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762906633; cv=none; b=FmniUVgR0E5zunQcX80JBSX5Hyi6GBXjhS8kVdB2UofWGL0l3twAzjb+i1DdUzBYUX1VOduWx/gc6lfLBnR0GibzNL2k/55RxhkELkdaD+b8Ms36r9sQBfD+8pgBWOC5EunjoAOwbtd7PXrSKoP5Voe9TTFlCfKJfZ7YxTpXTc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762906633; c=relaxed/simple;
	bh=c7Acazo6/VSTzsird0Ho5whwvCWjj8rpyxfYP9HRqIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKQXY4ExUGCi4ufyOltZ5KTQO/jVqs0gJNnnSJfP5nRsxxWhWR8I88g+frWiMfrCeFL/kRMhNRsGAiitmJFM2rynWfXgJqcbyzV33UkX38sQFcI4m6yeXmRsgvOVE5asjPBRqBszhNzYQAVLGaV/97uWBuTRgCa9sLgsuawi09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AX0ToDhO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AX0ToDhO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762906632; x=1794442632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c7Acazo6/VSTzsird0Ho5whwvCWjj8rpyxfYP9HRqIQ=;
  b=AX0ToDhOlzKvVPuik5GOtTWGMeBTzqJr3Cbxn30p7arIVoK84nffGtDU
   gxGUlmQaS7Z7v1RO+ug10UlKB5ChcBNm44XHXrRQHUKlL0YWbn5C7hyN7
   1z4fDF9JHmMeQ0wphX7U32rtY9fCmAh0PVUaA1N05/atkYTodw4wIbSBT
   LOc7gWAkgbeDL1/0X9yW2I7sGcHtQnw4TWwbFpqArk8fcKqMpBGX3fLEp
   9FJw5YBcJ87Cq25BAWznYhSv+s42IcuSDvZ/Lw6WIrAySugqng3c6VgcI
   4zuoiepsbeT9PVpgCZ6RFiV6bmsBPri2Odg7O+12MvMNiZI3iD5+CXH0E
   A==;
X-CSE-ConnectionGUID: 1UhiecGDRw+3r863qdfc1w==
X-CSE-MsgGUID: EaB7gKu5T7ekmXQrWmfXOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64874090"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="64874090"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 16:17:09 -0800
X-CSE-ConnectionGUID: HQYDWhPZRQmrtmd8b8OQCg==
X-CSE-MsgGUID: VhNBE5L1Rg2w4tqrBr35tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="219802858"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 16:17:00 -0800
Message-ID: <1a8dcc37-68a3-463f-874e-8bb808047d2d@linux.intel.com>
Date: Wed, 12 Nov 2025 08:16:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 10/12] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-11-dapeng1.mi@linux.intel.com>
 <20251106145217.GA4067720@noisy.programming.kicks-ass.net>
 <09210c12-cc61-4af5-bd13-830fd9650f9b@linux.intel.com>
 <20251107130552.GB4067720@noisy.programming.kicks-ass.net>
 <a0416429-23d4-4f4f-af73-bcd87b4e773c@linux.intel.com>
 <20251110090311.GW3245006@noisy.programming.kicks-ass.net>
 <97eb5ae9-6c99-497e-a1b9-80bf365bf2d5@linux.intel.com>
 <380fd742-a7ed-4d6f-9944-b963869a5cb3@linux.intel.com>
 <20251111113732.GM278048@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251111113732.GM278048@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/11/2025 7:37 PM, Peter Zijlstra wrote:
> On Tue, Nov 11, 2025 at 01:41:05PM +0800, Mi, Dapeng wrote:
>
>> I tested the queue/perf/core code with a slight code refine on SPR/CWF/PTL.
>> In summary, all things look good. The constraints validation passes on all
>> these 3 platforms, no overlapped constraints are reported. Besides, perf
>> counting/sampling (both legacy PEBS and arch-PEBS) works well, no issue is
>> found.
> Excellent, I pushed out to tip/perf/core.
>
>> I did a slight change for the intel_pmu_check_dyn_constr() helper. It
>> should be good enough to only validate the GP counters for the PEBS counter
>> and PDIST constraint check. Beside the code style is refined
>> opportunistically. Thanks.
> If you could send that as a proper patch -- the thing was horribly
> whitespace mangled.

Sure. Would send the patch soon.



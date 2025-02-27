Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48517A30A;
	Thu, 27 Feb 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622149; cv=none; b=BKgesT2A6DE84oA13nU+qYs1Z7WbBRELL2Pqdd6DPG6+Ump5w+7HnspRfhl43/FAdYk7cvXcrz1yJseiHM/YiJa04TGWvv9KXNQQQOXm+hb6uSLqNqm9Wr8SacKu+R7przOfa+zBrDVbIcL4p4VTJF2G2fYImj/Bo97k9QU7MZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622149; c=relaxed/simple;
	bh=YKQPDFWLbcBJaFaNyrtcFXPUNWbF9I/UCfWEsAk8UFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFPV5oqri2K5iUQDddgsFAr/jDI2NyVCWfq2ORY1bOtuglKYGQ03jJV0CP0OWZiHTmBf2LehVqykl9aq4kV6/QYup7hVJdHlybVitcEXNvc4E9tqySvfhgNCmVP53kGNb5JZbtzyRlc1PxHlyYNBAd1wfI+4bNDW6VwJPTUgwl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MemwB/t2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MemwB/t2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740622149; x=1772158149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YKQPDFWLbcBJaFaNyrtcFXPUNWbF9I/UCfWEsAk8UFs=;
  b=MemwB/t2emj03nTLlX98lI9TCyXsWw0++rZMkt5TLE6k2D+MWe+L+SbA
   cCPVMGRFLyoJmPlmIhlaZKYz+jh6VCMRsXv2MRaemWieJr/2OfTHaMbdS
   YOjF+X6ZSX+bI2LtPUEndN/J6tlaOIp8FOSWqGc+TmPBPWjX1U16HAOrN
   fal7SP+R2yiWnrWQk3uXCUcPCZ9sSkO2+GlaQ+1+RWqTZ1XoZCeCBHw53
   8OIygBav59OOCN+aTwPBnMRM+8WlNrpRhRjqFATIfNkmYTCikhngy0lI/
   2lmKkJkOInhusTMXm0Xm5LVPzVfaOcpErb92PYfWp3v2H/AodOgniKIFR
   g==;
X-CSE-ConnectionGUID: 7+FH4WRFSZ+rFzjoBPAJog==
X-CSE-MsgGUID: W4+Z38KIQUymzsXvEjgUjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41518705"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="41518705"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 18:09:08 -0800
X-CSE-ConnectionGUID: 3zzLp7cqRfyU7rbEN+VXvw==
X-CSE-MsgGUID: ft54dxorTYCOfas6YWGQKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121003116"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 18:09:03 -0800
Message-ID: <5bce57a6-f554-4a54-bf87-08a30c60bea9@linux.intel.com>
Date: Thu, 27 Feb 2025 10:09:01 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 12/24] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-13-dapeng1.mi@linux.intel.com>
 <20250225112543.GM11590@noisy.programming.kicks-ass.net>
 <000043b8-1284-46f3-b117-9ece905f218e@linux.intel.com>
 <20250226094841.GT11590@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250226094841.GT11590@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/26/2025 5:48 PM, Peter Zijlstra wrote:
> On Wed, Feb 26, 2025 at 02:19:15PM +0800, Mi, Dapeng wrote:
>> On 2/25/2025 7:25 PM, Peter Zijlstra wrote:
>>> On Tue, Feb 18, 2025 at 03:28:06PM +0000, Dapeng Mi wrote:
>>>> Arch-PEBS introduces a new MSR IA32_PEBS_BASE to store the arch-PEBS
>>>> buffer physical address. This patch allocates arch-PEBS buffer and then
>>>> initialize IA32_PEBS_BASE MSR with the buffer physical address.
>>> Just to clarify, parts with ARCH PEBS will not have BTS and thus not
>>> have DS?
>> No, DS and BTS still exist along with arch-PEBS, only the legacy DS based
>> PEBS is unavailable and replaced by arch-PEBS.
> Joy. Is anybody still using BTS now that we have PT? I thought PT was
> supposed to be the better BTS.

Yeah, I suppose no one still use BTS, but suppose it would need a long time
to drop BTS on HW.



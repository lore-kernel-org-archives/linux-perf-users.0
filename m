Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14652FE58D;
	Tue,  6 Jan 2026 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767734372; cv=none; b=tFjcNUa2i3d4yllbARZIuRCQrJb322KHPUNvUIpEdpZrEL45ZA5EYD+s8xwhm/1VBpuWAZanC3lmpUAUXxJ6JD9hwAOfer041oTVJhQfrEZZVe833NtpsYGm4rti/yl0J1pPXnF1C4nyPgVqAL3BV+n9Wt43AdTOWYOOw1q9DwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767734372; c=relaxed/simple;
	bh=8It3JAn5M/kGCFZwgGeGWsjkqFrvQyoZHxCgGzFQcE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jg7ttbGO89zptmV4eV0ffRbMURMNp91+LDE6c0pdLduXXnJKv+jq6fdyyOY14PnomHO5MF2tng1IRR15nU2+A90KXbjZkPnJ+CkGDkM6GviUrhnI7BqKBCTbuMLhPBv0ejGFpgHFh7ki31o36l+PkMKeDxXehPoCkMOthbz5FIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiodKmdI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiodKmdI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767734371; x=1799270371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8It3JAn5M/kGCFZwgGeGWsjkqFrvQyoZHxCgGzFQcE0=;
  b=hiodKmdIO+AfWETLMB/HF8hZuIj0nN2xgq0wFkIWGWJHnfRbgfRDB7vd
   kkSF9ObZWRXrMqlvZmL0H4fxJLYiQmFdRfdaRE7lwHKDR/nUX+sS1Glet
   JBQGk8T3hjoO16RMTlFw6hP8j8myiFabrr/JKCih6T65LYrw6AU3yuJCK
   ZlP1XDN4mbNAguy3OVYP4napeV12x/X0JwXu7IMGkoxnSSbWe1wyLMp68
   TksHDtp31tt3G7ppz0DXuPPOEseDrLLsv6WM9aNLnCsqOBc1dDw7d8U7i
   6wO/hjf4H5N3HrGy/JlHGwzeB8HfkusRySJLq4Y0EpDik3ekLd0l1hhBh
   Q==;
X-CSE-ConnectionGUID: 2hObKezCRbmnQmTIRUHP/A==
X-CSE-MsgGUID: NmIiFzXmTJukxEInYUgK/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="72952251"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="72952251"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 13:19:30 -0800
X-CSE-ConnectionGUID: Qx3u3eqZRoCXR+NENMUtnQ==
X-CSE-MsgGUID: x4n46abrSnuS3DdAUbTnGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="202654490"
Received: from unknown (HELO [10.241.241.119]) ([10.241.241.119])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 13:19:29 -0800
Message-ID: <0906a9e0-ebec-4a91-9392-aa10bb49d35f@intel.com>
Date: Tue, 6 Jan 2026 13:19:28 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/13] Add DMR/NVL and missing PTL uncore support
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
 <20260106150833.GD2393663@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260106150833.GD2393663@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/6/2026 7:08 AM, Peter Zijlstra wrote:
> On Wed, Dec 31, 2025 at 02:42:17PM -0800, Zide Chen wrote:
> 
>> Zide Chen (13):
>>   perf/x86/intel/uncore: Move uncore discovery init struct to header
>>   perf/x86/intel/uncore: Support per-platform discovery base devices
>>   perf/x86/intel/uncore: Remove has_generic_discovery_table()
>>   perf/x86/intel/uncore: Add IMH PMON support for Diamond Rapids
>>   perf/x86/intel/uncore: Add CBB PMON support for Diamond Rapids
>>   perf/x86/intel/uncore: Add domain global init callback
>>   perf/x86/intel/uncore: Add freerunning event descriptor helper macro
>>   perf/x86/intel/uncore: Support IIO free-running counters on DMR
>>   perf/x86/intel/uncore: Support uncore constraint ranges
>>   perf/x86/intel/uncore: Update DMR uncore constraints preliminarily
>>   perf pmu: Relax uncore wildcard matching to allow numeric suffix
>>   perf/x86/intel/uncore: Add missing PMON units for Panther Lake
>>   perf/x86/intel/uncore: Add Nova Lake support
> 
> Thanks, pushed out to queue/perf/core for the robots to have a go.
> 
> I made a few minor edits, the biggest of which I already shared in a
> reply.

Thank you very much!

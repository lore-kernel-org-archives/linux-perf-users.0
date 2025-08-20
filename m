Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C71EB5FE;
	Wed, 20 Aug 2025 05:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668016; cv=none; b=QCeawsUxCiZ4LQner+8FJ6ynA1FF7CdAHYJG6INKkxushjDwhKavSIsE1aq9R+BO7a+gkCTjn19axZwMBiyma1vfOJOMsC2RWRMgfsCa6KXBWAGm7N42Xfci4D/AB1cSVUJ87jYAbKMElcZ3ahB37aOukpTY5P5RnajCAUsXcQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668016; c=relaxed/simple;
	bh=WfEcrvAeALEQpugHAc/HFFrPqe9f9qTjZzLDwJ2E5F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrOcSbwoaX6Lh5x91uiWMauPxsub9FQ8lRcy+q6RjBBxFBYeYvkZa9QWDtMyS1RQ4+clZjqsVGSmnttBJhTb3WClL/nvM9p0gFaqQb6UOmkwPFDqu01BMb/C0rHoh0/leeduAzKKfy4A1unEjvvNun5ZycLxAzEELNAdc5G2XRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlRtDcxf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlRtDcxf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755668015; x=1787204015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WfEcrvAeALEQpugHAc/HFFrPqe9f9qTjZzLDwJ2E5F4=;
  b=nlRtDcxfhXfax0OzxcP4Mk3gFa3pet8uiH5NMZZG9i3yZa7Mxhd6zQY7
   SjksSV7Ci1reWGVd1WrlZaTGnqHL0ufVSE07COoVK4+JgdjQDA7lHNQLB
   FzLJ47R+/Q2aK36Dw9C2SPmy8gyrrZAh0jGRR8aIukzThnYonxv8xtwvW
   cHEztqvk7EQh+nk8g1rvrxQSGD/2uLvwKq9w6k8F7tgSquUcHZpTwv/gN
   oh/Z8devZtLfhb7GeRZSirVqtbsFzPijPz8ZMmMBt75DFOWukVzFLSQcZ
   dKQspjY+wbqxMJO7RmhvMCCFuyL+Elf7OAkmSeMj7WnjAMZux+QF3uzDG
   Q==;
X-CSE-ConnectionGUID: btolh88sQzSZaOHSOOyjHQ==
X-CSE-MsgGUID: I5bYPsgZQ9GdyiNtV8my+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="56953549"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="56953549"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 22:33:34 -0700
X-CSE-ConnectionGUID: gQfVMk+3Qs6VTpA0ThJ1mA==
X-CSE-MsgGUID: Gy0h7wyQSDCTANCLvkPOfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168285300"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.36]) ([10.124.240.36])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 22:33:30 -0700
Message-ID: <aedbcbb5-f0b4-4bf6-bc33-c8c3bf3f20bc@linux.intel.com>
Date: Wed, 20 Aug 2025 13:33:28 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 3/7] perf/x86: Check if cpuc->events[*] pointer exists
 before accessing it
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Eranian Stephane
 <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 kernel test robot <oliver.sang@intel.com>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
 <20250820023032.17128-4-dapeng1.mi@linux.intel.com>
 <aKVD4ATXW4LmhDJm@tassilo>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aKVD4ATXW4LmhDJm@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/20/2025 11:41 AM, Andi Kleen wrote:
>>  		event = cpuc->events[bit];
>> +		/*
>> +		 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
>> +		 * could trigger interrupt throttle and clear all event pointers of the
>> +		 * group in cpuc->events[] to NULL. So need to re-check if cpuc->events[*]
>> +		 * is NULL, if so it indicates the event has been throttled (stopped) and
>> +		 * the corresponding last PEBS records have been processed in stopping
>> +		 * event, don't need to process it again.
>> +		 */
>> +		if (!event)
>> +			continue;
> Then we silently ignore the overflow. Would be better to log at least an overflow
> packet or something like that.

Andi, I didn't fully get the exact meaning about the "log" here. When
throttle is triggered, perf_event_throttle() has already called
perf_log_throttle() to log the throttle event although only for the group
leader. Is it enough?


>
> -Andi
>

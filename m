Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3DE1624C5;
	Wed, 20 Aug 2025 05:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755669265; cv=none; b=RcGT8/f2FYICkDYgL8LGWmsfGMoMRmkdWxASWE00Pj8cy4SYEfUCbHcfCCWoAKqXX8HUm/k5wjBMHRMLxuvyiGPJ/LxWdzR2ho8xL7HJxhvabGziwB7uW1exqv69xhA1E4qZlGV+9+w1GcUVSL3ZROSdt5Hhi9Nav9InzY3VNnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755669265; c=relaxed/simple;
	bh=IaIJ+rusFPu7AQeJZSbdYkBlqREjoLUKiBlYhFsnFNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1SNbhG8FMZFPy4V9JMBDFkTeu0ad/Gjy1LnEtQ3PdzWOP+hcydz6bKHjdpA6XSvxfEUEoMWLZJ73SCWFW2ISxFei46uWzf+UGpt243BqY/l6LXRMsz7GC3whf+hSD6yZO+4ZYBnZo0/92JL4RoXTYgD05vNRM4PbjD4WzWhz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjJo0lSQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjJo0lSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755669264; x=1787205264;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IaIJ+rusFPu7AQeJZSbdYkBlqREjoLUKiBlYhFsnFNI=;
  b=EjJo0lSQCDvJ649ncHRBcgUCP4nbPJNGRdhoANMV/KX4UGu8iYTGZjt+
   5gsaTN8xvVNYLregRgDSEzeZx0lvLVY0GHNTEhxxidNRFDoyshOWClXux
   MBI1MadMIcUZKh5+erDLx9F3RBNcs+egSHWAI5a4jCuuMswMNDNetyvuC
   GpEL5qtmdlJnEZWG9henJKZ2zl4zo4Nj1DPqyBL1VO9D9NJAUb2kL3Lhr
   x2R2ii1bSbR9H7atPbyOE943/UK9eC2p0dxDj9SnKlL3q8WAVa+YEMuVI
   yZy+nlD4jnOPlsLTIsVfNnIjwo6PPQTuVMPlC9bxcyIwKasUeNXdgzxeP
   w==;
X-CSE-ConnectionGUID: a84xeYGWSy2NUgPR+nTTsA==
X-CSE-MsgGUID: CUP1LzUPSDqAukuMQ8pMCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58076084"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="58076084"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 22:54:23 -0700
X-CSE-ConnectionGUID: oT8Rtm0jSIaq7gWObcSqKQ==
X-CSE-MsgGUID: QAcufMB/RVCZKRdyFWK2NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167543502"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.36]) ([10.124.240.36])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 22:54:20 -0700
Message-ID: <fab2a035-5ab3-4e24-bd3e-760a4b9be5e8@linux.intel.com>
Date: Wed, 20 Aug 2025 13:54:17 +0800
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
 <aedbcbb5-f0b4-4bf6-bc33-c8c3bf3f20bc@linux.intel.com>
 <aKVgyV4XWfJGR6uK@tassilo>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aKVgyV4XWfJGR6uK@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/20/2025 1:44 PM, Andi Kleen wrote:
>> Andi, I didn't fully get the exact meaning about the "log" here. When
>> throttle is triggered, perf_event_throttle() has already called
>> perf_log_throttle() to log the throttle event although only for the group
>> leader. Is it enough?
> Throttle normally doesn't involve data loss, just less samples. But this
> is data loss, so it's an overflow.

IIUC, there should be no data loss, the unprocessed PEBS records of these
throttled events would be still processed eventually by calling
intel_pmu_drain_pebs_buffer() when stopping the event.


>
> -Andi
>

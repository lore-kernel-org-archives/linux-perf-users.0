Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C8F3090D5;
	Thu, 12 Mar 2026 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305102; cv=none; b=qHFMtw76UPaYdC2K8dIXZgWbqYb4Ps4rl+RtctgjLDS/fIxskCaUe5ryhdWGVeu0B3ERKPjJ4DAuRdt6JJd71TbWQxYBh7+sk1Z354OROwE8o2oRX7ERvcVDV9nUjhxZiBTk4m8i59hB5TKVg3JfEMtlRhiZumUPslcRUK3c3JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305102; c=relaxed/simple;
	bh=2/zXMu+4WkLz1kiPeuAc2xZPU3G5yR6kxcN1JGMyjgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdbAV+nP3Z4zXezzDsNo2rneB9Zah9yKcQfAMzfQ8DNT88SI/X4bpCzYpdEO6fKdbzmqy48YIeprNfiDg1cJnhUSx9Y9E5SUDuqhupnTpXr8pOd6zoCqrKGQWTBb4k9JSuSP0AKdXvpLFsi8aN7vYSQwq9PvmZOTWQvRdgkyZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iD4w+Efm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iD4w+Efm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773305101; x=1804841101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2/zXMu+4WkLz1kiPeuAc2xZPU3G5yR6kxcN1JGMyjgM=;
  b=iD4w+EfmwJT9ibD4cl568z4JFTEj2u5JxQr4wAQmx7G8x7R3Q10aoykF
   ZOadOJvYl6TnJmaqsNr3yAdn69NfAZ7ULXGZ9wwLzpaN+N8dMQLqi/Bty
   fdYLPSN9PzzTKIB7WnF+QITlW5LefaWbq8tvR8CF6XxwVnh6sGG9QAZpU
   s10Tv/qhnQXU1WlNJMmChgtk3oNbEpOjqY8sGUNW5X1QYEp52u5PPKFFS
   mYrI+hS1Lgwf95AnR0179Jm4mY/1nKnVK41tis79i4nqJMs8/XlucVATL
   XthpEpAp4Zrs2MqLSElR+wmoDvLWOZxpjxlmoDv/8ec0s6mbe8YcOgez/
   A==;
X-CSE-ConnectionGUID: MsAa12mhSEuLeAG417RrcA==
X-CSE-MsgGUID: 44E3EL83Rget7mZdHKluNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85475703"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85475703"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:45:00 -0700
X-CSE-ConnectionGUID: Uzi+eJaARR+GPQghQNMWlQ==
X-CSE-MsgGUID: a3TBCjbsRr+7tYRVgk5MOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220017062"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:44:54 -0700
Message-ID: <772e396d-7da7-40f2-bb9b-481f21c23e6d@linux.intel.com>
Date: Thu, 12 Mar 2026 16:44:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch 1/2] perf/x86/intel: Only check GP counters for
 PEBS constraints validation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
 <c718111d-b836-4e03-b42c-5b86d409b6bc@linux.intel.com>
 <20260312084206.GF606826@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260312084206.GF606826@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/12/2026 4:42 PM, Peter Zijlstra wrote:
> On Thu, Mar 12, 2026 at 04:28:45PM +0800, Mi, Dapeng wrote:
>> Hi Peter,
>>
>> Could you please review and merge this change? This change suppose to be
>> low risky. Without this change, the dynamic constraints check would trigger
>> false positive on DMR/NVL. Thanks.
> Ah, so I have it in queue/perf/core, it didn't have no Fixes on so I
> didn't think it urgent.

Oh, just saw it. Thanks a lot! 😊


>

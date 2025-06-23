Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEAB155A30;
	Mon, 23 Jun 2025 01:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750643756; cv=none; b=QcZwqtF1r53zeRhMu3U4isjhbEnbT1cRHawodTJeoc4SEeFRcOZiAxFhBNEmFZp34Kl4d2ftp/Ab6kEDt+721ZxIuFa0G8s2i5c8+dh9NxtYE/5uVaZl8LJQ7+lgnMvBaJgjnrXQpKN4MQA4nRXDrGHt2VxxZpAKPyStR8sPoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750643756; c=relaxed/simple;
	bh=2XSdeQVvG5sytC1J38GfxjbVWMvMsjn48/atUCNK+mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CITRuK5G9MDKU8/diwVoNvtBG7FbaSD9twlfSpUj7DRXV3gkHs2GgRi4lt2UGGd+CEdooDAgqSJQbhCJkFUt0FXZ5PyMjLIBrwHMJuX0QqfCQOOzG1123aKmwNcb+3NLDTkeIutiRnsYBMXUSy2CYnGsMEuPMxHPpZVL6eWyYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGjjYLRq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGjjYLRq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750643755; x=1782179755;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2XSdeQVvG5sytC1J38GfxjbVWMvMsjn48/atUCNK+mQ=;
  b=lGjjYLRqFPkXtaUzicMAS5MTJoa+sHaZ0z3CuYczTH8tZHBdWHwFxzg3
   6JIN4tOGtm6yi9yuwfhVKdgFGLjQBGW9/goLq2nO7KBcAfLUmHlcxYMY8
   aQEJgOMDAgQ9z84tZ6LP4103fnXT2L8OYDVuheB965i7d0M8G+CwlHia3
   DH4O/HObEcDoq2EgYARM9zVU4eKX7eOEugom9a5daVb29b5HEIOntC/IN
   Tfp1qRHy11Uydr14KzNmlp3cfzl+iggkCuCt1HQuo8Px8XBksylKGg/xv
   p7wl5e/g3rWdoEZ3s8kSmyMji2SvHi8A0/YXTaziAPjZGICdZuAsZ+cqo
   w==;
X-CSE-ConnectionGUID: 97RnnwTUQKOH3+fSXejqJA==
X-CSE-MsgGUID: FLW8YyDTSjSwTnHLINT+YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52975327"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="52975327"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:55:54 -0700
X-CSE-ConnectionGUID: Mv1J6INuQ3GpCSFBvOOCAg==
X-CSE-MsgGUID: UNqdy7oMQP62KROYUQbM3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="188685408"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.144]) ([10.124.245.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:55:52 -0700
Message-ID: <fe19ce39-689c-419b-9073-7fcaacd2841f@linux.intel.com>
Date: Mon, 23 Jun 2025 09:55:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 09/13] perf/x86/intel: Setup PEBS data configuration
 and enable legacy groups
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
 <20250620103909.1586595-10-dapeng1.mi@linux.intel.com>
 <20250621094343.GY1613376@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250621094343.GY1613376@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/21/2025 5:43 PM, Peter Zijlstra wrote:
> On Fri, Jun 20, 2025 at 10:39:05AM +0000, Dapeng Mi wrote:
>
>> +		if (cpuc->n_pebs == cpuc->n_large_pebs)
>> +			index.split.thresh = ARCH_PEBS_THRESH_MUL;
>> +		else
>> +			index.split.thresh = ARCH_PEBS_THRESH_SINGLE;
>> +	if (cpuc->n_pebs == cpuc->n_large_pebs)
>> +		index.split.thresh = ARCH_PEBS_THRESH_MUL;
>> +	else
>> +		index.split.thresh = ARCH_PEBS_THRESH_SINGLE;
>> +/*
>> + * The largest PEBS record could consume a page, ensure
>> + * a record at least can be written after triggering PMI.
>> + */
>> +#define ARCH_PEBS_THRESH_MUL	((PEBS_BUFFER_SIZE - PAGE_SIZE) >> PEBS_BUFFER_SHIFT)
>> +#define ARCH_PEBS_THRESH_SINGLE	1
> Can we please do something like s/MUL/MULTI/ or so. My brain keeps
> trying to make it MULtiply and that doesn't really work.

Sure.



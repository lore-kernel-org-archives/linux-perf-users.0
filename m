Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF832226191;
	Thu,  6 Feb 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834536; cv=none; b=dNHvFEC8U+upYjkgVz8QqH4Tt3vamJgzUQrRcrSnOA62Pf8EUOFfnOcI1O8P6mLv3+Ux5SckSTROhLbdL3oo0X10cDYVUcW/2Mz9lWaROYYPIFWGQcU7DzjUrsiNG7xzLVFhrn6YIpGBpyu/90bUIEYFyR02u3RcHL8+zl5N2a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834536; c=relaxed/simple;
	bh=J8z4feXQofrPOrZAaMMCNtsMh5WCYVTCcVS4fYVxK8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGEipCuEt0UbJO/f8t4/DER2YzjWbrVJ+VRLWZVnMrf9VACsKwAMB7DfbcWEHN/s1rRU8/a9oow8Bwbl5e2hXUGsHpKQSLVJ/3oYJz3m1BE+UaMZK09qu+vDrgDNqlCpDRA+nvqnJ5YBTgFhpZFOApzq0fpbkdwaN0aCv1RvsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4heFP41; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4heFP41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738834535; x=1770370535;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J8z4feXQofrPOrZAaMMCNtsMh5WCYVTCcVS4fYVxK8A=;
  b=l4heFP41YvSq6zskrWVL18XFoZD7E6968+olJidh3lO7VANytPYeMlmK
   3F0GbITX2OgefqetUiFaSvarI4I5mYLvp/De3AEiXrWPBsVbA9soVJiD2
   weYzNpe0Sq5eDXmJuiQ+rEdK3PL7TWgC6wYzAFfnKonN5qclnTISd9vz/
   2EEknT2ceefVs8yR7Mkl9Opfe2akyVunejgvc0jXGALAC0/hbw+SLCbEF
   KRFkucjhCECfinyOWRS1b7Xk2ruKBMiij446UqjpGiQpqMY8TicA9mj8y
   k17nPZIsc5q85N2dMU7cAZ/UX5KFWLkOBmP1YLZ7Q7rZcRv6rDx62vHFt
   A==;
X-CSE-ConnectionGUID: uTYdHseCR4mrfHbd3mJDZA==
X-CSE-MsgGUID: q7BJ2XqSTm6goy5kNzy5yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43090699"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="43090699"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 01:35:34 -0800
X-CSE-ConnectionGUID: jHqcwLsUTqeo83cfobT5Tw==
X-CSE-MsgGUID: nXdd+6+FQy2qeI9/jGctmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="111126500"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 01:35:30 -0800
Message-ID: <16417b83-af65-4ed2-9b9a-c82363abdd4a@linux.intel.com>
Date: Thu, 6 Feb 2025 17:35:28 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] perf/x86/intel: Add PMU support for Clearwater
 Forest
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-2-dapeng1.mi@linux.intel.com>
 <20250127162651.GL16742@noisy.programming.kicks-ass.net>
 <d31dcd21-7455-4108-96d7-e29ecde1c5de@linux.intel.com>
 <20250206075356.GF7145@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250206075356.GF7145@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/6/2025 3:53 PM, Peter Zijlstra wrote:
> On Thu, Feb 06, 2025 at 09:31:46AM +0800, Mi, Dapeng wrote:
>> On 1/28/2025 12:26 AM, Peter Zijlstra wrote:
>>> On Thu, Jan 23, 2025 at 02:07:02PM +0000, Dapeng Mi wrote:
>>>> From PMU's perspective, Clearwater Forest is similar to the previous
>>>> generation Sierra Forest.
>>>>
>>>> The key differences are the ARCH PEBS feature and the new added 3 fixed
>>>> counters for topdown L1 metrics events.
>>>>
>>>> The ARCH PEBS is supported in the following patches. This patch provides
>>>> support for basic perfmon features and 3 new added fixed counters.
>>>>
>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>> ---
>>>>  arch/x86/events/intel/core.c | 24 ++++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>> index b140c1473a9d..5e8521a54474 100644
>>>> --- a/arch/x86/events/intel/core.c
>>>> +++ b/arch/x86/events/intel/core.c
>>>> @@ -2220,6 +2220,18 @@ static struct extra_reg intel_cmt_extra_regs[] __read_mostly = {
>>>>  	EVENT_EXTRA_END
>>>>  };
>>>>  
>>>> +EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_skt,        "event=0x9c,umask=0x01");
>>>> +EVENT_ATTR_STR(topdown-retiring,       td_retiring_skt,        "event=0xc2,umask=0x02");
>>>> +EVENT_ATTR_STR(topdown-be-bound,       td_be_bound_skt,        "event=0xa4,umask=0x02");
>>>> +
>>>> +static struct attribute *skt_events_attrs[] = {
>>>> +	EVENT_PTR(td_fe_bound_skt),
>>>> +	EVENT_PTR(td_retiring_skt),
>>>> +	EVENT_PTR(td_bad_spec_cmt),
>>>> +	EVENT_PTR(td_be_bound_skt),
>>>> +	NULL,
>>>> +};
>>> The skt here is skymont, which is what Sierra Forest was based on, and
>>> you just said that these counters are new with Darkmont, and as such the
>>> lot should be called: dmt or whatever the proper trigraph is.
>> Sorry for late response since the Chinese new year holiday.
>>
>> Sierra Forest is based on Crestmont instead of Skymont. 
> I hate all these names :-( But yeah, you're right.
>
>> The 3 new fixed counters are introduced from Skymont and Darkmont
>> inherits them. So these attributes are named with "skt" suffix.
> Fair enough.
>
> But how come this is new for darkmont and wasn't done for
> arrowlake/lunarlake which have skymont based e-cores?

ARL/LNL are all hybrid platforms, all the event attributes are defined with
a kind of P-core and E-core mixed format like below.

EVENT_ATTR_STR_HYBRID(topdown-retiring,      td_retiring_lnl, 
"event=0xc2,umask=0x02;event=0x00,umask=0x80", hybrid_big_small);
EVENT_ATTR_STR_HYBRID(topdown-fe-bound,      td_fe_bound_lnl, 
"event=0x9c,umask=0x01;event=0x00,umask=0x82", hybrid_big_small);
EVENT_ATTR_STR_HYBRID(topdown-be-bound,      td_be_bound_lnl, 
"event=0xa4,umask=0x02;event=0x00,umask=0x83", hybrid_big_small);

static struct attribute *lnl_hybrid_events_attrs[] = {
    EVENT_PTR(slots_adl),
    EVENT_PTR(td_retiring_lnl),
    EVENT_PTR(td_bad_spec_adl),
    EVENT_PTR(td_fe_bound_lnl),
    EVENT_PTR(td_be_bound_lnl),
    EVENT_PTR(td_heavy_ops_adl),
    EVENT_PTR(td_br_mis_adl),
    EVENT_PTR(td_fetch_lat_adl),
    EVENT_PTR(td_mem_bound_adl),
    NULL
};

CWF is pure E-cores and can't directly use this existed attributes, so
define these new attributes.



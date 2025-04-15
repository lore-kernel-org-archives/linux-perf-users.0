Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102A29A3D6;
	Tue, 15 Apr 2025 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734670; cv=none; b=Y7WvI9UtmIsB5IcTRjuRJ2Una4lMOjiKhlXOBu6wdECxwk0KRTd9m1giX42fIuQzbW4/snvJ9z4g0HjtFNQLYmCGY76zv22W6z1SlEsS3RASze0WrxVRV4vyQaVkv9HnvIYYEJ2a7IQaBKgE6+QfHmiOQ3L/MpmS9zVFh/cZB74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734670; c=relaxed/simple;
	bh=1acXItjHQpziw30nr7ed9lcmu99G8jYL55wgEsCJhRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfOlXVW/UShuKzVDZkFEUYVs+OCp7Mv6BmuENzjXpIhckbkIUuNiyGz60zFzNMH3rzl83jOplLSAG4Abv2EhRknNXurpK+Bu91JYh47F0Yylsi8tSxsS30mEzuh6+fbqSl6KxhFZmtx4Ueh7z6bxv/DOyi0rq6wIE6SV/G8rKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1tg7QNA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1tg7QNA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744734668; x=1776270668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1acXItjHQpziw30nr7ed9lcmu99G8jYL55wgEsCJhRU=;
  b=S1tg7QNAJIqlzymvGuSN6GgSIbX2lwukgkqIn/18sgZosDVEqvYD+h76
   tT0hKdAvXhjm5elJl2D2v/ZLHJQZkFp2xVsnuLN5gVfbZlyJTLSduu6kv
   D8fAv8SIlhtEeaUg9pf23j8RUoXhVBpyIBgsJwQoDj7yzlKK2QzhHkPdg
   53f0H2eNgd3IsDxjzGu9KlWLtR3W+8TIcVgB7TfW4eYYsSzSId0w0Dt7a
   n2/u5MfLcIlkWUGohH1nzrKKNtaulnsEBoWBE5gEeF8ZEVpCcED3b+uCX
   DkZCm99xjzn7yXecBnWnGs3NqX2BiUnwgp/Z+fR88eM9JhIDPirLKXqMZ
   g==;
X-CSE-ConnectionGUID: VeT5XW10SQ6KoOgMA5PBSg==
X-CSE-MsgGUID: 8VQbRCeQSaui+FmY7nWwKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="33872818"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="33872818"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 09:31:07 -0700
X-CSE-ConnectionGUID: sndavqITQFSpl9CyD5mOTg==
X-CSE-MsgGUID: 04Q2R2BaS+WnBbxWi7aNaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130132506"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 09:31:08 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 3686E20B5736;
	Tue, 15 Apr 2025 09:31:05 -0700 (PDT)
Message-ID: <607b1f13-1d5d-4ea7-b0ab-f4c7f4fa319b@linux.intel.com>
Date: Tue, 15 Apr 2025 12:31:03 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 12/22] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
To: Peter Zijlstra <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-13-dapeng1.mi@linux.intel.com>
 <20250415135323.GC4031@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250415135323.GC4031@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-15 9:53 a.m., Peter Zijlstra wrote:
> On Tue, Apr 15, 2025 at 11:44:18AM +0000, Dapeng Mi wrote:
>> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
>> sampling and precise distribution PEBS sampling. Thus PEBS constraints
>> should be dynamically configured base on these counter and precise
>> distribution bitmap instead of defining them statically.
>>
>> Update event dyn_constraint base on PEBS event precise level.
> 
> What if any constraints are there on this? 

Do you mean the static constraints defined in the
event_constraints/pebs_constraints?

> CPUID is virt host
> controlled, right, so these could be the most horrible masks ever.
>

Yes, it could be changed by VMM. A sanity check should be required if
abad mask is given.

> This can land us in EVENT_CONSTRAINT_OVERLAP territory, no?The dyn_constraint is a supplement of the static constraints. It doesn't
overwrite the static constraints.

In the intel_get_event_constraints(), perf always gets the static
constraints first. If the dyn_constraint is defined, it gets the common
mask of the static constraints and the dynamic constraints. All
constraint rules will be complied.

	if (event->hw.dyn_constraint != ~0ULL) {
		c2 = dyn_constraint(cpuc, c2, idx);
		c2->idxmsk64 &= event->hw.dyn_constraint;
		c2->weight = hweight64(c2->idxmsk64);
	}

Thanks,
Kan


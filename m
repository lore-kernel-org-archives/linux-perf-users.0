Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83630F92E
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662136; cv=none; b=BKmoBAlwsafEHmRTFkGNatdNBxlar1LUHJgASMPI/6Cts0yqTPlf/SVQpzADO9RgcFA172k3sd7OiK2EwcsCAbJGscc978+Yhm9+bjesPKF5gUF3uFDVzeiaGd6HoLtj8uOfpYJR0kYWuvkKgNFSHINWNBtEOD1DRLgQxWj21rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662136; c=relaxed/simple;
	bh=e7HfHug5Y8Z7SBTfW+u3rv0Z3Ai9il89WEgBk7p5lqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1MweesN9l4CkwWMKELiDfqZhcNUYLC20iNcOkOSwkgNFj8LoBlKv5JhNudHoGG7XlWmbYlrMzXXhsig84e5xExpFQGAU1Re2zU60nZwcJUSslF6zO2iTsnhXFL/qiYHNvpteVp4Idttw/6+dJU9AF9UC2zDkXplFY9tcDb0jAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g38+X7+m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g38+X7+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790662134; x=1822198134;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e7HfHug5Y8Z7SBTfW+u3rv0Z3Ai9il89WEgBk7p5lqM=;
  b=g38+X7+mn8lMQyNzIBf+2J4E14k2BEAw1CObm2peTz/a9+wKwl+GQllP
   ZjztuvV/GamiYeDEy78hlvt6GwfdwsSxu3D3rkKWzQ5c5VpZNVkqZMCR4
   +/xfxO7UIAESIMOOAfsCbwjEQQQ3EOLGCc1HFmYoavPy0zgF+LDkKMbha
   22AsBYIMSCyyS3iz643MW43z7d08U535kGlsPjpbLNQ2zhbHn2f60SN31
   pZVHRNMSbYOmNOcV9eaLoBuxLYFteE1O2WUzL437T/iWIgdiOhh4+TZgJ
   rE28oOCiAPHpuwLLRLyUXfY4O+FrmD3Op4jc5Fu9vyvlnUGwOT0oOKYP3
   g==;
X-CSE-ConnectionGUID: N/f8uurWQb2oZXknZm706A==
X-CSE-MsgGUID: S64UKhiyQs6/GVHjPY9UyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="116900998"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="116900998"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 23:08:53 -0700
X-CSE-ConnectionGUID: eAS+XA21QVu5PE2J8fYNmg==
X-CSE-MsgGUID: PL1oSM0CQnemSG4LoAoirQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274492597"
Received: from unknown (HELO [10.238.1.105]) ([10.238.1.105])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 23:08:52 -0700
Message-ID: <1827c1cc-a543-4a27-afb5-ccef49493055@linux.intel.com>
Date: Tue, 29 Sep 2026 14:08:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] perf/x86/intel: Reject SAMPLE_READ for
 no-counter-snapshot ACR events
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-8-dapeng1.mi@linux.intel.com>
 <20260928080451.9139A1F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260928080451.9139A1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/28/2026 4:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf/x86: Validation bypass for SAMPLE_READ on ACR events via software events
> --
>
> commit cc3bcd9a57c859b5993ae9c14bd06faec36a3c33
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Reject SAMPLE_READ for no-counter-snapshot ACR events
>
> This commit restricts the use of PERF_SAMPLE_READ for Auto Counter Reload (ACR) 
> events to prevent perf from reporting invalid counts. It ensures that 
> SAMPLE_READ is only permitted for PEBS-backed ACR events with counter snapshot 
> support, as non-PEBS events can be auto-reloaded before software reads them.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 377ff39124206..3fc3795534bf7 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>
>> @@ -5184,6 +5239,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  		if (hweight64(cause_mask) > hweight64(hybrid(pmu, acr_cause_mask64)) ||
>>  		    num > hweight64(hybrid(event->pmu, acr_cntr_mask64)))
>>  			return -EINVAL;
>> +
>> +		if (!intel_pmu_allow_acr_sample_read(event, has_sample_read))
>> +			return -EINVAL;
>> +
> [Severity: Medium]
> Does this validation fully prevent PERF_SAMPLE_READ from being applied to ACR
> groups?
>
> Because this check is inside intel_pmu_hw_config(), it is evaluated when the
> x86 event is initialized. If a user creates an ACR hardware event group
> initially without PERF_SAMPLE_READ, it will successfully pass this check.
>
> What happens if the user subsequently creates a Software PMU event (like a
> dummy tracepoint) with PERF_SAMPLE_READ set, and attaches it to the existing
> ACR hardware group using the leader's group_fd?
>
> Since perf_event_open() allows software events to be attached to hardware
> groups without re-invoking the hardware PMU's validation callbacks for
> existing members, it appears intel_pmu_hw_config() won't be re-evaluated
> for the hardware events. 
>
> When the appended software event overflows, won't perf_output_read_group()
> read all siblings and still capture the imprecise auto-reloaded values of the
> ACR hardware counters?

Yes, it's a real risk. But it's hard to implement the check for last
software event in current framework. If the last event in the group is a
software event, then intel_pmu_hw_config() won't be involved to validate
the software event.

I suppose this could be just a corner case, we may leave this as a known
issue. Thanks.



>
>>  		/*
>>  		 * In the second round, apply the counter-constraints for
>>  		 * the events which can cause other events reload.

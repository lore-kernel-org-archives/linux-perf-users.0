Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364EBF9E4
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594742; cv=none; b=AOKwa88iOfVJlbZNg9AKS8mYNpbDIJWs1Z/uW2Q4yXmg9tk90UA5EnvvSv5DYcYboSOlWE2gybAj1TRWBqRtbyGD79RKZtaMSS89mPvUi3w42OHODUoBMKRuM/oib9SUJmqjZVZWMP4TEjDSMLv47ZYXOzWY5n8ApRI7huxwYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594742; c=relaxed/simple;
	bh=T7r75LGtlVoLBkdRmSOT4C//Bff+94oQE48Owlsp16g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghVJ981Et2vHJMRJBbZYMUtdMOF3Ywb2Fx+snara6aBS8V7F0BWYoXB/2lA1WBU3Fvi5k5nTc8avnFmHoo02p8s0zYgMidXmTeQOEUtTP15W27B10xCi2EiV5Sdq3mN7aShJUTRyIvqJxnWTK1s/bxQfxJNF5F3c1aYd35UzSGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ome3RNvq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ome3RNvq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731594740; x=1763130740;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T7r75LGtlVoLBkdRmSOT4C//Bff+94oQE48Owlsp16g=;
  b=Ome3RNvqPFiUlDITD96pN+pyjThjuu78DsIJEn8MbuTOM+4aNWM8HTPj
   yoe5gp0D84aPkFLdpO7gfU2qVm7GK22aEuZ59KofpBaiabi+CDjZ1hCl6
   c/253oHRiz8En/WeNzYSpUMtxYGNwyD/vEpcrDij9sTsClpIWtxWhMY3S
   o6SaHDpLwJ8lP9Wr2quFc/XdMveIDxT+mKTH63Lc4LASncQm4esoWYvWI
   0CjF9hQOb3uNqIjPPGF5oE6k8c26OKDWcfczpWEEUkQ4TsP5wofWf8CsI
   EswVeDW4gQ72pwbHJGAGxfMccS6Tn1OOE17ScEXeniXleTbU7AvG11AWF
   g==;
X-CSE-ConnectionGUID: fRuTDYqBQuS6f7gFk+ZZxw==
X-CSE-MsgGUID: 8BD7eLBBRCafn+/CJEPIXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="19148449"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="19148449"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 06:32:16 -0800
X-CSE-ConnectionGUID: xZR4clhCSXSgCE9iDjJZLQ==
X-CSE-MsgGUID: VNTJA191SS6P6OMtJH/H5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="88643034"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 06:32:16 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7C30D20B5703;
	Thu, 14 Nov 2024 06:32:15 -0800 (PST)
Message-ID: <e37d7c6b-91c7-4fd7-831b-98f0dca5d46c@linux.intel.com>
Date: Thu, 14 Nov 2024 09:32:14 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Intel Arrowlake and hwcache events
To: Michael Petlan <mpetlan@redhat.com>, alexander.shishkin@linux.intel.com,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org
Cc: qzhao@redhat.com, vmolnaro@redhat.com
References: <ea7b2c27-7512-f412-32c0-3a247fd930f9@redhat.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ea7b2c27-7512-f412-32c0-3a247fd930f9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-11-14 4:54 a.m., Michael Petlan wrote:
> Hello!
> 
> Qiao Zhao (CC'd) has found out that there are no hwcache events available
> on an Arrowlake system he was testing perf on. 

There are several variants for Arrowlake.
#define INTEL_ARROWLAKE_H		IFM(6, 0xC5)
#define INTEL_ARROWLAKE			IFM(6, 0xC6)
#define INTEL_ARROWLAKE_U		IFM(6, 0xB5)

The INTEL_ARROWLAKE should be supported in 6.10 and later.
The INTEL_ARROWLAKE_H was just merged and should be available in the
upcoming 6.13-rc.
https://lore.kernel.org/lkml/20240808140210.1666783-1-dapeng1.mi@linux.intel.com/

The patch to support INTEL_ARROWLAKE_U hasn't been posted yet.

Which system were you testing?

> We have found out that it
> does not work even on 6.12.0-rc6+. Are there still drivers that haven't
> been merged yet?
> 
> Happens that nothing matches in this loop:

The HW cache events are usually model specific events. You cannot see it
unless there is specific support.

You may also get more clues via dmesg | grep PMU.
If you see "generic architected perfmon", it means the specific support
isn't ready in the kernel.

Thanks,
Kan
> 
> int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state)
> [...]
> 305		for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
> 306 		for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
> 307  	 		/* skip invalid cache type */
> 308 			if (!evsel__is_cache_op_valid(type, op))
> 309					continue;
> 310
> 311			for (int res = 0; res < PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
> 312 			char name[64];
> 313				char alias_name[128];
> 314				__u64 config;
> 315				int ret;
> 316
> 317				__evsel__hw_cache_type_op_res_name(type, op, res,
> 318													name, sizeof(name));
> 319
> 320				ret = parse_events__decode_legacy_cache(name, pmu->type,
> 321													&config);
> 322				if (ret || !is_event_supported(PERF_TYPE_HW_CACHE, config))
> 323					continue;
> 
> Thanks,
> Michael
> 
> 


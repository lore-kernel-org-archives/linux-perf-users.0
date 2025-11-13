Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4535971B;
	Thu, 13 Nov 2025 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058036; cv=none; b=i5T73q9cmPtM0EKTQTPKByJ46hxWodF5biW6eW93ytdRXO/lwMuE4fouUs9zxlxMO/teRvo+aSAix4XToIYb0p1hR005o/J/9vxvq9RjyCJ0OJ0ESfBUBUirMJ30D2lKLZnRVJoCyqugfe+l7ByB2FQTcdqayAqDb+W+up+Ua8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058036; c=relaxed/simple;
	bh=xBPAuk5vfKvWiJamfUh8vtN+hDRtyxOY2R9j/XJFKjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHO4N0AkZQZNBAD8eV6Ex7lihfK7CqmK0gn4nEUDbwKX5NGZ9rRkWlNPQNu7rxPVrukC70VWS3Yd63dHICfOH8ZPF0rbJyXQ1WPVyByuuYnV9TouVMtNRxdvs9R26WAWQTdsDSVU5vy8SA//26gPSqcZplts27flTfDeU+jSy1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpJiW3zf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpJiW3zf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763058033; x=1794594033;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xBPAuk5vfKvWiJamfUh8vtN+hDRtyxOY2R9j/XJFKjc=;
  b=XpJiW3zf6l/Hv+LBY1YRX0kbTx/oBHgrrcy6DZ5Jmmz8qqezuttH4fv6
   LmgSJaMq3Ez1XTxk6rNY3vkfrbPoJvDVDMVP2RSABte6T2KBKPYXkR2p3
   1vl4acKJAjUEvdJFV0xJn/sly3h9YhLsItyyVdtdgiaH+NMXbFT6jeM7U
   7o60LHh8075pRf36K6nCYB1Gu4bd558vMUksQCKG85SNRMoWdv5TvAWI3
   fOVNGOLnfN0hfXCwaCDlhzj5xwkUxPpZn2TC6YXEKtT3jmSTfVE/9qkeM
   nM7CiFgWNMf8EpBJZIHLRibIvxXa8XhsWopnwNhahMlZoyIzP+MqlIZIs
   A==;
X-CSE-ConnectionGUID: cdgvioXrT7+2akBqUM54zg==
X-CSE-MsgGUID: qb7PpgVARCChTIa599eiZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65243689"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="65243689"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:20:31 -0800
X-CSE-ConnectionGUID: +nko5Ir0SgaPEbP1Ndp03g==
X-CSE-MsgGUID: UdlA+nJBQZandO7u60GayQ==
X-ExtLoop1: 1
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.108.136]) ([10.125.108.136])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:20:31 -0800
Message-ID: <6e84a532-5d30-487f-b849-84893ac2a652@intel.com>
Date: Thu, 13 Nov 2025 10:20:31 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/events/intel/cstate: Add Pantherlake support
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>,
 "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "Hunter, Adrian" <adrian.hunter@intel.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251112090024.3298186-1-kaushlendra.kumar@intel.com>
 <1ba407b6-a108-41ce-b1b2-3c03aa25d272@intel.com>
 <LV3PR11MB87682D759248CA310546261CF5CDA@LV3PR11MB8768.namprd11.prod.outlook.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <LV3PR11MB87682D759248CA310546261CF5CDA@LV3PR11MB8768.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 20:05, Kumar, Kaushlendra wrote:
> On 11/12/25, [Reviewer Name] wrote:
>> On 11/12/25 01:00, Kaushlendra Kumar wrote:
>>> It supports the same C-state residency counters as
>>> Lunarlake.This enables monitoring of C1, C6, C7 core states and
>>> C2,C3,C6,C10 package states residency counters on Pantherlake
>>> platforms.
>> 
>> Is this actually documented? Or is there just a smoke-filled room
>> at Intel somewhere where this is decided?
> 
> Good point. Baseline for Pantherlake is Lunarlake with respect to C
> states. It is documented in internal documents. This approach is
> consistent with similar implementations throughout the kernel
> codebase for related CPU families.

It needs to be publicly documented somewhere. It doesn't have to be
fancy: a web page or white paper would be fine.

I know it's been allowed to slide up until now. But, according to[1]:

	We (Intel) continuously improve, enabling us to be more curious,
	bold and innovative.

So, can we try to improve this, please?

...>> Also, why *can't* this just be enumerated?
> 
> Could you clarify what you mean by "enumerated"? Are you suggesting:
> 1. Runtime detection instead of static matching?
> 2. A different approach to CPU model matching?
> 3. Something else?
> 
> The current approach follows the established pattern for other Intel 
> CPU models in this driver. If there's a preferred alternative approach, 
> I'm happy to implement it.
Your patch effectively says:

	PTL supports C10 package states residency counters

(among others of course). Why can't there be a bit in CPUID or an MSR
somewhere that, when set, means the same thing? That way, we don't have
to keep patching the kernel every time there's a new CPU model.

I guess in general PMU things haven't been architectural. But this seems
like something that wouldn't be too hard for the CPU itself to enumerate
to software.

1.
https://www.intel.com/content/www/us/en/corporate-responsibility/our-values.html

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F218645038;
	Thu, 27 Feb 2025 02:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621958; cv=none; b=OEkMlQHjGQcPysF6aHcgALqW9gg4GoJoBgOOHjrfMI9I2YNp6TeRPoRkWiOHgyZaTVwLlr94ev0oKFgQpbLjI8vpbK1CHyQIDMLEoymnACFNg6deicNc1u+wwHPgvovVDdu3BOvPnQQATWkBSfmRzGKxvtB2Jkkutz0t6XP2vXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621958; c=relaxed/simple;
	bh=JzWgb3ouRwEj23CenLkm9khTdhrCYcxsAd00GiZIGpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsS3+JES54uKlL8oblt7knKra8pZuIvNNHXmMj83ZjnSxdmFbbC5Va2YT+8I65yu0n2alhpYkKfM8MifNEr4+yM4PfbslkKUFxi6F/7f3Neko7PMWqqB6Mc3MK9wb7EErlvIDwycG/DYVqvbqVY870JSWIMOEnsPmbz7t06vnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kotd1l6g; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kotd1l6g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740621957; x=1772157957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JzWgb3ouRwEj23CenLkm9khTdhrCYcxsAd00GiZIGpk=;
  b=kotd1l6giuBzaON1zxb9m/0jROWBOT2fRyeenD7rq/5lmZBh9UPZcGSi
   NWwbBQPMQjAZPKpSMGibYuif7bmYvSyr0GnjkuGt/yc0VdF5/tVUcdmv/
   wikZt+8x7Oa60UZrbAhAd/5SorttdQiBf3q9YM3DyCebe9Fiee2Xv9wEo
   rqysZUpzPR15r2cWUjC395WLHOm+AhXwO2qAEJi958sTgSf/MswOrZyOW
   kSr8H1dtdz8m57VAP8+hoJl2JTcqS2dmu6LBQRiKxqoZBwYTKQXpJ4AQd
   uNelxGMpGGWQg8M7u4RiIctDtb03A7CDWe9AdylUnl6n7rH5KBXzSqPOu
   Q==;
X-CSE-ConnectionGUID: fK4C7L7CRN6mtm6noUjVFw==
X-CSE-MsgGUID: 90sAETMPQoWEGaYL10c/rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41348548"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="41348548"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 18:05:57 -0800
X-CSE-ConnectionGUID: p/VwjY/wTrGcA624VSj1/g==
X-CSE-MsgGUID: UPjosW/eTXmRqHbyByLvLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="117368295"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 18:05:53 -0800
Message-ID: <08f9f344-4414-4819-87b9-538d8ed3b040@linux.intel.com>
Date: Thu, 27 Feb 2025 10:05:50 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 12/24] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-13-dapeng1.mi@linux.intel.com>
 <20250225111805.GL11590@noisy.programming.kicks-ass.net>
 <2e1b48d7-1528-4de0-affa-e6c13e0ce1b1@linux.intel.com>
 <20250226094656.GS11590@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250226094656.GS11590@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/26/2025 5:46 PM, Peter Zijlstra wrote:
> On Wed, Feb 26, 2025 at 01:48:52PM +0800, Mi, Dapeng wrote:
>> On 2/25/2025 7:18 PM, Peter Zijlstra wrote:
>>> On Tue, Feb 18, 2025 at 03:28:06PM +0000, Dapeng Mi wrote:
>>>> Arch-PEBS introduces a new MSR IA32_PEBS_BASE to store the arch-PEBS
>>>> buffer physical address. This patch allocates arch-PEBS buffer and then
>>>> initialize IA32_PEBS_BASE MSR with the buffer physical address.
>>> Not loving how this patch obscures the whole DS area thing and naming.
>> arch-PEBS uses a totally independent buffer to save the PEBS records and
>> don't use the debug store area anymore. To reuse the original function as
>> much as possible and don't mislead users to think arch-PEBS has some
>> relationship with debug store, the original key word "ds" in the function
>> names are changed to "BTS_PEBS". I know the name maybe not perfect, do you
>> have any suggestion? Thanks.
> Right, so I realize it has a new buffer, but why do you need to make it
> all complicated like this?
>
> Just leave the existing stuff and stick the new arch pebs buffer
> somewhere new. All that reserve nonsense shouldn't be needed anymore.
>
> Just add it to the intel_pmu_cpu_{prepare,starting,dying,dead} things.

Sure. would do.



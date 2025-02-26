Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247719D8A4;
	Wed, 26 Feb 2025 05:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740547493; cv=none; b=laMQVVOPQn5SPw2kATttUCd9eJNaIP3lguVooIxjpwqgANYvWz2Q9GPm+yYHkyjH1hRqy/ZnQWXcRe6WJZrZUkEcEYPEWK1+bM2BqpazUCU8F6zycSz0wYF+Gf3FOfrRh4/ZkyDyQPGf2PSUprgOPRyBntrpb7G1wFSWmu0cBiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740547493; c=relaxed/simple;
	bh=PUgV2L1qpalJMMJ345KkxrEEGZh3KK/OjXN2N+zVGc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msoioNxbK49RHuvb/GfuXpJIzcz/Bh9ZQSg9zKPm+h32vofvgQQoMhHM3Lc4XjxlQ5oPydK+LC5U3N3yCH1p0jOdOFeQbI/i+i6EMv5Cm1LIMUVQthMkkqKlBvlE4oF236Lsom94uZXfgwOgOMPY/RMLcoj/lAzPBwqso9Khyv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i60zKSSs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i60zKSSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740547492; x=1772083492;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PUgV2L1qpalJMMJ345KkxrEEGZh3KK/OjXN2N+zVGc8=;
  b=i60zKSSsuMpdktujq/KnQlSSb6WtSPrG+c4S2KQu3mpEMG46RFnLVBlo
   zLAieSRACNIZw3EszIr4CbBrBKO951wmWz0VOkOLsYmHoMGUatA0OmLzN
   P4/miWywQBC5BrmLxXJYdfayEeNbbZgKlBNzeemYNr5SpBP3WSbdfoQP3
   HY1fIu2YtLXFE3GEeiQzBykcnRn0ZicNFz4MrnFIgzQtvxWvP/Rms2qq7
   NRcE1RWb6VHzrcBlVXz2T0mi1RGv2Cgxf6VD9OP38E+qsSO/mjzdI/2An
   pQbLDRBPyZDdX4deH6zC+Y01ikmNl5/qO+CmxyhrljZlIVmzUuhnDW3Xk
   w==;
X-CSE-ConnectionGUID: XXgtMBaTQo2v1xgL1zHZLA==
X-CSE-MsgGUID: 2BVUDEALR8imIaLDAnNFnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52800313"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52800313"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:24:51 -0800
X-CSE-ConnectionGUID: zrtRMa0oT3Op07mPRWsd+g==
X-CSE-MsgGUID: rM1X7wpTSDaxvMye8mFshA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121541330"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:24:47 -0800
Message-ID: <42081958-3d07-4dab-87f7-f4b0c726d24e@linux.intel.com>
Date: Wed, 26 Feb 2025 13:24:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 11/24] perf/x86/intel: Factor out common functions to
 process PEBS groups
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-12-dapeng1.mi@linux.intel.com>
 <20250225110217.GK11590@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250225110217.GK11590@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/25/2025 7:02 PM, Peter Zijlstra wrote:
> On Tue, Feb 18, 2025 at 03:28:05PM +0000, Dapeng Mi wrote:
>> Adaptive PEBS and arch-PEBS share lots of same code to process these
>> PEBS groups, like basic, GPR and meminfo groups. Extract these shared
>> code to common functions to avoid duplicated code.
> Should you not flip this and the previous patch? Because afaict you're
> mostly removing the code you just added, which is a bit silly.

Sure.



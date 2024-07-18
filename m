Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108B884DF5;
	Thu, 18 Jul 2024 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315189; cv=none; b=btVAnazhJhIfpHx0f/O3RYm+pHHWLQCfYRQS5p1f+96RVC1hlRlKXzyN89TBYngG2OzA+UyIjgOX1VGTrduzxa22dYdIVgZ3QiJNHWz6WEPA/+zqrdsrgBWDixIMjQiC9woZ9cX3FMTewI3di6Yo13ZutyVUFwXNOZAk+8wc/Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315189; c=relaxed/simple;
	bh=xWEG6GnW8oWj5fZCGPjd8eUta8B9DzBMlHdsowxGO6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvOweokKhZ7MRNUbTNmcF7wXcTSgqwMA54Z1dCSv3sZl5IRRWcTy9727iKKkOmFgEklXBO2kUgl4fkuwv5yjROuDS6aykAtocz4ekQvH90D2iK3zy6HxHqgE35/h2fz/J1lAcPfAXP4GR/uTjLxbf8yHHBLAoOUBUDFQYuo8W50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCmvFCss; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCmvFCss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721315188; x=1752851188;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xWEG6GnW8oWj5fZCGPjd8eUta8B9DzBMlHdsowxGO6I=;
  b=WCmvFCssHwZahGFoj3Hx12NnOBt1RWaTZT7uhNUaSV6tHFYj73lqWFyd
   MGfUBhhXxKGuWx/gP6aRjvsx1TKUhRgGiCsj42PHfJQ2lADuv/olu9o3j
   k97M0eeO9IfZ3bgVKT6HXRVW5mXElpKjlHx9JrvQKYo0a6HigU6/20tlU
   ZNbO33aEumphUfgNdygECQbL+xlLGrO6nuGElztAMr/QClwVzlGu8A/4f
   zK5hX3WULonZXpmrWSawFX2azYpM/4ydCf/iHHHYIwqM5ub6vXWoGdJzJ
   PT21zvvzf/rQaZ9qPxnL/BeAmL/Dkkcfvm8l40oAjruWhQmEWp2+Iozqs
   Q==;
X-CSE-ConnectionGUID: jetAEcNtS2ig24JdD48hFg==
X-CSE-MsgGUID: rHU7fcBkSq+W6ZXhbCzSew==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="22743963"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="22743963"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 08:06:27 -0700
X-CSE-ConnectionGUID: djibNPuXR/aigB4EFVEZSA==
X-CSE-MsgGUID: 7IEqcivvR/KYdlkE2wcF3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="54985720"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 08:06:21 -0700
Message-ID: <ef63885b-f762-4398-beff-c695b24304e6@intel.com>
Date: Thu, 18 Jul 2024 18:06:16 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 02/13] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240715160712.127117-1-adrian.hunter@intel.com>
 <20240715160712.127117-3-adrian.hunter@intel.com>
 <20240718093846.GJ26750@noisy.programming.kicks-ass.net>
 <14cd68b2-eeee-42e3-87a6-c12d3814bd51@intel.com>
 <20240718115126.GK26750@noisy.programming.kicks-ass.net>
 <20240718125849.GI28838@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240718125849.GI28838@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/24 15:58, Peter Zijlstra wrote:
> On Thu, Jul 18, 2024 at 01:51:26PM +0200, Peter Zijlstra wrote:
> 
>> OK, let me do that and make a few more edits and see if I can stare at
>> that next patch some.
> 
> I pushed out a stack of patches into queue.git perf/core
> Could you please double check I didn't wreck anything?

Looks fine, and seems to work OK in a brief test.

Thank you! :-)


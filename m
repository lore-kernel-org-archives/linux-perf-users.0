Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF861EF0B9;
	Wed,  3 Dec 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745937; cv=none; b=k9KrVKFCUHlpJytRPDopD1rHmWOrAxDyMfqoCzEN7s5xdUt04FDtLXS2TXGEOZun1JpPqF34ZVJA4XmEkfyJE+bzPFJ+IqBGMJ7/A+eKHyjTNj3enz5LARBuoTBCxPyZ59MZSXiWEGhCX5EPKG924aFj1Dk+iB5s6MBD1MZ3b6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745937; c=relaxed/simple;
	bh=Qad5RWAQFkhqvLJYhjA4qG57Ms0/CcuyJjsepDFLyww=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SxOfWPTEsE+Jexi1BLAwiJ/iJ5ERqZk1+9or1Wsnf/deuYC//TMlLrpCCm9LnTG+UKZ2yAQz8BKz58SnAf3qdK5eULVlYFmnTAnS/eaPQxXzwAf2VqC4BFC8wU9FhYaAQx5k31GgN9W+IRjtrGn9eXUHaQVEjxPd3UUh2LD1DAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAHvcrXj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAHvcrXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745936; x=1796281936;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Qad5RWAQFkhqvLJYhjA4qG57Ms0/CcuyJjsepDFLyww=;
  b=eAHvcrXjTXjPHPWLDTqxQsPGGU0dXseFE73HQc0s7UfZK3pPY4jTwSEy
   twIwYaB+l2ErZYWl+YHXJixgiMXV9pxAqSq+Gs9eCZy5GilspyRHdxkrr
   BylWFCITP2vtUJX3ahwSLBmG90mAlSctJ1E6BlIiiGeIkfBzPFG790u6f
   1QN33xquGN8tET5PuBX5Jc9U5LxQmax+/h+Ukzq8V+tlqUfbhmH5pGsfX
   zVsEZk5GCQudenL3gLZuJRlLNp/iPKnuwoQ2yzWOLFbY5B4a+2GlRIBCE
   4rOL1gV73z4Y0BdibN/J57zij2GgOCVSw3pV8Ml8GS1C95zxkouae7Fk6
   Q==;
X-CSE-ConnectionGUID: nYuY9OUQTz6YGYGdGV6vCg==
X-CSE-MsgGUID: E9wTy16JRYWR2WvLBiVS4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66620688"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="66620688"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 23:12:15 -0800
X-CSE-ConnectionGUID: nTgqeR7lSgSrZZs1dUHuTA==
X-CSE-MsgGUID: B0rVuGRaQNOu4LCaIg0xNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="225542144"
Received: from unknown (HELO [10.238.3.115]) ([10.238.3.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 23:12:11 -0800
Message-ID: <934bdcb1-cd80-4c4c-bc32-411499f10429@linux.intel.com>
Date: Wed, 3 Dec 2025 15:12:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] Updated Intel events and metric unit fixes
To: Ian Rogers <irogers@google.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Edward Baker <edward.baker@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Caleb Biggers <caleb.biggers@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251202165340.555375-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251202165340.555375-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/3/2025 12:53 AM, Ian Rogers wrote:
> Update the Intel events using the script:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> pulling in 8 updates to event data and a metric unit fix.
>
> Ian Rogers (9):
>   perf vendor events intel: Update alderlake events from 1.34 to 1.35
>   perf vendor events intel: Update arrowlake events from 1.13 to 1.14
>   perf vendor events intel: Update cascadelakex metric units
>   perf vendor events intel: Update graniterapids events from 1.15 to
>     1.16
>   perf vendor events intel: Update icelakex events from 1.28 to 1.30
>   perf vendor events intel: Update lunarlake events from 1.18 to 1.19
>   perf vendor events intel: Update meteorlake events from 1.17 to 1.18
>   perf vendor events intel: Update pantherlake events from 1.00 to 1.02
>   perf vendor events intel: Update sierraforest events from 1.12 to 1.13
>
>  .../pmu-events/arch/x86/alderlake/cache.json  |  16 +-
>  .../arch/x86/alderlake/pipeline.json          |   6 +-
>  .../pmu-events/arch/x86/alderlaken/cache.json |  16 +-
>  .../arch/x86/alderlaken/pipeline.json         |   6 +-
>  .../pmu-events/arch/x86/arrowlake/cache.json  | 337 ++++++++++++++++-
>  .../arch/x86/arrowlake/floating-point.json    |  73 ++++
>  .../arch/x86/arrowlake/frontend.json          |  72 ++++
>  .../pmu-events/arch/x86/arrowlake/memory.json |  64 ++++
>  .../pmu-events/arch/x86/arrowlake/other.json  | 119 ++++++
>  .../arch/x86/arrowlake/pipeline.json          | 350 ++++++++++++++++++
>  .../arch/x86/arrowlake/virtual-memory.json    | 113 ++++++
>  .../arch/x86/cascadelakex/uncore-cache.json   |   2 +-
>  .../arch/x86/cascadelakex/uncore-memory.json  |  12 +-
>  .../arch/x86/graniterapids/cache.json         |   4 +-
>  .../arch/x86/graniterapids/uncore-cache.json  |   9 +
>  .../arch/x86/icelakex/uncore-cache.json       |   4 +-
>  .../pmu-events/arch/x86/lunarlake/cache.json  |  20 +-
>  .../pmu-events/arch/x86/lunarlake/other.json  |   1 +
>  .../arch/x86/lunarlake/pipeline.json          |  26 +-
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |  18 +-
>  .../pmu-events/arch/x86/meteorlake/cache.json |  20 +-
>  .../arch/x86/pantherlake/cache.json           |  38 ++
>  .../arch/x86/pantherlake/floating-point.json  |  73 ++++
>  .../arch/x86/pantherlake/memory.json          |   9 +
>  .../arch/x86/pantherlake/pipeline.json        | 305 ++++++++++++++-
>  .../arch/x86/sierraforest/cache.json          |  20 +-
>  .../arch/x86/sierraforest/uncore-cache.json   |   9 +
>  27 files changed, 1650 insertions(+), 92 deletions(-)

The whole patch-set looks good to me.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


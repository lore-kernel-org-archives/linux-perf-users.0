Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA62E3360;
	Wed,  2 Apr 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743626011; cv=none; b=IhGfMegeuFuR47UZ5ACH2fWKjIXspPzMqR8RAyqWjA4bri+9Z5PP1TttgzqUqa31nbEt6MozZfAKeKUH/JoR2/1hR5MTIL82IfxUzEoq9VANiit3AIjSM0Fopu6TjTMhsM+vwci7V/IQnXKjIpPFTsstI/DNyIJaX5fj+zZoCuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743626011; c=relaxed/simple;
	bh=Ky2oDARbnBISRNFB24tJGN0+lhE4zfoNlYttXQ5NtRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c5UA2CFdoFf3MeG7JZ5InDcL5m622eow7L+7W60eqLeJ3wfvCqCf3rWbB8qVBQedWNL4ZAutGX3Fqwkeu5aGFfrCx7sA1FmGuUC4CuJt43YB0pmOjvwMi7G4ppTLEOfyzFSqgjcVmrWf9MJbyDj2ZgiH47KpDI/YZi3cxxx7uSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDDYmRCY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDDYmRCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743626010; x=1775162010;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Ky2oDARbnBISRNFB24tJGN0+lhE4zfoNlYttXQ5NtRY=;
  b=VDDYmRCYXGm4NjoCo569UUQkbsKUBAuygV5z7WheTfUfNr90jd7GaJr1
   GQAPnihFbaTrzmzQzWsWmKLkC2US5OyhwXnicCtibZ7p6cDcBLIP26X4Y
   Paqnlj65+S5UMx0iaEfNmmHCp5Xq2qejAXB8aaqoZcJwT431Gu/9vi5+u
   sUwcIqduL+1loaM4bcUwcOVu7BrRsZiLOmyy2rOpIvzYxAsZcediGQrhZ
   IOkoz8tdaREGOULGmPbd9svhQTjrxOHdArqasy+CQywtlED7JQm7Jg0FS
   lfsox2zmlKS1gGmdyhVDXdS3bPv9Gs8yBDvvXS33Eyovbgu2nadZjHNcZ
   g==;
X-CSE-ConnectionGUID: Ay3Zd135QMa1s+OYe3ring==
X-CSE-MsgGUID: rJHJWE+TSkuX8DaghCohEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="55207241"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="55207241"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 13:33:29 -0700
X-CSE-ConnectionGUID: pC++GfITSmSZ+9DVxlAD3Q==
X-CSE-MsgGUID: sqitUD0ZTlWA5WrYeIByVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="157799585"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 13:33:28 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5199B20B5736;
	Wed,  2 Apr 2025 13:33:26 -0700 (PDT)
Message-ID: <18c2fb33-2b3a-4ebe-ab26-8cebe0b6b94c@linux.intel.com>
Date: Wed, 2 Apr 2025 16:33:25 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] NMI warning and debug improvements
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Howard Chu <howardchu95@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen
 <ak@linux.intel.com>, James Clark <james.clark@linaro.org>,
 Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250402201549.4090305-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250402201549.4090305-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-02 4:15 p.m., Ian Rogers wrote:
> The NMI warning wouldn't fire even if all the events were for one PMU
> type. Remove a nearby, and no longer useful, mixed hardware event
> group function. Improve the evlist to string function and dump it in
> verbose mode after the reordered events warning.
> 
> As commonly happens legacy events like instructions will be uniquified
> to hybrid events like cpu_core/instructions/, even though the
> encodings differ. To make this correct either:
> https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@google.com/
> or:
> https://lore.kernel.org/linux-perf-users/20250109222109.567031-1-irogers@google.com/
> needs merging.
> 
> v3: Increase the verbose dump length from 1024 to 2048 as requested by
>     Kan Liang.
> 
> v2: Rename evlist__has_hybrid to evlist__has_hybrid_pmus and add a
>     max_length parameter to evlist__format_evsels as suggested by Kan
>     Liang.
> 
> Ian Rogers (5):
>   perf stat: Better hybrid support for the NMI watchdog warning
>   perf stat: Remove print_mixed_hw_group_error
>   perf evlist: Refactor evlist__scnprintf_evsels
>   perf evlist: Add groups to evlist__format_evsels
>   perf parse-events: Add debug dump of evlist if reordered

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> 
>  tools/perf/builtin-record.c    |  9 ++++---
>  tools/perf/util/evlist.c       | 34 ++++++++++++++++-------
>  tools/perf/util/evlist.h       |  3 ++-
>  tools/perf/util/parse-events.c | 16 ++++++++---
>  tools/perf/util/stat-display.c | 49 +++++++++++-----------------------
>  tools/perf/util/stat.h         |  1 -
>  6 files changed, 60 insertions(+), 52 deletions(-)
> 


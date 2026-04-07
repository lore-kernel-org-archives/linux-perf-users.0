Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E622B9A4;
	Tue,  7 Apr 2026 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775522820; cv=none; b=GAK2JYP97ixp4FXggpZZbdminxmhymqAqIPReAHmN9d/k4JUklknZvavABgtqeS+jRQGsA4J48s/gsa4d86los/l5iQVUabVU3wF1+kUIRZguYYgTUliVpecWPJ/pvFV//1DtReH44noGnvScDP1TX6HzdBr7hFzVafz1Hp/UdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775522820; c=relaxed/simple;
	bh=SLZuMDBLfxr63z1VMKqC4vFcGC0di2z0ijdCDyyJ/IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdhvoCL3FLXVSVgI8JIg2yrf1izZN79eUSQ1PCP4o7qXf4TjVNPv+LjiRTEwoHlLXITa0Tox8rUJM4p2ktxPJhqghVv8PDRigmsEgnV3k2RMXS7oaRq/+OVdyNmv53xbbOsIFw/WNw7PCIxcsbEJVOIx/XfBCDcxcyU9NNaDgWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSAva4R+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSAva4R+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775522818; x=1807058818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SLZuMDBLfxr63z1VMKqC4vFcGC0di2z0ijdCDyyJ/IY=;
  b=dSAva4R+jtncrmvyBajnULAdasRPt91x92PNmuk2UHBXjb7LPeoNQbHd
   vKd9PLk1vTT89tAddKOPQUksV8GKJA1wFNi3uGlQV2SqnLQbieVlk6Uz+
   aBhlxXXbrwFO327vOJaut186mzsy8RZojUN0C357clpHD6Zui1Q5+Dquz
   QobqsnaOX5Sw4Jt/WSfGykHKnGnQV4EYnlZdJNbpzuGZbdE8Wq6rCcXsy
   M9iE2A/skh8UjF5ed3og8uD8Z0BAoC5D74CxrRe8RncpSEQWhU5z58J8x
   Mej5MArghtzlhuWAOJ0jyXRKIb+IDzPjbgGGNjHAf92BHd3TkYBvUWb/r
   w==;
X-CSE-ConnectionGUID: YQTh59kiSlGGXDv9DBYYLA==
X-CSE-MsgGUID: vQ7zmAeNQvqADDnNonklow==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="87180024"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="87180024"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 17:46:57 -0700
X-CSE-ConnectionGUID: kNfO3ahBTfGiUs9knBEaWw==
X-CSE-MsgGUID: gsB07j2xTf20A+ykczNmKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="227184504"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 17:46:53 -0700
Message-ID: <5d2c56a4-0e00-4bf9-aa60-3b367cb26c3f@linux.intel.com>
Date: Tue, 7 Apr 2026 08:46:50 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/7] Miscellaneous Intel uncore patches
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, Chun-Tse Shao <ctshao@google.com>,
 Markus Elfring <Markus.Elfring@web.de>
References: <20260403172146.158172-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260403172146.158172-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The whole patch-set looks good to me.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 4/4/2026 1:21 AM, Zide Chen wrote:
> I grouped these patches together for the convenience of the maintainers
> and bumped the whole series to V7.
>
> Changes since v6:
> - Drop patch v6 4/5: perf/x86/intel/uncore: Fix PMON enumeration with
>   NUMA disabled
>
> Changes since v5:
> - Split patch v5 3/4 into two patches for clearer scope.
> - Patch 2/5: Add changelog to clarify that it doesn't support die ID gaps.
> - Patch 3/5: Change title and changelog to reflect the reduced scope.
> - Patch 4/5: New patch. Remove redundant snbep_pci2phy_map_init() calls.
>
> Changes since v4:
> - Remove unused die_id variable from patch 3.
>
> V6:
> https://lore.kernel.org/lkml/20260330212444.117325-1-zide.chen@intel.com/
>
> Previous versions:
> https://lore.kernel.org/lkml/cda9ab9b-4581-409f-a9bb-0e8a67ad3530@web.de/T/
> https://lore.kernel.org/lkml/20260116031113.45098-1-zide.chen@intel.com/
> https://lore.kernel.org/lkml/20260206231203.11760-1-zide.chen@intel.com/
>
> Zide Chen (4):
>   perf/x86/intel/uncore: Fix iounmap() leak on global_init failure
>   perf/x86/intel/uncore: Skip discovery table for offline dies
>   perf/x86/intel/uncore: Do not treat -1 die_id as error during UBOX
>     scan
>   perf/x86/intel/uncore: Remove extra double quote mark
>
>  arch/x86/events/intel/uncore_discovery.c | 17 ++++---
>  arch/x86/events/intel/uncore_snbep.c     | 57 +++++++++++-------------
>  2 files changed, 37 insertions(+), 37 deletions(-)
>

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6536C351C2F;
	Wed,  3 Jun 2026 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454938; cv=none; b=o63TgGGKR+X3Mrr7E843O5bBcAsxBnbgnDBw9aQez65y5xmfWcZmqfHMCLlKFytayDoKsI0egQVfBMjHc77I02px/VYbECUfHDb5tSko4Sv/11DAgl12IAOBp0ZKv+5NxSdqd6XsoOjSFOswAJFHG/sOHfYapkM4gF7vHBygXu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454938; c=relaxed/simple;
	bh=pyRlZ8OmN6JugQqib/k3O6DaMzanH28nwu2WvE1yrnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/USGzOdoUUc42muNgbo6yAYUXoQsdC/FauQCOFW9QR5xn+v7z2zJIcoO42+j68qMMU7mReiHP4Sf6ERrT6aRK92fkqoXK6S3Ez/041y1x11/plQ2tOAS4q8Z69NbSsVtA9dv/qocjwNAw2OOOSYtnic30eg4TSrVy7l5KtjZ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9N8qvFm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9N8qvFm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780454938; x=1811990938;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pyRlZ8OmN6JugQqib/k3O6DaMzanH28nwu2WvE1yrnE=;
  b=m9N8qvFmPN8Y1L2+xRzVJyk0KTNx7BlT7N5XJsilsoWLTKsnXvQMqb09
   A2ou527F9HW8N7q5KbcoVztTM/S7JQZUzMeTVpSa5X+5XqAZokCHNF7Zb
   1djbJnrzfVZbg8uyMySQMW2WJHJjoh8tMAPy13o9vg95he5fV/jHqKfZe
   DWK5Rw/z/anRf83yG6VwTUi/dyFTe2gBBiqPq3XbrJ+eLdBJ09GL1HIaW
   97E9+Ut/ewW/IThkVNtABZRRkNakkjK7+9AYHiUkgAZGOkQxnA9us0C6h
   QnbmFR6p67l6HSYRmSc/jKPx1D9bK93HojJ06rZyAIseGdaIpUvmXZXy3
   A==;
X-CSE-ConnectionGUID: XCKdLu/MR1+mSfe14P6HhA==
X-CSE-MsgGUID: qBRM3FgWR1ewU3Z3yceYrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="84878864"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="84878864"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 19:48:57 -0700
X-CSE-ConnectionGUID: 4jqHX3BLRI6sNY9zVkCRJQ==
X-CSE-MsgGUID: qX6tqZNkRdmImdrfOgQBnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="245901116"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 19:48:54 -0700
Message-ID: <dcc6f3c2-0d0c-405c-b6ed-1e6bf7931625@linux.intel.com>
Date: Wed, 3 Jun 2026 10:48:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/7] perf/x86/intel/uncore: Bug fixes and cleanups
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260602144908.263680-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260602144908.263680-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All patches look good to me. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 6/2/2026 10:49 PM, Zide Chen wrote:
> This series includes bug fixes and cleanups for the Intel uncore PMU
> driver.
>
> - Patch 1 fixes a theoretical bug in discovery unit lookup on multi-die
>   systems.
> - Patch 2 guards against an invalid box control address.
> - Patch 3 fixes a PCI device refcount leak in UPI topology discovery.
> - Patch 4 works around a hardware issue on Raptor Cove CPUs.
> - Patches 5-7 implement a global MSR init callback for GNR/GRR/SRF/CWF
>   uncore.
>
> Changes in v3:
> - Protect uncore_discovery_pci() with cpus_read_lock(). (Sashiko)
> - Add Fixes tag for patch 4/7 and 7/7. 
> - Add the missing '---' in patch 5.
>
> Changes in v2:
> - Add patch 2 to guard against invalid box control address (Sashiko)
> - Remove WARN_ON_ONCE() from patch 1
> - Move cpus_read_{lock,unlock}() out of uncore_die_to_cpu() (Sashiko)
>
> Zide Chen (7):
>   perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems
>   perf/x86/intel/uncore: Guard against invalid box control address
>   perf/x86/intel/uncore: Fix PCI device refcount leak in UPI discovery
>   perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()
>   perf/x86/intel/uncore: Move die_to_cpu() to uncore.c
>   perf/x86/intel/uncore: Fix uncore_die_to_cpu() for offline dies
>   perf/x86/intel/uncore: Implement global init callback for GNR uncore
>
>  arch/x86/events/intel/uncore.c           | 32 ++++++++++++++++-
>  arch/x86/events/intel/uncore.h           |  3 +-
>  arch/x86/events/intel/uncore_discovery.c | 46 ++++++++++++++++--------
>  arch/x86/events/intel/uncore_snb.c       |  7 ----
>  arch/x86/events/intel/uncore_snbep.c     | 36 +++++++------------
>  5 files changed, 76 insertions(+), 48 deletions(-)
>

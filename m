Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73A48CFC;
	Wed, 27 May 2026 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859055; cv=none; b=ABG0LktqhG5MvwOh7AmGoYrPrqnd7Km7LEihyrTR4aXKX+5bcRwQ02Muu0FF/2LMwMoAglggzp+JsUL0eQXsSJXyoYcbfV0JfHjJI+nIDpxFUdIS0mB1HKrfpLxd9vlxmE5cx7ltxYobJBc6XpYtajIa/V8Sl9CUtAazdXJrJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859055; c=relaxed/simple;
	bh=JqnWVoffGGyD09Jxe6YkAqJSDjyKJcvh/iHSY+5Uv7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlWVFLnwiIX/Lc/FgL1YUgnDnwUUF7H6Se0LqBitVUT1yT5Cb5BU7LskeOnJXCShUIjArD9ry26NmENVy2QtbPVEO64JiuzLUQiLJzT4g330G7KuLuMVRXtpV1I9THZC/th6QJQ1bl3pIhU/q8jPlro/DHvC4BTgtI0aZZJJZ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzJpA6Bu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzJpA6Bu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779859054; x=1811395054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JqnWVoffGGyD09Jxe6YkAqJSDjyKJcvh/iHSY+5Uv7s=;
  b=SzJpA6BuA3IKaOlDpY1rZFSX5qo/33/80GrS5MdoZkP4fjjiDngxfpqW
   KHDBFZdpOnnCskjBn9ORrDLkTWud/j/Jrvi/Ipl0JZJo/znfweL72fVr2
   KhwEHxzTyxmnnRBduqvaCpd8jsePK/Ylu4tyULtKYY7kz3X9waBiyI5fu
   kVHWRkXMplKQCNBf/thDqjMg0XMow7VvmP/qAzKYbPM/elOy1z/y5twP5
   oyEb4n/Ln5d18sQwgtC9Q5+TQuEZIBtAfVs3v8U2puipKbSGf/6BV8ljo
   0bGsZ276KVhJHFXRtYUSj39fDFnldRmqVyJcsg+nnSlA4fXGcks9RFjYd
   g==;
X-CSE-ConnectionGUID: a2gnPPzARAe7kI/cEGZT5Q==
X-CSE-MsgGUID: vBQdL5//TI2ZENXbMeZsQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="103355677"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="103355677"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 22:17:33 -0700
X-CSE-ConnectionGUID: XfzJbBRzQnC20YlMlA4daQ==
X-CSE-MsgGUID: 8L6KT0pMQkySkvP/32lhLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="239123905"
Received: from unknown (HELO [10.238.3.232]) ([10.238.3.232])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 22:17:30 -0700
Message-ID: <22cb9525-3cdd-4962-bc98-d9e905f195ab@linux.intel.com>
Date: Wed, 27 May 2026 13:17:28 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/7] perf/x86/intel/uncore: Bug fixes and cleanups
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260526211846.121640-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260526211846.121640-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Seems only cover letter is here. Where are the patches?

On 5/27/2026 5:18 AM, Zide Chen wrote:
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
>  arch/x86/events/intel/uncore.c           | 32 ++++++++++++++++++-
>  arch/x86/events/intel/uncore.h           |  3 +-
>  arch/x86/events/intel/uncore_discovery.c | 40 +++++++++++++++++-------
>  arch/x86/events/intel/uncore_snb.c       |  7 -----
>  arch/x86/events/intel/uncore_snbep.c     | 36 +++++++--------------
>  5 files changed, 74 insertions(+), 44 deletions(-)
>

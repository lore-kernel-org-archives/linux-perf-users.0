Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AF234964;
	Sun,  4 Jan 2026 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767494222; cv=none; b=Pp3OFObr4tc814zsk1j3fzSMpyU49sfkKSLScqzOY23C0/QSipbQPiGNbUylCyeKE6w8B6s4glX5o4WhyMeLCJFk5qUmr00xJg6LX/sWeEp8QY6j9eoEubrkyptg+QWwrRdZkXIPpUPyJuZNrqBq+H1y5S1Cts7MyXlUY0UmZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767494222; c=relaxed/simple;
	bh=cyvzgOpfFcrZzVGgUDD6mbjXvxLRWJy2FzaDvjtVdsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivLq8rP2nGJ6Qje5j/X16DU8rPskH/9bbkvwPIJNNTQiZTgbWAU6gbvbWZnQPQSx4sBc/sPkLQ4tHR8ok3NM3sGg4mZBBh1YOb+lAC2G6S38GpmH4ESDoQFZoJal28sGannNETKAhQSOxU97odPXyI52QflWFVTN28qyIz1/gXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmZN/1fB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmZN/1fB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767494220; x=1799030220;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cyvzgOpfFcrZzVGgUDD6mbjXvxLRWJy2FzaDvjtVdsc=;
  b=UmZN/1fByCr1P0nji1coFRiLlO2/M0uPc1twvQxQSOgGtGc+S2WeFRn3
   NCBVHUPLrXzEUnnvcFNZzZTgAS5Ud/pSw5y9XV9djd56T+l6ob+Bu3zxq
   2Zne67z+Asj6oQE3acdJlOEkWWulyrrmPD0CtSTYTB48rn7OYeysR+BvM
   DdNPHZqZJCZ1lmJ6zUoIQqDOOaECof4xaeSCSdieal0hHDyOrgpUBMIxe
   viWy8w83FDzD17Kh6Dq1smb+h5v8M6KDZ9fxL0xVKBzDjjm3yTou8i4pR
   eyyG2K2pd7t41ljw2SdzstCLNiTzV5f0Sib57gsCQTQSVblLxpNrH8tup
   g==;
X-CSE-ConnectionGUID: P3uijYSoThGcJPEVln21ug==
X-CSE-MsgGUID: TRsxrwYOQX2k9VHer9+JOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="72543812"
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="72543812"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:36:59 -0800
X-CSE-ConnectionGUID: Yhlbz/gRR3SMAXWtT/xDKA==
X-CSE-MsgGUID: oYlR4+rWQ3C+OgmC2+1Saw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="201969811"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:36:56 -0800
Message-ID: <ec3ac8c3-d400-4357-95e0-db70411413b2@linux.intel.com>
Date: Sun, 4 Jan 2026 10:36:53 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 09/13] perf/x86/intel/uncore: Support uncore constraint
 ranges
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
 <20251231224233.113839-10-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251231224233.113839-10-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/1/2026 6:42 AM, Zide Chen wrote:
> Add UNCORE_EVENT_CONSTRAINT_RANGE macro for uncore constraints,
> similar to INTEL_EVENT_CONSTRAINT_RANGE, to reduce duplication when
> defining consecutive uncore event constraints.
>
> No functional change intended.
>
> Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2: new patch
>
>  arch/x86/events/intel/uncore.c       |   2 +-
>  arch/x86/events/intel/uncore.h       |   2 +
>  arch/x86/events/intel/uncore_snbep.c | 183 ++++++---------------------
>  3 files changed, 44 insertions(+), 143 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 080b6870a88d..54b3c1e3af32 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -436,7 +436,7 @@ uncore_get_event_constraint(struct intel_uncore_box *box, struct perf_event *eve
>  
>  	if (type->constraints) {
>  		for_each_event_constraint(c, type->constraints) {
> -			if ((event->hw.config & c->cmask) == c->code)
> +			if (constraint_match(c, event->hw.config))
>  				return c;
>  		}
>  	}
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index 55e3aebf4b5e..564cb26c4468 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -33,6 +33,8 @@
>  #define UNCORE_EXTRA_PCI_DEV_MAX	4
>  
>  #define UNCORE_EVENT_CONSTRAINT(c, n) EVENT_CONSTRAINT(c, n, 0xff)
> +#define UNCORE_EVENT_CONSTRAINT_RANGE(c, e, n)			\
> +		EVENT_CONSTRAINT_RANGE(c, e, n, 0xff)
>  
>  #define UNCORE_IGNORE_END		-1
>  
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 28bcccf5cdfe..fac2be780276 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -836,76 +836,37 @@ static struct intel_uncore_ops snbep_uncore_pci_ops = {
>  static struct event_constraint snbep_uncore_cbox_constraints[] = {
>  	UNCORE_EVENT_CONSTRAINT(0x01, 0x1),
>  	UNCORE_EVENT_CONSTRAINT(0x02, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x04, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x05, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x04, 0x5, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x07, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x09, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x11, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x12, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x13, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x1b, 0xc),
> -	UNCORE_EVENT_CONSTRAINT(0x1c, 0xc),
> -	UNCORE_EVENT_CONSTRAINT(0x1d, 0xc),
> -	UNCORE_EVENT_CONSTRAINT(0x1e, 0xc),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x12, 0x13, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x1b, 0x1e, 0xc),
>  	UNCORE_EVENT_CONSTRAINT(0x1f, 0xe),
>  	UNCORE_EVENT_CONSTRAINT(0x21, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x31, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x35, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x31, 0x35, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x36, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x37, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x38, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x39, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x37, 0x39, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x3b, 0x1),
>  	EVENT_CONSTRAINT_END
>  };
>  
>  static struct event_constraint snbep_uncore_r2pcie_constraints[] = {
> -	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x11, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x12, 0x1),
>  	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x24, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x25, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x24, 0x26, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x32, 0x34, 0x3),
>  	EVENT_CONSTRAINT_END
>  };
>  
>  static struct event_constraint snbep_uncore_r3qpi_constraints[] = {
> -	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x12, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x12, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x13, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x20, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x21, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x22, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x24, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x25, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x29, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2a, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2b, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2e, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2f, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x30, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x31, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x36, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x37, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x38, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x39, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x20, 0x26, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x28, 0x34, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x36, 0x39, 0x3),
>  	EVENT_CONSTRAINT_END
>  };
>  
> @@ -3034,24 +2995,15 @@ static struct intel_uncore_type hswep_uncore_qpi = {
>  };
>  
>  static struct event_constraint hswep_uncore_r2pcie_constraints[] = {
> -	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x11, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x13, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x23, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x24, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x25, 0x1),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x23, 0x25, 0x1),
>  	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x27, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x29, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x28, 0x29, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x2a, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x2b, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x35, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x2b, 0x2d, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x32, 0x35, 0x3),
>  	EVENT_CONSTRAINT_END
>  };
>  
> @@ -3066,38 +3018,17 @@ static struct intel_uncore_type hswep_uncore_r2pcie = {
>  
>  static struct event_constraint hswep_uncore_r3qpi_constraints[] = {
>  	UNCORE_EVENT_CONSTRAINT(0x01, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x07, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x08, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x09, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x0a, 0x7),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x7, 0x0a, 0x7),
>  	UNCORE_EVENT_CONSTRAINT(0x0e, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x12, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x12, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x13, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x14, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x15, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x1f, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x20, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x21, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x22, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x25, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x29, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2e, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2f, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x31, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x36, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x37, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x38, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x39, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x14, 0x15, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x1f, 0x23, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x25, 0x26, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x28, 0x29, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x2c, 0x2f, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x31, 0x34, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x36, 0x39, 0x3),
>  	EVENT_CONSTRAINT_END
>  };
>  
> @@ -3371,8 +3302,7 @@ static struct event_constraint bdx_uncore_r2pcie_constraints[] = {
>  	UNCORE_EVENT_CONSTRAINT(0x25, 0x1),
>  	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x2c, 0x2d, 0x3),
>  	EVENT_CONSTRAINT_END
>  };
>  
> @@ -3387,35 +3317,18 @@ static struct intel_uncore_type bdx_uncore_r2pcie = {
>  
>  static struct event_constraint bdx_uncore_r3qpi_constraints[] = {
>  	UNCORE_EVENT_CONSTRAINT(0x01, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x07, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x08, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x09, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x0a, 0x7),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x07, 0x0a, 0x7),
>  	UNCORE_EVENT_CONSTRAINT(0x0e, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x11, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x13, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x14, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x15, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x1f, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x20, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x21, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x22, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x14, 0x15, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x1f, 0x23, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x25, 0x3),
>  	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x29, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2e, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x2f, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x36, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x37, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x38, 0x3),
> -	UNCORE_EVENT_CONSTRAINT(0x39, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x28, 0x29, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x2c, 0x2f, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x33, 0x34, 0x3),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x36, 0x39, 0x3),
>  	EVENT_CONSTRAINT_END
>  };
>  
> @@ -3722,8 +3635,7 @@ static struct event_constraint skx_uncore_iio_constraints[] = {
>  	UNCORE_EVENT_CONSTRAINT(0x95, 0xc),
>  	UNCORE_EVENT_CONSTRAINT(0xc0, 0xc),
>  	UNCORE_EVENT_CONSTRAINT(0xc5, 0xc),
> -	UNCORE_EVENT_CONSTRAINT(0xd4, 0xc),
> -	UNCORE_EVENT_CONSTRAINT(0xd5, 0xc),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0xd4, 0xd5, 0xc),
>  	EVENT_CONSTRAINT_END
>  };
>  
> @@ -4479,14 +4391,9 @@ static struct intel_uncore_type skx_uncore_m2pcie = {
>  };
>  
>  static struct event_constraint skx_uncore_m3upi_constraints[] = {
> -	UNCORE_EVENT_CONSTRAINT(0x1d, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x1e, 0x1),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x1d, 0x1e, 0x1),
>  	UNCORE_EVENT_CONSTRAINT(0x40, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x4e, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x4f, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x50, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x51, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x52, 0x7),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x4e, 0x52, 0x7),
>  	EVENT_CONSTRAINT_END
>  };
>  
> @@ -5652,14 +5559,9 @@ static struct intel_uncore_type icx_uncore_upi = {
>  };
>  
>  static struct event_constraint icx_uncore_m3upi_constraints[] = {
> -	UNCORE_EVENT_CONSTRAINT(0x1c, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x1d, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x1e, 0x1),
> -	UNCORE_EVENT_CONSTRAINT(0x1f, 0x1),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x1c, 0x1f, 0x1),
>  	UNCORE_EVENT_CONSTRAINT(0x40, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x4e, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x4f, 0x7),
> -	UNCORE_EVENT_CONSTRAINT(0x50, 0x7),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x4e, 0x50, 0x7),
>  	EVENT_CONSTRAINT_END
>  };
>  
> @@ -6142,10 +6044,7 @@ static struct intel_uncore_ops spr_uncore_mmio_offs8_ops = {
>  static struct event_constraint spr_uncore_cxlcm_constraints[] = {
>  	UNCORE_EVENT_CONSTRAINT(0x02, 0x0f),
>  	UNCORE_EVENT_CONSTRAINT(0x05, 0x0f),
> -	UNCORE_EVENT_CONSTRAINT(0x40, 0xf0),
> -	UNCORE_EVENT_CONSTRAINT(0x41, 0xf0),
> -	UNCORE_EVENT_CONSTRAINT(0x42, 0xf0),
> -	UNCORE_EVENT_CONSTRAINT(0x43, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x40, 0x43, 0xf0),
>  	UNCORE_EVENT_CONSTRAINT(0x4b, 0xf0),
>  	UNCORE_EVENT_CONSTRAINT(0x52, 0xf0),
>  	EVENT_CONSTRAINT_END

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



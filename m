Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7221DF26E;
	Mon, 19 Jan 2026 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768783698; cv=none; b=rJCPhoj+9UFwCPLG+Q/Bz8pcZLbZTWaLQKB7hmzuAUyE9mAYnTCyiYXJVSLVrnZEoKHtJcY777PYtP6dbZjv4+gN2L+QI7mQ8MQE9yJZ1OdsrHgcYG9ectb+rgDg4P8e7zuMYNdGOn6nGfkH8NUU6I7ulObjNl/Ev+DVoAF1hNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768783698; c=relaxed/simple;
	bh=WvZ8znrgX89gTGv89HISVFTL7PnPzo6bt2j5QX1FfTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJ40K8FG98pWfjGdARpFO4DKJcJEt2EmSPXgN6NvRNwRFRTASnldDlVtZrlBz7YcwXFidUapw5ucaLavAy6QQ7Yk6y8A9jNXRgUl/dKNmCv9vXYWxPdu5ljdYkfFh/CNvxdEh2Um3LRcsmp7ckIKgKtOeS6OnrM8f3ydvQkh95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amCVgV78; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amCVgV78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768783696; x=1800319696;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WvZ8znrgX89gTGv89HISVFTL7PnPzo6bt2j5QX1FfTE=;
  b=amCVgV78yNEqePRP15IkgGMEnPgKePc92/c8NBPhCIC21+70qXN9YJeI
   J1dSZacpR5POumIk0UKILV9F1/u1Q/DHj+/TUFJ+IfHmENRvmNIre0GNf
   KafoD0VFtrwJWNkh/CKZUh6l58Tc99Se5LEC0QE4oPLBQswFvILvoR1OL
   /C4ctRzEhrfnzGld/FAV+6CYVJT7sRtn//7tWmc4E8tdCSpmyqF1QcFZ4
   ADvtPU6ZwrIkdJeeg8g5j8uWBMEoTnQ/nKE/IS/9/9vlxjUFFg9W3VVrR
   eiY0vG2tUyaGYItd0hGpl7kVjHIli/xK5MYDcHqtDRSekSpXoR3NW3sN4
   g==;
X-CSE-ConnectionGUID: AIVO2FdGRKG/OJ076Tdzqg==
X-CSE-MsgGUID: 55jrSpI+QyO2Gzkg7zLF2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="73845934"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="73845934"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 16:48:15 -0800
X-CSE-ConnectionGUID: +o3Wxz0wRjaZR7RX+RId5Q==
X-CSE-MsgGUID: K+FBh/t/SiizZc2R7qAgmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="205524785"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 16:48:11 -0800
Message-ID: <b09f882b-fa14-4ccb-aee5-7024747af83c@linux.intel.com>
Date: Mon, 19 Jan 2026 08:48:08 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf/x86/intel/uncore: Fix iounmap() leak on
 global_init failure
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Markus Elfring <Markus.Elfring@web.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 kernel test robot <lkp@intel.com>
References: <20260114193825.17973-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260114193825.17973-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/15/2026 3:38 AM, Zide Chen wrote:
> Kernel test robot reported:
>
> Unverified Error/Warning (likely false positive, kindly check if
> interested):
>     arch/x86/events/intel/uncore_discovery.c:293:2-8:
>     ERROR: missing iounmap; ioremap on line 288 and execution via
>     conditional on line 292
>
> If domain->global_init() fails in __parse_discovery_table(), the
> ioremap'ed MMIO region is not released before returning, resulting
> in an MMIO mapping leak.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: b575fc0e3357 ("perf/x86/intel/uncore: Add domain global init callback")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore_discovery.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index 0e414cecb6f2..efd1fc99a908 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -264,6 +264,7 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>  	struct uncore_unit_discovery unit;
>  	void __iomem *io_addr;
>  	unsigned long size;
> +	int ret = 0;
>  	int i;
>  
>  	size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
> @@ -273,21 +274,23 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>  
>  	/* Read Global Discovery State */
>  	memcpy_fromio(&global, io_addr, sizeof(struct uncore_global_discovery));
> +	iounmap(io_addr);
> +
>  	if (uncore_discovery_invalid_unit(global)) {
>  		pr_info("Invalid Global Discovery State: 0x%llx 0x%llx 0x%llx\n",
>  			global.table1, global.ctl, global.table3);
> -		iounmap(io_addr);
>  		return -EINVAL;
>  	}
> -	iounmap(io_addr);
>  
>  	size = (1 + global.max_units) * global.stride * 8;
>  	io_addr = ioremap(addr, size);
>  	if (!io_addr)
>  		return -ENOMEM;
>  
> -	if (domain->global_init && domain->global_init(global.ctl))
> -		return -ENODEV;
> +	if (domain->global_init && domain->global_init(global.ctl)) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
>  
>  	/* Parsing Unit Discovery State */
>  	for (i = 0; i < global.max_units; i++) {
> @@ -307,8 +310,10 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>  	}
>  
>  	*parsed = true;
> +
> +out:
>  	iounmap(io_addr);
> -	return 0;
> +	return ret;
>  }
>  
>  static int parse_discovery_table(struct uncore_discovery_domain *domain,

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>




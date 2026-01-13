Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C91509AB;
	Tue, 13 Jan 2026 00:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768265313; cv=none; b=bm7UDHFa7ve/UP26ngULDm20aAgEMwSicCxahc+RXP6qI47Uqv6SXTA7OlmOFRf5vhiM+6QjT5X6oLm3/hiuiHPdynkp985cVUOamVBG4+1Y9AHgFemx/YRONrr7xwMEKYDYZB5bqg0SwtyD5HU0yyG17LnNB3Vyrtz5v6Tj6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768265313; c=relaxed/simple;
	bh=r7FEULhh1ukAy3TvOmnKK1EknsD7ohNc/8EmBCr6IH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yf8kPDTEicfnIMpH35qzr0ctIeriXGw8Pa4WR48pWzxBmx9Lvb6YChWtPVUwM/ri4PknN0a+wuaQdJ3CjoPd+2r5KuyrIrFwGNVZdKtAPToZeW0gX2QSaGofTg5GMOOWO3OB6GfP41tsDEtpO8xj/T/JWHLWpVLa3jquh9qJ8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxQl1ROf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxQl1ROf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768265312; x=1799801312;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r7FEULhh1ukAy3TvOmnKK1EknsD7ohNc/8EmBCr6IH0=;
  b=MxQl1ROfltyXx36pzz9CPG61yHDDbAwcHDoWwEodgx+oOkfWjvDY6jox
   vDZ/pRJNOxtOWSfOFqeSnUnVXJ8hdPBKeAVV4xzrydHQr9LPVw15JOghL
   FXS9MkxDxapOETFi0izyBAmiyyCO+UVSnsblcLTRkfBTfAYCvpEOqB2iW
   wSyr0XevlTATcPtV3t4gr/MX1FeMOM3m8qGSRLCh+apmnKeBY+1oS36nb
   rTeqw/sR0P8dUZlGbXWklBeZgYymNdXSRds8WqMpGOOCF993x7YfdTt+1
   h3OnZ4uW0Jlvhf7ukmb5OFkxb1El3wai8vpo1aICS2MIOSuOk5XH9ozEY
   w==;
X-CSE-ConnectionGUID: IeLda7g3T3+MxkYyIHzAhw==
X-CSE-MsgGUID: xYyeUSCvR/quqwGi/cMPYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69458905"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69458905"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 16:48:31 -0800
X-CSE-ConnectionGUID: HZhSmPFoSVCt4rr2jdfDOQ==
X-CSE-MsgGUID: ai/8sIHcRGuwKLHz18zpxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204047496"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 16:48:27 -0800
Message-ID: <3d49f7a2-bbc0-4ec2-8024-45a01aba0c95@linux.intel.com>
Date: Tue, 13 Jan 2026 08:48:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix iounmap() leak on global_init
 failure
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 kernel test robot <lkp@intel.com>
References: <20260113002539.408943-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260113002539.408943-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/13/2026 8:25 AM, Zide Chen wrote:
> If domain->global_init() fails in __parse_discovery_table(), the
> mapped MMIO region is not released before returning, resulting in
> an iounmap() leak.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: b575fc0e3357 ("perf/x86/intel/uncore: Add domain global init callback")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore_discovery.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index 0e414cecb6f2..f64661ad56b2 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -286,8 +286,10 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>  	if (!io_addr)
>  		return -ENOMEM;
>  
> -	if (domain->global_init && domain->global_init(global.ctl))
> +	if (domain->global_init && domain->global_init(global.ctl)) {
> +		iounmap(io_addr);
>  		return -ENODEV;
> +	}
>  
>  	/* Parsing Unit Discovery State */
>  	for (i = 0; i < global.max_units; i++) {

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



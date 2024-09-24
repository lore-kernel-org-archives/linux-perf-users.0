Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834781EEF9;
	Tue, 24 Sep 2024 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185867; cv=none; b=WhSkcLLQkwIGa9rnUh3AAm+JWsGJINUDh5G26O4luaY8oyfKN8t+IthAyVUKVveVePvLLQ4xGBJQ0p0/x9dW1fl7tbMERU0VraFXuhlP/H+Gj3hM2eRuQYEMFAGDIBucNHVjuEo4QifmI2FTSU6ki6brY1UFVd2eJzFDZ4Mmwho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185867; c=relaxed/simple;
	bh=BbVN8rQgOMlXyrzQZgmaR26p8GbGnfgzzWiaex2l7EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwnCo65PFIP+wxQZsAkPz0bxeqpZ2Ut08G8PCGWMp9iGYtcfNkZYpJ8LqGdXmLSIyb7vRwogwGL8fg9QcNjoLN5DI6hy9eq5AAYtI97v+WDKWa2xnjfhl9Z0cRoNItNfYCWPl+FGDidlYdDLdt8t+xi1nr7ILK2cXgVEfiy+H84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfM9I2ot; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfM9I2ot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727185866; x=1758721866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BbVN8rQgOMlXyrzQZgmaR26p8GbGnfgzzWiaex2l7EI=;
  b=CfM9I2otsboyV2Fb5V0xx1x6tu3NmNQmSPi6GXUmq2J2+D9Fhw7hlSrn
   VlYJMUIvZQ9u1E6dm++2AodpdplU+4VWH51c7t9M2BXV6xEmSPg44WavN
   f2NtNWnU6hR7c+i/CLUDvBZNnf/qHFAb3E/R306ifTMGCr3Fpoi6f/ISS
   97n3ZLhFpUnXVpd8x/uLbtnBd6wJ1Mdsge3ujLwO8GU05OfxKy4j3CIk8
   0zFuI/N/zvZVjHCan0ulmbzzJ99l0cBvONDaDzA2tt7i8U8rhfL49RdBS
   xelMr4sSibBbZIHLernC4b7u9BrwzYaDgm5cFcwfX4bIlLzQKdCbYcj50
   Q==;
X-CSE-ConnectionGUID: S1MZJLgvQBqyGdswELa0fw==
X-CSE-MsgGUID: b94PNUKhTBqqQhVzBXbMQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="25999334"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="25999334"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 06:51:05 -0700
X-CSE-ConnectionGUID: ffx8M899Rt2GwK/sFxC51g==
X-CSE-MsgGUID: 726Ow3IvT+i5x3txCUe+Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="71753888"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 06:51:05 -0700
Received: from [10.212.70.53] (kliang2-mobl1.ccr.corp.intel.com [10.212.70.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7855420CFEEC;
	Tue, 24 Sep 2024 06:51:02 -0700 (PDT)
Message-ID: <73e999cd-93c3-49e0-bac2-0e2c6efe4110@linux.intel.com>
Date: Tue, 24 Sep 2024 09:51:01 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Enable uncore on vCPUs when using
 uncore discovery
To: =?UTF-8?B?6ZmI5Z+56bi/KOS5mOm4vyk=?= <chenpeihong.cph@alibaba-inc.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users <linux-perf-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?B?6YOR57+UKOato+e/lCk=?= <zx283061@alibaba-inc.com>,
 =?UTF-8?B?6LW155Sf6b6Z?= <shenglong.zsl@alibaba-inc.com>
References: <d420bcf0-5651-41f7-81c9-1c8155bd6bcc.chenpeihong.cph@alibaba-inc.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <d420bcf0-5651-41f7-81c9-1c8155bd6bcc.chenpeihong.cph@alibaba-inc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-09-23 10:47 p.m., 陈培鸿(乘鸿) wrote:
> With uncore discovery, kvm can choose to expose a subset of
> uncore related MSRs it wants to guest by emulate the uncore
> discovery device. 

I don't hear that the KVM has started to support uncore vPMU.
Can you please point me to patches?

The default of uncore_no_discover is 0. So it bypasses the HYPERVISOR
check unless the user specially sets the value. It could be a problem
for the earlier platforms which don't support discovery
table. How do you plan to emulate the devices on earlier platforms?

Thanks,
Kan
> So we can enable uncore on virtualized CPUs
> when uncore discovery is using.
> Signed-off-by: Cheng Hong <chenpeihong.cph@alibaba-inc.com>
> ---
>  arch/x86/events/intel/uncore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index d98fac567684..33776df95aa4 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1920,7 +1920,7 @@ static int __init intel_uncore_init(void)
>  struct intel_uncore_init_fun *uncore_init;
>  int pret = 0, cret = 0, mret = 0, ret;
> - if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> + if (uncore_no_discover && boot_cpu_has(X86_FEATURE_HYPERVISOR))
>  return -ENODEV;
>  __uncore_max_dies =

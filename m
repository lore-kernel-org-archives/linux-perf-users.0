Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BDA1429D;
	Wed,  3 Jun 2026 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449895; cv=none; b=ecmw+aEItulWaXOMcHuJexk0x28retN+qT3ovvwKWhpZ/a8CaClYGpfbo39bY8xQWVCBUW+eQRn7UwVpuGSBUVxfESFZW1JoRuvueO3dxUQHx8qPg/va6oYmy/1waFw1cvYntwcC9/ZrgcNv/czVSptK6VL3GhaXCP3YDNwhCWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449895; c=relaxed/simple;
	bh=8F1T65cLdbeXrWi87mlHgL2C8GvLeiSB7U3YRRKMwjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ke1YZkOLfsBWzkPpyL7NMgfSZ0ngqfP54ES/JTvjD5xfkgmN4Jp6bDZmdHFH+9/u0BZIo6CwS5tyEO3x27MA0SMdBedBelSdfmwK3qKHatzuJuGeJv/XXJEpoc/T+GkohiI2uSNaxYnCjsGUvElvXKBd9oSKN5zaoAbDGlSBUWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqmvX3uQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqmvX3uQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780449894; x=1811985894;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8F1T65cLdbeXrWi87mlHgL2C8GvLeiSB7U3YRRKMwjA=;
  b=hqmvX3uQlowxm7xFcQRU4l9tXUUuoVL2RIwj0uuT3sI/zkbNmoG2q3qO
   kdlvdp8Sdzn3/R6ofM7rqC5HmjX+kCopGkWiklcwnUWGcPXOELC8qCbi9
   D8qEj0pzPfEzbe3bAipS4WL3k1wc0FsivxxCcBcFrMr+kZBoBQobu9Cta
   +3y6Mszq5Bk1bK4/7BoIjvoTviTmmrw+LIlQL2i7kbCfDa5/vZ8m8tBFe
   RGKnIkCsJLoaqZYjLDW01aGWZsRamM7szUiI36JaV61MsnEcI97jF7F2b
   xavFpzjXxpG/bWjicxHvoEZ3sXAvjOgkhcJtbcCEQQxlKH/RdkJrzaUUA
   A==;
X-CSE-ConnectionGUID: /oZMfX8MQS2fm3MkI5OdZQ==
X-CSE-MsgGUID: kVl63NI3SQKolXtvaFMrAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80278308"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="80278308"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:24:53 -0700
X-CSE-ConnectionGUID: R2KZA1xBRkil5C8EYSk1SA==
X-CSE-MsgGUID: GU5sfojQSG6jyn0ObI7fFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="282183143"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:24:51 -0700
Message-ID: <1c276350-5491-4623-93ab-def77894dbd8@linux.intel.com>
Date: Wed, 3 Jun 2026 09:24:47 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/8] perf/x86/intel/uncore: Keep PCI PMUs working when
 MMIO/MSR setup fails
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260601170114.173359-1-zide.chen@intel.com>
 <20260601170114.173359-5-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260601170114.173359-5-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 6/2/2026 1:01 AM, Zide Chen wrote:
> uncore_event_cpu_online() returns -ENOMEM early when both the MSR and
> MMIO box allocations fail.  This also aborts PCI uncore setup, even
> though PCI PMUs are independent of the MSR/MMIO paths.
>
> Remove the early return so PCI uncore setup always runs regardless
> of whether MSR or MMIO box allocation succeeds.
>
> Fixes: 3da04b8a00dd ("perf/x86/intel/uncore: Support MMIO type uncore blocks")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index d759888476c3..6df44f69cc5b 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1633,8 +1633,6 @@ static int uncore_event_cpu_online(unsigned int cpu)
>  	die = topology_logical_die_id(cpu);
>  	msr_ret = uncore_box_ref(uncore_msr_uncores, die, cpu);
>  	mmio_ret = uncore_box_ref(uncore_mmio_uncores, die, cpu);
> -	if (msr_ret && mmio_ret)
> -		return -ENOMEM;
>  
>  	/*
>  	 * Check if there is an online cpu in the package

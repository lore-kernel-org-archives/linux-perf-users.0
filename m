Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C021B9D2;
	Thu,  8 Jan 2026 05:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767848759; cv=none; b=lHlSbTLFPHD0bJrPTcI3EH9nChANlMkhDIRKVt8KOpO7hEDNlrMHx5QytjPtDHG73gbtP3s47clyvxPAObN2jWBe8ArtmBf2FVWoNnsMpVK+/PPXK72771r/qEhwg2HbdbHDX6ClaUdGrGLCPTKa73Q38tvTUwQLm4fJF7/7vSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767848759; c=relaxed/simple;
	bh=4GFUI3wC4iHSfDYMpDNAvtAxGEw0EQcxj4VQigWEtws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBj1UYiRbHr+jeWkhHfcF0xbIBPyC/0s3XaagKyAL3JrjKv6UCY9cCAatkMvJoyNSZhXxq10Fq1rFuIhFj11XY6lHmJd0PdRDgdkF4uqC+9zmE0sYIo6+NM3uXT/+jJ/jj6EJM4j8ZalON9hJwDtSWrR/8R/B3L6CyLK49lgIKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDZcnX+3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDZcnX+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767848757; x=1799384757;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4GFUI3wC4iHSfDYMpDNAvtAxGEw0EQcxj4VQigWEtws=;
  b=kDZcnX+36hUIUAJJ4cn0Hy6Gza3/BTOaH4uu7Kpz5GskbUwcTZZ3ZXZ1
   8fHv3PemmiITjmOB/cUI0UaavvCRjwNUVerp/S9oz4IqrjtoNHJtkkZVG
   OOnMesJa4WK32qt5HqmYg3gsLVEengp3uPdHbWa9YWr+MMFdX5XgTsUz7
   f+8wNHF2fHHWwYmDnvcwwvBZghSmKW+yhgK0+bfkWbt129ZKR/hNsfzYi
   +JurPnY3Z+ejR4ZczzdGm9KAcY+1edAsy60aLWm33RMzFgqFjsj8bTwok
   s86/mpVtWLkAbqNBqDs2gjiIvV7VXG3MJOkWkQgeGlyGybRI1GzeotqRq
   A==;
X-CSE-ConnectionGUID: pQ0RD/bXRLWyiMg+LkYNzQ==
X-CSE-MsgGUID: vhpwzU9MRkOj74G5sHQ/zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69136734"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69136734"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 21:05:57 -0800
X-CSE-ConnectionGUID: 2xbhUn+QRCeBszwUc7N47A==
X-CSE-MsgGUID: nKclU3J0SnWdfiM0Nsuj3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="208177514"
Received: from unknown (HELO [10.238.3.120]) ([10.238.3.120])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 21:05:53 -0800
Message-ID: <4df4fe60-7627-4d1d-bd6f-fc7865d19615@linux.intel.com>
Date: Thu, 8 Jan 2026 13:05:50 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/core: Remove duplicate include
To: Chen Ni <nichen@iscas.ac.cn>, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260107082159.2150934-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260107082159.2150934-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/7/2026 4:21 PM, Chen Ni wrote:
> Remove duplicate inclusion of linux/kvm_types.h.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  arch/x86/events/core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 0ecac9495d74..c182a47f0f38 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -30,7 +30,6 @@
>  #include <linux/device.h>
>  #include <linux/nospec.h>
>  #include <linux/static_call.h>
> -#include <linux/kvm_types.h>
>  
>  #include <asm/apic.h>
>  #include <asm/stacktrace.h>

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



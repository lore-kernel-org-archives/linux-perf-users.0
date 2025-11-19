Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B710832D0F5;
	Wed, 19 Nov 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547911; cv=none; b=EpCtCS/hBQCGt+J3YsLpDPqNT65FWBrK+UlDBWgrS86Acs+w/eOesM9Dr9jnQphUQwiU+SI5Msx1ds37jfh4DjoZbpTqZS+AzJ8niQezgAcn3aMcDl8/Gql0zNq7itx6kncJwDzlnKwegDLTV+0YOBlyT14ocNdc5n2Rbv2e03k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547911; c=relaxed/simple;
	bh=f9+sbam+nL4q1ilhv6pPblZGRElogRxPlGCyzKUZL+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJOOU92bMswXQ0/s618cBaPpqhIHRL4XnJbGDxqtI/iH+GvdmW366VqMSUZxuM4sEc32H6BQBRWlcrFkk+nnxOD1CLqLLNffwreaWe4wnka2uo+snWyGOEXTX2HrRpjlfF+z7aqYj33PYihUjGwZUkpuhQUH2zxAOeOxN4jX1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJfJaLU7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJfJaLU7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763547909; x=1795083909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f9+sbam+nL4q1ilhv6pPblZGRElogRxPlGCyzKUZL+Y=;
  b=EJfJaLU78JMGanUqkmHJncq3tEq3VCEQK3fnQ3/+8jjgfxzaDR09zJpY
   1CJgpcKz4NCv7JQ+cyeUVMPe4Kl1M2UyGfq2F7vJpY9+Rp4ZbuFsV7+cV
   e6wq1/VSit+1HGNcFJkG/WRwPZtSBE7bMn4LWkSWM+jebw62oDyGYdpYY
   wJKA3eWKEstp3zbKptTzoa6IU/hS7UG0cVZYV4DCdIpQc7VtXy3U6PqFL
   yNVJi6chDkUZSRLHIsjIn3nB8MM0MEcnvPT80ZKjb0LVS1JwCgX1nVK8H
   xcA9zWZ+B65yeAY6JAryakp43yRgCjIphzfZTwMb5RkN2WBrAvPpoCwSQ
   w==;
X-CSE-ConnectionGUID: eWMPO46YS7m6ZdGf8vrWdg==
X-CSE-MsgGUID: lnJ8AezKQAG6AMwSLqwjJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="91059510"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="91059510"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 02:25:07 -0800
X-CSE-ConnectionGUID: sVzLWEmFTdSSrUiKHpu6iA==
X-CSE-MsgGUID: AEc6SzrdRoSV8yA6uAjkZg==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.3.29]) ([10.238.3.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 02:25:03 -0800
Message-ID: <796c2f61-b74f-44e4-a633-eb447a79c9f6@linux.intel.com>
Date: Wed, 19 Nov 2025 18:25:01 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: remove dead check
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-perf-users@vger.kernel.org
References: <20251119091538.825307-1-jirislaby@kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251119091538.825307-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/19/2025 5:15 PM, Jiri Slaby (SUSE) wrote:
> pmu cannot be NULL as is taken as a pointer to an array. Remove the
> superfluous NULL check.
>
> Found by Coverity: CID#1497507.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: "Liang, Kan" <kan.liang@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-perf-users@vger.kernel.org
> ---
>  arch/x86/events/intel/uncore.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index d6c945cc5d07..e228e564b15e 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1325,8 +1325,6 @@ static void uncore_pci_sub_driver_init(void)
>  				continue;
>  
>  			pmu = &type->pmus[UNCORE_PCI_DEV_IDX(ids->driver_data)];
> -			if (!pmu)
> -				continue;
>  
>  			if (uncore_pci_get_dev_die_info(pci_sub_dev, &die))
>  				continue;

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897E33557C;
	Mon, 19 Jan 2026 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807888; cv=none; b=gLIWrAwm4IYDtpgZ8uceZ93P7gI9vncuXx5kIultAn9StNK7qGb7OEASszbU5EPE7gQz6SVMd4Y579al+IOhIFJQLPDq1hHoO82vFCdEA2bdmbxDXmdBV2zm6EKnK8gmtPKZ7S3fk/GISqeSdDGqJPFXZuhOTOg4yK2USYesDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807888; c=relaxed/simple;
	bh=iynO06n787J9EPVUutaj8xE+B65ig6lXz0/4ZM8wkHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsxZ+HDLUFF3KJ/WZTSZkzpt2hHFdNyvuBjlVKRNPzUSM6AdVe6YmCNphGGvFqK8F5J5tyRrMpjt1j4bgdLkFJ9PM85y4BZk6/jz0BAyPvdd2PmJHuE36pN/zsFIxTiU5WTK2l4gVht/VG4f70CgZ++8YoSgIQRFteyzU4i529c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCIb0lg6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCIb0lg6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768807887; x=1800343887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iynO06n787J9EPVUutaj8xE+B65ig6lXz0/4ZM8wkHU=;
  b=WCIb0lg6ND1L2XGv2KfxWpHVtFt2/aJQdJvl2YrSoGeIxQ/O3UILAWnS
   tJMy6cKzFInWpf6xuT1aj++E2gNiGq8IieF8iNjYo4FGUaUticHEl4eJH
   UTiT/GZqCh83WLAXD9yD9VC0BGQfovuFYQBh3OXwMRmx0tC8viJjNbalz
   5InVKhiY2Pn4Kk+gQuLTp7G/ED6C2VEGJJKkevdGwdhNAje2cJ1ufKfrU
   AB8ag3HKlALEwcgX5LFVYDfA8qsute1OBhI06frGm5dJQ+WMUh0aea8s8
   zR3Bnsb2cnO0U3e6JAKrACJJ24k+pPjlzrjUsT4+Uvimnv7NQRM/C78Ua
   g==;
X-CSE-ConnectionGUID: gpV2qoxQT3SfeVHwp2Hl7w==
X-CSE-MsgGUID: 5t8eJA24TO2m/Z1CwZhFXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="87429649"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="87429649"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:31:27 -0800
X-CSE-ConnectionGUID: DNkg1cBXRmaZNRk8ZUYGew==
X-CSE-MsgGUID: Ge57W9zYRbKW7TUF3vla6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="206154006"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:31:22 -0800
Message-ID: <de24ee43-fa1d-418b-855f-aef5c681a302@linux.intel.com>
Date: Mon, 19 Jan 2026 15:31:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] perf/amd/ibs: Throttle interrupts with filtered
 ldlat samples
To: Ravi Bangoria <ravi.bangoria@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Manali Shukla <manali.shukla@amd.com>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
 <20260116033450.965-2-ravi.bangoria@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260116033450.965-2-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/16/2026 11:34 AM, Ravi Bangoria wrote:
> IBS NMI handler has a software filter (on top of hardware filter) to
> discard samples with load latency value lesser than user requested
> threshold. However, since software filter still involves NMI, check
> for NMI overhead and throttle the sample rate if needed.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index aca89f23d2e0..96bb0974057f 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -1293,8 +1293,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  		 * within [128, 2048] range.
>  		 */
>  		if (!op_data3.ld_op || !op_data3.dc_miss ||
> -		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF))
> +		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF)) {
> +			throttle = perf_event_account_interrupt(event);
>  			goto out;
> +		}
>  	}

Not quite familiar with IBS code, but should the below code call the
throttle as well?

        /* Workaround for erratum #1197 */
        if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1]))
            goto out;


>  
>  	/*

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E747F3570D3;
	Wed, 14 Jan 2026 05:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768368331; cv=none; b=l0lIMxxcoU42DIoU9tZTt6yC6y8EDm21g+wu2StvHE2b3JR9VAbWWDqmvFwkIv7CrVtZ7RyrQE3kjdK1NMCUlqruc3aVUETrmzPWbGUWrI92jP409aVjVntvMBVZkxdCDZcixjvLlnt/VlWf0i2p/vG7IRrTcmBfV5gfG9yHn2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768368331; c=relaxed/simple;
	bh=Wjv52xi2F/AZ+4o2QZiAV95k6o6QaEUHsHFTJPU7maA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+/irmtrbn49hgpqEdc8uucHxw2fJB4Cdmsohboolm/DAjfdqvVVWITUprxN4+YI41CXs1ZO0kPbjuuXsgX8incc+ijuwvIYlI84tlLCQBWVI/BFPN8J0N5a+dhqbvlwCu7v4XPBoH+KdpZ007w8ZB3Kv48ZXyJAugJnlc9cvK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FK4c5f/a; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FK4c5f/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768368319; x=1799904319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wjv52xi2F/AZ+4o2QZiAV95k6o6QaEUHsHFTJPU7maA=;
  b=FK4c5f/a0dE+kuj2s6BtWnkbTSQfVQkV6iRgSsf9vnY22goqOEk7GX6S
   xEnGLTvdgKTOewSXvzQdP0uXcG6kIrYwzYDHmffRB2e4cE609hKuCruYg
   P5U3m0nt0sKc9FeoTOphdS4uBeD1JmN/PvTei/7JZeaGUDIqRL+gj26mv
   OtOQqXp1xO9plFoslSfYxNy3EBfMbznYRod/MjI0XkkXByl5TqQZrzZSR
   rjz5W3hyIGM8dH8bYRW4CwAN+xQ9UG/itAIntL912blYITMBxIxVAyYpK
   Gj9R7okplj+YeVGvyOGm9o3+VE8qJ/XjwO9Su4D0+lADuAhzbYPZHJfWA
   g==;
X-CSE-ConnectionGUID: FshbMVmURB6q6SCHX5LtcA==
X-CSE-MsgGUID: hHwj1BNKRguWaFM1kaetKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="95136492"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="95136492"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:25:14 -0800
X-CSE-ConnectionGUID: VbG+2/g4QFK0FGDBQiMPWw==
X-CSE-MsgGUID: rnaZU0ygQYK6KRh0HSrMUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204474468"
Received: from unknown (HELO [10.238.4.29]) ([10.238.4.29])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:25:09 -0800
Message-ID: <c4382e16-cc9a-42d3-a610-8978e946b765@linux.intel.com>
Date: Wed, 14 Jan 2026 13:25:07 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/x86/intel/uncore: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, tglx@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 zide.chen@intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260114023652.3926117-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260114023652.3926117-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/14/2026 10:36 AM, Chen Ni wrote:
> Replace comma between expressions with semicolons.
>
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
>
> Found by inspection.
> No functional change intended.
> Compile tested only.
>
> Fixes: e7d5f2ea0923 ("perf/x86/intel/uncore: Add Nova Lake support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
>
> v1 -> v2:
>
> - Add Fixes tag.
> ---
>  arch/x86/events/intel/uncore_snb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
> index e8e44741200e..3dbc6bacbd9d 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -2005,11 +2005,11 @@ static struct intel_uncore_type *nvl_msr_uncores[] = {
>  void nvl_uncore_cpu_init(void)
>  {
>  	mtl_uncore_cbox.num_boxes = 12;
> -	mtl_uncore_cbox.perf_ctr = NVL_UNC_CBOX_PER_CTR0,
> -	mtl_uncore_cbox.event_ctl = NVL_UNC_CBOX_PERFEVTSEL0,
> +	mtl_uncore_cbox.perf_ctr = NVL_UNC_CBOX_PER_CTR0;
> +	mtl_uncore_cbox.event_ctl = NVL_UNC_CBOX_PERFEVTSEL0;
>  
> -	ptl_uncore_santa.perf_ctr = NVL_UNC_SANTA_CTR0,
> -	ptl_uncore_santa.event_ctl = NVL_UNC_SANTA_CTRL0,
> +	ptl_uncore_santa.perf_ctr = NVL_UNC_SANTA_CTR0;
> +	ptl_uncore_santa.event_ctl = NVL_UNC_SANTA_CTRL0;
>  
>  	mtl_uncore_cncu.box_ctl = NVL_UNC_CNCU_BOX_CTL;
>  	mtl_uncore_cncu.fixed_ctr = NVL_UNC_CNCU_FIXED_CTR;

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



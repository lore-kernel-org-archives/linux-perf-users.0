Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4519F1F4181;
	Wed, 14 Jan 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354215; cv=none; b=dxcQ1PBjuwB2eUi//RYM5Kz89OrEeiqqNwKYasGbvoCmSmyHBdKLpPPcmv3PO5SDeSdpf8DRN29j5Akm9ORV3FMxch4F2yx56VFbLDt4jSu5ibBvTjSlcATUEu3GMs18P1wX/snR8EvF1jx+IkkiwpYrxN33qpaB9WpZT2YOhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354215; c=relaxed/simple;
	bh=W7dOIGVpZoGcdSEJEwvSQHIHMhDQWwVhZbAhrNFzlh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJtWh1sNJZgiC2iOyuFhe3z4J1HDjxg00DcZ4bfk7q0Qd2WP7lByQmThVdaYidVi99nN4VvjRXM5Kp5iEcohAGAe8cWp0Iif+KMto2l2gBNWSKh6jgvpngYpOs0InZuMp4qn0W598EV5Q00fM0w/rOpcqBIm7dbmNL3/+jBiq3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAPbVsXA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAPbVsXA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768354213; x=1799890213;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W7dOIGVpZoGcdSEJEwvSQHIHMhDQWwVhZbAhrNFzlh0=;
  b=EAPbVsXANSiu9cVL0OjtDXzbZyJ+0xmqXVUiLTTuAsmsfmKHLM/4M+yT
   SL0ESl//QO/SBoDKQujm14haHS4S+Uyb3odcsxac2yM5UzdCp7sG0uBRG
   5FCuN4m3ibaBdVQQtEHH76fw8IdpJvJth+5a20DQrKSQpnhvJvZKPpxlB
   nLp2/1+1vY9q61wT886zVarssvBUvnGnlh5o8T5At8CsFzFVY7PqoKx7U
   0T//HvolzXZC4alcvEjy7ccdRNi/jQMJS0/97XBxRdf9/9psx7w0NreY4
   7Sy7zxU/gTJHWoPj6mq5vSqNk9L3+L2kmyFdBaPjD+J2PNllGzob7Yoh1
   A==;
X-CSE-ConnectionGUID: ZfAkXADaSOOx7EnLr7XDJQ==
X-CSE-MsgGUID: ue8pK7H5RjG11nm2ckvEXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69707064"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69707064"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 17:30:13 -0800
X-CSE-ConnectionGUID: M+0KEpyBQQizcA0g7BeZuw==
X-CSE-MsgGUID: 2iP3sHWXRoW381gWEq855w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="203756738"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 17:30:10 -0800
Message-ID: <cac0ea97-bc0b-47c5-ac6c-6b972d9d4eea@linux.intel.com>
Date: Wed, 14 Jan 2026 09:30:06 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, tglx@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260114010740.3500665-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260114010740.3500665-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/14/2026 9:07 AM, Chen Ni wrote:
> Replace comma between expressions with semicolons.
>
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
>
> Found by inspection.
> No functional change intended.
> Compile tested only.

We need a "Fixes" tag here.


> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
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

Thanks for finding and fixing this hidden issue. 


>  
>  	mtl_uncore_cncu.box_ctl = NVL_UNC_CNCU_BOX_CTL;
>  	mtl_uncore_cncu.fixed_ctr = NVL_UNC_CNCU_FIXED_CTR;

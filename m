Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DAE1DE2DC;
	Wed, 25 Jun 2025 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877292; cv=none; b=naKNyLiL70SUGKeM2qkGa2ifMFIwYmBw9i7jOXGH3SWaWfe3/4ykpwMuAtPP1uKoyWGau+hnHJTpBVTgDYefE4OKx5acWKpmhcrj1TIoEDJya94IsCJ3Sl9JLDURauff2eeBY/a8dlPwSgBzjMgrSddiv+neOFrkcUcnk9Q7BJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877292; c=relaxed/simple;
	bh=kt9De5IvAY7iLGLkFAowNEnzFuWw510oKFHcaPU1AQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBiBW8sMTsegMm9chksv+vUstPvcDqJ4nfgXPGg3Je0sBFuVAIOiNrANKlrrKtDL/uoLvbnYf/eUFF2Ys8uteRFsvG/eGz5K9PDUqSL7h7KgiWjXdrlTDKnqpjl9K82B9b1bnqeZa/1tQu0NlWzxbnlHMdk3i/tUKT2abyZOh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMIcbK43; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMIcbK43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750877290; x=1782413290;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kt9De5IvAY7iLGLkFAowNEnzFuWw510oKFHcaPU1AQU=;
  b=JMIcbK43yP2ypEZpCyxlAtSH/I7FN82puSdiEAfPZnptK9o7Ggu0JqCJ
   PbqaJw8Ez3sya8/cCgyJKR3WJH9jHTX811SAcr3i83ZQNP2GSdNS4T+kD
   TH1uCaI6kAW7NWfFHL7XF0s1DL0fNxSnPXGBc5M0JM6I7rtHjH0HBzCgq
   2SqnkLDvezY0iG7t0FJM6TY73V0IsY6MTRCsoVJP/luoH5U3TahcPEmXs
   7rYSU0bFi8o/uTSmmxIC19P3avH4G3HqiR1Taourde92GYc8Z9LrRsMnN
   pHhuRkoiTSF4MCW9lx0YFz4BnhSxEC0JE9BS/PQnEVPwPiH6nZFGtJKmF
   Q==;
X-CSE-ConnectionGUID: qgU8QLywSbKJ602A34Ahyg==
X-CSE-MsgGUID: SkIle341Rx+gGfYMaWDW7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53094741"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="53094741"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 11:48:10 -0700
X-CSE-ConnectionGUID: S/LoK/0sQ/SpPQVlM57hGQ==
X-CSE-MsgGUID: nsLRR2TERduCMLjWk0+IiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="183324227"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 11:48:06 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4CF0E20B5736;
	Wed, 25 Jun 2025 11:48:05 -0700 (PDT)
Message-ID: <9a391626-df9b-46bb-a160-2c39e3fb3c4f@linux.intel.com>
Date: Wed, 25 Jun 2025 14:48:04 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/intel/cstate: Remove PC3 support from
 LunarLake
To: Zhang Rui <rui.zhang@intel.com>, peterz@infradead.org
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 ak@linux.intel.com
References: <20250625010822.250826-1-rui.zhang@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250625010822.250826-1-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-06-24 9:08 p.m., Zhang Rui wrote:
> LunarLake doesn't support Package C3. Remove the PC3 residency counter
> support from LunarLake.
> 
> Fixes: 26579860fbd5 ("perf/x86/intel/cstate: Add Lunarlake support")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

For the series,

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  arch/x86/events/intel/cstate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
> index ec753e39b007..6f5286a99e0c 100644
> --- a/arch/x86/events/intel/cstate.c
> +++ b/arch/x86/events/intel/cstate.c
> @@ -70,7 +70,7 @@
>   *			       perf code: 0x01
>   *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
>   *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
> - *						ADL,RPL,MTL,ARL,LNL
> + *						ADL,RPL,MTL,ARL
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
>   *			       perf code: 0x02
> @@ -522,7 +522,6 @@ static const struct cstate_model lnl_cstates __initconst = {
>  				  BIT(PERF_CSTATE_CORE_C7_RES),
>  
>  	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
> -				  BIT(PERF_CSTATE_PKG_C3_RES) |
>  				  BIT(PERF_CSTATE_PKG_C6_RES) |
>  				  BIT(PERF_CSTATE_PKG_C10_RES),
>  };


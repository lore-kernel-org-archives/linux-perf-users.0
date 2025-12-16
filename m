Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36311487F6;
	Tue, 16 Dec 2025 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849909; cv=none; b=kqdeKuoUc9z794kdi89wyfgl6cJ7yyLdOUR723QwWRHGse51oR/XsofO+VgIYrocAYeTpUym9biBIYXR9wCDKmniP5JfnU1j6UjYd7m/V+E9K8jsoDiy4hyH+Ra0LMMg7HSkEt41Gl//sd0NV4xRFfNluclKE+UAFUsO/Fw+maE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849909; c=relaxed/simple;
	bh=bAL1Ix06AXQJaesDVbyPJR4MEsaJmLA+bA3mVq4Kcwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3By7rUiAQ6rZtSFY2erPuiCNbiFbs47r98noLVzHASlBapAAPGzzlkPbk5uKyBXyDzUoETaNK1BH0SaoR5eUQiaIvh1/ndmWzZiWUuOLVA4nB8YeDwL9oWD6N5Z6VoJw+ynH0y0c4PV7esTuPr8ku8o4E40xeNlz9KIP3q3Lqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKwTLgx9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKwTLgx9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765849906; x=1797385906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bAL1Ix06AXQJaesDVbyPJR4MEsaJmLA+bA3mVq4Kcwc=;
  b=JKwTLgx91c0/EIS3WOdOKtWmC14+iEtPQt5AbDRAIPRAgfb07d8v9Mii
   0/Lqd6urdW0H8m6wjXDM0huTxOnftDq4dN1MxIRKxnu7zLU2XXqXs30wA
   0picMhy9uZWIjBz52ERT0RB7IC0CLKgEQb+TqHmzrJhIHlEjWR1sSy7qr
   jNZFDHIrfLVYGsKPgBnKmJuDZP3U/l95wzK0tQ801xd77adVGgtPRTHbh
   /aDD0cGZXeJQ4evZedzOwssuLw9vnSlj9wv2/JA08aEoi10ccbT41IpBP
   AMXkjR2bczjAPhrCe9+ivkzbaV+yHmoZUkR1BRVnTFzKzhjoLIPvsnbro
   A==;
X-CSE-ConnectionGUID: v1IrDXyaQ3K/gxblkqhtHQ==
X-CSE-MsgGUID: bnLooGxzQHu9n8v/QKTarg==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="66750830"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="66750830"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 17:51:44 -0800
X-CSE-ConnectionGUID: Fn9cO3zZSVWDOheJdADI9g==
X-CSE-MsgGUID: zq68VdbyRYWV/WdaV5FSTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="202383582"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 17:51:40 -0800
Message-ID: <a01f17ee-7388-4e83-8c02-132f0fc51f1a@linux.intel.com>
Date: Tue, 16 Dec 2025 09:51:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf/x86/intel/cstate: Add Wildcat Lake support
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251215182520.115822-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251215182520.115822-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The whole patch-set looks good to me. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 12/16/2025 2:25 AM, Zide Chen wrote:
> Wildcat Lake (WCL) is a low-power variant of Panther Lake.  From a
> C-state profiling perspective, it supports the same residency counters:
> CC1/CC6/CC7 and PC2/PC6/PC10.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/cstate.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
> index fa67fda6e45b..b719b0a68a2a 100644
> --- a/arch/x86/events/intel/cstate.c
> +++ b/arch/x86/events/intel/cstate.c
> @@ -41,7 +41,7 @@
>   *	MSR_CORE_C1_RES: CORE C1 Residency Counter
>   *			 perf code: 0x00
>   *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
> - *					  MTL,SRF,GRR,ARL,LNL,PTL
> + *					  MTL,SRF,GRR,ARL,LNL,PTL,WCL
>   *			 Scope: Core (each processor core has a MSR)
>   *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
>   *			       perf code: 0x01
> @@ -53,19 +53,19 @@
>   *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
>   *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
>   *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
> - *						GRR,ARL,LNL,PTL
> + *						GRR,ARL,LNL,PTL,WCL
>   *			       Scope: Core
>   *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
>   *			       perf code: 0x03
>   *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
>   *						ICL,TGL,RKL,ADL,RPL,MTL,ARL,LNL,
> - *						PTL
> + *						PTL,WCL
>   *			       Scope: Core
>   *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
>   *			       perf code: 0x00
>   *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
>   *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
> - *						RPL,SPR,MTL,ARL,LNL,SRF,PTL
> + *						RPL,SPR,MTL,ARL,LNL,SRF,PTL,WCL
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
>   *			       perf code: 0x01
> @@ -78,7 +78,7 @@
>   *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
>   *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
>   *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
> - *						ARL,LNL,PTL
> + *						ARL,LNL,PTL,WCL
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
>   *			       perf code: 0x03
> @@ -97,7 +97,8 @@
>   *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
>   *			       perf code: 0x06
>   *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
> - *						TNT,RKL,ADL,RPL,MTL,ARL,LNL,PTL
> + *						TNT,RKL,ADL,RPL,MTL,ARL,LNL,PTL,
> + *						WCL
>   *			       Scope: Package (physical package)
>   *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
>   *			       perf code: 0x00
> @@ -654,6 +655,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
>  	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&adl_cstates),
>  	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_cstates),
>  	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&lnl_cstates),
> +	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,	&lnl_cstates),
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FF3213E9F;
	Wed, 29 Oct 2025 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731926; cv=none; b=p5EcpNml2QWOcghVjsJ5qisuzYHFLysbjoSf+sLGbfM5fAW/80xdTBm8cUmSgHgFwMKLcpj9IsD6T6hfLF3lNLL+ziGrNMX38wRByPgdAWnVzCUlgkrMvMdsFNpSBaY7cau4pujraWHeTnYX5lEb7po7B8b9AOstFmOkleN+rIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731926; c=relaxed/simple;
	bh=Kq1eyyzWeTq2PGjeIgEd5N8sYVWegT3l4RTdVo9JeBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QECe++f/TiGvvrAzlxlWEtm05zM8mWU3TjoxVr9aGKMfonH9z9cRaSAWgPLndPBKp8rVLMAVDhbDq5T9WNjDQ4jZuQnYecsP4dlewHeVKzw7gPJasE9Vnf0fEUFHLpwhiklUDDkJG6Yu3VKrFUN8nY7yOQM0Ssh6b0hVA01mCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSjI1vja; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSjI1vja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761731924; x=1793267924;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kq1eyyzWeTq2PGjeIgEd5N8sYVWegT3l4RTdVo9JeBg=;
  b=ZSjI1vjagfpuKCjNuM8n6qa8JjZ5dnjBQ7rt5x4QsLWfnuV63DlebSVG
   Kk6Alzk3BbzJPmaSTyKbW3xnH2DIYUmeIL/7KhUVIFgTdIL/Z1Es04IK/
   CKDu1NfMmZ3yj74H197dKs6p8dBMfmlKilnQdh4ZxndSWHadTavS8Qe7y
   JTNKbPT6s1PCtBQ3kolFnZS85g2QMWYIp6oOambDV1QUxDMPAaFi/VfAY
   wnydd5HpY+rj6EQrnP8RtuoHf0+T4XAkmCSpVxpfryHnc6XTHNGXrzqqM
   aVaG8G2deVVjejX9vba8eizHM1y6XD2wrGJponoXwO82xP4/+9zT2cyrk
   A==;
X-CSE-ConnectionGUID: 3z28AHOqSMGWiLpeGxey5Q==
X-CSE-MsgGUID: YO9CSnQPR9a5V5T13kerlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74446075"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="74446075"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 02:58:44 -0700
X-CSE-ConnectionGUID: 4kioB4kiTv2895ziHEBokg==
X-CSE-MsgGUID: nHQntyzQR9WoogTrM29snA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="189677442"
Received: from haochenw-mobl1.ccr.corp.intel.com (HELO [10.238.3.228]) ([10.238.3.228])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 02:58:39 -0700
Message-ID: <ef7801a3-d2c3-44da-b0da-d014bd7e3e8f@linux.intel.com>
Date: Wed, 29 Oct 2025 17:58:38 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/intel: Add PMU support for WildcatLake
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250908061639.938105-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250908061639.938105-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/8/2025 2:16 PM, Dapeng Mi wrote:
> WildcatLake is a variant of PantherLake and shares same PMU features,
> so directly reuse Pantherlake's code to enable PMU features for
> WildcatLake.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 28f5468a6ea3..fe65be0b9d9c 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -7596,6 +7596,7 @@ __init int intel_pmu_init(void)
>  		break;
>  
>  	case INTEL_PANTHERLAKE_L:
> +	case INTEL_WILDCATLAKE_L:
>  		pr_cont("Pantherlake Hybrid events, ");
>  		name = "pantherlake_hybrid";
>  		goto lnl_common;
>
> base-commit: 16ed389227651330879e17bd83d43bd234006722

Hi Peter,

Wildcat Lake is a variant of Panther Lake, it shares same PMU capabilities
with Panther Lake. Could you please review this small patch-set? If no
issue, could you please merge this patch-set? Thanks.



Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973DA3AEF2D;
	Tue,  4 Aug 2026 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785806720; cv=none; b=PRO684WgSa7j1QA50ADw+ekRLveh70aW4Y1eI9lAQMbGFyS+IUJNmBhwx/UBXDDRE0VSX/FQNF+qBXf3CB5a7lxa9+IN9jZs/cvmqiKBnD9uXSvnw/HQSsiIzAuXXRVtUVtSmnoPga4x0RxlhaPPzWbR1ECZgessQl66sfJFo84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785806720; c=relaxed/simple;
	bh=RQuiByorVvnbbgwSg5XkYBr6kpduwS0I5fwUX0Vcf3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qB/wObva9g2tMSH1pTyGGg5wK4bj/FmRdJJlBTYsA4qu7kxoDsijR3W4OcHW1W6gGSsdcCAiPYzVXk9KJTuaFNaGs5lR7kVjLI3ToqN+FCFBYaIEP3DUkr8OwuGizD6y93poEa122gSnVe2+5acsvMs9zcn/SaEJUv+gJScRPQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNx+TI+L; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNx+TI+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785806719; x=1817342719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RQuiByorVvnbbgwSg5XkYBr6kpduwS0I5fwUX0Vcf3A=;
  b=ZNx+TI+LAjMGuUmVFVVr88XO10Hlzq2jEenl59qozYIVFFsidKZ533kI
   97qT7UEU8ABCMP4d4Ro57unLwEzvbbBJ5GdUkrqgjdUbjSz4TjaWcfBqQ
   DzEtHybSWAustsfNM9L95wB7psH2FVNVPsso+lVdCTS4WnvP6jF+8+xIZ
   U+7CgaMJxlG+Q5zcZ2kJ5UdbPILhrBxE6bVHZs+HkX8jGJHTLeK+OC7ID
   zXFKRyCMxNfifZGMIts/x9vIIh2Fehmx9kzhElQX9FzoaH+zDmz4GcCpw
   8GPpk8mfr7nmLLWyPdHhpjIIS9D3LtohZjcJRhmkYkSrqDDo2XmTVCorM
   g==;
X-CSE-ConnectionGUID: JdnStmgMQmaGfViUQyJX2Q==
X-CSE-MsgGUID: 37b03gueSve/7uXUEV01XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86204260"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86204260"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 18:25:18 -0700
X-CSE-ConnectionGUID: 7NH6anwYQu+L/tmefSkpZg==
X-CSE-MsgGUID: rDcZNl1ARlGe+NB7kR6tww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="260767263"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 18:25:16 -0700
Message-ID: <34636d29-febf-47c8-91c3-089a507cfdfb@linux.intel.com>
Date: Tue, 4 Aug 2026 09:25:12 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] perf vendor events intel: Fix Novalake CPUID regex
 in mapfile.csv
To: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de,
 mani@kernel.org, thomas.falcon@intel.com, irogers@google.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260803215028.834556-1-ctshao@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260803215028.834556-1-ctshao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 8/4/2026 5:50 AM, Chun-Tse Shao wrote:
> Based on offline discussion with Intel in
> lore.kernel.org/20260715211144.3144895-1-ctshao@google.com, we decided
> to drop the leading zero from Nova Lake models 0x01 and 0x03 in
> mapfile.csv to match single-digit model numbers without zero padding
> (GenuineIntel-18-[13]).
>
> The updated mapfile entry was published in:
> github.com/intel/perfmon/commit/00167baed45ac3b2708e89dbf1b9ce4769e9d115
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/pmu-events/arch/x86/mapfile.csv | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> index 8e4ee898942c..e5d90825041b 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -39,7 +39,7 @@ GenuineIntel-6-8[CD],v1.19,tigerlake,core
>  GenuineIntel-6-2C,v5,westmereep-dp,core
>  GenuineIntel-6-25,v4,westmereep-sp,core
>  GenuineIntel-6-2F,v4,westmereex,core
> -GenuineIntel-18-0[13],v1.00,novalake,core
> +GenuineIntel-18-[13],v1.00,novalake,core
>  AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
>  AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
>  AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core

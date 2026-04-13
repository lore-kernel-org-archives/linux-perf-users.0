Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734E51D798E;
	Mon, 13 Apr 2026 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043195; cv=none; b=Os6LEN+gMwg8yeuosDB+cDud1eARaMveIijWYCbhNIShzPotTRJRpHrD8/mOuXVfla98gOy/j2a4YwKngRPgct92JWb81CttVhldDULKca40Z5D3REKlzJumYSI8UPgP70fznKXffASae3T7cMQVm5Q8EVabKCBvW3Q/qQr9y44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043195; c=relaxed/simple;
	bh=zvGm/jw7xWs0d2hQGokcWf3AGZx35rF3WFN6ShtDCxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bn8RaGYtsP1HVlVmiNB+OfOF4rBIH8vI2oS+WPwDuulPglLT+NsTh0zCflmCNhe5e9UuuJU1kovugOAQNCHdaFsILTeNv3UzDJ53p+g6uQzMXFKY9vRG9e4uCtBX0e4C0BayAedMpWvQcCwZ9S49JQvyoiV+jodi7tUYURYVZ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/thzZR1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/thzZR1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776043195; x=1807579195;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zvGm/jw7xWs0d2hQGokcWf3AGZx35rF3WFN6ShtDCxE=;
  b=F/thzZR1nFfcOaRs3yOyiBzuJs0vDAUV3wtCWqYvDPJuBCgIJcIcmaBB
   Z63DUp0MXad1O2rccwoO4a/T3AwwdkDB7hTeLM8JQw6I2JTcFgZEX2fAv
   bKczgVFmpvFb1qw1QpjDy9XWV2MZ8MlthKWeb4LJMYYLWC5ReyByqF9ah
   2P6AtWWhBrN9NZ0vyhZTiJKGNoDGXD+N/dAJ2afjxrjCqxAh/wM3al7MF
   ElUTWJoLDNA1lRX9Huq3+hD8+amt65DXQZyRjZ4rrfsLQ8ybHwJkEGZ0R
   CJ70+SAbif/ZpDxJ3CDjZVV5AcLiCYYKPoPk/5AOGrgpNdm4JRcIn13R4
   Q==;
X-CSE-ConnectionGUID: qJgk/EaGTb6NflYms22A/w==
X-CSE-MsgGUID: ms15O2UNRISPqG4BqLLkyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="87268762"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="87268762"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 18:19:54 -0700
X-CSE-ConnectionGUID: f7wo3qNPR2qywSzgCgjQRg==
X-CSE-MsgGUID: b9LmlH/hTs+nEk6MHJmd9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="228621677"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 18:19:50 -0700
Message-ID: <96a7f3f9-77cd-46f9-b16f-54b4ce9c7ec8@linux.intel.com>
Date: Mon, 13 Apr 2026 09:19:47 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix 2 bugs for Intel auto counter reload (ACR)
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260413010157.535990-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260413010157.535990-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/13/2026 9:01 AM, Dapeng Mi wrote:
> This small patch-set fixes 2 issues in auto counter reload support.
> - The stale ACR mask is not cleared before setting a new one. Patch 1/2
>   fixes this issue.
> - PMI is enabled by default for self-reloaded ACR events which causes
>   suspicious NMI warning. Patch 2/2 fixes this issue.
>
> Besides an ACR unit test is added into perf tests which would be posted
> in a separate session.

The unit test patch:
https://lore.kernel.org/all/20260413010920.546501-1-dapeng1.mi@linux.intel.com/

Thanks.


>
> Tests:
>
> Run below ACR sampling commands on CWF and NVL (hybrid platform), no
> issues are found.
>
> a. Non-PEBS ACR sampling
>
> perf record -e '{instructions/period=20000,acr_mask=0x2/u,cycles/period=40000,acr_mask=0x3/u}' ~/test
>
> b. PEBS ACR sampling
>
> perf record -e '{instructions/period=20000,acr_mask=0x2/pu,cycles/period=40000,acr_mask=0x3/u}' ~/test
>
>
> Dapeng Mi (2):
>   perf/x86/intel: Clear stale ACR mask before updating new mask
>   perf/x86/intel: Disable PMI for self-reloaded ACR events
>
>  arch/x86/events/intel/core.c | 20 ++++++++++++++++----
>  arch/x86/events/perf_event.h | 10 ++++++++++
>  2 files changed, 26 insertions(+), 4 deletions(-)
>
>
> base-commit: 9805ed3c91478b08a586861b874bd8b6a2fed648

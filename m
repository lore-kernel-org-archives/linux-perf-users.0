Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543E21CD3F;
	Tue, 20 May 2025 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750588; cv=none; b=Su0uihqpjSodvvRLaxtm0E5kTCbC3DbRuHEYHAxzlisgpv8ZdWGUG1grWadvaR5Inug40KNxsC6LaOMJ7b0KaQ0GDdl53fYYwKeHeDxGg0CSGf2wP1SBXwg1cM2lwg/S9g8VloBkc+gQ+EXo6DyUXOjUD0nmxDXN3Udi0CTcapY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750588; c=relaxed/simple;
	bh=hIJkv1ReHr7jiOitm2gMHNm3E6sjizaqBmXRx8axdfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q32bKFhjpxtrrD51tT2SuTkjeeyMJFXuxIk9GWA2+S8U4GAiI4iU+zmm902UDAAmFPu80AGHV4w8Pm45K2Dossd8QMOUBWSDs1xttitnOJLBZRHAF7CEHqRD5IDyjfbTxbLw/iYoQgauGy3J//OfZL7mJmofDsXx/qx70swFveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lyYAp8jJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lyYAp8jJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747750587; x=1779286587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hIJkv1ReHr7jiOitm2gMHNm3E6sjizaqBmXRx8axdfI=;
  b=lyYAp8jJVidKUZeWiI41W9RfMbilNP/8tpv6D0V/x2etZgQuTtOjnEGl
   6U4Ldjx3xh0/cLulqplM0x3rYAAiCYWZP+D35EQT7N450jGo2jRR+HiRZ
   sqOHT1mc+tRh09EPYB+/+0uYWN6x5IDUA7l3wF4/nRoZYWAuXSvEpityz
   phy4zA8PSFakGkp9BUF5BNveXPvIZY/gk0T3iBsjUCFBaAEFFKuYuRaKk
   0U1h/zlnZcgif8U3nPP1gu+Zix91CpdzKRxwIEChH/s+ZrRE/ULgy9Wyp
   XOCQkN0wX905R3o3vKaNQLRbI3i0Un7xCcngJ9+TTcO3kF4PqyR/P4iEi
   A==;
X-CSE-ConnectionGUID: dd5bAoCpSx+ewWW8snwHvQ==
X-CSE-MsgGUID: eOnwi1VTRG6BooAT05+2tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="67242443"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="67242443"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 07:16:26 -0700
X-CSE-ConnectionGUID: eShhJpjKR3GhdSefT9W/rA==
X-CSE-MsgGUID: o7UqvB0eTWy8cjRnjx5FIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="170720126"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 07:16:24 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D22CC20B5736;
	Tue, 20 May 2025 07:16:22 -0700 (PDT)
Message-ID: <1e380367-aaad-4c02-bc10-b85b25dd2274@linux.intel.com>
Date: Tue, 20 May 2025 10:16:21 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 02/16] perf: Fix the throttle logic for a group
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com, leo.yan@arm.com
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
 <20250516182853.2610284-3-kan.liang@linux.intel.com>
 <aChHXShBhoDBgPX7@gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <aChHXShBhoDBgPX7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-17 4:22 a.m., Ingo Molnar wrote:
> 
> * kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:
> 
>> The throttle only happens when an event is overflowed. Stop the entire
>> group when any event in the group triggers the throttle.
>> The MAX_INTERRUPTS is set to all throttle events.
> 
> Since this is a relatively long series with a healthy dose of 
> breakage-risk, I'm wondering about bisectability:
> 
>  - patch #2 auto-throttles groups, ie. stops the PMU
> 
>  - patches #3-#16 removes explicit PMU-stop calls.
> 
> In the interim commits, will the double PMU-stop in drivers not updated 
> yet do anything noticeable, such as generate warnings, etc?
> 

The short answer is no.

Here are the details for different ARCHs.

There is a active_mask to track the active counter/event in X86. The
current implementation checks the corresponding bit first. If it is
already cleared, do nothing. It avoids the double PMU-stop. I've tested
on my machine.
AMD and Zhaoxin shares the same x86_pmu_stop() as Intel. They are OK as
well.

powerpc, S390, ARC, sparc and xtensa utilize the PERF_HES_STOPPED flag
instead. If the flag has been set, do nothing. It can also avoids the
double PMU-stop.

ARM, apple m1, csky, loongarch and mips invoke the disable_event, rather
than PMU stop. The disable_event unconditionally disables the counter
register. It doesn't check if the register is already disabled. But I
don't think double writing a register can trigger any issue.

Alpha utilizes the PERF_HES_STOPPED flag. But it seems still writes the
counter register even it's already disabled. Because the cpuc->enabled
is used to check whether to write to the register. It's not updated in
the alpha_pmu_stop(). But again, I don't think double writing a register
can trigger any issue.

Thanks,
Kan


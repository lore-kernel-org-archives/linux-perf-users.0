Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287A1204F82
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950082; cv=none; b=qDRmK6YwepTB218eLNpag+/2FzaeM5BQTLA5K1yq/smalLmA0/vkLTa/rTdGhiOwG4Ab7+IQfm97dP2WazozTS6QuDXAXq9uye6fwIrhce3S3DWND9gs4r9sdjtFEb16XwlDFhqlBKSz+QeOnhhHWBerBITSxl5IShmA+GAP57Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950082; c=relaxed/simple;
	bh=G/8/dq16gyCSS5SuWXUnLrMaHCb3kTjkLGwv/jA1wj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayyPsi581QlfuGMR2yPMorD53ny2derMLNEZLIpEzwYQ05djd/5S2ZS3KjaU2ru079LiDCFJkJdXmwryyNxrqC2Dk5gntkAV6uun7jq+PAgJhXBqgXAfmlKs997tpva2AtVjAbdKNYRaOH/oEn3T3cZEZiNHy5sKPShgzBR/Bg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nudY4iUf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nudY4iUf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733950080; x=1765486080;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G/8/dq16gyCSS5SuWXUnLrMaHCb3kTjkLGwv/jA1wj4=;
  b=nudY4iUf+K7E0E9MgH02mwmi9NDagXLd6b0HOmZsbiN9RUNyQMEe0OJo
   exGdbwyRCQq/zhT6FTu09utI9MpYJ3S2Vfg2c40ykutbVyRu7EKLo0FEv
   SJzZRjRjw1/V8MJ5Y7Owm9xdecIsGLNWjZl8bzVbo6AXQJ6FL3vRz2Z6x
   qHVgyq/7CKOYMaryhiaX8GNOK9M1pwbSNN7HH0ng9OcHC9+srenA9wFyr
   inFCFyP3oMZwi7Xn0YTgXG1VOWFajEBMoAjXnkRvJFA74ApCzqB6ntVKL
   KI4e3TwW3U6WWF8MKIoUtAD9UwaGhs4m2vgqNcTR8KuTSRuT67IuG6Tw/
   w==;
X-CSE-ConnectionGUID: RaarmRShRZ2nKMbNzjHpXg==
X-CSE-MsgGUID: pdomvSnfRjCSSdGtqvuNZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="37184876"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="37184876"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 12:47:59 -0800
X-CSE-ConnectionGUID: /WNTQHkbSXid/Gg6csdeXg==
X-CSE-MsgGUID: n8j/C4vlRMu3Ko6bLeSWdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="96332274"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 12:47:59 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B299520B5703;
	Wed, 11 Dec 2024 12:47:58 -0800 (PST)
Message-ID: <d071b641-b62a-4f9e-8ce3-eacbe77a62a5@linux.intel.com>
Date: Wed, 11 Dec 2024 15:47:57 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update perf tools topdown documentation
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>,
 linux-perf-users@vger.kernel.org, Vince Weaver <vincent.weaver@maine.edu>
References: <20241210193554.93013-1-ak@linux.intel.com>
 <01513f7b-390c-4e2e-a6e8-54c268e8acf2@linaro.org>
 <c1e008c4-d2c2-4088-aad2-a86987099c35@linux.intel.com>
 <71775d41-bf73-48e3-b5a6-6bce46658931@linux.intel.com>
 <CAP-5=fVx8GukBdDNe0Ckb1oPBVwsG4A4xGvj1s9VARQC4k3Dow@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVx8GukBdDNe0Ckb1oPBVwsG4A4xGvj1s9VARQC4k3Dow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-12-11 1:20 p.m., Ian Rogers wrote:
> On Wed, Dec 11, 2024 at 8:07 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>> The RDPMC can automatically reset the perf metrics.
>>> Maybe change it to "automatically resetting the perf metrics RDPMC"
>>>
>>
>> The new post can be found at
>> https://lore.kernel.org/lkml/20241211160318.235056-2-kan.liang@linux.intel.com/
>>
>> I also added the reviewed-by in the new patch.
>>
>> Please let me know if there are more comments.
> 
> Hi Kan,
> 
> Vince Weaver posted to the list a related question on topdown + rdpmc + hybrid:
> https://lore.kernel.org/linux-perf-users/b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu/
> The topic of being rescheduled isn't part of the rdpmc documentation:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/include/uapi/linux/perf_event.h?h=perf-tools-next#n610

Maybe we should emphasis that the example in the documentation is only
for p-core.

diff --git a/tools/perf/Documentation/topdown.txt
b/tools/perf/Documentation/topdown.txt
index 44644e917ffd..a229d0043399 100644
--- a/tools/perf/Documentation/topdown.txt
+++ b/tools/perf/Documentation/topdown.txt
@@ -21,14 +21,14 @@ per architecture.
      5.704818971                 14.0                 27.5
    51.3                    7.3
 ...

-New Topdown features in Intel Ice Lake
+New Topdown features in Intel Ice Lake and later p-core
 ======================================

 With Ice Lake CPUs the TopDown metrics are directly available as
 fixed counters and do not require generic counters. This allows
 to collect TopDown always in addition to other events.

-Using TopDown through RDPMC in applications on Intel Ice Lake
+Using TopDown through RDPMC in applications on Intel Ice Lake and later
p-core
 =============================================================

 For more fine grained measurements it can be useful to


> In the testing we're only testing per-task mode and not per-CPU:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/tests/test-evsel.c?h=perf-tools-next#n145

The event type is hard code to PERF_TYPE_HARDWARE, which is available
for both core. It doesn't matter which core the event is scheduled to.

If you plan to add a topdown event, the PERF_TYPE_RAW should be used,
which is the type for the p-core. If the app is scheduled on an e-core,
the event is disabled.

> It isn't clear to me how per-CPU would work given rescheduling, you
> could read a counter that doesn't match the mmap page unless you pin
> everything to just 1 CPU. Given the issues with rdpmc, perhaps it is
> safer in the documentation to cover cases without it.

As long as the scope of the RDPMC is clearly defined, I think it's OK
to add the usage in the documentation.

Thanks,
Kan


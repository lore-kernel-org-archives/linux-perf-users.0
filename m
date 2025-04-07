Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BC821B18A
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051881; cv=none; b=USzjEcOqA9knM9o+9RiUmGPlGza/+JNVfBo6zeve0bx98I8cjjnL+txD7UajB4ER/2MgRm91UDMOkOmVblrcEazcQBVqOWb9uicZurmj2AhLj5xnbr6Uz2fNnYGSX9T5lCe3K0FEJp3SzUVWY7jdzWbpJb7CDOqp9ogZv3ADXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051881; c=relaxed/simple;
	bh=B1RxrDQ77yBzTzS36jMQWBarh1X2qD1jYEnsZl7ZrHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcZS5kG7hrM1IEF+kcoJZu8Gjp4DV3KQruoQcgWlEI14Qurd4otwcpSkNBMlItXmNjg+siv8No/7fr3SnwCxpUrxVg7sple9ZcGILTCic8q4A+KtK3S/cWeKMyaC27S3prb1sRoNF4sdukj1x+Q1KYPqOpWqdmh7VccueXoYOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDe3eIEh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDe3eIEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744051880; x=1775587880;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B1RxrDQ77yBzTzS36jMQWBarh1X2qD1jYEnsZl7ZrHw=;
  b=gDe3eIEhL1qqfbGnn1BDCE/FI6SRj7DahFEAPHLQGr5uCK2PeYl/A370
   OaLMJ35WxyRP1Zl28PDiEpAJUtzzukN4gJ4AbMjK/6ggNuLdr5JLEfx4x
   8lhyRNG3l/3X7dzo2AInbZrq5yNWH6gM2yHObr3lJjd1VAH8vdS2inQ9V
   ubgWnssOtNR9gOKGYyXWqioZ1iw8Jv0kAAG+hdMHPlACw5I8XcTm7UyZu
   ItVa7UiOD83xTDrAMvhz/prBtXFmNIodvDTuA8VHnlSAGEuHSH7PJdfs8
   2aBPGXJL0zsSkfVQoLAoSaBNDSHd5rks1WBRZQL9AJBwBK/fnpVRO9b+M
   w==;
X-CSE-ConnectionGUID: L9iQQ+wrQeSWloNjjfQpbw==
X-CSE-MsgGUID: c2cOQdgMTECxDyVIFeouGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49111783"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="49111783"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:51:18 -0700
X-CSE-ConnectionGUID: I46vfFfFTN2ONjfn3vmYsQ==
X-CSE-MsgGUID: /hHv123OQzmH49OT6cH1Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="151227739"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:51:16 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4E43420B5736;
	Mon,  7 Apr 2025 11:51:16 -0700 (PDT)
Message-ID: <1b35658f-da59-4939-8b6a-110f445abcf3@linux.intel.com>
Date: Mon, 7 Apr 2025 14:51:15 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Leader sampling and topdown events
To: Ian Rogers <irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
 Weilin Wang <weilin.wang@intel.com>
References: <CAP-5=fX=hnn7egfAj+gyBeQAo24CQ1_mb7Dx-NfWaue8NMugnA@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fX=hnn7egfAj+gyBeQAo24CQ1_mb7Dx-NfWaue8NMugnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-07 2:23 p.m., Ian Rogers wrote:
> Hi,
> 
> I'm trying to understand why the following succeeds:
> ```
> $ perf record -e '{slots,instructions,topdown-retiring}:S' -a sleep 0.1
> WARNING: events were regrouped to match PMUs
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 3.077 MB perf.data (496 samples) ]
> ```
> As per the test case in:
> https://lore.kernel.org/all/20240913084712.13861-6-dapeng1.mi@linux.intel.com/
> But without the instructions event it fails:
> ```
> $ perf record -e '{slots,topdown-retiring}:S' -a sleep 0.1
> WARNING: events were regrouped to match PMUs
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (cpu_core/topdown-retiring/).
> "dmesg | grep -i perf" may provide additional information.
> ```
> With the (not merged) patch:
> https://lore.kernel.org/lkml/20250402201549.4090305-6-irogers@google.com/
> The groups being programmed are:
> ```
> $ perf record -v -e '{slots,topdown-retiring}:S' -a sleep 0.1
> Using CPUID GenuineIntel-6-B7-1
> slots -> cpu_core/slots/
> topdown-retiring -> cpu_atom/topdown-retiring/
> topdown-retiring -> cpu_core/topdown-retiring/
> WARNING: events were regrouped to match PMUs
> evlist after sorting/fixing:
> 'cpu_atom/topdown-retiring/,{cpu_core/slots/,cpu_core/topdown-retiring/}'
> DEBUGINFOD_URLS=
> nr_cblocks: 0
> affinity: SYS
> mmap flush: 1
> comp level: 0
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (cpu_core/topdown-retiring/).
> "dmesg | grep -i perf" may provide additional information.
> ```
> Given we only want to read the topdown-retiring event with leader
> sampling, what's the significance of the instructions event? `perf
> stat` doesn't require it.
> 

For p-core, the PERF_METRICS counter is not a regular counter. It's a
combination of fractions for topdown events. The slots event is required
to calculate the topdown events. The PERF_METRICS and slots must be
synchronized (start from 0 at the same time). So we cannot use the slots
for sampling. There must be an auxiliary event for sampling, e.g.,
instructions in this case.

The slots must be the first event of a topdown group. So the auxiliary
event needs to be the second event.

Thanks,
Kan


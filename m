Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795239372;
	b=3lamGFVn3gQAuBY1+VCAYRdLD/JfhTQ7JYHtOu3+OkWSskysVooahei5kt9pkROfS8Vj
	 1EbwmR8aEWZ8Dd66UqlE5kC8HVGE6u6j0RN9tyI045obKHyYQCqYPcajaZJ65LV8bwL/+
	 owYJh4uMDwRRD0pDZHrdoVqBumO9B+g4PlneCbhF63rPRd+tdIKaoloo1P0PS3n6mE6dp
	 K4XqhC+lheSYA4jqu1dKNbTCOC0roCRHfeYWS1pXJvxZTQ4VRF+iMTNb2PEE98HxZn+0B
	 gyWQOQgjqn2KW5FWJWB8Jn9O3oyKnXqcnW2vGfc7Bank4uoj4ZIEtN4AcmK4Sxpa7tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795239372;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0o3FRnQiKkoscsEUT3YbtKJLx8HWGG44j8iwYcNZKHw=;
	b=JbaM2jSWZbc03N4IXdvitbuSEpFQcz6Xp8ROf4/zDzzZGwf6xQdg1R070zAQE2KO48/3
	 zAKWQ7nm1J4TEZRxIeEK7crjg/+6p3ZTXcYDqJ3z4CKBw3HTnH9HlqW1BzOyh32YE4WmV
	 vXPCmfG6OuraJNgvJpctA+K+6ZSD0vvIk6dBwnmk9+zCaBdPC9bZbiVr557qRtVVqnYWa
	 DHn83FU8hNs0NXH0w8uK45sa4LmpFyvGlVTDOPpMZC13BFE8k/8eEHM8De2jejEGRLAZy
	 aCjnkYLuMAhMJKtfrAXrtXglPSog0UxqVwfaVIk5j6wVI6fK/3bYK8HTIXK1kBQ6K4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j8EeED3Q;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA6A606A32C;
	Sat, 21 Nov 2026 05:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFA6A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j8EeED3Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795239371; x=1826775371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oGHFSLX2ZWq3/D9o1TXL/H7n6lw7cEG3lMvkKg7Zizo=;
  b=j8EeED3QWCCNwjg98IqjrnK2iY8nL5pHtNP/SwyW8YJPGXzsxZPh1j9Y
   w5lSEWZn3rEvjkqataVAbY3mPmBAZmlBdB5SwnU1LKBBF+woMmoM4t+jf
   TIVJ5P0jpjOSceLig4M8hfwCC74HMsBBkkOdkKK4iwDFy0uLa4NgekNL2
   XrWWH+toUdMiV+R5lB9DAi6sVUcjx/O+lrOVageJ+LSFUvD86ve/1RO9w
   3XE6cQXZb55xZBwR5J94XrIznSiFqSzZLWHidI3U/kl6Wi+qed2YWyHS5
   nJnqm2+jvCsEDqnCkPzEvHtblU/FnP7z2k3sZuCjV887JtWuqd19eCEKO
   g==;
X-CSE-ConnectionGUID: gC5T/XHvRSaCxSY7PbHGgQ==
X-CSE-MsgGUID: w9bM5KuzQK6ydOdTdKRCWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4011810"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4011810"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 21:36:10 -0800
X-CSE-ConnectionGUID: YrtsrEmMQhGUdJckcrBI6Q==
X-CSE-MsgGUID: JtL1kT7bS4W4ro3XpJvdjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="11068491"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 21:36:05 -0800
Message-ID: <e8e95f5f-973c-4b81-944b-46d7ce683042@linux.intel.com>
Date: Sat, 21 Nov 2026 13:36:00 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/ds: don't WARN when the BTS buffer can't
 be allocated
To: Yuehong Wu <wuyuehong@cmss.chinamobile.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kan Liang <kan.liang@linux.intel.com>,
 David Rientjes <rientjes@google.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261105-perf-ds-bts-warn-1-yuehongwu@cmss.chinamobile.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261105-perf-ds-bts-warn-1-yuehongwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/6/2026 11:06 AM, Yuehong Wu wrote:
> alloc_bts_buffer() asks for the buffer with __GFP_NOWARN and then WARNs
> if the allocation failed anyway.  The failure is already handled: the
> caller disables BTS for the event and releases what was set up, and
> perf_event_open() returns -ENOMEM.
>
> The WARN_ONCE() came with commit 4485154138f6 ("perf/x86/intel: Avoid
> spamming kernel log for BTS buffer failure"), which added __GFP_NOWARN to
> stop the log spam of the failing per-CPU allocation but kept one warning
> as a hint.  That hint is fatal under panic_on_warn: on a machine with
> BTS, the 64 KiB buffer allocation can fail on a memory-constrained
> system and a plain perf_event_open() then panics the kernel.  Since the
> allocation explicitly asked not to warn and the error path is fine, drop
> the WARN_ONCE().
>
> Reproduced on 7.3.0-next-20261027 by making the page allocator fail the
> order-4 BTS buffer allocation (fail_page_alloc: min-order=4,
> ignore-gfp-wait=0).  Without this change the first perf_event_open() of
> a hardware event hits the warning and, with panic_on_warn=1, panics.
> With this change the same allocation failure is silent: BTS is disabled
> and a following branches/period=1 event returns -EOPNOTSUPP, while the
> kernel keeps running.  The buffer is allocated per possible CPU,
> independently of any specific BTS event, so the failure path is
> exercised without BTS tracing.
>
> Fixes: 4485154138f6 ("perf/x86/intel: Avoid spamming kernel log for BTS buffer failure")
> Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
> ---
>  arch/x86/events/intel/ds.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 8444670..27e4115 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -939,10 +939,8 @@ static int alloc_bts_buffer(int cpu)
>  		return 0;
>  
>  	buffer = dsalloc_pages(BTS_BUFFER_SIZE, GFP_KERNEL | __GFP_NOWARN, cpu);
> -	if (unlikely(!buffer)) {
> -		WARN_ONCE(1, "%s: BTS buffer allocation failure\n", __func__);

It's meaningful to keep the WARN_ONCE() here since __GFP_NOWARN is set and
the memory allocator won't print the warning message when allocation fails.

About the panic_on_warn worries , as the
"Documentation/process/coding-style.rst" said, it's the users'
responsibility to deal with the possible crash if user enables the
"panic_on_warn" option.

"

Do not worry about panic_on_warn users
**************************************

A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
available kernel option, and that many users set this option. This is why
there is a "Do not WARN lightly" writeup, above. However, the existence of
panic_on_warn users is not a valid reason to avoid the judicious use
WARN*(). That is because, whoever enables panic_on_warn has explicitly
asked the kernel to crash if a WARN*() fires, and such users must be
prepared to deal with the consequences of a system that is somewhat more
likely to crash.

"


> +	if (unlikely(!buffer))
>  		return -ENOMEM;
> -	}
>  	hwev->ds_bts_vaddr = buffer;
>  	/* Update the fixmap */
>  	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.bts_buffer;

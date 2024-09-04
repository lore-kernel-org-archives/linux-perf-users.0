Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14371D88DF;
	Wed,  4 Sep 2024 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463263; cv=none; b=uN7jCmo9WEDebUSlK2iuTwnKGNwBtQsH7MKwjwLAn1wArTujJH7K3fE1AJC1l9cPLM79fzPOrjTTYy0hdKtpRymYSzZoLWZjwOx/yiA/J4buGEBm2hfpXRtz+EinFDLyhWKFzRomZd63khlm10psY7Ex/elAcoR71WtVoJwYAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463263; c=relaxed/simple;
	bh=G6e42ZvLcKnMUFQznAoffYFdr8gDHDsObIEdwNyWko8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRIcKHwAAUSSs0Yr+ZDBDwkmJg91wG85X8Bfh7L/TBclLqSG/ubiLLI6ME6k8AP3n6fiwK2ROarNbWI0B2K4bTwyeNS+0Qx0W8lucNfTL9ewnVAswKnebE/0ov5aTe1eW3HoJ16+Xn6nbItX648UXKaj07N4KERtpC0Oqhx4b7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFmQxOsG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFmQxOsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725463262; x=1756999262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G6e42ZvLcKnMUFQznAoffYFdr8gDHDsObIEdwNyWko8=;
  b=NFmQxOsGKo7kBofzNtyQpitB4MipJhmbbnsuoclVVW4lLZRFtdjyFCrB
   ybiHJ1hjZKcC+XLRwLdGvG1+T8YioTHaeS1cRurIVlc7cW6w27y/lKHJj
   VtZ7b9jx3o7+/3upJJG8wp/pPvIIxWNAw9a3bwbXQO/kxYIGSRE7EkO5f
   Fpi+hZLH1zriaqxGawVcQmMxC57KtAQly9o9Nubg5EK4oVjDs9qv0G9Ow
   1tScqlyF9LleD6xIMxr2LEL2ozP4OYYbt0BBuc1jk61a5TdI3cI3SN2xJ
   qto8uCy2Z5Sxp6Ql8x1To/CbS7QjrvEsVWT39RVHZdkx0KWsfWqllwQJw
   w==;
X-CSE-ConnectionGUID: ra5IEnK+QJCRvI6Wm6HXYg==
X-CSE-MsgGUID: ywoUmu+gQYqgDlykkmOk/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24292936"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="24292936"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:21:01 -0700
X-CSE-ConnectionGUID: H2idS7vzTOaZxLKVe+ijoA==
X-CSE-MsgGUID: cE2UTth3RR2G7qhtwDel8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="64966311"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:20:59 -0700
Received: from [10.212.117.74] (hantran-MOBL1.amr.corp.intel.com [10.212.117.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 45EA520B5782;
	Wed,  4 Sep 2024 08:20:58 -0700 (PDT)
Message-ID: <e848ad7b-bc9d-4eca-8918-0dd5a67c347e@linux.intel.com>
Date: Wed, 4 Sep 2024 11:20:57 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf mem record not getting the mem_load_aux events by default
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Zthu81fA3kLC2CS2@x1>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Zthu81fA3kLC2CS2@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-09-04 10:30 a.m., Arnaldo Carvalho de Melo wrote:
> Hi Kan,
> 
> Recently I presented about 'perf mem record' and found that I had use
> 'perf record' directly as 'perf mem record' on a Intel Hybrid system
> wasn't selecting the required aux event:
> 
>   http://vger.kernel.org/~acme/prez/lsfmm-bpf-2024/#/19
> 
> The previous slides show the problem and the one above shows what worked
> for me.
> 
> I saw this while trying to fix that:
> 
> Author: Kan Liang <kan.liang@linux.intel.com>
> commit abbdd79b786e036e60f01b7907977943ebe7a74d
> Date:   Tue Jan 23 10:50:32 2024 -0800
> 
>     perf mem: Clean up perf_mem_events__name()
>     
>     Introduce a generic perf_mem_events__name(). Remove the ARCH-specific
>     one.
>     
>     The mem_load events may have a different format. Add ldlat and aux_event
>     in the struct perf_mem_event to indicate the format and the extra aux
>     event.
>     
>     Add perf_mem_events_intel_aux[] to support the extra mem_load_aux event.
>     
>     Rename perf_mem_events__name to perf_pmu__mem_events_name.
> 
> --------------------------´
> 
> So there are provisions for selecting the right events, but it doesn't
> seem to be working when I tried, can you take a look at what I describe
> on those slides and see what am I doing wrong?
> 

If I understand the example in the slides correctly, the issue is that
no mem events from big core are selected when running perf mem record,
rather than wrong mem events are selected.

I don't see an obvious issue. That looks like a regression of the perf
mem record. I will find a Alder Lake or Raptor Lake to take a deep look.

Thanks,
Kan

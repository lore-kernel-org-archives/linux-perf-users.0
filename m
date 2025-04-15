Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE2163;
	Tue, 15 Apr 2025 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744730496; cv=none; b=ZKy/HdyVJtivhTiT2uRh66eJmnhQbIdmOZFiicJprujHbzP9EBjsGCAVpO8y+TV9oEeuFTvQgNNP5xFHkasQ+cQDm7QjOKTdSpH5IFK5rmfWWygHnorQlujrw6CBLUB7KaLFNNIGxy5LkiclrBwQ3TZZuQsbf3hQLyDM2SKy/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744730496; c=relaxed/simple;
	bh=UZtsQn7eWW57ETxT89gwtGyP1+AHnX0eriLWRF49OWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeUaCrEM+Kgj6W+e+KJn5vXs6E5nQn3ND4vppRTH4k6hKC/HWzoloyncUDcNtalaIutep1l26cSNCv9iHzsOwiXdhlhBDwaPHnWPDx0yZ24ZHHirp+XEQiQJpLcobq9fLGbuVLSdVDNXc8nV+YngWj9W3o0pDR5eVL3ZtYeeIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nctSUJhW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nctSUJhW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744730496; x=1776266496;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UZtsQn7eWW57ETxT89gwtGyP1+AHnX0eriLWRF49OWw=;
  b=nctSUJhW9gQzjAWE+sACHByCxmdWjdLw1zhWHNKnLiCke8hH5lPM1t8s
   4qcijOfB7yBwTAeQuKOKO61srUZtySoohI2bCjIuDFeBI6aNbG879ITKF
   A1U1EYiqkcWsgK6YC/5yxjU/yg6s5U8B/6XptyrRghBzRhiKcfbrdYurd
   VPTHW48gpJ+pg16GaVFpOd9VV9D3831o6cI2vJnpO3h7/9viuLz+PnBRt
   HMptW6kAj2MArW06hh4Xds+Pzq9RjqCV+bT/D8i1LdOzfqCRB58EhSZGj
   sTeN8AikjWf/bDE1pnq8Rrat/JG0S7/dDBYURXCLlxnPv5kZNV9xMiFYS
   w==;
X-CSE-ConnectionGUID: 6WpL6mgaR/6FWq/leAayaQ==
X-CSE-MsgGUID: /DjFriP6RG+Hj1VcdZOXsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46135728"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46135728"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 08:21:34 -0700
X-CSE-ConnectionGUID: lYmH6eNOSG+/FADvhYWDCw==
X-CSE-MsgGUID: gQMoM/zhTamqy2CSVwzKPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130689111"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 08:21:34 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2ED2120B5736;
	Tue, 15 Apr 2025 08:21:37 -0700 (PDT)
Message-ID: <71ba0725-04f5-4142-8536-b5c17d2d5e00@linux.intel.com>
Date: Tue, 15 Apr 2025 11:21:30 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 00/22] Arch-PEBS and PMU supports for Clearwater Forest
 and Panther Lake
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

On 2025-04-15 7:44 a.m., Dapeng Mi wrote:
> Dapeng Mi (21):
>   perf/x86/intel: Add PMU support for Clearwater Forest
> 
> Kan Liang (1):
>   perf/x86/intel: Add Panther Lake support

Could you please take a look and pick up the above two patches if they
look good to you?

The two patches are generic support for the Panther Lake and Clearwater
Forest. With them, at least the non-PEBS and topdown can work.
The ARCH PEBS will be temporarily disabled until this big patch set is
merged.

 # dmesg | grep PMU
[    0.095162] Performance Events: XSAVE Architectural LBR,  AnyThread
deprecated, Pantherlake Hybrid events, 32-deep LBR, full-width counters,
Intel PMU driver.

 # perf stat -e
"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
-a
WARNING: events were regrouped to match PMUs
^C
 Performance counter stats for 'system wide':

         2,212,401      cpu_atom/topdown-retiring/
         8,121,982      cpu_atom/topdown-bad-spec/
        42,119,870      cpu_atom/topdown-fe-bound/
        27,667,678      cpu_atom/topdown-be-bound/
       496,377,056      cpu_core/slots/
         2,058,926      cpu_core/topdown-retiring/
         6,008,255      cpu_core/topdown-bad-spec/
       265,352,356      cpu_core/topdown-fe-bound/
       222,957,516      cpu_core/topdown-be-bound/

 # perf record -e cycles:p sleep 1
Error:
cpu_atom/cycles/pH: PMU Hardware doesn't support
sampling/overflow-interrupts. Try 'perf stat'

Thanks,
Kan

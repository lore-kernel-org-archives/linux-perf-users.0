Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBB217BA3;
	Thu,  3 Oct 2024 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984716; cv=none; b=nT/cpDXp7ZZ+HP2aYmGnfoAqGVCxlMQWX4ARookfBg+MFV7N/iKiurqbPQsK/25Z6m/kIq7TR3Ja691I+fRqesYSaP1YVp+Pe4/EAayPxNhZNevXLtUCRQs7AD2dxzKRT7nvnPmgC4Av4YRET5HJq8r3gr4beETHUoljbD8VaNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984716; c=relaxed/simple;
	bh=0/8lQtBHUjWb5r2+wnL5I8TKJL5m2GUqXoPH9jfsfsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZQo8tEWK33FWaB7IviA23BM/O64+QwWA0k7Xc5rkczCjU1DMZDncygXiQaK8aooC29K7e9zKXmLE5mjK7rfxP/661vHBqUlj1fOkXzw0y9Sy7hyQzKoazrclMgOsGSbcU96ruP6GzZbp3w4gFqINrvShWWoHb7kQ0uqOQSumlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8rWJQ0P; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8rWJQ0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727984715; x=1759520715;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0/8lQtBHUjWb5r2+wnL5I8TKJL5m2GUqXoPH9jfsfsg=;
  b=E8rWJQ0P2t9IXXjFWxdeWH1+w2sC+qm+iVgzXVDj4+Qnhx9r7Vn5mgry
   RjyZTITTpQb2li6hS+ySYIUoyGBR4KnU91MErgt+Kzm5QobdpFxgv2OkO
   T8xEMI5gtDpLDXueNF/6DgWM10tRGZ4HmZ3mXXVAwH+vF4JxFb3jMlcbI
   1+0PYPb2Lkd9iZZtGadmnmWcVe8rIeXJasAveKFP5JzmrxJVuRl4MBiRF
   W0wq98ApexaHZHUEhFZ8vsmtSnAk7HUs4dhUedioKrgrbUupUDUcNMdmi
   YkVRdYyqgP8x4n9Q3kE0hbi2TVpmA+iTnWSYMcdYCab3dmISmsgx+KdMP
   Q==;
X-CSE-ConnectionGUID: AfkwnO0YTuubU121CK+1FQ==
X-CSE-MsgGUID: 9Ewez1I6RkCQiZ7Nib1eEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="38558430"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="38558430"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 12:45:14 -0700
X-CSE-ConnectionGUID: 9EOjCBCaSkulgP7MmbOZpw==
X-CSE-MsgGUID: i8VRvNU2TTezdiWCoGzPSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="78881343"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 12:45:14 -0700
Received: from [10.212.90.18] (kliang2-mobl1.ccr.corp.intel.com [10.212.90.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 488E820B5782;
	Thu,  3 Oct 2024 12:45:12 -0700 (PDT)
Message-ID: <690ddcd6-276a-4b7b-bd21-fb4ef2349990@linux.intel.com>
Date: Thu, 3 Oct 2024 15:45:11 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
 <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
 <Zv3ek7aBkQo0Z9To@google.com>
 <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
 <b0695ef6-8a59-4550-8a33-9afb25c93f48@linux.intel.com>
 <CAP-5=fXutWptEKZKNvLXvXXpuDoMje6PiOxMuF872xoMjtumGQ@mail.gmail.com>
 <Zv7KHGQx0y3rAGWx@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Zv7KHGQx0y3rAGWx@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-10-03 12:45 p.m., Namhyung Kim wrote:
>>> If the algorithms cannot be changed, can you please give some
>>> suggestions, especially for the sample read failure?
>> So this is symmetric:
>> ```
>> if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>>   return -1;
>> if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
>>   return 1;
>> ```
>> That is were lhs and rhs swapped then you'd get the expected comparison order.
>> ```
>> if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs) &&
>> lhs->core.leader != rhs->core.leader)
>>   return -1;
>> if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
>> lhs->core.leader != rhs->core.leader)
>>   return 1;
>> ```
>> Is symmetric as well.
>> ```
>> if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>>   return -1;
>> if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
>> lhs->core.leader != rhs->core.leader)
>>   return 1;
>> ```
>> (what this patch does) is not symmetric as the group leader impacts
>> the greater-than case but not the less-than case.
>>
>> It is not uncommon to see in a sort function:
>> ```
>> if (cmp(a, b) <= 0) {
>>   assert(cmp(b,a) >= 0 && "check for unstable/broken compare functions");
>> ```
> I see.  So are you proposing this?
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index 438e4639fa892304..46884fa17fe658a6 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -70,7 +70,8 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>                 if (arch_is_topdown_slots(rhs))
>                         return 1;
>                 /* Followed by topdown events. */
> -               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
> +               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs) &&
> +                   lhs->core.leader != rhs->core.leader)
>                         return -1;
>                 /*
>                  * Move topdown events forward only when topdown events
> 
> Dapeng and Kan, can you verify if it's ok?  My quick tests look ok.

I verified the above change. It works well.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

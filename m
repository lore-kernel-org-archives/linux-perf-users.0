Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337213BC11;
	Mon, 25 Mar 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375016; cv=none; b=ReyJ53g0AG8I+EbUXJjNFFj2vlcWhauSe5qHK2Oi1ynOnkWdQmFcjL/PmWzPVO7yPOE3Q3jxtDxIFgcc+HsvjAFTZSc5ELeYh2H01jYTGKh4457ZpN54SwL9qzHCJdq387EZO0l4AeZLV5g3bV7XdScTs1ohXfWkJATLpy9PRjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375016; c=relaxed/simple;
	bh=CIjWgNa5/RqrWiWqTtP7C1MxhXcQymqkfeDs57zZTs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQdXg9HIvaFjWz1/adVb3D9ky4r5Tf0im4pGpe454sx+Adx/tTkFXLvRqHKnCVOs3Gzgp4ZMZzXXR9AGEHkvj10ltr9VkQnK7dRPRTSqhscs7q9l6kYMK+0vHNb9+brOGqVDH6ldjk41eFjxNQ0XIqefEu4YIS1B+/Cvp9pRRcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8waIhvF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8waIhvF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711375014; x=1742911014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CIjWgNa5/RqrWiWqTtP7C1MxhXcQymqkfeDs57zZTs0=;
  b=X8waIhvFYoBoJobj1sB1xsbn1UAW1Vp8mJNql/JEo84j1MuWGGPnHBsN
   6L2ansyTJsXUi4V+OwzI8Z8+umOkcoom9IbJbTW4yGX6t0xjoiuK5/HOP
   GzwkC6gpDxPt56hVEc/L2aiS2g94ZXiDPHk/D5wwSo25aOXaBRtKq9+2n
   xoy63Yb0Dcs4MHYtK2YB8yipEc6MxR1cBXaj2POwDWv4mfVQ8TAejbwki
   oCD5f5oHhnIwo0G7T7VwMA3dvoMVARzI0rySaPr5fDYfWC4L6MkRBc4gS
   aqQzSeqE1ry931Pj8u3cW/NFi51pJngWOyR1D/j6cA41GlJiGiHlhImGl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="23862500"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="23862500"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="46765985"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:56:53 -0700
Received: from [10.212.65.128] (kliang2-mobl1.ccr.corp.intel.com [10.212.65.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A933B580DE9;
	Mon, 25 Mar 2024 06:56:51 -0700 (PDT)
Message-ID: <9cfa43c3-3698-455c-8a2f-85c30470733c@linux.intel.com>
Date: Mon, 25 Mar 2024 09:56:50 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf annotate: Get rid of duplicate --group option
 item
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20240322224313.423181-1-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240322224313.423181-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-22 6:43 p.m., Namhyung Kim wrote:
> The options array in cmd_annotate() has duplicate --group options.  It
> only needs one and let's get rid of the other.
> 
>   $ perf annotate -h 2>&1 | grep group
>         --group           Show event group information together
>         --group           Show event group information together
> 
> Fixes: 7ebaf4890f63 ("perf annotate: Support '--group' option")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

For the series,

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>  tools/perf/builtin-annotate.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index f677671409b1..3e9f7e0596e8 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -810,8 +810,6 @@ int cmd_annotate(int argc, const char **argv)
>  		    "Enable symbol demangling"),
>  	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
>  		    "Enable kernel symbol demangling"),
> -	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
> -		    "Show event group information together"),
>  	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
>  		    "Show a column with the sum of periods"),
>  	OPT_BOOLEAN('n', "show-nr-samples", &symbol_conf.show_nr_samples,

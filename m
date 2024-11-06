Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E531DDC39;
	Wed,  6 Nov 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906829; cv=none; b=FMKUGWY8WIa4+CWovaVGpC2+ah0WhcjCcfsxaQkDqmKMuEFOsdVVuP6IWdl5JnzVjvWgvtKyhsK0vMyU06H+uwfkfhOkz+RM49HGDK6DNttP3D/NM5RlFg8zc/9dAEYbcziuk9mc1GLljlz4F6+EQpk/wVzUvpOZ2yTTnZIXOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906829; c=relaxed/simple;
	bh=Brk1X9aA3sPBHjbXFyQDwaIQz3kg94ymUeRtoiv8woE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q2Htrz1RFEy55udfvw/wrkejAgrT3Ko3YZV+o7GBv/k7F+6vOiFRdUsWgvavN5OxA34v5fse10hMx0e0wlQqkMYv+TGj52Bp32qhm0F5ZCz5AHOlGyZFfCd7qYtWmng3de+2YRKCoRb2JHiH2/74ZcpwDfDENZJ56BH7VcK0tNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9fXJVQJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9fXJVQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730906828; x=1762442828;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Brk1X9aA3sPBHjbXFyQDwaIQz3kg94ymUeRtoiv8woE=;
  b=f9fXJVQJ9qGzBnxuCgVBAukUDGe6hB9jlWjSmewiRV8ZaJJr02ooE1bg
   6hm0gcmwYar/hQjEAp7cISnrDlBYDe6Mohj6heBRhIFRmszFCdyhEQdwd
   jwmRuhdeu572bnWYqDequDjrRPpv1LmUJZmVR2bwYxVc4xxXgjaywZ99F
   Xu9T0/ItkrN5+SG7j1fr5HEHRDkeKkf5wmhZiFtXkH7f46eJQ6F/gME7s
   PiS4TqhiPaqSk7dw8w+NX9Kbic/HWcBKzE7t3Fbf7mg0oo0MFcuVrcjkE
   mcTw20lSN6prowLEISiH/Ncyv0aiJoe+4aeYmQ1IVlOJw8FpNZFB00Ela
   g==;
X-CSE-ConnectionGUID: xeA5W8g5RVWGWWO9zWETMw==
X-CSE-MsgGUID: ZMWl+jcCQVayZVwV3vobbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30891168"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30891168"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 07:27:07 -0800
X-CSE-ConnectionGUID: sPnCpIvdR1uJFfwMaCaNEg==
X-CSE-MsgGUID: sBopCpaBQ/uaRRjUFOcSeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89190380"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 07:27:07 -0800
Received: from [10.212.82.230] (kliang2-mobl1.ccr.corp.intel.com [10.212.82.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id EDAED20B5703;
	Wed,  6 Nov 2024 07:27:04 -0800 (PST)
Message-ID: <126ebac6-fb52-4c3c-b364-0b423e164d40@linux.intel.com>
Date: Wed, 6 Nov 2024 10:27:03 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf stat: Expand metric+unit buffer size
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241106004818.2174593-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241106004818.2174593-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-11-05 7:48 p.m., Ian Rogers wrote:
> Long metric names combined with units may exceed the metric_bf and
> lead to truncation. Double metric_bf in size to avoid this.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-shadow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 8c9292aa61d3..6b531d4f58a3 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -507,7 +507,7 @@ static void generic_metric(struct perf_stat_config *config,
>  	if (!metric_events[i]) {
>  		if (expr__parse(&ratio, pctx, metric_expr) == 0) {
>  			char *unit;
> -			char metric_bf[64];
> +			char metric_bf[128];

I thin there is already a MAX_EVENT_NAME.
Can we similarly define a MAX_METRIC_NAME for it?

Thanks,
Kan
>  
>  			if (metric_threshold &&
>  			    expr__parse(&threshold, pctx, metric_threshold) == 0 &&


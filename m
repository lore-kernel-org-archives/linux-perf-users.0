Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545DC1CAA68;
	Thu, 30 Apr 2026 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509536; cv=none; b=SdwN/00X/jdGw61EqmTlySCuLHLu2x9nybckTfMtw+2BLdWS307XpPG2EUg0PHUSVbn0otfiWo/D7U5m8z5QzwWBW6HHbyKzMeN7JkHBglzBIb70bXavFA5+JikXOyUw4Y0ga9cSMJPOwsSFkSZFg3w2/heVb8C7exjgkhDt3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509536; c=relaxed/simple;
	bh=o2BHU4lr63u6LL2U9xZl6Nv2RuBMkTIABsrX74N+8Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6ra66ldJgw2xZaLnz7mLKMt3URRM3yRN8jmGLfcVfGL9MDtVDXoys4zlUHCMqFX7YimrADpyebin0im8OnT4szGzdoBW3wGfKaKA2etSqAF41HFCsWSY8OrayRWZC7sk2TrgzQPl6TIgbfCFya/t6p/aF9N6HAiGYA15cxaiQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0rmUNKk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0rmUNKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777509535; x=1809045535;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o2BHU4lr63u6LL2U9xZl6Nv2RuBMkTIABsrX74N+8Sw=;
  b=d0rmUNKk0IfG0HseIAiL1KSiXAXorZeHWHxSMzoip1Gdq1sRYkZGfAf8
   nbK1iKeUpljIns2vlxytpE97E68oRpWNwxnNcZQzHfZ+1qVVR5HUYDKJp
   4WJ2UtseuDUAwiLyirGwZ0/MiRhNA8T7TaYGh/rVwC8pAKzcUOAuVsMEb
   xyQnUiPEMPkEDv+cFGrSj0QzC6UKsCmrbaVgVLsVj7Q2jnzv5ZQUnLIS1
   kHXsGQfYw+jI8UNiJiUxj7I2XuVse2nCcUM5lnF5c2ndOFo6bhca+N1yq
   Nf+H/DQ3QZFFhLJQGeIuu4OxQxlNzd2CdQEt/ymGjE6YDxWy/LV9D09uK
   g==;
X-CSE-ConnectionGUID: Ab5lSzfgSLGqT7WulD78bA==
X-CSE-MsgGUID: +Pqs1GhdRBOX36NHcjGFng==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="65983553"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="65983553"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:38:55 -0700
X-CSE-ConnectionGUID: RB00u7nfTUu/0/FKBzUoMQ==
X-CSE-MsgGUID: PkOrhcgGRhaTIJ28ZqfzUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="231281458"
Received: from unknown (HELO [10.238.2.250]) ([10.238.2.250])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:38:51 -0700
Message-ID: <bd6b5e3a-eda4-45a8-ad5b-3d9aea53e936@linux.intel.com>
Date: Thu, 30 Apr 2026 08:38:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v2] perf annotate: Fix missing branch counter column
 in TUI mode
To: Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
References: <20260429152917.178803-1-thomas.falcon@intel.com>
 <20260429152917.178803-3-thomas.falcon@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260429152917.178803-3-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/29/2026 11:29 PM, Thomas Falcon wrote:
> perf annotate checks that evlist->nr_br_cntr has been incremented
> to determine whether to show branch counter information. However,
> this data is not populated until after the check when events are
> processed. Therefore, this counter will always be less than zero
> and the Branch Count column is never shown. Do this check after
> events have been processed and branch counter data is updated.
>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
>  tools/perf/builtin-annotate.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 5e57b78548f4..7bddbaee1cde 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -563,6 +563,10 @@ static int __cmd_annotate(struct perf_annotate *ann)
>  	if (ret)
>  		goto out;
>  
> +	if ((use_browser == 1 || ann->use_stdio2) && ann->has_br_stack)
> +		if (session->evlist->nr_br_cntr > 0)
> +			annotate_opts.show_br_cntr = true;
> +
>  	if (dump_trace) {
>  		perf_session__fprintf_nr_events(session, stdout);
>  		evlist__fprintf_nr_events(session->evlist, stdout);
> @@ -926,11 +930,8 @@ int cmd_annotate(int argc, const char **argv)
>  	 * branch counters, if the corresponding branch info is available
>  	 * in the perf data in the TUI mode.
>  	 */
> -	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack) {
> +	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack)
>  		sort__mode = SORT_MODE__BRANCH;
> -		if (annotate.session->evlist->nr_br_cntr > 0)
> -			annotate_opts.show_br_cntr = true;
> -	}
>  
>  	if (setup_sorting(/*evlist=*/NULL, perf_session__env(annotate.session)) < 0)
>  		usage_with_options(annotate_usage, options);

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



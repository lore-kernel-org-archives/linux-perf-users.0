Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D501DF26B;
	Wed, 28 May 2025 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415801; cv=none; b=BHGoncyYDCKzSXSBQZsjWVqCjJXVwO9oW7gpubpTR3ATtQVmX67du6vtV2ByG+feQWEPtPfPcB0K/pOirbwi6bsI9Dz1/xb/jQA6OjC+HJQUquEfcIcpiWGOCIAXYDXh15wpNMHtxEGoWvC8RwbXhwnibcXK2WSsSIzv9z18NP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415801; c=relaxed/simple;
	bh=lmBB606/RhZ9VkViIQT3U8bRpJxkME4jwKV6IGAFURI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUDSIZVh5+m10HO9ZpMDrVJwM1w+l4S/kEcG1s37zw8+qi/OGC7UZXbmbisKGyIrBtgap0II5cYBdW/gjHj3/RiUg7OSXnib7iHicISNf90LzQYNIYCkud0s5QUPlTK/+kTjJM1D4HBJdguECoPT4dOewHMa8S0GXzBjc5yDC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9TCD5OW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9TCD5OW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748415800; x=1779951800;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lmBB606/RhZ9VkViIQT3U8bRpJxkME4jwKV6IGAFURI=;
  b=i9TCD5OWrBdFFZUDurYIDoJL9GkiAk41SPACTE3lMvkRT7RNM3zRbKLl
   gXn+PRaEd2eB9C/hjaHvTdfyuZsOEnIsUfB+HRFjuU2yC5IN80RA2yBDi
   ff6cwB3vyQW3Sr3WvMB7anpgos/t3+wIyCQuC4Mt56SY5RFFZCpry5nU9
   nwBA9ZhHsqP4PuRfdgvsFOGub5pDj/5SXPbhsXnaXkC3YKI+DhugWq6M6
   Xlz6ckSXL44O9C+lO6pnt4nJsHJLDG7YaMO34KwLf5fRwwkZ7jGogm3B+
   z8mj/ccMTzL9oX1QWFUsSRoJ/AkeZ9FEdZTqnftJNZ8TsRF0C1MkYT2Bb
   A==;
X-CSE-ConnectionGUID: XPrGdElkTuG27lOsvIFdHw==
X-CSE-MsgGUID: aSZlMYqFRYK8Oo6VOgNO0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="75818277"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="75818277"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 00:03:18 -0700
X-CSE-ConnectionGUID: 66S2hyaASfqzYGfACHdsKg==
X-CSE-MsgGUID: NPjMyB11T/2HBuhIivlaFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="180385549"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 00:03:15 -0700
Message-ID: <35efdc62-fc2b-40c7-9fbd-25fc6028fa6b@linux.intel.com>
Date: Wed, 28 May 2025 15:03:13 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] perf tools: Fix incorrect --user-regs comments
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250403060810.196028-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250403060810.196028-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kindly ping... Thanks.

On 4/3/2025 2:08 PM, Dapeng Mi wrote:
> The comment of "--user-regs" option is not correct, fix it.
>
> "on interrupt," -> "in user space,"
>
> Fixes: 84c417422798 ("perf record: Support direct --user-regs arguments")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ba20bf7c011d..d56273a0e241 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3480,7 +3480,7 @@ static struct option __record_options[] = {
>  		    "sample selected machine registers on interrupt,"
>  		    " use '-I?' to list register names", parse_intr_regs),
>  	OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
> -		    "sample selected machine registers on interrupt,"
> +		    "sample selected machine registers in user space,"
>  		    " use '--user-regs=?' to list register names", parse_user_regs),
>  	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
>  		    "Record running/enabled time of read (:S) events"),
>
> base-commit: 35d13f841a3d8159ef20d5e32a9ed3faa27875bc

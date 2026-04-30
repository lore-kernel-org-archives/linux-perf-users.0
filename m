Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F121D416C;
	Thu, 30 Apr 2026 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509432; cv=none; b=GSlnyzsXLn1Nc8Lkpvs6Nm9DNkFVCIF5iWDiwyg15rBwB2LjonSboonYym6PvP5+7j7t9bql+gTgbt8ztYvT4WxxWsVdhi26cPQjv6ZYEf/fT47aLGmML0HUlOHZGTXwUBb62CZCtTRbxnc1UAasveHjwXkFkokd3SY81bOpEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509432; c=relaxed/simple;
	bh=XAaSmrIzK9xKxzTt/leL5oDz/rNpl/n6pkuK/M8ZYp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWBt6W0iJf3JsMP2K69ybAXAbQ3CCIHONptMQgpPbscomeMMskeIrgXgKREzTJbPtaoSItky/auq74i//X53N2EMyWvvUpxudznJxebMyVBg5SwxA9Y5KnDAcFlQQY1Fl8xEKyYlx7d9cul2EGF9VtGGPetYwsfAxBiSgOBuBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BprAhYuS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BprAhYuS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777509431; x=1809045431;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XAaSmrIzK9xKxzTt/leL5oDz/rNpl/n6pkuK/M8ZYp8=;
  b=BprAhYuSEtp0TM95wAXgHhfW6cEAT9HXMaymTPoSsDv4+pcG4x1gaa45
   Klj0jCLLBP3crWzhDc1LponCTByRNwk/DF+P+H+kRxlvPJVg543GXVSdg
   XUHzYwJ6jJlk0XQ+Vr5IkaueaJHf1O2pGP8c8Cx8mox0D1cMyq8Or1Acp
   uXugD+uu0Mm1MzYO/u4rhMtEh46jYoZvXMkFkpg1TFeu0WzBFnbJr9Sqr
   dikQSjS/e3NkdimQHNIf1m+gL5vih2ohuTLAhEkIa4Kd9ZxAJpshHcnsa
   ZJEzKaak4NxvyVGYsQ/mk1cVbBq+M/crSiJrZLBVbgM7b9B8KGjb8Qylx
   Q==;
X-CSE-ConnectionGUID: uCZthbonT1ilU/d3rS2GMw==
X-CSE-MsgGUID: CAIQmCCNRJassLuhyT+WvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="65983439"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="65983439"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:37:10 -0700
X-CSE-ConnectionGUID: x8SOFqkpTzOQTACaLmE/VQ==
X-CSE-MsgGUID: KPl4FsRLTqyv5P/1o5gixA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="231281190"
Received: from unknown (HELO [10.238.2.250]) ([10.238.2.250])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:37:07 -0700
Message-ID: <5c37bcc6-1c3d-43ba-b4e4-cce602ab55ce@linux.intel.com>
Date: Thu, 30 Apr 2026 08:37:05 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] perf script: Fix missing '+' indicator when branch
 counter reaches upper limit
To: Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
References: <20260429152917.178803-1-thomas.falcon@intel.com>
 <20260429152917.178803-2-thomas.falcon@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260429152917.178803-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/29/2026 11:29 PM, Thomas Falcon wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> When displaying branch counter (br_cntr) information, a "+"
> suffix represents that event occurrences may have been lost
> due to branch counter saturation. However, this indicator was
> missing in perf script. Add it back.
>
> Before:
>
>  # Branch counter abbr list:
>  # cpu_core/event=0xc4,umask=0x20/ppp = A
>  # cpu_core/instructions/ = B
>  # cpu_core/MEM_INST_RETIRED.ALL_LOADS/ = C
>  # cpu_core/MEM_LOAD_RETIRED.L2_MISS/ = D
>  # '-' No event occurs
>  # '+' Event occurrences may be lost due to branch counter saturated
> ...
>         datasym+190:
>         00005567f9951676        jz 0x5567f995162dr_cntr: BBBC   # PRED 1 cycles [1]
> ...
> After:
> ...
>         datasym+190:
>         00005567f9951676        jz 0x5567f995162dr_cntr: BBB+C  # PRED 1 cycles [1]
> ...
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
>  tools/perf/builtin-script.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c8ac9f01a36b..f865c8b2f95f 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1287,8 +1287,12 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
>  			if (!verbose) {
>  				for (j = 0; j < num; j++)
>  					printed += fprintf(fp, "%s", pos->abbr_name);
> -			} else
> -				printed += fprintf(fp, "%s %d ", pos->name, num);
> +				if (num == mask)
> +					printed += fprintf(fp, "+");
> +			} else {
> +				printed += fprintf(fp, "%s %d%s", pos->name,
> +						   num, num == mask ? "+ " : " ");
> +			}
>  		}
>  		if (numprinted == 0 && !verbose)
>  			printed += fprintf(fp, "-");

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



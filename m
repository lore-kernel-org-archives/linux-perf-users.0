Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5679CF;
	Tue,  2 Dec 2025 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764638493; cv=none; b=g9ROmBm19PX/k1SE0HkZ0fyeVGmaK5gqr/AiKcARq1Vx05QKvU/0sKGzOSWT+cfR/6E2uzioFBPt3luMH6j20a5ZHkxXkE5xoQXue/P0qYYLwRhQjBCDfM8q4ZnGyoh/g+F6bI2LYfWe5DOodekbhOniZ4vF/zYUlRH6yvn38CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764638493; c=relaxed/simple;
	bh=G5tuwPivk08Ckq1Q6Kx1GdVHNRY0LMEJv3u0sxLRHyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uXNXH+t+jk1vVVRTE470ypoRmfKAtG3URPPk9g689r67+GQr+gS06n0/fOXHe1AejPkRQJJdMcsRk0xQ4+pVdZtgyot9VpxDADjAZSEhJRTD+4ajAgZHLhVFA8LQCUjcuFgGoXcgsVz49XoYQYTc/JMON+X/ztSbxYy5jCPO3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ufhrcn2M; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ufhrcn2M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764638492; x=1796174492;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=G5tuwPivk08Ckq1Q6Kx1GdVHNRY0LMEJv3u0sxLRHyc=;
  b=Ufhrcn2M7WcxHns0w8qrkUzXGpDdCWGdNmFqo/ktDjZ7sI4Q5U9sgCcp
   mP/BDzfs+aiy/FGhFdU1YzRtF8L1MmGPfQsNlsOJak8I5J5JqmhZjsFzm
   sZVTZT1d8F8h4r9Y1IU10KZrl9PA94+KA2qszOrLyiQmME98i+DQnBslI
   sbuFLoSh5VIHZZg+RGu6Z0yGguBJsaFvTgDNMef90Spu3e8fMKqSg3cMt
   TWXkRkgAJtF0nMBFtZI+WdjCNfpFuhlxxpObpk+DbIsY5wIJjc1o+lg5v
   lql5vXz8B+ouMvGTuZXD3djWXDGGGkV+WOF97XVuk5DPn/d/xx8UjvNVo
   w==;
X-CSE-ConnectionGUID: jrtm2xCfRjiK09a/RmoUWA==
X-CSE-MsgGUID: F21zh8jETpScVM0Fuhty+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="77223410"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="77223410"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 17:21:31 -0800
X-CSE-ConnectionGUID: xbx79SyHRzWnIg7NfEHZdQ==
X-CSE-MsgGUID: 90ZcBpOgSYm8bBBh8yiplQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="193350878"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.12]) ([10.124.240.12])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 17:21:28 -0800
Message-ID: <e01eaa21-c335-46b4-ba0f-72dc67997c00@linux.intel.com>
Date: Tue, 2 Dec 2025 09:21:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Fix hybrid testing of event fallback test
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Zide Chen <zide.chen@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251201231136.293248-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251201231136.293248-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/2/2025 7:11 AM, Ian Rogers wrote:
> The mem-loads-aux event exists on hybrid systems but the "cpu" PMU
> does not. This causes an event parsing error which erroneously makes
> the test look like it is failing. Avoid naming the PMU to avoid
> this. Rather than cleaning up perf.data in the directory the test is
> run, explicitly send the 'perf record' output to /dev/null and avoid
> any cleanup scripts.
>
> Fixes: fc9c17b22352 ("perf test: Add a perf event fallback test")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../tests/shell/test_event_open_fallback.sh   | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_event_open_fallback.sh b/tools/perf/tests/shell/test_event_open_fallback.sh
> index 9c411153c01b..9420a7557c13 100755
> --- a/tools/perf/tests/shell/test_event_open_fallback.sh
> +++ b/tools/perf/tests/shell/test_event_open_fallback.sh
> @@ -6,24 +6,9 @@ skip_cnt=0
>  ok_cnt=0
>  err_cnt=0
>  
> -cleanup()
> -{
> -	rm -f perf.data
> -	rm -f perf.data.old
> -	trap - EXIT TERM INT
> -}
> -
> -trap_cleanup()
> -{
> -	cleanup
> -	exit 1
> -}
> -
> -trap trap_cleanup EXIT TERM INT
> -
>  perf_record()
>  {
> -	perf record "$@" -- true 1>/dev/null 2>&1
> +	perf record -o /dev/null "$@" -- true 1>/dev/null 2>&1
>  }
>  
>  test_decrease_precise_ip()
> @@ -49,7 +34,7 @@ test_decrease_precise_ip_complicated()
>  
>  	perf list pmu | grep -q 'mem-loads-aux' || return 2
>  
> -	if ! perf_record -e '{cpu/mem-loads-aux/S,cpu/mem-loads/PS}'; then
> +	if ! perf_record -e '{mem-loads-aux:S,mem-loads:PS}'; then
>  		return 1
>  	fi
>  	return 0

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>




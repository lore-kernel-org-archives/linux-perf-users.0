Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A437F321;
	Mon,  7 Sep 2026 06:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763645; cv=none; b=icKTAjkciIYjCvdPW//lcgEoN3fpdF0eKVHRJQ/6GGRhWPBhuVrbcw6BJhx9q8MjAyf2OBfustAYYtyk7a3M0qF65k8hZdxEPfwHNsF6EAbCt/+uW9LRbgZXjdJUPjxA0InbxoNVr/wmQ7ufIwRKMfwBcEQVmsyA9fXQwTrGnfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763645; c=relaxed/simple;
	bh=bJPiTTGsc3yenhYOT2Hyvlf3agRMGZCEMTqOhy1xAXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T85CMYRV9jEL71IkzVehLqYrgi+QRDZsSW4f4/8wMdVj0efVFxOIXmQWse+OBtZcJABQKXX9oHtxV/LEC0IwBf3p4/TVpKIH/eTbmxHbSdLkKa9ydF4WbUvT1BxwTGHr/Sn1bPBoEy9sd5GANgJG7L11YzuToKrONd/dwU3U/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKqmwh5l; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKqmwh5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788763644; x=1820299644;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=bJPiTTGsc3yenhYOT2Hyvlf3agRMGZCEMTqOhy1xAXw=;
  b=TKqmwh5lyp3e1r/Ole0lt8Trqhjz7kBUj/FWorkhYbQADCB/0EUbAxrP
   Regb3UXVzLMujaXfZJb2SsYKsV46cEa+Fzsu6Tx4roGGyn7Z+/IoN7LG/
   fOtKfKu9mV5vO6E+c/p4zoEn6kGxcxHU0IZ13IwcTOwmzwwNQRbUygYHI
   sbllKLbQ2v/zb2KJtItlk5vJS8uGDX/ZgfOcnx+c/WrVoU/aTMVs+nSVU
   WPprH8BwKoQFBJJzoSATklHurIncaHOKX+Lvv9dJ0j4YlZsrDX7AagHXB
   7cbcspgCP0Rnl2az1EmE1Ht9Vx9ZXJ+ibfcoJxyIQ5kKUFPhWJdqdXyvf
   w==;
X-CSE-ConnectionGUID: e7ofdeyDRAewH9A/Ck93bw==
X-CSE-MsgGUID: 8uITsi9+Rhq8BgNQ/h6zrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89007890"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="89007890"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 23:47:23 -0700
X-CSE-ConnectionGUID: v0qGgyvMQwugywJZ/fRwfg==
X-CSE-MsgGUID: hukM3fOPR2iMjxwuL+epjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="268892816"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 23:47:20 -0700
Message-ID: <3b4cee11-a3e7-4c31-bc5d-a992f00db0c3@linux.intel.com>
Date: Mon, 7 Sep 2026 14:47:17 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Avoid call to missing cleanup function
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Zide Chen <zide.chen@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260904194954.1192154-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260904194954.1192154-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 9/5/2026 3:49 AM, Ian Rogers wrote:
> Cleanup function was removed by writing to /dev/null rather than
> temporary files. The exit path still had a call.
>
> Fixes: 44f6b4402791 ("perf test: Fix hybrid testing of event fallback test")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/test_event_open_fallback.sh | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_event_open_fallback.sh b/tools/perf/tests/shell/test_event_open_fallback.sh
> index 9420a7557c13..27d440a5355d 100755
> --- a/tools/perf/tests/shell/test_event_open_fallback.sh
> +++ b/tools/perf/tests/shell/test_event_open_fallback.sh
> @@ -57,8 +57,6 @@ ret=0
>  test_decrease_precise_ip		|| ret=$? ; count_result $ret ; ret=0
>  test_decrease_precise_ip_complicated	|| ret=$? ; count_result $ret ; ret=0
>  
> -cleanup
> -
>  if [ ${err_cnt} -gt 0 ] ; then
>  	exit 1
>  fi

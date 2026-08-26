Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B002F7F14;
	Wed, 26 Aug 2026 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758622; cv=none; b=Xs+gXR1vMDS7E7STcZiuBt3P9llo3FjdxyQ4HhWTai5HY1xEC8hF2/HqEn2fe9SW96ggCkHkR4ThA6I3C5791rcBSLz75xiFJAxoKnvCukcsTlfjvDAovmNJtRCmnLCAeIDRdO0NDz6Z41/DNXThmtZTFicV3PNhC1pWD9NyljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758622; c=relaxed/simple;
	bh=46kJdOmXXA9Z+Clpn0ggxkzOHrhLi8hXcwdHrQbxIh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQCA+8jMX0Np1CAd54iOSAj98PovLgCnyv6rA4LoM/jCtV+3gnonU8jYBqOhF+SR+aoZ8y8Ldc7FZvilxfbFgiMO2vjCPeEqcsPxH7V7zPEHJTVxoO28tWRL24IpDhfRMcIgfeuP7n7+vdq6IQ8GDmgha7cIEOWVa4Dc5nW5WxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UtDqSkEP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UtDqSkEP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B974E16F2;
	Wed, 26 Aug 2026 08:36:46 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39C5D3F85F;
	Wed, 26 Aug 2026 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787758610; bh=46kJdOmXXA9Z+Clpn0ggxkzOHrhLi8hXcwdHrQbxIh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UtDqSkEP6QMvh9X8Jt3OFI4rFoDesCHjx1iYM8Pqo3ayQAp06DXPXTO+5x/wEQizj
	 GXJHR0cHK6MSTuBGAiBGVTsgdj6VLzyYkLe411Ex/sT+BJ3Pc3m8GAcLjfS62aVGxg
	 EuXQW9cuZiyiANPbLqSWFeHiWMyORfmVn4X08Xhw=
Date: Wed, 26 Aug 2026 16:36:48 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 03/14] perf cs-etm: Turn on context packet timestamps
 in per-thread mode
Message-ID: <20260826153648.GK8904@e132581.arm.com>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-3-00c4fd0701b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-3-00c4fd0701b4@linaro.org>

On Fri, Aug 21, 2026 at 10:49:01AM +0100, James Clark wrote:

> @@ -453,13 +453,22 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  	 */
>  	evsel__set_sample_bit(cs_etm_evsel, CPU);
>  
> -	/*
> -	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
> -	 * when a context switch happened.
> -	 */
>  	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
> +		/*
> +		 * Timestamps are required to interleave samples from different
> +		 * CPUs.
> +		 */
>  		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
> +		/* Context IDs are required to associate trace to a process */
>  		evsel__set_config_if_unset(cs_etm_evsel, "contextid", 1);
> +	} else {
> +		/*
> +		 * Enable context packet timestamps only (no periodic

> +		 * timestamps). Even in per-thread mode with a single process we
> +		 * still need to correlate trace to a specific mmap around
> +		 * execs, which can be done with just context packet timestamps.

Could we use terminology that is aligned with the ETM spec?

  "Disable periodic timestamps but generate timestamps for trace
   synchronization  ... to a specific mmap around execs, which
   can be done with just timestamps of trace synchronization."

> +		 */
> +		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", UINT64_MAX);

It seems this will eventually convert UINT64_MAX to 0xf for the
timestamp bit field. Why not use 0xf directly to avoid confusion?

>  	}
>  
>  	/*
> 
> -- 
> 2.43.0
> 

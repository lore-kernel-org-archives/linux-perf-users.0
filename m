Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15698396565;
	Fri,  4 Sep 2026 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543909; cv=none; b=G9HBiQ2P3IYTO015cu1valwTjssdgv2jvtYcfE8DzjzAwVsUSVFcCXO9pSKIb2FYPRWSkPWpKh5alrimT6CZDSk1JL+7wjzSJM+i4QzCHsBIVpi3B+R0RWO3Kb0zqfrx11pTbxTiYN4rhVKcGMypuL/sDO59+wU+RGI9Gygp4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543909; c=relaxed/simple;
	bh=ZHXUHTgBsZEh26fOHvyKJbcpT9hW8hW0zSA/LhXujMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTdqoREvCtb6Bz6rkrzOTgSoR/YdqOzMxiB/qUL6I+UZdW8vcCmCW9ErZCsAmvo04DvIKpyVOHzhHefIs2rTVozi5IxGSl1awuWoYlJGVFMkoYij2LsgmIANFXCUhqG2xKmHebQnBG7+w99C/Nw7yemTZIceogN01GduVHmlzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ant9XImY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ant9XImY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756BD152B;
	Fri,  4 Sep 2026 10:45:02 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D10EE3F7D8;
	Fri,  4 Sep 2026 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788543906; bh=ZHXUHTgBsZEh26fOHvyKJbcpT9hW8hW0zSA/LhXujMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ant9XImYbJ1oD8BB/rZzmbivZPPVSpgcETqcOYR77mr9o02NdUMD5vBbh/6N7Rbhq
	 KHanHAa47oO5iVgVq/N0Jhp5HMw14aZ4BSfjHBTfyqq/Ry2bGemuxyl5VXLtTNwvAj
	 7FiFx6kWYhydHlfvYMrKHMPeX4kZHEs/Mxoid3iM=
Date: Fri, 4 Sep 2026 18:45:03 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] perf: cs-etm: Respect --no-itrace option
Message-ID: <20260904174503.GC8904@e132581.arm.com>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-4-9d532ddabcc3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-4-9d532ddabcc3@linaro.org>

On Fri, Aug 21, 2026 at 10:50:32AM +0100, James Clark wrote:

[...]

> @@ -3603,27 +3603,49 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>  	int err = 0;
>  	int aux_hw_id_found;
>  	int i;
> -	u64 *ptr = NULL;
> +	u64 *ptr = (u64 *) auxtrace_info->priv;
>  	u64 **metadata = NULL;
>  
> -	/* First the global part */
> -	ptr = (u64 *) auxtrace_info->priv;
> -	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
> +	etm = zalloc(sizeof(*etm));
> +	if (!etm)
> +		return -ENOMEM;
> +
> +	session->auxtrace = &etm->auxtrace;
> +	etm->auxtrace.free = cs_etm__free;
> +	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
> +	etm->auxtrace.process_event = cs_etm__process_event;
> +	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
> +	etm->auxtrace.flush_events = cs_etm__flush_events;
> +	etm->auxtrace.free_events = cs_etm__free_events;
> +	etm->pmu_type = (unsigned int) ((ptr[CS_PMU_TYPE_CPUS] >> 32) & 0xffffffff);
> +
> +	/*
> +	 * Don't go further than the minimum required to identify this event as
> +	 * auxtrace with cs_etm__evsel_is_auxtrace() so unleader_auxtrace()
> +	 * works.
> +	 */
> +	if (auxtrace__dont_decode(session))
> +		return 0;

TBH, I don't look in details, currently auxtrace__dont_decode() only
exits in the common util/auxtrace.c, why other AUX trace can work well
the option but cs-etm.c needs particular initialization?

Seems to me, we even don't need to do any initialization in cs-etm.c
if the no-itrace flag is set.

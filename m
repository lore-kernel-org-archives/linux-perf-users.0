Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8081A8C07;
	Wed,  5 Jun 2024 05:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717565222; cv=none; b=YgSt1LM1x+ySju6lifA9VuBWOEcoQqyQ1q4y0epFWuaE4LXeyIiCFJT5Q0qHuQmDhAIxXWQ5dIa5tJGFa2xdvWCi/r9U7Gy8lc4gG+ri71Eo3Uxg8OkI2h6hTWJ5tWwOT9W1McRz+gQc0gJcPiuk7mJ71IfT3nSBj6EH/h+Cs5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717565222; c=relaxed/simple;
	bh=3RRuyKGLNOBy7i2i4R4B/Xpa4YznPKGDdEc8i6l7yhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PO6YeBG2OsSA6r8daTIuVagSGeU5CBy31wmFO5uA87qorQn9z40uaozJeaLAYHNQhevWFGkbHF8KBaEpX3H33fT20clq7s3w/B+5q34l6CHZ9Rz7UrzP6SSxB0Qu1A9fXZcoqorcrBYXv4J+Tk3C6B1qRf10RbTFmAtkRZh+KD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bv3rD2GV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bv3rD2GV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717565220; x=1749101220;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3RRuyKGLNOBy7i2i4R4B/Xpa4YznPKGDdEc8i6l7yhA=;
  b=bv3rD2GVn8QZA/VCpAZPNkStDZ16BzajEmcMcZmJLMnuP5ZfCjEoYrSq
   /Hw9x4wt8IZRHCeKDSXoa+QZrCD8QS0v2/tOEJ9VCYVXEc+pXSJo0e4M8
   lclQzohWCpsrf4GKrnd5d2KJk1KX6Ah3fxDbzm9cpYuNyDTfwdyAN5Hnc
   OK5GSrnQntNtbBH7OG/W/59mI4pr3kbh2Zut1/2dXL/OVeWAXe3r7Kw25
   2qxRfvijKc4WjTYadYLRHVfV1anSWjqFfIwnY2UCv7aLXIImXvW3vZxmP
   ADm3irTLNnBn9PX8POQie0iY/jm1GtvCVnH93/7vVMv8zx++vNsU0gubV
   g==;
X-CSE-ConnectionGUID: zCSRlhB4RQinqYLloDjw8A==
X-CSE-MsgGUID: wKxVP2Z5TeiOF9QJdoOa8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13956046"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="13956046"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 22:26:59 -0700
X-CSE-ConnectionGUID: sk5OLcxuTBWzciShxNLuCw==
X-CSE-MsgGUID: JsmSPp6SSL6tLYR07zqctQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="38038066"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.95])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 22:26:53 -0700
Message-ID: <12c09d40-788d-4af1-9eb6-0f5699875d70@intel.com>
Date: Wed, 5 Jun 2024 08:26:50 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] perf auxtrace: Allow number of queues to be
 specified
To: James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
 suzuki.poulose@arm.com, gankulkarni@os.amperecomputing.com,
 mike.leach@linaro.org, leo.yan@linux.dev, anshuman.khandual@arm.com
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
References: <20240604143030.519906-1-james.clark@arm.com>
 <20240604143030.519906-3-james.clark@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240604143030.519906-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/06/24 17:30, James Clark wrote:
> Currently it's only possible to initialize with the default number of
> queues and then use auxtrace_queues__add_event() to grow the array. But
> that's problematic if you don't have a real event to pass into that
> function yet.
> 
> The queues hold a void *priv member to store custom state, and for
> Coresight we want to create decoders upfront before receiving data, so
> add a new function that allows pre-allocating queues. One reason to do
> this is because we might need to store metadata (HW_ID events) that
> effects other queues, but never actually receive auxtrace data on that
> queue.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Again ;-)

> ---
>  tools/perf/util/auxtrace.c | 9 +++++++--
>  tools/perf/util/auxtrace.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 3684e6009b63..563b6c4fca31 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -218,15 +218,20 @@ static struct auxtrace_queue *auxtrace_alloc_queue_array(unsigned int nr_queues)
>  	return queue_array;
>  }
>  
> -int auxtrace_queues__init(struct auxtrace_queues *queues)
> +int auxtrace_queues__init_nr(struct auxtrace_queues *queues, int nr_queues)
>  {
> -	queues->nr_queues = AUXTRACE_INIT_NR_QUEUES;
> +	queues->nr_queues = nr_queues;
>  	queues->queue_array = auxtrace_alloc_queue_array(queues->nr_queues);
>  	if (!queues->queue_array)
>  		return -ENOMEM;
>  	return 0;
>  }
>  
> +int auxtrace_queues__init(struct auxtrace_queues *queues)
> +{
> +	return auxtrace_queues__init_nr(queues, AUXTRACE_INIT_NR_QUEUES);
> +}
> +
>  static int auxtrace_queues__grow(struct auxtrace_queues *queues,
>  				 unsigned int new_nr_queues)
>  {
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 55702215a82d..8a6ec9565835 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -521,6 +521,7 @@ int auxtrace_mmap__read_snapshot(struct mmap *map,
>  				 struct perf_tool *tool, process_auxtrace_t fn,
>  				 size_t snapshot_size);
>  
> +int auxtrace_queues__init_nr(struct auxtrace_queues *queues, int nr_queues);
>  int auxtrace_queues__init(struct auxtrace_queues *queues);
>  int auxtrace_queues__add_event(struct auxtrace_queues *queues,
>  			       struct perf_session *session,


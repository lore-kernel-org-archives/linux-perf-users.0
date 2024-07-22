Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B003A8F7;
	Mon, 22 Jul 2024 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646836; cv=none; b=uJM+nFx7flvjTfo2+o5ml5r6QDgcmoA3zBwdWCjgSa/SATU8YoFcneTQDx1ueLi8hhFmFveNO75XaT5hQy+G3eTySyQIEse5b3ykoXJ+LUSp6A8yfj/990CudulNmRpqPo8lvacGv5f7iJLWuexiNeDL7ezuJCkkuTGMpuN5IVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646836; c=relaxed/simple;
	bh=epq/oVOAbsZItv4EApiSC0nImHFpX+Gb33tvWPeHBYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DJd4PmRCN0ZBZ5S9dedA6igYpUbOVISwr2elY51FhkNMe8rpbqLBmoogWEt+QuNhodsG4ZPpzhZeQQrl6f73QJPBbHSItSo55LA5jnmbPj7x62NjzlBd4NqqtLfiTfqE+iqu9IfX7WVysh1IFmauKKAEx8hf2iJquGzEgKp3PBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CC7f0/bP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CC7f0/bP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721646834; x=1753182834;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=epq/oVOAbsZItv4EApiSC0nImHFpX+Gb33tvWPeHBYo=;
  b=CC7f0/bPt0HBroTSxdzyTD9oIgjnN8BNtulQh/DZ0H/gSR62crY2sBUX
   saNXuPU+TDsuaY7AbhMXWUn3TU7hc0vobBGciX6qxiUBYb+wx/qDjFTW7
   mL6J8lVB4S18IUnmer6tXCuTd94BVwfOF2y8l32kwITAUfhSYTb/4m5OJ
   iUDKDHRrl3rA66sS7lQOYvSGdeFCUP8Bneb7uykO+rNT4rzm2dmX6w2PT
   /y7dJ2Wwxd3/rQkTuAySg87fHCMP8X4l9tDM6EMe5qb0PxebZmp7fDoin
   5N3WY8c1kZ+f948nypvV3/IlwQzlo7fLmFemN88RG1s3SG+0mq3KQLzeO
   g==;
X-CSE-ConnectionGUID: N3Sj0/QMTLadgkXmGNV8Yw==
X-CSE-MsgGUID: FS+69JT0TOuA9siPVte1gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19080175"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="19080175"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 04:13:52 -0700
X-CSE-ConnectionGUID: g0rJ/vUPRvSo0+TcOy12CQ==
X-CSE-MsgGUID: 9jb6BcuBSeit7re7VGHE5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="56702178"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 04:13:48 -0700
Message-ID: <9f08c5cb-fb4b-4994-9128-0484aa6c06d7@intel.com>
Date: Mon, 22 Jul 2024 14:13:43 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] perf auxtrace: Iterate all AUX events when finish
 reading
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240721202113.380750-1-leo.yan@arm.com>
 <20240721202113.380750-5-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240721202113.380750-5-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/24 23:21, Leo Yan wrote:
> When finished to read AUX trace data from mmaped buffer, based on the
> AUX buffer index the core layer needs to search the corresponding PMU
> event and re-enable it to continue tracing.
> 
> However, current code only searches the first AUX event. It misses to
> search other enabled AUX events, thus, it returns failure if the buffer
> index does not belong to the first AUX event.
> 
> This patch extends the auxtrace_record__read_finish() function to
> search for every enabled AUX events, so all the mmaped buffer indexes
> can be covered.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/auxtrace.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index e2f317063eec..95be330d7e10 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -670,18 +670,25 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
>  int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
>  {
>  	struct evsel *evsel;
> +	int ret = -EINVAL;
>  
>  	if (!itr->evlist || !itr->pmu)
>  		return -EINVAL;
>  
>  	evlist__for_each_entry(itr->evlist, evsel) {
> -		if (evsel->core.attr.type == itr->pmu->type) {
> +		if (evsel__is_aux_event(evsel)) {

If the type is the same, then there is no need to
change the logic here?

Otherwise, maybe that should be a separate patch

>  			if (evsel->disabled)
> -				return 0;
> -			return evlist__enable_event_idx(itr->evlist, evsel, idx);
> +				continue;
> +			ret = evlist__enable_event_idx(itr->evlist, evsel, idx);
> +			if (ret >= 0)

Should this be:

			if (ret < 0)

> +				return ret;

And will need a common error path for the pr_err() below.

>  		}
>  	}
> -	return -EINVAL;
> +
> +	if (ret < 0)
> +		pr_err("Failed to event enable event (idx=%d): %d\n", idx, ret);
> +
> +	return ret;
>  }
>  
>  /*


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1551F956
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2025 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764120829; cv=none; b=gAnfjDmDGc7cMQPYlUWg7vCr+xmDGSYVf5qf5S8z+U6UFyPFfVoPS3R/7pDm38RpIxjriM2wL3rqxoLRGwxyw/AROqutzELVKLJQsxQKa6WqDjJGjQqGOXcs+bcKLf7yINpxcVmw51HkMj1go45TiOC5XsaiImiscVjUAI0Ggu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764120829; c=relaxed/simple;
	bh=FqbRw1ukOs163cBhyRQotQIXqJOKzsn7aypGKIg575k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWMiXX9Bl3ikyW2lqRR2LX45SkPvhazxD9CGKMD8NCKksQNON0XJxrKASlqFwTqawNbcpQXrWNTXwKYS5d9Xipp5OBm0/i8uElzKhhbqvs2LqfWuTElImxjV8nnf+zm4ocpxcJ1ty6p3BKdPjKZjK5qBYgmQuFrlu3gX1/Ug9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zm9FyWKt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zm9FyWKt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764120828; x=1795656828;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FqbRw1ukOs163cBhyRQotQIXqJOKzsn7aypGKIg575k=;
  b=Zm9FyWKttYoRVvJnlevGUapjJs9V6fT3zTNSUNSYfxZxjE13r5fgU1/j
   7UGaDbN5JjeA8D+W/kzDFzMbVz075tOfNePg/JA2hGNd5Hd/Sq4cQgh7L
   LFaP57CH/6FBKE1vT/rzq48TmYURd3UM8qSWBGWqHy/jKdSrPyadLmqxH
   FX+wRpJgWr2U6migdHS0dJIY6lYrELk6Xtl3e9MnxJhYxB8stVYcjg+lX
   wmL3c57sMLXnQpGKhRc4NWT+Dq63uRnF31XsIdaZRdaqWA5A9SdjCxDBR
   PXmEMBtrKX9hU0bKcMNWKCUet4qd4SQeHxpgtFcmjw6+zY5tQfRAlHd+c
   Q==;
X-CSE-ConnectionGUID: 2pZ2YHetR6a/x1/0U4oaHA==
X-CSE-MsgGUID: E3cxjcrAR7aaSrdPFvdeJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66033923"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="66033923"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 17:33:47 -0800
X-CSE-ConnectionGUID: Ma29G3b8S6yoIF0vmX87zQ==
X-CSE-MsgGUID: wdlkvejfROu8j5MdMJ5u3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="230058380"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.213]) ([10.124.240.213])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 17:33:44 -0800
Message-ID: <9efbbdad-c7d6-46ac-89f3-6ed28533b85c@linux.intel.com>
Date: Wed, 26 Nov 2025 09:33:40 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf pmu: fix duplicate conditional statement
To: Anubhav Shelat <ashelat@redhat.com>, mpetlan@redhat.com, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@linaro.org
References: <20251114220547.496562-2-irogers@google.com>
 <20251125114118.196089-1-ashelat@redhat.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251125114118.196089-1-ashelat@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/25/2025 7:41 PM, Anubhav Shelat wrote:
> Remove duplicate check for PERF_PMU_TYPE_DRM_END in perf_pmu__kind.
>
> Fixes cedf1f4852ae.

The code change looks good to me. But the offensive commit hash ID seems
incorrect.

The change comes from this commit.

f0feb21e0a10 ("perf pmu: Add PMU kind to simplify differentiating")

Better add a "Fixes" tag for this change. 

>
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  tools/perf/util/pmu.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index cfcaba3e2e75..723a67cb41f4 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -331,8 +331,6 @@ static inline enum pmu_kind perf_pmu__kind(const struct perf_pmu *pmu)
>  		return PERF_PMU_KIND_PE;
>  	if (type <= PERF_PMU_TYPE_DRM_END)
>  		return PERF_PMU_KIND_DRM;
> -	if (type <= PERF_PMU_TYPE_DRM_END)
> -		return PERF_PMU_KIND_DRM;
>  	if (type <= PERF_PMU_TYPE_HWMON_END)
>  		return PERF_PMU_KIND_HWMON;
>  	if (type == PERF_PMU_TYPE_TOOL)

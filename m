Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9770944F;
	Wed,  5 Feb 2025 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782709; cv=none; b=Ju8qN7JBXDVVKOXlErTvsgRtSZqdXtEVrUNZmWqVbb2ni0TyjT3g+ywHnr0dzNd/cd2ndlhEEA73XIHjlAUV/GrE98810BvHV/Of3bMFfC6BxjudBEV1EgAXiP+5w9lijsITZ7mMSC2+Ki7FfdRFT57syKpXigKPVYdQ3Tcw0k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782709; c=relaxed/simple;
	bh=Cfh1njfmFVp1IfDiv7sGSmv8/HD6Y5Neq0KxmXPyi7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DxrwwV1+eMCqmRSTTSwwcMC0FSj9fAmTI+7262fksfH+NIAU34pFvQoYtBprs2gyhhz9Pg50B0MqUexUZfc7qCkA8nbTKskcwTTILrl+4ennL5Siw/1Yv88/TrXZylg2l/hVYK9DqSQx690Y+uR6mwzZ4VNPuZFCI2StKMem1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+gNtQ3c; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+gNtQ3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738782708; x=1770318708;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Cfh1njfmFVp1IfDiv7sGSmv8/HD6Y5Neq0KxmXPyi7o=;
  b=B+gNtQ3cqPAfH++PIB3GDFraX6NKJ6NkgSVnrwvVa0IqbFxJRW+AwwKD
   OtgDJ6cOFO8vMVsMgi1eaq3+z0pMVVaRnrphAQbnEIFd3qY3Qj346UYZ5
   8YyWa4mT9l4gojc5amUWFqRiy51GdGM0sxNuQGR7shNeSHJ8lobCzB3YJ
   kIAIcFLPyt4t0zVQfp+ZBYI9t0/RttgmTxAreoywDfrLCKDa3VQLPSTHk
   Vy5T4EQEtFheNJEq2tPWfQmDwjoyHrhb5Psx9DUfIrZMQ/jzwE/UG9nGe
   imZpZ+jAwRmeMHi2JyeyDRaaOQ0ysrPySp3ExRWiVV2y5Jc43ERX0gh9G
   A==;
X-CSE-ConnectionGUID: 3y0LVnseQmKvF8y46LZclw==
X-CSE-MsgGUID: N2NZk3QKSeml2cZs2lvkmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38570582"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="38570582"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 11:11:44 -0800
X-CSE-ConnectionGUID: zfkCCFFxQvSwsiWlDGAVBw==
X-CSE-MsgGUID: L22l8mFYS/22WdUvcbWGrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="110780356"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 11:11:43 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 3468920B5713;
	Wed,  5 Feb 2025 11:11:41 -0800 (PST)
Message-ID: <7692d2d6-16d5-4f50-8c3a-37f1db356426@linux.intel.com>
Date: Wed, 5 Feb 2025 14:11:40 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/24] perf vendor events: Update/add Graniterapids
 events/metrics
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>,
 Samantha Alt <samantha.alt@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>,
 Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>,
 Thomas Falcon <thomas.falcon@intel.com>
References: <20250205173140.238294-1-irogers@google.com>
 <20250205173140.238294-12-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250205173140.238294-12-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-05 12:31 p.m., Ian Rogers wrote:
> +    {
> +        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
> +        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
> +        "MetricGroup": "BvUW;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricName": "tma_retiring",
> +        "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
> +        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum Pipeline_Width throughput was achieved.  Maximizing Retiring typically increases the Instructions-per-cycle (see IPC metric). Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Heavy-operations or Microcode Assists are categorized under Retiring. They often indicate suboptimal performance and can often be optimized or avoided. Sample with: UOPS_RETIRED.SLOTS",
> +        "ScaleUnit": "100%"
> +    },

The "Default" tag is missed for GNR as well.
It seems the new CPUIDs are not added in the script?

Thanks,
Kan

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A1F17C3
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Nov 2023 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlBNxAUE"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CF1FC;
	Mon,  6 Nov 2023 23:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699341935; x=1730877935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=llRoDtmc+r5SempaBzUob7pMWwccBv60/lBawAuIIt4=;
  b=BlBNxAUERdLlh2QTQvBwai1bvyuzGETDhvhearQ1oXH8sWO4wh6IcGyF
   VTFbMCbu4CCPy5uNnLNnDme2DfzbHolnsqOTSF3uwfwXSiAQjxNqBRmXD
   deLWdY51hj56jdXFQwnrwHIqclJFSSPBstDQ5FY4MpYIqbIyknJvHQEtp
   +WbZ8DvuEpbrazpP3QV4bLR+EKv/i4jUT2SiJ32EM5OhsQE8INfxIsUh4
   ZiTJG8Hn4c9yz84Xsq8alfVgg2K/zK6dTjLMg4osNgbv+CAqBniX3Yfsu
   KDc7AScB8OgAYIBL+nKKcEOlr6ZUy6RSylpJ+xeNpKwB5vxPa1DNbT5Nc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="388327626"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="388327626"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 23:19:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="1009795977"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="1009795977"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.31])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 23:19:14 -0800
Message-ID: <2940af18-8bcd-4456-a8ed-e77cade1b160@intel.com>
Date: Tue, 7 Nov 2023 09:19:10 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf auxtrace: Add 'T' itrace option for timestamp
 trace
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231014074513.1668000-1-leo.yan@linaro.org>
 <20231014074513.1668000-2-leo.yan@linaro.org>
 <8a2ea58f-f835-4d1a-8bd6-3a63b3b0db94@intel.com>
 <ZUlgM8pgf19UeyM9@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZUlgM8pgf19UeyM9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/23 23:52, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 19, 2023 at 01:47:15PM +0300, Adrian Hunter escreveu:
>> On 14/10/23 10:45, Leo Yan wrote:
>>> An AUX trace can contain timestamp, but in some situations, the hardware
>>> trace module (e.g. Arm CoreSight) cannot decide the traced timestamp is
>>> the same source with CPU's time, thus the decoder can not use the
>>> timestamp trace for samples.
>>>
>>> This patch introduces 'T' itrace option. If users know the platforms
>>
>> "If users know" <- how would users know?  Could the kernel
>> or tools also figure it out?
> 
> Adrian, I'm trying to go all the outstanding patches, do you still have
> any issues with this series?

No, although the question wasn't actually answered.  I presume users
just have to try the 'T' option and see if it helps.


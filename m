Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E0612B95;
	Tue, 18 Jun 2024 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718320; cv=none; b=WfUuckxgg8GbSfZhBDojaugwEW1EE6iA0v38IHbN5v8nGlhctDEl6z17cFWpTtvbiuBi/CubYWTdVpAVEUDTG60enbIAcy4J6CEqNJVMBy1yH83rF6UJDjDvNgLunQ+UREsyTcNRbbTBfur/AQJhhTQI8bRhQWV0F3bnZIbg95M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718320; c=relaxed/simple;
	bh=qIRP7WziDihj3AiKzpO4qsVfd9h7I4nske+kKM6qQOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvPUarzy079TCb4g5YF1aL6zl5FTca0xgneuYn79V4VWkik6NLXTOObliO2UG+cO21w6ty/d99LWO8ckmldFUWU5qwQKAzsoeRkly+7MFojcEjkXxWgNmXYQhp+IwuIK4hrf7kC22l0SeAy8PQfn3mOJWWGnWz6n+Cd9/3w2eNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQj3DfAp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQj3DfAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718718319; x=1750254319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qIRP7WziDihj3AiKzpO4qsVfd9h7I4nske+kKM6qQOM=;
  b=GQj3DfAp+5sS/nbjDFxugvM1QjbgCHi+RrZQ6tZeuxWIBxxdLXqwV5Wm
   +nAHD5SHAQkb+wECF3vZcPHtLqnj9rFGanFOIok9toqX5TveXXdv8xKTI
   1mvaSUNiJSxANNSkFtdUtsBXPLNGk0oPjfSycgwfPHKY9XoDAfwhVQqvD
   pxNhFiXRQrf+cJ/kwJW7gkmlmucoHD0arEFyST/JHqrnt0HxApLdRnaVf
   +oWxCncCJtP+JdRKHLCLll9Vn9T8UzpwzVVjFTk513NAiYHBy2KXFpwtC
   rPLyckVQQdCGW7MXgP+NQE1kd7eIwWnnkfHQF9Fbj8yJQkP+RcL49svL+
   Q==;
X-CSE-ConnectionGUID: eLBePovlT/KbZ5KZ01b7dQ==
X-CSE-MsgGUID: zPbksVpqT5mWLcLDBElfFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15740819"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15740819"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 06:45:18 -0700
X-CSE-ConnectionGUID: RYQDIZYjSV6Vn+hV2fR+kA==
X-CSE-MsgGUID: pxtX/aX1SxmRGvkmobxipQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="45922331"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 06:45:17 -0700
Received: from [10.212.26.15] (kliang2-mobl1.ccr.corp.intel.com [10.212.26.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9EDCF20B5703;
	Tue, 18 Jun 2024 06:45:15 -0700 (PDT)
Message-ID: <00ac4787-c290-424f-8461-7ba300a4c1a9@linux.intel.com>
Date: Tue, 18 Jun 2024 09:45:14 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/37] perf vendor events: Update grandridge events and
 add counter information
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Weilin Wang <weilin.wang@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>
References: <20240614230146.3783221-1-irogers@google.com>
 <20240614230146.3783221-14-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240614230146.3783221-14-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2024-06-14 7:01 p.m., Ian Rogers wrote:
> Update events from v1.01 to v1.02.

The subject has a typo. It should be "perf vendor events: Update
graniterapids events and add counter information", not grandridge.

Thanks,
Kan

> 
> Bring in the event updates v1.02:
> https://github.com/intel/perfmon/commit/0ff9f681bd07d0e84026c52f4941d21b1cd4c171
> 
> Add counter information. The most recent RFC patch set using this
> information:
> https://lore.kernel.org/lkml/20240412210756.309828-1-weilin.wang@intel.com/
> 
> There are over 1000 new events.
> 
> Co-authored-by: Weilin Wang <weilin.wang@intel.com>
> Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../arch/x86/graniterapids/cache.json         |  825 ++++
>  .../arch/x86/graniterapids/counter.json       |   77 +
>  .../x86/graniterapids/floating-point.json     |  242 ++
>  .../arch/x86/graniterapids/frontend.json      |  469 ++-
>  .../arch/x86/graniterapids/memory.json        |  175 +-
>  .../arch/x86/graniterapids/other.json         |  150 +-
>  .../arch/x86/graniterapids/pipeline.json      | 1009 ++++-
>  .../arch/x86/graniterapids/uncore-cache.json  | 3674 +++++++++++++++++
>  .../arch/x86/graniterapids/uncore-cxl.json    |   31 +
>  .../graniterapids/uncore-interconnect.json    | 1849 +++++++++
>  .../arch/x86/graniterapids/uncore-io.json     | 1901 +++++++++
>  .../arch/x86/graniterapids/uncore-memory.json |  449 ++
>  .../arch/x86/graniterapids/uncore-power.json  |   11 +
>  .../x86/graniterapids/virtual-memory.json     |  159 +
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
>  15 files changed, 10975 insertions(+), 48 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-cxl.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-power.json

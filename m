Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C5219CC02;
	Thu, 28 Nov 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732802039; cv=none; b=Gkau4rJr5VojOUufU9JXx3FieS7Qt8uw/ayAgKYKQt74TpR6iIqKCmp6x4dqVMXDSvHw1072AgHoGBsWOKPWScjrKdCiQpHX59Y+tB7YJdBz7GI0cN2OtiKthFnbXvNQAwyFc8v+kBBXxbri86a04DAuxnqk2nKbGULgY5XqCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732802039; c=relaxed/simple;
	bh=u8cq6VaEAOfX5CJPIwJdOu2Eb08xtEzuaQwDrTdYXGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uq4+gjzWSiuWH7TJAe1su3hsYYJck8R39uRNisNC3jAbt0m+Yv9nP16kgEFd6aFYTmBH/CKK905xhJ4LCGrtSgm0ewWpF+DsMFrCmcXNWOZPGIGDr/eDjwjy5ratcgS3BeZEO2OM9LyvBeyug1luD8mtp9ak3wuuUlFGzzhd390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A81YnyK4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A81YnyK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732802038; x=1764338038;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=u8cq6VaEAOfX5CJPIwJdOu2Eb08xtEzuaQwDrTdYXGk=;
  b=A81YnyK4Wwc3vyJ86x48+566wuB/1X8HbHtmumDa1y/ygvv11lp719Pw
   hNm7bQ8ue+uZVRXfjZdWH2y5W+nr9haBYX5KOT4hJllfNNQcqhnEBy9yV
   3fN2STEf8J/DgG8bdjSlB8xJYW0ggHylATD+fOnYZjG6xAbuF1RkmHHY3
   EAvGonn7wQheS/uU1TAPmPW905DmdQXLGfSN4c6WbfmN2ZNxqxl3MHnyB
   E5f4ntp9POXQXfgu2nl4/sH7/opA3RQ2ly4FVvXd+tasxssks2LDj1mON
   0pUm2T+l75qS6ZACGnZJ5RZ8IQHmYYomwoLvBmoKNhiusnXU1tlz3iZNn
   Q==;
X-CSE-ConnectionGUID: s61dgJxGQ4SKTXvgws9SCw==
X-CSE-MsgGUID: Df30M++CSSmjCW9qhqy0aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="36965094"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="36965094"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 05:53:58 -0800
X-CSE-ConnectionGUID: phXS6J0hTjqFQZ/45RO+Sg==
X-CSE-MsgGUID: 7S0UJOIbT9aiCfUopCgQ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="96332303"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 05:53:53 -0800
Message-ID: <0aecb442-ede7-44ce-824e-6fc0271207b7@intel.com>
Date: Thu, 28 Nov 2024 15:53:45 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/12] perf record: Add event action support
To: Yang Jihong <yangjihong@bytedance.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, kan.liang@linux.intel.com, james.clark@arm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128133553.823722-1-yangjihong@bytedance.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241128133553.823722-1-yangjihong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/11/24 15:35, Yang Jihong wrote:
> In perf-record, when an event is triggered, default behavior is to
> save sample data to perf.data. Sometimes, we may just want to do
> some lightweight actions, such as printing a log.

Why not just pipe 'perf record' to 'perf script'?

# perf record -e sched:sched_switch | perf script | head
            perf  768231 [000] 2318380.474267: sched:sched_switch: perf:768231 [120] R ==> migration/0:18 [0]
     migration/0      18 [000] 2318380.474294: sched:sched_switch: migration/0:18 [0] S ==> swapper/0:0 [120]
            perf  768231 [001] 2318380.474353: sched:sched_switch: perf:768231 [120] R ==> migration/1:23 [0]
     migration/1      23 [001] 2318380.474382: sched:sched_switch: migration/1:23 [0] S ==> swapper/1:0 [120]
            perf  768231 [002] 2318380.474477: sched:sched_switch: perf:768231 [120] R ==> migration/2:29 [0]
     migration/2      29 [002] 2318380.474503: sched:sched_switch: migration/2:29 [0] S ==> swapper/2:0 [120]
            perf  768231 [003] 2318380.474513: sched:sched_switch: perf:768231 [120] R ==> migration/3:35 [0]
     migration/3      35 [003] 2318380.474523: sched:sched_switch: migration/3:35 [0] S ==> swapper/3:0 [120]
            perf  768231 [004] 2318380.474534: sched:sched_switch: perf:768231 [120] R ==> migration/4:41 [0]
     migration/4      41 [004] 2318380.474541: sched:sched_switch: migration/4:41 [0] S ==> swapper/4:0 [120]

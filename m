Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795050744;
	b=r3lidVNKuqf7Jb3U++MvaUxnoRwQvnRIjfO4julFTyHwz3nFS677pFnQvEgxcfhysqux
	 EYKSlWVSJRsysMdqMa5hyoCVfl3ioi2AVg3U6JQht0vKe3utTj/es1Cu82qizB1XKi3ep
	 oM4fhI/So3Rg3q4KVChNRlkIYsfECCYg0yVT9PSdBUfRbJbpXCowoEGaPwkQgixeNOFsJ
	 QrvVnUvZLFiukR/VFxwOXpS4kr1++BEQd1dhEKqi8Y6F4MQXv4jWX7P9gupK07fhHJvNC
	 nxPpg8OTySj4rRkrfJPms56Mz4VEfCqusGHmtKs1GL3lgnYwz9MKED4tVz3zvTyljww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050744;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FK6VzBl+ofQOPWwLENQ50MyqjZEFYFuge0LYPKK/944=;
	b=OrkkPfe8Bfe7qKsbWUzjx47wg4RIzhGK3bvJq7QKzIsAhDbG7aWDzkR5ZuMHD60qxRfh
	 IRedLBhiRH0QXVhHWafx/l+uVVNxhnwAnhv6d3PH9cZfQSOQB0ilXZabla+cqNzypkZb4
	 oe2YHsJMr9vPISGghYrC4jm6oAOAiyN1QWmG3GlAE9utfbnzShYIg5rxwhqoYOG0dk8mj
	 bTaJ0g1ReYB3LQoX6kyhXImadJ2Ant3fwfWqxaDsTwm0A+31DTHisPIoUe6sWfVH81Fi+
	 Dt+nOatCvAQEaBMGgEhTBKWU44tDFtzirOcHLL+A7DT3vtdsSda2es/GriYBgba8utA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PSAqgZ4H;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F96606A332;
	Thu, 19 Nov 2026 01:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6F96606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PSAqgZ4H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795050744; x=1826586744;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RkDE5FYk3ckqdSoyce7QuO2GOcWUtpi9cUB3Rd1PPzE=;
  b=PSAqgZ4HdyDqPtUtqIcH4bgvkNdCU3hbp1H7drY3Cc6r6YlfkTPdlpzE
   eizPT811T+0/9BBOfoOrTsrtuf6TuK5IPfcd6zDjyyS4UWo7+lrVwASJT
   24uGwQfOK4LV0fnJZsK5RC0WaSaxCi7pA/wRJsA0cg6zFD3bsNRVd+bWo
   i5BTW1sG3JqMcDHjTZKlgmLXqODchAJw1DTxDRxkbfC57RpVoGa1/dZfs
   G8IFIkbFGCGVg5enPvHnRVIq99IyHSCzTr6UvEKO6BPTHQh94oVNiQrUj
   A31ha61StS6uwyBEoGQSMqcVw8JsIlMeNcua9d9rbEMwNpRQwoMRop1ut
   Q==;
X-CSE-ConnectionGUID: hk/GMG17SN+cxVUAQRlvrQ==
X-CSE-MsgGUID: NmQ/YiIoS3mYKl0QsoTfxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3804885"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3804885"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 17:12:23 -0800
X-CSE-ConnectionGUID: xhjgn3mtR46lVeV16Y1Ltw==
X-CSE-MsgGUID: M6ytwln9SJyGPeuTUXwSyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10388910"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 17:12:20 -0800
Message-ID: <02c0499a-c3a0-41e2-a79f-630afe888dc4@linux.intel.com>
Date: Thu, 19 Nov 2026 09:12:17 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] perf vendor events intel: update
To: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 james.clark@linaro.org, thomas.falcon@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261118212655.2262601-1-ctshao@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261118212655.2262601-1-ctshao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tested on DMR, no issue is found. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Tested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 11/19/2026 5:26 AM, Chun-Tse Shao wrote:
> Sync Intel PMU JSON event files with the latest Intel perfmon repository
> (https://github.com/intel/perfmon/commit/1e224c0fd9d9):
> - Add Diamond Rapids (DMR) v1.00 events
> - Update Lunar Lake (LNL) events from v1.26 to v1.27
> - Update Nova Lake (NVL) events from v1.04 to v1.05
>
> Chun-Tse Shao (3):
>   perf vendor events intel: Add diamondrapids v1.00 events
>   perf vendor events intel: Update lunarlake events from 1.26 to 1.27
>   perf vendor events intel: Update novalake events from 1.04 to 1.05
>
>  .../arch/x86/diamondrapids/cache.json         |  952 +++++++++++
>  .../arch/x86/diamondrapids/counter.json       |   52 +
>  .../x86/diamondrapids/floating-point.json     |  419 +++++
>  .../arch/x86/diamondrapids/frontend.json      |  458 ++++++
>  .../arch/x86/diamondrapids/memory.json        |  295 ++++
>  .../arch/x86/diamondrapids/other.json         |  777 +++++++++
>  .../arch/x86/diamondrapids/pipeline.json      | 1423 +++++++++++++++++
>  .../arch/x86/diamondrapids/uncore-cache.json  |  292 ++++
>  .../arch/x86/diamondrapids/uncore-cxl.json    |   22 +
>  .../diamondrapids/uncore-interconnect.json    |  218 +++
>  .../arch/x86/diamondrapids/uncore-io.json     |  386 +++++
>  .../arch/x86/diamondrapids/uncore-memory.json |  939 +++++++++++
>  .../x86/diamondrapids/virtual-memory.json     |  266 +++
>  .../pmu-events/arch/x86/lunarlake/cache.json  |    2 +-
>  .../pmu-events/arch/x86/lunarlake/memory.json |   27 +-
>  .../pmu-events/arch/x86/lunarlake/other.json  |   19 +
>  .../arch/x86/lunarlake/pipeline.json          |   44 +-
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |    5 +-
>  .../pmu-events/arch/x86/novalake/cache.json   |   13 +-
>  .../pmu-events/arch/x86/novalake/counter.json |    5 +
>  .../arch/x86/novalake/floating-point.json     |    4 +-
>  .../pmu-events/arch/x86/novalake/memory.json  |   39 +-
>  .../pmu-events/arch/x86/novalake/other.json   |   84 +
>  .../arch/x86/novalake/pipeline.json           |   75 +
>  .../arch/x86/novalake/uncore-cache.json       |   11 +
>  25 files changed, 6814 insertions(+), 13 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-cxl.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-interconnect.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-io.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/diamondrapids/virtual-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/uncore-cache.json
>

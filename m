Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77E2E65D;
	Mon, 15 Jun 2026 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781487165; cv=none; b=qVWGhBhpTP0srlZ1wcSwLxSx1DbX91APXIT1WrUo9/FVqDo/56yePvwsl53Mj10wCtfr+ouPCgidxNbpwfYNNApbAYAxyKwAnQUX6IaUNpZcBJYtvN2a4ZfH+ZuOBhHwpfDT/kK2SS7eypY1W24N7RIq5osLV4Y6K/2IM6vFnhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781487165; c=relaxed/simple;
	bh=MpYEDOHdbTAI71oTaLKeSfNxXMHemeREX88StmVjphs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y23sZpt1D21tg60nK4fj4kcwNdsiKHJoC5uBCL/8y2lHPS25bPtox4Dj8iqCwmKzoieC7Ka4+JKHq69qV/iYFHW1VupwsCtv1jQBPzpXRMUXvUwEbYWOTx/7mDxDc7elUdWJFSiNxmm+woxo9mE9S3pbwvf6kLbJVdksqFVYNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dD1q/5SI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dD1q/5SI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781487163; x=1813023163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MpYEDOHdbTAI71oTaLKeSfNxXMHemeREX88StmVjphs=;
  b=dD1q/5SIabEfZa4E5If27pwdJU5MhQXGQJ2eOIoorrwjNJmXBNa17Shz
   K864VAv+Jh5O1mvAQlPH7ZkJH/AicClhEYiMANUiJtoC7MVecYCQ3rASM
   sKeZ490+sQVXdM/yUHGFWWAPWieh/TCcmjO1efWCPZyg3fbKmAWeayM2/
   SiDs5qV0c/nu/xIkWCXlJr5gFI12O/sYTCu/EInyDZyfH6O2br8T5TV2C
   aLFO8M818NZ9aPkQB1Yuu8GbScUYT/XR/af2TfYNxbGlakDLAJX3B6ugL
   2fY90o4gIzmSTZcWeNhp9eWC0yf140i/fcTUMTers+YoNEEhQTT0y8XqN
   Q==;
X-CSE-ConnectionGUID: miBYE1/9TMO88aKxMNLKDQ==
X-CSE-MsgGUID: A/6GuZWBTPmWmlSJ3qHUsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="85856948"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="85856948"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:32:43 -0700
X-CSE-ConnectionGUID: Unr3KdDWQH+p0wyNepRQzw==
X-CSE-MsgGUID: xGxiuwS+QnWQXTNPauITRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="271411996"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:32:39 -0700
Message-ID: <0b6d58d5-f802-47dc-ae71-31c45184b738@linux.intel.com>
Date: Mon, 15 Jun 2026 09:32:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] perf vendor events intel: update
To: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de,
 mani@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-actions@lists.infradead.org
References: <20260609215046.2391903-1-ctshao@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260609215046.2391903-1-ctshao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 6/10/2026 5:50 AM, Chun-Tse Shao wrote:
> Sync with the latest perfmon events from:
> https://github.com/intel/perfmon
> by running the script:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> and copying the resulting json and mapfile.csv changes into the perf
> tree.
>
> Chun-Tse Shao (6):
>   perf vendor events intel: Update arrowlake events from 1.17 to 1.19
>   perf vendor events intel: Update emeraldrapids events from 1.23 to
>     1.24
>   perf vendor events intel: Update graniterapids events from 1.18 to
>     1.19
>   perf vendor events intel: Update lunarlake events from 1.22 to 1.25
>   perf vendor events intel: Update pantherlake events from 1.05 to 1.06
>   perf vendor events intel: Update tigerlake events from 1.18 to 1.19
>
>  .../pmu-events/arch/x86/arrowlake/cache.json  |  30 ++-
>  .../arch/x86/arrowlake/floating-point.json    |  45 ++++
>  .../pmu-events/arch/x86/arrowlake/memory.json |  18 ++
>  .../arch/x86/arrowlake/pipeline.json          | 129 +++++++++-
>  .../arch/x86/emeraldrapids/cache.json         |   9 +
>  .../graniterapids/uncore-interconnect.json    |  10 +
>  .../arch/x86/graniterapids/uncore-memory.json |   2 +-
>  .../pmu-events/arch/x86/lunarlake/cache.json  |   2 +-
>  .../arch/x86/lunarlake/pipeline.json          |  27 ++-
>  .../arch/x86/lunarlake/uncore-memory.json     | 208 ++++++++++++++++-
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |  12 +-
>  .../arch/x86/pantherlake/counter.json         |   5 +
>  .../arch/x86/pantherlake/pipeline.json        |  29 ++-
>  .../x86/pantherlake/uncore-interconnect.json  |  10 +
>  .../arch/x86/pantherlake/uncore-memory.json   | 221 +++++++++++++++++-
>  15 files changed, 728 insertions(+), 29 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/uncore-interconnect.json
>

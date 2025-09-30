Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C6E2940D;
	Tue, 30 Sep 2025 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217356; cv=none; b=k+xvs56BJ5Sif4Sa2mfLyoRq7W9EUhzIQ3369epbjhZ3ciQSAuwxW4eGrOB2FZvVdBUATaPHq5IV6v5laGHXWjsSn/JGYg11DKht8M2PVP0sXEPv9LPjNw2rXzZP3F+wl/UxtXpe/JieWVcLqEyYtiEmc3ocGcdN0rqclH8G5GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217356; c=relaxed/simple;
	bh=46YCLTx/FX2549HtH0nhlM0CzLqRzR3LF3K6lFBH8zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpdfnWer1FcF4xyFVbWphWnQ3g3dcdOy5b9n4c5Rmto1ngDeu7RH7hgh89Vi0vncHINkSW+uzws6UYOTCT+mGfhQ3+SDFs6ZQKRvkesokVQi6+qKQys5NbZ/LCgFVl2gOcDOJ972OL15Qr7RHhfT3ZdBqTP1tLC8Qj7vAsCKOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bU6SKo27; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bU6SKo27"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759217354; x=1790753354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=46YCLTx/FX2549HtH0nhlM0CzLqRzR3LF3K6lFBH8zo=;
  b=bU6SKo27BIikv9s8x4O81FoYYZzx5wAd3h7mhB/Dez2ALs74daBa5X6L
   GM5IsX0Agkwu5HRvDZx9XJHm7+w7oezZZtQWRy8MTzm4Rx4Na4yP+mGuO
   RZwOCB5GvyY2gEwZNu3lNeDfDyKlqN7udSSZuL3FfFSDS27i29HHLvnCw
   KTgk8/u7JsZKeXhtjn8OLpFe4/z5+exQUcQFeii8xqfcSg6Q8SmPM55MP
   di7Ep4l1/JizTmmvULiQebhHJc+wbwlpaTj6j1cDNoJVyO50q9mOUlZbw
   bvxLlJL0bZ/8H9gmARAZSHYVCNlol5IMrirUNAN9qXimkAeHeW23ueFjN
   Q==;
X-CSE-ConnectionGUID: t/gMHOubTMeIJRlXinxUuw==
X-CSE-MsgGUID: pJn2Qd60Tsi++b6OJP1bgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65105279"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="65105279"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 00:28:57 -0700
X-CSE-ConnectionGUID: 2O+7BYlQSYqB15SIuiflBw==
X-CSE-MsgGUID: KFlFoovGQaqZyQRftiWdNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="209162659"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 00:28:54 -0700
Message-ID: <ed463cd8-495e-4769-b392-372413ca7db6@linux.intel.com>
Date: Tue, 30 Sep 2025 15:28:50 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v2 0/2] perf record: ratio-to-prev event term for
 auto counter reload
To: Thomas Falcon <thomas.falcon@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>
References: <20250902164047.64261-1-thomas.falcon@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250902164047.64261-1-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/3/2025 12:40 AM, Thomas Falcon wrote:
> The Auto Counter Reload (ACR)[1] feature is used to track the
> relative rates of two or more perf events, only sampling
> when a given threshold is exceeded. This helps reduce overhead
> and unnecessary samples. However, enabling this feature
> currently requires setting two parameters:
>
>  -- Event sampling period ("period")
>  -- acr_mask, which determines which events get reloaded
>     when the sample period is reached.
>
> For example, in the following command:
>
> perf record -e "{cpu_atom/branch-misses,period=200000,\
> acr_mask=0x2/ppu,cpu_atom/branch-instructions,period=1000000,\
> acr_mask=0x3/u}" -- ./mispredict
>
> The goal is to limit event sampling to cases when the
> branch miss rate exceeds 20%. If the branch instructions
> sample period is exceeded first, both events are reloaded.
> If branch misses exceed their threshold first, only the
> second counter is reloaded, and a sample is taken.
>
> To simplify this, provide a new “ratio-to-prev” event term
> that works alongside the period event option or -c option.
> This would allow users to specify the desired relative rate
> between events as a ratio, making configuration more intuitive.
>
> With this enhancement, the equivalent command would be:
>
> perf record -e "{cpu_atom/branch-misses/ppu,\
> cpu_atom/branch-instructions,period=1000000,ratio_to_prev=5/u}" \
> -- ./mispredict

Hi Tom,

Does this "ratio-to-prev" option support 3 and more events in ACR group?

If not, should we consider to support the cases there are 3 and more events
in the ACR group? (If I remember correct, the PMU driver should support it).

e.g.,

perf record -e
"{cpu_atom/branch-misses,period=200000,acr_mask=0x6/p,cpu_atom/branches,period=1000000,acr_mask=0x7/,cpu_atom/branches,period=1000000,acr_mask=0x7/}"
-- sleep 1

Of course, this is just an example that indicates the cases are supported,
it doesn't mean the command is meaningful. But we can't exclude that users
have such real requirements.

If we want to support 3 and more events in ACR group (if not already), we'd
better rename the "ratio-to-prev" option to "ratio-to-head" and only allow
the group leader can be set the sampling period explicitly with "period"
option and the sampling period of all other group members can only be
calculated base on the sampling period of group leader and
the "ratio-to-head", maybe like this.

perf record -e
"{cpu_atom/branch-misses,period=200000/p,cpu_atom/branches,ratio-to-head=5/,cpu_atom/branches,ratio-to-head=5/}"
-- sleep 1

Thanks.


>
> or
>
> perf record -e "{cpu_atom/branch-misses/ppu,\
> cpu_atom/branch-instructions,ratio-to-prev=5/u}" -c 1000000 \
> -- ./mispredict
>
> [1] https://lore.kernel.org/lkml/20250327195217.2683619-1-kan.liang@linux.intel.com/
>
> Changes in v2 (mostly suggested by Ian Rogers):
>
> -- Add documentation explaining acr_mask bitmask used by ACR
> -- Move ACR specific implementation to arch/x86/
> -- Provide test cases for event parsing and perf record tests
>
> Thomas Falcon (2):
>   perf record: Add ratio-to-prev term
>   perf record: add auto counter reload parse and regression tests
>
>  tools/perf/Documentation/intel-acr.txt | 53 ++++++++++++++++++
>  tools/perf/Documentation/perf-list.txt |  2 +
>  tools/perf/arch/x86/util/evsel.c       | 53 ++++++++++++++++++
>  tools/perf/tests/parse-events.c        | 54 ++++++++++++++++++
>  tools/perf/tests/shell/record.sh       | 40 ++++++++++++++
>  tools/perf/util/evsel.c                | 76 ++++++++++++++++++++++++++
>  tools/perf/util/evsel.h                |  1 +
>  tools/perf/util/evsel_config.h         |  1 +
>  tools/perf/util/parse-events.c         | 22 ++++++++
>  tools/perf/util/parse-events.h         |  3 +-
>  tools/perf/util/parse-events.l         |  1 +
>  tools/perf/util/pmu.c                  |  3 +-
>  12 files changed, 307 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/Documentation/intel-acr.txt
>

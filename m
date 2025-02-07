Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3B197A92;
	Fri,  7 Feb 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961055; cv=none; b=JpvBxSuzaLb27dxsf0rpFQF7q8EKYOQjrEMIlSPADzWFJ+B/owMyNzFvVj+5uyLnjZMxIZA1FB2jUniJ6pUoEIHJRIHneDezRIy/b5krKT5ijC0S7wdXwR5kopLe9V+pkCvL+oLYYxpXJWGeQUZnPLGDJSvNn/Hqru2TKAEOTjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961055; c=relaxed/simple;
	bh=VjCQ/dNJzo32/blT7wrbpdnCgdz6nwbeGNYKaHWKkpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KmXFLmQvYX3+4pj3aDDbvrEgUG/EdR9G8Rmvfj3GDOPmW/viQb59O50C4HTRR6Rp67qTKZWsmP0FepMkh7bQ1tfvB1uzT5hyQloYphwlzC+nsAx2RsIuImEj6sAYuA/MQc/qFth/phe9gqPjIAw9sH7g1EIu42GdtMAbkc9tnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gosUNd/s; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gosUNd/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738961053; x=1770497053;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=VjCQ/dNJzo32/blT7wrbpdnCgdz6nwbeGNYKaHWKkpQ=;
  b=gosUNd/suEhUy0JKtyTxoOEvb81/z5qhzo0Ha3yjouAz+tFJUMeNKDY/
   d3FUq+Drir3yFPyTMiiexqtwbEflVeLqy6olCcb0wlTVgUxsESLQQcn+l
   n+2Ajh9MmAX8CX176N67jQ8Qc/oboHo4vjvCefvwUhGmWIbr9sU4N1oif
   jvn8NF0WNn6gkssUyDGnqiz0CrRpxDjdIjw+Q7tnOlMnHD2krvAov1bfB
   d/PEvxA1yem4IuH4845gc9xZdNSrceUXNTjfeargkLb5i9imT1YLubJvW
   Nk/FcoQiqz3UxD2yPvznbfDVcUIumLkcRME4FPb/y2ITiS1Eq1xPvx/uo
   g==;
X-CSE-ConnectionGUID: CWOdrxDQRWqlcfR+Qg0T4g==
X-CSE-MsgGUID: 59xuhKQ2RoKJFA8fsDEluA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39741909"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="39741909"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 12:44:13 -0800
X-CSE-ConnectionGUID: asEEEMBdTL6snNOUTBa72g==
X-CSE-MsgGUID: 3QM6z1AuT46svrxRetQVeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="116631038"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 12:44:12 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2FDB520B5713;
	Fri,  7 Feb 2025 12:44:10 -0800 (PST)
Message-ID: <0990a674-d8ab-4abc-a904-299513773f90@linux.intel.com>
Date: Fri, 7 Feb 2025 15:44:08 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/24] perf vendor events: Add Arrowlake events/metrics
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
References: <20250207185154.824433-1-irogers@google.com>
 <20250207185154.824433-4-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250207185154.824433-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-07 1:51 p.m., Ian Rogers wrote:
> +    {
> +        "BriefDescription": "Percentage of time that the core is stalled due to a TPAUSE or UMWAIT instruction",
> +        "MetricExpr": "100 * cpu_atom@SERIALIZATION.C01_MS_SCB@ / (8 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricName": "tma_info_serialization _%_tpause_cycles",

It doesn't seem a correct MetricName. A convert script bug?

> +        "Unit": "cpu_atom"
> +    },diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/uncore-other.json b/tools/perf/pmu-events/arch/x86/arrowlake/uncore-other.json
> new file mode 100644
> index 000000000000..1ac5b5ef8094
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/arrowlake/uncore-other.json
> @@ -0,0 +1,10 @@
> +[
> +    {
> +        "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles.",
> +        "Counter": "FIXED",
> +        "EventCode": "0xff",
> +        "EventName": "UNC_CLOCK.SOCKET",
> +        "PerPkg": "1",
> +        "Unit": "CLOCK"

On MTL and ARL, the unit should be CNCU.
Thomas will propose a convertor script patch to fix it.

Thanks,
Kan

> +    }
> +]


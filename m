Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B519DF66;
	Thu,  6 Feb 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868389; cv=none; b=MPwhznd4b4Nczpa4u9DJLbav9s8eX6M0QFQ3y4fLtI6u8EbEfZ5cnNI82TXi6N6zDH1ZpgyEcXxhpX78jpLR7uV6Xj7gm8O8KEP3jf/ra3psGOmgl869h1OqJ6tJrc9GDrJgftM4pEMce0KK72Thgi3iX/SPgZ83x7yHp+XcN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868389; c=relaxed/simple;
	bh=XUoNq0FXUpQLQ2UXreYcR91bq5sqBHrEwC5wFxwfVj0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XI9xOQN6iLOKxE8K+1eMHgqv9HHaBDDFEMk5tPFMR3goqQQ3uDbivieYG+CerTfdgvoZOC25t76Re+18mPsE9mrRp4SQTwx51/bfnVQA/QRHcPTNmu2fK7rYo9LogZYO9LYyNzHc28yosjZar/IFyThelINi/TLkVWvnLkGqc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUVc3J7u; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUVc3J7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738868388; x=1770404388;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=XUoNq0FXUpQLQ2UXreYcR91bq5sqBHrEwC5wFxwfVj0=;
  b=UUVc3J7utj8CLZLvkgjNaUAEYhMrcMOc5+6IqB6Df2mkV8mMIeDKMoR1
   cz5OGt9gCLbVi2IYuElmuFlwBJVgs00lSuZYROGeOmiDCEHUwP8obTfZG
   JyCy1LI005GZYamMA5dMtKn0Bqvx+DKS6wN7IKICpw03Wy7Ss5tQtdLNX
   sLauVsx9XXCkqk5m9ivq4FAQdXMQJIz+inFyZBbYD9lEzFhXDkjPAXpDx
   YNY0jnldW7C6MeZMYLXTHhhitDWK0qpJQCNMQg/QAylZxyStTSuhY8xeO
   s9t3mh3Mux2jQz93nUfzTryH7F6LQeOQ6I5qUGWDP+NZ9zuiP9zvY/FFF
   A==;
X-CSE-ConnectionGUID: aGRAra14RdGNKNHumhwqiQ==
X-CSE-MsgGUID: /b59IopUQ+y6ctDRQ5jo2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50129740"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="50129740"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:59:47 -0800
X-CSE-ConnectionGUID: j12Kzmo2TGOCpwuDEeleNg==
X-CSE-MsgGUID: F1pAexndTLq+kibc1GNndA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116235578"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:59:48 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id DCB0120B5713;
	Thu,  6 Feb 2025 10:59:44 -0800 (PST)
Message-ID: <f0eb58c2-afba-4810-96d5-61f1c942ed57@linux.intel.com>
Date: Thu, 6 Feb 2025 13:59:43 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/24] perf vendor events: Update/add Graniterapids
 events/metrics
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>,
 Samantha Alt <samantha.alt@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>,
 Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>
References: <20250205173140.238294-1-irogers@google.com>
 <20250205173140.238294-12-irogers@google.com>
 <7692d2d6-16d5-4f50-8c3a-37f1db356426@linux.intel.com>
 <CAP-5=fU+9MgMbQKpFix+Jw8k+-_yfAs-F+FYE4CmTWxevPmd-A@mail.gmail.com>
 <9fa56c75-2ee6-4901-9e04-0ec23412fd62@linux.intel.com>
 <CAP-5=fWpbXSwZq5biRZ1fjcSJY2DO4g=cv-0K8jZ1Gzv3bOfhA@mail.gmail.com>
 <58e08371-8d43-4f84-baaf-64b0af95c7cb@linux.intel.com>
 <CAP-5=fX+u_Un-WYKA35sc366kniuXFVfRDT+dzWd-axTG5PmpA@mail.gmail.com>
 <51732c12-b5d7-4b81-8ea5-79e87b87795d@linux.intel.com>
 <CAP-5=fWQj01O3WmGLoAf6O_uEeMHpOUqVWvHi3nW_kGj4VtZWg@mail.gmail.com>
 <145ce38d-67c5-47e5-9625-0ae9e9831fd9@linux.intel.com>
Content-Language: en-US
In-Reply-To: <145ce38d-67c5-47e5-9625-0ae9e9831fd9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-06 1:53 p.m., Liang, Kan wrote:
>>> However, when I dump the debug information,
>>> ./perf stat -M tma_frontend_bound -vvv
>>>
>>> I got below debug information. I have no idea where the slot is from.
>>> It seems the perf code mess up the p-core metrics with the e-core
>>> metrics. But why only slot?
>>> It seems a bug of perf tool.
>>>
>>> found event cpu_atom@CPU_CLK_UNHALTED.CORE@
>>> found event cpu_atom@TOPDOWN_FE_BOUND.ALL@
>>> found event slots
>>> Parsing metric events
>>>
>>> '{cpu_atom/CPU_CLK_UNHALTED.CORE,metric-id=cpu_atom!3CPU_CLK_UNHALTED.CORE!3/,cpu_atom/TOPDOWN_FE_BOUND.ALL,metric-id=cpu_atom!3TOPDOWN_FE_BOUND.ALL!3/,slots/metric-id=slots/}:W'
> It because the perf adds "slot" as a tool event for the e-core Topdown
> metrics.
> There is no "slot" event for e-core.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
> tools/perf/util/metricgroup.c#n1481
> 
> I will check why "slot" event is added as a tool event for e-core?
> That doesn't make sense.


BTW: I checked the list of the tool events. Except the slots, others are
all SW (or non-HW) events which should always be available.
Slots is a HW event and only be available for p-core.
It doesn't look like a good fit here.

static const char *const tool_pmu__event_names[TOOL_PMU__EVENT_MAX] = {
	NULL,
	"duration_time",
	"user_time",
	"system_time",
	"has_pmem",
	"num_cores",
	"num_cpus",
	"num_cpus_online",
	"num_dies",
	"num_packages",
	"slots",
	"smt_on",
	"system_tsc_freq",
};

Thanks,
Kan

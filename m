Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2397E78C63;
	Fri, 21 Jun 2024 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000871; cv=none; b=ep2ll6zNNHameNmuUvMrBwQjFsHPDZsqu1P/cHt9vNiSzOU8PaDn8eqG+fctwBEOYQF7MTHwfwRznla3naxhimt1OuBIEcvBQiFZOiOHZvN6UMtQdiwJFFT7Wo5CaLk7iNzT8leMmE0NjJ/6rFTHnEscThCuQS77NuQorNMc0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000871; c=relaxed/simple;
	bh=CrEBsFqVMm42+JY9xcQXYS6fBCPw+k+5ST1yxmLQiNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODBtG/gHIw/z/cWyJ/3Rk3veP65OPVc+HhL36yeRD7CNOR4rY4XQc5qNnSU3kQlKnpd1VK6WvvHXF0urnQLb7+ABw7qMOOpMWH1ekkuLrX1niJTa16zO9GxtvWpl/kPnpO2/Y37kwgKJ70QoG/4NEAwfPAMx0fnavNqnuyPUbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxNmbqoX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxNmbqoX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719000870; x=1750536870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CrEBsFqVMm42+JY9xcQXYS6fBCPw+k+5ST1yxmLQiNs=;
  b=cxNmbqoX2xPw2C5SwbXj+/1nr3CpoZmlL7iN08svkeuqHyIKxZ22TO3W
   zHMln6Ge4OsU2HtzLWWk7FrG4PzbiJKcAUC1RSf+1Y4sVNVWtvpoHbfAz
   P9GALoolsHqCLQa6hD7AaVdJlakszoplqq3ucLgyNc3VLqvZXsRi4+Jo8
   /ackZwmeg5OGWMnX4PT8myAp+21r8JfYNsQlJiBP8HuB6J7jeCQveXfEI
   AprkRWwwXBtPR/kCzuDYJKBkaDy4IUZCrmsqOJSWiXdMPQacexxqBDFWU
   kGdz/8RVnQPDewSlxIABZq3yqn/BfGgVVhWf36iIzYbz8fQxh0iUoqWlq
   A==;
X-CSE-ConnectionGUID: geL13cruRWu0mADGyePt2Q==
X-CSE-MsgGUID: J2DujhSPT3unQN6Vv/2lkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="15745258"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="15745258"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 13:14:29 -0700
X-CSE-ConnectionGUID: fbEeGUa8QDmGB/6fd8ijHw==
X-CSE-MsgGUID: gFDbWNPRR3WaditWG0DnbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="73435098"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 13:14:29 -0700
Received: from [10.212.73.237] (kliang2-mobl1.ccr.corp.intel.com [10.212.73.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B46C020B5703;
	Fri, 21 Jun 2024 13:14:27 -0700 (PDT)
Message-ID: <60882b46-abe6-4225-886f-188bbe406283@linux.intel.com>
Date: Fri, 21 Jun 2024 16:14:26 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] perf tools: Assorted random updates and fixes
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20240621170528.608772-1-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240621170528.608772-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-21 1:05 p.m., Namhyung Kim wrote:
> Hello,
> 
> I found some misc updates and fixes are still remaining.  Just sending out
> together.  Please take a look!
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf report: Fix condition in sort__sym_cmp()
>   perf symbol: Simplify kernel module checking
>   perf tools: Fix a compiler warning of NULL pointer
>   perf mem: Fix a segfault with NULL event->name

Looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> 
>  tools/perf/util/dsos.c       | 3 +++
>  tools/perf/util/mem-events.c | 2 +-
>  tools/perf/util/sort.c       | 2 +-
>  tools/perf/util/symbol.c     | 5 +----
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E902AE69;
	Tue, 10 Sep 2024 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985176; cv=none; b=BUptg55aJrhdVJv/PRuMcSOJeb2daHx4l/0njzkBUamynWoYbKEZNrD9VnXS23YEjgjS2FTujR48WYWrJPlhljqgKPkeItNyqwW/JJT0Q9EUU85Qe+XQ9I5OwtNMVRsg/EJF6F94893Frz6Yub3EHhsyTHZ9rm+/Ib5unFDPl5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985176; c=relaxed/simple;
	bh=8cyHUd99dHnbLKGD//21nviYrE6ra9Tqo3z6HzABt8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1DiTdGq6WJMtRWs9nmO+qrhaM87VTYUj76u5UqxBfiGe/SI8z/aPNBS7BQAsL/mfUJyPWKP2ek0WqwlmV1WpeQSYkQhOE5Kdsi1+b28rcynI+NaAR+wp4zkrb45nlq4OiAEkuX76jDqzgbRGlN/FqQUbDOyHuxwwnNElvpo8A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Srf7ztS+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Srf7ztS+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725985174; x=1757521174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8cyHUd99dHnbLKGD//21nviYrE6ra9Tqo3z6HzABt8E=;
  b=Srf7ztS+Bnw89RCv/f9yUwXDfNW6YIlrkGpEr7bw8KfIqSoq43JKX9CS
   BIlI6uBZ8QJEEW/M4Ym0//Tuyxdy7I82g6NlF3XFaUi8abpn9ii4Zr+mM
   dnrmlgTmmNxwZb1TDr4cPs5fF4MpP8WQDZCId+QvARTU2aq5Ln9IHjkj5
   7BBpGdOrauVMFatgQOuiRcklk7xnuHzP8EMJ7bMZzkWkDoEAO5P2JrC+I
   QvYQcx86mPYFSTrukJRFZFeROHc8JCg2c/9wX8vllLYwDEHRGmeOlpbQw
   zDAyTzZVf+1Zpm5IIouY58jjfZJeXqRWD5HVDSdsICu94mLr5akX2P/Mp
   w==;
X-CSE-ConnectionGUID: O5Fil8+pSEibJ2sscU0f9w==
X-CSE-MsgGUID: WubCZzPAS0i/UFBMMPoR9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35412913"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="35412913"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 09:19:32 -0700
X-CSE-ConnectionGUID: fWmWG3v0QOGJ5rwjEtVgoQ==
X-CSE-MsgGUID: hoOCppemQ4Sr+nxYiV/suA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67100537"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 09:19:31 -0700
Received: from [10.212.67.246] (kliang2-mobl1.ccr.corp.intel.com [10.212.67.246])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E8D3820CFED7;
	Tue, 10 Sep 2024 09:19:27 -0700 (PDT)
Message-ID: <b9441341-42ed-41e5-be38-ac63a9cd88f6@linux.intel.com>
Date: Tue, 10 Sep 2024 12:19:26 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] Event parsing fixes
To: James Clark <james.clark@linaro.org>, irogers@google.com,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, namhyung@kernel.org
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Weilin Wang <weilin.wang@intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Colin Ian King <colin.i.king@gmail.com>,
 Yang Jihong <yangjihong@bytedance.com>, Howard Chu <howardchu95@gmail.com>,
 Ze Gao <zegao2021@gmail.com>, Jing Zhang <renyu.zj@linux.alibaba.com>,
 Sun Haiyong <sunhaiyong@loongson.cn>, Yicong Yang
 <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240910151640.907359-1-james.clark@linaro.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240910151640.907359-1-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-10 11:16 a.m., James Clark wrote:
> I rebased this one and made some other fixes so that I could test it,
> so I thought I'd repost it here in case it's helpful. I also added a
> new test.
> 
> But for the testing it all looks ok.
> 
> There is one small difference where it now hides _all_ default
> <not supported> events, when previously it would only hide some
> selected subset of events like "stalled-cycles-frontend". I think
> this is now more consistent across platforms because, for example,
> Apple M only has cycles and instructions, and the rest of the
> default events would always show as <not supported> there.
> 
> Tested on Raptor Lake, Kaby Lake, Juno, N1, Ampere (with the DSU
> cycles PMU) and I also faked an Apple M on Juno. 
> > Changes since v6:
>   * Fix empty PMU name in perf report
>   * Rebase onto perf-tools-next 003265bb6f02
> 
> Changes since v5:
>   * Test on x86 non hybrid
>   * Assume 1 PMU in the test when no PMUs expose /cpus file
> 
> Changes since v4:
> 
>   * Hide all <not supported> default events when not verbose
>   * Remove previous note about <not supported> behavior from the cover
>     letter and replace it with a new note about the new behavior
>  
> Changes since v3:
> 
>   * Rebase onto perf-tools-next 6236ebe07
>   * Fix Intel TPEBS counting mode test
>   * Fix arm-spe build
>   * Add support for DT devices in stat test
>   * Add a new test for hybrid perf stat default arguments
> 
> Ian Rogers (5):
>   perf evsel: Add alternate_hw_config and use in evsel__match
>   perf stat: Uniquify event name improvements
>   perf stat: Remove evlist__add_default_attrs use strings
>   perf evsel x86: Make evsel__has_perf_metrics work for legacy events
>   perf evsel: Remove pmu_name
> 
> James Clark (2):
>   perf test: Make stat test work on DT devices
>   perf test: Add a test for default perf stat command
> 

Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>  tools/perf/arch/arm64/util/arm-spe.c          |   4 +-
>  tools/perf/arch/x86/util/evlist.c             |  74 +----
>  tools/perf/arch/x86/util/evsel.c              |  35 ++-
>  tools/perf/builtin-diff.c                     |   6 +-
>  tools/perf/builtin-stat.c                     | 291 +++++++-----------
>  tools/perf/tests/parse-events.c               |   2 +-
>  tools/perf/tests/shell/stat.sh                |  37 ++-
>  .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
>  tools/perf/util/evlist.c                      |  46 +--
>  tools/perf/util/evlist.h                      |  12 -
>  tools/perf/util/evsel.c                       |  28 +-
>  tools/perf/util/evsel.h                       |  22 +-
>  tools/perf/util/metricgroup.c                 |   4 +-
>  tools/perf/util/parse-events.c                |  57 ++--
>  tools/perf/util/parse-events.h                |   8 +-
>  tools/perf/util/parse-events.y                |   2 +-
>  tools/perf/util/pmu.c                         |   6 +-
>  tools/perf/util/pmu.h                         |   2 +-
>  tools/perf/util/stat-display.c                | 109 +++++--
>  tools/perf/util/stat-shadow.c                 |  14 +-
>  tools/perf/util/stat.c                        |   2 +-
>  21 files changed, 359 insertions(+), 413 deletions(-)
> 

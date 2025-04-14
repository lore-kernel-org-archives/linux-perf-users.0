Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862BC7E9;
	Mon, 14 Apr 2025 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657692; cv=none; b=K1Z6UOKBll9Umh5pWRTAu1Oo5tkYuYqDxdFghX8aSrsKNCWzWtgCH5nUh4LO9CW8YhVcbpo1hGYTV4jMw8hbzXpAPy6Yrjxw5612esLyyeIr3NUXAG28JzWrWdaNqOaJVjBkkJIMVqWSEpmbigQNOeO3UFW8GBpsIzui7B/XUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657692; c=relaxed/simple;
	bh=346wJkGTLFnMQ6c9hyBWDU32uZ8F5QJqhkAA5EfubMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OiRDtY1GMooM4M+RnOVWWRLDReyaay0x5lpgEAexVsE8drRo/eHTBFDiUwQ2usirjXKRGh6TtxLHnfdkEONi7455N6NrVt/nmsG1xfwx/7wtftFl5b2N2KsFkBFczz8HzQegw29S/P1aANAH/aQ86av2ZwVhkUscpKHsgEM8E/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Omnf3q5l; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Omnf3q5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744657690; x=1776193690;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=346wJkGTLFnMQ6c9hyBWDU32uZ8F5QJqhkAA5EfubMU=;
  b=Omnf3q5lb5SNgq+/vlEBDJ0ibwB69oDFBvGNF9mv8Kp3B3V9dW6ICo76
   2I5Ma4LQ/V2HZnWmpgUF5IrsEucTxvgl+XmYCB62Kl2hu1MGcOl6Y2Sbl
   A2MoUsU1xMeH9EIw+q8iLBYQ8mjmrQg6ptOWDxDiOd0umKiug1g/Ky9j/
   ZB8QyhlWj4wIWk+i9XXzGIZr3Mp2SLKyGAOHxbq6dfQWqfWhTPgkPDwxp
   KcRkTFkG0uRP1Pj66sGRINcJi5brDgG2o8v5KPEMT7l4K3+nOZYVwGqq3
   TcaQvpCcTqvC0/GSZJEGQdwqEnsOlTm73mN9hN8tUliKgt0Nsu6Q93zaR
   w==;
X-CSE-ConnectionGUID: qGxqJ4AOTkCKjYcg0g43Cw==
X-CSE-MsgGUID: RpeZ7x9dQ2aWUmDL+wvNpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46307367"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="46307367"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 12:08:09 -0700
X-CSE-ConnectionGUID: TVmv2tk7QWCjU/9KztJBTQ==
X-CSE-MsgGUID: GVIDmg66S7uDVFzMYMJb/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="135070649"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 12:08:09 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0AFBB20B5736;
	Mon, 14 Apr 2025 12:08:05 -0700 (PDT)
Message-ID: <cfa0aa31-3fe7-4174-8cce-89e8aadbcd07@linux.intel.com>
Date: Mon, 14 Apr 2025 15:08:04 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/16] Intel TPEBS min/max/mean/last support
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang
 <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>
References: <20250414174134.3095492-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-14 1:41 p.m., Ian Rogers wrote:
> The patches add support to computing the min, max, mean or last
> retirement latency and then using that value as the basis for metrics.
> When values aren't available, support is added to use the retirement
> latency as recorded for an event in the perf json.
> 
> Support is added for reading the retirement latency from the forked
> perf command more than once. To avoid killing the process commands are
> sent through the control fd. Some name handling is changed to make it
> more robust.
> 
> Rather than retirement latency events having issues with perf record,
> make it so that the retirement latency modifier enables sample
> weights.
> 
> Note: the retirement latency JSON updates are part of:
> https://lore.kernel.org/lkml/20250328175006.43110-1-irogers@google.com/
> 
> v5: Add Namhyung and Weilin's tags. Fix missing error path mutex
>     unlock spotted by Namhyung.
> 
> v4: Don't use json min/max in retirement latency stats as they will
>     never update afterwards. Warn once if json data is used when TPEBS
>     recording was requested.
> 
> v3: Two fixes from Kan Liang. Ensure min/max statistics don't vary
>     when real samples are encountered.
> 
> v2: Addition of header cleanup patch originally posted:
>     https://lore.kernel.org/lkml/20241210191823.612631-1-irogers@google.com/
>     as there are no arch specific reasons not to build this code.
>     Fix bug in "perf pmu-events: Add retirement latency to JSON events
>     inside of perf" where "t->stats.n != 0" should have been
>     "t->stats.n == 0".
>     Add patch so that perf record of a retirement latency event
>     doesn't crash but instead enables sample weights for the event.
> 
> Ian Rogers (16):
>   perf intel-tpebs: Cleanup header
>   perf intel-tpebs: Simplify tpebs_cmd
>   perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
>   perf intel-tpebs: Separate evsel__tpebs_prepare out of
>     evsel__tpebs_open
>   perf intel-tpebs: Move cpumap_buf out of evsel__tpebs_open
>   perf intel-tpebs: Reduce scope of tpebs_events_size
>   perf intel-tpebs: Inline get_perf_record_args
>   perf intel-tpebs: Ensure events are opened, factor out finding
>   perf intel-tpebs: Refactor tpebs_results list
>   perf intel-tpebs: Add support for updating counts in evsel__tpebs_read
>   perf intel-tpebs: Add mutex for tpebs_results
>   perf intel-tpebs: Don't close record on read
>   perf intel-tpebs: Use stats for retirement latency statistics
>   perf stat: Add mean, min, max and last --tpebs-mode options
>   perf pmu-events: Add retirement latency to JSON events inside of perf
>   perf record: Retirement latency cleanup in evsel__config
>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan


>  tools/perf/Documentation/perf-stat.txt   |   7 +
>  tools/perf/builtin-stat.c                |  29 +-
>  tools/perf/pmu-events/empty-pmu-events.c | 216 +++----
>  tools/perf/pmu-events/jevents.py         |   6 +
>  tools/perf/pmu-events/pmu-events.h       |   3 +
>  tools/perf/util/Build                    |   2 +-
>  tools/perf/util/evlist.c                 |   1 -
>  tools/perf/util/evsel.c                  |  22 +-
>  tools/perf/util/evsel.h                  |   6 +
>  tools/perf/util/intel-tpebs.c            | 682 ++++++++++++++---------
>  tools/perf/util/intel-tpebs.h            |  40 +-
>  tools/perf/util/parse-events.c           |   4 +
>  tools/perf/util/pmu.c                    |  52 +-
>  tools/perf/util/pmu.h                    |   3 +
>  14 files changed, 666 insertions(+), 407 deletions(-)
> 


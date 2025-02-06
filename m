Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76391A23A8;
	Thu,  6 Feb 2025 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866648; cv=none; b=LKvUf1AQ41U1+wTcKPp04j0BUkKrPLUEPj/XUJf19veyT62nMTzU31m9JWiE1cAsEb0NolcONqJlszBghkjWY/Y7gIA68xK/wDYfJKmHqb7Li0JxEduAIwik/szRLx+V5i4u8JTvxFMNOgR8KbyB+HUYWKfAvm/6SZZ18JsD39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866648; c=relaxed/simple;
	bh=W37gjZs+MxawhXaaJ7d9hAleIryWG96BRnEP1Ati5aE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S9RU9eE3XfsUd5/0qH7ikKoFTVekMz+oSdb9YCVTjmCjnS90umdBXL9xQsuL+3MEDAeRtqCA2t+QgziQPa7bjOUlcucKhsUPLygEiGwp0A6Z8zVSGQKQgIPWaH8mZYJgWqoHf0TR3brjsMy47evlUZTElyMWFuKNQGALzOpidoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bG7XElMm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bG7XElMm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738866647; x=1770402647;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=W37gjZs+MxawhXaaJ7d9hAleIryWG96BRnEP1Ati5aE=;
  b=bG7XElMm7hEuFNcHrw3273vRi5GrSt6sRspheO5gdUVu7vBYnQXHBtLD
   21hLOWm7ZzFTe+mtQwDPXmpvemrfzRZ6VxjGDq2MgMNEgRproCySFxDSC
   DpzVo6mRXnx5pN5dZ2GGNPnJn6pw24MhVmWsjAHJ6RFKy2zrBePtWAd22
   wwwh1WMd5bJhF7wLY1Hp0PRe2svmrg7HtGQOwROyz8dUhm6SdVPqPFNgC
   SJfNaJdMSoCdNdZ2rYHHpZg7oQYoOVj5fnXjF7Y9dyRk3yFalvFrzZ/TD
   1G6Gr4yWXLsgvJ0QheIup5Qou6IlP60iWfAAXXqDOK0UI2H1ugjfUxXkN
   w==;
X-CSE-ConnectionGUID: k2a+PgYqQKePC+KdDKsy3A==
X-CSE-MsgGUID: HpFoCPXNShGXf9p+/AwMOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43148940"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="43148940"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:30:38 -0800
X-CSE-ConnectionGUID: VQsEHjhBTqy2QLrIOgOtMw==
X-CSE-MsgGUID: xvzSPsyUR4GrtIxcssSA4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116231174"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa003.jf.intel.com with ESMTP; 06 Feb 2025 10:30:38 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id ECE60301B19; Thu, 06 Feb 2025 10:30:37 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: namhyung@kernel.org,  irogers@google.com,
  linux-perf-users@vger.kernel.org,  linux-kernel@vger.kernel.org,  Arnaldo
 Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 0/8] perf report: Add latency and parallelism profiling
In-Reply-To: <cover.1738772628.git.dvyukov@google.com> (Dmitry Vyukov's
	message of "Wed, 5 Feb 2025 17:27:39 +0100")
References: <cover.1738772628.git.dvyukov@google.com>
Date: Thu, 06 Feb 2025 10:30:37 -0800
Message-ID: <87ldujkjsi.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Vyukov <dvyukov@google.com> writes:

> There are two notions of time: wall-clock time and CPU time.
> For a single-threaded program, or a program running on a single-core
> machine, these notions are the same. However, for a multi-threaded/
> multi-process program running on a multi-core machine, these notions are
> significantly different. Each second of wall-clock time we have
> number-of-cores seconds of CPU time.

I'm curious how does this interact with the time / --time-quantum sort key?

I assume it just works, but might be worth checking.

It was intended to address some of these issues too.

> Optimizing CPU overhead is useful to improve 'throughput', while
> optimizing wall-clock overhead is useful to improve 'latency'.
> These profiles are complementary and are not interchangeable.
> Examples of where latency profile is needed:
>  - optimzing build latency
>  - optimizing server request latency
>  - optimizing ML training/inference latency
>  - optimizing running time of any command line program
>
> CPU profile is useless for these use cases at best (if a user understands
> the difference), or misleading at worst (if a user tries to use a wrong
> profile for a job).

I would agree in the general case, but not if the time sort key
is chosen with a suitable quantum. You can see how the parallelism
changes over time then which is often a good enough proxy. 


> We still default to the CPU profile, so it's up to users to learn
> about the second profiling mode and use it when appropriate.

You should add it to tips.txt then

>  .../callchain-overhead-calculation.txt        |   5 +-
>  .../cpu-and-latency-overheads.txt             |  85 ++++++++++++++
>  tools/perf/Documentation/perf-record.txt      |   4 +
>  tools/perf/Documentation/perf-report.txt      |  54 ++++++---
>  tools/perf/Documentation/tips.txt             |   3 +
>  tools/perf/builtin-record.c                   |  20 ++++
>  tools/perf/builtin-report.c                   |  39 +++++++
>  tools/perf/ui/browsers/hists.c                |  27 +++--
>  tools/perf/ui/hist.c                          | 104 ++++++++++++------
>  tools/perf/util/addr_location.c               |   1 +
>  tools/perf/util/addr_location.h               |   7 +-
>  tools/perf/util/event.c                       |  11 ++
>  tools/perf/util/events_stats.h                |   2 +
>  tools/perf/util/hist.c                        |  90 ++++++++++++---
>  tools/perf/util/hist.h                        |  32 +++++-
>  tools/perf/util/machine.c                     |   7 ++
>  tools/perf/util/machine.h                     |   6 +
>  tools/perf/util/sample.h                      |   2 +-
>  tools/perf/util/session.c                     |  12 ++
>  tools/perf/util/session.h                     |   1 +
>  tools/perf/util/sort.c                        |  69 +++++++++++-
>  tools/perf/util/sort.h                        |   3 +-
>  tools/perf/util/symbol.c                      |  34 ++++++
>  tools/perf/util/symbol_conf.h                 |   8 +-

We traditionally didn't do it, but in general test coverage
of perf report is too low, so I would recommend to add some simple
test case in the perf test scripts.

-Andi

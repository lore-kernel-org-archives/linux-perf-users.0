Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD8D38E8B0;
	Wed, 13 May 2026 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683032; cv=none; b=r3yAxVvapnbPduzRxOH5rMIbcCWVdqdQ1dE3YbJ7Na9HPR3tg1nzhq3/e05tllLW33n4mT0Fw6AsS0qGW8RLxOHUEyqDVGT04N3D7LUbQLOG4AMHpY49NoKjGsdbJIQqfIFw3v8NBfBGH+Eyn8H+SwbAqXrisa9sSlb/niw2xdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683032; c=relaxed/simple;
	bh=J+n7v0QR4/x13Wopvn7Queb5CLvSpXBbB1ibP6nkqKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHXDiXcGbIZSkWkuQp/e06FN3si30isfz6wSriAkWAmsW/i4u4ozPdc13gY3mcKvoyocuhDLMimbsQFz8bKcF9lBHcKqKXq07UKf8sV7WW5kIg3Cs5hYBlIUg9xALsEw8NunQboVcZWaFMri0dDwU1xhtlSDUWMkqCfV6Hs6bs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JJRtObgF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JJRtObgF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CCEB1477;
	Wed, 13 May 2026 07:37:03 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC7AD3F7B4;
	Wed, 13 May 2026 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778683028; bh=J+n7v0QR4/x13Wopvn7Queb5CLvSpXBbB1ibP6nkqKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJRtObgFAdOEqMFeBoOqJ2CxS0VrCMk91W/B6OTGQ0VzemydIM8Rjw7+5F2rwtEGn
	 Xz+kNQmgTsihZdC5G3Dz0VycUBLR2amS+HZtdAQRTyZqINi3W/bl3j34rQ3YGEX/am
	 3v9VIkEN8rkSxu47njSOIBvPuIHYPqCvdZDo1qSw=
Date: Wed, 13 May 2026 15:37:05 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf pmu: Skip test on Arm64 when #slots is zero
Message-ID: <20260513143705.GG34802@e132581.arm.com>
References: <20260410-perf_fix_pmu_metrics_test-v2-1-61826ab3ca8b@arm.com>
 <CAP-5=fWEU5qqTHjisUyDJMQQB5yFibyogMwAerTs5VUF0OSPHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWEU5qqTHjisUyDJMQQB5yFibyogMwAerTs5VUF0OSPHA@mail.gmail.com>

On Wed, May 13, 2026 at 06:10:00AM -0700, Ian Rogers wrote:

[...]

> We get this failure for these metrics on x86 when building perf with
> JEVENTS_ARCH=all. Rather than expecting the parse failure perhaps we
> should just always return true in tool_pmu__read_event:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/tool_pmu.c#n421

I considered returning true when slots == 0 so can mute parser error
and allow the test to pass. However, if so platforms which do not
support #slots would be able to use those metrics and generate
meaningless statistics.

I would keep the parser errors so this is a reminding when users wrongly
use unsupported metrics.

> I guess the problem there is that when these metrics are broken (no
> slots value) you can't distinguish this case from other valid cases.

IMO, this is a test design issue: tests should validate metrics while
remaining hardware-agnostic. Hardware-specific cases should either run
only on supported platforms, or the tests should be refined to run
transparently across different hardware.

> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for review!

Leo

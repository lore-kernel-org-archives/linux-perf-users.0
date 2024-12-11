Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F329824634B;
	Wed, 11 Dec 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937528; cv=none; b=qitHC3OhAKp6P7yLu7yNuC+ljHoHQ+/JuT/gpc73qbyGAtYaqorHJzMtrJHTZx4qtPPmYCxkmaMmJuGbq1MFn/r0qDezAXBtQHNLJuugd4/YSW7EFMXbemLQZCPR0AOFJdSvQzEWnkA780AYAP1hfvklF5xp0Lk1SrgJoLJOQ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937528; c=relaxed/simple;
	bh=linuuN8BXJlE/EXoqlW3B6ptqsh7UsVYafQI7hPFUsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK1uMihatWH4nATg8Bcd4bWbR7S2/mReocQZ8hJmhOH5IzZkoQ3MlqLAXCENtAz8W+lwc/V1j69tm3rkKP4K13JkvLVK6Zbp0aGvw6XgqIh9s7+XjyqWNJXJR7rugrDtuXyivvePqeKfkgUyH6O7cEQLFSLUNOvlZk/0EKsdtOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R83O9+jr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R83O9+jr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDACBC4CED2;
	Wed, 11 Dec 2024 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733937527;
	bh=linuuN8BXJlE/EXoqlW3B6ptqsh7UsVYafQI7hPFUsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R83O9+jrtpLXOYakowOwcayidf3lxLLUbaEbi5g6JNmFesGszE7MbaHhnZrzIzWHS
	 f6ATiR4gKT2xNhL4xtTU9pyHyPIxYrr2I7c6+uApfntzvpzBZUKMBoZIB9jfwPXk9U
	 J+yf6pwNTCNiY3hW8rtyQH0z8mvKw26nCZ4JqmT5h0Uunk1oSbcwVTofPUOXSbr4yH
	 xz+ay7f3ffULBszqvuTp5ApH5EHIt0L1HhK59thphOEd1DZzZlt9pGdL5VLf+V52XK
	 RbcsDsuN+xtYkOt9Sp052GQ2EPu0EBpPglL8Fm/sx5ZKP/4p/WAYTaFlrl9Fnq62FO
	 lfQ9Nj5RLKLlw==
Date: Wed, 11 Dec 2024 09:18:45 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
	Dima Kogan <dima@secretsauce.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf probe: Fix uninitialized variable
Message-ID: <Z1nJdd3YF5YGvlqp@google.com>
References: <20241211085525.519458-1-james.clark@linaro.org>
 <20241211085525.519458-2-james.clark@linaro.org>
 <Z1mQcsDCw0d8djjx@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1mQcsDCw0d8djjx@x1>

Hello,

On Wed, Dec 11, 2024 at 10:15:30AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Dec 11, 2024 at 08:55:23AM +0000, James Clark wrote:
> > Since the linked fixes: commit, err is returned uninitialized due to the
> > removal of "return 0". Initialize err to fix it.
> > 
> > This fixes the following intermittent test failure on release builds:
> > 
> >  $ perf test "testsuite_probe"
> >  ...
> >  -- [ FAIL ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar (output regexp parsing)
> >  Regexp not found: \"Error: switch .+ cannot be used with switch .+\"
> >  ...
> 
> So Namhyung, this one should go to perf-tools, I can pick the second on
> perf-tools-next, so that we keep perf-tools as small as possible.

Sure, will replace and force-push.

Thanks,
Namhyung


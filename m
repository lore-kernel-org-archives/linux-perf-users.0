Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8AF480946;
	Thu,  4 Jun 2026 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584011; cv=none; b=jhYpfMH/0rJRlEv4TR0Ahlg+sYdDOhsl1UdYPm0pmAaw2HFd5GjoTlJRYsJbd/tFbp2sgxdiNk8Xr9Q7rBo7iHUSe84G/O8FjYmSE3eGBoCUjdwldV32qf/H+UfTtEIepBnio7uLRP2LhctE4gkOg+Cr6WjN5ecDm18A/F74XR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584011; c=relaxed/simple;
	bh=rvL2t+Q2hRoz7rx0pY6q3kwvu1ujB1XZ5xnexmSjIy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4PIvWkvOxY0uubMzfQr+q9hGJg67CLSwjAi55F/aRfBUbAVRlonz3K9g6+g8G2qeEMaAzl9CuA5jyt8qKdsJenTTdY+/JvtwCX4BlIaFa1zbew8BZJG6Gjw7n8lJK7ewK+O2dcS8klyRj17wPsP0QXtmZMWqver/zPTlBiutY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxvIAHCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxvIAHCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF171F00893;
	Thu,  4 Jun 2026 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584010;
	bh=Fy6ENsUGKVNjmabTyaPHPNhoW3b14bbEdhjK/wRUPfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OxvIAHCQORpDyhYZfTunZMpNRvxvPz1ffy7aMzTYEYnLyiqi1h5e2fidKoV7H9ePo
	 DBx3c+gPhlfD2wMlwYIeBTJE4YzEHUO8/45JCqh8JWLtk3lOUBBL9ZZ6ZYWoQhdGvB
	 15IljjTCNv+Ny84S1zVd6Hf4LvONiDBBHA9fsEaX9HWHMlgbvLFw6h2msDqxvKcsNn
	 dKYuWYpRNkvWuk691tFl5c3NiHPTDUmdeGTeAx8uSV26sVSIcaRF/yA3IMcNroLUXO
	 IG+K0bK+xU3ZHKinA+ucxPI8i0Gk/rx8w4wIBrEYsdPwlTccSkRDmRtJ3EPr6V3KaH
	 UfSRtQMXWFLUw==
Date: Thu, 4 Jun 2026 11:40:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH v8 10/18] perf test: Add summary reporting
Message-ID: <aiGOR2Vv6zUxP381@x1>
References: <20260602073132.2653307-1-irogers@google.com>
 <20260602174129.3192312-1-irogers@google.com>
 <20260602174129.3192312-11-irogers@google.com>
 <aiGOAqGhE7utmNX4@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiGOAqGhE7utmNX4@x1>

On Thu, Jun 04, 2026 at 11:39:01AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Jun 02, 2026 at 10:41:21AM -0700, Ian Rogers wrote:
> > Currently, when running test suites (perf test), users must scroll
> > through hundreds of lines of console output to manually tally the
> > number of passed, skipped, or failed test cases.
> > 
> > Introduce an automated, global execution summary printed at the
> > absolute tail of the test run:
> > 1. Track counts mid-flight inside the print_test_result() accumulator,
> >    clearly separating pass counts into standalone main tests vs.
> >    individual subtests (where num_test_cases > 1).
> > 2. Accumulate the precise descriptions of all failed test cases
> >    directly into a global string buffer, formatted with their suite
> >    indices (e.g., 3.1: Parse event definition strings) for effortless
> >    cross-referencing.
> > 3. Define a summary printer function print_tests_summary() that
> >    emits a colored outline of the final pass, skip, and fail totals,
> >    followed by the explicit list of failed tests.
> > 4. Invoke the summary printer right before freeing the test array at
> >    the absolute tail of __cmd_test(), guaranteeing that the summary is
> >    successfully printed even if an internal emergency signal cleanup
> >    occurs or if the user interrupts the run early.
> > 
> > Example output:
> > ```
> > $ sudo perf test -v
> >   1: vmlinux symtab matches kallsyms                                 : Skip
> >   2: Detect openat syscall event                                     : Ok
> >   3: Detect openat syscall event on all cpus                         : Ok
> > ...
> > 163: perf trace summary                                              : Ok
> > 
> > === Test Summary ===
> > Passed main tests : 123
> > Passed subtests   : 145
> > Skipped tests     : 22
> > Failed tests      : 6
> > List of failed tests:
> >    92: perf kvm tests
> >    95: kernel lock contention analysis test
> >   120: perf metrics value validation
> >   124: Check branch stack sampling
> >   143: perftool-testsuite_probe
> >   158: test Intel TPEBS counting mode
> > ```
> 
> This is a great feature, thanks for working on it!
> 
> I'm merging the series now.

And since I have 'perf test python' in my perf tools build alias, I got
my first summary straight away:

make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
102: 'import perf' in python                                                                                   : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
⬢ [acme@toolbx perf-tools-next]$
acme@number:~/git/perf-tools-next$

:-)

- Arnaldo

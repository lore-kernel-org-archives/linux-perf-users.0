Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ED3360EFB;
	Thu,  4 Jun 2026 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583942; cv=none; b=Fkd0G//WPSks1EfY+9gIppkt2c8OpKoTsN/2NFT/hsyCPMRtl1dONT9o/Vh8C7UrR/Ud9/30J169+qYPERxbD4p/+ygasJ9WsG0qgZCjdlZzCDy23uWyR6RHdcqWV8+CecwuG7e+pL8XRPwWAdo15dLSFnhdDlfoHC4eKYMgmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583942; c=relaxed/simple;
	bh=HyCtyCBFaYzcz9Socqda7UNXGozA2X3oqTR/KIId7EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkPVDrdT32uzWJTFn7lVY9iRn0UakohYpVjV2SDzfzAcDWX/nooPqYqMgc1WWEkYkPIY4iGvlXlnlnxU1I0gID9d+3Q2uM+tE53vIVQZn19rch7VNL7469mECopE3Ag4bWucmDbyHXAvkgU8N153NuLWy/SvfEidBhTF4wUgFmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB1uiTzz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB1uiTzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98001F00893;
	Thu,  4 Jun 2026 14:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780583941;
	bh=12N1CbgAr0VSaqwGYMeW3ZXpLZVNALsAOflN+CBVtFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RB1uiTzzN0L24W3b+ACX1aSwa80HM65HqwQHiQt0x5qk0u8V0Z1MW1BfK6624tUcf
	 tOX8xH4MPANdikDsNvkoPKkBhEkcxgYJYRUjpAnjQNXY3zNX46ct4xxY0RngOd30ru
	 2m+iLfGaMQ7Xx40u6bmOJpzquQOuZK2SyyeFWswf7jvzttwMe8WNbqyGJ4GEnJ7BId
	 NsXX/AzZ/cpVqNK6vaP1q6oj3KNuaD3THhAYgGuRBpnClP4FX8Z+ZrYdIK/qwyay3t
	 c28/BH6xISOwnXP4LqgGG/JNlRJ9p14hJgENSXGAGlqANu5O8WvoHtfPv89dbvx1JG
	 Y7m3qDlv0SDaw==
Date: Thu, 4 Jun 2026 11:38:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH v8 10/18] perf test: Add summary reporting
Message-ID: <aiGOAqGhE7utmNX4@x1>
References: <20260602073132.2653307-1-irogers@google.com>
 <20260602174129.3192312-1-irogers@google.com>
 <20260602174129.3192312-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602174129.3192312-11-irogers@google.com>

On Tue, Jun 02, 2026 at 10:41:21AM -0700, Ian Rogers wrote:
> Currently, when running test suites (perf test), users must scroll
> through hundreds of lines of console output to manually tally the
> number of passed, skipped, or failed test cases.
> 
> Introduce an automated, global execution summary printed at the
> absolute tail of the test run:
> 1. Track counts mid-flight inside the print_test_result() accumulator,
>    clearly separating pass counts into standalone main tests vs.
>    individual subtests (where num_test_cases > 1).
> 2. Accumulate the precise descriptions of all failed test cases
>    directly into a global string buffer, formatted with their suite
>    indices (e.g., 3.1: Parse event definition strings) for effortless
>    cross-referencing.
> 3. Define a summary printer function print_tests_summary() that
>    emits a colored outline of the final pass, skip, and fail totals,
>    followed by the explicit list of failed tests.
> 4. Invoke the summary printer right before freeing the test array at
>    the absolute tail of __cmd_test(), guaranteeing that the summary is
>    successfully printed even if an internal emergency signal cleanup
>    occurs or if the user interrupts the run early.
> 
> Example output:
> ```
> $ sudo perf test -v
>   1: vmlinux symtab matches kallsyms                                 : Skip
>   2: Detect openat syscall event                                     : Ok
>   3: Detect openat syscall event on all cpus                         : Ok
> ...
> 163: perf trace summary                                              : Ok
> 
> === Test Summary ===
> Passed main tests : 123
> Passed subtests   : 145
> Skipped tests     : 22
> Failed tests      : 6
> List of failed tests:
>    92: perf kvm tests
>    95: kernel lock contention analysis test
>   120: perf metrics value validation
>   124: Check branch stack sampling
>   143: perftool-testsuite_probe
>   158: test Intel TPEBS counting mode
> ```

This is a great feature, thanks for working on it!

I'm merging the series now.

- Arnaldo

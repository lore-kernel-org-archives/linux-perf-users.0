Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63C240230
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781858; cv=none; b=Giu1c71R6ZOSZETqJ0tcJEccQT52qw6D+Pz7BOpWM+f0dB286i/LOTsJVUtlkMKpBvmHw0xAbyN3Dp4Lo2cFNVG8gBNKGD/HGXytju2nPHG5/N5duOGJ0PPn+ne7ipznxs9Iffs5Kp3McrCWvCA/Fte0sa1KrIM6QrbpUqlu+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781858; c=relaxed/simple;
	bh=Mqoqiavy5RlgkF9NNNbW2qAoJS5R8ybeSusDyq1HaG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jI43b2kiM372I/ZEt9i5biaGahQxg7UXNj7okArQ+P/umKK0jLJ8UVlAWojvv1d2BqZy+3/hgNUNyoQD/uDijYe8pz4kXICtGIqwKnM7SGoxE6IFDZMhm77t9k1rkOciFF5ofznLRcgceoEoaWHyIFB2xwLnGeo1GLlBYp5Jyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkPTw10f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkPTw10f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EC0C4CED6;
	Mon, 13 Jan 2025 15:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736781858;
	bh=Mqoqiavy5RlgkF9NNNbW2qAoJS5R8ybeSusDyq1HaG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkPTw10ft82D/RiXCjByd1tY2xaFlh8i1u70UXcLkNG/67m7YBcBlX3n8NDTQ+puu
	 5lu146NVy3MZVs42j5cEaHik9h8tP3coqf8qxlu6N8RzSNalQnhIsEcBQODz0YavXI
	 nIowsBfHOETEQN3RebMkSdR2oBmccNoAHrAN878qcluDgU2k0g8Usr4UyfWcM9Wp3k
	 ndFSFnEq2XTTXqMm+/Hr0rnqfNdnwOrLnFiM7iZtpmxrzWDKUo/nVK6/2Zdk61n9lF
	 uyaiEYbBAcuDZzQiwMZCBILjqfraXADHMSkRFbhG4KxHJ8TC2C7YfhssoYfg4QqqTD
	 13ggwVqD/qv1g==
Date: Mon, 13 Jan 2025 12:24:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
	mpetlan@redhat.com, irogers@google.com
Subject: Re: [PATCH 00/10] Introduce structure for shell tests
Message-ID: <Z4UwHy-Kj9XDI9cf@x1>
References: <20241220220334.69198-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220220334.69198-1-vmolnaro@redhat.com>

On Fri, Dec 20, 2024 at 11:03:24PM +0100, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Hello,
> 
> Sending the third patchset from perftool-testsuite upstreaming effort,
> which also contains new possibilities for shell tests, such as a two-level
> structured test hierarchy, a setup file for the test suite and ability to
> store logs.
> 
> The patches do not add any new test cases but instead provide the needed
> environment that was temporarily replaced by the perftool test drivers.
> 
> We wanted to provide the possibility to have a shell test consisting 
> of multiple subtests, as is already done for the C tests. The logical 
> structuring of the test cases was a part of the perftool test suite,
> and we saw this as an opportunity to introduce a structured approach for 
> the perf shell tests.
> 
> A directory in the shell directory will be represented as a test suite 
> if it contains at least one executable shell test. In case of two and 
> more tests, the subtests are are visibly differentiated from the test 
> suite by having a subtest index. All deeper levels of subdirectories 
> are still searched for tests but do not create additional levels of 
> hierarchy.
> 
> Some test suites require setup to be done before they are run, such 
> recording samples or setting up test probes. This can be done by 
> adding a "setup.sh" executable file in the test suite directory, which 
> will be run before all of the tests. If the setup fails, all of 
> the tests are skipped, as it is assumed that the setup is required 
> for their execution. The setup file also gives us the possibility to 
> name the test suite. If there is no setup file, the name is derived 
> from the name of the directory.
> 
> Lastly, we wanted to provide a way to store the test logs after execution 
> for debugging purposes, if necessary. The test logs for perftool tests 
> are stored in a '/tmp/perf_test_*' temporary directory. By default,
> these logs are cleared after the test finishes. However, if the env
> variable PERFTEST_KEEP_LOGS is set to "y", the test logs are retained
> for debugging.
> 
> For now, all of the perftool tests are marked as exclusive, preventing 
> from running parallel. This may change in the future if we ensure that 
> they will not interfere with other tests being run simultaneously.

I tried to apply it now to perf-tools-next and didn't manage to :-\

Can you take a look please? I was going to test it.

- Arnaldo
 
> Thoughts and ideas are welcome.
> 
> Thanks and regards,
> 
> Veronika
> 
> Michael Petlan (1):
>   perf testsuite: Fix perf-report tests installation
> 
> Veronika Molnarova (9):
>   perf test perftool_testsuite: Add missing description
>   perf test perftool_testsuite: Return correct value for skipping
>   perf test perftool_testsuite: Use absolute paths
>   perf tests: Create a structure for shell tests
>   perf test: Provide setup for the shell test suite
>   perftool-testsuite: Add empty setup for base_probe
>   perf test: Introduce storing logs for shell tests
>   perf test: Format log directories for shell tests
>   perf test: Remove perftool drivers
> 
>  tools/perf/Makefile.perf                      |   3 +-
>  tools/perf/tests/builtin-test.c               | 151 +++++++++-
>  tools/perf/tests/shell/base_probe/setup.sh    |  13 +
>  .../base_probe/test_adding_blacklisted.sh     |  17 +-
>  .../shell/base_probe/test_adding_kernel.sh    |  57 ++--
>  .../perf/tests/shell/base_probe/test_basic.sh |  23 +-
>  .../shell/base_probe/test_invalid_options.sh  |  15 +-
>  .../shell/base_probe/test_line_semantics.sh   |  11 +-
>  tools/perf/tests/shell/base_report/setup.sh   |   8 +-
>  .../tests/shell/base_report/test_basic.sh     |  49 ++--
>  tools/perf/tests/shell/common/init.sh         |   6 +-
>  .../tests/shell/perftool-testsuite_probe.sh   |  23 --
>  .../tests/shell/perftool-testsuite_report.sh  |  23 --
>  tools/perf/tests/tests-scripts.c              | 258 +++++++++++++++---
>  tools/perf/tests/tests-scripts.h              |  15 +
>  tools/perf/tests/tests.h                      |   8 +-
>  16 files changed, 489 insertions(+), 191 deletions(-)
>  create mode 100755 tools/perf/tests/shell/base_probe/setup.sh
>  delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
>  delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh
> 
> -- 
> 2.43.0

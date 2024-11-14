Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E3C262A3;
	Thu, 14 Nov 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605872; cv=none; b=Hz+KlmVOcH3hZGnRZ9Ue+2dbsI+3jQhlcKvL0OUswhAWSLY9d9XOcObNTpZGHn+i0lt1lrlBhhFEFjwxrxkQABxXJ7klhfwZAiOKSm+T6Gu8uR1fpOmFICkXsyOS4brdFZnADo4P1NCTXvJrnhXSrRiIPQeB8vmucVZJ/fboRS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605872; c=relaxed/simple;
	bh=nHqkn9rS6E8aBB1UDCP9+/7t8mwF55M9pcIYHwzPAUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7ZIo+j7f6roYnEBGMeaxvWgaFTjQ1iGIVpJsz8cF6X8MWGeNbQeUmXeDubb4JjAUzVQS5U7hZE/YJ+gn5ayWeFyI1P6GEt2095Q7vHtv3K8mHGwo+KcvuUX3ulpoDcmv1SrHrC2l09xiM0RPXzETm0sJObip44KOnpvPJosxyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCqPVwyF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCqPVwyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD37C4CECD;
	Thu, 14 Nov 2024 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731605871;
	bh=nHqkn9rS6E8aBB1UDCP9+/7t8mwF55M9pcIYHwzPAUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uCqPVwyF42KJvLd9Q3G1dS1h65c8sjcbHnTN05uEortvnQCMDtOC4meOF60zvxwIr
	 iIjR4AVjV+jUSft1AK7MNay8peJPomI8nqpmT+d0guL+PS391c0d2p6CS8BG7cY2uA
	 sxoAOcio933DvfBs5sub0GATengqFncNqc10ekpOmw0zQOTPABw+v11x6J7iKfepk6
	 GyMsCgdpQqbcRRLpjo+esYrH+cSFjUIzEi14Shm3R62S0f3+JIRwTgbSwhkyeAuscy
	 G+DRQ298VIq08ojYgPRUlvulBV1Qw6mzQEu8Qj4vsVc7lAUq45wxNU+1bxtDypQPxF
	 wwgA/x/Jpb4Ig==
Date: Thu, 14 Nov 2024 14:37:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Benjamin Peterson <benjamin@engflow.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] perf tests: add test for trace output loss
Message-ID: <ZzY1bPtoyRH-nRIV@x1>
References: <20241106234518.115234-1-benjamin@engflow.com>
 <20241106234518.115234-2-benjamin@engflow.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106234518.115234-2-benjamin@engflow.com>

On Wed, Nov 06, 2024 at 11:45:18PM +0000, Benjamin Peterson wrote:
> Add a test that checks that trace output is not lost to races. This is
> accomplished by tracing the exit_group syscall of "true" multiple times and
> checking for correct output.
> 
> Conveniently, this test also serves as a regression test for 5fb8e56542a3 ("perf
> trace: avoid garbage when not printing a trace event's arguments") because
> exit_group triggers the previously buggy printing behavior.
> 
> Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> ---
>  tools/perf/tests/shell/trace_exit_race.sh | 31 +++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100755 tools/perf/tests/shell/trace_exit_race.sh
> 
> diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
> new file mode 100755
> index 000000000000..8b70324bc5b4
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_exit_race.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +# perf trace exit race
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Check that the last events of a perf trace'd subprocess are not
> +# lost. Specifically, trace the exiting syscall of "true" 100 times and ensure
> +# the output contains 100 correct lines.
> +
> +# shellcheck source=lib/probe.sh
> +. "$(dirname $0)"/lib/probe.sh
> +
> +skip_if_no_perf_trace || exit 2
> +
> +trace_shutdown_race() {
> +	for i in $(seq 100); do
> +		perf trace -e syscalls:sys_enter_exit_group true 2>>$file
> +	done
> +	[ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$" $file) = "100" ]
> +}
> +
> +
> +file=$(mktemp /tmp/temporary_file.XXXXX)
> +
> +# Do not use whatever ~/.perfconfig file, it may change the output
> +# via trace.{show_timestamp,show_prefix,etc}
> +export PERF_CONFIG=/dev/null
> +
> +trace_shutdown_race
> +err=$?
> +rm -f ${file}
> +exit $err
> -- 

Its failing with shellcheck, I'm trying to fix it:

  CC      /tmp/build/perf-tools-next/builtin-trace.o
  TEST    /tmp/build/perf-tools-next/tests/shell/trace_exit_race.sh.shellcheck_log

In tests/shell/trace_exit_race.sh line 15:
	for i in $(seq 100); do
        ^-^ SC2034 (warning): i appears unused. Verify use (or export if used externally).


In tests/shell/trace_exit_race.sh line 18:
	[ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$" $file) = "100" ]
          ^-- SC2046 (warning): Quote this to prevent word splitting.

For more information:
  https://www.shellcheck.net/wiki/SC2034 -- i appears unused. Verify use (or ...
  https://www.shellcheck.net/wiki/SC2046 -- Quote this to prevent word splitt...
make[4]: *** [tests/Build:91: /tmp/build/perf-tools-next/tests/shell/trace_exit_race.sh.shellcheck_log] Error 1
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:158: tests] Error 2
make[2]: *** [Makefile.perf:777: /tmp/build/perf-tools-next/perf-test-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....


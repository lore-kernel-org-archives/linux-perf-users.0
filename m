Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577C523C8B6;
	Wed, 12 Mar 2025 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776898; cv=none; b=gwvT2M190o3sr6wAP4Ut7Jv7xTr4CRx/Kw3823FABgjn3xdtDF9oAv4Unv63BgeeOjWGzs9YFAKkHwjMzZRSEXiLw5Y9NLDBEUhZ8sYtYGTMOWJIo6INb6xSOBbHAm/4fg4A7VfBcOTxvg9w8DQ3AOhSk26R+2aZWgXqW6SELg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776898; c=relaxed/simple;
	bh=+jF4gN3BFEFncSl2pP+PxFQOLnvIuk2cYjlidEck+/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIJeZHnH/kJoPUJHRGjLJ7Fj+5up9/AfVpvCA/hOi3hT47eOty9LuwU0I+Tp1REErHQE8v+YFzIvcLpGWG9noDEG22l5pXy9aqyHJw8/o7IfO/WkaDUiTclYezuqadEe0qz+Z8uu7F0i8SRNlauBrRbJgO8TkKZwBXcxDK1Zi6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 305BD1515;
	Wed, 12 Mar 2025 03:55:06 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 054553F694;
	Wed, 12 Mar 2025 03:54:54 -0700 (PDT)
Date: Wed, 12 Mar 2025 10:54:50 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	German Gomez <german.gomez@arm.com>
Subject: Re: [PATCH v1] perf tests: Harden branch stack sampling test
Message-ID: <20250312105450.GN9682@e132581.arm.com>
References: <20250312055846.671522-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312055846.671522-1-irogers@google.com>

Hi Ian,

On Tue, Mar 11, 2025 at 10:58:46PM -0700, Ian Rogers wrote:
> On continuous testing the perf script output can be empty, or nearly
> empty, causing tr/grep to exit and due to "set -e" the test traps and
> fails. Add some empty file handling that sets the test to skip and
> make grep and other text rewriting failures non-fatal by adding
> "|| true".
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/test_brstack.sh | 79 +++++++++++++++++++-------
>  1 file changed, 59 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> index e01df7581393..6f5ae227b3e8 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  # Check branch stack sampling
>  
>  # SPDX-License-Identifier: GPL-2.0
> @@ -17,35 +17,54 @@ fi
>  
>  skip_test_missing_symbol brstack_bench
>  
> +set -x
> +err=0
>  TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
>  TESTPROG="perf test -w brstack"
>  
>  cleanup() {
>  	rm -rf $TMPDIR
> +	trap - EXIT TERM INT
>  }
>  
> -trap cleanup EXIT TERM INT
> +trap_cleanup() {
> +	set +e
> +	echo "Unexpected signal in ${FUNCNAME[1]}"
> +	cleanup
> +	exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
>  
>  test_user_branches() {
>  	echo "Testing user branch stack sampling"
>  
> -	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
> -	perf script -i $TMPDIR/perf.data --fields brstacksym | tr -s ' ' '\n' > $TMPDIR/perf.script
> +	perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u -- ${TESTPROG} > "$TMPDIR/record.txt" 2>&1
> +	perf script -i "$TMPDIR/perf.data" --fields brstacksym > "$TMPDIR/perf.script"
>  
>  	# example of branch entries:
>  	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
>  
> -	set -x
> -	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"	$TMPDIR/perf.script
> -	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
> -	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
> -	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
> -	grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"		$TMPDIR/perf.script
> -	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"	$TMPDIR/perf.script
> -	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"	$TMPDIR/perf.script
> -	grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"		$TMPDIR/perf.script
> -	set +x
> -
> +	expected=(
> +		"^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"
> +		"^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
> +		"^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$"
> +		"^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
> +		"^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"
> +		"^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"
> +		"^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"
> +		"^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"
> +	)
> +	for x in "${expected[@]}"
> +	do
> +		if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$x"
> +		then
> +			echo "Branches missing $x"
> +			if [ "x$err" == "x0" ]
> +			then
> +				err=2

Here it sets "err=2", as a result, if any grep command fails, the script
exits while reporting to skip the test.  This seems incorrect to me.

My understanding is the regular expressions above are mandatory to be
matched, otherwise, it must be something is wrong.  We should not skip
the test in this case.

I can understand that 'perf record' cannot record all branch types, if
this is the case, maybe we can improve the recording quality rather
than reporting skip?  E.g.,

  cat <<EOF > "$TMPDIR/loop.sh"
  for run in {1..5}; do perf test -w brstack; done
  EOF

  perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u
    -- sh $TMPDIR/loop.sh

If we run the test for 5 times, should this can allow us to ensure the
branch samples are recorded?

> +			fi
> +		fi
> +	done
>  	# some branch types are still not being tested:
>  	# IND COND_CALL COND_RET SYSCALL SYSRET IRQ SERROR NO_TX
>  }
> @@ -57,14 +76,31 @@ test_filter() {
>  	test_filter_expect=$2
>  
>  	echo "Testing branch stack filtering permutation ($test_filter_filter,$test_filter_expect)"
> -
> -	perf record -o $TMPDIR/perf.data --branch-filter $test_filter_filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
> -	perf script -i $TMPDIR/perf.data --fields brstack | tr -s ' ' '\n' | grep '.' > $TMPDIR/perf.script
> +	perf record -o "$TMPDIR/perf.data" --branch-filter "$test_filter_filter,save_type,u" -- ${TESTPROG}  > "$TMPDIR/record.txt" 2>&1
> +	perf script -i "$TMPDIR/perf.data" --fields brstack > "$TMPDIR/perf.script"
>  
>  	# fail if we find any branch type that doesn't match any of the expected ones
>  	# also consider UNKNOWN branch types (-)
> -	if grep -E -vm1 "^[^ ]*/($test_filter_expect|-|( *))/.*$" $TMPDIR/perf.script; then
> -		return 1
> +	if [ ! -s "$TMPDIR/perf.script" ]
> +	then
> +		echo "Empty script output"
> +		if [ "x$err" == "x0" ]
> +		then
> +			err=2
> +		fi
> +		return
> +	fi
> +        # Look for lines not matching test_filter_expect ignoring issues caused
> +        # by empty output
> +	tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep '.' | \
> +          grep -E -vm1 "^[^ ]*/($test_filter_expect|-|( *))/.*$" \
> +          > "$TMPDIR/perf.script-filtered" || true
> +	if [ -s "$TMPDIR/perf.script-filtered" ]
> +	then
> +		echo "Unexpected branch filter in script output"
> +		cat "$TMPDIR/perf.script"
> +		err=1
> +		return
>  	fi
>  }
>  
> @@ -80,3 +116,6 @@ test_filter "any_ret"	"RET|COND_RET|SYSRET|ERET"
>  test_filter "call,cond"		"CALL|SYSCALL|COND"
>  test_filter "any_call,cond"		"CALL|IND_CALL|COND_CALL|IRQ|SYSCALL|COND"
>  test_filter "cond,any_call,any_ret"	"COND|CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|RET|COND_RET|SYSRET|ERET"
> +
> +cleanup
> +exit $err
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog
> 
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2256525742B;
	Mon, 12 May 2025 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072561; cv=none; b=VW1CSTUiqYhtBZsuvS1LwJgsXhfZeYMygpmJHAUNfXJZomYMhz4k83UF9f7AFHH5fGwGv9xQ7tVeM5nUFL96S4ID0uVQMB5TNYCRpkbLhoKKwd0NpX19p5orZGBN1vEVOCOCkUlNgl/SqV7OU3eMYn+gg4QVs9cm5nX0ji9qOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072561; c=relaxed/simple;
	bh=7PNc2HdbCkpyHnT6/nPDH6L5Zch1/Jzmc+ZEuFMaWqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE61FUtb80NOdXQeHgdCxGP2PqcGhGV0iKUof5RMpKnINMAJKp+8t8VBprRCIcmN3nQoYEfooWuiOR0vReukTvuIS3CSiVAgyu2qwoZxHpkBhznw4r5iMbYizFqD1nDSwtOvbZmUU9YnHQ6q6fl19QeDLLv700KUJBMVO4opTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i40gCx0L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i40gCx0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803C3C4CEE9;
	Mon, 12 May 2025 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747072560;
	bh=7PNc2HdbCkpyHnT6/nPDH6L5Zch1/Jzmc+ZEuFMaWqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i40gCx0LcEJb+P73g0+7K1tMG9pLAg0KHSjnruQrNC8JF1iDFRFk4YdlNRUI6uCr+
	 G/Rn9G1/BZJ6yTJjXCazhowFyxoXooVmqBpLcahC39Iolmyoct5JMfVK+fn07ML52z
	 WAx5TnvCGx1Sc7bAiGEZcXh/ZCRW0uU3yAZnZI+zdxhicTFFZEQA9Q/G5ObDuPUDZ+
	 v/LyZnYvfFdMJPUKn6cNuoZr/bJBBTTteITj9cfNBpDGJSX8fgD0AiL2xF4h+3TKQS
	 IzQF1Y3Rf0/VEjBqN53KqPchgyY1AoDSAC61t/0K1NQIzhQF8rWDDg2iuAa/vmZO+S
	 eW8ZqCQcvLFlg==
Date: Mon, 12 May 2025 14:55:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v3] perf tests: Harden branch stack sampling test
Message-ID: <aCI2LnmPgauls0BN@x1>
References: <20250318161639.34446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318161639.34446-1-irogers@google.com>

On Tue, Mar 18, 2025 at 09:16:39AM -0700, Ian Rogers wrote:
> On continuous testing the perf script output can be empty, or nearly
> empty, causing tr/grep to exit and due to "set -e" the test traps and
> fails. Add some empty file handling that sets the test to skip and
> make grep and other text rewriting failures non-fatal by adding
> "|| true".
> 
> Signed-off-by: Ian Rogers <irogers@google.com>


Thanks, applied to perf-tools-next,

- Arnaldo

> ---
> v3: Drop set -x
> v2: Change skips to errors Leo Yan.
> ---
>  tools/perf/tests/shell/test_brstack.sh | 72 +++++++++++++++++++-------
>  1 file changed, 52 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> index e01df7581393..9138fa83bf36 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  # Check branch stack sampling
>  
>  # SPDX-License-Identifier: GPL-2.0
> @@ -17,35 +17,50 @@ fi
>  
>  skip_test_missing_symbol brstack_bench
>  
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
> +			err=1
> +		fi
> +	done
>  	# some branch types are still not being tested:
>  	# IND COND_CALL COND_RET SYSCALL SYSRET IRQ SERROR NO_TX
>  }
> @@ -57,14 +72,28 @@ test_filter() {
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
> +		err=1
> +		return
> +	fi
> +	# Look for lines not matching test_filter_expect ignoring issues caused
> +	# by empty output
> +	tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep '.' | \
> +	  grep -E -vm1 "^[^ ]*/($test_filter_expect|-|( *))/.*$" \
> +	  > "$TMPDIR/perf.script-filtered" || true
> +	if [ -s "$TMPDIR/perf.script-filtered" ]
> +	then
> +		echo "Unexpected branch filter in script output"
> +		cat "$TMPDIR/perf.script"
> +		err=1
> +		return
>  	fi
>  }
>  
> @@ -80,3 +109,6 @@ test_filter "any_ret"	"RET|COND_RET|SYSRET|ERET"
>  test_filter "call,cond"		"CALL|SYSCALL|COND"
>  test_filter "any_call,cond"		"CALL|IND_CALL|COND_CALL|IRQ|SYSCALL|COND"
>  test_filter "cond,any_call,any_ret"	"COND|CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|RET|COND_RET|SYSRET|ERET"
> +
> +cleanup
> +exit $err
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 

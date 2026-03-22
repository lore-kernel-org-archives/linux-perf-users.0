Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AADF28642B;
	Sun, 22 Mar 2026 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774217113; cv=none; b=sL9bggFt/jKUc3kMUroJ8jW1TG626pv7X+n7S/BnEGoxj/kBKUDuwgrU1Fkc8eMNUIrdtMGR/dCr+0FaSUa/cwPRuur8pAyoNyMY5/0oOzlaMMizaXN/SMXnyE+Zu9NtSZcijg0ooypl06Jm2nyimnTIb70YYsqruQA196NIJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774217113; c=relaxed/simple;
	bh=7GbE9c8ySUNS66hmeHrJN3+mT2jLGMkAQsvSx+zrKEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4YGffrUKbdsCqhKDKPRq2Rr5HOkvfdCfVTw2nCMQRT/zxPgho4xW5kac3JKFKSIrUm0/hT5schQ9NAxE1zlDe4ZPOdauKGdtVQSf60mCDiAkvp3lhASgFvs+Z+I+KlfrF3plxe1Qf2e4lwzm/KXh7uta1ftAyTNvcpw5XGIJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOxfrAbU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOxfrAbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B0DC19424;
	Sun, 22 Mar 2026 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774217113;
	bh=7GbE9c8ySUNS66hmeHrJN3+mT2jLGMkAQsvSx+zrKEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qOxfrAbUPljR3M03l14qQAnEPEH2Hxj2bcqt7jMt7O5p+qPpxuW6T9c0HAEem6fu4
	 XAjAbNSjzWVPhBCXLptowYb+U/aI8Xn+bYPHCkMiSBPDSqyF3IrVZG2Eflo4t1EbCy
	 Bbm2F+klNvxC2xp+mZ0YGXSFYiRXqSkiyER6F+IY3oOBIIYHfxepxqKRYrJPCzV1t7
	 aIsN6q8ojfBC/nmn7s/EqXLzdU4GOhFfiHzPDRuxAV+Mdah0doSW1z8/OIlYrFYrmV
	 ScgBTxSkkli9nJyTN3ZfKUgBVaokKQtAsruiOjeoR66zPY8/g2Rkj9P60zBeVrELJ9
	 xe0XlbAmr3ZlA==
Date: Sun, 22 Mar 2026 19:05:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf test: Fix perf stat --bpf-counters on hybrid
 machines
Message-ID: <acBnlSMHS9oe8yFR@x1>
References: <20260319064513.9269-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319064513.9269-1-namhyung@kernel.org>

On Wed, Mar 18, 2026 at 11:45:13PM -0700, Namhyung Kim wrote:
> The test constantly fails on my Intel hybrid machine.  The issue was it
> has two events in the output even if I only gave it one event.
> 
>   $ perf stat -e instructions -- perf test -w sqrtloop
> 
>    Performance counter stats for 'perf test -w sqrtloop':
> 
>          910,856,421      cpu_atom/instructions/                (28.05%)
>       14,852,865,997      cpu_core/instructions/                (96.79%)
> 
>          1.014313341 seconds time elapsed
> 
>          1.004114000 seconds user
>          0.008174000 seconds sys
> 
> Let's modify the awk script to add the values for each line and print
> the total.  The variable 'i' has a number of input lines that have valid
> output and variable 'c' has the sum of actual counter values.  That way
> it should work on any platforms.

Still doesn't pass reliably for me, only once it did work:

⬢ [acme@toolbx perf-tools]$ git log --oneline -1
38415985abcdb64d (HEAD -> perf-tools, number/perf-tools, number/HEAD) perf test: Fix perf stat --bpf-counters on hybrid machines
⬢ [acme@toolbx perf-tools]$
logout
acme@x1:~/git/perf-tools$
acme@x1:~/git/perf-tools$
acme@x1:~/git/perf-tools$ sudo su -
root@x1:~# perf -v
perf version 7.0.rc4.g38415985abcd
root@x1:~# perf test 152
152: perf stat --bpf-counters test                                   : FAILED!
root@x1:~# set -o vi
root@x1:~# perf test -v 152
152: perf stat --bpf-counters test                                   : Ok
root@x1:~# perf test -v 152
--- start ---
test child forked, pid 1829364
Testing --bpf-counters The difference between 21947395146 and 16947118203 are greater than 20%.
---- end(-1) ----
152: perf stat --bpf-counters test                                   : FAILED!
root@x1:~# perf test -v 152
--- start ---
test child forked, pid 1829401
Testing --bpf-counters [Success]
Testing bpf event modifier The difference between 22461906845 and 17190344465 are greater than 20%.
---- end(-1) ----
152: perf stat --bpf-counters test                                   : FAILED!
root@x1:~# perf test -v 152
--- start ---
test child forked, pid 1829445
Testing --bpf-counters The difference between 24210793380 and 16852007232 are greater than 20%.
---- end(-1) ----
152: perf stat --bpf-counters test                                   : FAILED!
root@x1:~# perf test -v 152
--- start ---
test child forked, pid 1829481
Testing --bpf-counters The difference between 24293201069 and 17225814972 are greater than 20%.
---- end(-1) ----
152: perf stat --bpf-counters test                                   : FAILED!
root@x1:~# grep -m1 "model name" /proc/cpuinfo
model name	: 13th Gen Intel(R) Core(TM) i7-1365U
root@x1:~#

acme@x1:~/git/perf-tools$ uname -a
Linux x1 6.17.12-300.fc43.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Dec 13 05:06:24 UTC 2025 x86_64 GNU/Linux
acme@x1:~/git/perf-tools$ 
 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v3) make sure to print numbers w/o thousand separators.
> v2) handle '<not counted>' and '<not supported>'.
> 
>  tools/perf/tests/shell/stat_bpf_counters.sh | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
> index f43e28a136d3c9bc..35463358b273ce1c 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -41,8 +41,14 @@ check_counts()
>  test_bpf_counters()
>  {
>  	printf "Testing --bpf-counters "
> -	base_instructions=$(perf stat --no-big-num -e instructions -- $workload 2>&1 | awk '/instructions/ {print $1}')
> -	bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions -- $workload  2>&1 | awk '/instructions/ {print $1}')
> +	base_instructions=$(perf stat --no-big-num -e instructions -- $workload 2>&1 | \
> +				awk -v i=0 -v c=0 '/instructions/ { \
> +					if ($1 != "<not") { i++; c += $1 } \
> +				} END { if (i > 0) printf "%.0f", c; else print "<not" }')
> +	bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions -- $workload  2>&1 | \
> +				awk -v i=0 -v c=0 '/instructions/ { \
> +					if ($1 != "<not") { i++; c += $1 } \
> +				} END { if (i > 0) printf "%.0f", c; else print "<not" }')
>  	check_counts $base_instructions $bpf_instructions
>  	compare_number $base_instructions $bpf_instructions
>  	echo "[Success]"
> @@ -52,8 +58,14 @@ test_bpf_modifier()
>  {
>  	printf "Testing bpf event modifier "
>  	stat_output=$(perf stat --no-big-num -e instructions/name=base_instructions/,instructions/name=bpf_instructions/b -- $workload 2>&1)
> -	base_instructions=$(echo "$stat_output"| awk '/base_instructions/ {print $1}')
> -	bpf_instructions=$(echo "$stat_output"| awk '/bpf_instructions/ {print $1}')
> +	base_instructions=$(echo "$stat_output"| \
> +				awk -v i=0 -v c=0 '/base_instructions/ { \
> +					if ($1 != "<not") { i++; c += $1 } \
> +				} END { if (i > 0) printf "%.0f", c; else print "<not" }')
> +	bpf_instructions=$(echo "$stat_output"| \
> +				awk -v i=0 -v c=0 '/bpf_instructions/ { \
> +					if ($1 != "<not") { i++; c += $1 } \
> +				} END { if (i > 0) printf "%.0f", c; else print "<not" }')
>  	check_counts $base_instructions $bpf_instructions
>  	compare_number $base_instructions $bpf_instructions
>  	echo "[Success]"
> -- 
> 2.53.0

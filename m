Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E815B971;
	Sun, 18 May 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747589817; cv=none; b=EzNiA8X7bu0/adJ0hmXKBlZNMC7T1+eXq+7wK2LQ8Fc5xJ5xwuRu0zrLHpoSZiCbFJhA2vD/2Lxf1GAl5tVM93gr/wwJnAHmhUTA92i1VwtLFUwl4kEfpGC7pHTvWlV3kjIsjGollNoe6XyfHfu9NEmxZXZir1X4NAdfE9JmqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747589817; c=relaxed/simple;
	bh=qO52H0fsR4aRohAdm3P77B/RedYm7B+ayCGLW/gsMbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDvwCATOcga74l4rP/cHdC0e3Zrw5X+Ea24sIvuGE621YXy0zt5lObKegv81y3zLRSEc2gcmFaCORUTU7yGeU4beBZpvQRMHaoZz1HVIeEB3W7BhfOkpR0hZGUP6MbShhYBUPaZBpiJyYQDnK098HzJGC9Pf10rN/V1kPJ8bXoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4u/0Pvj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4u/0Pvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B98C4CEE9;
	Sun, 18 May 2025 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747589816;
	bh=qO52H0fsR4aRohAdm3P77B/RedYm7B+ayCGLW/gsMbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4u/0Pvjq88DjWo0ksK8MpqcBUqVc3Q0alyNP2vqCnw312KN/+4d4LfjN/BuxIlL1
	 zNSA0qRMB2XocXLHldhJe+on/CKocG34zQM/Wf+WMUKcY2n+DsN8m6Dwy/T2Atq0I4
	 VVqXjEvaRA6gv9kLzjti1gOWtfm0Y6/F/X2tNpp2vooLj564ssXd2KqfI2TIOGyc2G
	 EdWj1x1gJl69vhuk6gp85/U1t5EKBiiYfRP76pZIF8Ok1Wn8WeHcQ5btsu9rcvaDm2
	 QyTKfdJIId09jVAz46IDrD1JDaZBT1Ne/RwaT7jz05wrKx/kO11Vs1SilCurIE3Sxm
	 BvKDFGBqQ03RQ==
Date: Sun, 18 May 2025 10:36:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] perf test trace: Remove set -e and print trace
 test's error messages
Message-ID: <aCoatnYe6z61xdcb@google.com>
References: <20250517163230.1237469-1-howardchu95@gmail.com>
 <20250517163230.1237469-3-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250517163230.1237469-3-howardchu95@gmail.com>

Hi Howard,

On Sat, May 17, 2025 at 09:32:27AM -0700, Howard Chu wrote:
> Currently perf test utilizes the set -e option in shell that exit
> immediately if a command exits with a non-zero status, this prevents
> further error handling and introduces ambiguity. This patch removes set
> -e and prints the error message after invoking perf trace during perf
> tests.

I think it's fine to exits with non-zero inside 'if' statements.  But
it won't work if you want to move it out of the 'if' statements.  I'm
not sure how it'd work in a subshll for the assignment.  But it'd be ok
to remove 'set -e' anyway since the test checks the result manually.

Thanks,
Namhyung

> 
> In my case, the command that exits with a non-zero status is perf
> trace instead of grep, because it can't find the 'timer:hrtimer_setup'
> tracepoint, see below.
> 
> Before:
>     $ sudo /tmp/perf test enum -vv
>     107: perf trace enum augmentation tests:
>     107: perf trace enum augmentation tests                              : Running
>     --- start ---
>     test child forked, pid 783533
>     Checking if vmlinux exists
>     Tracing syscall landlock_add_rule
>     Tracing non-syscall tracepoint syscall
>     ---- end(-1) ----
>     107: perf trace enum augmentation tests                              : FAILED!
> 
> After:
>     $ sudo /tmp/perf test enum -vv
>     107: perf trace enum augmentation tests:
>     107: perf trace enum augmentation tests                              : Running
>     --- start ---
>     test child forked, pid 851658
>     Checking if vmlinux exists
>     Tracing syscall landlock_add_rule
>     Tracing non-syscall tracepoint timer:hrtimer_setup,timer:hrtimer_start
>     [tracepoint failure] Failed to trace tracepoint timer:hrtimer_setup,timer:hrtimer_start, output:
>     event syntax error: 'timer:hrtimer_setup,timer:hrtimer_start'
> 			 \___ unknown tracepoint
> 
>     Error:  File /sys/kernel/tracing//events/timer/hrtimer_setup not found.
>     Hint:   Perhaps this kernel misses some CONFIG_ setting to enable this feature?.
> 
>     Run 'perf list' for a list of valid events
> 
>      Usage: perf trace [<options>] [<command>]
> 	or: perf trace [<options>] -- <command> [<options>]
> 	or: perf trace record [<options>] [<command>]
> 	or: perf trace record [<options>] -- <command> [<options>]
> 
> 	-e, --event <event>   event/syscall selector. use 'perf list' to list available events---- end(-1) ----
>     107: perf trace enum augmentation tests                              : FAILED!
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/tests/shell/trace_btf_enum.sh | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
> index b3775209a0b1..cd4c8754f5d4 100755
> --- a/tools/perf/tests/shell/trace_btf_enum.sh
> +++ b/tools/perf/tests/shell/trace_btf_enum.sh
> @@ -3,7 +3,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  err=0
> -set -e
>  
>  syscall="landlock_add_rule"
>  non_syscall="timer:hrtimer_setup,timer:hrtimer_start"
> @@ -34,22 +33,24 @@ trace_landlock() {
>      return
>    fi
>  
> -  if perf trace -e $syscall $TESTPROG 2>&1 | \
> -     grep -q -E ".*landlock_add_rule\(ruleset_fd: 11, rule_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags: 45\) = -1.*"
> +  output="$(perf trace -e $syscall $TESTPROG 2>&1)"
> +  if echo "$output" | grep -q -E ".*landlock_add_rule\(ruleset_fd: 11, rule_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags: 45\) = -1.*"
>    then
>      err=0
>    else
> +	printf "[syscall failure] Failed to trace syscall $syscall, output:\n$output"
>      err=1
>    fi
>  }
>  
>  trace_non_syscall() {
> -  echo "Tracing non-syscall tracepoint ${non-syscall}"
> -  if perf trace -e $non_syscall --max-events=1 2>&1 | \
> -     grep -q -E '.*timer:hrtimer_.*\(.*mode: HRTIMER_MODE_.*\)$'
> +  echo "Tracing non-syscall tracepoint ${non_syscall}"
> +  output="$(perf trace -e $non_syscall --max-events=1 2>&1)"
> +  if echo "$output" | grep -q -E '.*timer:hrtimer_.*\(.*mode: HRTIMER_MODE_.*\)$'
>    then
>      err=0
>    else
> +	printf "[tracepoint failure] Failed to trace tracepoint $non_syscall, output:\n$output"
>      err=1
>    fi
>  }
> -- 
> 2.45.2
> 

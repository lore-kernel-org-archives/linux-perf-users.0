Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5318A6B3;
	Thu,  8 Aug 2024 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122088; cv=none; b=K+B6hfHkFyQO64lHnL0eF/gcG4TNeqtaBwenkznzTd9Ar+daNdOHloVetFJmv7iX5DTyW30uIkC2P93UA/sjGXTo2WnxwSEmAn6cm9xnl10+PUgybCrdHh7GgJdaRgkvSvlNXlfMT4QWy51XvQnfDwAEa/mU67QNJPIjrh6C+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122088; c=relaxed/simple;
	bh=T4RdaDLDFwBenuUKBcPyXWxSawbxj6a3jc5VnVJcxCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrJqLpWZapiPfjCQUorywN6raUX2wkfBl/0owCZcccy/svQzVKZain1MDM9A5ctT52kOhq4NwIdufWT2UE9vYa557QJ3K/uLzF6GjWFF9v5gcs5YIiZuzYDC9Ca8BDQfU0+5xzTQena2H2bkW5nHXhPYwSNPFtxGGaZAMCL8jNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAEIB9GZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAEIB9GZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5523C32782;
	Thu,  8 Aug 2024 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723122087;
	bh=T4RdaDLDFwBenuUKBcPyXWxSawbxj6a3jc5VnVJcxCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nAEIB9GZu5oEqYVhpiqpwjrH0SKc/tI1lqfWlF2PpGwHstQDzgz/qc7Xd5Yy1g5gO
	 2HxTHOISWYBf7UxxHeoSIgFJ9Oyhenpd+T1//+d9gE9qt1S7QkwncpmL9wfBij+e4W
	 svH9yOjwKVIxQtpsqTJ+KTZdF6VEJ/H4C+p6mUhwJNdCFkTg3PNXOSwsNdwwe5wfkD
	 7SF5rl06emxK4rssCKuZBPDIsSm7Pa9cVNnJdpOo1/vvgJHJ5/thAJ1j2t1CyTsPLi
	 mhO5D4P7LGwH8hOgpjexngGNEF6fc5eWOgUc6/8By2WDv10Kucixt0KZNsb5C+kKGh
	 rkcRjUPKBDD4A==
Date: Thu, 8 Aug 2024 10:01:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] perf test: Add a new shell test for perf ftrace
Message-ID: <ZrTBo7KACZeuCyLj@x1>
References: <20240808044954.1775333-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808044954.1775333-1-namhyung@kernel.org>

On Wed, Aug 07, 2024 at 09:49:54PM -0700, Namhyung Kim wrote:
>   $ sudo ./perf test ftrace -vv
>    86: perf ftrace tests:
>   --- start ---
>   test child forked, pid 1772223
>   perf ftrace list test
>   syscalls for sleep:
>   __x64_sys_nanosleep
>   __ia32_sys_nanosleep
>   __x64_sys_clock_nanosleep
>   __ia32_sys_clock_nanosleep
>   perf ftrace list test  [Success]
>   perf ftrace trace test
>   # tracer: function_graph
>   #
>   # CPU  DURATION                  FUNCTION CALLS
>   # |     |   |                     |   |   |   |
>    0)               |  __x64_sys_clock_nanosleep() {
>    0)               |    common_nsleep() {
>    0)               |      hrtimer_nanosleep() {
>    0)               |        do_nanosleep() {
>   perf ftrace trace test  [Success]
>   perf ftrace latency test
>   target function: __x64_sys_clock_nanosleep
>   #   DURATION     |      COUNT | GRAPH                                          |
>       32 - 64   ms |          1 | ############################################## |
>   perf ftrace latency test  [Success]
>   perf ftrace profile test
>   # Total (us)   Avg (us)   Max (us)      Count   Function
>     100136.400 100136.400 100136.400          1   __x64_sys_clock_nanosleep
>     100135.200 100135.200 100135.200          1   common_nsleep
>     100134.700 100134.700 100134.700          1   hrtimer_nanosleep
>     100133.700 100133.700 100133.700          1   do_nanosleep
>     100130.600 100130.600 100130.600          1   schedule
>        166.868     55.623     80.299          3   scheduler_tick
>          5.926      5.926      5.926          1   native_smp_send_reschedule
>        301.941    301.941    301.941          1   __x64_sys_execve
>        295.786    295.786    295.786          1   do_execveat_common.isra.0
>         71.397     35.699     46.403          2   bprm_execve
>          2.519      1.260      1.547          2   sched_mm_cid_before_execve
>          1.098      0.549      0.686          2   sched_mm_cid_after_execve
>   perf ftrace profile test  [Success]
>   ---- end(0) ----
>    86: perf ftrace tests                                               : Ok
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/ftrace.sh | 84 ++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100755 tools/perf/tests/shell/ftrace.sh
> 
> diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
> new file mode 100755
> index 000000000000..b1c36d30559a
> --- /dev/null
> +++ b/tools/perf/tests/shell/ftrace.sh
> @@ -0,0 +1,84 @@
> +#!/bin/sh
> +# perf ftrace tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +# perf ftrace commands only works for root
> +if [ "$(id -u)" != 0 ]; then
> +    echo "perf ftrace test  [Skipped: no permission]"
> +    exit 2
> +fi
> +
> +output=$(mktemp /tmp/__perf_test.ftrace.XXXXXX)
> +
> +cleanup() {
> +  rm -f "${output}"
> +
> +  trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +# this will be set in test_ftrace_trace()
> +target_function=
> +
> +test_ftrace_list() {
> +    echo "perf ftrace list test"
> +    perf ftrace -F > "${output}"
> +    # this will be used in test_ftrace_trace()
> +    sleep_functions=$(grep 'sys_.*sleep$' "${output}")
> +    echo "syscalls for sleep:"
> +    echo "${sleep_functions}"
> +    echo "perf ftrace list test  [Success]"
> +}
> +
> +test_ftrace_trace() {
> +    echo "perf ftrace trace test"
> +    perf ftrace trace --graph-opts depth=5 sleep 0.1 > "${output}"
> +    # it should have some function name contains 'sleep'
> +    grep "^#" "${output}"
> +    grep -F 'sleep()' "${output}"
> +    # find actual syscall function name
> +    for FN in ${sleep_functions}; do
> +	if grep -q "${FN}" "${output}"; then
> +	    target_function="${FN}"
> +	    echo "perf ftrace trace test  [Success]"
> +	    return
> +	fi
> +    done
> +
> +    echo "perf ftrace trace test  [Failure: sleep syscall not found]"
> +    exit 1
> +}
> +
> +test_ftrace_latency() {
> +    echo "perf ftrace latency test"
> +    echo "target function: ${target_function}"
> +    perf ftrace latency -T "${target_function}" sleep 0.1 > "${output}"
> +    grep "^#" "${output}"
> +    grep "###" "${output}"
> +    echo "perf ftrace latency test  [Success]"
> +}
> +
> +test_ftrace_profile() {
> +    echo "perf ftrace profile test"
> +    perf ftrace profile sleep 0.1 > "${output}"
> +    grep ^# "${output}"
> +    grep sleep "${output}"
> +    grep schedule "${output}"
> +    grep execve "${output}"
> +    echo "perf ftrace profile test  [Success]"
> +}

I think this will cover the problem I reported to you, i.e. strange
times:

root@x1:~# perf ftrace profile sleep 1s > a
root@x1:~# time_re="[[:space:]]+100[[:digit:]]{4}\.[[:digit:]]{3}"
root@x1:~# grep -E "^${time_re}${time_re}${time_re}[[:space:]]+1[[:space:]]+.*clock_nanosleep" a
 1000171.000 1000171.000 1000171.000          1   __x64_sys_clock_nanosleep
root@x1:~#

I.e. we know that we will have just one call to *clock_nanosleep and
that it will take a bit more than 1 second (100 followed by 4 digits to
get to something like 1000171).

So I cooked up the following patch, on top of yours, I tested it
replacing the '10' in the time_re with 20 and it fails, with '10', as
expected, it passes.

- Arnaldo

diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
index b1c36d30559a900a..a6ee740f0d7eca07 100755
--- a/tools/perf/tests/shell/ftrace.sh
+++ b/tools/perf/tests/shell/ftrace.sh
@@ -72,6 +72,11 @@ test_ftrace_profile() {
     grep sleep "${output}"
     grep schedule "${output}"
     grep execve "${output}"
+    time_re="[[:space:]]+10[[:digit:]]{4}\.[[:digit:]]{3}"
+    # 100283.000 100283.000 100283.000          1   __x64_sys_clock_nanosleep
+    # Check for one *clock_nanosleep line with a Count of just 1 that takes a bit more than 0.1 seconds
+    # Strip the _x64_sys part to work with other architectures
+    grep -E "^${time_re}${time_re}${time_re}[[:space:]]+1[[:space:]]+.*clock_nanosleep" "${output}"
     echo "perf ftrace profile test  [Success]"
 }
 

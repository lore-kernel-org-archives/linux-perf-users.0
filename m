Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999F188016;
	Tue, 30 Jul 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367147; cv=none; b=DlTUIH9u/Fwx1MU/msLpNU62M8F9T4St01eUlzQvB3gfkr0vROtOxefD/+dcTOj3SQPY+IkzhYsgsFwQF/1FlW3yD2UhkXm1P93HRJVttIIb3Jf9UCqybxyPN16afczVhIZCenUZKO/VS01EU5dSg+/b8lCjOSuizZKCcIE8NB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367147; c=relaxed/simple;
	bh=ZwEZbzVOl2i7S7qWqbFu8+IPoL2JEN22iQLkUoFOZPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Scv/ERuL3pcVr/EmWq7yqzUvpCSEtu32lVr8Sg3aTwk9TsfPxxC2Pn32WaSLtSSu1yz1bfU99/uLq7MPGwXRtlH4TRZGUlooMpwistTXCss7L5RfUYLXmiIN9pGb+Jf9VTZMuUUHiw9qmPYslbszMwIXIpLv6eJDKBVjSzpkHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+uuOLmV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+uuOLmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C43C32782;
	Tue, 30 Jul 2024 19:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722367147;
	bh=ZwEZbzVOl2i7S7qWqbFu8+IPoL2JEN22iQLkUoFOZPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+uuOLmVUVCaTpJ5v199DvIcvZsK5orDeOYyAg2D9Abt04nLQxndGh5Fc1HxgNZmq
	 5J2zNL2PY1ifdCrFLNpzCkMFGWhwP8j72H6RuQy1EHzoYFAXjG9urJgW+UlKJCydwM
	 SxNJkVoJaaYNC548ozS4pL4WsuloOXZtU9d1roXP12pBqoiC0uIKbeMI2NknJTwfez
	 abqhakjqIVKtpnULXfHW+6pbAHX5a4N1c4YjOOalQ0aRvEIZsoGF4d8Ma9gp/26szr
	 Z7kATdwGcptAzQoxVB3yl7v7XPBt6ealM+K9Gatls29iMwxnD4YjLZH1n7ocRQR8jE
	 3+3gz2fTEXt5g==
Date: Tue, 30 Jul 2024 16:19:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 0/4] perf ftrace: Add 'profile' subcommand (v1)
Message-ID: <Zqk8p-IxbMQBKjtE@x1>
References: <20240729004127.238611-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729004127.238611-1-namhyung@kernel.org>

On Sun, Jul 28, 2024 at 05:41:23PM -0700, Namhyung Kim wrote:
> Hello,
> 
> This is an attempt to extend perf ftrace command to show a kernel function
> profile using the function_graph tracer.  This is useful to see detailed
> info like total, average, max time (in usec) and number of calls for each
> function.
> 
>   $ sudo perf ftrace profile -- sync | head
>   # Total (us)   Avg (us)   Max (us)      Count   Function
>       7638.372   7638.372   7638.372          1   __do_sys_sync
>       7638.059   7638.059   7638.059          1   ksys_sync
>       5893.959   1964.653   3747.963          3   iterate_supers
>       5214.181    579.353   1688.752          9   schedule
>       3585.773     44.269   3537.329         81   sync_inodes_one_sb
>       3566.179     44.027   3537.078         81   sync_inodes_sb
>       1976.901    247.113   1968.070          8   filemap_fdatawait_keep_errors
>       1974.367    246.796   1967.895          8   __filemap_fdatawait_range
>       1935.407     37.219   1157.627         52   folio_wait_writeback
> 
> While the kernel also provides the similar functionality IIRC under
> CONFIG_FUNCTION_PROFILER, it's often not enabled on disto kernels so I
> implemented it in user space.

Great functionality, tested it all and applied to tmp.perf-tools-next,
will be in perf-tools-next after one last round of container builds.

The discussion about libcap seems to still be open, so I'm applying what
is in this series as it is small and simple, we can go on from there.

Thanks!

- Arnaldo
 
> Also it can support function filters like 'perf ftrace trace' so users
> can focus on some target functions and change the buffer size if needed.
> 
>   $ sudo perf ftrace profile -h
>   
>    Usage: perf ftrace [<options>] [<command>]
>       or: perf ftrace [<options>] -- [<command>] [<options>]
>       or: perf ftrace {trace|latency|profile} [<options>] [<command>]
>       or: perf ftrace {trace|latency|profile} [<options>] -- [<command>] [<options>]
>   
>       -a, --all-cpus        System-wide collection from all CPUs
>       -C, --cpu <cpu>       List of cpus to monitor
>       -G, --graph-funcs <func>
>                             Trace given functions using function_graph tracer
>       -g, --nograph-funcs <func>
>                             Set nograph filter on given functions
>       -m, --buffer-size <size>
>                             Size of per cpu buffer, needs to use a B, K, M or G suffix.
>       -N, --notrace-funcs <func>
>                             Do not trace given functions
>       -p, --pid <pid>       Trace on existing process id
>       -s, --sort <key>      Sort result by key: total (default), avg, max, count, name.
>       -T, --trace-funcs <func>
>                             Trace given functions using function tracer
>       -v, --verbose         Be more verbose
>           --tid <tid>       Trace on existing thread id (exclusive to --pid)
> 
> 
> The code is also available in 'perf/ftrace-profile-v1' branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf ftrace: Add 'tail' option to --graph-opts
>   perf ftrace: Factor out check_ftrace_capable()
>   perf ftrace: Add 'profile' command
>   perf ftrace: Add -s/--sort option to profile sub-command
> 
>  tools/perf/Documentation/perf-ftrace.txt |  48 ++-
>  tools/perf/builtin-ftrace.c              | 439 +++++++++++++++++++++--
>  tools/perf/util/ftrace.h                 |   3 +
>  3 files changed, 463 insertions(+), 27 deletions(-)
> 
> -- 
> 2.46.0.rc1.232.g9752f9e123-goog

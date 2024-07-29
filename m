Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969B801;
	Mon, 29 Jul 2024 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722213689; cv=none; b=UC/FPziWiFJIxZByBgLPKn+CzMCTokCJOY7vs1BiTBYq3dkq4zHB+Z5K3BCP4iJRA7OTKtJbkN5kdR4gaZEvq+lDYkUgaeus14HG8JsD7GQhe4tXF7bnTrN4oYE4LIkvDes3DtfZAQFMhhAODAs0tZ03IAKUp/s4blY9A28VhFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722213689; c=relaxed/simple;
	bh=sAsPq2kSVX16B4RkNsWZBq68YMl3ERbCE29JZAvQGgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sKcL74lwJdpVbWGkPwmCOPyKRxgoS8jIdajyKouu7QkANcWgEM6Dm/e0Kw17xrQ8pH3PT5559KACovakzVy8Tnjfl6rqBGymrL2bI7mPgTj1Yk5TOtwx8vhbWEuy2SRCLGkfrqiONfQTH5ZLocWtGZfmsDIzSf0NfiW/19qjHsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ly8cUIxU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly8cUIxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B846C32782;
	Mon, 29 Jul 2024 00:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722213688;
	bh=sAsPq2kSVX16B4RkNsWZBq68YMl3ERbCE29JZAvQGgc=;
	h=From:To:Cc:Subject:Date:From;
	b=Ly8cUIxU40XpUCig/C5lPqJ0OWmsDPFjgZG2uekfMa1ccIL0HqkuxrpO7Q2i5Afyy
	 kK+WmCdKCLeV7enZvR0S30Leil7FyNodpyFrpo47vfGrAYLEIU6GzALfhrKfoZ+m2K
	 Nk5QpLjhVm64GzDLfGU0AZ0we1Z6F+8cXKOAGO3w3gbkmpNMrMcldoZRY+b8wKtYcd
	 f7AUxuLroE03mstyViOOoAK6QibxKgl5BIKoPsBlhZrQmE28hIKA7dOGStwGIJvi55
	 L6TD0BdNTx/oeJF4aleUMX9jsHGtHpqNlJmO/DuvAisRud15eBQ4T/Md7qtmU/YfwQ
	 bSjW73WjjYIQg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 0/4] perf ftrace: Add 'profile' subcommand (v1)
Date: Sun, 28 Jul 2024 17:41:23 -0700
Message-ID: <20240729004127.238611-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is an attempt to extend perf ftrace command to show a kernel function
profile using the function_graph tracer.  This is useful to see detailed
info like total, average, max time (in usec) and number of calls for each
function.

  $ sudo perf ftrace profile -- sync | head
  # Total (us)   Avg (us)   Max (us)      Count   Function
      7638.372   7638.372   7638.372          1   __do_sys_sync
      7638.059   7638.059   7638.059          1   ksys_sync
      5893.959   1964.653   3747.963          3   iterate_supers
      5214.181    579.353   1688.752          9   schedule
      3585.773     44.269   3537.329         81   sync_inodes_one_sb
      3566.179     44.027   3537.078         81   sync_inodes_sb
      1976.901    247.113   1968.070          8   filemap_fdatawait_keep_errors
      1974.367    246.796   1967.895          8   __filemap_fdatawait_range
      1935.407     37.219   1157.627         52   folio_wait_writeback

While the kernel also provides the similar functionality IIRC under
CONFIG_FUNCTION_PROFILER, it's often not enabled on disto kernels so I
implemented it in user space.

Also it can support function filters like 'perf ftrace trace' so users
can focus on some target functions and change the buffer size if needed.

  $ sudo perf ftrace profile -h
  
   Usage: perf ftrace [<options>] [<command>]
      or: perf ftrace [<options>] -- [<command>] [<options>]
      or: perf ftrace {trace|latency|profile} [<options>] [<command>]
      or: perf ftrace {trace|latency|profile} [<options>] -- [<command>] [<options>]
  
      -a, --all-cpus        System-wide collection from all CPUs
      -C, --cpu <cpu>       List of cpus to monitor
      -G, --graph-funcs <func>
                            Trace given functions using function_graph tracer
      -g, --nograph-funcs <func>
                            Set nograph filter on given functions
      -m, --buffer-size <size>
                            Size of per cpu buffer, needs to use a B, K, M or G suffix.
      -N, --notrace-funcs <func>
                            Do not trace given functions
      -p, --pid <pid>       Trace on existing process id
      -s, --sort <key>      Sort result by key: total (default), avg, max, count, name.
      -T, --trace-funcs <func>
                            Trace given functions using function tracer
      -v, --verbose         Be more verbose
          --tid <tid>       Trace on existing thread id (exclusive to --pid)


The code is also available in 'perf/ftrace-profile-v1' branch at
git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  perf ftrace: Add 'tail' option to --graph-opts
  perf ftrace: Factor out check_ftrace_capable()
  perf ftrace: Add 'profile' command
  perf ftrace: Add -s/--sort option to profile sub-command

 tools/perf/Documentation/perf-ftrace.txt |  48 ++-
 tools/perf/builtin-ftrace.c              | 439 +++++++++++++++++++++--
 tools/perf/util/ftrace.h                 |   3 +
 3 files changed, 463 insertions(+), 27 deletions(-)

-- 
2.46.0.rc1.232.g9752f9e123-goog


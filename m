Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732D192B65;
	Tue, 17 Sep 2024 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612107; cv=none; b=S8tYbDHVMpRMFJZIhIBgmUQbp1Ez9ZJGYOMOr3FYG46IySsAIBDOYvwG2puvmtp3vNYZFO2cNVJqQ6dqheRtl1y+T7XM/YMOTE3t+G7FUKRQ/FXH5ZCs2QjwEDL/9iq+bMejwj0YvFYvF1GAThCEDednjyMJ2Jf+3Ge187p0ciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612107; c=relaxed/simple;
	bh=ukObCMspFSCFE55xSfnhSqn0sZVwDJhzCm5JUIv+TK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwMHwipOGfr+otzE2CYUwaA0Ma0sYs8+Vf0ZAzOyT+Kay3U+BPOjoknWVV8HXRlORcvyfkqe+srNdbGNFD8jt00hYHGuxaUCv+0QhY6nCOqn3rR0/NeARp/Qh5Id81YGf8nIkZmFTZOSrxU9Gk2Z04qjhRUddAiI8voGfwEeKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRLlo5lG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRLlo5lG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91D5C4CECD;
	Tue, 17 Sep 2024 22:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612106;
	bh=ukObCMspFSCFE55xSfnhSqn0sZVwDJhzCm5JUIv+TK8=;
	h=From:To:Cc:Subject:Date:From;
	b=oRLlo5lGbC5AbGkgYAW4uo1S+3wuOY1cvHmY6lqZ2hwVREmKzh0zZXWW8litnuuP8
	 ikFcs1ahw3CazAkkvvmXrvag2boikZ2xrschEg5md53C0F3EOGQoLErUyUVN4Xf4CT
	 btDSwcsfPc3g5W1EZ+hUVLnThRNRRiQFYG8pEBty/To7ZnzdOUcr3x9vW6FCi29FkI
	 2VoMLt/HxuXr068ngW36+1t5lUqz3y40LILkWKBtPUKJPOc1tWR9giMw284jgMaxIf
	 ZPSfXMByKvRA7qwI8pfWyCVBVoadUOHYpQaGxJ2YMkZqiK/L1+sv8cjbb2yc0a2JYS
	 IvYOpmcs096+Q==
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
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	linux-toolchains@vger.kernel.org
Subject: [RFC/PATCHSET 0/5] perf tools: Support deferred user callchains (v2)
Date: Tue, 17 Sep 2024 15:28:15 -0700
Message-ID: <20240917222820.197594-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is a counterpart for Josh's kernel change v2 [1] to support deferred
user callchains.  The change is transparent and users should not notice
anything with the deferred callchains.

  $ perf record -g sleep 1

I added --[no-]merge-callchains option to control output of perf script.
You can verify it has the deferred callchains like this:

  $ perf script --no-merge-callchains
  perf     801 [000]    18.031793:          1 cycles:P:
          ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.kallsyms])
          ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
          ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
          ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
          ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
          ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsyms])
          ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
          ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsyms])
          ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
          ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
          ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
          ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
          ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])

  perf     801 [000]    18.031814: DEFERRED CALLCHAIN
                  7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/libc.so.6)

  ...

When the callchain is merged (it's the default) it'd look like below:

  $ perf script
  perf     801 [000]    18.031793:          1 cycles:P:
          ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.kallsyms])
          ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
          ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
          ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
          ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
          ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsyms])
          ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
          ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsyms])
          ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
          ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
          ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
          ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
          ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
                  7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/libc.so.6)

  ...

Notice that the last line and it has the __GI___ioctl in the same
callchain.  It should work with other tools like perf report.

The code is available at 'perf/defer-callchain-v2' branch in
https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

[1] https://lore.kernel.org/lkml/cover.1726268190.git.jpoimboe@kernel.org


Namhyung Kim (5):
  perf tools: Sync UAPI perf_event.h header
  perf tools: Minimal DEFERRED_CALLCHAIN support
  perf record: Enable defer_callchain for user callchains
  perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
  perf tools: Merge deferred user callchains

 tools/include/uapi/linux/perf_event.h     | 21 +++++-
 tools/lib/perf/include/perf/event.h       |  7 ++
 tools/perf/Documentation/perf-script.txt  |  5 ++
 tools/perf/builtin-script.c               | 92 +++++++++++++++++++++++
 tools/perf/util/callchain.c               | 24 ++++++
 tools/perf/util/callchain.h               |  3 +
 tools/perf/util/event.c                   |  1 +
 tools/perf/util/evlist.c                  |  1 +
 tools/perf/util/evlist.h                  |  1 +
 tools/perf/util/evsel.c                   | 32 +++++++-
 tools/perf/util/evsel.h                   |  1 +
 tools/perf/util/machine.c                 |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/sample.h                  |  3 +-
 tools/perf/util/session.c                 | 78 +++++++++++++++++++
 tools/perf/util/tool.c                    |  2 +
 tools/perf/util/tool.h                    |  4 +-
 17 files changed, 273 insertions(+), 4 deletions(-)

-- 
2.46.0.792.g87dc391469-goog


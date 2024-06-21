Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC812E1E9;
	Fri, 21 Jun 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719008639; cv=none; b=pv1B/qhtBoJ0530+z//74Xzpt2a/ttrwfqyYmGZruP4nGN9Xq8ZtFdmfKxl2LjZtwzM5XJheYYkvQa1u/BEmBrEZ7ouwUwLOGmuD9XNDie4fJ2Yrn0QYV7ja6ubm1x4wIu9R4Y27KdbZeonmCU+Ed9sDb/1OHLvJi7crOc6Ow90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719008639; c=relaxed/simple;
	bh=+ne5Lbkjbf1ZBPupvceOAgaiCrWOTXDw9K56r3OtFO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ru2F0+vY+37/V1Gmh7aFLeSPmkORa/TVSsw+553s2SEVppX0GpHSeqos6nDeQCVLpphcJT4+Gs6BWsAdfn26oRuW62AXmzhJ6TRe01ceOilZBsZSJYyct2gVrsw8eqKvnA/15zVo8O8LlA4YMgaSfNyLneR0OyOfNtNiHpQsC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeoNJ8Vn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeoNJ8Vn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384E1C32789;
	Fri, 21 Jun 2024 22:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719008638;
	bh=+ne5Lbkjbf1ZBPupvceOAgaiCrWOTXDw9K56r3OtFO4=;
	h=From:To:Cc:Subject:Date:From;
	b=GeoNJ8VnSg+MEPfSaq1MFuOJf3igvE3+N1sWohMgBce2NtmzA7j6BT8HHPxdJrrCv
	 G6IuFSuBpN7n/9zdLtQlJef4Ug6hECYqA2kCB16xP3xkFNgaszJHCNrcMZd4x4agvp
	 jfzaN4DzhVh5wCkbI9u3oolpIZ03+Mb23tVS9lPDpniNPvw2IrjkT/ZLZ+EheSDuxh
	 VbKtneCU8d4VxHoTcBKRkdt5xc4HyFKkBiofwia1BlB1RMwlZZgE9TlbFNV3ce/KOz
	 b6IIpay9ZgbHUzN6mmrpYHqY7aL7j2PQjapH07PpXa+qbV8289m5Yt6KNFpe4GqRol
	 uZf0C5GZBufog==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [RFC/PATCHSET 0/8] perf record: Use a pinned BPF program for filter (v2)
Date: Fri, 21 Jun 2024 15:23:49 -0700
Message-ID: <20240621222357.717374-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is to support the unprivileged BPF filter for profiling per-task events.
Until now only root (or any user with CAP_BPF) can use the filter and we
cannot add a new unprivileged BPF program types.  After talking with the BPF
folks at LSF/MM/BPF 2024, I was told that this is the way to go.  Finally I
managed to make it working with pinned BPF objects. :)

v2 changes)
 * rebased onto Ian's UID/GID (non-sample data based) filter term change
 * support separate lost counts for each use case
 * update the test case to allow normal users (if supported)


This only supports the per-task mode for normal users and root still uses
its own instance of the same BPF program - not shared with other users.
But it requires the one-time setup (by root) before using it by normal users
like below.

  $ sudo perf record --setup-filter pin

This will load the BPF program and maps and pin them in the BPF-fs.  Then
normal users can use the filter.

  $ perf record -o- -e cycles:u --filter 'period < 10000' perf test -w noploop | perf script -i-
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.011 MB - ]
        perf  759982 448227.214189:          1 cycles:u:      7f153719f4d0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
        perf  759982 448227.214195:          1 cycles:u:      7f153719f4d0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
        perf  759982 448227.214196:          7 cycles:u:      7f153719f4d0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
        perf  759982 448227.214196:        223 cycles:u:      7f153719f4d0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
        perf  759982 448227.214198:       9475 cycles:u:  ffffffff8ee012a0 [unknown] ([unknown])
        perf  759982 448227.548608:          1 cycles:u:      559a9f03c81c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
        perf  759982 448227.548611:          1 cycles:u:      559a9f03c81c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
        perf  759982 448227.548612:         12 cycles:u:      559a9f03c81c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
        perf  759982 448227.548613:        466 cycles:u:      559a9f03c81c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)

It's also possible to unload (and unpin, of course) using this command:

  $ sudo perf record --setup-filter unpin

The code is avaiable in 'perf/pinned-filter-v2' branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (8):
  perf bpf-filter: Make filters map a single entry hashmap
  perf bpf-filter: Pass 'target' to perf_bpf_filter__prepare()
  perf bpf-filter: Split per-task filter use case
  perf bpf-filter: Support pin/unpin BPF object
  perf bpf-filter: Support separate lost counts for each filter
  perf record: Fix a potential error handling issue
  perf record: Add --setup-filter option
  perf test: Update sample filtering test

 tools/perf/Documentation/perf-record.txt     |   5 +
 tools/perf/builtin-record.c                  |  23 +-
 tools/perf/builtin-stat.c                    |   2 +-
 tools/perf/builtin-top.c                     |   2 +-
 tools/perf/builtin-trace.c                   |   2 +-
 tools/perf/tests/shell/record_bpf_filter.sh  |  13 +-
 tools/perf/util/bpf-filter.c                 | 406 +++++++++++++++++--
 tools/perf/util/bpf-filter.h                 |  19 +-
 tools/perf/util/bpf_skel/sample-filter.h     |   2 +
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  75 +++-
 tools/perf/util/evlist.c                     |   5 +-
 tools/perf/util/evlist.h                     |   4 +-
 tools/perf/util/python.c                     |   3 +-
 13 files changed, 485 insertions(+), 76 deletions(-)

-- 
2.45.2.741.gdbec12cfda-goog


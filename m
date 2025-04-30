Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681A2D0AAB;
	Wed, 30 Apr 2025 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046550; cv=none; b=Cugayaz06gtR1Ms3Nj1Nv3ROZgNSbbXQUl7Bini9mchBKtb4VKeKUXkNk7cZlPadAbHQLI8cQp+RrutUXAzx5/9CYDDd8c4Il3+y3arzvLHQ8IfK2AFFTAMHp4j/5H7MOSJm4dbajNfn6Rhj1xXrS0luus7xaD5E2/ona+4VC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046550; c=relaxed/simple;
	bh=FEIARb4xNOhJ0olxO8wg4X4kbp7vC8hmM3fCFxFYg48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BiM3mFS+di2IWzVpoJ++jIGfNhBwRp+niiYXxnNhii3Cby/eV5jK2Ojldat4+KvbUkS+dhLLnDdfRSAuy8ajdBBgR5sSapQx7qi/RzQRxaTsNm02Ny2oUjiRll3MRdZTqsWNB0VUedI+naNgZ/jQ8adKXukb7/w16giVMVYnKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKuSSE8X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKuSSE8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87267C4CEE7;
	Wed, 30 Apr 2025 20:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046550;
	bh=FEIARb4xNOhJ0olxO8wg4X4kbp7vC8hmM3fCFxFYg48=;
	h=From:To:Cc:Subject:Date:From;
	b=qKuSSE8X2RCrGcIb+dBaxYKyrX3DpcNjnKntm3kdrLSsWPRF3NyJ7jUJ41pTWRAMv
	 lKBrvRzZ5gtoABJqBlkdahV+o+/t2xcWdIu+wLfNMDuG2Bayu7TSJEublAZU4YdxHv
	 CxlcmzINiGZEaVOBxsxP2sInzYuZaLq14ubSE7CMqiny7q+k5TQ6NsO0hWKIHL0Jip
	 2VISb0K5YcEaOpkbspOUKtglTygq3YqDuL3RK8S4SxSo0VPFqT8BOoWY5fnWPoOtRv
	 Oky19327qqNhG4l89CV3huENEoz4bGmbPehmlamcRwt+0KgwZHfdsLTXdwmLNQlZ7O
	 zNnUnJt5PIi7w==
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Leo Yan <leo.yan@arm.com>
Subject: [RFC/PATCHSET 00/11] perf mem: Add new output fields for data source (v1)
Date: Wed, 30 Apr 2025 13:55:37 -0700
Message-ID: <20250430205548.789750-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The perf mem uses PERF_SAMPLE_DATA_SRC which has a lot of information
for memory access.  It has various sort keys to group related samples
together but it's still cumbersome to see the result.  While perf c2c
command provides a way to investigate the data in a specific way, I'd
like to add more generic ways using new output fields.

For example, the following is the 'cache' output field which breaks
down the sample weights into different level of caches.

  $ perf mem record -a sleep 1
  
  $ perf mem report -F cache,dso,sym --stdio
  ...
  #
  # -------------- Cache --------------
  #      L1     L2     L3 L1-buf  Other  Shared Object                                  Symbol
  # ...................................  .....................................  .........................................
  #
       0.0%   0.0%   0.0%   0.0% 100.0%  [kernel.kallsyms]                      [k] ioread8
     100.0%   0.0%   0.0%   0.0%   0.0%  [kernel.kallsyms]                      [k] _raw_spin_lock_irq
       0.0%   0.0%   0.0%   0.0% 100.0%  [xhci_hcd]                             [k] xhci_update_erst_dequeue
       0.0%   0.0%   0.0%  95.8%   4.2%  [kernel.kallsyms]                      [k] smaps_account
       0.6%   1.8%  22.7%  45.5%  29.5%  [kernel.kallsyms]                      [k] sched_balance_update_blocked_averages
      29.4%   0.0%   1.6%  58.8%  10.2%  [kernel.kallsyms]                      [k] __update_load_avg_cfs_rq
       0.0%   8.5%   4.3%   0.0%  87.2%  [kernel.kallsyms]                      [k] copy_mc_enhanced_fast_string
      63.9%   0.0%   8.0%  23.8%   4.3%  [kernel.kallsyms]                      [k] psi_group_change
       3.9%   0.0%   9.3%  35.7%  51.1%  [kernel.kallsyms]                      [k] timerqueue_add
      35.9%  10.9%   0.0%  39.0%  14.2%  [kernel.kallsyms]                      [k] memcpy
      94.1%   0.0%   0.0%   5.9%   0.0%  [kernel.kallsyms]                      [k] unmap_page_range
      25.7%   0.0%   4.9%  51.0%  18.4%  [kernel.kallsyms]                      [k] __update_load_avg_se
       0.0%  24.9%  19.4%   9.6%  46.1%  [kernel.kallsyms]                      [k] _copy_to_iter
      12.9%   0.0%   0.0%  87.1%   0.0%  [kernel.kallsyms]                      [k] next_uptodate_folio
      36.8%   0.0%   9.5%  16.6%  37.1%  [kernel.kallsyms]                      [k] update_curr
     100.0%   0.0%   0.0%   0.0%   0.0%  bpf_prog_b9611ccbbb3d1833_dfs_iter     [k] bpf_prog_b9611ccbbb3d1833_dfs_iter
      45.4%   1.8%  20.4%  23.6%   8.8%  [kernel.kallsyms]                      [k] audit_filter_rules.isra.0
      92.8%   0.0%   0.0%   7.2%   0.0%  [kernel.kallsyms]                      [k] filemap_map_pages
      10.6%   0.0%   0.0%  89.4%   0.0%  [kernel.kallsyms]                      [k] smaps_page_accumulate
      38.3%   0.0%  29.6%  27.1%   5.0%  [kernel.kallsyms]                      [k] __schedule

Please see the description of each commit for other fields.

New mem_stat field was added to the hist_entry to save this
information.  It's a generic data structure (array) to handle
different type of information like cache-level, memory location,
snoop-result, etc.

The first patch is a fix for the hierarchy mode and it was sent
separately.  I just add it here not to break the hierarchy mode.  The
second patch is to enable SAMPLE_DATA_SRC without SAMPLE_ADDR and
perf_event_attr.mmap_data which generate a lot more data.

The name of some new fields are the same as the corresponding sort
keys (mem, op, snoop) so I had to change the order whether it's
applied as an output field or a sort key.  Maybe it's better to name
them differently but I couldn't come up with better ideas.

That means, you need to use -F/--fields option to specify those fields
and the sort keys you want.  Maybe we can change the default output
and sort keys for perf mem report with this.

The code is available at 'perf/mem-field-v1' branch in

 git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (11):
  perf hist: Remove output field from sort-list properly
  perf record: Add --sample-mem-info option
  perf hist: Support multi-line header
  perf hist: Add struct he_mem_stat
  perf hist: Basic support for mem_stat accounting
  perf hist: Implement output fields for mem stats
  perf mem: Add 'op' output field
  perf hist: Hide unused mem stat columns
  perf mem: Add 'cache' and 'memory' output fields
  perf mem: Add 'snoop' output field
  perf mem: Add 'dtlb' output field

 tools/perf/Documentation/perf-record.txt |   7 +-
 tools/perf/builtin-record.c              |   6 +
 tools/perf/ui/browsers/hists.c           |  50 ++++-
 tools/perf/ui/hist.c                     | 272 ++++++++++++++++++++++-
 tools/perf/ui/stdio/hist.c               |  57 +++--
 tools/perf/util/evsel.c                  |   2 +-
 tools/perf/util/hist.c                   |  78 +++++++
 tools/perf/util/hist.h                   |  22 ++
 tools/perf/util/mem-events.c             | 183 ++++++++++++++-
 tools/perf/util/mem-events.h             |  57 +++++
 tools/perf/util/record.h                 |   1 +
 tools/perf/util/sort.c                   |  42 +++-
 12 files changed, 718 insertions(+), 59 deletions(-)

-- 
2.49.0.906.g1f30a19c02-goog


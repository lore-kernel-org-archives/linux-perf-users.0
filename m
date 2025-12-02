Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D461A219E8C;
	Tue,  2 Dec 2025 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663406; cv=none; b=luGrg9u+Gkq6NEEKzk6KCMA9UPZnmtzQE13Wwyle4kGmJo8slXdjlKlmEqkfn6ZZeIa5zMc6qVM83LMXbLZ0NBDViLRomdaqdSwR6KFPVKkfC8qPJj8TPJLESACmM0/Ejfo9pXhQkSInUwSqD7JsAQRfKjmdwDaYKotwoCNHfss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663406; c=relaxed/simple;
	bh=RxqAj9h+/viMZshnmHgnFPnkGGBelDBbmQHHCMFXa8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pR48rRThs2rUNn+12j1mtkco6qFQd9z1eQAlMKFztNg3qVGDJM/Kpb3F4aS3n/FOyUSGekozHkAaSlEmc73YXZBLcbNuDGkbrtUzePyitH14BF7T6zFZKuqzpKP4hHPzRyCaIDEt9lTJYUw9fsM5ck8fK5PPoEiHBShvRRt3us0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmQt/Mrv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmQt/Mrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4CEC4CEF1;
	Tue,  2 Dec 2025 08:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764663406;
	bh=RxqAj9h+/viMZshnmHgnFPnkGGBelDBbmQHHCMFXa8Y=;
	h=From:To:Cc:Subject:Date:From;
	b=mmQt/Mrvv8UHbzoX/SrVs15SdUVYCUyvzLuITK/GKJLAcoXFU1RW0jXxUDesuvf70
	 f+dPNyargk0L3i2fZwK4m1UqeKRwHAANJZulMzy58tcg0wOcF0093R5HTDO8E49awB
	 k7DC+MhfUgcBi+/SWW2J9hc9axRz4ri8KIyQja4Brhp+RloS63zjVFGY7Rsf4g0cu5
	 amb0wDQ/yOVFX2YJB+vn1epDGtlX5wYTv1vrQxta8owq0YH1HpFkVESYpofQpsEOeU
	 /ohKLOKaKeA3GkZu25cUCrmhF1K+PaV9ywTho/s5iNTxgjFdmCdfvor1cuLn5nhAQV
	 HFsmhrngfBJOw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCHSET 0/5] perf tools: Fix /proc/kallsyms map split 
Date: Tue,  2 Dec 2025 00:16:40 -0800
Message-ID: <20251202081645.931527-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I found a weird bug in symbol handling for kallsyms.  My system has a
live patch which is a module and it has some symbols that conflict
with the main kernel map.

For example, the symbols are common functions defined in the kernel
like kmalloc and kfree.  They have 'u' type which is a unique global
symbol.

  $ grep ' u ' /proc/kallsyms
  ffffffff98798dd0 u kmalloc_caches	[livepatch]
  ffffffff97afb6c0 u kmalloc_trace_noprof	[livepatch]
  ffffffff9739e7a0 u __list_add_valid_or_report	[livepatch]
  ffffffff97afb240 u __kmalloc_noprof	[livepatch]
  ffffffff970597f0 u klp_enable_patch	[livepatch]
  ffffffff979939f0 u kfree	[livepatch]
  ...

They are duplicate symbols and will be removed by the fixup routine.
But if symbol_conf.allow_aliases is set, they remain.  This is the
case for perf lock contention, and it caused a trouble with the
kallsyms split code.

  $ grep ' kfree' /proc/kallsyms
  ffffffff97057a30 t kfree_rcu_shrink_scan
  ffffffff97394380 T kfree_strarray
  ffffffff9779b890 T kfree_skb_list_reason
  ffffffff9787be60 t kfree_pmc
  ffffffff979939f0 T kfree                         <<<--- here
  ffffffff979bbc50 T kfree_skb_partial
  ffffffff97a8f110 t kfree_rcu_work
  ffffffff97a8f2f0 t kfree_rcu_monitor
  ffffffff97a8f910 t kfree_rcu_shrink_count
  ffffffff97af67f0 T kfree_const
  ffffffff97afbbc0 T kfree_sensitive
  ffffffff97b5c4a0 T kfree_link
  ffffffff99255908 d kfree_rcu_shrinker
  ffffffff998beec0 T kfree_rcu_scheduler_running
  ffffffff979939f0 u kfree	[livepatch]        <<<--- duplicate

As the kfree function is in the livepatch module, any functions in the
main kernel map that come later than 'kfree' will now to be splitted.
This will create a lot of new kernel maps and loading them again will
go to the routines to load kallsyms and split.  So the process was in
an infinite loop creating new maps and eventually gets killed.

I've added some defensive measures to prevent such situations and a
test case to verify it.  But maybe we need to do something for 'u'
type symbols.

Thanks,
Namhyung


Namhyung Kim (5):
  perf tools: Mark split kallsyms DSOs as loaded
  perf tools: Fix split kallsyms DSO counting
  perf tools: Fallback to initial kernel map properly
  perf tools: Use machine->root_dir to find /proc/kallsyms
  perf test: Add kallsyms split test

 tools/perf/tests/Build                   |  1 +
 tools/perf/tests/builtin-test.c          |  1 +
 tools/perf/tests/fake_root/proc/kallsyms | 10 ++++
 tools/perf/tests/fake_root/proc/modules  |  1 +
 tools/perf/tests/fake_root/proc/version  |  1 +
 tools/perf/tests/kallsyms-split.c        | 72 ++++++++++++++++++++++++
 tools/perf/tests/tests.h                 |  1 +
 tools/perf/util/symbol.c                 | 16 ++++--
 8 files changed, 99 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/tests/fake_root/proc/kallsyms
 create mode 100644 tools/perf/tests/fake_root/proc/modules
 create mode 100644 tools/perf/tests/fake_root/proc/version
 create mode 100644 tools/perf/tests/kallsyms-split.c

-- 
2.52.0.158.g65b55ccf14-goog


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BB4313520;
	Tue,  2 Dec 2025 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719843; cv=none; b=eWk1GcEeGURvp0de40u0LWNqUHAKfSLb0F1TRRkyrI1r3XJ4ryRx6j2hp++0ma6wEQQMQQdNJPP3BgdRLMqzWCYcP6vxo1VQ4+sfbwCUKCArfPyCDumxBd9Zl7UJkPMuaoSGOKh6+vvn4up8adWj6pYf0MTG5W2l2LDoG3OOD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719843; c=relaxed/simple;
	bh=RKXuvrmy6aoBfAhk2vTtBo/u2cAPnVcw9agYmoN2qSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUiKZyGn+rlOb8MNjSWtFkgkNYcWPjc5t8mTlNupdKKlFDX9bnld5WmPACLHPohacP1ZPiDAI1Nn0wx+ko8M98Lr9kvwD4M0ffN4y86y332ysisu5Fn/BxGiV2rtymkZHcI/DZ11uhlELMRfK8o4EF6rVgJs3MEFgO2Y+ff0S3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3lORID6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3lORID6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0030DC4CEF1;
	Tue,  2 Dec 2025 23:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764719841;
	bh=RKXuvrmy6aoBfAhk2vTtBo/u2cAPnVcw9agYmoN2qSk=;
	h=From:To:Cc:Subject:Date:From;
	b=j3lORID6bukfl4gcdQwFIORpPD5wgdmSRT6z/prbo/bdFluTQpZkLmwYpGPTcOcgc
	 eHJVwQ4Lmxi8KZdGWgecvdR1tmLAriABfYmJeBxdnqq9AJJRHO0bNQ3j1DVLhXiPla
	 5t2OEedf237Rhr3xCVHwxBpu40FiZb5qsdlmLWUCWnjMZHqW0yNAcEZoFod6ejQerZ
	 6tA9B9ewsZ9esTOPZqEICBSzzk8k5bKDDurKjS+hM1YTrhboFhwpqqxcic3W/L+K0z
	 KrFv6DpoMl+a+OtI4ikRCN7zocLwxsIilp4pMdgjc43nCJXWqOhbmXgYI4XNB5XybI
	 ucW0JLF406G5A==
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
Subject: [PATCHSET v2 0/5] perf tools: Fix /proc/kallsyms map split 
Date: Tue,  2 Dec 2025 15:57:13 -0800
Message-ID: <20251202235718.1018752-1-namhyung@kernel.org>
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

* v2 changes)
 - use map__kmaps()  (Ian)
 - use temporary root directory  (Ian)
 - Add Ian's Reviewed-by

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

 tools/perf/tests/Build            |   1 +
 tools/perf/tests/builtin-test.c   |   1 +
 tools/perf/tests/kallsyms-split.c | 156 ++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h          |   1 +
 tools/perf/util/symbol.c          |  16 ++-
 5 files changed, 171 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/tests/kallsyms-split.c

-- 
2.52.0.158.g65b55ccf14-goog


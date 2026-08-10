Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECFE2EB5B8;
	Mon, 10 Aug 2026 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368946; cv=none; b=Qietggn4f6tgDdqP+r4+LFbk3Ad/wWFJE+5BsU4bbihoaBI7fJ0pEj2XEdOYQw7h0X5a+n+LLKd0EZxG41BVD8iF7563VmACoVGPVtKoMkoepZdhJdl7sicEduYZ4EPYV/lNYk+DSpY9tIAxc62jp/iyQNJYajc0MIzTj7bt/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368946; c=relaxed/simple;
	bh=sj0RrVfUhExYBdkJs39XAms88P2ltniJLgWXvjG9Rhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCQmmWCxrrxHZNEjnNjoeQdRapcRYV8/y+RqGO6LMgLZmpc59iL9CF+gk9ZSKNIRbC0RCOkYmUzkgPh7ki4uhp36RxPXutTNR1v9Mub0Y4zQKZP+YRGv1EaxrwjUJge8kMF7t+b5cSVrIZQbEmYGvT6MxHt7fAvwk5whq62ICIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtgfW6K0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtgfW6K0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E831F00A3A;
	Mon, 10 Aug 2026 13:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786368944;
	bh=hlrl3xze0yBKa+qAzlqk+6GMfYLXuGnJHmFyd3u5Lmc=;
	h=From:To:Cc:Subject:Date;
	b=gtgfW6K07wfpikyLhTN0/8c62690UmSrq9xyaCeGCIVIOu/0QV4UVko/rqe1wxWgX
	 8lLV4Z/1ZYljrZDs+r/MO28J/8XJiJscpnCMlo9byWhCCOa/rJwbRLHKoozCl9EOeh
	 tzakhVlSC1ViGcN+Y5RtxoB5CNyMrfL5mOi//joqmO9oMbs5VuOpsAm3lg+HOMh90z
	 mP2czSSbOuD+52OzEMkJxkcyTgMH49wJWwtzZHixS1Xfw/eyWtNlyN9Ay6r4iuf7iP
	 9juW6iAAo0H6OZNpSosCDZUE8JMMQhEhmrLp0z9Ss5HOjC6cdpptMa3BE5QVTnJfb/
	 AWBdx+OUpU/vQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Usama Arif <usama.arif@linux.dev>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] perf/core: sched_task() dispatch and branch entry fixes
Date: Mon, 10 Aug 2026 06:35:33 -0700
Message-ID: <20260810133540.1947118-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These three fixes were found while adding BRBE support for
bpf_get_branch_snapshot() on arm64 and were carried in that series until
v6 [1]. They do not depend on it, so they go on their own; the version
number continues from that series to avoid two numbering schemes for the
same patches.

Patch 1 stops __perf_pmu_sched_task() passing a NULL pmu_ctx to
pmu->sched_task(). armv8pmu_sched_task() is the only implementation that
dereferences the argument, so the oops needs BRBE.

Patch 2 makes perf_pmu_sched_task() visit PMUs whose events are all
CPU-wide. They are skipped today on every switch to a task that has a
perf context but no event on that PMU, so branch records leak across the
task boundary with perf record -b -a. intel_pmu_lbr_add() calls
perf_sched_cb_inc() unconditionally, so x86 LBR is affected the same way.

Patch 3 has each caller fill struct perf_branch_entry in one assignment
rather than clearing the bitfields first, and drops
perf_clear_branch_entry_bitfields(). The helper had drifted from the
struct: new_type and priv were never cleared, and arm_pmuv3.c allocates
the per-CPU branch stack with kmalloc().

Tested on a 128 CPU arm64 machine with BRBE. A WARN_ON_ONCE() at the gate
patch 2 adds to perf_ctx_sched_task_cb() fires within seconds of running
perf record -b -a alongside a task-bound event pinned to a different CPU.
Also built for x86, which patch 3 touches.

Changes in v7:
- Patch 1: pass &cpc->epc unconditionally. cpc->task_epc is NULL there
  both before and after patch 2, so the conditional was dead.
- Patch 2: gate perf_pmu_sched_task() on cpc->task_epc alone. It is
  never set without a task context scheduled in, so the cpuctx->task_ctx
  test was redundant and the two gates are now inverses.
- Patch 3: fill the entry at each site instead of renaming the helper,
  as suggested by Peter.
- Dropped the v6 review tags, all three patches changed.

Changes in v6:
- Split the sched_task() fix into patches 1 and 2; the NULL dereference
  and the missed dispatch are separate bugs with different reachability.
- Gate perf_ctx_sched_task_cb() on cpc->task_epc. v5 removed the early
  return in perf_pmu_sched_task() without it, so both paths ran for a
  task whose event for that PMU is pinned to another CPU. Caught by the
  WARN_ON_ONCE() described above.
- Tag patches 1 and 2 for stable.
- Send separately from the BRBE series, rebased onto tip perf/core.

[1] https://lore.kernel.org/all/20260616155716.2631508-1-puranjay@kernel.org/
v6: https://lore.kernel.org/bpf/20260806135224.3267890-1-puranjay@kernel.org/

Puranjay Mohan (3):
  perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
  perf/core: Run sched_task() for PMUs with only CPU-wide events
  perf/core: Fill branch entries with a single assignment

 arch/x86/events/amd/brs.c   |  9 +++--
 arch/x86/events/amd/lbr.c   | 16 ++++-----
 arch/x86/events/intel/lbr.c | 65 ++++++++++++++++++++-----------------
 drivers/perf/arm_brbe.c     |  2 +-
 include/linux/perf_event.h  | 17 ----------
 kernel/events/core.c        | 15 ++++++---
 6 files changed, 58 insertions(+), 66 deletions(-)

-- 
2.53.0-Meta


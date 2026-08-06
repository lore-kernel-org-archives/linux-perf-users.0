Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2D388E7C;
	Thu,  6 Aug 2026 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024389; cv=none; b=PJ2hZHZoATYs8pyp719AKzMZy2pVnWy6x2XBh94WncNDn4xApg3ZCUEpmi7SP78itob6WDMaZkLPob5UvPHVdwtRi2FfmdvokmfewFfnBxVDAQpr6WI9vFApYaxNI701bgVQb0NH/o0pe4Ug5lRGE3WdAKO14ut3x1OuKzQMm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024389; c=relaxed/simple;
	bh=q2cciPE6r9aBzCBRCLxeFxoFZfPY8m4wAIombo350LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZ5mcsfAX6fvWed/K2UWPQLlp+EqfuF+GxAR0gy/m7zRKuvrr5O4hb7r0DD1mmH3oLLufDt0eW8Llui1PwzxvKpQZI/1+cuD+EHBb0OafJU1dgwxtH3VcOaNV1nlozPi1jkOtiZmQHN/SvDSEz+iz1S4ihQiXDLtVUUgdAKLMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltDRo8L2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltDRo8L2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B221F000E9;
	Thu,  6 Aug 2026 13:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024388;
	bh=IKqPFsGUTE/iktLHlZyo0CuSNyCusETSu5tRfe5rZ0I=;
	h=From:To:Cc:Subject:Date;
	b=ltDRo8L2l+ReTf9LHJZ1lbVO+HFjWO0EkdBg/v1r8yVCrfkqDWQPbxKpu7+/m85UW
	 EWsa7X+ULsG35QAAOGjWetSPRoWgy9hCyCIUGgxOeVnX7M6kLVvTgwKcN/3YTCKYdm
	 Q9FxcVWow/UIypSymxwQH7WVcMDoH5E0ca4/xWWiMNFyJuYPkQEj8lDOTR87HQ3YSm
	 ruoQsweYdo1x4c00BfM5mXDvvlIY4Jxf95mJX44Lib5cg53LvIL97Re1uhln/LF3cN
	 mC09R+aBNeG5aEH1m0C3IdaLbVju5VMi8QV/2DWCONtOzXWV2w8H8r0XbhmwA4iu0p
	 4apY1ZPUVJnuQ==
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
Subject: [PATCH v6 0/3] perf/core: sched_task() dispatch and branch entry fixes
Date: Thu,  6 Aug 2026 06:52:20 -0700
Message-ID: <20260806135224.3267890-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These three fixes were found while adding BRBE support for
bpf_get_branch_snapshot() on arm64 and have been carried in that series
since v1 [1]. They do not depend on it, so they go on their own from
here; the version number continues from that series to avoid two
numbering schemes for the same patches.

Patch 1 stops __perf_pmu_sched_task() passing a NULL pmu_ctx to
pmu->sched_task(). armv8pmu_sched_task() is the only implementation that
dereferences the argument, so the oops needs BRBE.

Patch 2 makes perf_pmu_sched_task() visit PMUs whose events are all
CPU-wide. They are skipped today whenever the scheduled task has a perf
event of its own, so branch records leak across task boundaries with
perf record -b -a. intel_pmu_lbr_add() calls perf_sched_cb_inc()
unconditionally, so x86 LBR is affected the same way.

Dropping the early return alone leaves both dispatch paths running for
one case, so perf_ctx_sched_task_cb() gains a matching gate. The two
could instead be collapsed into perf_pmu_sched_task() alone, since
__perf_pmu_sched_task() already passes the same epc, but that would move
the callback out of the perf_ctx_disable() window for every PMU rather
than just that one case, which seemed like too much for a fix tagged for
stable.

Patch 3 clears struct perf_branch_entry with a single struct assignment.
perf_clear_branch_entry_bitfields() had drifted from the struct: new_type
and priv were never cleared, and arm_pmuv3.c allocates the per-CPU branch
stack with kmalloc().

Tested on a 128 CPU arm64 machine with BRBE. A WARN_ON_ONCE() at the gate
patch 2 adds to perf_ctx_sched_task_cb() fires within seconds of running
perf record -b -a alongside a task-bound event pinned to a different CPU.

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

Based on tip perf/core (f4dfab174244).

Puranjay Mohan (3):
  perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
  perf/core: Run sched_task() for PMUs with only CPU-wide events
  perf/core: Clear the whole branch entry in perf_clear_branch_entry()

 arch/x86/events/amd/brs.c   |  2 +-
 arch/x86/events/amd/lbr.c   |  2 +-
 arch/x86/events/intel/lbr.c |  6 +++---
 drivers/perf/arm_brbe.c     |  2 +-
 include/linux/perf_event.h  | 16 ++--------------
 kernel/events/core.c        | 15 +++++++++++----
 6 files changed, 19 insertions(+), 24 deletions(-)

-- 
2.53.0-Meta


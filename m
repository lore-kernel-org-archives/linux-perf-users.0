Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA823655DA;
	Fri, 24 Jul 2026 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915348; cv=none; b=EK6khEN8Clbe30IB24e6gQtbMS3d+j9rx78UHW1anR28uG4xGZazi44qR/2pNvnWVXtRVaNZ6sBefcVobJEqaCwgbLIhjNRkrHDtVCvUzuo4Wz2VsV5fvDmB1/a2I1Ha86KKvyTtATgh3L50iuX4v/62Qp97tGqkXrCDOrOqlow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915348; c=relaxed/simple;
	bh=BfRf4tstKQfdBZ2mTIhCZTKbr44ScN8NGYw5YXn8tQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dG2+xPE8y3YDLGno3CwPXrrtcBmSiti338M8mv0lMPt4/wXhUZvUlBZLqicJRjk9unabKWCVkCq4RkbnB/dv9VrM2jecJDEp8MLznlna/5M1EyBVB+wH0T+29yhd73d4GiAISsAtYP2nCg+7rQcVB1yHBr4qM83qQSkX/sOApHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=StK6VLRX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="StK6VLRX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D68A339;
	Fri, 24 Jul 2026 10:49:01 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0E473F59E;
	Fri, 24 Jul 2026 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784915345; bh=BfRf4tstKQfdBZ2mTIhCZTKbr44ScN8NGYw5YXn8tQA=;
	h=From:To:Cc:Subject:Date:From;
	b=StK6VLRXUI8uaU5lynj0dOuCM4zHrCRH2DZQYRRNbFJG+dJLsagwdsU9yhT3pBeuB
	 axwu9QUaLa2l6c+L0ctHyrAng3VMLtJOVlkUe5cMD2w20eEzuDwuaVbeEMwBiGtIfU
	 zXOe8lJJ1ZvySgELLHi91qJAstRbSrtCpi+e71ZY=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] perf: Generic hotplug/cpumask for system PMUs
Date: Fri, 24 Jul 2026 18:48:57 +0100
Message-ID: <cover.1784911757.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-perf-users/cover.1784653319.git.robin.murphy@arm.com/

Hi all,

Here's my take on finally trying to clean up the longstanding PMUs vs.
CPU hotplug can of worms. Patch #1 is the thing to look at; patch #2
is included as an example of how it simplifies my "favourite" driver
(in fact arm-cmn actually gets one of the least-negative diffstats on
offer, but it's the one I can test on a box under my desk). I'll save
the remaining bulk-conversion noise for a follow-up if and when.

For simplicity I've framed this around the system PMU use-case, since
consolidating their whole cpumask/migration business is the big win
here, and isn't all that easy to do in separate stages. However, the
design does also allow for any driver to now benefit from implementing
the init_cpu/exit_cpu ops in place of managing their own cpuhp state;
only the automatic filtering and context migration is tied to the new
cpumask-specific scope.

v2 fixes the definite functional mishaps from v1; as for the comments
and other subtleties I'd rather know what real human maintainers think.
I'm still not entirely sure about trying to put ->exit_cpu() calls in
perf_pmu_free() for the sake of symmetry - it looks like it would be a
little fiddly to get right, and as far as the system PMU drivers go,
the ones which aren't already using _nocalls variants for remove/
probe-failure teardown anyway look to be just wrong and making
exactly the mistakes I'm trying to clean up: doing a bunch of busywork
chasing around the affinity of an IRQ that's about to be freed, plus
calling perf_pmu_migrate_context() with an unregistered PMU! I do see
at least arm-spe, coresight-trbe and riscv-sbi actually doing some kind
of vaguely meaningful per-CPU disable, so perhaps the question of
whether it's common enough to be generic or simple enough to open-code
can wait for a future generic hotplug conversion of those?

Thanks,
Robin.


Robin Murphy (2):
  perf: Generic hotplug/cpumask for system PMUs
  perf/arm-cmn: Switch to generic cpumask

 drivers/perf/arm-cmn.c     | 96 +++++++++-----------------------------
 include/linux/perf_event.h | 19 ++++++++
 kernel/events/core.c       | 78 +++++++++++++++++++++++++++----
 3 files changed, 110 insertions(+), 83 deletions(-)

-- 
2.54.0.dirty


Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14D3033EC
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004680; cv=none; b=PJA3FZzYhh+7kG5Nb8+VEAKu7GaTLKxgFjoeSt/LWAaaGNB8Rza9n+qIvw0IB5Ab7zUdGdqiI1+DqN/rnjB+1nv1BtUdXZquFFSCuRD+VgwSx/aaRh0enNnm9vo2u8wgPNdHNHwYho3gyjfcZDDA142H5sjcnjMkJV3vJNt6Kr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004680; c=relaxed/simple;
	bh=Cldqk0T4bqBsY7t9dyJshqCFFkgUH6dgBPVkheiwoqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Git4CsCWAuWMsnNyj7fen5QUWReUWAonFD2fKmRi/FUQ6lCGqlwELsJ18M5LeQBdFUSJPZkdzTT0zhXIqqNeonlDc/moAoeUu/mQIdpyeizuiF2syh4YtmF8s32eaBa3WOmfgHoP+ALP9g7NvDMrB0UgKBvs9zCOWpRH/PWlSJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aOQAfDjB; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aOQAfDjB"
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Cldqk0T4bqBsY7t9dyJshqCFFkgUH6dgBPVkheiwoqM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790004676; v=1; x=1790609476;
 b=aOQAfDjBX/uHJDk6TrAksHRE69buKV2hcMUw+8ZAdZZzJBdR+p2xucLokSMr3MOANgTpxhY4
 c2dSYGsCEvMsiEDlzvtCMus+sgZgGTp8l23A5PD20pA4qMMcfMWTkE1u1csVktJi/KQw3OlVdQT
 dfN9XnGZum5ujyyDHmok/YiU=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 6ebe27a16f4fd00e;
	Mon, 21 Sep 2026 15:31:15 +0000
X-Mizu-Trace-ID: 6ebe27a16f4fd00e
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	x86@kernel.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH 0/2] perf/x86/amd/uncore: Drop redundant counter slot searches
Date: Mon, 21 Sep 2026 08:30:13 -0700
Message-ID: <20260921153108.2713179-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both amd_uncore_add() and amd_uncore_del() search ctx->events[] for an
event whose counter slot is already recorded in event->hw.idx.

Perf serializes ->add() and ->del() for an event, and the driver never
moves an installed event between slots, so an installed event can only
be at the recorded index. Both searches are redundant.

Neither callback is normally hot. That changes once more events target
a PMU than it has counters. Perf then multiplexes them: every mux tick
deschedules the resident set and schedules the next one, so both callbacks
run for each rotated event on every tick.

Meta's fleet-wide profiles attribute 1.1% of kernel CPU time, excluding
do_idle(), to amd_uncore_add() and amd_uncore_del() combined. On the
host that exposed this, a workload holding 15,782 perf event file
descriptors drove 56,575 calls per second into each callback from mux
rotation, against a 16-counter DF PMU.

Patch 1 removes the scan in amd_uncore_add(). It walks every counter
before the free slot search, which is the common case once multiplexing
has scheduled the event out.

Patch 2 makes amd_uncore_del() free the recorded slot directly instead
of rescanning from slot zero. Deleting all events from a full PMU with
N counters drops from N * (N + 1) / 2 compare-exchanges to N.

No functional change intended.

Usama Arif (2):
  perf/x86/amd/uncore: Remove redundant event slot scan
  perf/x86/amd/uncore: Free counter slot by index

 arch/x86/events/amd/uncore.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

-- 
2.53.0-Meta


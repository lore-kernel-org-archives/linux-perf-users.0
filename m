Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656861DDD1;
	Thu, 15 May 2025 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329386; cv=none; b=Kdkb6m0ZlrkzFVBeZ6jPoWgvgwnXYzKCG9AZlYvcAEygbTk0nadTQP8Ro/2tssBxOz40IzX9TFNAdmdQ8yjViToMeWgMUq+RMOns5pRl1gxC8sXsox0aABPJRCwLtyHK4BRfFGWWjGeJB7gA9O3leWPaUKyU3tK0KtpAiTDfyu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329386; c=relaxed/simple;
	bh=Vw4WEkclDr1GGKoxm4vvIt6vwMIbQuuQMXPj+KoindA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C1gngxCWJHCNBWkG2SpYpgn+d0oEHdfzNYWhs1mT53cuIdLJqi9hBDztDgD9j8VnMlL9OIMAd3DJfB6mqPDIm/AjZ76HFD8kmfIjMy99jAc3wRfHKqv4zJSj9SmMo8B59TppS2GsZX2KjeH5mufLmZPzeqc61WF2b21cUnip5LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fKlAN+Te; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Co839R3z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fKlAN+Te";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Co839R3z"
Date: Thu, 15 May 2025 17:16:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747329382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u30DGWx84jmgZeTyazFg+3FQdniCQfpgI//ck4i7XuY=;
	b=fKlAN+Te57M9lwCsybgPc4jximkBWF2Tt9FtJBKivr/FWQiiJIyi4AEZ5uRGxAz0R6e3Pe
	4oZsvTLlnr0Da9N9QFAuOuIgoLwllp/5tUDUmDIqN/MCwK7egPaWnOFEVM3Ai813BRty5d
	225JtMguSHhqXNILE+kTfcwy6bJH28yW9DmZiTFlLfiS+IhgaoCaVsw/NTQSQF2X3jhmdJ
	x6ysEsOEz1go5fG8+M+XLFFadV0TEauOKttNGUw1j5zwsA2gH7zEN0GT9G+1gfIh56hjc2
	k/5NrqHC4G8lYzZng+hhuunk85xd+0ikX4FBoYosi5XrL+E9I1dQfbwA7qRKRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747329382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u30DGWx84jmgZeTyazFg+3FQdniCQfpgI//ck4i7XuY=;
	b=Co839R3zCDxtrOISgMwmh9dwdJmPoDZQw4uogv64WQey8etNrR1PSNIUdSCa1vSvZ598Gt
	00Nf0Q9GxW810qCg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Fix segfault with PEBS-via-PT with
 sample_freq
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250508134452.73960-1-adrian.hunter@intel.com>
References: <20250508134452.73960-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174732938125.406.12231233963068767961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     99bcd91fabada0dbb1d5f0de44532d8008db93c6
Gitweb:        https://git.kernel.org/tip/99bcd91fabada0dbb1d5f0de44532d8008db93c6
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 08 May 2025 16:44:52 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 15 May 2025 18:15:54 +02:00

perf/x86/intel: Fix segfault with PEBS-via-PT with sample_freq

Currently, using PEBS-via-PT with a sample frequency instead of a sample
period, causes a segfault.  For example:

    BUG: kernel NULL pointer dereference, address: 0000000000000195
    <NMI>
    ? __die_body.cold+0x19/0x27
    ? page_fault_oops+0xca/0x290
    ? exc_page_fault+0x7e/0x1b0
    ? asm_exc_page_fault+0x26/0x30
    ? intel_pmu_pebs_event_update_no_drain+0x40/0x60
    ? intel_pmu_pebs_event_update_no_drain+0x32/0x60
    intel_pmu_drain_pebs_icl+0x333/0x350
    handle_pmi_common+0x272/0x3c0
    intel_pmu_handle_irq+0x10a/0x2e0
    perf_event_nmi_handler+0x2a/0x50

That happens because intel_pmu_pebs_event_update_no_drain() assumes all the
pebs_enabled bits represent counter indexes, which is not always the case.
In this particular case, bits 60 and 61 are set for PEBS-via-PT purposes.

The behaviour of PEBS-via-PT with sample frequency is questionable because
although a PMI is generated (PEBS_PMI_AFTER_EACH_RECORD), the period is not
adjusted anyway.

Putting that aside, fix intel_pmu_pebs_event_update_no_drain() by passing
the mask of counter bits instead of 'size'.  Note, prior to the Fixes
commit, 'size' would be limited to the maximum counter index, so the issue
was not hit.

Fixes: 722e42e45c2f1 ("perf/x86: Support counter mask")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Link: https://lore.kernel.org/r/20250508134452.73960-1-adrian.hunter@intel.com
---
 arch/x86/events/intel/ds.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 9b20acc..8d86e91 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2465,8 +2465,9 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
 				setup_pebs_fixed_sample_data);
 }
 
-static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, int size)
+static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64 mask)
 {
+	u64 pebs_enabled = cpuc->pebs_enabled & mask;
 	struct perf_event *event;
 	int bit;
 
@@ -2477,7 +2478,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, int
 	 * It needs to call intel_pmu_save_and_restart_reload() to
 	 * update the event->count for this case.
 	 */
-	for_each_set_bit(bit, (unsigned long *)&cpuc->pebs_enabled, size) {
+	for_each_set_bit(bit, (unsigned long *)&pebs_enabled, X86_PMC_IDX_MAX) {
 		event = cpuc->events[bit];
 		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
 			intel_pmu_save_and_restart_reload(event, 0);
@@ -2512,7 +2513,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 	}
 
 	if (unlikely(base >= top)) {
-		intel_pmu_pebs_event_update_no_drain(cpuc, size);
+		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
 		return;
 	}
 
@@ -2626,7 +2627,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 	       (hybrid(cpuc->pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED);
 
 	if (unlikely(base >= top)) {
-		intel_pmu_pebs_event_update_no_drain(cpuc, X86_PMC_IDX_MAX);
+		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
 		return;
 	}
 

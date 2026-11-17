Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.215.233.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947038;
	b=kLM+7gLnRXEplrZP5Mp87+NdYDO9VdHDNQAl0cLzs9KU/4hXWwwjnRBOCAT0z2R9tcAw
	 ht4QS89OWdfH5Q0TT9/RO83iuQoD/+UIo0WFYufII3aYEYhivsNpjXxI9hU8cwwRDLkMN
	 0KDxxK9+eGUD4pxyhaikQfRGmduiZjrJsWwLzxD2bzvNaIWmQ/cxeIcPP3RMc1RpqWuLv
	 EDiTHaVy4HqFCeHFttwaynIHFn3Lj5VB0rA/EDM4wVcfalhGtc5jTmd3srx0iZDmDg7aB
	 T3cYDdb+I5V8hIBbvHisO7ENj7/CLkNJmrRb6MmTIYYIDXuGbP9CGX7ZFO2jKCmHTBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947038;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rxARBXF17nydjljBWVKwhRacn4Q2l+TVTwmO6HqYRTw=;
	b=U/REH8Ug4CAvV6SmNOqfdq918aNtFLByGG0zHnlgMmpw4ZAfAg2dx8U7Q2EsLcJvPz2Y
	 DaEKqR2Wb9RV01r+EVCMMCdeJe1P8FoxwOHhce91/KS6RReZ+yFcPAkoEcjrVrCOTJQEQ
	 kIZbaXdu13rw7TMMfB374NRqwS2UvV/F8NG/+ihAr80I9P6nZyX1E3vXAFAbKtGMIh2N4
	 hWp1Ye07xUJSAIcrIV4OhF5373oBVe6VojzCJ1aPwVv8ha2AT1FH6G1ErBrAtn7Akft2z
	 yiZyZROJ7cQrf4DGqZk11PoS5UjkFRrm5/sGM97i3kXd7VU3R0Ng9KCRlcODTter5DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=janestreet.com;
	spf=pass smtp.mailfrom=janestreet.com;
	dkim=pass header.d=janestreet.com header.i=@janestreet.com header.a=rsa-sha256 header.s=waixah header.b=w8i1lJ0j;
	arc=none smtp.remote-ip=64.215.233.18
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D2606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB2D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=janestreet.com header.i=@janestreet.com header.a=rsa-sha256 header.s=waixah header.b=w8i1lJ0j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1794947031;
  bh=rxARBXF17nydjljBWVKwhRacn4Q2l+TVTwmO6HqYRTw=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References;
  b=w8i1lJ0jkLursNGIPy6zGlW2JzR6Y/441VhpQeExCyw9IwAbH7jHkQ1rA7Pn+7vM9
  tHVuT82qdzli5uqt2ckYkSzRK7Ja2zxUQS0LefrMrhJEtXGEnTeSsOetpFsyP5uipO
  xkwYJN8R7mJrPjZF0UYFxCwOUW3jDadXGcGHpjHMNk7x0oIpYqAnjZA4arKAAm+Yrh
  iv1Mue1ZTW3KX1SFR49SmY+C/3waP0Db3ne2pqvT1KWc3UoZk1zdhuB1/vvM3LN8hv
  OTMSHE67ZCkMF8SA9bA9gSFIZfgCzfHttyLiUGFc6Og2wLG+xHmd7OZPXx7vtHMuj4
  y+5+QGVjYO6vg==
From: Gregg Leventhal <gleventhal@janestreet.com>
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
     Ingo Molnar <mingo@redhat.com>,
     Arnaldo Carvalho de Melo <acme@kernel.org>,
     Namhyung Kim <namhyung@kernel.org>,
     Mark Rutland <mark.rutland@arm.com>,
     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
     Jiri Olsa <jolsa@kernel.org>,
     Ian Rogers <irogers@google.com>,
     Adrian Hunter <adrian.hunter@intel.com>,
     James Clark <james.clark@linaro.org>,
     Mark Barnett <mark.barnett@arm.com>,
     linux-kernel@vger.kernel.org,
     Jay Hilton <jahilton@janestreet.com>,
     Andrew Delgadillo <adelgadillo@janestreet.com>,
     Eric Hagberg <ehagberg@janestreet.com>
Subject: [PATCH] perf/core: Use the elapsed period for frequency-mode period adjustment
Date: Tue, 17 Nov 2026 15:23:51 -0500
Message-ID: <20261117152351.1294050-1-gleventhal@janestreet.com>
In-Reply-To: <CAFN_u7G94CC_RGL1La66jX+jRKHSJdAB5PKkTRSWrUvqhM48oQ@mail.gmail.com>
References: <CAFN_u7G94CC_RGL1La66jX+jRKHSJdAB5PKkTRSWrUvqhM48oQ@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jay Hilton <jahilton@janestreet.com>

In frequency mode, __perf_event_account_interrupt() estimates the event
rate from hwc->last_period and the time since the previous overflow,
and passes it to perf_adjust_period().

The PMU drivers re-arm the counter before they call
perf_event_overflow(), and re-arming sets hwc->last_period to the
period of the next interval. The estimator therefore divides the next
period by the time the previous one took. While the period ramps up
from its initial value, each period is much larger than the previous
one, so the rate is overestimated by that ratio and the period
overshoots its target.

On an AMD EPYC 9655P running v7.3, sampling user-mode cycles at 11 Hz,
the period jumped from 21.9M to 2.3G cycles, 5.6x the target, and the
next sample arrived after 544 ms instead of 91 ms. When the overshoot
exceeds 8x, the next tick's perf_adjust_period() resets period_left,
and the cycles counted before the reset are not attributed to any
sample (145M in that run). Intel and AMD IBS show the same overshoot.
On Intel, intel_pmu_freq_start_period() hides it for the default
hardware events, but not for raw events.

Since commit 1734d98fbcce ("perf/arch: Record sample last_period before
updating on the x86 and PowerPC platforms"), the PMU drivers record the
elapsed period in data->period before re-arming. Pass that to the
estimator instead of hwc->last_period. perf_event_account_interrupt(),
which has no sample data, keeps using hwc->last_period.

Fixes: abd50713944c ("perf: Reimplement frequency driven sampling")
Closes: https://lore.kernel.org/all/CAFN_u7G94CC_RGL1La66jX+jRKHSJdAB5PKkTRSWrUvqhM48oQ@mail.gmail.com/
Assisted-by: LLM
Signed-off-by: Jay Hilton <jahilton@janestreet.com>
Signed-off-by: Gregg Leventhal <gleventhal@janestreet.com>
---
Notes (not part of the commit message):

This fixes the overshoot reported in the Closes: thread.

Tested on v7.3 with and without this patch, using the reproducer from
the report and repeated runs (user mode, 11 Hz unless noted). Runs
with the bug, i.e. a period over 2x the target or a sample whose period
doesn't match the cycles counted:

  AMD EPYC 9655P (Zen5), bare metal   v7.3         v7.3 + patch
    cycles                            50/50        0/50
    instructions                      50/50        0/50
    raw cycles                        50/50        0/50
    cycles, 4000 Hz                   10/10        0/10
    IBS (ibs_op, incl. kernel)        20/20        0/20
    max period / target               up to 7.0x   1.00x

  Intel Xeon Platinum 8468, bare metal v7.3         v7.3 + patch
    raw cycles (0x3c)                 49/50        0/50
    cycles                            0/50         0/50
    instructions                      0/50         0/50
    max period / target               up to 6.8x   1.02x

(On Intel, intel_pmu_freq_start_period() already keeps the default
events close to the target, so only the raw event shows the bug.)

With the patch, the period approaches the target from below, as the
low-pass filter intends (9655P, target ~411M cycles):

        period      counted    dt(ms)
          2371         1791     0.001
         11854        11880     0.004
      28341794     28341765     6.284
     251213029    251213027    55.579
     411087485    411087548    90.895

Base: v7.3. The code this touches is unchanged in v7.4-rc2. Builds
cleanly with W=1.

All perf_event_overflow() callers under arch/ and drivers/ in v7.3
initialize the sample data with the period recorded before re-arming,
so data->period is the elapsed period on every path we checked.

perf_event_account_interrupt() still passes hwc->last_period, and this
patch doesn't change its callers. Two of them run after the counter
has been re-armed, so they still feed the estimator the next period:
perf_ibs_handle_irq() when it discards a sample (user/kernel mode
filtering, the load-latency and fetch-latency filters, and the
zero-RIP erratum workaround), and powerpc's record_and_restart() for
an invalid SIAR. The Intel PEBS error path runs before re-arming and
is fine. We haven't measured the IBS discard case; if it's worth
fixing, those callers could pass the elapsed period too, in a
follow-up.

On kernels without 1734d98fbcce, x86_pmu_handle_irq() and
handle_pmi_common() still put the next period in data->period, so a
backport there also needs 1734d98fbcce.

The original change was written by an AI coding assistant in Jay's
session. This version, the changelog and these notes were prepared
with an AI coding assistant; Jay and I reviewed them, and I ran the
tests above.

 kernel/events/core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c4217c996..55b72a044 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10592,8 +10592,15 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 }
 EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
 
+/*
+ * @period is the period of the interval that just ended. PMU drivers
+ * re-arm the counter before calling perf_event_overflow(), which sets
+ * hwc->last_period to the period of the next interval, so the overflow
+ * path passes the sample's period instead.
+ */
 static int
-__perf_event_account_interrupt(struct perf_event *event, int throttle)
+__perf_event_account_interrupt(struct perf_event *event, int throttle,
+			       u64 period)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int ret = 0;
@@ -10621,7 +10628,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 		hwc->freq_time_stamp = now;
 
 		if (delta > 0 && delta < 2*TICK_NSEC)
-			perf_adjust_period(event, delta, hwc->last_period, true);
+			perf_adjust_period(event, delta, period, true);
 	}
 
 	return ret;
@@ -10629,7 +10636,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 
 int perf_event_account_interrupt(struct perf_event *event)
 {
-	return __perf_event_account_interrupt(event, 1);
+	return __perf_event_account_interrupt(event, 1, event->hw.last_period);
 }
 
 static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *regs)
@@ -10757,7 +10764,7 @@ static int __perf_event_overflow(struct perf_event *event,
 	if (unlikely(!is_sampling_event(event)))
 		return 0;
 
-	ret = __perf_event_account_interrupt(event, throttle);
+	ret = __perf_event_account_interrupt(event, throttle, data->period);
 
 	if (event->attr.aux_pause)
 		perf_event_aux_pause(event->aux_event, true);
-- 
2.43.7


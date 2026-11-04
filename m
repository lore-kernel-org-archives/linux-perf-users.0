Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818160;
	b=ESlMHddniiRDsZw4x+CxZXs9hjbli0ogibGj0SGpX2pzjy5oHbfffNVwOwLUV+CgPZPA
	 m0KGcLB28MEpyFrO3Llbaj26Mn/1OApidXgkpDb3SFNndIKMAJ67ZO9G10hQn5xsytdK1
	 6UFYFswYRdEheSf1pSaM05GxJspd4kY6bGNnAbvi9JYbPBNm+u370iAsvHfjUjH9qggF9
	 Zb/yk53aOdPlIWHLuTvJ8fmrXDSWwojI3cQQ2XsEQEArzfzEKFUhW+bFjzV9Kla6Q8QOr
	 Vdu84L9PmjTFd/cbMa5F4gjgEM8KURbFcQafC8nkeoYHvfOlZbGQwk3aqA//8/JFkQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MrVZIFY9xpRe5kGm25GXPuJKC2m6ZmcUrunMXbmenrs=;
	b=gXFUHycs9URCSAxQfj96dlUL8Z4uopG51wSV9VNibIuvh2C2e4kFrovrdXDNEJbwsGoR
	 JNHFMEbUcmIZL8n5sUcTcrmDn7OkbEhlVcRJdPPey5GI+mo9YCRZwwUPQbhtDQYYYhF+v
	 bTtaEylU5EItI5zQ1hMS2C/eC874nXBtb0jbkeo4dj6L1KrwxFGk1tq7RuULq8GgoKbD6
	 vk070fOJfcPjPd/aJ4/YIUcXGDhVAW4wsGve3Zs7yZM76LKVdTiOC09HTKr8L9k+qmq53
	 uOd3P/8/bBiJYdJfrlqaA5PGTzuQg+YU0gF9Qhgeodppc55Uyh1Xk2jmZetrbVe2BmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ztJspIif;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07E606D83D
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E07E606D83D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ztJspIif
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8aea7b7ca0cso11605747b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 10:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818159; x=1794422959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MrVZIFY9xpRe5kGm25GXPuJKC2m6ZmcUrunMXbmenrs=;
        b=ztJspIif9KEZJVeoG3u8+Vb8w3ge3wYyCCP+0qXbfwT0oDGPowkN9keJdubIUe97U/
         Wg5I+NZCgkYfrCcYYqVNmvpfH88d6CsM6SQ8RUf+1yLsKXqlhrIWJBi+Swk6uoFsby2Q
         ERxoeHKlj+WyGXmOVQTpVdM+N4E8YWxj7wZ26Dg0caKKpt8Ho+42PhxHXNtXkhXE2xa2
         8eTVXSRKb4U4116u67tAgeQqDb6bcobt3HFUU98AM26xIev+PCHAAZVRGu9/nLM4104A
         70xNwRL2XzOgTaptSxRwO3erRKs3cZ/SoIKXElqS+ucXzsFY34vLC4FQIVXrhB4bMc0b
         9NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818159; x=1794422959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MrVZIFY9xpRe5kGm25GXPuJKC2m6ZmcUrunMXbmenrs=;
        b=XiDpMHVVRcnymo5SqqhhdU2GGds+r+YY4MZMUAmhoBlGoDYY3CylxRVWX2JI5OoDkT
         Hkfr9nsW61VUBgBt9I2NfLzniRRmbBi3TuE0QFt1wf7cdDXt3Uwci7axcVVO7caVOBe3
         SWeDYamnv244yZYyWpWe2tMnMLvdjzW4++TjU/Bb+TBrJFjJGir8J9CQG9PIdJpZeo9a
         5Z1FGt7NPe60kLKAO03ia855UsvIzmcHQur/4+asfIjhM2korrvBXuZ0I9/r/2UvYlKD
         ZiJ49hpEMXUDoYREENxCWwdzU1sBpt0Q4nMW/07hG3CYN90Icd36vMLwFjHDARPehol2
         Xljw==
X-Forwarded-Encrypted: i=1; AKwUvBwDR0cvNcx5vMKkeYXuHm4V44o2g5S0DxRw0E0Zs2U83TvI1schstAPpYUeByO7LVvwrYxj4MNt5kjUuQ9m/94o@vger.kernel.org
X-Gm-Message-State: APuU4Z8aGwym+sPTj7igIPuaYiVC8qZFT4NKFwiDRLojiWqJ+f/4YfeZ
	qtMIijBH8O53b3Y03nQT54+eSXPRqmcyneaLQylZldGj32RLOhtOMkAk
X-Gm-Gg: AYBFou2dFogFe1uEHgCY61mkHamlQ3ChEZ8uxpvnOSp4xzScGyn9tNeoI2qpD/CyqA7
	4ZLLXNtej0A688K5/EZcp/VsyUL9l+2PHyMiogUQdyacoJrX2s0jJ5NpDcxsvmdJLNWbhJKWugZ
	3dnWh+YEkQWQufG0nsYuFDkNBcDFNTSjE/2jYwynV0GtWKwdeHyFw0DocHQyr1Z9EPNwsZe6poc
	WyFGdhvs2i1H3sihg3vCyE3+qSTeyKHC54WxhLrfpf76uP4or7ixAfolw8wGrHV6bCG6lJq6vlt
	V6JZ/xU2cgOxlq9/EU9pezZjbH+IH87QTNifFcGLbVixnWFJ4R2a78NEjyvDUsnY0cj4c0DEq8d
	PbipKIYxq4IrXMFy7bmkTYz8rcMBOGvF+SBLtNfTQt3vt/ZF7nZAG10KeDsr7WzsUdx4bWM9jv+
	grFOou+KsQUTdA18EGJ252wrW7/PZNHSOpAmxFX1CMltfSeixE28XA6XO8O1HJ/ye42dU+EXZaT
	Gy/FdEH/FnseAuN+aCiNkceOjtjL/pxtZy463zs3sVr9TLVurlWqz7xyXnHWAcqR/7syAI8dRfW
	XDXqDyM4aChiCGGjMMQ28uzPdwY3HqHHkG46mErMHE4apHVXfVue0P2ipy8sFBIPkxQ7QNPEFgy
	7U8JIQiJDIA==
X-Received: by 2002:a05:690e:4105:b0:67c:41a:bf62 with SMTP id 956f58d0204a3-67c041ace87mr92159d50.31.1793818159061;
        Wed, 04 Nov 2026 10:49:19 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67bee202bc4sm1998531d50.4.2026.11.04.10.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:49:18 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 04 Nov 2026 13:49:12 -0500
Subject: [PATCH v6 05/13] alpha/perf: ignore overflow interrupts the
 counter does not account for
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-alpha-profileme-v6-5-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
In-Reply-To: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6094; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=72vScTB6O6dHaasPBS0wMYfMhBz3Vy2ucix9UsfhK9I=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe16lMqlN+diT4kryDcbHe+WdC+bfVo2oOrwmdU3taJ
 z+l2Xlqx0cWBjEuhpliiixx6xVZZrXtWOpzWvoXzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGMVD5PQYNDKLi0tTi3TTCooc8vJLEksy8/OK9fILUvMK0gv00jLTSjIy8ouKU4FG6OWllpi
 6OroZGRqYWDpamDlZOJqaODs7GTq5OTo6uzoZWZqbGDhbOpq4WpozcHEKwFwT08rI8O7pi5SGVS
 +4lQQNtcy79VoXHHkakc+WyVRp7eWT6NblzsjQxfLjRcbd7YETtxZs4tzgME0koOb7H5OX9z/Xu
 wS0/9nODgA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The interrupt handler adds a full counter period to the count of the
event on the counter that interrupted, which goes wrong in two cases.

Rewriting a counter does not cancel its pending interrupt: wrperfmon has
no way to, and PALcode clears the request only when delivering it. An
interrupt pending when an event is reloaded, or when perf moves another
event onto the counter, is then taken as an overflow of a counter that
has not overflowed. It adds a bogus period to the count and can emit a
false sample.

And alpha_perf_event_update() already adds the period when a read finds
that the counter overflowed before its interrupt was taken. The
interrupt then adds it again.

An overflow leaves the counter just past zero, below the value it was
written with, while a counter that has not overflowed is at or above it.
Ignore an interrupt for a counter in the latter state, unless a read
has already counted the overflow, in which case add nothing. For this to
hold, write the counters at most half their range below overflow, as
armpmu_event_set_period() does. Counting events then take an interrupt
every 2^19 events rather than every 2^20.

Fixes: 979f867191f8 ("alpha: implement HW performance events on the EV67 and later CPUs")
Suggested-by: Ian Rogers <irogers@google.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 59 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index ecec78c355cd..dd7fc4ac1396 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -30,6 +30,9 @@
 #define MAX_HWEVENTS 3
 #define PMC_NO_INDEX -1
 
+/* hw_perf_event.flags */
+#define ALPHA_PERF_FLAG_WRAPPED		0x1
+
 /* For tracking PMCs and the hw events they monitor on each CPU. */
 struct cpu_hw_events {
 	int			enabled;
@@ -315,10 +318,16 @@ static int alpha_perf_event_set_period(struct perf_event *event,
 	if (unlikely(left < alpha_pmu->pmc_left[idx]))
 		left = alpha_pmu->pmc_left[idx];
 
-	if (left > (long)alpha_pmu->pmc_max_period[idx])
-		left = alpha_pmu->pmc_max_period[idx];
+	/*
+	 * Start at most half the counter's range below overflow, so that the
+	 * value an overflow leaves, just past zero, is always below the value
+	 * written. See alpha_perf_event_ovf().
+	 */
+	if (left > (long)(alpha_pmu->pmc_max_period[idx] >> 1))
+		left = alpha_pmu->pmc_max_period[idx] >> 1;
 
 	local64_set(&hwc->prev_count, (unsigned long)(-left));
+	hwc->flags &= ~ALPHA_PERF_FLAG_WRAPPED;
 
 	alpha_write_pmc(idx, (unsigned long)(-left));
 
@@ -338,9 +347,9 @@ static int alpha_perf_event_set_period(struct perf_event *event,
  * zero.  The value passed via ovf by the interrupt handler corrects for
  * overflow.
  *
- * This can be racey on rare occasions -- a call to this routine can occur
- * with an overflowed counter just before the PMI service routine is called.
- * The check for delta negative hopefully always rectifies this situation.
+ * A call to this routine can occur with an overflowed counter just before
+ * the PMI service routine is called. A negative delta detects this, as the
+ * counter is always written at most half its range below overflow.
  */
 static unsigned long alpha_perf_event_update(struct perf_event *event,
 					struct hw_perf_event *hwc, int idx, long ovf)
@@ -359,10 +368,12 @@ static unsigned long alpha_perf_event_update(struct perf_event *event,
 	delta = (new_raw_count - (prev_raw_count & alpha_pmu->pmc_count_mask[idx])) + ovf;
 
 	/* It is possible on very rare occasions that the PMC has overflowed
-	 * but the interrupt is yet to come.  Detect and fix this situation.
+	 * but the interrupt is yet to come.  Detect and fix this situation,
+	 * and tell the interrupt not to count the overflow again.
 	 */
 	if (unlikely(delta < 0)) {
 		delta += alpha_pmu->pmc_max_period[idx] + 1;
+		hwc->flags |= ALPHA_PERF_FLAG_WRAPPED;
 	}
 
 	local64_add(delta, &event->count);
@@ -835,6 +846,32 @@ void perf_event_print_debug(void)
 }
 
 
+/*
+ * Return the overflow that an interrupt from counter idx adds to the count,
+ * or -1 if the counter has not overflowed since it was written.
+ *
+ * Rewriting a counter does not cancel its pending interrupt: wrperfmon has
+ * no way to, and PALcode clears the request only when delivering it. So an
+ * interrupt can arrive after the counter was reloaded or given to another
+ * event. The counter is then at or above the value written, whereas an
+ * overflow leaves it just past zero, below that value.
+ */
+static long alpha_perf_event_ovf(struct hw_perf_event *hwc, int idx)
+{
+	unsigned long prev;
+
+	/* alpha_perf_event_update() has already counted this overflow. */
+	if (hwc->flags & ALPHA_PERF_FLAG_WRAPPED)
+		return 0;
+
+	prev = local64_read(&hwc->prev_count) & alpha_pmu->pmc_count_mask[idx];
+	if (alpha_read_pmc(idx) >= prev)
+		return -1;
+
+	return alpha_pmu->pmc_max_period[idx] + 1;
+}
+
+
 /*
  * Performance Monitoring Interrupt Service Routine called when a PMC
  * overflows.  The PMC that overflowed is passed in la_ptr.
@@ -847,6 +884,7 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	int idx, j;
+	long ovf;
 
 	__this_cpu_inc(irq_pmi_count);
 	cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -891,7 +929,14 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 	}
 
 	hwc = &event->hw;
-	alpha_perf_event_update(event, hwc, idx, alpha_pmu->pmc_max_period[idx]+1);
+	ovf = alpha_perf_event_ovf(hwc, idx);
+	if (ovf < 0) {
+		/* The interrupt was pending when the counter was written. */
+		wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
+		return;
+	}
+
+	alpha_perf_event_update(event, hwc, idx, ovf);
 	perf_sample_data_init(&data, 0, hwc->last_period);
 
 	if (alpha_perf_event_set_period(event, hwc, idx))

-- 
2.55.0


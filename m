Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0215B0F5
	for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801793; cv=none; b=tKuZLgJkQkuaNWBtCQmGiAVG9c7eN9fphZfjQjMFzAxKz9jJcjcayAUZYcBY7XxcwRY4pOaYIWHBR8mye1P7sBXTEbf7WMikWPQcaI1fgh33cEOl+XzRvu1wqgDyMhMdkCJRD/2iJN+IFvXbs4DkcR1aSNHHJD0WfdQp097Ao+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801793; c=relaxed/simple;
	bh=0lSt7QVBUAdOGQGjlbIPqXYDj232a+VWY9UlJ/ZrpNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ggU3oCNLp44jFJ0Yw9dYeF4fROpflXv6yOUw5j3C0opgkr91XUhd9Qvcoc86pnZNei+diBznTixK6PQDUkPuUSJWJfyJuf0RFddPUMBvK3bgFmwfraMuvSnrDQhismDZX2SW+MgzLuseND3REggOHmf1mVy1pQcBNcJ43Wb2VqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqcJeDG4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqcJeDG4"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so10180065276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715801791; x=1716406591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YlmXNn2pYx8wzd3I64r7rBzQTUUgwVUdbiBLIDfo5/M=;
        b=nqcJeDG4VS51tGH0eNlWJoGayc4RrT+yo5IBujXLTc4nPTLlc2J4p0MMFR32Z7lSaz
         ppcz2KvOuj7LrhOsRg55PtbeID9JycUPJ3eBGVK/tNGq4VucWozqkxdSfOLbbpO17prQ
         sWuIwN/jjBE0ZVMEaXfgWjGSIq9S/BjpTOsyJ0pFRhip7B5v0uD4dEKyeFnTS0D5n18u
         ZOtkM/+FANKK4yv6kaJytaB+sGQZ0xeirNUOBMRqpsASkfeSJfn3MyxcKjiA2GpNJCoe
         VYBzMiX3v+wqmc/4Hv15pHNVBYWLdjNPr+sHBe+DMe/BXRA9qH02YVCEQXwRfaEcAhmy
         sgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715801791; x=1716406591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlmXNn2pYx8wzd3I64r7rBzQTUUgwVUdbiBLIDfo5/M=;
        b=onbY4bLFj78hkFuW7wXJ/9UKX/45KOia1QKJQo4yPuH6jc2QiFfhWohu8BVm3zJr1y
         duVArPG8P87b7LgB7uZQSN+++w5Qhrdb0RT8cFuvbx8Pqdno6DJKEsl92fp/luylDIfD
         ZYgNif/Q4xo7rispflP9uHH5CuFY0W27zF6OmHq9a7yrx4jN1fwEefXo0ls8XW8oOKOX
         OV21x+OawC3KGjtNJ8gUAF9aRwkXZDtbhNyDDxeTs6jtR9AsYyw7RryCLYzG5pQioiGt
         F4/Dqw+bpKsTHL36+zl/tnXWZj4Pf7iNe+p3WdU0GMEcJabhHL9S6yfwYn+vzXq1uXGV
         ULJw==
X-Gm-Message-State: AOJu0Yw9dEyllkqqhRFw2aMwen8hZNGHzjvT60YcVMo0btavWskz0NwB
	sh1yP0YmTfiILZqrivyoSRhj6cCysxyHOOeCHAqzEvZx1inFK///fUAZzEi2aaLjyNprNsFV+HL
	q
X-Google-Smtp-Source: AGHT+IGytyoLkOH431aR7mF4/3pxrMXnoPzF9EPSCOORKbwwc0MQGbSUWr23nIhRDL3iPMPF3Uv+te+uzcs=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:6e4e:954d:1e49:f87c])
 (user=yabinc job=sendgmr) by 2002:a05:6902:2b83:b0:de5:2ce1:b62d with SMTP id
 3f1490d57ef6-dee4f4bfba9mr1543914276.10.1715801790944; Wed, 15 May 2024
 12:36:30 -0700 (PDT)
Date: Wed, 15 May 2024 12:36:08 -0700
In-Reply-To: <20240515193610.2350456-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515193610.2350456-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515193610.2350456-3-yabinc@google.com>
Subject: [PATCH v5 2/3] perf/core: Check sample_type in perf_sample_save_callchain
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Check sample_type in perf_sample_save_callchain() to prevent
saving callchain data when it isn't required.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Yabin Cui <yabinc@google.com>
---
 arch/x86/events/amd/ibs.c  | 3 +--
 arch/x86/events/intel/ds.c | 6 ++----
 include/linux/perf_event.h | 5 +++++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c3a2f6f57770..f02939655b2a 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1129,8 +1129,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	 * recorded as part of interrupt regs. Thus we need to use rip from
 	 * interrupt regs while unwinding call stack.
 	 */
-	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(&data, event, iregs);
+	perf_sample_save_callchain(&data, event, iregs);
 
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e010bfed8417..c2b5585aa6d1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1655,8 +1655,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(data, event, iregs);
+	perf_sample_save_callchain(data, event, iregs);
 
 	/*
 	 * We use the interrupt regs as a base because the PEBS record does not
@@ -1823,8 +1822,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(data, event, iregs);
+	perf_sample_save_callchain(data, event, iregs);
 
 	*regs = *iregs;
 	/* The ip in basic is EventingIP */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fefac1a57b56..bda066c33120 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1235,6 +1235,11 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 {
 	int size = 1;
 
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+		return;
+	if (WARN_ON_ONCE(data->sample_flags & PERF_SAMPLE_CALLCHAIN))
+		return;
+
 	data->callchain = perf_callchain(event, regs);
 	size += data->callchain->nr;
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


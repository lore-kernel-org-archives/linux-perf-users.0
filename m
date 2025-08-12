Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7464282E1;
	Tue, 12 Aug 2025 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022312; cv=none; b=OCbAmL+c9L6NadqO6JZI3HrxaPEmc7RKPWAz9bAMzRh02AtWZurOWtHDhKGFl9P7ptm6qUXZlwGT5vneV/sijMfdEw1QzzreEAs5E0szPQPqrLy4e1DCzZnrSbRqmRis4qSH5O7f4pv0Ao4JDcV+d6IlGsELyqXpvf5HqYKq5ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022312; c=relaxed/simple;
	bh=IPuyGTmGXMHr2tPOmZNLid39cwl5Ro+vwFkF52X02UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZEDyeG2bZQXwH615QRIwmDXDhN/B9xAQxO6ze27gG1grhuAkZS+M6mAKB2GL6nr/+i4hR7HuKqw6AARP+4W8Q48rp0tcS8T6wvX0+TnkyxxFRxIzW/7G/lK++4kKhF0lRCptGSRKu8PXT502UresJsErPlKW4rQDAzPRuelbuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76ba6200813so495883b3a.0;
        Tue, 12 Aug 2025 11:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755022310; x=1755627110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Sc0iVOrEVFOByaHU7AVFmw7/jwWHw2s7ViclReSH2Q=;
        b=V0V5T3ZLquqogwp3KiqYZX4mY3suSloKcaxZTD5BR3fcdweRP9pBUaXmUchIp4p+jd
         Y0suiyZrKjAxpDFYHqT/3/wRANaidSNKvCtOiS2hHo1fmKwbkBEqXrBdUeXvwIU+bwmW
         VEoDzN3vrS4xGQKzfIvEifovoZe234LPCHFlVV6fsD+aQndz1/GfUDV1IuqrRh4cv+Kw
         4xAkpe77Ic7+UN7GlUuVhe7U5nFgcs3J4fELnLVTgOQVB36WouALHeNANb6DMuZVnkrQ
         LJMgSOrjQE/388E77eUlUrjHUd39MiS5/jl8FlFsKcCxyvDdqwjxsV5Eg18TqrqbWpWG
         qCmg==
X-Forwarded-Encrypted: i=1; AJvYcCWkcTWfzL/ZYiXIqjGEMfaAb3MoNIHi3oa/4iR8o2p9IPh63JKk+/d/dcXdfHdObsJYiGbAfDfWUkL20B4=@vger.kernel.org, AJvYcCX55PWVzA4LaO/H7avyoLUMQzX2KGWgwXvy8YAPphTg+wgHk10+hXzo8IQ+yPhvcnhqU7qIQMvzRmZskXhi1SGj+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwckHC3xP70Hwf4ibsn5vyiMB7+beR6s15SdLZeYaUMadXKQpHV
	E5+ysYHTstpMm67IK91WPUJQwWD9yJhCk6rneF+BrBASF6mc8NCPC6pr
X-Gm-Gg: ASbGncttuNLcPOjiGjQDML8RPFvTwOdfOFsOyWryMoL/0FKWUQaSDEhd7/3zJgN5xOO
	5HfkIM6e8FvdOz4hDMDGgp7LUNR3vf+YNmIebRWed1Uweuk9mX1qzyhWSrsvZV/iEbBYpLUb0nA
	OMssX9F32Su2fDFL6Tuq0kg61VEyT+McZDa8qkUf7QwBfAeje2RBwQn1N0Vh1AYPJ/CtncyDGeS
	LeKD7natmL01ad14NZD7Cmj+LXA8Mgd369g0yAlP5FgeHKhEs7qWfkpQ55jE8pqLVwr+W/zdFON
	Jy9g3SdRSrkUp+RGUGMD2AqWMwn/4E6Ke5ItkDrf9vPYGb4yyGVCpGKzKtwQ21RFZoPQxzvrU+3
	LZMuqlHPh0O7iQKSypmZXBbU=
X-Google-Smtp-Source: AGHT+IGjJiOgFGABGQ9x06XkqaQHRFpKGeWGp1hYW0cDylnclyQZGbxcp9GEIjL1o/o42pInwYYYEw==
X-Received: by 2002:a05:6a20:7d86:b0:23d:da6d:b050 with SMTP id adf61e73a8af0-240a8b4fda3mr131209637.6.1755022310014;
        Tue, 12 Aug 2025 11:11:50 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm26177530a12.56.2025.08.12.11.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:11:49 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Austin Kim <austindh.kim@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH v3] perf: Avoid undefined behavior from stopping/starting inactive events
Date: Tue, 12 Aug 2025 18:10:47 +0000
Message-ID: <20250812181046.292382-2-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling pmu->start()/stop() on perf events in PERF_EVENT_STATE_OFF can
leave event->hw.idx at -1. When PMU drivers later attempt to use this
negative index as a shift exponent in bitwise operations, it leads to UBSAN
shift-out-of-bounds reports.

The issue is a logical flaw in how event groups handle throttling when some
members are intentionally disabled. Based on the analysis and the
reproducer provided by Mark Rutland (this issue on both arm64 and x86-64).

The scenario unfolds as follows:

 1. A group leader event is configured with a very aggressive sampling
    period (e.g., sample_period = 1). This causes frequent interrupts and
    triggers the throttling mechanism.
 2. A child event in the same group is created in a disabled state
    (.disabled = 1). This event remains in PERF_EVENT_STATE_OFF.
    Since it hasn't been scheduled onto the PMU, its event->hw.idx remains
    initialized at -1.
 3. When throttling occurs, perf_event_throttle_group() and later
    perf_event_unthrottle_group() iterate through all siblings, including
    the disabled child event.
 4. perf_event_throttle()/unthrottle() are called on this inactive child
    event, which then call event->pmu->start()/stop().
 5. The PMU driver receives the event with hw.idx == -1 and attempts to
    use it as a shift exponent. e.g., in macros like PMCNTENSET(idx),
    leading to the UBSAN report.

The throttling mechanism attempts to start/stop events that are not
actively scheduled on the hardware.

Move the state check into perf_event_throttle()/perf_event_unthrottle() so
that inactive events are skipped entirely. This ensures only active events
with a valid hw.idx are processed, preventing undefined behavior and
silencing UBSAN warnings. The corrected check ensures true before
proceeding with PMU operations.

The problem can be reproduced with the syzkaller reproducer:
Link: https://lore.kernel.org/lkml/714b7ba2-693e-42e4-bce4-feef2a5e7613@kzalloc.com/

Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 kernel/events/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8060c2857bb2..872122e074e5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2665,6 +2665,9 @@ static void perf_log_itrace_start(struct perf_event *event);
 
 static void perf_event_unthrottle(struct perf_event *event, bool start)
 {
+	if (event->state != PERF_EVENT_STATE_ACTIVE)
+		return;
+
 	event->hw.interrupts = 0;
 	if (start)
 		event->pmu->start(event, 0);
@@ -2674,6 +2677,9 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
 
 static void perf_event_throttle(struct perf_event *event)
 {
+	if (event->state != PERF_EVENT_STATE_ACTIVE)
+		return;
+
 	event->hw.interrupts = MAX_INTERRUPTS;
 	event->pmu->stop(event, 0);
 	if (event == event->group_leader)
-- 
2.50.0


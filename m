Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8256B634;
	Sat, 11 Jan 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736618235; cv=none; b=vCLg+hQ0YVRNSiracNZkPnNc0dCr5MLGKsQ37TWgByECKZb1mllAxERSNpiUqPjcKsRR0b67UcrmxvLX05xBuBne0WHb7iqoOal8rEUj736ecLvRqg3VU4tcSUfgRWioXIZukJKGKDmUKcXtlqmUlRu+LPblfcXDnCX0W1xUe8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736618235; c=relaxed/simple;
	bh=ZuPmFlnqHGfNcIlCYBxbCIL1fkijr3wBaqL1e8akxDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GO404vpcUchDqzXzneqHj0E4StYkuxS8b5n0ao8tjCoo+Thjf+UwJwFsC7KLXDkPEC5SyxltPqLOpELNicsP/MY06fUP5juXzjeGW7W2slbbd0dftt5t3hXH0jDhAM54hZQZqWQCUfNUeeXIV2aEeQ4xe+v9PO0nqk6i5ERbZMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6e4d38185so292166985a.0;
        Sat, 11 Jan 2025 09:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736618232; x=1737223032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVCyocSWQeL6rl9UsMQxUJ/1ipLs5qXVXl8X7iHttI0=;
        b=Nbld3etqbRl2vj2z4iW+XyycCrg3UPmk/Xu3GiMfZL53Qcd3+uY2aKpN+5uwd58S/4
         L33ywTEnN+4zswoI2fEXRZcI+JbkWzpQsUXGPpV/dyho/ItqIkY9/AW6pVwuCKlusZae
         69E2oO4SDpWQZJJJaG4J+GEzW0yzfz6hE1Cr8a7bKZ+Nv4hnULyUcR7qIc0ewt/xT52t
         cM1VYngeECmSsMM/0/1Ea1BLwM+oKf/8QcCMBkphRFOCh6XOtEPBQ8p68yTmYujyqIMh
         tLidWmjDubsLlIdfSprIe45w4qRwysc+BsTJRKjHBxUvI0ADI5CVfvOM3homElyiQmBq
         //+A==
X-Forwarded-Encrypted: i=1; AJvYcCWFicPzqXa9Dal1XfBgkvdr7rEIDjw+JXJwvKVP5Jdm6rWAJl1U9fB0lnqbIyk1RQ/FSBNmhlEjsu4z6Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZEIPjv49Ts+JBNCQaOrddTJJZBLmwA+x5X3zvT5pt8jOemQZH
	Uaz2aOQbvHBLfEnKrCMtyvQBj//i5BJ9YtRTpIqEi0V4k2linmWYn2OYTo+U
X-Gm-Gg: ASbGncs4WtwM5BDu46XkyJW5U4bHujx1oU/15VIe1wLnUPlFYJzXPP/lvJe3nTpnDul
	1LMtxVnIg8nlxa3zXlzecFDIMmtWUthH+LY+RlcXrPqWjaZhqZNVLO+PlnEPIY53tV7+NxC8syb
	6l4h2i0AQqm8BXhjCHOvJzjJD6mowS+S61OjnF8j6R25rgmgVeeqSkOH+TTLiz0i6r2fY1YpLxg
	JNn4wk10SJgr6EDclngAJGppd2qCYDQWjwYLgv9zX5by7KbV62AKAHE2cuvXj4poPR8LGFJA3B3
	VLEf3vQ=
X-Google-Smtp-Source: AGHT+IGtDd6eCkoJ/Y3CclmwLt/y1hNoBTm71vFwD6OQPNfBvk1hnKaCTEH5rCqCQiWCp7D75hOTNA==
X-Received: by 2002:a05:620a:24c6:b0:7b6:f34b:cdd2 with SMTP id af79cd13be357-7bcd97a4e6cmr2707065585a.53.1736618232189;
        Sat, 11 Jan 2025 09:57:12 -0800 (PST)
Received: from tachyon.tail92c87.ts.net ([192.159.180.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248304sm300273785a.31.2025.01.11.09.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 09:57:11 -0800 (PST)
From: Tavian Barnes <tavianator@tavianator.com>
To: linux-perf-users@vger.kernel.org
Cc: Tavian Barnes <tavianator@tavianator.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Kreimer <algonell@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf intel-pt: don't zero the whole perf_sample
Date: Sat, 11 Jan 2025 12:56:17 -0500
Message-ID: <d841b97b3ad2ca8bcab07e4293375fb7c32dfce7.1736618095.git.tavianator@tavianator.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

C designated initializers like

    struct perf_sample sample = { .ip = 0, };

set every unmentioned field of the struct to zero.  But since
sizeof(struct perf_sample) == 1384, this takes a long time.

struct perf_sample does not need to be fully initialized, and even
.ip = 0 is unnecessary because intel_pt_prep_*_sample() will initialize
it.  Skipping the initialization saves about 2.5% of the execution time
when running

    $ perf script --itrace=i0

Signed-off-by: Tavian Barnes <tavianator@tavianator.com>
---
 tools/perf/util/intel-pt.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 30be6dfe09eb..c829398c5bb9 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1764,7 +1764,7 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 	struct dummy_branch_stack {
 		u64			nr;
 		u64			hw_idx;
@@ -1835,7 +1835,7 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 
 	if (intel_pt_skip_event(pt))
 		return 0;
@@ -1867,7 +1867,7 @@ static int intel_pt_synth_cycle_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 	u64 period = 0;
 
 	if (ptq->sample_ipc)
@@ -1894,7 +1894,7 @@ static int intel_pt_synth_transaction_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 
 	if (intel_pt_skip_event(pt))
 		return 0;
@@ -1927,7 +1927,7 @@ static int intel_pt_synth_ptwrite_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 	struct perf_synth_intel_ptwrite raw;
 
 	if (intel_pt_skip_event(pt))
@@ -1953,7 +1953,7 @@ static int intel_pt_synth_cbr_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 	struct perf_synth_intel_cbr raw;
 	u32 flags;
 
@@ -1983,7 +1983,7 @@ static int intel_pt_synth_psb_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 	struct perf_synth_intel_psb raw;
 
 	if (intel_pt_skip_event(pt))
@@ -2009,7 +2009,7 @@ static int intel_pt_synth_mwait_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 	struct perf_synth_intel_mwait raw;
 
 	if (intel_pt_skip_event(pt))
@@ -2034,7 +2034,7 @@ static int intel_pt_synth_pwre_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 	struct perf_synth_intel_pwre raw;
 
 	if (intel_pt_skip_event(pt))
@@ -2059,7 +2059,7 @@ static int intel_pt_synth_exstop_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 	struct perf_synth_intel_exstop raw;
 
 	if (intel_pt_skip_event(pt))
@@ -2084,7 +2084,7 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 	struct perf_synth_intel_pwrx raw;
 
 	if (intel_pt_skip_event(pt))
@@ -2235,7 +2235,7 @@ static void intel_pt_add_lbrs(struct branch_stack *br_stack,
 static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evsel *evsel, u64 id)
 {
 	const struct intel_pt_blk_items *items = &ptq->state->items;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 	union perf_event *event = ptq->event_buf;
 	struct intel_pt *pt = ptq->pt;
 	u64 sample_type = evsel->core.attr.sample_type;
@@ -2407,7 +2407,7 @@ static int intel_pt_synth_events_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 	struct {
 		struct perf_synth_intel_evt cfe;
 		struct perf_synth_intel_evd evd[INTEL_PT_MAX_EVDS];
@@ -2446,7 +2446,7 @@ static int intel_pt_synth_iflag_chg_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample;
 	struct perf_synth_intel_iflag_chg raw;
 
 	if (intel_pt_skip_event(pt))
-- 
2.47.1


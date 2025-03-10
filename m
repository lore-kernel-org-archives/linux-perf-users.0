Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6DD1DE2B9
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636527; cv=none; b=GGDsyHP7VPmT8EYYl+0Zny9n7qUi32bpZXIvtzMW306LUs8iNy/Pb6XzlvZ9jWzSUrDSGYgKcUNiPo127NZKayXa/J2sm35Dcuj9683UzVvCiYuFL+i3+JZIXQHSObab8x5ubYXu4LLF1WlGOBr/nziOg8DZwRSR/9gzNKbsm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636527; c=relaxed/simple;
	bh=PdPgmcBYIWEeNLSGXkHHbQNrOkp0XMuWoBrNvNBx1oE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=O6CSUJwaIFe1WWRISTWG5+zodV90km1enguqPbJw2BtYPHiJGvBGl6NZ5hCj5tt3biOIrt9bQS0lQ6vrFi6W32clvPeCeh8vMZe7vScZi5oTdjp40hzduryTU4XxMh4lzXNEOAN9yffrLCQT6FIoWB+QDZsBky5ja/5mOlYtSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTkF/7VO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTkF/7VO"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-223a2770b75so82977915ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 12:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741636525; x=1742241325; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mtw5A6pnErP63NBf+2oMOxljRBPUk1W+HOiO6no4Q+Y=;
        b=GTkF/7VOrGQiew+TawzbLnyyCrEYOCyiUjfEQYSkkHgCY+XH2lnlaz0X7gmZrj9dqS
         nFSKJBVBTuOERhWChbz20kpkNmNncYwWS2T0t5lX2J0XqryqzrXKp8t13bSVmT+tV1Kd
         bxRxWI7DMaT8npi/EA9Vzy/dI+7vzUXlhXMwo/34VBf4GmMAehr+oDMxPv9b2etQnY5J
         DzdjEdmHITZBdxG+YeoHuT8ZchmWeqMy7d7UM6keZaF3tCPGeITrYkkA1M8YgS66u293
         kq7eRAsOSDKtEys0wV9a1pKFZ/IduYYizyOopFk8WGZ854tAJam/4akymZ+kIpaCcsry
         cRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636525; x=1742241325;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mtw5A6pnErP63NBf+2oMOxljRBPUk1W+HOiO6no4Q+Y=;
        b=nwCYJoac0UFUkvmPqBbDGhJhmLy0coHmGiyNZLeoY08RoiYnA2/1suaqwB2Fq90pHf
         Y8VrU4MA9lZP8U9r29sU2s/QnvNwD7EMQIeaGAoxCokvLGN0/5PE+1rTuRh4S7tMO2Bv
         WJrHyYeIEHo/xKFZ1wt4lPfO6jiX1Ad1rmUWh7R41wBIeV+CRsk1pV7qBGBg5IsMCrfX
         LiPLRDUWlKxJXZaK6RRgXo7ay0wN6p7345J1ZQhI/KJtwPd5z9Q+ouiEXKnejMEuxmjB
         2NC07DR48UvnCnVIcQ5oorRz7ZOdptXami6OLDoaIGgSmsrAFDtGNpAtAhFIV5yVLkcm
         8tuA==
X-Forwarded-Encrypted: i=1; AJvYcCUM6WgT6ZzkW6F80wEtJb+1iG9uh9QYHuvA0ufwEzhZXIt0MMUUHvubIuGmqr7oD819UPnEQ5tUnrCXgjNv2eWQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9ERlfy49hAZzDAwjWMiUnU/QysnMSx2aPGq78A02QxAytPVs
	vRkHCi7ZBjWEi5hrbfvuMW1qOUiCPTi4jQPDMkn7gBIhk5ZSlroAIqxokBIBwutYAd/7farAJQn
	I1BmoAQ==
X-Google-Smtp-Source: AGHT+IFGWlShb5kIWxI+81Al+aKaRpPgOqN7dElfZLMAJXDNRxxbs9Dr7UEPZnwpTE1mHFFuj6jma5OrHpr5
X-Received: from pllo19.prod.google.com ([2002:a17:902:7793:b0:223:5a6e:b17])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c6:b0:224:13c0:58e3
 with SMTP id d9443c01a7336-22428bf1976mr198632485ad.51.1741636525408; Mon, 10
 Mar 2025 12:55:25 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:55:17 -0700
In-Reply-To: <20250310195518.2012571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250310195518.2012571-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250310195518.2012571-2-irogers@google.com>
Subject: [PATCH v1 1/2] perf parse-events: Make legacy events always have
 priority over sysfs/json
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

This reverts the behavior of commit a24d9d9dc096 ("perf parse-events:
Make legacy events lower priority than sysfs/JSON"). That commit
states:

  As part of that report Mark Rutland <mark.rutland@arm.com> requested
  that legacy events not be higher in priority when a PMU is specified
  reversing what has until this change been perf's default behavior.

with an Acked-by: Mark Rutland <mark.rutland@arm.com> tag. Mark
expresses this preference here:
https://lore.kernel.org/lkml/ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com/
On an Alderlake this commit caused `cpu_core/instructions/` to be
encoded as:

  ------------------------------------------------------------
  perf_event_attr:
    type                             4 (cpu_core)
    size                             136
    config                           0xc0 (instructions)
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    enable_on_exec                   1
    exclude_guest                    1
  ------------------------------------------------------------

While `instructions` would be encoded as:

  ------------------------------------------------------------
  perf_event_attr:
    type                             0 (PERF_TYPE_HARDWARE)
    size                             136
    config                           0x400000001
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    enable_on_exec                   1
    exclude_guest                    1
  ------------------------------------------------------------

As the event parsing for legacy events uses parse_events_add_numeric,
rather than the more generic PMU handling case, we end up with the
same event name being encoded two ways. However, as instructions is
also a cpu_atom event on Alderlake, or any hybrid system, the PMU
prefixes are added in the stat output meaning instructions is reported
as cpu_core/instructions/ and cpu_atom/instructions/ even though those
events are encoded differently and potentially have different
behaviors. We shouldn't be having the same event with two different
encodings and I followed up the commit with changing the
prioritization of legacy events also when no PMU is specified in
commit 617824a7f0f7 ("perf parse-events: Prefer sysfs/JSON hardware
events over legacy").

RISC-V have been asking that legacy events also be a lower priority
than sysfs/json to avoid driver complexity. They've since had to work
around this issue meaning it isn't a necessity:

  If the overriding legacy with JSON is available, each future vendor
  may just provide the json file instead of modifying the driver.
  However, it will be a matter of convenience and clutter free future
  rather than a necessity at this point.

https://lists.riscv.org/g/sig-perf-analysis/topic/110906276#msg458

Landing the commit making encoding consistent and having sysfs/json a
priority has been pushed back against by Namhyung Kim, Arnaldo
Carvalho de Melo and James Clark. James assert the ARM drivers are now
fixed and don't need the prioritization. RISC-V's interests have been
ignored. The fact that legacy events are antiquated, imprecise in
meaning, brittle, misleading and don't give us a way to fix kernel
issues in software, have also been ignored:
https://lore.kernel.org/lkml/Z8sMcta0zTWeOso4@x1/

Given the push back against sysfs/json being a priority, contrary to
Mark Rutland's insistence this was the sensible way to do things,
contrary to RISC-V's wishes, and contrary to my own preference that
legacy events do become legacy, this patch changes the priority back
to legacy events being the priority consistently - that is
instructions and cpu_core/instructions/ are both encoded using legacy
events. It isn't a straight revert as clean-ups/refactorings are kept
in place.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 13 +++----------
 tools/perf/util/parse-events.c  | 26 +++++++++-----------------
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 5ec2e5607987..78e8ae825bf8 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -162,16 +162,9 @@ static int test__checkevent_numeric(struct evlist *evlist)
 
 static int assert_hw(struct perf_evsel *evsel, enum perf_hw_id id, const char *name)
 {
-	struct perf_pmu *pmu;
-
-	if (evsel->attr.type == PERF_TYPE_HARDWARE) {
-		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, id));
-		return 0;
-	}
-	pmu = perf_pmus__find_by_type(evsel->attr.type);
-
-	TEST_ASSERT_VAL("unexpected PMU type", pmu);
-	TEST_ASSERT_VAL("PMU missing event", perf_pmu__have_event(pmu, name));
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->attr.type);
+	TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, id));
+	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__hw_names[id], name));
 	return 0;
 }
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 35e48fe56dfa..04bb70ba4292 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1023,12 +1023,10 @@ static int config_term_pmu(struct perf_event_attr *attr,
 			return -EINVAL;
 		}
 		/*
-		 * Rewrite the PMU event to a legacy cache one unless the PMU
-		 * doesn't support legacy cache events or the event is present
-		 * within the PMU.
+		 * Rewrite the PMU event to a legacy cache one as legacy events
+		 * take priority over sysfs/json.
 		 */
-		if (perf_pmu__supports_legacy_cache(pmu) &&
-		    !perf_pmu__have_event(pmu, term->config)) {
+		if (perf_pmu__supports_legacy_cache(pmu)) {
 			attr->type = PERF_TYPE_HW_CACHE;
 			return parse_events__decode_legacy_cache(term->config, pmu->type,
 								 &attr->config);
@@ -1049,19 +1047,13 @@ static int config_term_pmu(struct perf_event_attr *attr,
 			return -EINVAL;
 		}
 		/*
-		 * If the PMU has a sysfs or json event prefer it over
-		 * legacy. ARM requires this.
+		 * Rewrite the PMU event to a legacy cache one as legacy events
+		 * take priority over sysfs/json.
 		 */
-		if (perf_pmu__have_event(pmu, term->config)) {
-			term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
-			term->no_value = true;
-			term->alternate_hw_config = true;
-		} else {
-			attr->type = PERF_TYPE_HARDWARE;
-			attr->config = term->val.num;
-			if (perf_pmus__supports_extended_type())
-				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
-		}
+		attr->type = PERF_TYPE_HARDWARE;
+		attr->config = term->val.num;
+		if (perf_pmus__supports_extended_type())
+			attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
 		return 0;
 	}
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68293C9897
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648391; cv=none; b=H5ekYBGOyEEphYDyqmTnb7fKC1zMxkg0PtPQtqFRXHoTZN8FuW6f6IAkvff6SugBwRW1JUG+Emvb8ZCXNVDi26KCpwNx6KEg5Id5a0rYIFw7NfB25hYYBGuNPV/+LRaIDtWVqdXmOwVgaZX9RjvVH8xo+llj3aMpHLNbHPMrLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648391; c=relaxed/simple;
	bh=7lJMrIpbUJatL42JgkTjkAlodo4agqRRJmp/WJZ09N4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WnPCisMt5CyHL0zgIzqCWuf71uRoJA1Rg86U2pC5lTN89Sc2qFOLQDQWSZ+vZaQzwEvi8ranxVXm7nqwmO55JdfLvAR95z/6D8v0rAOqueK+4G0oyYiG5viXsJcrU/D71VtBKGmdKhMasDNfz4iraFj0PB4L5g35nuT/ks9Ul/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7TPtTBu; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7TPtTBu"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-142f4306744so739462c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 19:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790648389; x=1791253189; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SxuaAdKGLQo3SX9yWslu6cVjHc7eTb67lCtoktwWy1g=;
        b=v7TPtTBu8+HQzzLrpTBaksmigB3uJ09PPucAr4PlgV5X0Uj03ldguIpk5SnzsQkcx5
         GNp6my8gLTL/fQHqnu90bONd0CmkszpFGfYBIVz6oNcQXriCfRtqh+NfLyEchRWk2aG9
         QQHTlSiA00rE15471xhSyLOCPdVgBqcpgz+vMbm9+1cWkVIxJ67hbR/hGK5WbFyyfPdV
         /5RXiwycSBF+f81geso41JjyVtVo4G8hE5bTpeVc6hdXmSr3e7v4qb1stNB+Ac532rsu
         Dxut2hBn2xZ+zxX2fbpXBSNP/ru6/VLk5Eq8h0byHDJ5zpzYtHUG6D03qPaW9jO7GNas
         0upA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790648389; x=1791253189;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SxuaAdKGLQo3SX9yWslu6cVjHc7eTb67lCtoktwWy1g=;
        b=x6W/05xxmNoeA0Xi4VXQ/bBXZ6+XlizNN1lx6rCTBJuAhzM+RDs4R5NrweFjrdmhfx
         rIDx58UBLdS+MFoEXzIn+Rceslhr/T2bXDHc4vvotkk0Q08hb66wyfvHQNneyC7xh/mj
         SCU53GfqL4R9yKkNKTMsv1T1Z0+WcNkHzzm+jOPoDjuIvrTWTxy+7TJRDmD7h1RL12ky
         gY7Gi30LBCwgUbgsvivF8S+qRtbmatEIauAg6UmK+G3F0rqfO3wS/d0u8EWcC2dvvsAW
         MIHOWbymJUYE3CIPFj1nKPIWqCbh0xCRfCjCJqAOTiiULY+8YAnuOdroLrWoTB7olK2f
         Bu0w==
X-Forwarded-Encrypted: i=1; AKwUvByDBBKuuP5rsV2WF/EC6fr7eM+yGA74MQXEqfKUTxHRyO6OC7uKwWP9l8IOzqr0uaUcfJhxjw5iu9sdko01Q6X9@vger.kernel.org
X-Gm-Message-State: AFuF++mTQCdFtYO7rDBY3IOHYfBoXbLS+IeaWyKuLkZ/EOJmCUczRCpj
	FsTI2Ct1tno+EFwDu8IEPrBGg/NsTIPRJc3+AHNKo03pddCG18wNpqcrzBFRZSkQ38Gc/lHOorR
	i3021AT1gRg==
X-Received: from dlbsj5.prod.google.com ([2002:a05:7022:f905:b0:14a:e5a1:544a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:231b:b0:14a:88ce:74fb
 with SMTP id a92af1059eb24-14a88ce79aemr3504057c88.45.1790648388405; Mon, 28
 Sep 2026 19:19:48 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:19:13 -0700
In-Reply-To: <20260929021913.56010-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929021913.56010-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929021913.56010-10-irogers@google.com>
Subject: [PATCH v1 9/9] perf pmu: Fix race with concurrent tracepoint creation
 and removal in perf list
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf_pmus__print_pmu_events() first counts events via
perf_pmu__num_events() to allocate the aliases array, then populates it
via perf_pmu__for_each_event(). When dynamic tracepoints (such as
kprobes or uprobes during 'perf test' runs) are concurrently created or
removed between the two passes:
- If an event is removed, state.index is smaller than the allocated len,
  leaving trailing zeroed entries in aliases[] with name == NULL and
  pmu == NULL, which causes qsort(cmp_sevent) or the print loop to crash
  with SIGSEGV.
- If a dynamic tracepoint subsystem directory is removed while scanning
  /sys/kernel/tracing/events, tp_pmu__for_each_tp_event() returns
  -ENOENT and aborts enumeration of all remaining tracepoint subsystems.
- If an event is added, perf_pmus__print_pmu_events__callback() aborts
  enumeration when state->index reaches state->aliases_len.

Grow state->aliases dynamically via realloc() when needed, use
state.index as the actual populated length for sorting and printing, and
ignore -ENOENT when a tracepoint subsystem directory disappears during
enumeration.

Fixes: c3245d2093c1 ("perf pmu: Abstract alias/event struct")
Fixes: 45b6e281cb06 ("perf tp_pmu: Add event APIs")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c   | 20 ++++++++++++++++----
 tools/perf/util/tp_pmu.c |  8 ++++++--
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index e0a4cb2428ca..137abad37c33 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -571,7 +571,7 @@ static int cmp_sevent(const void *a, const void *b)
 	}
 
 	/* Order by event name. */
-	return strcmp(as->name, bs->name);
+	return strcmp(as->name ?: "", bs->name ?: "");
 }
 
 static bool pmu_alias_is_duplicate(struct sevent *a, struct sevent *b)
@@ -581,7 +581,7 @@ static bool pmu_alias_is_duplicate(struct sevent *a, struct sevent *b)
 		return false;
 
 	/* Don't remove duplicates for different PMUs */
-	return strcmp(a->pmu_name, b->pmu_name) == 0;
+	return strcmp(a->pmu_name ?: "", b->pmu_name ?: "") == 0;
 }
 
 struct events_callback_state {
@@ -597,8 +597,18 @@ static int perf_pmus__print_pmu_events__callback(void *vstate,
 	struct sevent *s;
 
 	if (state->index >= state->aliases_len) {
-		pr_err("Unexpected event %s/%s/\n", info->pmu->name, info->name);
-		return 1;
+		size_t new_len = max_t(size_t, 16, state->aliases_len * 2);
+		struct sevent *new_aliases;
+
+		new_aliases = realloc(state->aliases, new_len * sizeof(struct sevent));
+		if (!new_aliases) {
+			pr_err("Unexpected event %s/%s/\n", info->pmu->name, info->name);
+			return 1;
+		}
+		memset(&new_aliases[state->aliases_len], 0,
+		       (new_len - state->aliases_len) * sizeof(struct sevent));
+		state->aliases = new_aliases;
+		state->aliases_len = new_len;
 	}
 	assert(info->pmu != NULL || info->name != NULL);
 	s = &state->aliases[state->index];
@@ -654,6 +664,8 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 		perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state,
 					 perf_pmus__print_pmu_events__callback);
 	}
+	aliases = state.aliases;
+	len = state.index;
 	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 	for (int j = 0; j < len; j++) {
 		/* Skip duplicates */
diff --git a/tools/perf/util/tp_pmu.c b/tools/perf/util/tp_pmu.c
index c2be8c9f9084..5ac732e06841 100644
--- a/tools/perf/util/tp_pmu.c
+++ b/tools/perf/util/tp_pmu.c
@@ -151,7 +151,9 @@ static int for_each_event_cb(void *state, const char *sys_name, const char *evt_
 
 static int for_each_event_sys_cb(void *state, const char *sys_name)
 {
-	return tp_pmu__for_each_tp_event(sys_name, state, for_each_event_cb);
+	int ret = tp_pmu__for_each_tp_event(sys_name, state, for_each_event_cb);
+
+	return ret == -ENOENT ? 0 : ret;
 }
 
 int tp_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
@@ -176,7 +178,9 @@ static int num_events_cb(void *state, const char *sys_name __maybe_unused,
 
 static int num_events_sys_cb(void *state, const char *sys_name)
 {
-	return tp_pmu__for_each_tp_event(sys_name, state, num_events_cb);
+	int ret = tp_pmu__for_each_tp_event(sys_name, state, num_events_cb);
+
+	return ret == -ENOENT ? 0 : ret;
 }
 
 size_t tp_pmu__num_events(struct perf_pmu *pmu __maybe_unused)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


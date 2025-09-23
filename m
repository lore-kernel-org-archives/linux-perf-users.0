Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA93168E3
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666832; cv=none; b=iq2MyrZGu2VuFJUy2tr6YztASbRroeUFj8DwT0xLDNV9Yxbuj1xKqIR3nocPC8pRUUWj+tcnlCwTGGIAYVVcS5Cs+qBltzWVbw9Ew4fX7W5iCbeKdyhvRcs+EllwQ0BZzQhNmTFsrcG6Lxbr5y77oexFyc2DRBqNeuKUIH3W1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666832; c=relaxed/simple;
	bh=NWBAW3y8TVj1NFNioDjU58ZzRhKs/wIfiAJJKu8kiJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M7NmpTJYTWVvLKyAyPJOWq9ycIaBgK3OEQd22YvG2+4jBx+ijgyPfGPe7MxtdXJY5FSNQfSmZXRePYScgRg3zsx4dLkVODGi+noine6Dr9GKJ1B77e4+e3fJ+w+l2yMJCEpK1vujFQKOtEVFQUjXTCu5H9UjygG1qXZn2VHkwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OCSLdmRm; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCSLdmRm"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-3524dfcf121so272881fac.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666829; x=1759271629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7eBWQBMnNteQHZ1zVbXYWUdnzRH/KvDEdLro/KwtrM=;
        b=OCSLdmRmuEUOva1cUO8/6reeGhn44cGxqAvY57tptYKOX3iWdKl4nBtm8D5qH3JE8+
         tTJSAtoDkaueiCC90SUyfxinFpo4+SkcM8uYn1XEGToAFn4ZmeqO6848IO5Em52yDHkq
         envIGQg4cVabeEI0A6ww7qnrQXyMIYLFitk53m59yUFO4ciPDNQjjAornhfK1F78UGle
         JnC4SJQjlVy29rTlQZhBnyxlVOChJZg9qsjxtW/hRrt3FMJSsar1ywPf1NzqTKVU4ogT
         PCUwnuMbaRBpQPFYWmZO0gKnJDX1e5OjLyZNhpMLOr3GqWo+IgZa0Gy6sdjJ8/kwABRn
         lXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666829; x=1759271629;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7eBWQBMnNteQHZ1zVbXYWUdnzRH/KvDEdLro/KwtrM=;
        b=vLe8UAtfD/ulEVAEjSxXBcNfDtZYkSp7dqAjmvgKL35e6VhpbAcxjvybr4m1Xqefqs
         zzWbc+wTnPJljZtLlqgJ26jgkZYqepaEf3E0MX3CPPLVqspStgkvplFpKwSU/kGXBOCP
         ttreSOWUhkpoNO+ac9lF4hTsQReb9/g/NLIMrL8dnBQEZNGi0lRp9+QW1Bm6lvUr49lE
         e7EnMzaQ6inIHY2JWo7lM/kgUMovfJhZBJIwZcLG+ixWkS+IRwmzyLkElKHpG3gDsaV0
         FTXwtQqEJqVqDuJzqDPrkUVUWToW+0cAVGt1uZPAeisK3vj1PXNWOeRPcGdJvNipLz/n
         CEGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVCmdKdv67/it6fYyP7kYXOA6EUd4dmWk6GUj0DYkfBtTb36Jbtu3r8qlqYhLm5nP92SEFuJQm11VCoXMlCn8z@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49ZxzAf7rjQqKXYzoRuz+QHLKh+gSQXlh/OiSQ3hiem5m8Hsn
	uo+pd8XHJVtfbQUN56Y/Um/LbwN2xfqeKI5QsxNRTerbCTjlPqXRVE9oUFH+J1hG+rWDTKG+V/y
	G0EJ/v4JR+Q==
X-Google-Smtp-Source: AGHT+IFsNp1BNeCvhNyHEZa30SMugL3hMelc65X/Nm51JZ9+THP6wbg5FYVLP0e2BuitlACKyYXGE6i2Ssmy
X-Received: from oabxl16.prod.google.com ([2002:a05:6870:9f10:b0:31d:747e:8255])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:750b:b0:319:c702:5d20
 with SMTP id 586e51a60fabf-34c891db0a9mr2738415fac.49.1758666829509; Tue, 23
 Sep 2025 15:33:49 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:00 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-17-irogers@google.com>
Subject: [PATCH v6 16/28] perf print-events: Remove print_symbol_events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Now legacy hardware events are in json there's no need for a specific
printing routine that previously served for both hardware and software
events. The associated event_symbols_hw is also removed. To support
the previous filtered version use an event glob of "legacy hardware"
which matches the topic of the json events.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 18 +++++++----
 tools/perf/util/parse-events.c | 43 -------------------------
 tools/perf/util/parse-events.h |  1 -
 tools/perf/util/print-events.c | 57 ----------------------------------
 tools/perf/util/print-events.h |  3 --
 5 files changed, 12 insertions(+), 110 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index b6720ef3adf6..16400366f827 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -633,10 +633,18 @@ int cmd_list(int argc, const char **argv)
 			zfree(&default_ps.pmu_glob);
 			default_ps.pmu_glob = old_pmu_glob;
 		} else if (strcmp(argv[i], "hw") == 0 ||
-			 strcmp(argv[i], "hardware") == 0)
-			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
-					event_symbols_hw, PERF_COUNT_HW_MAX);
-		else if (strcmp(argv[i], "sw") == 0 ||
+			   strcmp(argv[i], "hardware") == 0) {
+			char *old_event_glob = default_ps.event_glob;
+
+			default_ps.event_glob = strdup("legacy hardware");
+			if (!default_ps.event_glob) {
+				ret = -1;
+				goto out;
+			}
+			perf_pmus__print_pmu_events(&print_cb, ps);
+			zfree(&default_ps.event_glob);
+			default_ps.event_glob = old_event_glob;
+		} else if (strcmp(argv[i], "sw") == 0 ||
 			 strcmp(argv[i], "software") == 0) {
 			char *old_pmu_glob = default_ps.pmu_glob;
 			static const char * const sw_globs[] = { "software", "tool" };
@@ -714,8 +722,6 @@ int cmd_list(int argc, const char **argv)
 				continue;
 			}
 			default_ps.event_glob = s;
-			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
-					event_symbols_hw, PERF_COUNT_HW_MAX);
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			print_sdt_events(&print_cb, ps);
 			default_ps.metrics = true;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f9c52eadac46..8d3eda3badfd 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -42,49 +42,6 @@ static int parse_events_terms__copy(const struct parse_events_terms *src,
 				    struct parse_events_terms *dest);
 static int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb);
 
-const struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
-	[PERF_COUNT_HW_CPU_CYCLES] = {
-		.symbol = "cpu-cycles",
-		.alias  = "cycles",
-	},
-	[PERF_COUNT_HW_INSTRUCTIONS] = {
-		.symbol = "instructions",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_CACHE_REFERENCES] = {
-		.symbol = "cache-references",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_CACHE_MISSES] = {
-		.symbol = "cache-misses",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = {
-		.symbol = "branch-instructions",
-		.alias  = "branches",
-	},
-	[PERF_COUNT_HW_BRANCH_MISSES] = {
-		.symbol = "branch-misses",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_BUS_CYCLES] = {
-		.symbol = "bus-cycles",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = {
-		.symbol = "stalled-cycles-frontend",
-		.alias  = "idle-cycles-frontend",
-	},
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = {
-		.symbol = "stalled-cycles-backend",
-		.alias  = "idle-cycles-backend",
-	},
-	[PERF_COUNT_HW_REF_CPU_CYCLES] = {
-		.symbol = "ref-cycles",
-		.alias  = "",
-	},
-};
-
 static const char *const event_types[] = {
 	[PERF_TYPE_HARDWARE]	= "hardware",
 	[PERF_TYPE_SOFTWARE]	= "software",
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 0db5e223e10d..23a42395d516 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -265,7 +265,6 @@ struct event_symbol {
 	const char	*symbol;
 	const char	*alias;
 };
-extern const struct event_symbol event_symbols_hw[];
 
 char *parse_events_formats_error_string(char *additional_terms);
 
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 91a5d9c7882b..8f3ed83853a9 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -186,60 +186,6 @@ bool is_event_supported(u8 type, u64 config)
 	return ret;
 }
 
-void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
-			 unsigned int type, const struct event_symbol *syms,
-			 unsigned int max)
-{
-	struct strlist *evt_name_list = strlist__new(NULL, NULL);
-	struct str_node *nd;
-
-	if (!evt_name_list) {
-		pr_debug("Failed to allocate new strlist for symbol events\n");
-		return;
-	}
-	for (unsigned int i = 0; i < max; i++) {
-		/*
-		 * New attr.config still not supported here, the latest
-		 * example was PERF_COUNT_SW_CGROUP_SWITCHES
-		 */
-		if (syms[i].symbol == NULL)
-			continue;
-
-		if (!is_event_supported(type, i))
-			continue;
-
-		if (strlen(syms[i].alias)) {
-			char name[MAX_NAME_LEN];
-
-			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms[i].symbol, syms[i].alias);
-			strlist__add(evt_name_list, name);
-		} else
-			strlist__add(evt_name_list, syms[i].symbol);
-	}
-
-	strlist__for_each_entry(nd, evt_name_list) {
-		char *alias = strstr(nd->s, " OR ");
-
-		if (alias) {
-			*alias = '\0';
-			alias += 4;
-		}
-		print_cb->print_event(print_state,
-				/*topic=*/NULL,
-				/*pmu_name=*/NULL,
-				type,
-				nd->s,
-				alias,
-				/*scale_unit=*/NULL,
-				/*deprecated=*/false,
-				event_type_descriptors[type],
-				/*desc=*/NULL,
-				/*long_desc=*/NULL,
-				/*encoding_desc=*/NULL);
-	}
-	strlist__delete(evt_name_list);
-}
-
 /** struct mep - RB-tree node for building printing information. */
 struct mep {
 	/** nd - RB-tree element. */
@@ -378,9 +324,6 @@ void metricgroup__print(const struct print_callbacks *print_cb, void *print_stat
  */
 void print_events(const struct print_callbacks *print_cb, void *print_state)
 {
-	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
-			event_symbols_hw, PERF_COUNT_HW_MAX);
-
 	perf_pmus__print_pmu_events(print_cb, print_state);
 
 	print_cb->print_event(print_state,
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 44e5dbd91400..eabba5d4a1fd 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -33,9 +33,6 @@ struct print_callbacks {
 /** Print all events, the default when no options are specified. */
 void print_events(const struct print_callbacks *print_cb, void *print_state);
 void print_sdt_events(const struct print_callbacks *print_cb, void *print_state);
-void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
-			 unsigned int type, const struct event_symbol *syms,
-			 unsigned int max);
 void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
 bool is_event_supported(u8 type, u64 config);
 
-- 
2.51.0.534.gc79095c0ca-goog


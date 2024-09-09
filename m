Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC3218C031
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914279; cv=none; b=hQT+gCJu/ieox/anpA4HmK4fDktvCP5aIWMuoPbd4gbVWtTqXaWHBZSNWiZgHejYXRK1wXJyrUt6SIH6bxqkibd5mjVsExbN4YZddGEPLDsLGuG+d0UIdCH7X5moqwwI52pmpEgwnSRl63yQrjku/zXVlxn8imIF+bWQZW3ITwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914279; c=relaxed/simple;
	bh=HptkHQHuvQDj1d3rSs7Sbbf5fWJ/fColrJrJTFzngig=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QZ2rCdhW760jyMU3EA/fXmjz4HZjFN/dn7PxLPW2jx6i62G5gWNg52fvOqrLtZi8oED0kps5XdCIsy0rTQlYE0iJfsTR+MSYE6MYtXV4uNXmojqCYZUIk09zCqGeChYE7ZRXpBGk4CEvO51oZgytmS4+JYFLvgRblRyTFQx6Jfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0A+5zuQj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0A+5zuQj"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03623b24ddso9692207276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Sep 2024 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725914277; x=1726519077; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReastPPbfrF1K+IO0MgSOanwMg0WzDPxfwAbYOVYAmc=;
        b=0A+5zuQjvWBAXaUm+hUXKt97y3j6Xqjd1Gg/XuNc6MTzeFb6Ud3k6+iBctfrPzaBfc
         2uE+iLkEL6jxkeg6vORuT/eQ5WGd/3cOYmnGuFmY/UaRGEER/BRJVwKatQ5fg+dd+xKH
         xe4T7PjqCWuVmkO0lu8+ChhcrGOOxfHK17wGJ+IMR+rL9gTKhQaD/s+dBMIdzTV8WR3u
         buPQ4bPV9mqbzGwg7lRM1HeGbASWdYlbbyylS+qkZHKQLHD/+0sG76WUTcLR9sBTAmw5
         qgEE2k9KrNAxB+a5MVYoe9os2x04XXBqLh8rVOn3S6T8FM4d+QJ9l5wPg1sRlouUFBCZ
         /L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725914277; x=1726519077;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReastPPbfrF1K+IO0MgSOanwMg0WzDPxfwAbYOVYAmc=;
        b=X10YRcRxGfp9iG+oSyZKz76YKwWRHAn0JyYH0w8h3GiASdMPlQdkTe0lzzonEzeF43
         Si596nLRq3Q77OhiWjEpm7RhZRUNl47y/TvUmsciHrJxMu/dAymUdu7DtF9A2IJhfPCQ
         5u1YKGgI9ZtuinU6AzFCEgGPalFmi2rtKq+X4mgzWQ5WhkC92uaB3SJONw+7Vo7eocTb
         a6WxEQE774DV4X87HpQresDCne/ISGVMNtkeIMfcXFA0n4A9bIwuTVHeEa/SxiO/a4eG
         CoR37rpGUT4kjRGfJtXcfJCnZvAViUfu7DekRNTFKdc0O3vHRa0m3HIpUkCQ4gQ/GC/3
         /5aA==
X-Forwarded-Encrypted: i=1; AJvYcCWszldbH1XtzpC69wcfAeG/1YjG/OX+eK0PD7T5gpQAUBFPFSY8ORGhtpG4XGNIVwdSB3UMjf0xHx2mXr9rhobk@vger.kernel.org
X-Gm-Message-State: AOJu0YxPrZFD9qhA6ntZyMrueEK65M5paVNfxGlPfJ7KkxC1OI1lDcSX
	T3FxXiINr2o8XTgP4OJflD5V61QbBcfiQFW4S9hJzgHDT5BXSocFFmxJhIv0RxqkFXw6ZfMsYAP
	dDG/g9g==
X-Google-Smtp-Source: AGHT+IEEO133mN0FLFV4W3AzE2rRP0msPowiLmvYMo3WDwZfY4rTrb7anK0cThA4Tw2iJw2eCeKbdObKrndc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b7b9:f9a0:1197:ff33])
 (user=irogers job=sendgmr) by 2002:a05:6902:4d1:b0:e0e:a784:2957 with SMTP id
 3f1490d57ef6-e1d34865f70mr32011276.1.1725914276607; Mon, 09 Sep 2024 13:37:56
 -0700 (PDT)
Date: Mon,  9 Sep 2024 13:37:40 -0700
In-Reply-To: <20240909203740.143492-1-irogers@google.com>
Message-Id: <20240909203740.143492-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240909203740.143492-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Subject: [PATCH v2 4/4] perf callchain: Allow symbols to be optional when
 resolving a callchain
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Casey Chen <cachen@purestorage.com>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In uses like perf inject it is not necessary to gather the symbol for
each call chain location, the map for the sample IP is wanted so that
build IDs and the like can be injected. Make gathering the symbol in
the callchain_cursor optional.

For a perf inject -B command this lowers the peak RSS from 54.1MB to
29.6MB by avoiding loading symbols.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c |  2 +-
 tools/perf/util/callchain.c |  8 ++--
 tools/perf/util/callchain.h |  2 +-
 tools/perf/util/machine.c   | 92 +++++++++++++++++++++----------------
 tools/perf/util/machine.h   | 33 ++++++++++---
 5 files changed, 85 insertions(+), 52 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 9eb72ff48d88..d6989195a061 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -942,7 +942,7 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 	}
 
 	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
-					mark_dso_hit_callback, &args);
+					/*symbols=*/false, mark_dso_hit_callback, &args);
 
 	thread__put(thread);
 repipe:
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 0d608e875fe9..0c7564747a14 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1800,7 +1800,7 @@ s64 callchain_avg_cycles(struct callchain_node *cnode)
 
 int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
 				    struct perf_sample *sample, int max_stack,
-				    callchain_iter_fn cb, void *data)
+				    bool symbols, callchain_iter_fn cb, void *data)
 {
 	struct callchain_cursor *cursor = get_tls_callchain_cursor();
 	int ret;
@@ -1809,9 +1809,9 @@ int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
 		return -ENOMEM;
 
 	/* Fill in the callchain. */
-	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
-					/*parent=*/NULL, /*root_al=*/NULL,
-					max_stack);
+	ret = __thread__resolve_callchain(thread, cursor, evsel, sample,
+					  /*parent=*/NULL, /*root_al=*/NULL,
+					  max_stack, symbols);
 	if (ret)
 		return ret;
 
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 76891f8e2373..86ed9e4d04f9 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -315,6 +315,6 @@ typedef int (*callchain_iter_fn)(struct callchain_cursor_node *node, void *data)
 
 int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
 				    struct perf_sample *sample, int max_stack,
-				    callchain_iter_fn cb, void *data);
+				    bool symbols, callchain_iter_fn cb, void *data);
 
 #endif	/* __PERF_CALLCHAIN_H */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5783b96fb988..fad227b625d1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2060,7 +2060,8 @@ static int add_callchain_ip(struct thread *thread,
 			    bool branch,
 			    struct branch_flags *flags,
 			    struct iterations *iter,
-			    u64 branch_from)
+			    u64 branch_from,
+			    bool symbols)
 {
 	struct map_symbol ms = {};
 	struct addr_location al;
@@ -2099,7 +2100,8 @@ static int add_callchain_ip(struct thread *thread,
 			}
 			goto out;
 		}
-		thread__find_symbol(thread, *cpumode, ip, &al);
+		if (symbols)
+			thread__find_symbol(thread, *cpumode, ip, &al);
 	}
 
 	if (al.sym != NULL) {
@@ -2228,7 +2230,8 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 				       struct symbol **parent,
 				       struct addr_location *root_al,
 				       u64 branch_from,
-				       bool callee, int end)
+				       bool callee, int end,
+				       bool symbols)
 {
 	struct ip_callchain *chain = sample->callchain;
 	u8 cpumode = PERF_RECORD_MISC_USER;
@@ -2238,7 +2241,8 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 		for (i = 0; i < end + 1; i++) {
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, chain->ips[i],
-					       false, NULL, NULL, branch_from);
+					       false, NULL, NULL, branch_from,
+					       symbols);
 			if (err)
 				return err;
 		}
@@ -2248,7 +2252,8 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 	for (i = end; i >= 0; i--) {
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, chain->ips[i],
-				       false, NULL, NULL, branch_from);
+				       false, NULL, NULL, branch_from,
+				       symbols);
 		if (err)
 			return err;
 	}
@@ -2291,7 +2296,8 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 				    struct symbol **parent,
 				    struct addr_location *root_al,
 				    u64 *branch_from,
-				    bool callee)
+				    bool callee,
+				    bool symbols)
 {
 	struct branch_stack *lbr_stack = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
@@ -2324,7 +2330,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       true, flags, NULL,
-				       *branch_from);
+				       *branch_from, symbols);
 		if (err)
 			return err;
 
@@ -2349,7 +2355,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, ip,
 					       true, flags, NULL,
-					       *branch_from);
+					       *branch_from, symbols);
 			if (err)
 				return err;
 			save_lbr_cursor_node(thread, cursor, i);
@@ -2364,7 +2370,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       true, flags, NULL,
-				       *branch_from);
+				       *branch_from, symbols);
 		if (err)
 			return err;
 		save_lbr_cursor_node(thread, cursor, i);
@@ -2378,7 +2384,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				root_al, &cpumode, ip,
 				true, flags, NULL,
-				*branch_from);
+				*branch_from, symbols);
 		if (err)
 			return err;
 	}
@@ -2545,7 +2551,8 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					struct symbol **parent,
 					struct addr_location *root_al,
 					int max_stack,
-					unsigned int max_lbr)
+					unsigned int max_lbr,
+					bool symbols)
 {
 	bool callee = (callchain_param.order == ORDER_CALLEE);
 	struct ip_callchain *chain = sample->callchain;
@@ -2587,12 +2594,12 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 		/* Add kernel ip */
 		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
 						  parent, root_al, branch_from,
-						  true, i);
+						  true, i, symbols);
 		if (err)
 			goto error;
 
 		err = lbr_callchain_add_lbr_ip(thread, cursor, sample, parent,
-					       root_al, &branch_from, true);
+					       root_al, &branch_from, true, symbols);
 		if (err)
 			goto error;
 
@@ -2609,14 +2616,14 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 				goto error;
 		}
 		err = lbr_callchain_add_lbr_ip(thread, cursor, sample, parent,
-					       root_al, &branch_from, false);
+					       root_al, &branch_from, false, symbols);
 		if (err)
 			goto error;
 
 		/* Add kernel ip */
 		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
 						  parent, root_al, branch_from,
-						  false, i);
+						  false, i, symbols);
 		if (err)
 			goto error;
 	}
@@ -2630,7 +2637,7 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 			     struct callchain_cursor *cursor,
 			     struct symbol **parent,
 			     struct addr_location *root_al,
-			     u8 *cpumode, int ent)
+			     u8 *cpumode, int ent, bool symbols)
 {
 	int err = 0;
 
@@ -2640,7 +2647,7 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 		if (ip >= PERF_CONTEXT_MAX) {
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, cpumode, ip,
-					       false, NULL, NULL, 0);
+					       false, NULL, NULL, 0, symbols);
 			break;
 		}
 	}
@@ -2662,7 +2669,8 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 					    struct perf_sample *sample,
 					    struct symbol **parent,
 					    struct addr_location *root_al,
-					    int max_stack)
+					    int max_stack,
+					    bool symbols)
 {
 	struct branch_stack *branch = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
@@ -2682,7 +2690,8 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 
 		err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
 						   root_al, max_stack,
-						   !env ? 0 : env->max_branches);
+						   !env ? 0 : env->max_branches,
+						   symbols);
 		if (err)
 			return (err < 0) ? err : 0;
 	}
@@ -2747,13 +2756,14 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 					       root_al,
 					       NULL, be[i].to,
 					       true, &be[i].flags,
-					       NULL, be[i].from);
+					       NULL, be[i].from, symbols);
 
-			if (!err)
+			if (!err) {
 				err = add_callchain_ip(thread, cursor, parent, root_al,
 						       NULL, be[i].from,
 						       true, &be[i].flags,
-						       &iter[i], 0);
+						       &iter[i], 0, symbols);
+			}
 			if (err == -EINVAL)
 				break;
 			if (err)
@@ -2769,7 +2779,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 check_calls:
 	if (chain && callchain_param.order != ORDER_CALLEE) {
 		err = find_prev_cpumode(chain, thread, cursor, parent, root_al,
-					&cpumode, chain->nr - first_call);
+					&cpumode, chain->nr - first_call, symbols);
 		if (err)
 			return (err < 0) ? err : 0;
 	}
@@ -2791,7 +2801,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
                        ++nr_entries;
 		else if (callchain_param.order != ORDER_CALLEE) {
 			err = find_prev_cpumode(chain, thread, cursor, parent,
-						root_al, &cpumode, j);
+						root_al, &cpumode, j, symbols);
 			if (err)
 				return (err < 0) ? err : 0;
 			continue;
@@ -2818,8 +2828,8 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 			if (leaf_frame_caller && leaf_frame_caller != ip) {
 
 				err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, leaf_frame_caller,
-					       false, NULL, NULL, 0);
+						root_al, &cpumode, leaf_frame_caller,
+						false, NULL, NULL, 0, symbols);
 				if (err)
 					return (err < 0) ? err : 0;
 			}
@@ -2827,7 +2837,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
-				       false, NULL, NULL, 0);
+				       false, NULL, NULL, 0, symbols);
 
 		if (err)
 			return (err < 0) ? err : 0;
@@ -2907,7 +2917,7 @@ static int thread__resolve_callchain_unwind(struct thread *thread,
 					    struct callchain_cursor *cursor,
 					    struct evsel *evsel,
 					    struct perf_sample *sample,
-					    int max_stack)
+					    int max_stack, bool symbols)
 {
 	/* Can we do dwarf post unwind? */
 	if (!((evsel->core.attr.sample_type & PERF_SAMPLE_REGS_USER) &&
@@ -2919,17 +2929,21 @@ static int thread__resolve_callchain_unwind(struct thread *thread,
 	    (!sample->user_stack.size))
 		return 0;
 
+	if (!symbols)
+		pr_debug("Not resolving symbols with an unwinder isn't currently supported\n");
+
 	return unwind__get_entries(unwind_entry, cursor,
 				   thread, sample, max_stack, false);
 }
 
-int thread__resolve_callchain(struct thread *thread,
-			      struct callchain_cursor *cursor,
-			      struct evsel *evsel,
-			      struct perf_sample *sample,
-			      struct symbol **parent,
-			      struct addr_location *root_al,
-			      int max_stack)
+int __thread__resolve_callchain(struct thread *thread,
+				struct callchain_cursor *cursor,
+				struct evsel *evsel,
+				struct perf_sample *sample,
+				struct symbol **parent,
+				struct addr_location *root_al,
+				int max_stack,
+				bool symbols)
 {
 	int ret = 0;
 
@@ -2942,22 +2956,22 @@ int thread__resolve_callchain(struct thread *thread,
 		ret = thread__resolve_callchain_sample(thread, cursor,
 						       evsel, sample,
 						       parent, root_al,
-						       max_stack);
+						       max_stack, symbols);
 		if (ret)
 			return ret;
 		ret = thread__resolve_callchain_unwind(thread, cursor,
 						       evsel, sample,
-						       max_stack);
+						       max_stack, symbols);
 	} else {
 		ret = thread__resolve_callchain_unwind(thread, cursor,
 						       evsel, sample,
-						       max_stack);
+						       max_stack, symbols);
 		if (ret)
 			return ret;
 		ret = thread__resolve_callchain_sample(thread, cursor,
 						       evsel, sample,
 						       parent, root_al,
-						       max_stack);
+						       max_stack, symbols);
 	}
 
 	return ret;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index a687876e3453..2e5a4cb342d8 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -178,13 +178,32 @@ struct mem_info *sample__resolve_mem(struct perf_sample *sample,
 
 struct callchain_cursor;
 
-int thread__resolve_callchain(struct thread *thread,
-			      struct callchain_cursor *cursor,
-			      struct evsel *evsel,
-			      struct perf_sample *sample,
-			      struct symbol **parent,
-			      struct addr_location *root_al,
-			      int max_stack);
+int __thread__resolve_callchain(struct thread *thread,
+				struct callchain_cursor *cursor,
+				struct evsel *evsel,
+				struct perf_sample *sample,
+				struct symbol **parent,
+				struct addr_location *root_al,
+				int max_stack,
+				bool symbols);
+
+static inline int thread__resolve_callchain(struct thread *thread,
+					    struct callchain_cursor *cursor,
+					    struct evsel *evsel,
+					    struct perf_sample *sample,
+					    struct symbol **parent,
+					    struct addr_location *root_al,
+					    int max_stack)
+{
+	return __thread__resolve_callchain(thread,
+					   cursor,
+					   evsel,
+					   sample,
+					   parent,
+					   root_al,
+					   max_stack,
+					   /*symbols=*/true);
+}
 
 /*
  * Default guest kernel is defined by parameter --guestkallsyms
-- 
2.46.0.598.g6f2099f65c-goog


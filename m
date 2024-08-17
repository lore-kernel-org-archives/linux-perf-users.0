Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC814883F
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Aug 2024 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877134; cv=none; b=MiGSAARXmp+sdrXmM11BDtq24nA0qeDrAHrsRjvIYqA51zrCEVFyxcojMhe7OPQuxWoL86vg17cv5MWkLSu/E+ehnPNc3GCTpgBMPtful/jwlUdp6yyA9cci5GsoyOgkQnVjblt6K9WBxosxEUjxjslZge9xvahFQVZEzvvBD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877134; c=relaxed/simple;
	bh=T+vkABo8pfjGvY2NJBEP+BbLwKM2texesBTDSZzCQeo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rbXx5jGJTRVhaHbxUEr5l4prEq966m9IYvIwfvz9DGCF0jTklNZbHBL4zrYcSMRvYNpg1wnvCOdM+2WhWDJHd/RN8QB0vrJLpuWIKGtHA6YmJH8QwpGIEu6Kf3PA4E3Ia/HqEj85VFyznnYxoVst2jU44wJPNBnqVwthOrnsDlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MBcRtOvB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBcRtOvB"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6643016423fso54602677b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877131; x=1724481931; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vs/ATUqSidqRIzdN2QwVwb6M41EgV7LbTTqskLbY2Q=;
        b=MBcRtOvBjHuzQ81K2qj/bR1qRjX/NBiNaFaw8RHW9Kb/H34rxMdtSXAaga6Ocs6OzL
         RIlk/Q+n7ZsU+S0/VllmWb7gD+hSYHXd7CBqKynxtbe11HPAZTKQPESXgkBBpltznt7A
         MVC5h2ScQxTm5Oo5bq4BCPrnZzf7VAZP81FQPbabtcnBV0lrRxiUU9GacnIeNgvXYAWh
         qOOrX8vhTsOQ1r6OQPgVD1JVv5jQ0zmoNBiNkwvvuLneU3u4uim/Yl/MQQ3tCeYZUs90
         181me0DbLojvaB8UQegRPoTT9ui1OesIZjGPo3RN0F2rCrsAoujwVcb0fF2vZAOVxszY
         MC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877131; x=1724481931;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vs/ATUqSidqRIzdN2QwVwb6M41EgV7LbTTqskLbY2Q=;
        b=I6Tc9Cw6tylzwXNGL08wpU0sO669qHPATFgSyGuQHUVsTorER8v9TXIPdt7UR6r7f4
         lwbUAM2p6/Fucb/Jn6tE77bHAHTiF1CBCFZ+94X29borJyTsFQjABgLXqwtU9abASjuc
         Q3RygJrqPsSReR7h5u6nJdIz0A6VfIAUdbAP21Sj/QLCAY5sWBvxl9ODOy10z2naJhUe
         O8DEd11C0PL4UIC7F5c+SqC7yaZEjZ0278WllbteKeE5lVO3MQdgUxnl5CfWUsmDcthd
         ljd86O9ZlyLYY0qlgdJbrGTY9ChFulgplx/GnMoLqNldaLlptRBg9ctYqHzFS2qp3Gzw
         UCaw==
X-Forwarded-Encrypted: i=1; AJvYcCW327XRN8/gLr05mKT0bQFz3thAG8ztvXGn0j/GCPhzbSde7Xv9cQ9H3QpYix4Z8iDUprU5yBal0lzbzDqAwJQlxR+klBcoRPAZwSUYJr91AA==
X-Gm-Message-State: AOJu0YweHgHFR9qJA/JfkT0mr6pkjdXd9EKqFRcO3p2B2AC5nptQBSv7
	wqMbnknms3Af0sLXHwCE/+jab4kYBtSvsFqxvltodZY7H87kAEL/utEb5EBay2ZbyopZlnUVULq
	fE7AQUg==
X-Google-Smtp-Source: AGHT+IF6f83tDj9w+yBgzQZgrB/tfugQj/LzXEEgJgaYJ+HcUK3RgmIsHTTvviaw6SxOuRaRQXJampnNms/V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a05:690c:2a87:b0:62c:f976:a763 with SMTP
 id 00721157ae682-6b1b7595cd4mr1426637b3.1.1723877131385; Fri, 16 Aug 2024
 23:45:31 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:42 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 13/13] perf callchain: Allow symbols to be optional when
 resolving a callchain
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In uses like perf inject it is not necessary to gather the symbol for
each call chain location, the map for the sample IP is wanted so that
build IDs and the like can be injected. Make gathering the symbol in
the callchain_cursor optional.

For a perf inject -B command this lowers the peak RSS from 54.1MB to
29.6MB by avoiding loading symbols.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c |  2 +-
 tools/perf/util/callchain.c |  8 ++--
 tools/perf/util/callchain.h |  2 +-
 tools/perf/util/machine.c   | 92 +++++++++++++++++++++----------------
 tools/perf/util/machine.h   | 33 ++++++++++---
 5 files changed, 85 insertions(+), 52 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 2ff246f56a44..8ad7cc5f0c63 100644
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
index cd79a830abae..6cffee6f9891 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2059,7 +2059,8 @@ static int add_callchain_ip(struct thread *thread,
 			    bool branch,
 			    struct branch_flags *flags,
 			    struct iterations *iter,
-			    u64 branch_from)
+			    u64 branch_from,
+			    bool symbols)
 {
 	struct map_symbol ms = {};
 	struct addr_location al;
@@ -2098,7 +2099,8 @@ static int add_callchain_ip(struct thread *thread,
 			}
 			goto out;
 		}
-		thread__find_symbol(thread, *cpumode, ip, &al);
+		if (symbols)
+			thread__find_symbol(thread, *cpumode, ip, &al);
 	}
 
 	if (al.sym != NULL) {
@@ -2227,7 +2229,8 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 				       struct symbol **parent,
 				       struct addr_location *root_al,
 				       u64 branch_from,
-				       bool callee, int end)
+				       bool callee, int end,
+				       bool symbols)
 {
 	struct ip_callchain *chain = sample->callchain;
 	u8 cpumode = PERF_RECORD_MISC_USER;
@@ -2237,7 +2240,8 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 		for (i = 0; i < end + 1; i++) {
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, chain->ips[i],
-					       false, NULL, NULL, branch_from);
+					       false, NULL, NULL, branch_from,
+					       symbols);
 			if (err)
 				return err;
 		}
@@ -2247,7 +2251,8 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 	for (i = end; i >= 0; i--) {
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, chain->ips[i],
-				       false, NULL, NULL, branch_from);
+				       false, NULL, NULL, branch_from,
+				       symbols);
 		if (err)
 			return err;
 	}
@@ -2290,7 +2295,8 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 				    struct symbol **parent,
 				    struct addr_location *root_al,
 				    u64 *branch_from,
-				    bool callee)
+				    bool callee,
+				    bool symbols)
 {
 	struct branch_stack *lbr_stack = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
@@ -2323,7 +2329,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       true, flags, NULL,
-				       *branch_from);
+				       *branch_from, symbols);
 		if (err)
 			return err;
 
@@ -2348,7 +2354,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, ip,
 					       true, flags, NULL,
-					       *branch_from);
+					       *branch_from, symbols);
 			if (err)
 				return err;
 			save_lbr_cursor_node(thread, cursor, i);
@@ -2363,7 +2369,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       true, flags, NULL,
-				       *branch_from);
+				       *branch_from, symbols);
 		if (err)
 			return err;
 		save_lbr_cursor_node(thread, cursor, i);
@@ -2377,7 +2383,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				root_al, &cpumode, ip,
 				true, flags, NULL,
-				*branch_from);
+				*branch_from, symbols);
 		if (err)
 			return err;
 	}
@@ -2544,7 +2550,8 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					struct symbol **parent,
 					struct addr_location *root_al,
 					int max_stack,
-					unsigned int max_lbr)
+					unsigned int max_lbr,
+					bool symbols)
 {
 	bool callee = (callchain_param.order == ORDER_CALLEE);
 	struct ip_callchain *chain = sample->callchain;
@@ -2586,12 +2593,12 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
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
 
@@ -2608,14 +2615,14 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
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
@@ -2629,7 +2636,7 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 			     struct callchain_cursor *cursor,
 			     struct symbol **parent,
 			     struct addr_location *root_al,
-			     u8 *cpumode, int ent)
+			     u8 *cpumode, int ent, bool symbols)
 {
 	int err = 0;
 
@@ -2639,7 +2646,7 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 		if (ip >= PERF_CONTEXT_MAX) {
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, cpumode, ip,
-					       false, NULL, NULL, 0);
+					       false, NULL, NULL, 0, symbols);
 			break;
 		}
 	}
@@ -2661,7 +2668,8 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 					    struct perf_sample *sample,
 					    struct symbol **parent,
 					    struct addr_location *root_al,
-					    int max_stack)
+					    int max_stack,
+					    bool symbols)
 {
 	struct branch_stack *branch = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
@@ -2681,7 +2689,8 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 
 		err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
 						   root_al, max_stack,
-						   !env ? 0 : env->max_branches);
+						   !env ? 0 : env->max_branches,
+						   symbols);
 		if (err)
 			return (err < 0) ? err : 0;
 	}
@@ -2746,13 +2755,14 @@ static int thread__resolve_callchain_sample(struct thread *thread,
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
@@ -2768,7 +2778,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 check_calls:
 	if (chain && callchain_param.order != ORDER_CALLEE) {
 		err = find_prev_cpumode(chain, thread, cursor, parent, root_al,
-					&cpumode, chain->nr - first_call);
+					&cpumode, chain->nr - first_call, symbols);
 		if (err)
 			return (err < 0) ? err : 0;
 	}
@@ -2790,7 +2800,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
                        ++nr_entries;
 		else if (callchain_param.order != ORDER_CALLEE) {
 			err = find_prev_cpumode(chain, thread, cursor, parent,
-						root_al, &cpumode, j);
+						root_al, &cpumode, j, symbols);
 			if (err)
 				return (err < 0) ? err : 0;
 			continue;
@@ -2817,8 +2827,8 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 			if (leaf_frame_caller && leaf_frame_caller != ip) {
 
 				err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, leaf_frame_caller,
-					       false, NULL, NULL, 0);
+						root_al, &cpumode, leaf_frame_caller,
+						false, NULL, NULL, 0, symbols);
 				if (err)
 					return (err < 0) ? err : 0;
 			}
@@ -2826,7 +2836,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
-				       false, NULL, NULL, 0);
+				       false, NULL, NULL, 0, symbols);
 
 		if (err)
 			return (err < 0) ? err : 0;
@@ -2906,7 +2916,7 @@ static int thread__resolve_callchain_unwind(struct thread *thread,
 					    struct callchain_cursor *cursor,
 					    struct evsel *evsel,
 					    struct perf_sample *sample,
-					    int max_stack)
+					    int max_stack, bool symbols)
 {
 	/* Can we do dwarf post unwind? */
 	if (!((evsel->core.attr.sample_type & PERF_SAMPLE_REGS_USER) &&
@@ -2918,17 +2928,21 @@ static int thread__resolve_callchain_unwind(struct thread *thread,
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
 
@@ -2941,22 +2955,22 @@ int thread__resolve_callchain(struct thread *thread,
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
2.46.0.184.g6999bdac58-goog


Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD212FFDFC
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465161; cv=none; b=Oq+DTKcxjOZFkvhMDQ/oc9AKYV3pEilVvRoIblypbBLi0oL/6yJ0OZIdMBZhuZBjrtIMJ+9yGVh/hHlE0eG93MYW1RGEgQLDGlc3v4Ab8a/knorbJg7ovtr5lOhy88KGXUR1ZX32qs6DTRgv8+XvxvWkTYrZNmHbHy+CD+kzoLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465161; c=relaxed/simple;
	bh=QAr4+Nc+Cx9Kyw9xC6h4+6yxNEiU19ywiW6NGK05bUg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NPdFvG3Puom8GznOJYwN2xcruujYt5DnJ4kUOh8wdAr2pWPDF+qfPxtycTF5mtW3UcO5R7It1/K9LwsHUkNgMOYxLqnsJ3IJohdr9xdgSs/PPeHQOZRqZ01lDUO3RdaRv9EIkKJoWHmFDuiGHLgLCtJeY5wLnTOh+V763QP6wDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KQMkr311; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQMkr311"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b6f0b345e3so23678747eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 14:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769465159; x=1770069959; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uscjFzN7lW6l+hjfQoY8JpHSmnfj6RBxlc4jMPBGOng=;
        b=KQMkr31197PsRNz8T/h7S+c2hrxwVl0Zw3hg4EWpld4geb7AR/KIlCBQFNrMTBKEHQ
         BCkJcke5HauXVWXDAj2Inw1PbY5d5fR/gg20UXySXcRFFuCHtu/GlABgjlF+1j+xaL9i
         E/sK65DkFWk0ep+x3hFoL/csTC9sZQXhqUxwjJPbIDQ6VApqsyqrQc+wGJ1aY5C8Tyg1
         RSmO20tuYVlCaXQ1RCFV4gCd1kUZKFrC5eCQcpsXKYIicRBCX8Gh7YL5jEGvqv43bLKz
         SmNtLXMUmqonc82imyh3/LuCq5YiZ/G/ncaxImwEyChn3tk5fGtxJ5nc1kKeRbT2ObS2
         SE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769465159; x=1770069959;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uscjFzN7lW6l+hjfQoY8JpHSmnfj6RBxlc4jMPBGOng=;
        b=p/ykWMm4LO1Gp6asFWQakkk0QdFfHgt5mftSDSWm/A5vpyMe84M9RSWBkL0HmvvvKu
         zOP33j6BvCymxCK5LcGjWaxoMUeLq7iAtvIhrtnNbfhhE14Qp4EzM4DXBkaF+rs7B+r7
         Q8A6qvPbgvmL+d0z6H8MC2PeQY5B7E8PcTYdWlrCGCDLVe+1waU+96m6j/p9pC/yDUEB
         /sy3MBt6mKdJcMflv1FKBmwd710clJxUXT3IDzetnWM9vA59qozFqFjcK8TwUjF1R/Eo
         pCCCPP3N+ZnH/nV9bG+VaLioSkGtnInk8MqDleRjd7bzI2u/+E6LfSXqrMJBIm0al1Rq
         WFYg==
X-Forwarded-Encrypted: i=1; AJvYcCXx3O8E09JNlGswkcopjRset/HlSH8tW/RdKpCJgmBstpuH1mhTj7WiSBWOH5hfOBvt/dr9eLhuE5RUWOXmiTbj@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZkN0M2uJdaDt9Jl8mauUCUrcdlX42ewCKGH7Tbr7cBs1cx9X
	q8oQoOjO2EdZLGFf9ZFNCPzogbLlVuorBZsVI/xJw86sX4ED6Slrixv8rRP5yOFwty5qYIoRHUq
	xHew1rwpwxw==
X-Received: from dyjn14.prod.google.com ([2002:a05:7300:a8e:b0:2ae:5f89:cc45])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1483:b0:2b0:5bfb:86
 with SMTP id 5a478bee46e88-2b764328ef4mr2532668eec.17.1769465159358; Mon, 26
 Jan 2026 14:05:59 -0800 (PST)
Date: Mon, 26 Jan 2026 14:05:49 -0800
In-Reply-To: <20260126220550.2573257-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126220550.2573257-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126220550.2573257-3-irogers@google.com>
Subject: [PATCH v2 2/3] perf callchain: Switch callchain_param_setup from an
 arch to an e_machine
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Increase use of e_machine by replacing callchain_param_setup's arch
argument to be an e_machine typically read from the session.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 6 ++----
 tools/perf/builtin-script.c | 4 ++--
 tools/perf/util/callchain.c | 4 ++--
 tools/perf/util/callchain.h | 2 +-
 tools/perf/util/sample.c    | 2 +-
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2e936928e8c0..810ffd66b11c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -448,7 +448,7 @@ static int report__setup_sample_type(struct report *rep)
 		}
 	}
 
-	callchain_param_setup(sample_type, perf_env__arch(perf_session__env(rep->session)));
+	callchain_param_setup(sample_type, perf_session__e_machine(session));
 
 	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
@@ -1283,7 +1283,6 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 			struct evlist **pevlist)
 {
 	struct perf_session *session;
-	struct perf_env *env;
 	u64 sample_type;
 	int err;
 
@@ -1297,8 +1296,7 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 	 */
 	sample_type = evlist__combined_sample_type(*pevlist);
 	session = (*pevlist)->session;
-	env = perf_session__env(session);
-	callchain_param_setup(sample_type, perf_env__arch(env));
+	callchain_param_setup(sample_type, perf_session__e_machine(session));
 	return 0;
 }
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 69af25780fc5..c7d5a325b5cb 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2859,7 +2859,7 @@ static int process_attr(const struct perf_tool *tool, union perf_event *event,
 	 * on events sample_type.
 	 */
 	sample_type = evlist__combined_sample_type(evlist);
-	callchain_param_setup(sample_type, perf_env__arch(perf_session__env(scr->session)));
+	callchain_param_setup(sample_type, perf_session__e_machine(evsel__session(evsel)));
 
 	/* Enable fields for callchain entries */
 	if (symbol_conf.use_callchain &&
@@ -3834,7 +3834,7 @@ static void script__setup_sample_type(struct perf_script *script)
 	struct perf_session *session = script->session;
 	u64 sample_type = evlist__combined_sample_type(session->evlist);
 
-	callchain_param_setup(sample_type, perf_env__arch(session->machines.host.env));
+	callchain_param_setup(sample_type, perf_session__e_machine(session));
 
 	if (script->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		pr_warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 515bb8b5da01..8ff0898799ee 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1681,7 +1681,7 @@ void callchain_cursor_reset(struct callchain_cursor *cursor)
 		map_symbol__exit(&node->ms);
 }
 
-void callchain_param_setup(u64 sample_type, const char *arch)
+void callchain_param_setup(u64 sample_type, uint16_t e_machine)
 {
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
 		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
@@ -1703,7 +1703,7 @@ void callchain_param_setup(u64 sample_type, const char *arch)
 	 * erroneous entries. Always skipping the LR and starting from the FP
 	 * can result in missing entries.
 	 */
-	if (callchain_param.record_mode == CALLCHAIN_FP && !strcmp(arch, "arm64"))
+	if (callchain_param.record_mode == CALLCHAIN_FP && e_machine == EM_AARCH64)
 		dwarf_callchain_users = true;
 }
 
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 2a52af8c80ac..df54ddb8c0cb 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -303,7 +303,7 @@ int callchain_branch_counts(struct callchain_root *root,
 			    u64 *branch_count, u64 *predicted_count,
 			    u64 *abort_count, u64 *cycles_count);
 
-void callchain_param_setup(u64 sample_type, const char *arch);
+void callchain_param_setup(u64 sample_type, uint16_t e_machine);
 
 bool callchain_cnode_matched(struct callchain_node *base_cnode,
 			     struct callchain_node *pair_cnode);
diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
index d885c02a9861..b9089878ace5 100644
--- a/tools/perf/util/sample.c
+++ b/tools/perf/util/sample.c
@@ -92,7 +92,7 @@ void perf_sample__fetch_insn(struct perf_sample *sample,
 	if (!sample->ip || sample->insn_len != 0)
 		return;
 
-	e_machine = thread__e_machine(thread, machine);
+	e_machine = thread__e_machine(thread, machine, /*e_flags=*/NULL);
 	len = elf_machine_max_instruction_length(e_machine);
 	len = thread__memcpy(thread, machine, sample->insn,
 			     sample->ip, len,
-- 
2.52.0.457.g6b5491de43-goog


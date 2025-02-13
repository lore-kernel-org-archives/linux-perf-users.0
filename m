Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925A20CCE8
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437717; cv=none; b=IPO4g5eN8diU5O4n/X5CpASc/1JllJgw5/rt0nziYXkM/qdiitB0ctNO+RUL6j9iupzzx90r3l3IuLi+jjG3aBKe2JZuPbQEY9i8MpDVIMn5FRw7q+EhgfFQ8oC8tejTsmj92cUftmBUmttUrGTYXnB9m66lcxvNCjjs5UhiDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437717; c=relaxed/simple;
	bh=DwGz+VSOEGNrHVXabO2VP39G++ha4Ni3nAPmzKDN9tI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H9eNfdoUxWafrrIJbC7oe3YxoWXPVi2AL3y37hC+kDYWEV0Op/+FOs/9aleyYQFWmc+skbWmiwf5qq+qAKYidMCtnxELqrkwSg1qRNv55DsHIjOsUJno0d7A6eGP8d3GP7fpkCw7p7pAQza+vTQRBHo2FIdRg39k5Erl1/NdnGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lxrxyGcp; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lxrxyGcp"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43942e82719so4517305e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 01:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739437713; x=1740042513; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VAwgMnA3DPssQgMLBmkgJOfyrB3zb9gYbZ4ecfMuZYg=;
        b=lxrxyGcptL7Usw7Wir+TrhRRK4qBKRMVZ3xW1JPxriLECznQeKO287O26h+RbUNRQq
         +leuyCKDsv6UiUbbOb/WIypSeRs448YgIi2j2Arq9vH+IVfdypNMVhum/ZNGKaRxgdBn
         zdYNov85AYomBf9sdl+C9aZEvztulmizmvgRex8FA54DdyhDNusmbbftGag7yIsfdo7s
         RkZ3e3Y0DhV260XjChML1Ow4uFYBqkzm7yHg36cD7lnrTdb35sBrxJgOhsR/A5s3aB0O
         rlYnSKWtjAYxj4jnhPAib7N/BbT8rYc4Rxer+jrgaYNFV4uiKBQ3qjnJr1tSFcLzAUoS
         MMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437713; x=1740042513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAwgMnA3DPssQgMLBmkgJOfyrB3zb9gYbZ4ecfMuZYg=;
        b=TT2YADxr1Xd9cxAYjyYXHaF/ABq0ouvNOE00wOw4FCo3H1eoUkd8j23OfSr5umueu6
         KiNOzwbvhyt1IOFNbucbmgr6P3Jda4i0DtWW5p716U82m43KCfqxzElhUj2PQz5quIY+
         tZTIVTlI1IKuTTbuf57zQd+HQlYWY1vzkacK7Eh2jrslRMGvajaDitC1naTDfultJj7G
         r9PO9vL0PTL+AAfMkiK3vcJrPfjr/ZRm8nu3YO91GLe0Ti66ECRAQoI2m/ehLFbnOLja
         Dvbeki0CbI8BCd4/qUp8XYSHoQjKLR9htYrhFwiZkH8BCfAZC5PXLuO/4qe3DilNzFeE
         9mlQ==
X-Gm-Message-State: AOJu0YzJ1vsuXbRLwG/oHmRPSasV6E/4yBz/enmGys6n4WCGgMNarDhG
	+I/9iw7kkl6FpIdJiCmIRNCcWGTTvBxbOGKmfwk7T6I9n/ljc78tJaSEaU3zUf2V71mAmP+X9Mg
	4VoAz+A==
X-Google-Smtp-Source: AGHT+IHITxXoY73MysFl5c5WcinYi/Q4/VDUYpm6Cd+cd58+lEq8ufzDgzTx5Cex3FOvb77XUTXeME6mypKb
X-Received: from wmbeo3.prod.google.com ([2002:a05:600c:82c3:b0:435:f81b:bac8])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4fc9:b0:435:32e:8270
 with SMTP id 5b1f17b1804b1-43958176b4emr67391965e9.14.1739437713287; Thu, 13
 Feb 2025 01:08:33 -0800 (PST)
Date: Thu, 13 Feb 2025 10:08:14 +0100
In-Reply-To: <cover.1739437531.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739437531.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <0f8c1b8eb12619029e31b3d5c0346f4616a5aeda.1739437531.git.dvyukov@google.com>
Subject: [PATCH v7 1/9] perf report: Add machine parallelism
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, acme@kernel.org, 
	ak@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

Add calculation of the current parallelism level (number of threads actively
running on CPUs). The parallelism level can be shown in reports on its own,
and to calculate latency overheads.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/builtin-report.c     | 1 +
 tools/perf/util/addr_location.c | 1 +
 tools/perf/util/addr_location.h | 2 ++
 tools/perf/util/event.c         | 3 +++
 tools/perf/util/machine.c       | 7 +++++++
 tools/perf/util/machine.h       | 6 ++++++
 6 files changed, 20 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index f5fbd670d619a..0d9bd090eda71 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1568,6 +1568,7 @@ int cmd_report(int argc, const char **argv)
 	report.tool.cgroup		 = perf_event__process_cgroup;
 	report.tool.exit		 = perf_event__process_exit;
 	report.tool.fork		 = perf_event__process_fork;
+	report.tool.context_switch	 = perf_event__process_switch;
 	report.tool.lost		 = perf_event__process_lost;
 	report.tool.read		 = process_read_event;
 	report.tool.attr		 = process_attr;
diff --git a/tools/perf/util/addr_location.c b/tools/perf/util/addr_location.c
index 51825ef8c0ab7..007a2f5df9a6a 100644
--- a/tools/perf/util/addr_location.c
+++ b/tools/perf/util/addr_location.c
@@ -17,6 +17,7 @@ void addr_location__init(struct addr_location *al)
 	al->cpumode = 0;
 	al->cpu = 0;
 	al->socket = 0;
+	al->parallelism = 1;
 }
 
 /*
diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
index d8ac0428dff23..36aaa45445f24 100644
--- a/tools/perf/util/addr_location.h
+++ b/tools/perf/util/addr_location.h
@@ -21,6 +21,8 @@ struct addr_location {
 	u8	      cpumode;
 	s32	      cpu;
 	s32	      socket;
+	/* Same as machine.parallelism but within [1, nr_cpus]. */
+	int	      parallelism;
 };
 
 void addr_location__init(struct addr_location *al);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index aac96d5d19170..2f10e31157572 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -767,6 +767,9 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 			al->socket = env->cpu[al->cpu].socket_id;
 	}
 
+	/* Account for possible out-of-order switch events. */
+	al->parallelism = max(1, min(machine->parallelism, machine__nr_cpus_avail(machine)));
+
 	if (al->map) {
 		if (symbol_conf.dso_list &&
 		    (!dso || !(strlist__has_entry(symbol_conf.dso_list,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 321cc110698c4..d6fb739e9a3f4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -94,6 +94,8 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	machine->comm_exec = false;
 	machine->kernel_start = 0;
 	machine->vmlinux_map = NULL;
+	/* There is no initial context switch in, so we start at 1. */
+	machine->parallelism = 1;
 
 	machine->root_dir = strdup(root_dir);
 	if (machine->root_dir == NULL)
@@ -677,8 +679,11 @@ int machine__process_aux_output_hw_id_event(struct machine *machine __maybe_unus
 int machine__process_switch_event(struct machine *machine __maybe_unused,
 				  union perf_event *event)
 {
+	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
+
 	if (dump_trace)
 		perf_event__fprintf_switch(event, stdout);
+	machine->parallelism += out ? -1 : 1;
 	return 0;
 }
 
@@ -1880,6 +1885,8 @@ int machine__process_exit_event(struct machine *machine, union perf_event *event
 	if (dump_trace)
 		perf_event__fprintf_task(event, stdout);
 
+	/* There is no context switch out before exit, so we decrement here. */
+	machine->parallelism--;
 	if (thread != NULL) {
 		if (symbol_conf.keep_exited_threads)
 			thread__set_exited(thread, /*exited=*/true);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index ae3e5542d57df..b56abec84fed1 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -50,6 +50,12 @@ struct machine {
 		u64	  text_start;
 		u64	  text_end;
 	} sched, lock, traceiter, trace;
+	/*
+	 * The current parallelism level (number of threads that run on CPUs).
+	 * This value can be less than 1, or larger than the total number
+	 * of CPUs, if events are poorly ordered.
+	 */
+	int		  parallelism;
 	pid_t		  *current_tid;
 	size_t		  current_tid_sz;
 	union { /* Tool specific area */
-- 
2.48.1.502.g6dc24dfdaf-goog


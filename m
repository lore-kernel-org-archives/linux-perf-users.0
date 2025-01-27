Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9E1FC7F3
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971960; cv=none; b=nlDKBV00I/grriLV5f0Xjm4ygB2BnjMMkbsWM9ikUe3xoOQZ5vnSjaNCFbNUxsRdfkFW3CTnk19UsoKqK7rmoDfUPx2lDqy8P7hpu9lSfVvimn2B48sxW57Ysu5zbbx5hsfBDQN7knTTzN27gGDFAxW7Oul7gMIkrbQh0eJRHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971960; c=relaxed/simple;
	bh=7Lwmz2qowc+FL2S348X3fs0ddxo5HZNQI1A8WhNfwmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UF8yx7tghZfZf73XfcUEX3ulu+G1gsmjohCqJsCozQ7reabWIC4Ckjifops+5Mi0qbeSI6A/UyxjiqgZQ7naR18CUWOK/S1XZ+/MidQ7H3OgzG8Rqr0iyk56rE7rRlTTDR3jqGCwzPdlYW5yi+OO+CvekSu7hvzpoOOd8Wumo0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=23D0DEL1; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="23D0DEL1"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d3bf8874dbso4927870a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 01:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737971956; x=1738576756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wY6YjR33QYUTFA2QpzMQp9zL626GKLB+VcfcqXYl4og=;
        b=23D0DEL18KYt5Yqv75lVQiJyWNLsTiuhFGSinubLbFBwh4SiMTzHVAmAPRJp1FJKCD
         946xU1laTwVZwJAXPdo8qTOugy2JCgRmcWcJUH5oX9pZNKmY1wV1Nq93plpNDCPzTQBW
         GJby9XqUhIVL9jqK28P8IgtkpsIPoerdoTxZz2/p2RWcm4yCeC43fAXfeodqsWOvLOMt
         eg5KK+O9owY4hpl2SYlIvd4W6SmP5KPlBgJJSRJXtdRXLFvngxiZI9qJIt9reBkq200H
         s4/oRAY4is4jkKkx/GbnSCo9/w4/rFNHmIvsB888S9vtUqs6FyvLumIxB2oBbrlar17H
         A28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737971956; x=1738576756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wY6YjR33QYUTFA2QpzMQp9zL626GKLB+VcfcqXYl4og=;
        b=mrXjDayUIAjcLLxmtlsJKm8rFNwGU/dj/hIPqpBvR6t9HaNweiSfcAVdLV48jRsPWN
         7ZDDWuW0dfB1arUSYVuD7leVy3uNcTus4dzsZOIBUSO29vgMmx2l5VZQPShSYBEGbTgH
         zhUHKuU/YnL8ydAgQxK7DtLh5y7PFV8dCwbXeRn5cbzteiOxx+wAd3chMb7BL4h5VHiD
         3wP6LuxsB4qt8s98XlyRIWJovIE2WywfIYdME24VC43V+z1LVXmbMlS9glkGyq6pvd6k
         ya9pj7fQJUf7Y+QuXjdTDD4V/Rm16JLmQBqDH3/SWcftCEFUPlJjHHx/reBRCyDF5X3Q
         zDMg==
X-Gm-Message-State: AOJu0Yzw6yEmaPJJKqWzMrAuIIKtl12QDimlh90sZO9ZaLu9WVC54j76
	q2gno8KpEYvhPCcjsa5+D6NvjXptUduhxzvrrj/7X9bI0P1m3XbZGiV9SFAhMmKVtwqSKSTLlkp
	cOF4nhg==
X-Google-Smtp-Source: AGHT+IHWR5KT444/HwyTkeF8oEknrLW504GPADqAKXMZXiZu/CWtg9MudjXP4L1rx2P21ydNd5cATZPXKLPB
X-Received: from edap3.prod.google.com ([2002:a05:6402:5003:b0:5dc:37ed:79fc])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:26c6:b0:5dc:545:40a7
 with SMTP id 4fb4d7f45d1cf-5dc05454350mr17309711a12.12.1737971956452; Mon, 27
 Jan 2025 01:59:16 -0800 (PST)
Date: Mon, 27 Jan 2025 10:58:48 +0100
In-Reply-To: <cover.1737971364.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1737971364.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <35860043ef3c4a25d36211853c3f2a6f83cd74b7.1737971364.git.dvyukov@google.com>
Subject: [PATCH v3 1/7] perf report: Add machine parallelism
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
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
index aac96d5d19170..3d3ac58e1c660 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -767,6 +767,9 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 			al->socket = env->cpu[al->cpu].socket_id;
 	}
 
+	/* Account for possible out-of-order switch events. */
+	al->parallelism = min(max(machine->parallelism, 1), machine__nr_cpus_avail(machine));
+
 	if (al->map) {
 		if (symbol_conf.dso_list &&
 		    (!dso || !(strlist__has_entry(symbol_conf.dso_list,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2d51badfbf2e2..0e65c5377f983 100644
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
 
@@ -1900,6 +1905,8 @@ int machine__process_exit_event(struct machine *machine, union perf_event *event
 	if (dump_trace)
 		perf_event__fprintf_task(event, stdout);
 
+	/* There is no context switch out before exit, so we decrement here. */
+	machine->parallelism--;
 	if (thread != NULL) {
 		if (symbol_conf.keep_exited_threads)
 			thread__set_exited(thread, /*exited=*/true);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 2e5a4cb342d82..a5f28652873ce 100644
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
2.48.1.262.g85cc9f2d1e-goog


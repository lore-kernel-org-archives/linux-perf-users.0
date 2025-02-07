Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E541DF730
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928480; cv=none; b=c01bN4IizIGWbg1r26QTIqaJ10XeBDW9GOVUXMvPNtVVzLmdJZg2trEFMvHX3V0/IxtyzfFdUeivmQ93zxpKD8IaNcewJRf7Hd0Dn475ao3fp0p3JLcPutYwlUX99h+UptthDEPY0vMDNX3mYjKFjZOFX8/lJAgt0iLeMixLsWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928480; c=relaxed/simple;
	bh=LQ+5E/V08gqN19grlM5o5d3mF3Nlg2Pj2gweLH/xUrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NamQdKNJA9L3V3gA5xuBkDRbn+Z42jHUYrzFDPqB23ygLioy1VVwd516aDO+ZjGdZXIhdQDv2rSmo1Jq3ne/zqrmelK/Ipo34uGQ3/UJQZAasn4XWI2FlirBLgFJpZFcgqsICBzSerhA1MJKay4b/U2ef5RZKptVd0N5rq5aXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UTKPT/8v; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTKPT/8v"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ab7044083e5so229001866b.2
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 03:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738928474; x=1739533274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yo5fC8nAcuJ1xporhMrmgvxA4ifRdS5ezb/LAyQusZU=;
        b=UTKPT/8vUCWD5WjzJGO/xXsK3gfatN9rxH05rwFSCzm3aAxSNsmXeS+1gwPtFUsbMu
         vXboYwAa7HxOjj7XAAQhecERojdOuxw5wAz02uR7E2i9jjmsXtTfjtkt8PtDxCPCnMXm
         5bX0nI4u9VvgV6ZKs/0ycCT+i6w/PimDpCdSn3SaBGY7q188dt0DQTM8KidRf8s2S73O
         nEpTMtWyoXa6oNJHbe3SxZsLmTzk9d79/YdJrYQi5+F3x/LlBjRDC8OTrBh+GD9TSFMA
         UQAbuefs4r+q8tMYBi+p6snQSNXK9b+nDG69VpjbhDlBZN1JkhZQJl+NXZyW/KhGXXkB
         TULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928474; x=1739533274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yo5fC8nAcuJ1xporhMrmgvxA4ifRdS5ezb/LAyQusZU=;
        b=oh56yytrLAqS79834yELrEFK3DMaXPaxfDlX3eyqU7QTWK5B4tTl+qjcy98cYq81xw
         XtK05AlOqfYTH3U7Et2RoFB4OXMM31zj3h+BfzQJfRAVN5USQ2+oOD+j9Z8GajI/OdeG
         Jr32pWSEAUJcfuPpa9ViX4DiWHORFKEQiWQghPk1Mo0tqXvUA0os/vhl3dcp7C0Z4Pit
         lLRHDiSh/lHM42lRgue0NwFK6cjDeT2UL9PIpPM/n8t19cqY5i3JBxbA5K55S2ziL70U
         D2kRJrG9DuCUWkr6DDDqWnj7KZq5+KD4BPq0M4qXSbmu6AkbZ9viyX9FAo3bskLXu1PH
         Ey2A==
X-Gm-Message-State: AOJu0YxV3NigQBsgPqaiXrTcF+GXQ0Cl7G+Wj2vJAGZpCt7zJPFS94uV
	z8OTdecdsSTqVD9rMgTqoN+iUD1KNMC4KhdCTPNoMA17FDK9rJ0hRoJy15v7P7f8XQQ6eIK1LkD
	/L4lblQ==
X-Google-Smtp-Source: AGHT+IF7i4bvBUwvrTusX1faPC38K4YhZvGfBQE+HZAgUhpE5GRpUvzoN23qHS0qePceS3ZLp8cI8tm4tGUi
X-Received: from ejckw8.prod.google.com ([2002:a17:907:7708:b0:ab7:9049:59bd])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7e9f:b0:ab7:5fcd:d4c4
 with SMTP id a640c23a62f3a-ab789b211f0mr292686966b.33.1738928474654; Fri, 07
 Feb 2025 03:41:14 -0800 (PST)
Date: Fri,  7 Feb 2025 12:40:28 +0100
In-Reply-To: <cover.1738928210.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738928210.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <8d6774cffb052c981d815a86a8b66fca0f727138.1738928210.git.dvyukov@google.com>
Subject: [PATCH v6 1/9] perf report: Add machine parallelism
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, ak@linux.intel.com
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
2.48.1.502.g6dc24dfdaf-goog


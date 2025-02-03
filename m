Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C7213228
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593073; cv=none; b=rHjRR3aZ+UMEllzzXybv9jnHyHZntb2DD12A5dFpZsOqGiLlV+X69fvsZ5A/L5an6+1WxeZxxNAFCSSYyXrXGe4l+DSssRFU3/T/fZ77F2pNT0FFoRd9E154SEPojGAcBS9eQRJTds5IWAXrxRoW95rpNomp5JWi7BaURUdLaJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593073; c=relaxed/simple;
	bh=mCUuqANy+yIirvStGy+ihDF5Mjg3/pOlPEFxqwt4Lks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KEkJor4O8SYtxz/c5JhoXT+p4bGbKPtJJ/LmLJRDAMbCa1jar/5dg1X8aPLVqJnzTsDY9Ak+3e5vpiHrBJi3y+VgBL6vUTrejyDtiLsmZcBAnYuitMlYHtGzp608Fc7JRL6+TiNpzautp6LKeJC0kIVEFgVqg6FxeWJ7oLf0W7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pI0z5PZ2; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pI0z5PZ2"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5dbe8a4165eso4936597a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 06:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593069; x=1739197869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FnxTA7/lzeZN78ebNQoH43GndLOusnP4mO8C9596Y+4=;
        b=pI0z5PZ2pePWbAeZnAS6SdBBuQJZKLQuMXOkff2c6wGhNyG0Szh887H9AjobxsvGRH
         6wh4+iaSMztP3EDcdzTvqRSAbfLSWp7z/lCZ6aH0DKeFrOP5aJvKM/vDRmSTNclqKJqu
         p/P3/cRFRCEkwGB4GCzLaogP8iycGMXpMwAmkabPch0pefETEdYOPu9RbdmGgJiVKfDQ
         Ckt0yy/yeJHcQgnGDr1tJUT2SfMYRGNS5mVPCjoYpJyAAjio1bD+QTjB8IRuYLmTOQDP
         ZPwCL5bb8m0kh7XC5Qzl11fc+c14A6OA26EfyOBQedue//HwtQ1myvOgcNtgKH4I/cKx
         RlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593069; x=1739197869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FnxTA7/lzeZN78ebNQoH43GndLOusnP4mO8C9596Y+4=;
        b=UshIaB08LuLqfJEhXkM3BDV5oDl6VQ5CO3KMbj/+u0NRhTknayKE39CoiPP14dXidq
         GravYPUzldB0NCU1PoFGw6mSEUGgFaL4FFQ4yjwbhaei/EWKWbk3X7Rr6CTesaFxOck3
         4oCvc9O2q3tAWYVU5ALzfYPAZlhs7xUaq3kzpkOFOJiPTYD9OTY0ZSqkJNW+so8B1jq+
         fnWWSiP9mfIFv8Uz7pV7Vp8CaBi/xWu3DRXxpKOte7oFuyT3QV5qLX4GxyONL28uUowG
         /DmPoKWvzr1E4Zc91zxGn7KRJk3BDPRUTIlFV5NiR6WZaMay6t5EczVvJ5dF/Gv5/u10
         Py4g==
X-Gm-Message-State: AOJu0YxN6lhmtIl1uQF+wARtyQEKlDyPWC3HNBIOxuNop4VYjrTJLUFU
	2ujqdBqw9mqm2HZWF6xMe0c/6agb6CyRK1FzFXxRvQuQTyDVuziLzFtQpFRgsHylimFcU7G5t2B
	njrGNCg==
X-Google-Smtp-Source: AGHT+IECpseKpYg6zjGUZ9HFqb66BEB3YO9OMu3iM+14CY4xn135PqCF/dxpMSAkM7XFJVb5pHPUNelWnVDg
X-Received: from edax7.prod.google.com ([2002:a05:6402:4147:b0:5d0:258f:3049])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1d4a:b0:5db:f40f:1a5f
 with SMTP id 4fb4d7f45d1cf-5dc7fd27f9amr14232234a12.15.1738593069651; Mon, 03
 Feb 2025 06:31:09 -0800 (PST)
Date: Mon,  3 Feb 2025 15:30:36 +0100
In-Reply-To: <cover.1738592865.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738592865.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <85d8b0c00dc94cecc64aedbe52215505a791d5e6.1738592865.git.dvyukov@google.com>
Subject: [PATCH v3 1/8] perf report: Add machine parallelism
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, acme@kernel.org
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
2.48.1.362.g079036d154-goog


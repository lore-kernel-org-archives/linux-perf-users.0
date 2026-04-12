Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C0347520
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959786; cv=none; b=rNxOFe8I91IRSTMzuEgdnSEMSsD74ZgW48Xm+Wd7gj9fMzfokdNaJ4RGWqlCz+K47lxrFrLgbWv1PIG/lR9clux0bhKPCvyKcL7m4tcXTPvXB1U+CEU/92jF9HwEnOC6bZxFyCNjssoEcKbXz41yQeEDqJ3CqZeTH8zvOTDHVXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959786; c=relaxed/simple;
	bh=dVAsi7bYYPJqnhbBpPHXGd5q5Za/B/TINrLvFtzpiD8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fJjy58GCEmF6eOUleFWoAJHHMdUea08ujPas2xhDsrqAVXh+mV6kpVh7CoCDPCe3pL+1CYvKzgam5QPujXq4OmeuHdI1CuruFGYhY0M4rqGkGG6CYzzrj0fhw3kQS9oUBSwD8g281M8/ZGEAqXPm5YtgG69d8auc6DCCREzbtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwi0MCYu; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwi0MCYu"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12bf921cf49so12625615c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959784; x=1776564584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3gAJ13cmq58H8ae4d4LEnv5+lFu4mwDfSGGPkW/FQa0=;
        b=uwi0MCYuCi4i2nsoQ401hKOxXDPGsy4MvHBeEAUbSZSEOJS9POYtXkdoLPwnZHsjZ3
         ZEo+04Vi8owjdel+3LL26hyNnXvWrq0Q5ouXpP6OpQEl7/G4WcVyQU3OvaT+jJl4GhD5
         Hw3LhHd2+Y0Qt7xxDNbSImhwGiMVaNDuml8c3ptWgznYzLG6jcgXp8ZbwHNRQ4PfCNiv
         1f0aLMvgkS4cW54jkYgyf0xouirTZtrXJU605wbd2GljmAbPNAVRoexcylWP9HaPju2b
         8lX7bl+lZwxn7QMtP52L9cCzoH7n5JOsmhyUfN1UgMIeWFNJHBYanh0vVjD36WIezwB2
         wqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959784; x=1776564584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gAJ13cmq58H8ae4d4LEnv5+lFu4mwDfSGGPkW/FQa0=;
        b=jzWL8pxj6BKsFDJsBsgE7/NbR+MmRAN1KKIeDJBPD1Cf6ooG9OxmOP+NrIhpKQ3OiL
         Fi/MIh1eQH1dXDlFtfe+9bpgvapQoRbZ52o3saqnlncRQwlzs75OAtQXZIqLnHz7zYxP
         9YnIy4O70Km7KSf8E+5lRXnrYhOamwkve7vIRJdu7oMq7QDJhxwApXDHlV4NXCP+GsLk
         6V2fto+ml1/dYKI1QnVcz1smshqTN3bhCQPIy6X84chv6RuqN4YnQZZLJcY9yrmo5Z+K
         P2Pm8VgZa4GSNdaBBlvxjDmDDzEDfhT92/kXFPmybetB+orGvvpSjPWrLOQFKnvULglR
         YDxw==
X-Forwarded-Encrypted: i=1; AJvYcCXjdhHRaKnLr8Kr0oDdflmakwEO4DlgxN0wo4Ct9TlMi+bCFEVt44KylyZ28UqaPy+VAAG4wlOXCRp5+RSWhy99@vger.kernel.org
X-Gm-Message-State: AOJu0YzreeoMnikkKIgJRkfhdWKG+1dVWH2DukxJgZ8vn1StJG22iE/s
	GoR5pxJsEXwBHXuNi4DKn2TEFZO04awsUYepqXfbjQuUa2QdGAJU9dFJiv7XAxOzSC+43LdIGOi
	7zfWQFdWVJg==
X-Received: from dlbsw14.prod.google.com ([2002:a05:7022:3a8e:b0:12a:8440:6d03])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6287:b0:128:bec5:1b37
 with SMTP id a92af1059eb24-12c34ea90f3mr4482933c88.16.1775959783888; Sat, 11
 Apr 2026 19:09:43 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:29 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-27-irogers@google.com>
Subject: [PATCH v10 26/29] perf timechart: Bounds check CPU
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Ensure the CPU is within expected bounds to avoid out of bound memory
accesses in arrays tracking CPU state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 35 +++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 64f69bd67c6b..64903b54e8a7 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -607,6 +607,10 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 	u32 state  = perf_sample__intval(sample, "state");
 	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
+		return -1;
+	}
 	if (state == (u32)PWR_EVENT_EXIT)
 		c_state_end(tchart, cpu_id, sample->time);
 	else
@@ -622,6 +626,10 @@ process_sample_cpu_frequency(struct timechart *tchart,
 	u32 state  = perf_sample__intval(sample, "state");
 	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
+		return -1;
+	}
 	p_state_change(tchart, cpu_id, sample->time, state);
 	return 0;
 }
@@ -635,6 +643,10 @@ process_sample_sched_wakeup(struct timechart *tchart,
 	int waker = perf_sample__intval(sample, "common_pid");
 	int wakee = perf_sample__intval(sample, "pid");
 
+	if (sample->cpu >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
+		return -1;
+	}
 	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, backtrace);
 	return 0;
 }
@@ -648,6 +660,10 @@ process_sample_sched_switch(struct timechart *tchart,
 	int next_pid   = perf_sample__intval(sample, "next_pid");
 	u64 prev_state = perf_sample__intval(sample, "prev_state");
 
+	if (sample->cpu >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
+		return -1;
+	}
 	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
 		     prev_state, backtrace);
 	return 0;
@@ -662,6 +678,10 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
 	u64 value  = perf_sample__intval(sample, "value");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long long)cpu_id);
+		return -1;
+	}
 	c_state_start(cpu_id, sample->time, value);
 	return 0;
 }
@@ -671,6 +691,10 @@ process_sample_power_end(struct timechart *tchart,
 			 struct perf_sample *sample,
 			 const char *backtrace __maybe_unused)
 {
+	if (sample->cpu >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
+		return -1;
+	}
 	c_state_end(tchart, sample->cpu, sample->time);
 	return 0;
 }
@@ -683,6 +707,10 @@ process_sample_power_frequency(struct timechart *tchart,
 	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
 	u64 value  = perf_sample__intval(sample, "value");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long long)cpu_id);
+		return -1;
+	}
 	p_state_change(tchart, cpu_id, sample->time, value);
 	return 0;
 }
@@ -694,10 +722,9 @@ process_sample_power_frequency(struct timechart *tchart,
  */
 static void end_sample_processing(struct timechart *tchart)
 {
-	u64 cpu;
-	struct power_event *pwr;
+	for (u64 cpu = 0; cpu < tchart->numcpus; cpu++) {
+		struct power_event *pwr;
 
-	for (cpu = 0; cpu <= tchart->numcpus; cpu++) {
 		/* C state */
 #if 0
 		pwr = zalloc(sizeof(*pwr));
@@ -1517,6 +1544,8 @@ static int process_header(struct perf_file_section *section __maybe_unused,
 	switch (feat) {
 	case HEADER_NRCPUS:
 		tchart->numcpus = ph->env.nr_cpus_avail;
+		if (tchart->numcpus > MAX_CPUS)
+			tchart->numcpus = MAX_CPUS;
 		break;
 
 	case HEADER_CPU_TOPOLOGY:
-- 
2.53.0.1213.gd9a14994de-goog


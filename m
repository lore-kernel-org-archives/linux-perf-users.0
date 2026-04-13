Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5AC38A299
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053590; cv=none; b=eGrfdUwX3vNwWXR8jsYuwHwQis+kQ1vUyoH46NLpuOCGbJcK9/45ulAdEHNaM0pK/zjDLyN2MkPVw5Pcy+bMK7l5qylA9uJOEzv8ZcHcHD6vOJnSronMsd/GT7qRivVSnSoyjIZqX4bR4ZEvOmYqp5d6yfNuwmw+++ymlad4kGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053590; c=relaxed/simple;
	bh=efLws6CWItfMARHwLMrmTPkXaixFU5L19SyevaVhz6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N9H/vLNEQ2kIC9ECmIaMazQuXoOH6bxbDQNoT58yqkGLwpvcPIeDI/09J1x4iEUcIvNUespEH+NUwo/D9FYieYCMGbJpJqYuqlTAnsbiiXXdH2j2tK++k42YtocpVA7DvUvg0B/rF7oWbhxkqsaPmf4jqaWA8NVaHYCJwWksyJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qncLtZRV; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qncLtZRV"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c16233ee11so5381371eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053584; x=1776658384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HQBeQ71sg5sqBmCvt3LAV9Ox37tWm3Hf2/nA+LCG7k=;
        b=qncLtZRV75F3XTY3NX43E9GEez3CeEyXXD1wk63R22H3Fx2I58VOXgWpMQHGU+NKxn
         6+TAi5875ezd58EQn00HD/FgqP+vZsMpiEu8IqexbjqkxEjB/tb8witmGb5/D8Cf/jSL
         OvLvtLNcrxreYDcKeQvQwl3tOxNnC6eQLoSA3iyefawyOGA5Clf4fb664fPiE7wMwBy8
         ClHkPcjBFYQqDhNWOTfMDyupwDSrGBOTJqGAwOmI4N4SvsJGzbu8844pgxVMetKpuG+z
         URtN6d+kWZO9UB2bGgaJMzSxvI1gwYWjAIA50AAbv3EFlj3LVEXg09Jk55k40zH55f0B
         hN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053584; x=1776658384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HQBeQ71sg5sqBmCvt3LAV9Ox37tWm3Hf2/nA+LCG7k=;
        b=f4yqboxJVoxAQ67NgJsHowfIG8UyqUIah4IiuuSuvcZnl8+ATg6rYnBZOlAQQHbSO9
         xZiEusQJ8AvMpScXlspE3gbkzYOHaL+QSmrvJWtUV2OK0p90rMN/UlROWRnA2kcdx0s6
         /ohU73EpmxvwFuNFE23J0sexUhFc4+nPEt1HVm5BshO/i5r5QArVDRtzTPIt+YoKlC6+
         5FNFIN1yKOJMIp9Gn0wOkWm7C9rnr+SfiD3Xq2BnKXxXOXPuXQ1gm3wAvbCXhifPwFE2
         VULHRI8wor0ynRdcvLJHRioW1sdt+a+9N+Ct16FNOcaiuTJpO6rmj6mV3EE6TEIBb5ry
         9f+w==
X-Forwarded-Encrypted: i=1; AFNElJ9TqyXC/X7L+ccx6BVDKbiv9GrSG4T0VxUkZLUVSIBCCbgE3HCB9SOZAzu6+oAmJDPhAKMnfjFwXxn2PMlQfe8q@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4nZPLGQWYMFNkgelKweKq39dJVBi0GuC8+aDw15rr4/VB+qN
	knlDlVq2UYu+QrjNJQA4nGxORP63cdlBwPpZBttpgSfxQ+vpNeTv5cUZXv/yexFydSIG8RxlPu5
	WKtiImDfwcQ==
X-Received: from dygg16.prod.google.com ([2002:a05:693c:80d0:b0:2d1:13bb:389c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4627:b0:2d7:6cbb:90ec
 with SMTP id 5a478bee46e88-2d76cbb93a9mr2286151eec.4.1776053583403; Sun, 12
 Apr 2026 21:13:03 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:39 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-30-irogers@google.com>
Subject: [PATCH v12 29/33] perf sched: Bounds check CPU in sched switch events
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

Prompted by Sashiko in code reviews. Ensure the CPU is within expected
bounds to avoid out of bound memory accesses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 45439e2af8ff..8b0526d342e3 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1791,6 +1791,11 @@ static int process_sched_switch_event(const struct perf_tool *tool,
 	u32 prev_pid = perf_sample__intval(sample, "prev_pid"),
 	    next_pid = perf_sample__intval(sample, "next_pid");
 
+	if (this_cpu < 0 || this_cpu >= MAX_CPUS) {
+		pr_warning("Out-of-bound sample CPU %d. Skipping sample\n", this_cpu);
+		return 0;
+	}
+
 	if (sched->curr_pid[this_cpu] != (u32)-1) {
 		/*
 		 * Are we trying to switch away a PID that is
@@ -1813,6 +1818,11 @@ static int process_sched_runtime_event(const struct perf_tool *tool,
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 
+	if (sample->cpu >= MAX_CPUS) {
+		pr_warning("Out-of-bound sample CPU %d. Skipping sample\n", sample->cpu);
+		return 0;
+	}
+
 	if (sched->tp_handler->runtime_event)
 		return sched->tp_handler->runtime_event(sched, sample, machine);
 
@@ -2775,6 +2785,11 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 	int rc = 0;
 	const char state = perf_sample__taskstate(sample, "prev_state");
 
+	if (sample->cpu >= MAX_CPUS) {
+		pr_warning("Out-of-bound sample CPU %d. Skipping sample\n", sample->cpu);
+		return 0;
+	}
+
 	addr_location__init(&al);
 	if (machine__resolve(machine, &al, sample) < 0) {
 		pr_err("problem processing %d event. skipping it\n",
-- 
2.53.0.1213.gd9a14994de-goog


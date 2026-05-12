Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D73B19BB
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625087; cv=none; b=BhbjFN6JzOMME3F2XznlLpgdsCyKOFxPkInMTGoH6SDMJARDHIIpY25YOOFMKUJIqHeUIWlWIVtTsnz3WOmGx1FrFpaO0i03GretoWT1KVR+Jn/6NCOnhlkwvR/i9lnZaRPKJhC45mrVGpdtK6KDCJhhWiZuR1BdVOWjfRnQjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625087; c=relaxed/simple;
	bh=hCKScr0WyxS2YrGmzRYYWXtF2RzqMKzfCJgP0LJhJ4M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fYi2JR6kusN59IDNptaTRMrYLtwUc4051XTQTsKF5LBoUyDa6CQ4aPLw2upWRHjMZ5mb/loKhc4w9V0A4XG8tW+xrTWY0Qp57Zq4pvMTvhTMEjvCMjSSzv1MnbqyI372bf18EW5I8g3XXHmy2G4X37APog9JOCmNwzuzxShXLy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGQqL1R4; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGQqL1R4"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f3eb8f3419so6230488eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625085; x=1779229885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LaXSnJWA8ji1yftg/70HKFa45P+2lJEw8f9JpbpekOg=;
        b=HGQqL1R41CleaiHJsMKpGXlnBhOYkHHCyVXgmRPIEJWnvNpsE6M4GNSVnrLtGYRabh
         pb/5Z46kb9AVDnTuu7+wLTCvpyrAE9snS48wZLdJeECbnu6yQwqayxaJIx/0YbYkcjM+
         oQIBHTnda29n4h4fWiBrn2Fnp4C1GNHO1viSebeOSIvaau339qf9j5YYLiLMAZ+XtWaj
         LncA0uTOD3Ieytcvw2hZqZdYRKOvHG0nSsQczns/7YUzKX5wDF/yAl+EVyQiT9k9LIYc
         RJxyrgPOvsAKFZyRJj3p7NbK9NomEcmvkb7rskJMVLk6FKfc0J5O9hfcGCcr/U6Pw0+5
         XALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625085; x=1779229885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LaXSnJWA8ji1yftg/70HKFa45P+2lJEw8f9JpbpekOg=;
        b=iInUyY5pyx7fihHGiKNrYMTyV8hJ+iuQrwvPaxrU0Psj8OSHNuXSPUClU62JddRwqC
         5/rbvS6cfcJvWUFBWUkT8rv8/o/2BsYCANXUI5d/SqcXUOE4yIfQZeORz7sQS8URSFgM
         5GZhqb0YFygERR6tM31UsTAWe8l00SP22wB0YxdsRp5ji7p9bGAJ2HjhLsEVCzDHWmSb
         RZAz55gHNtY96QDIIfPwYPgvxx2MqFgwKiSMOAdOyb/xgtzgeTWg1mugsMIbsGM8xK+6
         5NutGWXRr6x1auFjs7RqY90tDmX2rnmQAOtaOak0U4gQIyaH7UFhyWpD3TuBPqaMYcXl
         T4kg==
X-Forwarded-Encrypted: i=1; AFNElJ/O/1/NUVZIZFDZKed3Bs1+uP3ej7dZX9JY1WEabGt3k4EYKshml+6FSZGv4FJJNR7m0o5w/eSKZnkx+lCPbDfC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7cOxx6mNCNU8BTRrPScNPXwTAncp/ylbujjTnsNBp8SAj8/Ks
	5HHbT6tKgYAd6a8X7XkTTLcNuM15xSJDkbxS3j0KDip8aBw9q0/hbW2beMrtR8h92UiL3VHGkOL
	LjN+/Wil31Q==
X-Received: from dybia12.prod.google.com ([2002:a05:7301:30c:b0:2ed:99a:4f3f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:198c:b0:2da:10f0:a8de
 with SMTP id 5a478bee46e88-30117576085mr642775eec.8.1778625084833; Tue, 12
 May 2026 15:31:24 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:57 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-29-irogers@google.com>
Subject: [PATCH v13 28/32] perf sched: Bounds check CPU in sched switch events
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Prompted by Sashiko in code reviews. Ensure the CPU is within expected
bounds to avoid out of bound memory accesses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 45439e2af8ff..a637ce2a7c34 100644
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
+		pr_warning("Out-of-bound sample CPU %u. Skipping sample\n", sample->cpu);
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
2.54.0.563.g4f69b47b94-goog


Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646684028EC
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304003; cv=none; b=uxUJDQrLAJe035qVXCH81aaj8pakmDposUQ5Fm74Rs1/mW5Et9jU23q1FNOHi6wa8mfXCivn7rr1LDGmC5ORqciTFsujffEOzqBjyu0W4S4bTPeDiXnW8xoqmhPbNJrHAk5/SNykO4k7XDbB3BUtfdJln0KbH/uCEjKUZ4ffPF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304003; c=relaxed/simple;
	bh=MPppRBe60tvJYp0BqyDgLh3vcNIT2ZeLAESbSxhot3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a3mxk5y1J3uu3kw1Va4umv0EYg1K0Z0lXSqjIke5k5qu6h8n3JzBnzTBeU9IzIYEGofLC5Vp0rZ6udOIQMsS8pL1V/6fhga3Cvx/3rcDMR6x/xY4hxjufTNGOtOTUo2yPEu32XLeoQgURT0WyI/tPTlA/OEpJyXrpc2KWnnIKuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IjWJlYJu; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjWJlYJu"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-303b38ec2f6so7339593eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779304001; x=1779908801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvZIoBAdPpGsvWc5QRVNgc1NcfjcXh8BPa+JunnxBOs=;
        b=IjWJlYJuZhYf/sOK2sHfD9gYYxWytjq/+L8ABv/us1Ba+Glrtk4MO7YQZEw1GFnqsG
         iDZkka6BadAP4lAqMUKd5ysv7oJOYGALxsMrhkBGodBND3+DU1dVFLysOtsBKDjNrp5H
         IZYQI9XKVle22X9TSSCcJV0ZAc+PPR2q0PI6UbkXe922zpskAAXFyiiIcRWsiBXAnnus
         sic285HOdXVRuGfIMP8Ov/GOEbRyN62C/GdjMdVtx1kFoFN23A5HR+LWiwxqxcKjeu+/
         j5wusDjGj4HBmKrpZyHDqxVu4ND0DBwa9U3bvLnV9JUnhTSMMfVzrEbQbGcXjMT67ZxK
         fK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304001; x=1779908801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvZIoBAdPpGsvWc5QRVNgc1NcfjcXh8BPa+JunnxBOs=;
        b=Jt0V61N1cLacf+si37yuytIkjxX6zAdvoo/gsodsbHhnLj1fuipfoso81azfpAqir2
         WDBmGNF6FK8toMB5lOkiHJTgJyovDv/wnqdiNPNOeCxnNAhWnQMqBRax5nXKeH31Uv71
         oLzvSbL1U4i4qCX2O58Y74/Aq8SP6YTrpJDyZhaTLCO8cvIW/LcQ8NA4sKf4c6iOyIxg
         pvnOULjUWBaWxzZN07X9CnebP6uuCyu/Kf6v0qFf4a90FVLbOcv9CVcxERfubMN3DZFX
         0NFgAE+NmFAKLLQ6YmVnxRq8vWCs2rp+v4bKWNgJgJjAIoERBpypoiIFJVnCG+4k2usn
         RRmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6QBmiSHL0PaWkzg8G/Mio7TN4yQq5cmUm0XH/oQYFk7bleZPPZ82Oqb3RVpKdZeyRyIpWxOzkuFtTqDV7mWDw@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgqTFzvUfLqMzICjfrFub/anp/x2aRpme6R9zJzMcshdZ5owC
	vt9FOGHa9Rlk2aczsbunl++/84B66h8mcdzLV/YJhJGWhMGo67PR6JAN0XY7UDV8eSIcPJUbsWm
	cywFcfcAJMA==
X-Received: from dydr14.prod.google.com ([2002:a05:7300:50ee:b0:2ca:9b08:e7c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d511:b0:2de:cc07:e83
 with SMTP id 5a478bee46e88-303982ac0c2mr11066871eec.15.1779304001266; Wed, 20
 May 2026 12:06:41 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:34 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-29-irogers@google.com>
Subject: [PATCH v14 28/32] perf sched: Bounds check CPU in sched switch events
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

Ensure CPU indexes parsed from sched switch and runtime events fit within the
MAX_CPUS limit to prevent out-of-bounds indexing.

Add explicit bounds checks for sample->cpu against MAX_CPUS inside
process_sched_switch_event, process_sched_runtime_event, and
timehist_sched_change_event. This prevents indexing beyond the boundaries
of the sched->curr_pid tracking array, avoiding potential memory corruption or
undefined behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-sched.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index d984e58c7dbf..9d73c7043182 100644
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
2.54.0.746.g67dd491aae-goog


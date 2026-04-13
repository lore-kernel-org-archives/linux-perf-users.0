Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5354D2BDC13
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043418; cv=none; b=DtpRhgjXsEae8jyRNaq4vUqS1BLgrV3mKtp1SiLN7OmctDYBC7CMXhWAsIsTsG+Tsu+OrAfVjKFl9s8f4gsJye8/oRAhSfmZLHKiwB2ZMEZyJm6/tWwPmpnfZyzj7DJFwo+Ycbr+2ZEfbovU/NZIm6/6Ptel9+6tguPLkKORrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043418; c=relaxed/simple;
	bh=yx8AkPPpD2Sp+st/2098+LZAGIagjG0tVwYWsU2O4GA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rVymXKUU4Z8uwlGx9dOotXIg5T93byETsagZKmN2FOZIEOixF9/hC4wH3DqSyXfOc6osOouklvH5/PQvXcoQ+mxND3MYfrcew5X89LVjXltkWSWqWDSuLcAHwMz/zgMujD9MH3md+Ktv/y7wDERbfFzymoqfiTCZosyqp5f4ifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NVhmzWyT; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVhmzWyT"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d70f60aff7so5831344eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043416; x=1776648216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2iFG1V1ADs66SaGcnWhOCIW8PxKEBsq18U8S+fNjRdU=;
        b=NVhmzWyTgxKn1eLEwF3tKLIvUH9V9IbIUTh1ouwgJQ+opsFrZKatAAU9VUJjD0nfuD
         1Sg7KCxlaHJx703jIxiUVaBYSH9Jg1ihKLBak7BmdHdNuOczMl5F/sJ6Lfh0Rix7Oy0a
         ReiFzhUIC0ayDhcuZy7WKhTkn4xiGvucfxbeV5cdo2sDZ33+cTL9Lu4O70SEfsfKxVQa
         7Zv2U5sBg6FMkjkWwXxAI5nKy7SrcxTYlTO1UvfBdlRfgBsV4THXtyx8qsa7pABvT9q2
         VKaNzbCt6ss9o3I8NQiWculchmqBz7HYmw5aWFbtQ9TL8665vlzaP+SFslwDTMiys26A
         CPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043416; x=1776648216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iFG1V1ADs66SaGcnWhOCIW8PxKEBsq18U8S+fNjRdU=;
        b=se6Ccnn53GTIDrVCac+Q6Z5zc1z8ppLjVRn5ZBlPNNB/qBtN1TUhkECDS3YM7euP7g
         k/+Lhl6r0JZcFzCJ2hS1CVucOLcKw2C+JGb7BzUQqv5LW4iSteNVJqNmG4pszPZhUgX7
         1GIzrkEqVdVI+KD7SdnuyZiKygcU371L4+f1Q92DVGfYQTVXQllAfN7pIp6ca1QPPrBe
         gQDDuoSzPkQ7ZNmh/v+KbvfB3e+996p97i+1UJK7g3BC5qs5oCUhE3uIm3/fnRhG+uDr
         gpompNTTmsulA6AgaS8ZfdRP7ngxIHb087Eqz8Pb2K9mMuH8CoeDdqfvN6M8Og6OT9hr
         hKFg==
X-Forwarded-Encrypted: i=1; AFNElJ9C5UhdZwSbrOQLBbVuB4GuUb0/rMdL1HSPsUMOjwbc1M85Evgmapns+rPomnTBoIMIlsMtqH7pUmL7Wg7b9Uqv@vger.kernel.org
X-Gm-Message-State: AOJu0YxC5ZFEZpiqhzaffdGdtMrfR6SsqVESSxC/Ute4sWGaejMd+MXV
	bGXUBXFuWy/uIZoqp20BTU+iikKGBXAMCE8jQ8zuRa0dkpo6JvPrEmQTqyCE4/QSpty6j3e9Zmq
	JygNRddpHXA==
X-Received: from dybeb10.prod.google.com ([2002:a05:7300:a2ca:b0:2d5:d26c:d4bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4290:b0:2d8:7302:d37
 with SMTP id 5a478bee46e88-2d873021507mr1286149eec.1.1776043416162; Sun, 12
 Apr 2026 18:23:36 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:23 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-30-irogers@google.com>
Subject: [PATCH v11 29/33] perf sched: Bounds check CPU in sched switch events
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

Prompted by Sashiko in code reviews. Ensure the CPU is within expected
bounds to avoid out of bound memory accesses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 45439e2af8ff..008e3bb0ad6e 100644
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
 
+	if (sample->cpu < 0 || sample->cpu >= MAX_CPUS) {
+		pr_warning("Out-of-bound sample CPU %d. Skipping sample\n", sample->cpu);
+		return 0;
+	}
+
 	if (sched->tp_handler->runtime_event)
 		return sched->tp_handler->runtime_event(sched, sample, machine);
 
@@ -2775,6 +2785,11 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 	int rc = 0;
 	const char state = perf_sample__taskstate(sample, "prev_state");
 
+	if (sample->cpu < 0 || sample->cpu >= MAX_CPUS) {
+		pr_warning("Out-of-bound sample CPU %d. Skipping sample\n", sample->cpu);
+		return 0;
+	}
+
 	addr_location__init(&al);
 	if (machine__resolve(machine, &al, sample) < 0) {
 		pr_err("problem processing %d event. skipping it\n",
-- 
2.53.0.1213.gd9a14994de-goog


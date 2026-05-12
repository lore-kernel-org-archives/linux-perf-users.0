Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020293A7820
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625078; cv=none; b=unJkUCsiEBd9ka1RQhyb4V/vQ5vEybnHARIcfI19IMCofUnnZbELWa8+42YNyN5HKxNN4fsymydc0ubsFKtCWkYL2viqsSIMBlMfkDo6TI42nRSVyRjEhcv1qkgXzrT8zxqvF64suIkvZWjMGf0+CrTlwW0FT3r9XDnO4Fyq+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625078; c=relaxed/simple;
	bh=hvgb7FC84nvEyfEiP/Sj0PNnsoYzro3l9BrhLVQ0LZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZEEsRyM0+hLY5ZYoUWrxTnIsRTKF1jRh4klduTbjK80Kdd1sPOOf9LEjMxEmHox3/6twS+XK8MTnLgNJo0wP/ldw2SjGBFZoShn9JVBagbe0It00Aao4YqHV094vYfkDT0WpQagYAlv9nCu7J2tSvqS9umL7uyTcteW8JFUsLbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmVRNMgo; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmVRNMgo"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132a99125f8so7321696c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625076; x=1779229876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKjaZ3dzI18seBEUrUgjNQ1ME+XlhFOyeqTsd4L2T0Q=;
        b=EmVRNMgoTkhX9gPws3FT5g3AoeGasDTU9to9cmr/K37uAVgdz01onqujz6Q8r2crSi
         sRalLHfSUpRqKDe8/UUJE26lqrzLTNUFKXZehB1YE4Glg5eiI6grFNXlOsE4vz6Fer44
         79Qhg5K7Y92Uxp7jzL+VHiTZDchtwLqiaDoccyDmfzNUriURWSKSdsdLNgqx5yUhjhCF
         Ph/ea5Y/sry+GJACfn8YXB1geWnotPXGuXMhtX+kcRsexyUqgfonR8CEqZw5hjWqa4BY
         1zRLIjNiqjWeDxYIUWzjnDliZUAa2Q21bl7a8IHtOzWwMkmx81cHB7Oj0G2Z9kCAFBch
         T4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625076; x=1779229876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKjaZ3dzI18seBEUrUgjNQ1ME+XlhFOyeqTsd4L2T0Q=;
        b=etUpa+ca5KMPn19yhBva5Yh/sZL9kVO9FUALSFaFRrOQAxXtWyXg5oZt0mYEJyz3qV
         Hdpd1ZX8FMohZuYkYduZiPG82bIQsDJoFbcgXjHqYh1hwQmUXnXW9gKcqZ0wQX4j+iHh
         PspSxEHB6dUsJTqDeVJhXBCHS2boyAu+++dkboFcbFD8wCpGolOoxPMC5LldXUNzmdi2
         e6Ck7xvhLsfMPY/DKoiK3qtBC+JHMXi9mgStLxMXuGpj2hOXrr8F1gjAcsKw6S1l57UL
         noLbKb5nRD9VhRHjcTcas1Ay7mOQBLrqE3NIOzned6Fep0RDTYUVZsNIe3aNoh8dWTWL
         PK5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9mFP1unGwUZconZtGtStjqA8xLUFKUy4B+4d3GZcAZkjn+Wf6ZdgM5OJdVfr3mmBv7WdzcZmPOedVnP43iOms8@vger.kernel.org
X-Gm-Message-State: AOJu0YyMby7P7S2CInUnysrOpG1sZYNmEsKvQ0TG/12UVW9ZwoLLFIYY
	5cLjVMpmHPDNIi8NJyTJ10GTUl5k9A8onmFZvN4HaKOMUQAH8vUySulCG76Y+4LWrjFIH6dlpsh
	ukU5pvAPqZg==
X-Received: from dlbcj24.prod.google.com ([2002:a05:7022:6998:b0:12d:b2ba:b551])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:670d:b0:127:3915:76b2
 with SMTP id a92af1059eb24-13436991af2mr524854c88.27.1778625076092; Tue, 12
 May 2026 15:31:16 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:53 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-25-irogers@google.com>
Subject: [PATCH v13 24/32] perf timechart: Fix memory leaks
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

Fix missing free from cat_backtrace, which requires copies of the
backtrace being made in functions that save it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 1d24d8738519..64f69bd67c6b 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -299,7 +299,7 @@ static void pid_put_sample(struct timechart *tchart, int pid, int type,
 	sample->type = type;
 	sample->next = c->samples;
 	sample->cpu = cpu;
-	sample->backtrace = backtrace;
+	sample->backtrace = backtrace ? strdup(backtrace) : NULL;
 	c->samples = sample;
 
 	if (sample->type == TYPE_RUNNING && end > start && start > 0) {
@@ -433,7 +433,7 @@ static void sched_wakeup(struct timechart *tchart, int cpu, u64 timestamp,
 
 	we->time = timestamp;
 	we->waker = waker;
-	we->backtrace = backtrace;
+	we->backtrace = backtrace ? strdup(backtrace) : NULL;
 
 	if ((flags & TRACE_FLAG_HARDIRQ) || (flags & TRACE_FLAG_SOFTIRQ))
 		we->waker = -1;
@@ -489,9 +489,9 @@ static void sched_switch(struct timechart *tchart, int cpu, u64 timestamp,
 	}
 }
 
-static const char *cat_backtrace(union perf_event *event,
-				 struct perf_sample *sample,
-				 struct machine *machine)
+static char *cat_backtrace(union perf_event *event,
+			   struct perf_sample *sample,
+			   struct machine *machine)
 {
 	struct addr_location al;
 	unsigned int i;
@@ -544,8 +544,10 @@ static const char *cat_backtrace(union perf_event *event,
 				 * It seems the callchain is corrupted.
 				 * Discard all.
 				 */
-				zfree(&p);
-				goto exit;
+				addr_location__exit(&al);
+				fclose(f);
+				free(p);
+				return NULL;
 			}
 			continue;
 		}
@@ -577,6 +579,7 @@ static int process_sample_event(const struct perf_tool *tool,
 {
 	struct timechart *tchart = container_of(tool, struct timechart, tool);
 	struct evsel *evsel = sample->evsel;
+	int ret = 0;
 
 	if (evsel->core.attr.sample_type & PERF_SAMPLE_TIME) {
 		if (!tchart->first_time || tchart->first_time > sample->time)
@@ -587,11 +590,13 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
+		char *backtrace = cat_backtrace(event, sample, machine);
 
-		return f(tchart, sample, cat_backtrace(event, sample, machine));
+		ret = f(tchart, sample, backtrace);
+		free(backtrace);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int
-- 
2.54.0.563.g4f69b47b94-goog


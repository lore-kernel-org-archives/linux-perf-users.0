Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1F213E90
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Jun 2025 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059173; cv=none; b=i6ktL7D6TDQCn5Nn3tdgt4dXC+xwteAtDTrx2jABUob2gjyuED1iu45nz+lXkoc/6YfJ/XXALENljGwU3W0VF+Dib3vkumTEVYdD1IewzmdafnobwOKIzCvHO86TsZRMmktTDyeH1OwbMQA4bZh8SPTwL+fXlbi+3aNStxelnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059173; c=relaxed/simple;
	bh=8RJTcbaavtRa5sssuUXNrJxuZWZPCsk1MDl7ZbD+Gww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=by9Pj1wI0IOZBKzocYGcb4XYS3xgobS+NcqicyhrVRY4A/oSBaVC7lZpVJY0fUyu2ErIwz+zBc5Z6FNY9UI312bgHPzh/P/wK01quBr/9fvcEDKNjkQGaNqgi5iniHULEZZbG7Co+RjlyH8BsOwfrZTXdHXn11axczUQ9kGYNw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zlPWCFzW; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zlPWCFzW"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-72ecb622e02so12608a34.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Jun 2025 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059171; x=1749663971; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9yNfn5eRAho4EtZBNKkQLz+u3xqVjqDGPhEDNh7DTo=;
        b=zlPWCFzW9bZLo1g3Lwjsbw7mt6NYV9vAqHJtPeYRcZpQRZGnBAAfsMFLMUje4y9DXA
         sNbY9+sMjbtmkV8lc9XYtiViYYDJKLptcjHJvNfpaPs4PktpgQnejhrvo+1+QD/Q98Mz
         b1BAOo712tlyQnMmPcSe9TXY47PujMzrgncheIMDGlEd4V83Zvg8sAAjN2lSFrKCa6TR
         yhbvaHpXf2uiiXHuyVnfFBh2XKhyvc/BtYID1SER4f02d37umvvORGgfDdDqno2g/lbq
         acaidgsBXJ5R5cRWzNZuQcKrh4hoKO8FhnqFjq9FH8mp/CbGsRnBnfJtG7jiQASLzpiF
         AbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059171; x=1749663971;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9yNfn5eRAho4EtZBNKkQLz+u3xqVjqDGPhEDNh7DTo=;
        b=a36QBvj6qN0en8rOkURHgC9yLFD6jn8AbbHKipiXxZ7iPiPH47Yx3oSDvCyeqhoEHO
         X4/Tiju1xenuUJWC/qLS+24MAROzOBYLoMxSSR2weSwpIDFukEEps6u3Yba7wDasvvow
         Wo8wLzJtiCh/30xWi8DVOGw70VlF9DhCvJ42O84D+SYuqEYbi23eumscAUx+lyBLX4Zg
         Z01CLOkyvtLYhIUILqmbJ1muYAxbPvl09QYckDHGCcicMhsVQs4mO7dX9BZsRg6Croua
         xOrCdFXRK9MTysXHFG+KSMGMZvgYw/1RQCUHm6G4xqiJFlAWgw5QfBfYmWdn6kqE5WLq
         pMig==
X-Forwarded-Encrypted: i=1; AJvYcCX8JL1GFKLPQ5oTzQr1IrRJ3j4EFMWASeBBbQRymMkFj5mtSNcvZVUn1rKdGpbMt8n057yHLJVmKpaF+7h9QTxs@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyVOYEfXZXPyrPtpqOAdmOcxkHSc1brij1vPPnSmAEpoXr0tb
	kI8bY2nz910fxAjsHhy6DTRYICcUw4drJSW65e/Cm4fcMlTbnTLTqDSWEjck5gn74UiU+qmgc9J
	0Sr9HsBgVcw==
X-Google-Smtp-Source: AGHT+IE4gdMazXA+ZZ6u3qKDsWCX/dGkg5TUamz7U+qJ4v0aidP3AWFrx6m+vMK2PI1EgHELPCzVbt1PxPI4
X-Received: from oabky6.prod.google.com ([2002:a05:6871:4046:b0:2b8:45b4:8afc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:8a2a:b0:29e:503a:7ea3
 with SMTP id 586e51a60fabf-2e9bf641bb8mr2664304fac.36.1749059171203; Wed, 04
 Jun 2025 10:46:11 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:41 -0700
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-8-irogers@google.com>
Subject: [PATCH v4 07/10] perf trace: Switch user option to use BPF filter
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>, 
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Gautam Menghani <gautam@linux.ibm.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding user processes by scanning /proc is inherently racy and
results in perf_event_open failures. Use a BPF filter to drop samples
where the uid doesn't match. Ensure adding the BPF filter forces
system-wide.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2ab1b8e05ad3..4bb062b96f51 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -236,6 +236,7 @@ struct trace {
 		struct ordered_events	data;
 		u64			last;
 	} oe;
+	const char		*uid_str;
 };
 
 static void trace__load_vmlinux_btf(struct trace *trace __maybe_unused)
@@ -4412,8 +4413,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		evlist__add(evlist, pgfault_min);
 	}
 
-	/* Enable ignoring missing threads when -u/-p option is defined. */
-	trace->opts.ignore_missing_thread = trace->opts.target.uid != UINT_MAX || trace->opts.target.pid;
+	/* Enable ignoring missing threads when -p option is defined. */
+	trace->opts.ignore_missing_thread = trace->opts.target.pid;
 
 	if (trace->sched &&
 	    evlist__add_newtp(evlist, "sched", "sched_stat_runtime", trace__sched_stat_runtime))
@@ -5445,8 +5446,7 @@ int cmd_trace(int argc, const char **argv)
 		    "child tasks do not inherit counters"),
 	OPT_CALLBACK('m', "mmap-pages", &trace.opts.mmap_pages, "pages",
 		     "number of mmap data pages", evlist__parse_mmap_pages),
-	OPT_STRING('u', "uid", &trace.opts.target.uid_str, "user",
-		   "user to profile"),
+	OPT_STRING('u', "uid", &trace.uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "duration", &trace, "float",
 		     "show only events with duration > N.M ms",
 		     trace__set_duration),
@@ -5804,11 +5804,19 @@ int cmd_trace(int argc, const char **argv)
 		goto out_close;
 	}
 
-	err = target__parse_uid(&trace.opts.target);
-	if (err) {
-		target__strerror(&trace.opts.target, err, bf, sizeof(bf));
-		fprintf(trace.output, "%s", bf);
-		goto out_close;
+	if (trace.uid_str) {
+		uid_t uid = parse_uid(trace.uid_str);
+
+		if (uid == UINT_MAX) {
+			ui__error("Invalid User: %s", trace.uid_str);
+			err = -EINVAL;
+			goto out_close;
+		}
+		err = parse_uid_filter(trace.evlist, uid);
+		if (err)
+			goto out_close;
+
+		trace.opts.target.system_wide = true;
 	}
 
 	if (!argc && target__none(&trace.opts.target))
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


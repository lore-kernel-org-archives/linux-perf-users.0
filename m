Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF6828C5BD
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306623; cv=none; b=d5IbuQauEj2NEQVrWOl8uH6EinkXUuuoTYQeARIWRNS6luUNCSCmNC+nSV9SLXjbwErKl9j1ouWFdge7C0G8TC4J+FHTS5/Yew7HFm/Hj4GYISMQnGVdygjqz5TizF6fQKbsnYT5V7jQXANNd/lvat+hIEbA23ZP6tMipxH3uuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306623; c=relaxed/simple;
	bh=pwnF8n7mqD7yk9oNBMquJdU4/lh8MdFnDzv/GA7kVio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=e6G0X6EVKQ/GODO2108HDrKdPixe7vmAH/X/pbfU04jWFNmNkHpSLjFGbOb96v2R0cNPRZfZ9FYC68eXK6mkUKH8IA/qh99BQGlAHoviUT/Svm2Rkcz2J0JPZlOmhciAYe5qFcB1ug/VDUtJQJDm2rh4MtBHrwbPTD6dCArwq3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3fKEn+P; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3fKEn+P"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-229668c8659so8597725ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306621; x=1744911421; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpiUUvwlwp9tVCnJZ3TZUgEjsv1IVM8EEnnesVuXazs=;
        b=h3fKEn+Pz6OSFVCpDOszljZHfQXr0dLfzJkdBcKvgw+KCKrIsC8oXNEnmAsSqd9rEf
         JsmxFNiaOJRHgiYwgxRXodaSSnIs1hr5cDAri1SxncQ/BpUsvBqXNtW3IrExpseTdSz3
         QmNbeiQ+bw2+aRuD1TAt/k4m89qeFxvhZLSHgrzKwq6zPlOEMzPHk68PBwMjpPjTmoO9
         Mek7uXnINWAXZspY8ey7YOW+xQtODVaeCKzoEe07KFsCU2XTCuX7Nl8/gFGGCmDcRGpR
         T8HgJiYrvAlRIfhKkvcoqm4N3JLm7jiQbv1O7jENLfE7pvjmp/BhVIFiBT+RJ3PbpnAj
         wg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306621; x=1744911421;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpiUUvwlwp9tVCnJZ3TZUgEjsv1IVM8EEnnesVuXazs=;
        b=a1J9mVKS9MgJq6RbroTgP0x3rBnW/7raDNbJd5HWmTtBPA97XgmrrgVLluOpOaxh0v
         qgPdc0owZI1ti0zxMhqc/7pG2dGyKNE0sM6pwjTRAWvlF9ZrzD9Hwn0alJRMqmdkEgzv
         KJ993Ga7q5cLgQwg0MsyZvnprgPAwoXKwvigKgZ6HYBh+6Z8y9dibohc7eHVW+KfG8/l
         n/wxRgDifXFimilZN5Za0C0yTxI+bBYuhVpbLPgytL1Dxi8E/PC8cCJkh75YVFpbnBg+
         jcQYTPlwg0uJi1hwlW/La7dDkFlJlMKgNKAJTVw370k6+18Fenx/S47YAeigb2QbNgLs
         JjUw==
X-Forwarded-Encrypted: i=1; AJvYcCWJhg8YdBfUcyDL809gRr/v8xGUfz/VLguMVYBsW8AsqYxGmwskMOiGjrV7VgeN1YR5Inug8AZvDq51VsJGyUlf@vger.kernel.org
X-Gm-Message-State: AOJu0YyUIZpdFSnyT5pY7YGydS2t++BkYcCA4be9scz6cYKo4/N5Gbql
	78yAmjzEM7hfGKwHzR/tVktNWuqIRjFzelP9CyPkqc8LsEeDTvaH/NNKES4eG9qxsSpepHB+0lk
	2PzF4xQ==
X-Google-Smtp-Source: AGHT+IFwaCb2cDgkGC1n4/9Wz8pIMyxoLX83dVD19SJR7ZPEQ36S8XM3cNeUAEqdxlEjEYtd+dxtn/hNSjdL
X-Received: from plbml15.prod.google.com ([2002:a17:903:34cf:b0:227:b826:af9e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:120a:b0:216:2bd7:1c2f
 with SMTP id d9443c01a7336-22be02f73bamr41067965ad.18.1744306621413; Thu, 10
 Apr 2025 10:37:01 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:28 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-10-irogers@google.com>
Subject: [PATCH v2 09/12] perf trace: Switch user option to use BPF filter
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
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
index 6ac51925ea42..1f7d2b3d8b3d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -240,6 +240,7 @@ struct trace {
 		struct ordered_events	data;
 		u64			last;
 	} oe;
+	const char		*uid_str;
 };
 
 static void trace__load_vmlinux_btf(struct trace *trace __maybe_unused)
@@ -4401,8 +4402,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		evlist__add(evlist, pgfault_min);
 	}
 
-	/* Enable ignoring missing threads when -u/-p option is defined. */
-	trace->opts.ignore_missing_thread = trace->opts.target.uid != UINT_MAX || trace->opts.target.pid;
+	/* Enable ignoring missing threads when -p option is defined. */
+	trace->opts.ignore_missing_thread = trace->opts.target.pid;
 
 	if (trace->sched &&
 	    evlist__add_newtp(evlist, "sched", "sched_stat_runtime", trace__sched_stat_runtime))
@@ -5420,8 +5421,7 @@ int cmd_trace(int argc, const char **argv)
 		    "child tasks do not inherit counters"),
 	OPT_CALLBACK('m', "mmap-pages", &trace.opts.mmap_pages, "pages",
 		     "number of mmap data pages", evlist__parse_mmap_pages),
-	OPT_STRING('u', "uid", &trace.opts.target.uid_str, "user",
-		   "user to profile"),
+	OPT_STRING('u', "uid", &trace.uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "duration", &trace, "float",
 		     "show only events with duration > N.M ms",
 		     trace__set_duration),
@@ -5762,11 +5762,19 @@ int cmd_trace(int argc, const char **argv)
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
2.49.0.604.gff1f9ca942-goog


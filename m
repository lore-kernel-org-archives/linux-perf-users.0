Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0732C929
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770703457; cv=none; b=pZoaRZPFjxr7kOu/BZiwZyv8ZwIaAyQI715O/t/aF0ub+sHAysb9zH71+06euLaLKqMl68s1F0aUBxMFcPWD0dd6ZKDLGtehhoPnM1FermmnVAcqKfLIN0a+yqxFXzEPTcsJ5A0VeaDzLQBuHVUhBGG8PFG6x0WYFwvwiHlTPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770703457; c=relaxed/simple;
	bh=4h/e/AxUpfmxdWh/2XIxCaVxSOIKGoSbfQOiKef+stc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KnF1NXTwkQNY0L076MXczLqx9d9mDv0ay/BALbWhJTNdjpJluSI08yv0PVjQa4ULfVvg4WmBqrxUEKyh9KEyodqf+soiNa0Jy7cYVw2UxRcP0/x305M23pj6mCghDKyZ166HQET6hX1yFYVnKgJ1qfOyt/CVYIV1M6zatIVxMck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQt81+q6; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQt81+q6"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-123349958b2so9277292c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 22:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770703456; x=1771308256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MVDZXgJUA2hSu3vjasZfPoaK7yNybs3HQAJ9WY8Xr4c=;
        b=sQt81+q6+nK7JQX/j4wLqHQDno5WpWp3R5k9NAz2IntaJ+b2JdKWn+UhxAu9g0QuTb
         s1i1WeG7ZpLQyzFmimpMVP1zxUbckD2doghen4CnpbaQD6Shub04whvGIOJlkV/vPs0O
         Z7RfvA9RujxGk0yAEh8buuD2OSsCajND/kkahEqeYrDNxkr84Vmi+0EOohGcAwK+j0G4
         +CHRiVo4+WlaCFnIV+zo9SlAfppg9l2CcB0v+ebTG18M+140htKc74gUJB8TT2NgE6P3
         IckyMTXjcWUiXW3h6JxRsyRgqScuHVT/2fd3808/g87SmN0tTFIlC7KUzgN6EjvOmxqI
         uCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770703456; x=1771308256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVDZXgJUA2hSu3vjasZfPoaK7yNybs3HQAJ9WY8Xr4c=;
        b=Fyz1GZrZdkLqzxP1ZsqBVs21WsycXqotO5ki8VHJlZwXMZt20RNUrKjaRjvrkzDQQg
         3pVnlNnxsZBCzCtR6IuPCPBQH1729dfLxGt3PKoL0L2uPa3DnC+/Cb0P/hSmZwQEAb8z
         krVTXhji1+HSvDgBjd+SM7JoWL+Gul5QDSJAgt77E7j6dh3aHCdkaU0ckWbIPbSSPwhq
         9v26NfzcZVi+NsLHMqF8TKeJgzo73El6weS2AxCbt5leGrKr7YHgqBa/kwhqnMsM0Jee
         OhoT0HlQt8vN4xNDxeRKAXfZuE3XygtcXIm4pcm9kmNg4RKL1UfC7NbwZwUo/KuwhMi+
         iI9g==
X-Forwarded-Encrypted: i=1; AJvYcCVYRY5NRQXwcJV7dQdB1nwwAlUneo3t9PN/wLm3oR2/NETbjbKaUp7Ls3uhCEgeDM2hdqgFkUN+0XXPvCK0hltH@vger.kernel.org
X-Gm-Message-State: AOJu0YzhCgIBcQ9YYqpENw80XKVzoEM7CyG8dRRCT7PJq3jgwcmAZpEG
	vywvvcxUSen0oVaamNvd2fyFEwdYdQdBkIW5y9vWDrw8/ikp0Ced7ej6qCH40o+KETjUr4fihC+
	gmpfjUt1z1w==
X-Received: from dlbou24.prod.google.com ([2002:a05:7022:1118:b0:11d:cde5:d78e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:521:b0:11b:f056:a1b3
 with SMTP id a92af1059eb24-1272431e1bcmr595153c88.11.1770703455859; Mon, 09
 Feb 2026 22:04:15 -0800 (PST)
Date: Mon,  9 Feb 2026 22:03:59 -0800
In-Reply-To: <20260210060359.2233425-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYqHTfCoW1bGmJF4@google.com> <20260210060359.2233425-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260210060359.2233425-7-irogers@google.com>
Subject: [PATCH v9 6/6] perf stat: Add no-affinity flag
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, andres@anarazel.de, 
	dapeng1.mi@linux.intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	peterz@infradead.org, thomas.falcon@intel.com, tmricht@linux.ibm.com, 
	yang.lee@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Add flag that disables affinity behavior. Using sched_setaffinity to
place a perf thread on a CPU can avoid certain interprocessor
interrupts but may introduce a delay due to the scheduling,
particularly on loaded machines. Add a command line option to disable
the behavior. This behavior is less present in other tools like `perf
record`, as it uses a ring buffer and doesn't make repeated system
calls.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-stat.txt | 5 +++++
 tools/perf/builtin-stat.c              | 6 ++++++
 tools/perf/util/evlist.c               | 6 +-----
 tools/perf/util/evlist.h               | 1 +
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 1a766d4a2233..7cccc3a847d1 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -382,6 +382,11 @@ color the metric's computed value.
 Don't print output, warnings or messages. This is useful with perf stat
 record below to only write data to the perf.data file.
 
+--no-affinity::
+Don't change scheduler CPU affinities when iterating over
+CPUs. Disables an optimization aimed at minimizing interprocessor
+interrupts.
+
 STAT RECORD
 -----------
 Stores stat data into perf data file.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c1bb40b99176..73c2ba7e3076 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2426,6 +2426,7 @@ static int parse_tpebs_mode(const struct option *opt, const char *str,
 int cmd_stat(int argc, const char **argv)
 {
 	struct opt_aggr_mode opt_mode = {};
+	bool affinity = true, affinity_set = false;
 	struct option stat_options[] = {
 		OPT_BOOLEAN('T', "transaction", &transaction_run,
 			"hardware transaction statistics"),
@@ -2554,6 +2555,8 @@ int cmd_stat(int argc, const char **argv)
 			"don't print 'summary' for CSV summary output"),
 		OPT_BOOLEAN(0, "quiet", &quiet,
 			"don't print any output, messages or warnings (useful with record)"),
+		OPT_BOOLEAN_SET(0, "affinity", &affinity, &affinity_set,
+			"enable (default) or disable affinity optimizations to reduce IPIs"),
 		OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
 			"Only enable events on applying cpu with this type "
 			"for hybrid platform (e.g. core or atom)",
@@ -2611,6 +2614,9 @@ int cmd_stat(int argc, const char **argv)
 	} else
 		stat_config.csv_sep = DEFAULT_SEPARATOR;
 
+	if (affinity_set)
+		evsel_list->no_affinity = !affinity;
+
 	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
 		argc = __cmd_record(stat_options, &opt_mode, argc, argv);
 		if (argc < 0)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 45833244daf3..591bdf0b3e2a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -369,11 +369,7 @@ static bool evlist__use_affinity(struct evlist *evlist)
 	struct perf_cpu_map *used_cpus = NULL;
 	bool ret = false;
 
-	/*
-	 * With perf record core.user_requested_cpus is usually NULL.
-	 * Use the old method to handle this for now.
-	 */
-	if (!evlist->core.user_requested_cpus ||
+	if (evlist->no_affinity || !evlist->core.user_requested_cpus ||
 	    cpu_map__is_dummy(evlist->core.user_requested_cpus))
 		return false;
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 30dff7484d3c..d17c3b57a409 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -59,6 +59,7 @@ struct event_enable_timer;
 struct evlist {
 	struct perf_evlist core;
 	bool		 enabled;
+	bool		 no_affinity;
 	int		 id_pos;
 	int		 is_pos;
 	int		 nr_br_cntr;
-- 
2.53.0.rc2.204.g2597b5adb4-goog


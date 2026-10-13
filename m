Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41041344D91
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896463; cv=none; b=LW40XEMa2VX4f8yS0IIkTWyMdgroDbDXPdx4k2a4px/wUiB8DZnzAqxRM3IguUx8pmf4v1sux0CJ0lvzE+4uynSmwIic4a/Zn5992Fdh8q6aX7v1ikaLIxFJ5DGzZ54ipEf+7TukcrU5y2yCHKrNvlFbx764Fv1bdYIrygq6n+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896463; c=relaxed/simple;
	bh=AduMkvx1n0zCcP0NUjw003W54t5BWrn3PN0GPRnxgQo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TyoS7C61eNErMtXiM79OFBduPJJoer4SG8zJ/mwavicrzf5cZK6u03xCqP1rkkAjMlanzlr3f4f6SyTushGvVjLkVsrAu/ZmRjefkbq3vaz48ou1Sm8kWkS7ymRnDN79jZr+6iYsmYEJE4plS8KXM07nXCV3QJZqCHVYnU8fjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=OxhKAcNL; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="OxhKAcNL"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a9787a15bdso24707751fa.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 06:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1791896458; x=1792501258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xhpGL6YoccSJtK8h84NFPxYwPN/7uQF8oIdoEiXDADE=;
        b=OxhKAcNLqWtvtgPqMkjlBLYibLQizYfzmYyEN34lh4gqrDxEGBzrcGxAoa6SQMOK0x
         OLJb8aHjXAUemhi9lXE/T2tNqOIkGKHhTEOwXLKqrcIXF7djhSoOOQ1179YXaQOUD/wi
         ib1g7a3RQsfyCyTvcdLVxUd6zGI54oP/ko6tYlNBQUVVtMo3xjr+lEkzJlHZlsO7vIqF
         Z8YvvzsqYP90YTfLfuDSL7+VpslrOuPM4fzdYqaEOLvh1ePLSms+cnNLAmwrd3GbAbA4
         Nad0uZZrOFGLFarNU6aXmU2bHMwzBOpZRbnlarYV5zl6kwpXcxNMxHtxjd0hPU2xFDk8
         A0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791896458; x=1792501258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xhpGL6YoccSJtK8h84NFPxYwPN/7uQF8oIdoEiXDADE=;
        b=AVhxxfPnX6XRXplYQR2F1jVzGa5Qy8eP9YM/k9QjRnTuSudhoH9Naf4ELbaZdOyLew
         +T0p52ci0Vx953FhktsU4P/Yiicu0HsCNS9u3+eyFKaS+Hb0mDE5TYOzqOKwfPIDkLXZ
         hcGq1IAlTXmftNC+80orn36SzIdfyn5Rxglq6WqtAYOlLdQW48KGxpZSSsBMMrdksTmp
         8O+zqBvp+NXhZE7ZwujBy02Q//or+R1lMqY+NUat948TRYj/+3+NEEoh3pNiU6iHJsKK
         Dsb6Gy0K39JKdpR4a1NLJi7OsmLulkzoW1mII7vie+Yl1ipTCXRAZKvrMjq/o3ZAkvS+
         ljfw==
X-Forwarded-Encrypted: i=1; AKwUvBzMg0kNsTO5zLvTaO8j29jXIhFplQg+vQDWrFH9kukRfN4DyX0RwZ+wyuQAUmL2QevaM+6HbGGl6xdxFvd5cdTJ@vger.kernel.org
X-Gm-Message-State: AFq9FYL7xgIb8g3xODBSpBj96geWqSo5n6SiwkmPkqkLEWaOSEaykVdw
	7uagVDlewBBnetbAovD/sa3k1XUPvXIGmwjSKAMwFBt8R1FI9BazMSMFFu7n8VrNhIw=
X-Gm-Gg: AYBFou0gW8QZLHs0RCNnFK/Ce6eI7vXXndPNJHkBoQvyyRqE5gOBpizNWCvMILqZiMu
	NSfo1X7H6Xwkdp51l59g48K/eDflt0h7BP2PyCq3VVwW6ctr1NZDMcX+fFqHT+rv99TjZPuqPsi
	/nBIdILNQ35Fs2wLE3+ixRmv2HZTK8+E5H0QYfvkpulS3rNWKZCVpx7FPf0xO+onsELlsr6CsU6
	Rtg0DCSPsys+T9VUhqNhO/TUNMp70k/EbYN0FtlChGRqWPadQ6mB9+aPXtKxmHrsC3aWfFJmyhi
	x8JAiTgsF/3dS6m2haGQjCX2j0MB+xFMLGd7ca5QacUAXDZluym0r4fN9fTv+RvCgbEgOZ9ADdV
	KCfAxdpUV1s0wcl/cJuOKrFoZ6ACA5dlXQQ5xi3+jG8rs16szMUAmR0dIsc7cK6pmUPutD8Rhpo
	qEty0KGvDWzbVB58Gsc8qeBEZTVqv0gDXYngN+AKpMhdHtzPV7rBPpxLjkdmVyP8CJItV7w3l0N
	l0J/6LZY6McJzqPipSXjGbZX/ZWPNmLOacacAxDfYe3yFqIFgdbcXLtUIVZD1Kpum5vU2DKPw==
X-Received: by 2002:a05:6512:1193:b0:5b8:c147:f363 with SMTP id 2adb3069b0e04-5bcde8d4381mr4067679e87.64.1791896456820;
        Tue, 13 Oct 2026 06:00:56 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc50e0sm6549692f8f.49.2026.10.13.06.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:00:56 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: skip unnecessary userspace map synthesis
Date: Tue, 13 Oct 2026 15:00:43 +0200
Message-ID: <20261013130052.3012773-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading `/proc/PID/task/PID/maps` for existing processes is expensive
on systems with many processes.  `perf record` already allows skipping
these reads with the `--synth=` option, but `perf top` has no
equivalent option.

Skip userspace map synthesis by default in `record` and `top` when all
events exclude userspace and no sample feature needs user mappings.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 tools/perf/Documentation/perf-record.txt |  4 +++
 tools/perf/builtin-record.c              |  8 +++++
 tools/perf/builtin-top.c                 | 19 +++++------
 tools/perf/util/evlist.c                 | 40 ++++++++++++++++++++++++
 tools/perf/util/evlist.h                 |  1 +
 tools/perf/util/record.h                 |  1 +
 6 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 178f483140ed..cdef14f22df3 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -696,6 +696,10 @@ Available types are:
   - 'all'     - synthesize all events (default)
   - 'no'      - do not synthesize any of the above events
 
+By default, userspace MMAP synthesis is skipped if all events exclude
+userspace (for example, with --all-kernel or -e cycles:k) and their
+samples do not need userspace maps.
+
 --tail-synthesize::
 Instead of collecting non-sample events (for example, fork, comm, mmap) at
 the beginning of record, collect them during finalizing an output file.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a57987851cf0..f8b4e5279fca 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2574,6 +2574,13 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	evlist__config(rec->evlist, opts, &callchain_param);
 
+	if (!opts->synth_set && !opts->full_auxtrace &&
+	    !opts->auxtrace_sample_mode && !rec->off_cpu && !rec->buildid_all &&
+	    !evlist__needs_user_mmaps(rec->evlist)) {
+		opts->synth &= ~PERF_SYNTH_MMAP;
+		pr_debug("Skipping synthesis of userspace maps for kernel-only recording\n");
+	}
+
 	/* Debug message used by test scripts */
 	pr_debug3("perf record opening and mmapping events\n");
 	if (record__open(rec) != 0) {
@@ -3412,6 +3419,7 @@ static int parse_record_synth_option(const struct option *opt,
 		pr_err("Invalid synth option: %s\n", str);
 		return -1;
 	}
+	opts->synth_set = true;
 	return 0;
 }
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 570410599f1b..d85ecc140eda 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1017,14 +1017,6 @@ static int perf_top__start_counters(struct perf_top *top)
 	struct evlist *evlist = top->evlist;
 	struct record_opts *opts = &top->record_opts;
 
-	if (perf_top__overwrite_check(top)) {
-		ui__error("perf top only support consistent per-event "
-			  "overwrite setting for all events\n");
-		goto out_err;
-	}
-
-	evlist__config(evlist, opts, &callchain_param);
-
 	evlist__for_each_entry(evlist, counter) {
 try_again:
 		if (evsel__open(counter, counter->core.cpus,
@@ -1265,6 +1257,14 @@ static int __cmd_top(struct perf_top *top)
 	if (ret)
 		return ret;
 
+	if (perf_top__overwrite_check(top)) {
+		ui__error("perf top only support consistent per-event "
+			  "overwrite setting for all events\n");
+		return -1;
+	}
+
+	evlist__config(top->evlist, opts, &callchain_param);
+
 	if (perf_session__register_idle_thread(top->session) < 0)
 		return ret;
 
@@ -1296,7 +1296,8 @@ static int __cmd_top(struct perf_top *top)
 		pr_debug("Couldn't synthesize cgroup events.\n");
 
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
-				    evlist__core(top->evlist)->threads, true, false,
+				    evlist__core(top->evlist)->threads,
+				    evlist__needs_user_mmaps(top->evlist), false,
 				    top->nr_threads_synthesize);
 
 	perf_set_multithreaded();
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c3d784727810..6636edee0d2b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1990,6 +1990,46 @@ bool evlist__exclude_kernel(struct evlist *evlist)
 	return true;
 }
 
+bool evlist__needs_user_mmaps(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	bool has_kernel_event = false;
+
+	evlist__for_each_entry(evlist, evsel) {
+		struct perf_event_attr *attr = &evsel->core.attr;
+
+		/* Tracking events do not produce samples, regardless of modifiers. */
+		if (evsel__is_dummy_event(evsel))
+			continue;
+
+		if (!attr->exclude_user)
+			return true;
+
+		/* Kernel samples can still contain a userspace callchain. */
+		if ((attr->sample_type & PERF_SAMPLE_CALLCHAIN) &&
+		    !attr->exclude_callchain_user)
+			return true;
+
+		/*
+		 * These may reference userspace even when the sampled
+		 * IP is in the kernel.  Keep maps for opaque trace
+		 * payloads and AUX trace decoding too, whose address
+		 * requirements are PMU specific.
+		 */
+		if (attr->sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_RAW |
+					 PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER |
+					 PERF_SAMPLE_BRANCH_STACK | PERF_SAMPLE_AUX))
+			return true;
+
+		if (evsel__is_aux_event(evsel))
+			return true;
+
+		has_kernel_event = true;
+	}
+
+	return !has_kernel_event;
+}
+
 /*
  * Events in data file are not collect in groups, but we still want
  * the group display. Set the artificial group and set the leader's
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 838e263b76f3..b208bf7211e8 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -631,6 +631,7 @@ struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
 struct evsel *evlist__event2evsel(struct evlist *evlist, union perf_event *event);
 
 bool evlist__exclude_kernel(struct evlist *evlist);
+bool evlist__needs_user_mmaps(struct evlist *evlist);
 
 void evlist__force_leader(struct evlist *evlist);
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 93627c9a7338..1317ddce3cf0 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -80,6 +80,7 @@ struct record_opts {
 	int	      ctl_fd_ack;
 	bool	      ctl_fd_close;
 	int	      synth;
+	bool	      synth_set;
 	int	      threads_spec;
 	const char    *threads_user_spec;
 	u64	      off_cpu_thresh_ns;
-- 
2.47.3


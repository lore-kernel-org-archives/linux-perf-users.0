Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815143;
	b=sTCYd9xOiGJrwvIqwVMAMz+tA0vQfZfsK0hrkscwFy+BhDXErfCrcIfmIQDXxdvF6Uhk
	 XyGCvHMQNEZGVEmzlw7n0xR2zLNI3Mv7RFqDbalrD4EooJzEjsI8gaXCR48325JI1woW7
	 AkI+Pi3kGg0HVo8nN2Nav3JVBbdCAoY4azsiGvs2tHetIMT8bxeLgLTOWgBo6n0Q8fa4b
	 VRtKZpLv2XoIKZrAX9j2XQmghu2R5je3WXSi0NRFUSpESO4dhNnTIQCx/IfNNrXJMCCbd
	 LJQTmcMdmiJvmdUwKE0FMqV7bp8xCrPu52xp+YGzF0edyxgc0Y4WU6cS0Nt0hiRyRcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=jYZlXNPHbMt7W+f1wEXM0eyVVqcKSktO2/3fWNs8deY=;
	b=Hwxw9WZ9xHM9Hr86SS/VJnWn9jiajBNK55sxjoH3d/WU5hbLFYlohsKkZkcOuyvjF/UE
	 jU9SmxiWiL9PI7R1BsvUSjkC02U5/iujSfuE45Li5JCvKjHFZdvh2++5rnnP7K0z9Jy1E
	 sTHFkIyoXLcgOzwNXAUmc+L4uMmMjmt/1Ve4Nmxuav2K77xoV9BSA7IlQHHoZDSUGXw4H
	 iOt9Vtj35XI+UUMa+f5j4s4rlurgQ3VVqmQ7sIHAwbubM37eiwFP6jqvPhTbDxBk/ZKQU
	 btD3eYYDaKlvu0PJHECdDd+Zmb2mk6i2+6lIgGADSbFUyOeSR0E0QXlwnunpBzDCGnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZSlZ2hBy;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1588606A88B
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1588606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZSlZ2hBy
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36ecd5db581so3148192eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815142; x=1795419942; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jYZlXNPHbMt7W+f1wEXM0eyVVqcKSktO2/3fWNs8deY=;
        b=ZSlZ2hByHmAGDqFS7sjhHSkk6pXjyW010VlR8G7CO8zwTntrJDgQ4j9nBTdFGEEVfl
         TRIlKUeWBk/uCNk2+g8hvaZjuqP29DE9AwRDbeY/qUuf7F2uUZ968xUTcVjUD8jkWI08
         1prkzW9Mb+ALBIOiAYDkLrD2RpVJlDv9r9NLhbo3Qg8wbZng5nKvUgQtHvied3+ULisU
         GF/xkoyNLM4bLBbIsIHaBqDEiMemTGmUV1+sWsCUs0YylTr17+sUzlLPhhmNuetm7J47
         M2rVWUlKVKlbI83MkHwS/KNgBsDmYZE2ruJ3ZMdgObFG91tbk19yxysR4Ega6Rv1iV/H
         uz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815142; x=1795419942;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jYZlXNPHbMt7W+f1wEXM0eyVVqcKSktO2/3fWNs8deY=;
        b=gGEwN14QmURJy3stNre4Cdkbp9MPBs1htJufm0R6ygZn/FVze5pmxweeerRF+wsCBI
         kBsNgDJts6P11HzZsSTh6xOtNI7XW+6La1q03+gNq6/p0KH/ATE/Zt60J01hctH/u4Gr
         5HRYkrxo6BGDo5tsodlQWDjI8ZmCQXt4wbPpeu1w2CMRzjxdovOPygUZFVn7744tfAx0
         cqYrFK1/GZNFEhSj1g3WEznSmBcn4TjwXTkQzsnS2CIWa7JUZNUC4TPD6JkVoS2dfWxS
         v7shOe561XHLwefCyZRqwhH4PcC5TyUoJnBoiI6gPnO7t5NkI003edQR8S0CLpVVdJ3S
         ym0w==
X-Forwarded-Encrypted: i=1; AL+hErHACuTWpwv5Hzy90MR5piFTiGeQ/2xc/vyv51sD3rlkDlmycETol/gfvhSl91wx4YWgTKe9PXza5+o/eOdwJN3+@vger.kernel.org
X-Gm-Message-State: APuU4Z/k433GISNCUFrspNayLqM87f9nF8iTZJ+BbbFdWfxeBzAlakUB
	vvIEBxIH0UnazJJ3m3Kx3cpRjY5ZbHqyi34nNTVtQiWVhPUN0qaVfrrUBUhkxCRqeXqGAvEM55/
	aoL+nw8kbuw==
X-Received: from dlbvv6.prod.google.com ([2002:a05:7022:5f06:b0:196:a46:fc4b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4510:20b0:19a:bbe8:41a8
 with SMTP id a92af1059eb24-1b50312f09cmr10221198c88.20.1794815141723; Sun, 15
 Nov 2026 23:45:41 -0800 (PST)
Date: Sun, 15 Nov 2026 23:44:12 -0800
In-Reply-To: <20261116074414.3174737-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116074414.3174737-18-irogers@google.com>
Subject: [PATCH v3 17/19] perf record: Add --buildid-offset option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the --buildid-offset flag to perf record to natively request
PERF_SAMPLE_BUILD_ID_OFFSET and PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
from the kernel. This configures the evsel attributes by replacing
the standard IP and CALLCHAIN bits with the build ID offset equivalents.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt |  6 ++++++
 tools/perf/builtin-record.c              | 22 ++++++++++++++++++++--
 tools/perf/util/evsel.c                  | 17 ++++++++++++++++-
 tools/perf/util/record.c                 | 22 ++++++++++++++++++++++
 tools/perf/util/record.h                 |  1 +
 5 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 2351f7b4f5fc..d821303c923c 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -578,6 +578,12 @@ Specify vmlinux path which has debuginfo.
 --buildid-all::
 Record build-id of all DSOs regardless whether it's actually hit or not.
 
+--buildid-offset::
+Record build-id and DSO file offset instead of virtual instruction pointer
+addresses in samples and callchains (using PERF_SAMPLE_BUILD_ID_OFFSET and
+PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET). Implies --buildid-mmap and cannot be
+used with --no-buildid-mmap.
+
 --buildid-mmap::
 Legacy record build-id in map events option which is now the
 default. Behaves indentically to --no-buildid. Disable with
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 085d3648a30a..5796f13ffe8c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -936,7 +936,8 @@ static int record__config_tracking_events(struct record *rec)
 	 * delay of waiting or event synthesis.
 	 */
 	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
-	    perf_pmus__num_core_pmus() > 1) {
+	    perf_pmus__num_core_pmus() > 1 ||
+	    (opts->buildid_offset && evlist__nr_entries(evlist) > 1)) {
 		/*
 		 * User space tasks can migrate between CPUs, so when tracing
 		 * selected CPUs, sideband for all CPUs is still needed.
@@ -3625,6 +3626,8 @@ static struct option __record_options[] = {
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN(0, "buildid-all", &record.buildid_all,
 		    "Record build-id of all DSOs regardless of hits"),
+	OPT_BOOLEAN(0, "buildid-offset", &record.opts.buildid_offset,
+		    "Record build id offset instead of IP"),
 	OPT_BOOLEAN_SET(0, "buildid-mmap", &record.buildid_mmap, &record.buildid_mmap_set,
 			"Record build-id in mmap events and skip build-id processing."),
 	OPT_BOOLEAN(0, "timestamp-filename", &record.timestamp_filename,
@@ -4162,6 +4165,20 @@ int cmd_record(int argc, const char **argv)
 		record.opts.record_switch_events = true;
 	}
 
+	if (rec->opts.buildid_offset) {
+		if (rec->buildid_mmap_set && !rec->buildid_mmap) {
+			pr_err("--buildid-offset cannot be used with --no-buildid-mmap.\n");
+			err = -EINVAL;
+			goto out_opts;
+		}
+		if (!perf_can_record_build_id()) {
+			pr_err("Missing support for build id in kernel mmap events required by --buildid-offset.\n");
+			err = -EINVAL;
+			goto out_opts;
+		}
+		rec->buildid_mmap = true;
+	}
+
 	if (rec->buildid_mmap && !perf_can_record_build_id()) {
 		pr_warning("Missing support for build id in kernel mmap events.\n"
 			   "Disable this warning with --no-buildid-mmap\n");
@@ -4352,7 +4369,8 @@ int cmd_record(int argc, const char **argv)
 
 	evlist__warn_user_requested_cpus(rec->evlist, rec->opts.target.cpu_list);
 
-	if (callchain_param.enabled && callchain_param.record_mode == CALLCHAIN_FP) {
+	if (callchain_param.enabled && callchain_param.record_mode == CALLCHAIN_FP &&
+	    !rec->opts.buildid_offset) {
 		if (EM_HOST == EM_AARCH64)
 			add_leaf_frame_caller_opts_aarch64(&rec->opts);
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 49f6bbf08160..32c258764db9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1745,7 +1745,7 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
 	attr->mmap2    = track && !perf_missing_features.mmap2;
 	attr->comm     = track;
 	attr->build_id = track && opts->build_id;
-	attr->defer_output = track && callchain && callchain->defer;
+	attr->defer_output = track && ((callchain && callchain->defer) || opts->buildid_offset);
 
 	/*
 	 * ksymbol is tracked separately with text poke because it needs to be
@@ -1831,6 +1831,21 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
 	 */
 	evsel__apply_config_terms(evsel, opts, track);
 
+	if (opts->buildid_offset && !evsel__is_offcpu_event(evsel)) {
+		if ((evsel->core.attr.sample_type & PERF_SAMPLE_IP) || track) {
+			evsel__reset_sample_bit(evsel, IP);
+			evsel__set_sample_bit(evsel, BUILD_ID_OFFSET);
+			if (!evsel->no_aux_samples && !attr->exclude_user)
+				attr->defer_callchain = 1;
+		}
+		if ((evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+		    !attr->exclude_callchain_user) {
+			evsel__reset_sample_bit(evsel, CALLCHAIN);
+			evsel__set_sample_bit(evsel, CALLCHAIN_BUILD_ID_OFFSET);
+			attr->defer_callchain = 1;
+		}
+	}
+
 	evsel->ignore_missing_thread = opts->ignore_missing_thread;
 
 	/* The --period option takes the precedence. */
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 38e8aee3106b..77337e1318ab 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -110,6 +110,28 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
 			evsel->core.attr.comm_exec = 1;
 	}
 
+	if (opts->buildid_offset) {
+		bool has_callchain_bid = false;
+
+		evlist__for_each_entry(evlist, evsel) {
+			if ((evsel->core.attr.sample_type &
+			     PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) &&
+			    !evsel->core.attr.exclude_callchain_user) {
+				has_callchain_bid = true;
+				break;
+			}
+		}
+		if (has_callchain_bid) {
+			evlist__for_each_entry(evlist, evsel) {
+				if (evsel->core.attr.defer_output &&
+				    evsel__is_dummy_event(evsel)) {
+					evsel__set_sample_bit(evsel, CALLCHAIN_BUILD_ID_OFFSET);
+					evsel->core.attr.exclude_callchain_kernel = 1;
+				}
+			}
+		}
+	}
+
 	/* Configure leader sampling here now that the sample type is known */
 	evlist__for_each_entry(evlist, evsel)
 		evsel__config_leader_sampling(evsel, evlist);
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 411bb7276ad7..6c9568616177 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -55,6 +55,7 @@ struct record_opts {
 	bool	      kcore;
 	bool	      text_poke;
 	bool	      build_id;
+	bool	      buildid_offset;
 	unsigned int  freq;
 	unsigned int  mmap_pages;
 	unsigned int  auxtrace_mmap_pages;
-- 
2.56.1.703.gf848ed807c-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567917;
	b=yVxTuou/QLh9Mj2ny7P0qJYF3ww+sdmO7U3GMVbfdfiaCsVHRVcwn+50VrmZ5skS5bNJ
	 uvnCCSqkNZpaa+/iDIiEWjnfPmr4z4alYmDxLojpW78Sl67RrxrQxNlbgNYxvIUzz8RXk
	 PMSioMpGp5O3omSdKHH5UfKClarwhpSO6ZDLQN0d/bd0nGZ3O7ng8QaEdKWVjjJf3pZSP
	 4WvzbKk7AupyhXZt7fX6FpywdnA4NQJlWYFIvupXNOU2+znnlDgyL+tYFXCwkwXsdvqnt
	 pKTMFeHqx0AUxyUiFEFfvDu7x56NBGA0Ov3piaEeLS4h8VJNePQqwk0axM2mbMEiRYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=gKi/h6FXem9B7oE2V26QtBZc7ZsOCscf8la+gKh9y0U=;
	b=rkgNrNN8kE4QGjb+x3LDkgRqCkCuAbXTfN/rNdrTXCWz7bb/BDXntLOMbCYF27bKUfG+
	 lGSZjiybaWjDsd8QdZOsXjpDUjINWqBIEsrg5k5dEheYJaamqOWZe+ILizhib6Ux/ZN9i
	 Z8ZzwQxNm+3RJBar40c8mUmQqGqS/mwi7Re6aC5CPaspEp1d+IW7Tym0eFOtfqFl4BYv3
	 jts7nYf98L3rlB152JZuVWj2zVZYADmgyfwFxL06zJ8JZmANejRujhfh7ghYjgtwE6RNv
	 t8L+vVI6Wnh+vGAV3ekuXNz0CQOKONThMYU+G+moKae+31tZMc8QUAgxl9IaUhi1I6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fx3zsleA;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF460A3839
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 00:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27DF460A3839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fx3zsleA
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33713e5e6daso8845173eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 16:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567916; x=1796172716; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKi/h6FXem9B7oE2V26QtBZc7ZsOCscf8la+gKh9y0U=;
        b=fx3zsleAnWfPaEDLhfNsNhBBC6N6iaB5fY16p53HLaZODE8uwWu0Un9A+VqxOMfCdR
         NR40HE2LVpQHxfl5KMRyhjNEQU92cBKUWwuPr+KuEqAYezoqQbku2w6e7/GLlfOSvI8X
         tyjFh+EnbzB/EM/hDcCYsNPbZsxa1T+d/SN74SMaY1pMcCeejlijE7uD83vndUbwPsj5
         CzkvxO+xTL3d1ZYveEjQNzM0sQk4OQrBdx4GeTlNBnH840SigoStGIvHi+5CsPdVK8zW
         gLPmW2a9ajySSx7rZCXlMpwb8hPx3UoNzRsi+cryKn5V/uKw/I1w1jXEOxGFIjDEUYBc
         sFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567916; x=1796172716;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKi/h6FXem9B7oE2V26QtBZc7ZsOCscf8la+gKh9y0U=;
        b=hF32C57n5MnOIqbZSv1DahNiAudvTHM/OCgiXDhMlQOuXPIpG5mlMufA7+7Ru+U9Kk
         91WYwwQxAYLW/VPpK3o1YsUHgkqDajGJXlf98y/gzWygUEbEVKs3yv5RVZD8Jv+XLCt/
         DDkiIQiJLC3mC4gDi9KrBgKKSUtVglpRkVF5fGyMybhMc2MEXv8jldIfBzu5eLlcTEIO
         +nS/aDNOrWH8enFOqqCz+B/euw5cUUDT6rFgkNZofWJASrlYLTk0zdCQ19c3y4PF5+/9
         dFUASA26vhjzW0nlWWnkRtkMO4pyGEkmwl8RNVNQNM5r69slWmqvfmTEBSh7nq8lb69j
         pueg==
X-Forwarded-Encrypted: i=1; AL+hErGvAr45t+9A6x7YOV2cUxlSQH5VPOERwI2HKE7AMmjQ9sTf9iKUb3VVHHsJIVI995Bd3bhcOogc0GzmcbQdHW3+@vger.kernel.org
X-Gm-Message-State: APuU4Z9HYXBiXsOM9ORCi80hQ6tC+gAaY2G7x9WRuSnuuxggknvtLvwQ
	4zwo768mr2sQ0agPqNQxHWe1SPY/0bmTyurR1OH6BDTjRnQ+EtSjVFvLyczu8cE0pnjFxQT8U3W
	17+CznCleBg==
X-Received: from dycmv2.prod.google.com ([2002:a05:693c:2802:b0:386:b5d2:c426])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8803:20b0:386:9b9c:ef1b
 with SMTP id 5a478bee46e88-3869b9cf99amr11788653eec.3.1795567916077; Tue, 24
 Nov 2026 16:51:56 -0800 (PST)
Date: Tue, 24 Nov 2026 16:51:06 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-18-irogers@google.com>
Subject: [PATCH v4 17/19] perf record: Add --buildid-offset option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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
index 9fa77e76aecb..d22dd91a1585 100644
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
2.56.1.831.g720f3f5937-goog


Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C812145FE8
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Aug 2024 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877120; cv=none; b=iysl+IYl1U04r3r+ZNa73enbdPuDozd+6s1Ic1JxuW+MYeV5wnnMi999w92XZvygP6F3EI1eYTNibc+V7JijsaPXicLPPBCvlU37kUx9ptETMv1Hsy1c9XYu5cPwB3+v2NJa64H2RvrGKqKOQ9Fg/KBmDK0v1OxMR+PPSsVuiTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877120; c=relaxed/simple;
	bh=pRY5AZfCbwpYgGVAWMLYaicbhD2xuRtNblur1R1C4z8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hJzwuz6CS59TsY+TMnweb1jA9Dbyr9QfqBxcP3lxXPyvfYReB35e5sYVR/eaKH6eJ9uTTVe7dGka1q8H6nDtP9lbdEgObUAIUNZTu0F2m7DOhwL6Bh/0nczTbX8tKd09EzQUdyF0hGgG37lZLfICNkV8c5e9AcgNkms2p2ByKdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FCi8ExA4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FCi8ExA4"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6af8f7a30dbso45327797b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 23:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877117; x=1724481917; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAJzyWm13hc0XphEnwse3Fp8/0A+sQVmN1fNLb1gecE=;
        b=FCi8ExA4ISx306zIPeeadGugF1ffeTgK9NRLZR45pqPkb3ew/4cMCajkVfwlvGtrLi
         8LAOn+3rMhGElMx5KinBcs/qYIy69XPbLZNnpdjhv//wLxQoa+xuag1xalQby9Y0i2cn
         5Ws1oHZF/Ip0TV7Zhsk6SR1wrrMl2ZiKLMzBPtigsHI0/KdAQMJfbYmm/pwSoEY4xAh3
         z2CbckixxoHReN80WBC0oz0+MOiIPmHN9CUsRyMcqkLsGZ1gRuFi7XbATSfGMnPZuEgy
         Bf8A102E0NpL1Du37P5AkU+aPsI7KvbMgqrewR4gNP5E/gWzHnwgqqas4TPSwfatjkkN
         i/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877117; x=1724481917;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAJzyWm13hc0XphEnwse3Fp8/0A+sQVmN1fNLb1gecE=;
        b=B/MuYU7gztEirAYJ+BBDLtc4uf4Xty+1Kw7dRX1igRtIUn3F11KpJnPBYVsDTnNrWc
         5zBbUcdifmz03Awsy4MlIta4hFajnD+Ko+k/iNpUHJZokJ8oM+9uoXIbijTykzhqwoEe
         NEYo9WnLgSRZfn/HpMG17hxLn6rF82VaCFY1JyXf77rnPdda6XINB6x+mdOKuP/Z7Qv/
         Mue1Q6fB4/rcs0UvA4BLjzZJ5XuAhwY4f+juoifeNxYAHbeIgv7gh/GMSgf1nEMwDYnr
         XpD3ONEWZl5biSRZhMyu4rZhL5EMrnKQpWvFmvUmLn0//+I01MMVDGJyvBmnhPGOBvBV
         UIBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTgzsxJVIe1Edac4Z//4aBGDgWRojf1FvVuWWHMMSuRgV/27pnSoGza3Wg+NLZ94hxkrI1+i2ukbe8r7Ox/1km85H/wbv39Ehzn78q5PjyqQ==
X-Gm-Message-State: AOJu0Yx1REXGdOkz9ODcfWa6ClR86ds7AXZXa1j4KDS1MSmMps/2dGKp
	zg3KsUQypiieuBj7XaYgEh+OEQcJELV7ZoOWxPM/l01xbAUrTLEKRUrTWXQWPqyLorHrZ1G0w5N
	Od2pmAA==
X-Google-Smtp-Source: AGHT+IH7Yu232gNnniV3EHstk3fBHEEIjNkNXlA2pzSz4OdB3zq/IUPHPuAWRECkAxMJmLLflc2sJAA69/1d
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a05:690c:4606:b0:691:2f66:4b1c with SMTP
 id 00721157ae682-6b1baeadc0amr594057b3.6.1723877117487; Fri, 16 Aug 2024
 23:45:17 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:36 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 07/13] perf inject: Combine build_ids and build_id_all into enum
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It is clearer to have a single enum that determines how build ids are
injected, it also allows for future extension.

Set the header build ID feature whether lazy or all are generated,
previously only the lazy case would set it.

Allow parsing of known build IDs for either the lazy or all cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 51 ++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 8440ddfbf4fe..865d16ceead2 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -103,11 +103,16 @@ struct guest_session {
 	struct guest_event		ev;
 };
 
+enum build_id_rewrite_style {
+	BID_RWS__NONE = 0,
+	BID_RWS__INJECT_HEADER_LAZY,
+	BID_RWS__INJECT_HEADER_ALL,
+};
+
 struct perf_inject {
 	struct perf_tool	tool;
 	struct perf_session	*session;
-	bool			build_ids;
-	bool			build_id_all;
+	enum build_id_rewrite_style build_id_style;
 	bool			sched_stat;
 	bool			have_auxtrace;
 	bool			strip;
@@ -2015,8 +2020,8 @@ static int __cmd_inject(struct perf_inject *inject)
 
 	signal(SIGINT, sig_handler);
 
-	if (inject->build_ids || inject->sched_stat ||
-	    inject->itrace_synth_opts.set || inject->build_id_all) {
+	if (inject->build_id_style != BID_RWS__NONE || inject->sched_stat ||
+	    inject->itrace_synth_opts.set) {
 		inject->tool.mmap	  = perf_event__repipe_mmap;
 		inject->tool.mmap2	  = perf_event__repipe_mmap2;
 		inject->tool.fork	  = perf_event__repipe_fork;
@@ -2027,10 +2032,10 @@ static int __cmd_inject(struct perf_inject *inject)
 
 	output_data_offset = perf_session__data_offset(session->evlist);
 
-	if (inject->build_id_all) {
+	if (inject->build_id_style == BID_RWS__INJECT_HEADER_ALL) {
 		inject->tool.mmap	  = perf_event__repipe_buildid_mmap;
 		inject->tool.mmap2	  = perf_event__repipe_buildid_mmap2;
-	} else if (inject->build_ids) {
+	} else if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY) {
 		inject->tool.sample = perf_event__inject_buildid;
 	} else if (inject->sched_stat) {
 		struct evsel *evsel;
@@ -2148,9 +2153,9 @@ static int __cmd_inject(struct perf_inject *inject)
 			.inject = inject,
 		};
 
-		if (inject->build_ids)
-			perf_header__set_feat(&session->header,
-					      HEADER_BUILD_ID);
+		if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
+		    inject->build_id_style == BID_RWS__INJECT_HEADER_ALL)
+			perf_header__set_feat(&session->header, HEADER_BUILD_ID);
 		/*
 		 * Keep all buildids when there is unprocessed AUX data because
 		 * it is not known which ones the AUX trace hits.
@@ -2211,11 +2216,13 @@ int cmd_inject(int argc, const char **argv)
 	int ret;
 	bool repipe = true;
 	const char *known_build_ids = NULL;
+	bool build_ids;
+	bool build_id_all;
 
 	struct option options[] = {
-		OPT_BOOLEAN('b', "build-ids", &inject.build_ids,
+		OPT_BOOLEAN('b', "build-ids", &build_ids,
 			    "Inject build-ids into the output stream"),
-		OPT_BOOLEAN(0, "buildid-all", &inject.build_id_all,
+		OPT_BOOLEAN(0, "buildid-all", &build_id_all,
 			    "Inject build-ids of all DSOs into the output stream"),
 		OPT_STRING(0, "known-build-ids", &known_build_ids,
 			   "buildid path [,buildid path...]",
@@ -2313,6 +2320,10 @@ int cmd_inject(int argc, const char **argv)
 			return -1;
 		}
 	}
+	if (build_ids)
+		inject.build_id_style = BID_RWS__INJECT_HEADER_LAZY;
+	if (build_id_all)
+		inject.build_id_style = BID_RWS__INJECT_HEADER_ALL;
 
 	data.path = inject.input_name;
 	if (!strcmp(inject.input_name, "-") || inject.output.is_pipe) {
@@ -2326,7 +2337,7 @@ int cmd_inject(int argc, const char **argv)
 			repipe = false;
 	}
 	ordered_events = inject.jit_mode || inject.sched_stat ||
-		(inject.build_ids && !inject.build_id_all);
+		(inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY);
 	perf_tool__init(&inject.tool, ordered_events);
 	inject.tool.sample		= perf_event__repipe_sample;
 	inject.tool.read		= perf_event__repipe_sample;
@@ -2398,7 +2409,7 @@ int cmd_inject(int argc, const char **argv)
 			goto out_delete;
 	}
 
-	if (inject.build_ids && !inject.build_id_all) {
+	if (inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY) {
 		/*
 		 * to make sure the mmap records are ordered correctly
 		 * and so that the correct especially due to jitted code
@@ -2406,14 +2417,14 @@ int cmd_inject(int argc, const char **argv)
 		 * inject the jit mmaps at the same time for now.
 		 */
 		inject.tool.ordering_requires_timestamps = true;
-		if (known_build_ids != NULL) {
-			inject.known_build_ids =
-				perf_inject__parse_known_build_ids(known_build_ids);
+	}
+	if (inject.build_id_style != BID_RWS__NONE && known_build_ids != NULL) {
+		inject.known_build_ids =
+			perf_inject__parse_known_build_ids(known_build_ids);
 
-			if (inject.known_build_ids == NULL) {
-				pr_err("Couldn't parse known build ids.\n");
-				goto out_delete;
-			}
+		if (inject.known_build_ids == NULL) {
+			pr_err("Couldn't parse known build ids.\n");
+			goto out_delete;
 		}
 	}
 
-- 
2.46.0.184.g6999bdac58-goog


Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B614659C
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Aug 2024 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877122; cv=none; b=KbhmMVwvNAMB7bKAlwq8aQCTH8oGHt+vual5GcAEHUZcc4Roegt7/kA5u6e+IPC8Jv4Acp3UBJqIa3Gve6hDIYgUE1434Rh2TEXOUF/bFrM4qHWD/drAQACRd+CSE2Li5wXGF1rM8wLmhQlwVozsPplYM//139u8FAxWTpSIR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877122; c=relaxed/simple;
	bh=WW1VpISX2ocellr2odfdikhDznsZtCHPvqIBB2Ouivw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ua+YBFSSEsawe6HJGr07x6xUMAUr+TUrV6ILw227Fh03C3g7lxTy/kmI7ufGLfA3mg37wCjBFTq++IVHknuiiau4CQ3rCo62GLWSbQKcf+v2DwJiEAWjX8WDHedh8Ep9UAKMfoAIecQNsVDww8ULs+97Y21podOhd2NBS3np9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQWMugF3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQWMugF3"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e11cdb464f2so2538748276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877120; x=1724481920; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgTxrjJSN3UEpj2V6TaLEsH3nbDGy1R5SWod1sFWZ8c=;
        b=FQWMugF39G5RanQ9cS21+F0MOil3LvrnnI6Mhjqo1xUlCz3mUN7PqDJiz6gAhAznaz
         7JTWSqmrWTYBvED/TxY0vt5I8qgQ+QoKwg4fp+RcEqLidWg/DgvOEybLofOh7RVywacn
         kl/3tY+xb/bhJ+DJuitA0V4lVADn31e4eGlYbC/3ccYEYEb4vx7xi5Zpdc888udcYjVv
         wUBt6C0bQjjVi8umAzCgNDcq05PnF/j5+0DX8LizkbTkk4JdB52I7hJ+lvK5yxp2Dp8v
         zwf98/XKhHdwzcekKYY26LW0vKcQuOVhQtRdZwW84GEAY9wPfYuOKYxQkCRTDP2l8D42
         zZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877120; x=1724481920;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgTxrjJSN3UEpj2V6TaLEsH3nbDGy1R5SWod1sFWZ8c=;
        b=coU1ikQ0j4l/HXAL4jJ8mSRC5zsW27jcgBXZKAn6UkXqk+sZWNGUmJjjhFZsMH7VaT
         gN+DY3GV+Hf+Q96jzOQgcN1EL872PFB+bl6//0nSgMh02jITQlFh+5aOP1SPqYEDlbCg
         LZFj//YUlWNy15R2sRzceXndXr1rGCQIJqnl/aXPYvjn2hBCeo0d1cKi1jSq5VJ/mF2f
         GzQIWezcKGU2H3WanM65283EWOQsj3eVP7CyuuzmukXzXORhhTq3oPOjU07zyvz+Ja7R
         msrYjsL9c9J0S9+0ywbdjDfs38CDS7H87YGF5F+TurjhwfHx8Cb5N+bc8lq2VaWpAtM4
         7KqA==
X-Forwarded-Encrypted: i=1; AJvYcCV7T/97PqBlW/EX8Epghf7DX3btk7fY/GUT4grEPQp1hKAaHNobESqvc5wvLd1mbH/ygMEmuuVsJB4HiNPl+k2todEJcg/8tPqBdY4WNn0DwA==
X-Gm-Message-State: AOJu0Yxy8rNmGamuZSjjBSffQI5sp9nG/oDaVR0ryGRvMmHZSca1V5vd
	ZHEwnoKuvJkgUkyY4r2fcT8QeP0OfaMkYsH4WhRNxbdYZbLORXUZqsYMFvYJzXVA4ID3i4OwC+e
	mErbozg==
X-Google-Smtp-Source: AGHT+IERi9GSRMxTnykwrvZUawENrgJqpnxu9ZqGvySjlAvzwYvNnKXGoblaCJvhtARlkORt4uKlhsK9fAHn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a25:83d0:0:b0:e11:584f:c2ca with SMTP id
 3f1490d57ef6-e1180e8eb8emr212527276.6.1723877119735; Fri, 16 Aug 2024
 23:45:19 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:37 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 08/13] perf inject: Combine different mmap and mmap2 functions
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

There are repipe, build ID and JIT dump variants of the mmap and mmap2
repipe functions. The organization doesn't allow JIT dump to work with
build ID injection and the structure is less than clear. Combine the
function and enable the different behaviors based on ifs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 199 ++++++++++++++----------------------
 1 file changed, 76 insertions(+), 123 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 865d16ceead2..d99868953ff2 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -377,44 +377,6 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 	return perf_event__repipe_synth(tool, event);
 }
 
-static int perf_event__repipe_mmap(const struct perf_tool *tool,
-				   union perf_event *event,
-				   struct perf_sample *sample,
-				   struct machine *machine)
-{
-	int err;
-
-	err = perf_event__process_mmap(tool, event, sample, machine);
-	perf_event__repipe(tool, event, sample, machine);
-
-	return err;
-}
-
-#ifdef HAVE_JITDUMP
-static int perf_event__jit_repipe_mmap(const struct perf_tool *tool,
-				       union perf_event *event,
-				       struct perf_sample *sample,
-				       struct machine *machine)
-{
-	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
-	u64 n = 0;
-	int ret;
-
-	/*
-	 * if jit marker, then inject jit mmaps and generate ELF images
-	 */
-	ret = jit_process(inject->session, &inject->output, machine,
-			  event->mmap.filename, event->mmap.pid, event->mmap.tid, &n);
-	if (ret < 0)
-		return ret;
-	if (ret) {
-		inject->bytes_written += n;
-		return 0;
-	}
-	return perf_event__repipe_mmap(tool, event, sample, machine);
-}
-#endif
-
 static struct dso *findnew_dso(int pid, int tid, const char *filename,
 			       const struct dso_id *id, struct machine *machine)
 {
@@ -460,114 +422,108 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 	return dso;
 }
 
-static int perf_event__repipe_buildid_mmap(const struct perf_tool *tool,
-					   union perf_event *event,
-					   struct perf_sample *sample,
-					   struct machine *machine)
-{
-	struct dso *dso;
-
-	dso = findnew_dso(event->mmap.pid, event->mmap.tid,
-			  event->mmap.filename, NULL, machine);
-
-	if (dso && !dso__hit(dso)) {
-		dso__set_hit(dso);
-		dso__inject_build_id(dso, tool, machine, sample->cpumode, 0);
-	}
-	dso__put(dso);
-
-	return perf_event__repipe(tool, event, sample, machine);
-}
-
-static int perf_event__repipe_mmap2(const struct perf_tool *tool,
+static int perf_event__repipe_mmap(const struct perf_tool *tool,
 				   union perf_event *event,
 				   struct perf_sample *sample,
 				   struct machine *machine)
 {
-	int err;
+	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 
-	err = perf_event__process_mmap2(tool, event, sample, machine);
-	perf_event__repipe(tool, event, sample, machine);
+#ifdef HAVE_JITDUMP
+	if (inject->jit_mode) {
+		u64 n = 0;
+		int ret;
 
-	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
-		struct dso *dso;
+		/* If jit marker, then inject jit mmaps and generate ELF images. */
+		ret = jit_process(inject->session, &inject->output, machine,
+				  event->mmap.filename, event->mmap.pid, event->mmap.tid, &n);
+		if (ret < 0)
+			return ret;
+		if (ret) {
+			inject->bytes_written += n;
+			return 0;
+		}
+	}
+#endif
+	if (inject->build_id_style == BID_RWS__INJECT_HEADER_ALL) {
+		struct dso *dso = findnew_dso(event->mmap.pid, event->mmap.tid,
+					      event->mmap.filename, NULL, machine);
 
-		dso = findnew_dso(event->mmap2.pid, event->mmap2.tid,
-				  event->mmap2.filename, NULL, machine);
-		if (dso) {
-			/* mark it not to inject build-id */
+		if (dso && !dso__hit(dso)) {
 			dso__set_hit(dso);
+			dso__inject_build_id(dso, tool, machine, sample->cpumode, 0);
 		}
 		dso__put(dso);
-	}
+	} else {
+		/* Create the thread, map, etc. Not done for the unordered inject all case. */
+		int err = perf_event__process_mmap(tool, event, sample, machine);
 
-	return err;
+		if (err)
+			return err;
+	}
+	return perf_event__repipe(tool, event, sample, machine);
 }
 
-#ifdef HAVE_JITDUMP
-static int perf_event__jit_repipe_mmap2(const struct perf_tool *tool,
-					union perf_event *event,
-					struct perf_sample *sample,
-					struct machine *machine)
+static int perf_event__repipe_mmap2(const struct perf_tool *tool,
+				   union perf_event *event,
+				   struct perf_sample *sample,
+				   struct machine *machine)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
-	u64 n = 0;
-	int ret;
+	struct dso *dso = NULL;
 
-	/*
-	 * if jit marker, then inject jit mmaps and generate ELF images
-	 */
-	ret = jit_process(inject->session, &inject->output, machine,
-			  event->mmap2.filename, event->mmap2.pid, event->mmap2.tid, &n);
-	if (ret < 0)
-		return ret;
-	if (ret) {
-		inject->bytes_written += n;
-		return 0;
+#ifdef HAVE_JITDUMP
+	if (inject->jit_mode) {
+		u64 n = 0;
+		int ret;
+
+		/* If jit marker, then inject jit mmaps and generate ELF images. */
+		ret = jit_process(inject->session, &inject->output, machine,
+				event->mmap2.filename, event->mmap2.pid, event->mmap2.tid, &n);
+		if (ret < 0)
+			return ret;
+		if (ret) {
+			inject->bytes_written += n;
+			return 0;
+		}
 	}
-	return perf_event__repipe_mmap2(tool, event, sample, machine);
-}
 #endif
-
-static int perf_event__repipe_buildid_mmap2(const struct perf_tool *tool,
-					    union perf_event *event,
-					    struct perf_sample *sample,
-					    struct machine *machine)
-{
-	struct dso_id dso_id = {
-		.maj = event->mmap2.maj,
-		.min = event->mmap2.min,
-		.ino = event->mmap2.ino,
-		.ino_generation = event->mmap2.ino_generation,
-	};
-	struct dso *dso;
-
 	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
-		/* cannot use dso_id since it'd have invalid info */
 		dso = findnew_dso(event->mmap2.pid, event->mmap2.tid,
 				  event->mmap2.filename, NULL, machine);
 		if (dso) {
 			/* mark it not to inject build-id */
 			dso__set_hit(dso);
 		}
-		dso__put(dso);
-		perf_event__repipe(tool, event, sample, machine);
-		return 0;
 	}
+	if (inject->build_id_style == BID_RWS__INJECT_HEADER_ALL) {
+		if (!(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)) {
+			struct dso_id dso_id = {
+				.maj = event->mmap2.maj,
+				.min = event->mmap2.min,
+				.ino = event->mmap2.ino,
+				.ino_generation = event->mmap2.ino_generation,
+			};
+
+			dso = findnew_dso(event->mmap2.pid, event->mmap2.tid,
+					  event->mmap2.filename, &dso_id, machine);
+		}
+		if (dso && !dso__hit(dso)) {
+			dso__set_hit(dso);
+			dso__inject_build_id(dso, tool, machine, sample->cpumode,
+					event->mmap2.flags);
+		}
+	} else {
+		/* Create the thread, map, etc. Not done for the unordered inject all case. */
+		int err = perf_event__process_mmap(tool, event, sample, machine);
 
-	dso = findnew_dso(event->mmap2.pid, event->mmap2.tid,
-			  event->mmap2.filename, &dso_id, machine);
-
-	if (dso && !dso__hit(dso)) {
-		dso__set_hit(dso);
-		dso__inject_build_id(dso, tool, machine, sample->cpumode,
-				     event->mmap2.flags);
+		if (err) {
+			dso__put(dso);
+			return err;
+		}
 	}
 	dso__put(dso);
-
-	perf_event__repipe(tool, event, sample, machine);
-
-	return 0;
+	return perf_event__repipe(tool, event, sample, machine);
 }
 
 static int perf_event__repipe_fork(const struct perf_tool *tool,
@@ -2032,10 +1988,7 @@ static int __cmd_inject(struct perf_inject *inject)
 
 	output_data_offset = perf_session__data_offset(session->evlist);
 
-	if (inject->build_id_style == BID_RWS__INJECT_HEADER_ALL) {
-		inject->tool.mmap	  = perf_event__repipe_buildid_mmap;
-		inject->tool.mmap2	  = perf_event__repipe_buildid_mmap2;
-	} else if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY) {
+	if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY) {
 		inject->tool.sample = perf_event__inject_buildid;
 	} else if (inject->sched_stat) {
 		struct evsel *evsel;
@@ -2430,8 +2383,8 @@ int cmd_inject(int argc, const char **argv)
 
 #ifdef HAVE_JITDUMP
 	if (inject.jit_mode) {
-		inject.tool.mmap2	   = perf_event__jit_repipe_mmap2;
-		inject.tool.mmap	   = perf_event__jit_repipe_mmap;
+		inject.tool.mmap2	   = perf_event__repipe_mmap2;
+		inject.tool.mmap	   = perf_event__repipe_mmap;
 		inject.tool.ordering_requires_timestamps = true;
 		/*
 		 * JIT MMAP injection injects all MMAP events in one go, so it
-- 
2.46.0.184.g6999bdac58-goog


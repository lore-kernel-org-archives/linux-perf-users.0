Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B96E193064
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434203; cv=none; b=tN+g3YK9fS+j1cazc2zPFPYutNJ5gAZbwgwPJZfNPHqjfANw+aaiCp5sZWsHQWs8o9+zZqTEg4ClN8eT3QYdWNbMvQazu7aNSv00MsspEvfyRZloqJ7tUyc/SAgwXqGMfnLi2r/gSbqClko6MfSomqSm1yS0sLWQ8yVNdFSKwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434203; c=relaxed/simple;
	bh=qIVwlBIxBrBE5DJKOsQgRyMq6nkjAIOMt9TVYlLDX4w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AnbClLQP57QyigbZN3N/RQ2oIEuiCqnsVQzdi266P9pmwrOG41hL1H2Kelip68XIg34no5yXDt0qvemrJTak6v9WcohcxJPRDQTHLcwsXfcqQgnYgKzeYO4RZGRSSAlthJUbYT5AbTXmXiyC36X3V4qX3vXN1kqB6HW0eDavVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fP6RiTse; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fP6RiTse"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63548741556so129694187b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434201; x=1720039001; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnGIHHkhF2Y479Oo/otGWrEFafXUa7WO1wDvauktO0o=;
        b=fP6RiTseiTc7k7S8L4SESvaZjP7AEoBZ61f3xHn9RPiuNEzO87HPai0I+O9AYG6Bv1
         WAVIzPp66HKR0hgRITDA3ir/Z1YJmMs5Nc6GbLsbydRoAwMNjkm+/EicSQjIGF73wkBp
         Q8ilciS+8nD1GW9NmM+bYgTRi9Jwe0Z9q0NRtWamrxyXhtYLQHgb6QGeGN1qqduE3pcu
         SM/h7EvPuvOGoiA4GTjXCvKy85kFf4Ed6HIaFZbby0BFTe7PhBMAXeLSGMA2rGmfmFnZ
         qYX5HVhAgKbEWqTE8EQDyus1M3TWNajWnVT3uOuqxAnGWCaMaa0qP9SW6sclO+gexo8f
         qc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434201; x=1720039001;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnGIHHkhF2Y479Oo/otGWrEFafXUa7WO1wDvauktO0o=;
        b=Q+P46pbzw89jenHihhu7kFGXnwsDdEt7ts+87OPaq/Lnhuf/Er/I941GhmYYYQ9NFb
         2hKi64jh9PEGFUKV0t4hqbMtUqGIBXzsC26CN0HLgoXpNm1Xx/545INxobGttitSylCO
         Ue0b7uqj5R5NNeaYiAGcsAuTWHclV5yLihS3QWfHWbUFWQfjhW9Z+VmNworNnGthowhr
         VX/nS8uuyknk0yBgAIb6LW9vSod9QBb6Gk6ioPTwMLezaY2nOSM/2C3zD8/yWeypquyR
         5Kv7axhyd4bNatbppKYZgQg9MhpnGm52FYreM97s/Moc5D6mW2UmnZIdtsgm5BZhbG3L
         QD/A==
X-Forwarded-Encrypted: i=1; AJvYcCVMsziGqesFuUi4y+xDQHQ6N6gHwO1A58USgnLRVUyzaHBsJHZHzhIUEs2ibzS4xcG5bSrsnM7bFV+LQu1QVxjWHPjg9cruEcCc2Y3yy7ZjYg==
X-Gm-Message-State: AOJu0YwbhuTEmS7ph2KSYjuwaT4nE3UxQokWJEg6CNbfRXFgpJ1PzwZw
	WP+KcV1wR+QvW+/DqX/ivplcHpm8tfIlh+x91MSJNBTLOeDguUa1L/hJzRrs6gl5iOsNJyJL2Yq
	1e+43QA==
X-Google-Smtp-Source: AGHT+IGj/mCO4jEzm9rd9xMT3ci6YrkO+sYryFdaNeAGcFh7StHBleb0kVfx0rV3JI7j9YEgpazJzR0VNbWs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:f0b:b0:61b:e524:f91a with SMTP id
 00721157ae682-64341c235b3mr1708607b3.10.1719434201082; Wed, 26 Jun 2024
 13:36:41 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:03 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 01/27] perf auxevent: Zero size dummy tool
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The dummy tool is passed as a placeholder to allow a container_of to
get additional parameters. As the tool isn't used, make it a zero
sized array saving 320 bytes on an x86_64 build.

s390-cpumsf's dummy tool struct was unused, so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/arm-spe.c     | 6 +++---
 tools/perf/util/cs-etm.c      | 6 +++---
 tools/perf/util/intel-bts.c   | 6 +++---
 tools/perf/util/intel-pt.c    | 7 +++----
 tools/perf/util/s390-cpumsf.c | 5 -----
 5 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index afbd5869f6bf..ee0d5064ddd4 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1074,8 +1074,8 @@ static void arm_spe_print_info(__u64 *arr)
 }
 
 struct arm_spe_synth {
-	struct perf_tool dummy_tool;
 	struct perf_session *session;
+	struct perf_tool dummy_tool[0];
 };
 
 static int arm_spe_event_synth(struct perf_tool *tool,
@@ -1084,7 +1084,7 @@ static int arm_spe_event_synth(struct perf_tool *tool,
 			       struct machine *machine __maybe_unused)
 {
 	struct arm_spe_synth *arm_spe_synth =
-		      container_of(tool, struct arm_spe_synth, dummy_tool);
+		      container_of(tool, struct arm_spe_synth, dummy_tool[0]);
 
 	return perf_session__deliver_synth_event(arm_spe_synth->session,
 						 event, NULL);
@@ -1098,7 +1098,7 @@ static int arm_spe_synth_event(struct perf_session *session,
 	memset(&arm_spe_synth, 0, sizeof(struct arm_spe_synth));
 	arm_spe_synth.session = session;
 
-	return perf_event__synthesize_attr(&arm_spe_synth.dummy_tool, attr, 1,
+	return perf_event__synthesize_attr(arm_spe_synth.dummy_tool, attr, 1,
 					   &id, arm_spe_event_synth);
 }
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 32818bd7cd17..9fd2967d4e3f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1596,8 +1596,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 }
 
 struct cs_etm_synth {
-	struct perf_tool dummy_tool;
 	struct perf_session *session;
+	struct perf_tool dummy_tool[0];
 };
 
 static int cs_etm__event_synth(struct perf_tool *tool,
@@ -1606,7 +1606,7 @@ static int cs_etm__event_synth(struct perf_tool *tool,
 			       struct machine *machine __maybe_unused)
 {
 	struct cs_etm_synth *cs_etm_synth =
-		      container_of(tool, struct cs_etm_synth, dummy_tool);
+		      container_of(tool, struct cs_etm_synth, dummy_tool[0]);
 
 	return perf_session__deliver_synth_event(cs_etm_synth->session,
 						 event, NULL);
@@ -1620,7 +1620,7 @@ static int cs_etm__synth_event(struct perf_session *session,
 	memset(&cs_etm_synth, 0, sizeof(struct cs_etm_synth));
 	cs_etm_synth.session = session;
 
-	return perf_event__synthesize_attr(&cs_etm_synth.dummy_tool, attr, 1,
+	return perf_event__synthesize_attr(cs_etm_synth.dummy_tool, attr, 1,
 					   &id, cs_etm__event_synth);
 }
 
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index ec1b3bd9f530..fb8fec3a3c36 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -738,8 +738,8 @@ static bool intel_bts_evsel_is_auxtrace(struct perf_session *session,
 }
 
 struct intel_bts_synth {
-	struct perf_tool dummy_tool;
 	struct perf_session *session;
+	struct perf_tool dummy_tool[0];
 };
 
 static int intel_bts_event_synth(struct perf_tool *tool,
@@ -748,7 +748,7 @@ static int intel_bts_event_synth(struct perf_tool *tool,
 				 struct machine *machine __maybe_unused)
 {
 	struct intel_bts_synth *intel_bts_synth =
-			container_of(tool, struct intel_bts_synth, dummy_tool);
+			container_of(tool, struct intel_bts_synth, dummy_tool[0]);
 
 	return perf_session__deliver_synth_event(intel_bts_synth->session,
 						 event, NULL);
@@ -762,7 +762,7 @@ static int intel_bts_synth_event(struct perf_session *session,
 	memset(&intel_bts_synth, 0, sizeof(struct intel_bts_synth));
 	intel_bts_synth.session = session;
 
-	return perf_event__synthesize_attr(&intel_bts_synth.dummy_tool, attr, 1,
+	return perf_event__synthesize_attr(intel_bts_synth.dummy_tool, attr, 1,
 					   &id, intel_bts_event_synth);
 }
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index d6d7b7512505..b8b90773baa2 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3660,8 +3660,8 @@ static int intel_pt_queue_data(struct perf_session *session,
 }
 
 struct intel_pt_synth {
-	struct perf_tool dummy_tool;
 	struct perf_session *session;
+	struct perf_tool dummy_tool[0];
 };
 
 static int intel_pt_event_synth(struct perf_tool *tool,
@@ -3670,7 +3670,7 @@ static int intel_pt_event_synth(struct perf_tool *tool,
 				struct machine *machine __maybe_unused)
 {
 	struct intel_pt_synth *intel_pt_synth =
-			container_of(tool, struct intel_pt_synth, dummy_tool);
+			container_of(tool, struct intel_pt_synth, dummy_tool[0]);
 
 	return perf_session__deliver_synth_event(intel_pt_synth->session, event,
 						 NULL);
@@ -3687,8 +3687,7 @@ static int intel_pt_synth_event(struct perf_session *session, const char *name,
 
 	memset(&intel_pt_synth, 0, sizeof(struct intel_pt_synth));
 	intel_pt_synth.session = session;
-
-	err = perf_event__synthesize_attr(&intel_pt_synth.dummy_tool, attr, 1,
+	err = perf_event__synthesize_attr(intel_pt_synth.dummy_tool, attr, 1,
 					  &id, intel_pt_event_synth);
 	if (err)
 		pr_err("%s: failed to synthesize '%s' event type\n",
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 6fe478b0b61b..4ec583e511af 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -952,11 +952,6 @@ s390_cpumsf_process_event(struct perf_session *session,
 	return err;
 }
 
-struct s390_cpumsf_synth {
-	struct perf_tool cpumsf_tool;
-	struct perf_session *session;
-};
-
 static int
 s390_cpumsf_process_auxtrace_event(struct perf_session *session,
 				   union perf_event *event __maybe_unused,
-- 
2.45.2.741.gdbec12cfda-goog


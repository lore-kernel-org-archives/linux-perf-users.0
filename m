Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B481B86CB
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264441; cv=none; b=OgtQ/nVkYJTZ7670ADoofb3J3pqiCCGMc8Zbf9cc3XdKf3+RgFXoTaiXQjb159TzGbrQ8QfVeII1aWFjgO+kU+qJU7NlKtYpGCQ39qmpifEHrktI7TkAT+UTa66ndwzhBTQ4fKGCl2oJOu8JG970rxdBXG6igzHxslJBrvBaszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264441; c=relaxed/simple;
	bh=axSrt07YKEcGyRkfZftuqj4Vl4d+kkSuG6NbQDLQ3sA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=rWhArmR/q6xcTlicJNO95FMy0aT9YojUq6WwaSZKwNJRqQpLVmY28AJEGSYRq1oqVGu4AMhKYq4md6WZ+HEEraBarWtFI1gojYI5RdXuo63oqnaKbbc2Hw++Plx707dG4l5/O4KyGHngARgV3obxSgUN380WyHHDYvZkp1h41B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0nh215F; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0nh215F"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so701024276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264438; x=1721869238; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h3hGifXSQjj3nm6fESVDyQ4AnTNn7U8iAdJU/7HOQ5M=;
        b=G0nh215FKdkcnihpWWH9kqdYLYWJxf6lQ1nZ7b7f0NS1U2aZUEyuwORaZbN/lYjiQn
         +7R0q75sNm/mUDHfFK1V8IJQKGNikovpq6Yi+eRulykaOB/P+BPNjgZAhlz+Sj/9MZg4
         S8o0RuxVephxq7H9P70EMONrQ3UiUkZkrrLFN9fDCWj34cl1HsNgKp3I7ZqXTtXNTdIy
         oT6n4HIFBa52aaJLWuv+ykHNBtVa0sm/j8CW14kOSn9LhX/XWHu6S40Ik+/JXrngpQ3Q
         Hav94XOukjlj7k1mylAYENRIkhgkEFxzvrY+oVq+NYVcLAvkuStGy/KeMDfQuym9Bb8T
         aaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264438; x=1721869238;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3hGifXSQjj3nm6fESVDyQ4AnTNn7U8iAdJU/7HOQ5M=;
        b=NvBdV2DJEhH0GCZGM525qRL6N6Zt6GlXeUb8l5i4CEooYo1R/sxZprjKwUi0sAbSCW
         HoqxVULXXIqf1Vry5DqdiyiVhlwQv2i1HRW2M2twADdy6ig7EmRBw7x7kit4V+4ygyFO
         nxcZabVT4Zfjg0Ac+ckRaGZdlYRtbSrEvwv6FC7ZD1ZWQ6NdM6xGS/0ozYoCpTHAHs6h
         GOS5XGD0O9x/t2R4eI9jkefpuRZkMhX09KUisTsv1WCWmYYLe/ZBnXSJXGToEP9reSM/
         lxhueFip0CiVTz0MSJ8TckySH0aZBCMoiJ3fBvfdeeMcxLYKGd834DqPSYbJSm/MeKpI
         gKZw==
X-Forwarded-Encrypted: i=1; AJvYcCXShCMnx+SjN5T5/quPNebRsgB2+yWSOfFVsSJZ178VCiH4Iq0s340B37uL8ZqHB0kXjrCnPSVF7gkY1HpwqO7V2GzpfOJmmoSrEMeZR0lr3Q==
X-Gm-Message-State: AOJu0YySyMXNfb0wB3JRtO6zDel/Ejv0n3YJ0pJKqgfkr+yqy2OCeFP/
	zWNDDHYLN4K7Wlw+SV1g5IW1Vz5mvmdj7zHHhG5IfrC4k8lffCQB9rE29mW/Jx6zKsfYumJUg5p
	YysDGLw==
X-Google-Smtp-Source: AGHT+IHw3VaaUAUkP9J/OduZR01vk+bxSTc0XaiCAt/SDLKwoDxaATIJIqZVnUceV4pBafhIsjwxsfpQNkph
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:c13:b0:e07:2e88:89fe with SMTP id
 3f1490d57ef6-e072e888d78mr3276.3.1721264437877; Wed, 17 Jul 2024 18:00:37
 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:59:57 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 01/27] perf auxtrace: Remove dummy tools
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Add perf_session__deliver_synth_attr_event that synthesizes a
perf_record_header_attr event with one id. Remove use of
perf_event__synthesize_attr that necessitates the use of the dummy
tool in order to pass the session.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c   | 49 ++++++++-----------------------------
 tools/perf/util/cs-etm.c    | 33 ++-----------------------
 tools/perf/util/intel-bts.c | 31 +----------------------
 tools/perf/util/intel-pt.c  | 24 +-----------------
 tools/perf/util/session.c   | 24 ++++++++++++++++++
 tools/perf/util/session.h   |  3 +++
 6 files changed, 41 insertions(+), 123 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index afbd5869f6bf..fa40f3cb6266 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1073,35 +1073,6 @@ static void arm_spe_print_info(__u64 *arr)
 	fprintf(stdout, arm_spe_info_fmts[ARM_SPE_PMU_TYPE], arr[ARM_SPE_PMU_TYPE]);
 }
 
-struct arm_spe_synth {
-	struct perf_tool dummy_tool;
-	struct perf_session *session;
-};
-
-static int arm_spe_event_synth(struct perf_tool *tool,
-			       union perf_event *event,
-			       struct perf_sample *sample __maybe_unused,
-			       struct machine *machine __maybe_unused)
-{
-	struct arm_spe_synth *arm_spe_synth =
-		      container_of(tool, struct arm_spe_synth, dummy_tool);
-
-	return perf_session__deliver_synth_event(arm_spe_synth->session,
-						 event, NULL);
-}
-
-static int arm_spe_synth_event(struct perf_session *session,
-			       struct perf_event_attr *attr, u64 id)
-{
-	struct arm_spe_synth arm_spe_synth;
-
-	memset(&arm_spe_synth, 0, sizeof(struct arm_spe_synth));
-	arm_spe_synth.session = session;
-
-	return perf_event__synthesize_attr(&arm_spe_synth.dummy_tool, attr, 1,
-					   &id, arm_spe_event_synth);
-}
-
 static void arm_spe_set_event_name(struct evlist *evlist, u64 id,
 				    const char *name)
 {
@@ -1172,7 +1143,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		spe->sample_flc = true;
 
 		/* Level 1 data cache miss */
-		err = arm_spe_synth_event(session, &attr, id);
+		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;
 		spe->l1d_miss_id = id;
@@ -1180,7 +1151,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		id += 1;
 
 		/* Level 1 data cache access */
-		err = arm_spe_synth_event(session, &attr, id);
+		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;
 		spe->l1d_access_id = id;
@@ -1192,7 +1163,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		spe->sample_llc = true;
 
 		/* Last level cache miss */
-		err = arm_spe_synth_event(session, &attr, id);
+		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;
 		spe->llc_miss_id = id;
@@ -1200,7 +1171,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		id += 1;
 
 		/* Last level cache access */
-		err = arm_spe_synth_event(session, &attr, id);
+		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;
 		spe->llc_access_id = id;
@@ -1212,7 +1183,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		spe->sample_tlb = true;
 
 		/* TLB miss */
-		err = arm_spe_synth_event(session, &attr, id);
+		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;
 		spe->tlb_miss_id = id;
@@ -1220,7 +1191,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		id += 1;
 
 		/* TLB access */
-		err = arm_spe_synth_event(session, &attr, id);
+		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;
 		spe->tlb_access_id = id;
@@ -1232,7 +1203,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		spe->sample_branch = true;
 
 		/* Branch miss */
-		err = arm_spe_synth_event(session, &attr, id);
+		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;
 		spe->branch_miss_id = id;
@@ -1244,7 +1215,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		spe->sample_remote_access = true;
 
 		/* Remote access */
-		err = arm_spe_synth_event(session, &attr, id);
+		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;
 		spe->remote_access_id = id;
@@ -1255,7 +1226,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	if (spe->synth_opts.mem) {
 		spe->sample_memory = true;
 
-		err = arm_spe_synth_event(session, &attr, id);
+		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;
 		spe->memory_id = id;
@@ -1276,7 +1247,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
 		attr.sample_period = spe->synth_opts.period;
 		spe->instructions_sample_period = attr.sample_period;
-		err = arm_spe_synth_event(session, &attr, id);
+		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;
 		spe->instructions_id = id;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5e9fbcfad7d4..7fd976ea954b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1595,35 +1595,6 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	return ret;
 }
 
-struct cs_etm_synth {
-	struct perf_tool dummy_tool;
-	struct perf_session *session;
-};
-
-static int cs_etm__event_synth(struct perf_tool *tool,
-			       union perf_event *event,
-			       struct perf_sample *sample __maybe_unused,
-			       struct machine *machine __maybe_unused)
-{
-	struct cs_etm_synth *cs_etm_synth =
-		      container_of(tool, struct cs_etm_synth, dummy_tool);
-
-	return perf_session__deliver_synth_event(cs_etm_synth->session,
-						 event, NULL);
-}
-
-static int cs_etm__synth_event(struct perf_session *session,
-			       struct perf_event_attr *attr, u64 id)
-{
-	struct cs_etm_synth cs_etm_synth;
-
-	memset(&cs_etm_synth, 0, sizeof(struct cs_etm_synth));
-	cs_etm_synth.session = session;
-
-	return perf_event__synthesize_attr(&cs_etm_synth.dummy_tool, attr, 1,
-					   &id, cs_etm__event_synth);
-}
-
 static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 				struct perf_session *session)
 {
@@ -1675,7 +1646,7 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 		attr.config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS;
 		attr.sample_period = 1;
 		attr.sample_type |= PERF_SAMPLE_ADDR;
-		err = cs_etm__synth_event(session, &attr, id);
+		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;
 		etm->branches_sample_type = attr.sample_type;
@@ -1698,7 +1669,7 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
 		attr.sample_period = etm->synth_opts.period;
 		etm->instructions_sample_period = attr.sample_period;
-		err = cs_etm__synth_event(session, &attr, id);
+		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;
 		etm->instructions_sample_type = attr.sample_type;
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index ec1b3bd9f530..160d346cb450 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -737,35 +737,6 @@ static bool intel_bts_evsel_is_auxtrace(struct perf_session *session,
 	return evsel->core.attr.type == bts->pmu_type;
 }
 
-struct intel_bts_synth {
-	struct perf_tool dummy_tool;
-	struct perf_session *session;
-};
-
-static int intel_bts_event_synth(struct perf_tool *tool,
-				 union perf_event *event,
-				 struct perf_sample *sample __maybe_unused,
-				 struct machine *machine __maybe_unused)
-{
-	struct intel_bts_synth *intel_bts_synth =
-			container_of(tool, struct intel_bts_synth, dummy_tool);
-
-	return perf_session__deliver_synth_event(intel_bts_synth->session,
-						 event, NULL);
-}
-
-static int intel_bts_synth_event(struct perf_session *session,
-				 struct perf_event_attr *attr, u64 id)
-{
-	struct intel_bts_synth intel_bts_synth;
-
-	memset(&intel_bts_synth, 0, sizeof(struct intel_bts_synth));
-	intel_bts_synth.session = session;
-
-	return perf_event__synthesize_attr(&intel_bts_synth.dummy_tool, attr, 1,
-					   &id, intel_bts_event_synth);
-}
-
 static int intel_bts_synth_events(struct intel_bts *bts,
 				  struct perf_session *session)
 {
@@ -814,7 +785,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 		attr.sample_type |= PERF_SAMPLE_ADDR;
 		pr_debug("Synthesizing 'branches' event with id %" PRIu64 " sample type %#" PRIx64 "\n",
 			 id, (u64)attr.sample_type);
-		err = intel_bts_synth_event(session, &attr, id);
+		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err) {
 			pr_err("%s: failed to synthesize 'branches' event type\n",
 			       __func__);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index d6d7b7512505..1fc03bfd14c3 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3659,37 +3659,15 @@ static int intel_pt_queue_data(struct perf_session *session,
 					   data_offset, timestamp);
 }
 
-struct intel_pt_synth {
-	struct perf_tool dummy_tool;
-	struct perf_session *session;
-};
-
-static int intel_pt_event_synth(struct perf_tool *tool,
-				union perf_event *event,
-				struct perf_sample *sample __maybe_unused,
-				struct machine *machine __maybe_unused)
-{
-	struct intel_pt_synth *intel_pt_synth =
-			container_of(tool, struct intel_pt_synth, dummy_tool);
-
-	return perf_session__deliver_synth_event(intel_pt_synth->session, event,
-						 NULL);
-}
-
 static int intel_pt_synth_event(struct perf_session *session, const char *name,
 				struct perf_event_attr *attr, u64 id)
 {
-	struct intel_pt_synth intel_pt_synth;
 	int err;
 
 	pr_debug("Synthesizing '%s' event with id %" PRIu64 " sample type %#" PRIx64 "\n",
 		 name, id, (u64)attr->sample_type);
 
-	memset(&intel_pt_synth, 0, sizeof(struct intel_pt_synth));
-	intel_pt_synth.session = session;
-
-	err = perf_event__synthesize_attr(&intel_pt_synth.dummy_tool, attr, 1,
-					  &id, intel_pt_event_synth);
+	err = perf_session__deliver_synth_attr_event(session, attr, id);
 	if (err)
 		pr_err("%s: failed to synthesize '%s' event type\n",
 		       __func__, name);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5596bed1b8c8..18a8f4a84045 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1764,6 +1764,30 @@ int perf_session__deliver_synth_event(struct perf_session *session,
 	return machines__deliver_event(&session->machines, evlist, event, sample, tool, 0, NULL);
 }
 
+int perf_session__deliver_synth_attr_event(struct perf_session *session,
+					   const struct perf_event_attr *attr,
+					   u64 id)
+{
+	union {
+		struct {
+			struct perf_record_header_attr attr;
+			u64 ids[1];
+		} attr_id;
+		union perf_event ev;
+	} ev = {
+		.attr_id.attr.header.type = PERF_RECORD_HEADER_ATTR,
+		.attr_id.attr.header.size = sizeof(ev.attr_id),
+		.attr_id.ids[0] = id,
+	};
+
+	if (attr->size != sizeof(ev.attr_id.attr.attr)) {
+		pr_debug("Unexpected perf_event_attr size\n");
+		return -EINVAL;
+	}
+	ev.attr_id.attr.attr = *attr;
+	return perf_session__deliver_synth_event(session, &ev.ev, NULL);
+}
+
 static void event_swap(union perf_event *event, bool sample_id_all)
 {
 	perf_event__swap_op swap;
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 4c29dc86956f..cc28976bb00e 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -154,6 +154,9 @@ extern volatile int session_done;
 int perf_session__deliver_synth_event(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_sample *sample);
+int perf_session__deliver_synth_attr_event(struct perf_session *session,
+					   const struct perf_event_attr *attr,
+					   u64 id);
 
 int perf_session__dsos_hit_all(struct perf_session *session);
 
-- 
2.45.2.1089.g2a221341d9-goog


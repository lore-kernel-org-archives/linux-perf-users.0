Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042D2262B
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636853; cv=none; b=IdsP81HoQvn4ANLnq+9OxFtVaYOmFJjuJlETQkiwNRQFlRxXn5U7m9MbSARwGQyivVCv3JHUivqSEFqvXwHid2sJ9SHdBdLNYVdILvP4p4wpnneJ9Rcdd+b+xC2Z0SOSOO5nqEAKWWH6jbqa1JkAGU6FarPllrOuqBQQFPH1ZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636853; c=relaxed/simple;
	bh=WjJl7Xwm5fxKRIK12FrVcQFsSW477ASrbLk287Yd/mo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bNsfplo9CaSvjFEIYoyWfms1VrrJdXfcoH/eMYhh9vSxh9DZ+gazp8uI/3QTj9UdqyZBCrTkYqjYRXMnKipv3XC9H5gYL0jR04xtogQGSvLsWD+8Kv6Q8H5A4I/KwNNnXwWlyFFukb9WWoNj9DYDrI+Y29EialqMQp5LbXb2yjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQ3Tb/ua; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQ3Tb/ua"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64a6cda8ba1so22316057b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636850; x=1720241650; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fncuw7Z3XbzRLX/WU2elzeojCG7VDD1/GHjCfyd9rj4=;
        b=pQ3Tb/uah6gbVkinldKQ7bpTu6KkCLUnLO0Dg8+z+eSfSDlhEHQWYDxSGpZ8eScD+a
         +Iq77fAEumBWloUPA+xpKbMmOP1MeIqdIM9OWg3wcgMaDOiAnyfT0xfcY0XCQ+OrTpyg
         boROHKZrgXQrMWryUZyX/wt2XlD4Jh+f5j5DjkcShpDv7pTlSYN8PtjKYrGATXswpkSF
         PbaJrSDhaelnj4tCRqA26jolEXFlzrtfhYIC4bOIqIWGOQIBsb4fDsBP/RO+ZE0H0eHi
         ex1EMc2Iqa70h0Q4bTOPI7ElGkNVBQfcS/kaatNO5SYELXBiDHC7I+OkTeLqaCGcLjEp
         JR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636850; x=1720241650;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fncuw7Z3XbzRLX/WU2elzeojCG7VDD1/GHjCfyd9rj4=;
        b=aGAIpkzkfF+xogLf3Z7rwUmPBfbgJrSr+E+z6UGmlLpBRZkYPL0e5lbgknq1syvP6b
         ZYcbQ+SWtuHeCDh45gIzni2qM91fL250W0Mfq3EozrCc12SdH4O0VtFsLxGBsGI5zx46
         UNbsZ7IcBMWWMEV4+WNw6oV5e0liVtTDjbqpGAQjsfrdfR3fhZlYPoN9JP8wJhDoC3kR
         HZxZOQqvwQNFM7o5LXMfcsxzqWGW2FpdRNBh7INk1H+IHkGZPNOqyc1PZdKZXyOfJcG0
         jqCuacnJxgUGUK2N9cDIgm/vSOXbhXoPU5IAI6Mdp3hkjN68BT8AahmInzDPvtx8gHL0
         6c5A==
X-Forwarded-Encrypted: i=1; AJvYcCWa3HsHeNLdrbq8H+rv3HhyW9WP5AEyVs40nbhdZTtaLR+JxPEcYzFCkwde/QuLRjRmdTmQ5/Di8qcQ7wbpqea5vF+TrrHpMAzuyQbKfyJqhA==
X-Gm-Message-State: AOJu0YxS0UGPAj6uneOQMstw48NTLIKVzqkueGrIU97gWrrWmH/xvuHh
	bck9vivWnb1iNRKkfAkeqx5FFldYxAvkR68DURvoUfOevIoP0IwZ8zgtmQBPSNFa1pFkgZguz+P
	dTi+5Lw==
X-Google-Smtp-Source: AGHT+IEvFm7w3visFsVmiS8TyXjnSiUqd0ooBxC87vSF9FgvC4Jnxnscz7Zxpyg4HeoWiYOpkSkaylwGbzMu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b89:b0:dff:83e:b259 with SMTP id
 3f1490d57ef6-e036eb4a8cemr991276.6.1719636850301; Fri, 28 Jun 2024 21:54:10
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:23 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 01/28] perf auxtrace: Remove dummy tools
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
Content-Type: text/plain; charset="UTF-8"

Add perf_session__deliver_synth_attr_event that synthesizes a
perf_record_header_attr event with one id. Remove use of
perf_event__synthesize_attr that necessitates the use of the dummy
tool in order to pass the session.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/arm-spe.c   | 49 ++++++++-----------------------------
 tools/perf/util/cs-etm.c    | 33 ++-----------------------
 tools/perf/util/intel-bts.c | 31 +----------------------
 tools/perf/util/intel-pt.c  | 24 +-----------------
 tools/perf/util/session.c   | 30 +++++++++++++++++++++++
 tools/perf/util/session.h   |  3 +++
 6 files changed, 47 insertions(+), 123 deletions(-)

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
index 32818bd7cd17..c53812f343e9 100644
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
index 0ec92d47373c..44db5b49128f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1764,6 +1764,36 @@ int perf_session__deliver_synth_event(struct perf_session *session,
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
+		.attr_id = {
+			.attr = {
+				.header = {
+					.type = PERF_RECORD_HEADER_ATTR,
+					.size = PERF_ALIGN(sizeof(struct perf_event_attr),
+							   sizeof(u64))
+					    + sizeof(struct perf_event_header)
+					    + sizeof(u64),
+				},
+			},
+			.ids = { id, }
+		},
+	};
+
+	memcpy(&ev.attr_id.attr.attr, attr, min((u32)sizeof(struct perf_event_attr), attr->size));
+	ev.attr_id.attr.attr.size = sizeof(struct perf_event_attr);
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
2.45.2.803.g4e1b14247a-goog


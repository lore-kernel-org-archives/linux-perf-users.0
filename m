Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C318B47F
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914275; cv=none; b=AFHaqCABUrL/kxZSQVeDDcVPqRcWPWLg3t9n3yZnHGz1BsfOoShmpm3YHnZVGfYW1FpQfhXl/eysO6EX5TtRFUItSqo1LJCuS4z7ctD6GBTVQaW6Uo1Mv9ZXDuJOsOY/hzdDPSMrW5V/SZn++kziXK6SYRGpAGARtByp4VKEAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914275; c=relaxed/simple;
	bh=Clp56WWuXS/PFSTUhYjihAny4rJ1a82Jl6raVIJiC88=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Dq41jNIn9QAMgq1PkwaWravPLfJFNINTgnle8YVmgpStoCbjSkHrQrorWUM1SA2Rq2P8X6JWyNMzc2k8XhL7pfJ/vD/g97WZvOWzRvW2v0bjmYTEiNvuihqb+5A0d0pvPvjUgjEnghOSWfLhXHQadP9mAUZ8mGuZcWpTaUuvYPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhywGSBZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhywGSBZ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1a8eedf001so9228516276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Sep 2024 13:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725914272; x=1726519072; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=seNNgOYd+yOyVPoC1OLWCPYg4+Zlk5hIs7OYJde/eng=;
        b=NhywGSBZGfFlhp8sYIzXaLo0YN4GWh/E2oTU2lznCdtmADelD8s2S7IsO5/g+VHzZ7
         y7MZOHJO6coLdwmT7xNtml5WLuGixAAYHnlrZ+Ex6zCQUT4zg0WfAl2x5U5u5IoU9sQd
         QQ3pfn4/CU/atY0m/PIteuqpwSv/GzsdD0Khn5PvqvJf4H7Jj3HAwtVD9uDmBJ4iUpSY
         wpOtAACtnLZck6aHO2V1xEhLGvG12mVnln+eDdmW1N1RGDDmL+STJ5QavC1mRV3QtYhy
         BwcIUMTJZLeHYmZO0ptv5r56TOobcKurZ99GL7MmYCFrPzgcgqCEKNPqzPydHUPxZRy7
         F4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725914272; x=1726519072;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seNNgOYd+yOyVPoC1OLWCPYg4+Zlk5hIs7OYJde/eng=;
        b=ayDBHcFFpfp73rQMyPl+wRCwTX8PR7+Q+ZLiXcwchXp235idEeD5YXtZ2+1J2FRcDi
         9G1UH2PN8oIKHGiyvstle5ToTXByuLsKbdw49VevLSUNbmXtftOycFW/ME/BnZeyyaKo
         JvLtuxfuK7bn3FttJNUlWJAx1/JQ2DqMp5YipbdCG169wdJGIeHqO/amGkNow6gq7GlS
         Miem56G0t+piLF79r2jlt8c2ko3uuT4NgbVYaNcytUG00/vcr2wGjWoNR/zHIzyY/T44
         b1Lscd4ohFnvPW+UQHg2tvxdMgChxwhBO84fadvGOEFTDdpypc/K8MdP65Y2W17j7Ym+
         U85A==
X-Forwarded-Encrypted: i=1; AJvYcCWJHZreg9y3V+Yd7glJp6AuMCVpe+keDIQl+Ze5r5iuV8UUqdomKgs1sMmUtyvhzxuiRTFXUh7SHUTnpRLRD4Bm@vger.kernel.org
X-Gm-Message-State: AOJu0YyEv8IxWOVmyfeeBe3DTZ5sn+x1l3rzGI+LslAQ3BalFEtUp3sp
	OjhKo5+kTDoH0kO3Q23CAE/Z7Suh152be775zCyI5o9s8Mslyy7UT2GsB4Z/O8tjMxCGRVj9gJD
	B9HeyVQ==
X-Google-Smtp-Source: AGHT+IFRBqcIA/UKEfCNHcx4yJDQCt0HfpV4MJhN7slNa5TRF1tb1g+qjA9LwMlX6igzKJbD8DS0ZpMxkUpD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b7b9:f9a0:1197:ff33])
 (user=irogers job=sendgmr) by 2002:a25:d884:0:b0:e11:5807:1072 with SMTP id
 3f1490d57ef6-e1d34a32110mr21878276.8.1725914271660; Mon, 09 Sep 2024 13:37:51
 -0700 (PDT)
Date: Mon,  9 Sep 2024 13:37:38 -0700
In-Reply-To: <20240909203740.143492-1-irogers@google.com>
Message-Id: <20240909203740.143492-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240909203740.143492-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Subject: [PATCH v2 2/4] perf inject: Add new mmap2-buildid-all option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Casey Chen <cachen@purestorage.com>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add an option that allows all mmap or mmap2 events to be rewritten as
mmap2 events with build IDs. This is similar to the existing
-b/--build-ids and --buildid-all options except instead of adding a
build_id event an existing mmap/mmap2 event is used as a template and
a new mmap2 event synthesized from it. As mmap2 events are typical
this avoids the insertion of build_id events.

Add test coverage to the pipe test.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c         | 88 ++++++++++++++++++++++++++++-
 tools/perf/tests/shell/pipe_test.sh |  1 +
 tools/perf/util/synthetic-events.c  | 57 +++++++++++++++++++
 tools/perf/util/synthetic-events.h  | 11 ++++
 4 files changed, 154 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 24470c57527d..5a27fa46e93d 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -107,6 +107,7 @@ enum build_id_rewrite_style {
 	BID_RWS__NONE = 0,
 	BID_RWS__INJECT_HEADER_LAZY,
 	BID_RWS__INJECT_HEADER_ALL,
+	BID_RWS__MMAP2_BUILDID_ALL,
 };
 
 struct perf_inject {
@@ -146,6 +147,16 @@ static int tool__inject_build_id(const struct perf_tool *tool,
 				 __u16 misc,
 				 const char *filename,
 				 struct dso *dso, u32 flags);
+static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
+				      struct perf_sample *sample,
+				      struct machine *machine,
+				      const struct evsel *evsel,
+				      __u16 misc,
+				      __u32 pid, __u32 tid,
+				      __u64 start, __u64 len, __u64 pgoff,
+				      struct dso *dso,
+				      __u32 prot, __u32 flags,
+				      const char *filename);
 
 static int output_bytes(struct perf_inject *inject, void *buf, size_t sz)
 {
@@ -161,6 +172,7 @@ static int output_bytes(struct perf_inject *inject, void *buf, size_t sz)
 
 static int perf_event__repipe_synth(const struct perf_tool *tool,
 				    union perf_event *event)
+
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject,
 						  tool);
@@ -454,7 +466,9 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 					  union perf_event *event,
 					  struct perf_sample *sample,
 					  struct machine *machine,
-					  __u32 pid, __u32 tid, __u32 flags,
+					  __u32 pid, __u32 tid,
+					  __u64 start, __u64 len, __u64 pgoff,
+					  __u32 flags, __u32 prot,
 					  const char *filename,
 					  const struct dso_id *dso_id,
 					  int (*perf_event_process)(const struct perf_tool *tool,
@@ -525,6 +539,26 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 			return err;
 		}
 	}
+	if ((inject->build_id_style == BID_RWS__MMAP2_BUILDID_ALL) &&
+	    !(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)) {
+		struct evsel *evsel = evlist__event2evsel(inject->session->evlist, event);
+
+		if (evsel && !dso_sought) {
+			dso = findnew_dso(pid, tid, filename, dso_id, machine);
+			dso_sought = true;
+		}
+		if (evsel && dso &&
+		    !tool__inject_mmap2_build_id(tool, sample, machine, evsel,
+						 sample->cpumode | PERF_RECORD_MISC_MMAP_BUILD_ID,
+						 pid, tid, start, len, pgoff,
+						 dso,
+						 prot, flags,
+						 filename)) {
+			/* Injected mmap2 so no need to repipe. */
+			dso__put(dso);
+			return 0;
+		}
+	}
 	dso__put(dso);
 	return perf_event__repipe(tool, event, sample, machine);
 }
@@ -536,7 +570,9 @@ static int perf_event__repipe_mmap(const struct perf_tool *tool,
 {
 	return perf_event__repipe_common_mmap(
 		tool, event, sample, machine,
-		event->mmap.pid, event->mmap.tid, /*flags=*/0,
+		event->mmap.pid, event->mmap.tid,
+		event->mmap.start, event->mmap.len, event->mmap.pgoff,
+		/*flags=*/0, PROT_EXEC,
 		event->mmap.filename, /*dso_id=*/NULL,
 		perf_event__process_mmap);
 }
@@ -559,7 +595,9 @@ static int perf_event__repipe_mmap2(const struct perf_tool *tool,
 
 	return perf_event__repipe_common_mmap(
 		tool, event, sample, machine,
-		event->mmap2.pid, event->mmap2.tid, event->mmap2.flags,
+		event->mmap2.pid, event->mmap2.tid,
+		event->mmap2.start, event->mmap2.len, event->mmap2.pgoff,
+		event->mmap2.flags, event->mmap2.prot,
 		event->mmap2.filename, dso_id,
 		perf_event__process_mmap2);
 }
@@ -748,6 +786,45 @@ static int tool__inject_build_id(const struct perf_tool *tool,
 	return 0;
 }
 
+static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
+				       struct perf_sample *sample,
+				       struct machine *machine,
+				       const struct evsel *evsel,
+				       __u16 misc,
+				       __u32 pid, __u32 tid,
+				       __u64 start, __u64 len, __u64 pgoff,
+				       struct dso *dso,
+				       __u32 prot, __u32 flags,
+				       const char *filename)
+{
+	int err;
+
+	/* Return to repipe anonymous maps. */
+	if (is_anon_memory(filename) || flags & MAP_HUGETLB)
+		return 1;
+	if (is_no_dso_memory(filename))
+		return 1;
+
+	if (dso__read_build_id(dso)) {
+		pr_debug("no build_id found for %s\n", filename);
+		return -1;
+	}
+
+	err = perf_event__synthesize_mmap2_build_id(tool, sample, machine,
+						    perf_event__repipe,
+						    evsel,
+						    misc, pid, tid,
+						    start, len, pgoff,
+						    dso__bid(dso),
+						    prot, flags,
+						    filename);
+	if (err) {
+		pr_err("Can't synthesize build_id event for %s\n", filename);
+		return -1;
+	}
+	return 0;
+}
+
 static int mark_dso_hit(const struct perf_tool *tool,
 			struct perf_sample *sample,
 			struct machine *machine,
@@ -2261,12 +2338,15 @@ int cmd_inject(int argc, const char **argv)
 	const char *known_build_ids = NULL;
 	bool build_ids;
 	bool build_id_all;
+	bool mmap2_build_id_all;
 
 	struct option options[] = {
 		OPT_BOOLEAN('b', "build-ids", &build_ids,
 			    "Inject build-ids into the output stream"),
 		OPT_BOOLEAN(0, "buildid-all", &build_id_all,
 			    "Inject build-ids of all DSOs into the output stream"),
+		OPT_BOOLEAN(0, "mmap2-buildid-all", &mmap2_build_id_all,
+			    "Rewrite all mmap events as mmap2 events with build IDs"),
 		OPT_STRING(0, "known-build-ids", &known_build_ids,
 			   "buildid path [,buildid path...]",
 			   "build-ids to use for given paths"),
@@ -2363,6 +2443,8 @@ int cmd_inject(int argc, const char **argv)
 			return -1;
 		}
 	}
+	if (mmap2_build_id_all)
+		inject.build_id_style = BID_RWS__MMAP2_BUILDID_ALL;
 	if (build_ids)
 		inject.build_id_style = BID_RWS__INJECT_HEADER_LAZY;
 	if (build_id_all)
diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
index a3c94b4182c2..250574cd68b6 100755
--- a/tools/perf/tests/shell/pipe_test.sh
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -118,6 +118,7 @@ test_inject_bids() {
 test_record_report
 test_inject_bids -b
 test_inject_bids --buildid-all
+test_inject_bids --mmap2-buildid-all
 
 cleanup
 exit $err
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 6bb62e4e2d5d..a58444c4aed1 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2266,6 +2266,63 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 
 		ev.header.size += ret;
 	}
+
+	return process(tool, &ev, sample, machine);
+}
+
+int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
+					  struct perf_sample *sample,
+					  struct machine *machine,
+					  perf_event__handler_t process,
+					  const struct evsel *evsel,
+					  __u16 misc,
+					  __u32 pid, __u32 tid,
+					  __u64 start, __u64 len, __u64 pgoff,
+					  const struct build_id *bid,
+					  __u32 prot, __u32 flags,
+					  const char *filename)
+{
+	union perf_event ev;
+	size_t ev_len;
+	void *array;
+	int ret;
+
+	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + strlen(filename) + 1;
+	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
+
+	memset(&ev, 0, ev_len);
+
+	ev.mmap2.header.type = PERF_RECORD_MMAP2;
+	ev.mmap2.header.misc = misc | PERF_RECORD_MISC_MMAP_BUILD_ID;
+	ev.mmap2.header.size = ev_len;
+
+	ev.mmap2.pid = pid;
+	ev.mmap2.tid = tid;
+	ev.mmap2.start = start;
+	ev.mmap2.len = len;
+	ev.mmap2.pgoff = pgoff;
+
+	ev.mmap2.build_id_size = min(bid->size, sizeof(ev.mmap2.build_id));
+	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
+
+	ev.mmap2.prot = prot;
+	ev.mmap2.flags = flags;
+
+	memcpy(ev.mmap2.filename, filename, min(strlen(filename), sizeof(ev.mmap.filename)));
+
+	array = &ev;
+	array += ev.header.size;
+	ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
+	if (ret < 0)
+		return ret;
+
+	if (ret & 7) {
+		pr_err("Bad id sample size %d\n", ret);
+		return -EINVAL;
+	}
+
+	ev.header.size += ret;
+
 	return process(tool, &ev, sample, machine);
 }
 
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index 795bf3e18396..b9c936b5cfeb 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -54,6 +54,17 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 				    __u16 misc,
 				    const struct build_id *bid,
 				    const char *filename);
+int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
+					  struct perf_sample *sample,
+					  struct machine *machine,
+					  perf_event__handler_t process,
+					  const struct evsel *evsel,
+					  __u16 misc,
+					  __u32 pid, __u32 tid,
+					  __u64 start, __u64 len, __u64 pgoff,
+					  const struct build_id *bid,
+					  __u32 prot, __u32 flags,
+					  const char *filename);
 int perf_event__synthesize_cpu_map(const struct perf_tool *tool, const struct perf_cpu_map *cpus, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_event_update_cpus(const struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
 int perf_event__synthesize_event_update_name(const struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
-- 
2.46.0.598.g6f2099f65c-goog


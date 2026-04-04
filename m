Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F1533123D
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 03:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274247; cv=none; b=iw4Fm+J+bU2znEXRJFODnKvZ1wePAx/F1D/yTvbN613fmEgPuby/rqtVFEWIPWpVZg6DrQgOyWVUdIB13BQJwkR+Fx1jFBh1zf1BVQDfuX9bpqwPZJ3t7qOUQD9w59kiV7wqkvPz0DK85M0CLnrUFuKFl673XCFAeOBe73jl1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274247; c=relaxed/simple;
	bh=woVK730/m2g6PPS9x8P/giHxXs9+wVRn/ViMS/wmhlY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=trG/klvkJ94qdCGa92Ac+nYSxTB2FrA9U/Myu3ccwHwEm9xSlu795IKnYehE5XWaa9NCvqOjzSlgAL1ZmgSHj+SdTRQg1wLIs0sLyhvhwgkFEUJoonw5BRe0AHDLbzS+2R6e2cVsQR+x11DXWvuGpkt5A/t3z637Uw8aeOF1zGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AWhQsK/m; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWhQsK/m"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so15731918eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 20:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775274244; x=1775879044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rGBBXdpiWePuw/59wMcLGdfD0cYwMcREBloyciHzDuw=;
        b=AWhQsK/mRHqCyI8X2RwYETW1+HX49aHF/U6JrY22WlJJtoFtACxBcWGVdtbcPSMwko
         mF3Ix2t6I2xgDpeKtlkN3nEfLIXr1LJEkwSLyChUGvz9A9x5gOda/qxxuG90auGl9o5k
         EBuSWplk/vJn5GnhBWJdBRGclEstiVowR/a60B0u/N5YMs+lDcoXTSk1OPwp2v+e04bE
         kt9up9fKYodS6hBLyn+TVVXJNISokBdy0YiCb15lDz+s11XD6pBpIxGv6IIJWcYHsEmX
         fCv+Ttf5YpnSGOjvdQV8pTvFjJrwMMG5z/y6JrlUbI0IEsETFYty9u2HjtujOSo5U9Ip
         /8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775274244; x=1775879044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGBBXdpiWePuw/59wMcLGdfD0cYwMcREBloyciHzDuw=;
        b=JhozR5dhZB3qBf7Tw/bbAgQAuNMdywPP/nUd5yCT207DO5q4N3fqA8r+9VwcvftDfR
         hQkncNms8KfmvFCNMYfpGri7dzo2Re/kwvlZuBQTEezLDqFQV2U5ClXX8RoEtNUDUPDM
         Yz4ux2RZgT4dCqrr/9QR1WptGLiIusgm0/jH9Qng6KHMRAXtpRJmpNTv3rqEDF0rHucR
         bAgAelp2VdTzyl6LiSMa7i5tpf4KF3/M6rXUEfmIuP8IJT1ZUximD5DT0GulAC2HNECL
         /TOrHydfnpmD7WlitLpIRISkxtUDXmNFR0yHAM7xjfJCzo+CBwO8T1SEPYXjlCZ5Y/RC
         Qdsg==
X-Forwarded-Encrypted: i=1; AJvYcCUhXA469uqom5Snt6Fnaflzl8IrB/PSrXz2Zbiyy6DMqFClfVVChrI1ksFSUxYMsRRNM7M8G20lp1kb4ewces6e@vger.kernel.org
X-Gm-Message-State: AOJu0YyERtFMtQNBSMB0YF6e7k+Kuf2xUW/AcaPuqtDqCRqCWRJJZb8N
	DdEXhiXKSG7DYuhRVDb5w9yoyeWeIa8Y8ujl8obavFUFrIPyFFloej7iACXpv8aBxoloKfPEqMC
	cyFPOugYRAQ==
X-Received: from dyckg5.prod.google.com ([2002:a05:7301:d185:b0:2c1:264d:62f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5793:b0:2b0:571a:28a5
 with SMTP id 5a478bee46e88-2cbfba8dc09mr2640946eec.18.1775274244057; Fri, 03
 Apr 2026 20:44:04 -0700 (PDT)
Date: Fri,  3 Apr 2026 20:43:12 -0700
In-Reply-To: <20260404034325.3172592-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404034325.3172592-13-irogers@google.com>
Subject: [PATCH v6 12/25] perf db-export: Remove evsel from struct export_sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

As the sample contains the evsel avoid the duplication. Remove the
evsel from db_export__sample as it can also read from the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/db-export.c                            | 5 ++---
 tools/perf/util/db-export.h                            | 3 +--
 tools/perf/util/scripting-engines/trace-event-python.c | 8 ++++----
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index a1f578c3a8d5..fdfd825c7ef4 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -345,14 +345,13 @@ static int db_export__threads(struct db_export *dbe, struct thread *thread,
 }
 
 int db_export__sample(struct db_export *dbe, union perf_event *event,
-		      struct perf_sample *sample, struct evsel *evsel,
+		      struct perf_sample *sample,
 		      struct addr_location *al, struct addr_location *addr_al)
 {
 	struct thread *thread = al->thread;
 	struct export_sample es = {
 		.event = event,
 		.sample = sample,
-		.evsel = evsel,
 		.al = al,
 	};
 	struct thread *main_thread;
@@ -365,7 +364,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	if (!machine)
 		return -1;
 
-	err = db_export__evsel(dbe, evsel);
+	err = db_export__evsel(dbe, sample->evsel);
 	if (err)
 		return err;
 
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 23983cb35706..1abbfd398e3a 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -25,7 +25,6 @@ struct call_return;
 struct export_sample {
 	union perf_event	*event;
 	struct perf_sample	*sample;
-	struct evsel		*evsel;
 	struct addr_location	*al;
 	u64			db_id;
 	u64			comm_db_id;
@@ -96,7 +95,7 @@ int db_export__symbol(struct db_export *dbe, struct symbol *sym,
 int db_export__branch_type(struct db_export *dbe, u32 branch_type,
 			   const char *name);
 int db_export__sample(struct db_export *dbe, union perf_event *event,
-		      struct perf_sample *sample, struct evsel *evsel,
+		      struct perf_sample *sample,
 		      struct addr_location *al, struct addr_location *addr_al);
 
 int db_export__branch_types(struct db_export *dbe);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 1537122167d5..9e1069ec0578 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1312,7 +1312,7 @@ static void python_export_sample_table(struct db_export *dbe,
 	t = tuple_new(28);
 
 	tuple_set_d64(t, 0, es->db_id);
-	tuple_set_d64(t, 1, es->evsel->db_id);
+	tuple_set_d64(t, 1, es->sample->evsel->db_id);
 	tuple_set_d64(t, 2, maps__machine(thread__maps(es->al->thread))->db_id);
 	tuple_set_d64(t, 3, thread__db_id(es->al->thread));
 	tuple_set_d64(t, 4, es->comm_db_id);
@@ -1353,7 +1353,7 @@ static void python_export_synth(struct db_export *dbe, struct export_sample *es)
 	t = tuple_new(3);
 
 	tuple_set_d64(t, 0, es->db_id);
-	tuple_set_d64(t, 1, es->evsel->core.attr.config);
+	tuple_set_d64(t, 1, es->sample->evsel->core.attr.config);
 	tuple_set_bytes(t, 2, es->sample->raw_data, es->sample->raw_size);
 
 	call_object(tables->synth_handler, t, "synth_data");
@@ -1368,7 +1368,7 @@ static int python_export_sample(struct db_export *dbe,
 
 	python_export_sample_table(dbe, es);
 
-	if (es->evsel->core.attr.type == PERF_TYPE_SYNTH && tables->synth_handler)
+	if (es->sample->evsel->core.attr.type == PERF_TYPE_SYNTH && tables->synth_handler)
 		python_export_synth(dbe, es);
 
 	return 0;
@@ -1517,7 +1517,7 @@ static void python_process_event(union perf_event *event,
 	/* Reserve for future process_hw/sw/raw APIs */
 	default:
 		if (tables->db_export_mode)
-			db_export__sample(&tables->dbe, event, sample, evsel, al, addr_al);
+			db_export__sample(&tables->dbe, event, sample, al, addr_al);
 		else
 			python_process_general_event(sample, evsel, al, addr_al);
 	}
-- 
2.53.0.1213.gd9a14994de-goog


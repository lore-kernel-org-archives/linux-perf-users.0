Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CAA3FB064
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034911; cv=none; b=QznCJJkOdtO3nMWiHEW6Gc3aXLyOcv+vaarGyoE04jr5qn86AxTJyviLMGoinPglOTuHW0KDwRZBw5P//MGoJADwkaVTRF1Efm33uJmLMi+ViI7wRT6ReW4OS9BC1j9o89bp42pQ0Ofuw1gCMb+iCm0+ylrHf0JIRjJSel+fbWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034911; c=relaxed/simple;
	bh=tSip01469jrvhlPU1rMawpxwCK1neIL6tVl016usvGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NUYska0xgexT5BB9ao8uuNkJmc9C6KXpRpd3IkR9174aMjGLcdwvgYYgdDLqAVAxyGpvmLdYcQL/UiiY9adWMEfjES5kh1UFB3I7L4XObc1BfoauCaRl2Ok3FKLp58/84mnW+aM9wgqMUMhkQE//wNL6bGC/niXHqhV/tqTWzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPfws/Oh; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPfws/Oh"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12776bebeb3so34373204c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034907; x=1774639707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0A77l9BiErq54VrV3SpgYee5+o3mpUP2uJ5Hd4lHjyw=;
        b=gPfws/OhKEmjquesvA6ImVaRkugOOxjXgTTscNSSQ+xewB18gYQuD7hbcCUHfN2fvL
         z+jioE5kmeEBHNx4Ean/hbCQ9RqF3mdCN9UIU1h9ZcarPdvwJbdAs3QqQT7mPCDiY1Sm
         +BlWHJEKOtbxjOJv8I6BlAZLBCRb+AwnmZjI6Q5ygIcq8MXeMRHwcjwoSUw8l34z5Ap4
         B+n5dgm8SB/VEI6LHlsQ4Uk4FSVtAv/ky1iCqwrqkvvRuBvrexeESj3FJAAZ1NoW4NhO
         zHyZHsTFB+CVCidfTbkSbWxdqysufFdZdeUon+XJYq5dSIqVFRF0S7epbRujhcZ2QkLR
         yXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034907; x=1774639707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0A77l9BiErq54VrV3SpgYee5+o3mpUP2uJ5Hd4lHjyw=;
        b=khYQQBgw/nZiwQ/bk7vjy+l1VQfymHXFWzyayQYkWBogAL/iLJTQ00l779W6X71bM1
         FZ3mu7uldJeOjP7NKV1PWnylbuE7/xel1NdNltg4/ndw2lDhZPtcGEOyo7tRonqD0kRH
         rkBWlHesT9UDbU04i3rkQUmN3poAJ3loGJYA/8Xt5UAp11tgqPEdZ9t6hmCiq6tBVvs4
         nFR+WfTaoVFNuEQ4TfFMyz2IkNFuG7dUVF6R/fmT967DqjyQvN/cZjSFhqQsq690ldRk
         6OlRw1doir7C+KDYMIhah5756lGnXw8tSyd87qbbq/GMrm0AyCeQKIgUcCJaegmRKKR+
         lbOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFODCS7HJShwdL0/w8SVHX+3q8fLKSqky4mf53VyQ3P20RkCw3HkLxPWF+S1OVxEhkKp7WG8U5gnzNHz6RSAWW@vger.kernel.org
X-Gm-Message-State: AOJu0YwbBr4urQBflbPpDiRRV35WiF3YPTWNLxOQY0Zj8M04F35T3nX2
	Vi7CBXbfDtiqvkL79vxIvYSvDPkxbVz93chqysIibFEvWUpV6BCZ+v9cwZXgEQR4Ogt+KlBtAh9
	XSd/lK+gUzA==
X-Received: from dycao1.prod.google.com ([2002:a05:7301:7d01:b0:2c1:113a:5c84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4442:b0:2c1:564:7116
 with SMTP id 5a478bee46e88-2c109752b2dmr2217246eec.20.1774034906404; Fri, 20
 Mar 2026 12:28:26 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:14 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-13-irogers@google.com>
Subject: [PATCH v4 12/25] perf db-export: Remove evsel from struct export_sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
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
index 08197cef44c8..8de08cebe240 100644
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
2.53.0.959.g497ff81fa9-goog


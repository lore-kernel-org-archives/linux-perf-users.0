Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F4340A6B
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303961; cv=none; b=U1X0umamxj/YIxQFGfTO0VwVoEbmHXGJZAVIAY8gOdJFX6jUIOWBb7ma8iCqt5t3EnqlyIzfxD09ukS8AKAU9xp4PswhEv/fauzL03Ddnb8vFLGJJ7lINbv3T8wGv079QFeslOs+4/gEoO1AAN9P4wj/dmezAuNW7ITkBw7TLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303961; c=relaxed/simple;
	bh=Ckuv+sto6OsSGmHySigPKeUkcuTr9QXKl5kzs19HQGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OXg6ycvgKehmApwZ3LSJjg8eJ9eX4mvcKP4BPi/QyUJhJDlKlH8BK/Vb15yJCkpL+x9U1zWkviXTEYXboEwR2Y3BQDRlUNYLXMjERCBjMY0hPn4CysCOcxa+we8nxCDM+uBQat6qAfommLTuheyirsHO9xL4XOK5YODw90V00Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FHJNsiyM; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHJNsiyM"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13537722193so5205648c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303959; x=1779908759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd81IAA6Y2N94BN0DboklBqNs0x2u1tGGwFmFRe/xcw=;
        b=FHJNsiyMWsUGXJfjcXOFpu9IeHhcDeblfruedpU/XicAFNTtwFR+EKcAcF0sKe3fnJ
         HNneVSjxCoJrlWpZnIKjirEEiVV3I8zbR5Y/WeAC5fbWpY2GAO0xhwMaK1VwuxzMRJbh
         aE5snjJfrD080OtZ3JwxC1wbLYP1keHm4ZH/gCOLT8CdRUVvY5Bw9U8w/GU7+E/aFQj1
         RPMvLvPuH+lzMxv+5BoWVRlXI4bZWSQPXjF/v2OS2NhkoHnl7GvsuWeyTWCxNamaXv4O
         Do5hm9GJwlLzwNzdotPf2UU+2LMqONtKTC7Gm0OY5mUgmXlFeyAOfVBmHHzJxEqeYSDY
         eyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303959; x=1779908759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd81IAA6Y2N94BN0DboklBqNs0x2u1tGGwFmFRe/xcw=;
        b=IJRfhW5NWXAqVHdn7z9SRQvsZVng6+UvCNAUlpGVezUcOlSMdNaQulwUm60nT6eO28
         CkAnZwfX2SQmkaBhMH2iUDUh8L4s2+CUDXhOv+2G5SC7s2G2H692wYFyZUjVqB9epSgu
         kB1Ldzc+REzuaHg1/5hAIDCOJQ5/A1HU3EpLL/HG/ImR2T9ozxbHD3u0/ihzSNxyk1Wq
         7PFUrIARkBws2LsuSVuFQhKfqXtnxXNqjzJdHCICz1pqnOvGUrz+XIW2Nmo8obgkIrTm
         1CafqmpnoRvRFGGRvL0A/XW7zUjuncZQ8XZ+xduf+uT4KOw6E9sgPnJ6Coa1kgQRp4cv
         CqFw==
X-Forwarded-Encrypted: i=1; AFNElJ8KTB4dfakcs6XQNIrzf99O0KuLNC75AHlVlu0mn0suOScy9Tz8OoXMFNQNHQ/5+4BAHT9Qc4Ox1r6vaWfwaXvd@vger.kernel.org
X-Gm-Message-State: AOJu0YzK8tvR4LpQnpTpLo5YxtXgKjIFIxPTQCpquiOrUZtinNtX21N/
	l2ErPODD7i2sqnDJVFf9XfgeL54bU9MQmxMfc4C9omeF+e6AaOTHKuSusUHKE0Yg9FZEG/kSheA
	LcirYtx+5Dg==
X-Received: from dlai21.prod.google.com ([2002:a05:701b:2715:b0:132:9fc5:59aa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ff42:b0:134:cbed:2b35
 with SMTP id a92af1059eb24-13504517534mr11510313c88.18.1779303958803; Wed, 20
 May 2026 12:05:58 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:14 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-9-irogers@google.com>
Subject: [PATCH v14 08/32] perf db-export: Remove evsel from struct export_sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

As struct perf_sample now directly contains its own resolved evsel pointer,
passing the evsel separately is redundant and clutters the interface.

Remove the redundant evsel parameter from db-export-specific handlers and
structures, ensuring the tool always directly accesses the evsel bound to the
sample. This simplifies the API signatures and eliminates the risk of passing
an inconsistent evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/db-export.c                            | 5 ++---
 tools/perf/util/db-export.h                            | 3 +--
 tools/perf/util/scripting-engines/trace-event-python.c | 8 ++++----
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index d991e3168aed..ba54b1119ee6 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -344,14 +344,13 @@ static int db_export__threads(struct db_export *dbe, struct thread *thread,
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
@@ -364,7 +363,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
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
2.54.0.746.g67dd491aae-goog


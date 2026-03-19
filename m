Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3463FA5D2
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962669; cv=none; b=Sn/niE3qb8quh8RjUak0YH5NTKjvHYPU41Y6dtEtjXM/s9Enk/nhpCl3eEW7AeTKBvMykN/StpgyCwiEkemxiSWXu6SOmJcjBvW97OsWzaFYB/nncjtSa3QqovtT4zjvL/jHTD2XffKN0RZigNk0LXuBJmANxUblUHKAH3G91YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962669; c=relaxed/simple;
	bh=f5KwYWz1HjZ4yRvLyCRtzSLGeh2v7q8Q8KZbKJVjmbw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s8NDqBiCyMdDf+hGOnULraW6WPMrXYYRNWskEEZ3SG37ZorZBmEnlJdH7x3JMr/Fnd7tDpgzDLd+TRQ8p21E9evrSwS2lNa6Mi7MJ2n4yEJrZIgKYKC8+2k51QFtSh37MlDalPHe8XRR21gN5PHi6/eRlVsIaFaILyD9N0fZeOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VopVlkXS; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VopVlkXS"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so99759eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962668; x=1774567468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNmNW7mDn0ItCOOXElmd/MI6vY7MqoQwVcMfL6AVXpo=;
        b=VopVlkXS0uVuJhZsqcIlmZUzWcGh/7kVRKS7Ejw1WZq5ZJLthqeed81K3x4pNSS3lN
         WXpWgAm8Nd0qEw4gXZzRf2v9hmWUWLjMrfOe26Fu9PGi+CSTlbUgb/3QAMoBB/qgFHaP
         llPvV2dkthkDr70fzMdJgDoErtKSzUkApt+Saq1bJ1gnFltko9uSK5srTAVdulmXZZDz
         7pmYXcFeel2m9h0YhtGzLUMC3VuZbsVgST99iyAZGv9VLtVSzKzFLFgMA3sYQgXW6Nix
         6+UZB4jRBj2Eq+jJ0PZO5A7HPA0n6NJOslqEtfY/OXO653L0vI1AeOb8zxMozBODb4VN
         qlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962668; x=1774567468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNmNW7mDn0ItCOOXElmd/MI6vY7MqoQwVcMfL6AVXpo=;
        b=gFM1ad7xsYHMH1I+SNavNDQ/ARNBGNoOV60PeKF6ARWP2QufuezE4I2oyqjv0iP2YH
         go//xHSf6w3EtlM4rpyouJzdV/DPMBE6XnDXtKSOPIQNQpNB751xZbioH4wkfP4aO5wB
         jrwLjvD4oU2tHYcMNQUPkQw56ACa780QStQs45PFw5KL5uTup+QNjReWC17imLgYPlqy
         4c0eqz2VljO69GoywYNoxFVjpPGVxCtnaI5XKkty2cNrDL1pNbVqUw+cclGlL72iTlgF
         Ovaj/zKVqkS1xTnfUGRLceg+Wp62dcARGcwWx4Z9Q7yxN36skLNBxj1RpYUMjWWsrrWl
         vz8g==
X-Forwarded-Encrypted: i=1; AJvYcCUa1Qfg7k5Jeb3GPZYFL9DsiFf8nAoRjQ5MGxNntxxjipQBVP1C/9jD7XvB5CyqXVQHFwcczuAbq13HrZAqmj5P@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/AwwKsB+Gln+W0Y+60OZVUNiQpK7EUNEf8lxzmd2L+zZC97iO
	ybUouLC149vHQXRbIse9yLoI2HGE2QjOSB03BvZVMD/fhvqQ5I3H9ovD2L7xMU1eP/+DFA63MaV
	1n+po/4x80g==
X-Received: from dybmi40.prod.google.com ([2002:a05:7301:fa8:b0:2c1:6e8:4733])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2f8a:b0:2c0:c152:ecc7
 with SMTP id 5a478bee46e88-2c1096d57e7mr709411eec.16.1773962667579; Thu, 19
 Mar 2026 16:24:27 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:21 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-13-irogers@google.com>
Subject: [PATCH v2 12/25] perf db-export: Remove evsel from struct export_sample
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
index 0d8665c75d30..9f5c6e5e6ebe 100644
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


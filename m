Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78CD37D110
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053545; cv=none; b=Zj4hkRjKgGAP5x5vDPBE9mqfAvdVWcj9atGQ7uk9MgpKaX3khsKRivGUiAPqtxAXqcujhxfwVnKNn3BLav3fepNXcNWNwCM28P5L+DXhB+1Jf1HEnqeeOIU6GadXcRWUYLgThRDFqjtwgWV/26c340w4QgM7+a3jrMLkz5OiWd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053545; c=relaxed/simple;
	bh=zocEQ15pqhkgaBM7JLqkF/pDJjGAt5zDiwcYu+1pxdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u6XxzV+tF7Ebx68J+AgQDfVzK1GzU3pmjo5J4IL384H3oAEIrLMrAHrn58eCnLHl98JVTeSZZD7LRB2VdKo7d0CtTBuyir/mqB05xMmXEOodnu1nPAw1VUGgKoiOiFEz7jbG52/1tCYhCfzMXRpD1nDXVOYPToKviWPTq1wy334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JDmPOJgC; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JDmPOJgC"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c20a91932so7882963c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053538; x=1776658338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFmOnjJwpBpu0n7wKSDPl2Bef0Eg6yPkVeQqUwZtmi0=;
        b=JDmPOJgCa3nowCAwQQkVZcLuzGP5A3EJtoJHGFX/pqzVDJOb9TVegnlFTDbguGnk1Y
         SJLTo8Pr2eT9qgkvMvF7nxNHF22kmu3XfC5Y56JPSN/VDV/QzZ8XvhJFxfhj9NQkhZCl
         celzE1cLXN+D7GnxFQ6Ddpp4c7IzfChuH8sthwn6GD9Xa2cKTEkmwEeJyt/NqDmI04hW
         FzepZR/KvlMWLZlaoSI7JGe1bamPu3/K6HQ5YSZsj6auyEF5hHZF/6B5N1WhfsZz2hR4
         ErJ5K7pkS5PBv32QEPamKivnMtgLHRjejICJoPJY3ruWi/8ZnQOzzQmB4HL+ofS643nN
         vP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053538; x=1776658338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFmOnjJwpBpu0n7wKSDPl2Bef0Eg6yPkVeQqUwZtmi0=;
        b=rPgYVtDIPhRc3Bx1jbV4xRvxAWszf2jA6LU4nH1Q0pggdNJ6GqDfszTUrkMQ99Suid
         1sobeM7vdSK07qoL489/L69/bMEfhufXGcXkMDJnWcsZ60sAHNsZmndGHefEaOoitkfy
         y8xMtdrbSYXnDghxpTtPZE9fYKu0+ZkqTsm+tgvDblVULXUbBcdZy009c1yDIxYS43kB
         5V3djRV/vHDFV8dGXqOMG+VRsVswrmAbvcdB4Mt+Hpf04bIY8oQ5WNzWS3a03Z17nP55
         yvZi3RbBfIGRUQD2k1rexHR+qluxtEcTIZ98wmINK7NXJZtMx5ax9l90f2mOG19JScfq
         Z8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCURU/Iedfq6VOjEjtnrKdM09cBkW23wyyq4zUZd4s/bULMJnnXxOZkfTTALTKCyATfglhAgdcI7BGR8A5O7ZCnN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4ZmlDMDxoTLwKJQIWtxBFFlUCdn3EafHET43wEgY7ZO9r7L6
	T+QukMWPuj0ikro1s3ZALZAgyxI7WO9zQR4bd3aT3Z+jvS8Xsi8Ct1ros2Su+W/Hz/I8rhZYRTS
	7FOZY6eXKpA==
X-Received: from dlbsn14.prod.google.com ([2002:a05:7022:b90e:b0:12a:7f44:d2e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2205:b0:12a:7181:2f1c
 with SMTP id a92af1059eb24-12c34ecf751mr4257950c88.17.1776053537574; Sun, 12
 Apr 2026 21:12:17 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:19 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-10-irogers@google.com>
Subject: [PATCH v12 09/33] perf db-export: Remove evsel from struct export_sample
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
2.53.0.1213.gd9a14994de-goog


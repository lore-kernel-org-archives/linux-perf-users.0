Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C2532B9B5
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890671; cv=none; b=SrbHQ8taoQAiE0WRsUk3q5PaNLvK+Z2wh+4rjwCNDSl7pGHiWu192+tH0bBGWeWiQM7I/SzlBpT8KrsnxG2kBHeSZm8l4hQ+YFvRPSpd0R8PStqipXWf3aqxznorpvjWidQR69f4HNPUfHtK7YqF9NjM+CIVjNtrqtWgihMOMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890671; c=relaxed/simple;
	bh=zocEQ15pqhkgaBM7JLqkF/pDJjGAt5zDiwcYu+1pxdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZKgwE99VtnDe9H3VDZV4rwPwOwkepor3Xlqbu201OcVuufAmnzijdcwPsNrs+/Zspc/eEf2CKjUPNTU+C+X3msRb8NBiuW6meuqzxF8HesF21fhYoznRQzR/mA1QPVkmSlscVFAKVNB1eM9CeJuGnrN+VSAqQ3/QWwgBv1/jFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUUZ+j5c; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUUZ+j5c"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d443c3b094so5363977eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890665; x=1776495465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFmOnjJwpBpu0n7wKSDPl2Bef0Eg6yPkVeQqUwZtmi0=;
        b=LUUZ+j5cjm+B0KYgyTJnXPeyc1ZJM+KYA1QnWI0NoZqflCDsouWjaha3Nl3H4qZtqz
         pwX44zG+x3i+KSS2feZb0L0H93wXDd8Usxa2mVJRrQ2vR+G2ul9wHRrqM9Jt/H+5z+ZN
         4xG5eg3I+8t4He6mcX2DVWyCdkLQxQdhERsDe4GXF3lBTleD6zfZaqBAFDVoHZGCx7io
         taP9IbA31HrzKCVnvfoGWk31SENQwYk6L2ZATj59uy0x9FTiwwc1SMW/Ec0uP1k9JG8u
         PPO0fEeqPxrzgEo4ah3/VPVWxuz4s8p0xemIC3I3Ol5syy4ijTzjqguI453YF29+DPwF
         TymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890665; x=1776495465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFmOnjJwpBpu0n7wKSDPl2Bef0Eg6yPkVeQqUwZtmi0=;
        b=FmMe3OzugpCJfG3ICCrOBdLBTy7QWEJ2kP9pZsLkpijH+pB7f0y74Cuk0TSa36nPh6
         lM85pp+VqRSU1f2xi17a8fYn0LXzKEPq018Bjvm/wkZYuhMg99cTkGTAN6bdXKaW7+14
         0TC9Tz3Vlfto6AAC1Vam7kVOq3XrNyflbLkZnYWW9GmgAL3fEW7Wu7LzKTsYaEZuSqjW
         pyeb0jr7uW1FzjlNB8FtYBE2WboMjFkdJAizvAqIFKkHPJ+r0hMQwnt0OnvczsTFt5bl
         QWsepyaY7INcz2snpHP2WNxE/r/IvkyQYwFBapxpO95ueqkSIzbo6rieuVtXYuIL68++
         8CzA==
X-Forwarded-Encrypted: i=1; AJvYcCWZFTE0avAAQiSTaYi+U7xZ4PxOwnEYOLaYENZg7BoAY4TItm1EJUNheTlK6AT4hf2EDxNMIWlLdyYGmYGbB/uZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyRudrPcnU1VkwpmCPM15jiEO6CbGsNiGUS34XUpZU/e9vftY/c
	+3eP201I4d/5DtQ8PfY03+FvZqNBEyRWfic5t9YnedZGw3gdkwVvsu0O4y3kWFedlHE/JILSKIR
	YWmIZARce1w==
X-Received: from dydb11.prod.google.com ([2002:a05:7300:80cb:b0:2d1:8f27:d6ee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4586:b0:2cb:da49:7e54
 with SMTP id 5a478bee46e88-2d58638114cmr2918747eec.3.1775890664705; Fri, 10
 Apr 2026 23:57:44 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:56:59 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-11-irogers@google.com>
Subject: [PATCH v8 10/29] perf db-export: Remove evsel from struct export_sample
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


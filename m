Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90FF3AA514
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248854; cv=none; b=iRZQOyKz3oPK3RbtuTM4CHF+os+DVxcgLq6RxN91nLWzLlEAPKHiOzsaX0l5Tpyvr9hTQhObfrVvNqXlNFzEanla6zIoO/C3N9Ex1WJ6sf/bmZOc9LwZG9MCBPwtU53JycEbY2y9gWXgB0EVP6VXdG6LZgJV85FTV4NQHOPegBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248854; c=relaxed/simple;
	bh=KHhk7nT7s6uEMm9uxAq5Q1qjs0+1hn9hTiDZ90j2BXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qytRL2Mr9FGAhcM2/lxBU1/s+a+4ONDm/fJgK20TtKMsAdHGCZWvO2yX+CrZB1Xk7Jr5WvCwGcxCXuEOalHXvzq4ikHNEX3oHAbFTdOJ5WNRoVldpd+a4WcvawqmyC9LijP14XfX/TCkCRA8DQQQjp0TXFHp6wTP69OUje9DHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pNzU097+; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNzU097+"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c3b8880ca9so2847583eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248852; x=1775853652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdh3bDJf8eAerq7vruCDhEmsabGX5J8RipWgz2KyKOg=;
        b=pNzU097+FK+28pRtazT7JZ9v5N7d8/CTiuyuKoVHL9Otp83dwoyqe1MrciKfHg8Hum
         UGXEOXwq0iMoIESEdu8zWbxFbowwTDT5Ck5QrUPHoyqhy2EF7iIcmkANCDQYgXh0JHOI
         fFB5gfdDfmgasVUiUgn68x5LP0Hg5CXxEHLZ9/ws8EHskt1BcD5vgTWJj+jyijUVXV9x
         ySkPDrl036vbsU4CV7KRma1DcKKndpL3EnmPlygf1L9nZT01YZdpMkwCN1ALjbbkodb7
         T7ecmJBDAkhPAP1WISv+vXmjdzdQu/4DvNIyrGBjQMDlJFhzCPga4xk8Xgtdy7GwdPx8
         zQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248852; x=1775853652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdh3bDJf8eAerq7vruCDhEmsabGX5J8RipWgz2KyKOg=;
        b=oNRzFyTEkKSCWS0f0ZHx6RcJgYDS/wYlRVfQZ3QTkSpJbpCC3IQCMZ5I1nLxXujCmt
         ZF90hxN9NPmSthCM1EaVKPcwSHnSnh1j3956CUrggmkvFl5yTHogUBm1AaJrakH4Y+0t
         n9szMGBUFfOIaJb+smvbHFFR40rDiPerYlthKmrE7hcRTS/DGpQoNf0+J5ExTFtd2Y4C
         WZKFBZrg+gZ1D+qJXtwl4YwDojS6Htuc0k8EEF3JO5jPChQ0/wwfkAK372gOaZOVaNSl
         He9Qa03fEBCwhjNS3R2A95KD5cNcgvD2dER/zzBCq7O/oN027O1J0yJpMDYcYwRs19GZ
         5tbw==
X-Forwarded-Encrypted: i=1; AJvYcCXK7CLnlUITadFsiGWnrMkZSGfJZZnGjTaz7LU7XtpIigg/OOdNpsCYyhOfXzVpMKBgOwNBTnSav/xvRt6FTKGt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vGczAKA7qkDYqcFM/M3pFc9N64xEY2uSVLgc4Y7t6pnhs6UD
	7IkragkR4iHBVGL1et0Rj34Q2w1TJ2YVBg096BxY0pOXCs6ocRzCSXwY/B8Bpdsq+kwLUPTeQTP
	MqtXVEzMT7w==
X-Received: from dycoh2.prod.google.com ([2002:a05:7301:da02:b0:2c5:f8b4:33a3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3252:b0:2ba:964f:fa67
 with SMTP id 5a478bee46e88-2cbfbe7d5ebmr1842255eec.24.1775248851905; Fri, 03
 Apr 2026 13:40:51 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:04 -0700
In-Reply-To: <20260403204017.2919994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
 <20260403204017.2919994-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403204017.2919994-13-irogers@google.com>
Subject: [PATCH v5 12/25] perf db-export: Remove evsel from struct export_sample
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
2.53.0.1213.gd9a14994de-goog


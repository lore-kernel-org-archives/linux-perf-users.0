Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E338A713
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658869; cv=none; b=W7kCVzdWWKG3GpDku5z1gOGsGKyu5LD6EgSKtnAkpsyF28tn6hZ0wzcTYhcWGXtGLsGXPxrD/hZxpHvdlGPImhewdDUzXf21rpEoZA13GZcaVbb7REEnS/h/m0KrYoRYNBjtzDRLEZXn7zoTvMxZC7NiGr+EhPYPjwIyq6RmKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658869; c=relaxed/simple;
	bh=/1+X6HsiIfQyT6aIK41uOVrt9bjdXgvPPzcnYHrIJLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=erzuRB+pEVsWY2qA3l3Xsvocnl03CzL7tmH6V0VUmklvpeF/VpMuBw5VvquYsWo+gXP97ZiIbKBvY+sM239DsKXYnNhamAsxyYgC64MfjJkbhd82jA3QhduR7BBhZt9s8Dmrb2um3HY0oT8q/Mtg2haB4391gR9ULUMig/8ORdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5+WCdto; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5+WCdto"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba66faa692so1157190eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658869; x=1771263669; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZFiibkLe5bpK+h3FYzzNDt6gUE19webVGNlODoSOiw=;
        b=Z5+WCdtokUNW74gzHkdEp4an76HsqZ7/Qcgq01UMAcOcor295GdtD1W3ejKyXfF5/O
         ReMbvLWm0KmNsICueyHmF2sYhWJICiuJmTp3ULUQGeXuWL1KRSOWgURcfv2nqTMmnJRY
         jR8NsEjQGEPPvlU21mGh9zy4pythA9we4W3vZuNabZlFVDlFbRk5VQWpDNbEiUEF1jew
         IEIFXbz3qxHRRSkBQTJhc8NZY2fnWjsIg3Y0CyRi4P87yb+V8u/dyHlr34kdjau+7Zvq
         h5FhqtA3aSkuTP5ybMTyL3mTsDy8N5PYn9NdO+0OTYW1VgjXjkyfhc/Ft3iGRHQM3jqQ
         GNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658869; x=1771263669;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZFiibkLe5bpK+h3FYzzNDt6gUE19webVGNlODoSOiw=;
        b=jqbXS76bHu+2uKArdxrZXEH0BhuV7yimvRdK47UKoRpFUxyR0PkSkKXBavw5bmmum8
         2ISk1AP5H1VRv7T1r4OCfw37YrGfCo6A7wJ8dXKuwLAN7lg3TE/+KZPRBOPtnXw9kc3M
         7qoyvgzEaOF697HM6nRdN8gq4z01x2QMr6qENLpuVLu+S4vRpuJjHB5ERUULxY8Nhr1g
         WpnGy7EeLfE6ix8FiwEcBk+k16VMQdbYupGKNKk95ZgGpPlwaAD2hwRvSEhpFqsYU3nZ
         erClzhAKwExmdfW6HSnHIDHh3ElVJmjtAMdI/C3AQec1T8CE7hAaQH/Dun1BEvPO7Plm
         D7TA==
X-Forwarded-Encrypted: i=1; AJvYcCUGoc+ctjucWLIv7XucJa4Y0CvrbUrLzSKU71a5CE/zw/JL6OO2/7KJWiMScMMMzaYGqzKkQjAEVVPH7MbAdwSY@vger.kernel.org
X-Gm-Message-State: AOJu0YwcJAzj3WARcVmPi0SxeoFSYXrnv3CqF0jvaRNsyJpSu5ellptO
	GG9QidALaoqPhUE9n7tv2apgnkSsVCTlq2RjiTbYYUU9walF7vrbpZXs5u1uzfJ1zHfoGzJQynY
	tsB3pfY1s1w==
X-Received: from dlzz30.prod.google.com ([2002:a05:7022:49e:b0:123:17b9:69c2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:24a0:b0:11e:3e9:3ea1
 with SMTP id a92af1059eb24-1270403f77bmr5192993c88.50.1770658868424; Mon, 09
 Feb 2026 09:41:08 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:19 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-13-irogers@google.com>
Subject: [PATCH v1 12/25] perf db-export: Remove evsel from struct export_sample
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
2.53.0.239.g8d8fc8a987-goog


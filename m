Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E6E38B121
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633191; cv=none; b=RTXsmmC6gZBTB78EhKiO2fdhN1uz2yyC4VUQ/fBKEy6Ppml0kmWtfidZ14cmF2Q71Maia4FgnnHIKXptdgEZbfPrGII/RpZCwA/RMKygr6ffSvdGRWiv26TBintcF04fG2Nqa/fmB2OkTpqVtUxXGZZH70SSPrfmKxAn8i0BFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633191; c=relaxed/simple;
	bh=woVK730/m2g6PPS9x8P/giHxXs9+wVRn/ViMS/wmhlY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TdLHGF8FXCS9hbc5OmP+bX9zPNrjeIzIAVHYQMikdeUPQ8+9f8KQBiop4zaCuk9RDifafloSLO69GrDkvxJq0Aod9jtIm9cFhiNGUC5Vha5UC47QkBlWgcf9qNI8Pfw44ZhYiB6sRxGcU3nHoLfTdkeifADE2S71f0tKiRqL5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VSf2t5c+; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VSf2t5c+"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128ba70cc99so6519101c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 00:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775633189; x=1776237989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rGBBXdpiWePuw/59wMcLGdfD0cYwMcREBloyciHzDuw=;
        b=VSf2t5c+oltf0WZVoJmjwa2u46Oob8Tr6wwoH99MMkeRR/Oa8py8qc1SBaNjrHm8E9
         vSgFfTBi7hS/9cbsmMmM8ogtWFZWH3rn/43QUxj7cFmZ7hHc/fqwg+7JHQevjMy3PkFd
         hGoSxznmO6oaKZ6YHdCed12VuARdrpy3ejvJSud0mqb9GFOr9abkjtemLohXh/upK9iq
         j1ZyjJ7O9BS7CFbMpv9GWZo3qnbw3yDP9zD/27OR38XlTBZDRB4nggiKgBC5F0ExDtuz
         yiT0+3qguisONw/uCOZWdOUxuH3YTKSPQcNATudaPfo+RcdD8ik6jaP9Pg34eZ6sqLj0
         M/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633189; x=1776237989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGBBXdpiWePuw/59wMcLGdfD0cYwMcREBloyciHzDuw=;
        b=ZEonyJ1inz63KlaUymfOrK+5GPK8FmsyfOPya7CStCOqZisnCpVyP70X2FtiQdUGyo
         WHUbuLe27mMPC0GZDMgbCTdPlsk98vjcDv31mIlqS3MUUq1XiomIvVeY8bZbBxhHeoUs
         64Vrq3hEs7K1ZGRzOcfX1i7yuhjhc9X4tVX0Du3QHA33uyR1IKmTsLCPztiaTnpcXIO1
         B9NDvfp8gL+EOP5uWt4qV0cW4nLhLdVFGPwQSrHTxQ3/EA8qeDWzpMwj+LuoYWiLw10b
         8+Eey4lMf8vX9UV6qd3/OcBvZ3GHa9qpt6pddedQJnrwJGTBw3tGaRvc0E2+wBGeQhcG
         3umA==
X-Forwarded-Encrypted: i=1; AJvYcCXpVeWtUSSrCVE/8/FX3FdKZ00Is3ObhpVBY3RxtqzIqI1znHhY5j4SgfFIeMyIeTIdT6gCHDlELhai26uurNti@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5A1HDZ2xjqzUl8Pkrk+lTi9U5yPH5EniFVQB0VflgfiGlHuF
	f971eIkD7WlAzyPtO+ZRkU9pf8yFbYfeMlJ3PAp/r8hwQask9ayVecpgjZkdh03FiQqKlCZizmD
	BCDQqVtwUmQ==
X-Received: from dlak10.prod.google.com ([2002:a05:701b:290a:b0:12b:eb82:4c63])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fd05:b0:12a:b932:81d3
 with SMTP id a92af1059eb24-12bfb76b48emr10321726c88.26.1775633188835; Wed, 08
 Apr 2026 00:26:28 -0700 (PDT)
Date: Wed,  8 Apr 2026 00:25:48 -0700
In-Reply-To: <20260408072601.210837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adPyeCq3rQrTurju@google.com> <20260408072601.210837-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408072601.210837-11-irogers@google.com>
Subject: [PATCH v7 10/23] perf db-export: Remove evsel from struct export_sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, 
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


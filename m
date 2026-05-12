Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA43A6403
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625042; cv=none; b=rgK05SFZ0TRsKl/RaybVFcTYrbqKlY8f0ZoueXCdMIRi/W3C1NPI20izkamA8S5ArtAZn6NCyF4tRv5Oxxp0J/d5fTek8RZ4pTcgy+lOLWbvYmIgNMR+rFNh7+MKxbXxh/tHnEJM+fMEgemcJvnZxmIJvxyRjd9YoyhgboKNaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625042; c=relaxed/simple;
	bh=IfGif8V3zJ0pgh5LnOcz9CIxbrdob8ILsQ7rU8fXRbY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U9Ogwob7yMgyb5nOgjV/AavnTyTOiTsGb2hrLmNUNyO2eEmDdw1QvepPMF3aj8K//JsIrK5ewSdo8cF+Sv/e7Vm3Jj/x6EuTaeS8npOtvwR9nlQwZHkon0W+ZCg8bHxjMMT1LkSYA6oywcN9kj39cHXqvD7xnhz7PANT3aCqdaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q1D2xGi1; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1D2xGi1"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1334825df27so2794902c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625039; x=1779229839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWieKLQChCH4I/VctYtfbnZu3dvjx3pQytuJs8FQ7HE=;
        b=Q1D2xGi1POjMKP2Q2H75C9u2Fx0GH+IXM4yrt0bqY9d1JvjYmz4xiBRxY6VaH31JNW
         oVPmbBm0dEYAWI+ExG3dIsFAkask3LVOk1boZi/yeivh4hr4dVlW+P0LyrkMDmllPySn
         3MLqHMQ+rfJ0YLYufaOz7BXMM70BgFunjJbFAUOr7CB6CQUVS8hIqdZ4CldSECBkZg1Z
         UMd+rPRf/W6okVjjuFXGfsuS7NvDu4cNI49W9IMMQZssjTryZoUsKhdceanStr4TYiZt
         NfFZU8tPsIMi4hSJkf2lc+IMvuVqpgxuTqZhRDvieUuymedm93kWxsU32Lmcc9/22o60
         wGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625039; x=1779229839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWieKLQChCH4I/VctYtfbnZu3dvjx3pQytuJs8FQ7HE=;
        b=HSjSlQtuLx4LJGn64NmKNWaPmbJa5LpK+EItyDmjMMqpkJ10RM00H9AXavb8hLqlKA
         o4kH/PnEUAR1tE9MMEtJPqj4BHECdDj+SYDGxVCUQTXsGmov9pIwxtE3CbqjJQLAt58W
         HiLlmHibWxy337Kvg08zbOwDr8dKwPtH5/UWhEcznS4VH3Igg5p4vigwpL6ScyUaNq/H
         6MF7utU8vgXr4x+qVM56WAlBCkNRZgY942K4f/3OGOrXWU1BftlSvmzgmEYSCfk4AR3p
         8DzynpfMwr3yWC+ApJQezoTu8BJRqRq0U3e0TbxOvU95ECaSDP6dJwiYoBpN90DNGP7o
         nSDw==
X-Forwarded-Encrypted: i=1; AFNElJ9SGlBTNXML9dANGr0SFfYp3ce4ikaJrkHe+/vGWASlel1+Ijnv5YFcJS8MP69AQ2wVVMOEKwnbuSbxnK+ReZZG@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJ9rJYXUx46a54nEbMpr8OyIUMAI9sl7xq0Z9mVk0eZawIWIu
	Pi3CCKCJamvwal+EtQhR6l0dJGX2VZ045jE7is46qcL3qdYzq+i0tpLrUHAvFAfmfbvZIJQQ651
	GEuWMGFaZiA==
X-Received: from dlbcy22.prod.google.com ([2002:a05:7022:b96:b0:12d:f46c:8f9d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:225:b0:128:cf80:deea
 with SMTP id a92af1059eb24-1342ee3a12cmr449172c88.1.1778625038546; Tue, 12
 May 2026 15:30:38 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:37 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-9-irogers@google.com>
Subject: [PATCH v13 08/32] perf db-export: Remove evsel from struct export_sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
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
2.54.0.563.g4f69b47b94-goog


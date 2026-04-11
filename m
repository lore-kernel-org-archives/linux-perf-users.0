Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351943C3453
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935061; cv=none; b=FKTTxuAk7HsXPXMLEfkGMsXX9o4zTpEuwEPbXkJ1E9TEorhaFp1ETT+jA3xE+np7Wo2fgs9cnC89VJC+G2Hg5Sc5Xulo620XwTWPSH3MRojTolD5R79MNJJqrtLTCpWgfau3Ak+xF6odqVZtFgbjJRZbIytMGoJnScISr9jAoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935061; c=relaxed/simple;
	bh=zocEQ15pqhkgaBM7JLqkF/pDJjGAt5zDiwcYu+1pxdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UvNVPF/1dzurM5Ggtz3g1d8UTJCjPo6Oq1rnqIpFcvqq7i7AKFRnKRLpNWgNIKtGsS0XQplIrw0Q4P6mKrwJlK55Dyzoo5lWhj/Q8Amg+J6BVpk8S9spZ6KNhCaURF6CItygo6ymR3WTBSOT9t8TkKNWS3veaXQR8ymyg5TMslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KTEQKzlV; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KTEQKzlV"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c282d6d32so3756236c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935059; x=1776539859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFmOnjJwpBpu0n7wKSDPl2Bef0Eg6yPkVeQqUwZtmi0=;
        b=KTEQKzlVnRl76Mrs0CkJtZznRo7KOqc2CxBVBRqb75qe6/eRO3YR2byFsicQrDOc1R
         TKRxq2caya7YQV0Y116bKQbamVrW0gVi4dzT6I7uuSs45cTdu+HvxeEVt0q5lq8etNrW
         Ooan47xM9rs2Rq4L8XDQKkBuXcPVEVSQdy12HWu9mIOG7Wb8vJv1uugJoSQiim1leZg9
         YvluUVIvp5LLpiolxVFmpmFeiZeTuoZkuffNJswxldpiFTDBXWTrskvb4MR07D/k7uUQ
         uzsMnLLmIfrK9Ib7xA1hoETwaGbADGMyy5PlVqOlE8aZ8KH8FKG44921R4gyCgylemhc
         mfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935059; x=1776539859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFmOnjJwpBpu0n7wKSDPl2Bef0Eg6yPkVeQqUwZtmi0=;
        b=l+rltCgPJ2zrHwlG9kgBkF9aB+jJt8zTcrj19mxsIlxz1a7Qjb60CLGLKb5GvFoW2W
         8DV4aaqGEzR0JbXp8/7vXJMJRibSc0J7IMgVpBjZW9Fakykkew4I9iwHmZHLVupCNzN8
         XAFuEoecsAQdqxreIPcdXzlAT6shleH6yxh4JLrC5ijxJ5g2D+6aPeHDJM2ITOKNYMGe
         slXJZB3PLqiF8lATehTliupMOQ+RbwVP0rwvMyMBdgFRukqrnCG3B31YzghqfDoDgBeA
         gKlHYTkfEKkuaeiE/guVYVZ+dI8E8iShuMl3R+Qj220X4SqyyMmMHp/gE/uALpWY0R/e
         9INQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ayycIUlJfucGRSrHgEqD6UvP3tHjveQyQZuJQIOmlIr9fhAonlai5ggGw+AXdXu6Ug+ApZcMN5xw5wgPWM86Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1oLhgNbZIiS5afb7IGmyw1f+2vcigTeesJFmU2/7TWL1pQLo1
	RaXqye4tse+hxVWUm0ImYByLv4kNPdPrYzyM5xh75bbpfMuu9KAHkDRER7eY2+tZP+MUP8DYHZI
	9txiM0j0irw==
X-Received: from dybsr31.prod.google.com ([2002:a05:7301:719f:b0:2d5:e1c9:f780])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8188:b0:2ca:8099:ffc0
 with SMTP id 5a478bee46e88-2d5873b2f68mr4584724eec.7.1775935059074; Sat, 11
 Apr 2026 12:17:39 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:16:51 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-11-irogers@google.com>
Subject: [PATCH v9 10/29] perf db-export: Remove evsel from struct export_sample
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


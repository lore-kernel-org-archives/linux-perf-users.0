Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B81D798E
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043375; cv=none; b=J636LKbXbO+MOwGhsgm1XCM/MNd9LgQrwwI62oXo3zfGNC1WV+lDuKSL0mbgXx3rz2G/ELOQ1XDkG0mznhWys6c4VmCWa7ALwwXWF/MsRoDgY8znrrFj68QAU8mmEKoPyi+irkiFzAZYCwncArBFnDoy3T40gg/e+GhtkoOCv4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043375; c=relaxed/simple;
	bh=zocEQ15pqhkgaBM7JLqkF/pDJjGAt5zDiwcYu+1pxdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XlhKo73kDwo5thOfNSEq3GkFscycY2KlgpwozTs2Zvnx3Jv2OkBGWaGEPQbirHo1ezDnpsMi96ply2Gm4khBxHR3m6C20lbXRqLgVJxbKSzwSb98SvrgUON2BVF/sTzEjdKOKkJg7flXqyVRAXUmr8QANgc/q3+ykDQ6CvxWJec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M48ft5QY; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M48ft5QY"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c21dbc9c1so12529553c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043371; x=1776648171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFmOnjJwpBpu0n7wKSDPl2Bef0Eg6yPkVeQqUwZtmi0=;
        b=M48ft5QYHPV5tUR/MyuwM5CRWlxuHruh/pbLwni8Xl2kP+y+3f3zN6HOVzIaSH+Gpj
         KO8lLEO63x2h0amL7+qXZwp27dA8fXWkAijU+UCqVOBofor4uJ85dPPu+NPEGwqxJFdB
         I6Hs/OT7Ez0Mj9MWc5JsKqyrCgYTdTkjcBylgYwvUs4kM2n4iq8QydE0yt8ZHchF5RpO
         bRwmeZ8+TVq/nV6U6MUhtkxl0g3pz8s/HjkhM4IidFAyRTY8+uy5dZPVmxSey+ANfvYx
         gOT11pEpd+HA2d7MJAPNii1xjG8EsR9frmKfOzLdKYGfUI2NfNot/OlNDNmwICSkauKN
         afzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043371; x=1776648171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFmOnjJwpBpu0n7wKSDPl2Bef0Eg6yPkVeQqUwZtmi0=;
        b=U1mOtvprumDheXE3FDiEsCXjw9TiXTGsh2vslUqNjGeMy9dFP60rCygAGJSBUKJMrc
         UB96pXwVCQcSZSo7pUH52X+UwhqDftSBwTERnzTf2FHXaFoELiatBzz2qJlOQONiDOxF
         ZslKSP/6eXU2rO3/3HjwdBLFtiI3OfP0yjTGFuez414Zvheod5qaOhhKVBttWbMByBk8
         qOD0DonZwXh7VZilGCiR4Q9vWsjtqfa8WLjgXt//W60rC1DPxDiejxkMvlo95S/OAZi8
         bCjoxNrSYmbMUEo5ukU1tth4myRA68ex4oC7ChFPX2hHesDYZyHRJYD93cZKpxPnxpmC
         /s4A==
X-Forwarded-Encrypted: i=1; AJvYcCXoHXyLmbG2i/V6s4gans9tlmVRku3wcFKC8rj0WNAGfMriYNdqtWobC+m9QxvxArmcarAYqt7uNFN6CG5sEdED@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnBrrzq7MgOTQvnXvStW8bLi3Sgjo0kOF7IHMboUgy3C3cEE8
	xWOdEub6r0UNGV0gKHcso7bNcc92B0a6KqmuCkyzt5256A1tMwiGNplXVNw3wfj3Le1MpTrqwoC
	sem0w6ntGww==
X-Received: from dlbvt7.prod.google.com ([2002:a05:7022:3f87:b0:12b:eb91:8863])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4194:b0:119:e56b:c75b
 with SMTP id a92af1059eb24-12c34f03b09mr6342772c88.32.1776043370806; Sun, 12
 Apr 2026 18:22:50 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:03 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-10-irogers@google.com>
Subject: [PATCH v11 09/33] perf db-export: Remove evsel from struct export_sample
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


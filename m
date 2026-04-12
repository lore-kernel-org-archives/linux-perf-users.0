Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667E31E84D
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959745; cv=none; b=kXidYLbeKPp1LatNPJG5C4nR5z9XJp06NsRzO8GMcFiQSNvjmy13e7rqKSUz7EK4zwjToeIyPq5g4KiCuimOEx36OjQgbt+81SLV/EEecIGg6gpm7Uw+Uux75NbITAs7my7BJqDkkhPvRf/tdGumnRymy2j+WhxyG0fY3pgP7nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959745; c=relaxed/simple;
	bh=zocEQ15pqhkgaBM7JLqkF/pDJjGAt5zDiwcYu+1pxdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C9CfPB2vMMvv9FwQ6OAA3f0CfqqfCWcqFFuDtSjPunYDzF1YNnFGEEh6OZFs/RRBsYMVUSsBe6ni1mgqFM6OoV7cswCyLvVsiWcYedNa2wYddCRcXJY2EKC2Ou1cVSgjfpWNS7iHh7/6C0AWadlQt02SDQxCavh5kBwKDEJeq6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pdpi/aT7; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdpi/aT7"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdd327d970so2036765eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959743; x=1776564543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFmOnjJwpBpu0n7wKSDPl2Bef0Eg6yPkVeQqUwZtmi0=;
        b=pdpi/aT7I6s69pRNsb+KCgPZzSwzsfIX5KwZDPKIXhErMHffi2aIkBm1d3nrEZL9Z9
         0uLGPCSeliSD2CwjDlsGehHYdv2r+EJLPJReWk8OZHaECRpXKUx47kO4Mz9FJ46BejvZ
         xrEbLvQJbMGF5r9GHOY8vO9vudv6QErKZ8y5feNf/HV4fZZ/orFL2SvAq2zA2xGyatyL
         RU89lkQVPfWlNKYQXtDaw6ZiN/V0arSLOAREOD3yEYcfA3IbuXc9SRoXkJ4bTgJog3fD
         pkzTRCukssblhog+7Qm0PoRvbZM3JYWRqu0atufCBgqQCyqJ8FO2wGwt4zvV6EIc0cGy
         4c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959743; x=1776564543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFmOnjJwpBpu0n7wKSDPl2Bef0Eg6yPkVeQqUwZtmi0=;
        b=gOLuEZKv+oGxSUMOVeozE6IYokSEvBdmzr81xHkmvd/Ok+tWDLwUpnzYHtTJJMJbZU
         FffkgiFiMl56UQG+IS39Q2MGb3ppYx+ce1EljQqwW96h3sH8Q8SL93Qw5rAJk27z49Wi
         AixkefqO8xFKS/salIneXY/MRQcD4dTKvSPPAYjlceh6rYUvlI17To9rBWQh9m4TziiN
         GiAIav/+NuSs5wlk8an/D9GZzbS1wQmOp+2G9OhJJETR/8tVMGRuo1B3ZhGC3uapNpDp
         PZpcH0snBLMjlCibVqOKqmV0EOk/YPa67Z/gMv+yTYwxe/uu+kwzk9/MEXtIMoWbjZKS
         8zgg==
X-Forwarded-Encrypted: i=1; AFNElJ9PoBsFfdfXwEkEHSWUELdVnW2iR8+l70QWdE/4ge0DWK6GPTDcq5S65MNE3GG6pHzvnld7fTt42zpo1xotQ2ak@vger.kernel.org
X-Gm-Message-State: AOJu0YzGKFvYOqVjKTwVoo4HRRIIQLGRp8EJAjCt9aHlfUOuCDmKfNUO
	1S8irNoLg4tfRJhRdrFFynCkPm6JPa4sNlwePu/RPMv2gyXKqZ/cGBRrfifLI09Z8ZlMWQ39UNS
	iSYJcVkDT9Q==
X-Received: from dybta16.prod.google.com ([2002:a05:7301:6f10:b0:2d8:9b3:87f2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2184:b0:2c0:c6f6:b075
 with SMTP id 5a478bee46e88-2d40e9cad00mr4214612eec.8.1775959742427; Sat, 11
 Apr 2026 19:09:02 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:13 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-11-irogers@google.com>
Subject: [PATCH v10 10/29] perf db-export: Remove evsel from struct export_sample
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


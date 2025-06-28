Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A222156C
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 04:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086255; cv=none; b=T6zo6TegheOBiHiwFgL5mq+F6Er6y73p/QPs5rmipmlb3s69cY+tsqeJ0MAnldkf0sLIp7Qq9zm8qX8vpFltrNiHt07SgCWw7iPZjxBbg0bCoOTtn/4w/Duvr6KMDnJCwOfFvEfQ2DjGjbMF5ekXIAC+mx1fs1HDwzMjL6N0eNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086255; c=relaxed/simple;
	bh=3xYW2jVZ+V8yHcWI8MeTpN5JPAPdwj03e7PnhKFk/iI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Tke9u89esRcFMX1tTPzOUprOCahMdGVMXZPiTI5uPdENIcgD2fy9EQRyO9SQUqMSi4v9hcNqzzPN2m6UvH1be2arYi+mEvuuEJJpKAausLKiUAVNqSCP4NxyLg12qHZnmrWRhuXY5Bc2mPDtqJUzIZoZPYhXXeW2MBD7GDWCA7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nk/V7grN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nk/V7grN"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748a4f5e735so538409b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 21:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086253; x=1751691053; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsuMXS2KVsY9wSt/6mCAAI1RtzhnXJ4szVhJS9DTq2Y=;
        b=Nk/V7grN8aZGCpeZrSwPG036mI2hrNTVDkGL54XHNDTdXU+DDWr/VCgJoKFP1WjZVD
         iDAX2IUT/IEaF/mvAQ1IWN1A8kr/PG2YxnNKVmfs0syYnk06k6rYcYA7kxZrfi79ei9G
         kazeTzgyvGr07NDQZWYYgOcY1YvAN6p9I/lsjqilCpoNtWGw1CoK2MgmCFEmxTBvsh1i
         ayj8KvBra5hFpccnJpD4rN4D+lNwaD7Mzd9OHWqPLtAByS0QEAQY7sPYlVFdx7q4OQ5n
         doZX9M2v5h01W5RnGjAAQwGSH5+lWWaSZZHoVFPzJDkEZInvRcXHrgdvho9hL5Tiahjx
         5hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086253; x=1751691053;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsuMXS2KVsY9wSt/6mCAAI1RtzhnXJ4szVhJS9DTq2Y=;
        b=XWubtmuph8PJ6gmBJjqiND9REeAv1GEePYGMQkWQbQFNZ8/WHHer5uVaXyhvacQKJE
         zgnXLYBCLc1+LM+LFdEiD8sgh3heES3OCOMbH1psmlZ0PkwXeCEQLRuysmSwtJ9hjI9y
         d6Yx44UyL6EDtS6hwXQ4RdU97DY7A3ru0E4/WQXVl8Qm1VuvTmDcusvmPB0Q0QB9xAvd
         a2VouH2s8u1ZiP+nfJo+SDv/mCIF52BlGz3wV5jUnnDn4oTxGIi7I4az0X9wGJKQA9t/
         0OZL1fb5arht23qz63KyeNjpG+eCc3ENYv27IHVgxJqgzAkmfCZT0svb11sj1DNHPm9n
         vkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyl+LXoeW1De/MHaWQB9HR4Dzz9lVdWJu5aAV2Nvs1QKUAiyKizGSY0+KiQr8ufwas/xQXRS8wYs2L/Ge1xgsX@vger.kernel.org
X-Gm-Message-State: AOJu0YxxI9RBGCG5XSglhZZT3iywcSC2ggqdthAM1Sf3/inSV4uAr3TG
	CjayglznROmiQS9FZfThFqxLPBcOHK53Xfmdlj+NqgSn4VdSTCH+4vTAg7LoVuAtdw0vr+so/wc
	wA408nDDJiw==
X-Google-Smtp-Source: AGHT+IHsgP0BSA3zpM3gKeGrjNbPHAhLR9qMlepW527uVE/3e0PokK9cl03zA8A9Mhj3Exf4RPg5QEJ/1g7t
X-Received: from pfbmb13.prod.google.com ([2002:a05:6a00:760d:b0:746:1a2e:b29b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3392:b0:749:ca1:1d02
 with SMTP id d2e1a72fcca58-74af6eaa39emr7048192b3a.6.1751086253139; Fri, 27
 Jun 2025 21:50:53 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:50:02 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-9-irogers@google.com>
Subject: [PATCH v5 08/23] perf record: Make --buildid-mmap the default
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Support for build IDs in mmap2 perf events has been present since
Linux v5.12:
https://lore.kernel.org/lkml/20210219194619.1780437-1-acme@kernel.org/
Build ID mmap events don't avoid the need to inject build IDs for DSO
touched by samples as the build ID cache is populated by perf
record. They can avoid some cases of symbol mis-resolution caused by
the file system changing from when a sample occurred and when the DSO
is sought. To disable build ID scanning

Unlike the --buildid-mmap option, this doesn't disable the build ID
cache but it does disable the processing of samples looking for DSOs
to inject build IDs for. To disable the build ID cache the -B
(--no-buildid) option should be used.

Making this option the default was raised on the list in:
https://lore.kernel.org/linux-perf-users/CAP-5=fXP7jN_QrGUcd55_QH5J-Y-FCaJ6=NaHVtyx0oyNh8_-Q@mail.gmail.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c        | 33 +++++++++++++++++++-----------
 tools/perf/util/symbol_conf.h      |  2 +-
 tools/perf/util/synthetic-events.c | 16 +++++++--------
 3 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 53971b9de3ba..29428fb8ac67 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -171,6 +171,7 @@ struct record {
 	bool			no_buildid_cache_set;
 	bool			buildid_all;
 	bool			buildid_mmap;
+	bool			buildid_mmap_set;
 	bool			timestamp_filename;
 	bool			timestamp_boundary;
 	bool			off_cpu;
@@ -1811,6 +1812,7 @@ record__finish_output(struct record *rec)
 			data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
 	}
 
+	/* Buildid scanning disabled or build ID in kernel and synthesized map events. */
 	if (!rec->no_buildid) {
 		process_buildids(rec);
 
@@ -3005,6 +3007,8 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 			rec->no_buildid = true;
 		else if (!strcmp(value, "mmap"))
 			rec->buildid_mmap = true;
+		else if (!strcmp(value, "no-mmap"))
+			rec->buildid_mmap = false;
 		else
 			return -1;
 		return 0;
@@ -3411,6 +3415,7 @@ static struct record record = {
 		.synth               = PERF_SYNTH_ALL,
 		.off_cpu_thresh_ns   = OFFCPU_THRESH,
 	},
+	.buildid_mmap = true,
 };
 
 const char record_callchain_help[] = CALLCHAIN_RECORD_HELP
@@ -3577,8 +3582,8 @@ static struct option __record_options[] = {
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN(0, "buildid-all", &record.buildid_all,
 		    "Record build-id of all DSOs regardless of hits"),
-	OPT_BOOLEAN(0, "buildid-mmap", &record.buildid_mmap,
-		    "Record build-id in map events"),
+	OPT_BOOLEAN_SET(0, "buildid-mmap", &record.buildid_mmap, &record.buildid_mmap_set,
+			"Legacy record build-id in map events option which is now the default. Behaves indentically to --no-buildid. Disable with --no-buildid-mmap"),
 	OPT_BOOLEAN(0, "timestamp-filename", &record.timestamp_filename,
 		    "append timestamp to output filename"),
 	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
@@ -4108,19 +4113,23 @@ int cmd_record(int argc, const char **argv)
 		record.opts.record_switch_events = true;
 	}
 
+	if (!rec->buildid_mmap) {
+		pr_debug("Disabling build id in synthesized mmap2 events.\n");
+		symbol_conf.no_buildid_mmap2 = true;
+	} else if (rec->buildid_mmap_set) {
+		/*
+		 * Explicitly passing --buildid-mmap disables buildid processing
+		 * and cache generation.
+		 */
+		rec->no_buildid = true;
+	}
+	if (rec->buildid_mmap && !perf_can_record_build_id()) {
+		pr_warning("Missing support for build id in kernel mmap events. Disable this warning with --no-buildid-mmap\n");
+		rec->buildid_mmap = false;
+	}
 	if (rec->buildid_mmap) {
-		if (!perf_can_record_build_id()) {
-			pr_err("Failed: no support to record build id in mmap events, update your kernel.\n");
-			err = -EINVAL;
-			goto out_opts;
-		}
-		pr_debug("Enabling build id in mmap2 events.\n");
-		/* Enable mmap build id synthesizing. */
-		symbol_conf.buildid_mmap2 = true;
 		/* Enable perf_event_attr::build_id bit. */
 		rec->opts.build_id = true;
-		/* Disable build id cache. */
-		rec->no_buildid = true;
 	}
 
 	if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index cd9aa82c7d5a..7a80d2c14d9b 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -43,7 +43,7 @@ struct symbol_conf {
 			report_individual_block,
 			inline_name,
 			disable_add2line_warn,
-			buildid_mmap2,
+			no_buildid_mmap2,
 			guest_code,
 			lazy_load_kernel_maps,
 			keep_exited_threads,
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 69b98023ce74..638d7dd7fa4b 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -532,7 +532,7 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
 		event->mmap2.pid = tgid;
 		event->mmap2.tid = pid;
 
-		if (symbol_conf.buildid_mmap2)
+		if (!symbol_conf.no_buildid_mmap2)
 			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
 
 		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
@@ -690,7 +690,7 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
 		return 0;
 
 	dso = map__dso(map);
-	if (symbol_conf.buildid_mmap2) {
+	if (!symbol_conf.no_buildid_mmap2) {
 		size = PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));
 		event->mmap2.header.type = PERF_RECORD_MMAP2;
 		event->mmap2.header.size = (sizeof(event->mmap2) -
@@ -734,9 +734,9 @@ int perf_event__synthesize_modules(const struct perf_tool *tool, perf_event__han
 		.process = process,
 		.machine = machine,
 	};
-	size_t size = symbol_conf.buildid_mmap2
-		? sizeof(args.event->mmap2)
-		: sizeof(args.event->mmap);
+	size_t size = symbol_conf.no_buildid_mmap2
+		? sizeof(args.event->mmap)
+		: sizeof(args.event->mmap2);
 
 	args.event = zalloc(size + machine->id_hdr_size);
 	if (args.event == NULL) {
@@ -1124,8 +1124,8 @@ static int __perf_event__synthesize_kernel_mmap(const struct perf_tool *tool,
 						struct machine *machine)
 {
 	union perf_event *event;
-	size_t size = symbol_conf.buildid_mmap2 ?
-			sizeof(event->mmap2) : sizeof(event->mmap);
+	size_t size = symbol_conf.no_buildid_mmap2 ?
+			sizeof(event->mmap) : sizeof(event->mmap2);
 	struct map *map = machine__kernel_map(machine);
 	struct kmap *kmap;
 	int err;
@@ -1159,7 +1159,7 @@ static int __perf_event__synthesize_kernel_mmap(const struct perf_tool *tool,
 		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 	}
 
-	if (symbol_conf.buildid_mmap2) {
+	if (!symbol_conf.no_buildid_mmap2) {
 		size = snprintf(event->mmap2.filename, sizeof(event->mmap2.filename),
 				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
 		size = PERF_ALIGN(size, sizeof(u64));
-- 
2.50.0.727.gbf7dc18ff4-goog


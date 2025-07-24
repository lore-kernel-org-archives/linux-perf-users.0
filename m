Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204B2ECE94
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374818; cv=none; b=h01fIHytXSDmKiu+DYHnvX6WNQN9d3Zi09DgT20CZMZcaoNH68FeQ8rpC9B1SC60JpRjquL7DWN0CpTb2ZzZNv4e/tIM8OCFpFHTuHPF8ZOF6yeR4a7Fk0K4F8DohMk7+yVj4uU7+OMI+GTkU47SkTtFYcyB//hMAx95+dBAVtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374818; c=relaxed/simple;
	bh=z/xSjHdP56FXYIWs+aIIljgC0ViewnharrTuckvuFUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=R2dRlP18aU/0T6+TkCciqAyoS/g9QeFTr95uY5aTmKRzsgmpdyVf0Ok/bpT64l1TQ3Y6g4eYxElX7D8dfIbdmW5S8yet1tJlwsjfj+MfZoIjHh9gDiAXtnBOYTIMF2khHzjmE1qflwCr+pnNDcIQy4m5zUFJbNn/dwI8HviISyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9nAMuRn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9nAMuRn"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e8de720b009so593507276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374815; x=1753979615; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sdm1hmB2kPMSJ2yB+sDP6pEGWfyWwz9T2RmJ3aOqJf4=;
        b=M9nAMuRnCoJKE+wQWjGp2naLe/993Zlb0/vdxgKJff8DDjd9gtVEUDbZQBG3ZV5g9p
         ndLuebIk6cHDjyG0gxVszcv/tpnxybjdZ5QInVd2/5POj65YXjHpCoWbq3zpvXYuj2GR
         6gD3OMsMWS3eA7u88Czm8SqR8pFajy5fAeJl88yokZT5nDyI2ZJUiC5vNWvwv/xVg4YI
         dfJFICrtAKicN6tGBDNp+RA10YRAwAnb6NeFJlAlhy7zYyeeFLX73CXbz22wt//ETX/8
         F9TAzVQakkMf8La7qitFm2xUuTWudBiNKi4FpaCrS2JQOtJxpr337NRWqDgvgcFwdHlj
         3Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374815; x=1753979615;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdm1hmB2kPMSJ2yB+sDP6pEGWfyWwz9T2RmJ3aOqJf4=;
        b=jDBPYepjsXqknjC1mg/3t44nGSMgLwYPWji/m3ck7Un+ASDg9lOujcxKyGSj7WLpl7
         1S36KcF1Hvd6jc5I/9BT4/OFh0iHgJRN7hiJUV4z6TKbrBa3LdTb3sUZr1axsCgTJp+j
         +iaq3p2bE/7E2PQAIP06RdXxj+q35sCT1ydzOKzo9V8Eg/D3R5VuuZIVK1Fl2DCoVcni
         IBqaNUweTWFC1iJGr7mglhzDGfaSD+635vSYAHlr/Qe8UB3zLQu4z+EHneK5e+l7qV7N
         NI420FfaUKm4r8odRma+OQMzlr6igikCYqhvt0qimxVKYwg0v95TIDBNqNHtJtG/9gEy
         /NhA==
X-Forwarded-Encrypted: i=1; AJvYcCVQR868Gc13olWLBDd/iHIBzZREXHNBydT9oqStI7axBPwcvTE1mH8KNajJMVhB2KEXhQOVG5qIM7V/QDy9vJ26@vger.kernel.org
X-Gm-Message-State: AOJu0YwLplfp03jo+35TrMOi+4V/kpxfRQN9pTA8YHobC+vhkzskquez
	NFKD1LCQJPYK0KSwpubSqAMB+t+wsacPlYTEITNmUmVg+lRHwGP13IntO3cmXHDQWiRmBGfqqWE
	Q+z3m6JcQtw==
X-Google-Smtp-Source: AGHT+IGdvVU2kyOvJVHKnWQwtopdS3uO12p5q6cuQuTQqBzAPtRCgVQ93vv29c0Qy5A/Q0xotZJoWnAwhvCZ
X-Received: from ybaa8.prod.google.com ([2002:a05:6902:4808:b0:e8d:dc80:4fb2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a25:1c6:0:b0:e8d:892c:a2e4
 with SMTP id 3f1490d57ef6-e8dc5ac9b46mr7678442276.28.1753374815175; Thu, 24
 Jul 2025 09:33:35 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:48 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-9-irogers@google.com>
Subject: [PATCH v6 08/22] perf record: Make --buildid-mmap the default
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
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Matt Fleming <matt@readmodwrite.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Support for build IDs in mmap2 perf events has been present since
Linux v5.12:
https://lore.kernel.org/lkml/20210219194619.1780437-1-acme@kernel.org/
Build ID mmap events don't avoid the need to inject build IDs for DSO
touched by samples as the build ID cache is populated by perf
record. They can avoid some cases of symbol mis-resolution caused by
the file system changing from when a sample occurred and when the DSO
is sought.

Unlike the --buildid-mmap option, this chnage doesn't disable the
build ID cache but it does disable the processing of samples looking
for DSOs to inject build IDs for. To disable the build ID cache the -B
(--no-buildid) option should be used.

Making this option the default was raised on the list in:
https://lore.kernel.org/linux-perf-users/CAP-5=fXP7jN_QrGUcd55_QH5J-Y-FCaJ6=NaHVtyx0oyNh8_-Q@mail.gmail.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt |  4 ++-
 tools/perf/builtin-record.c              | 34 +++++++++++++++---------
 tools/perf/util/symbol_conf.h            |  2 +-
 tools/perf/util/synthetic-events.c       | 16 +++++------
 4 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 612612fa2d80..067891bd7da6 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -563,7 +563,9 @@ Specify vmlinux path which has debuginfo.
 Record build-id of all DSOs regardless whether it's actually hit or not.
 
 --buildid-mmap::
-Record build ids in mmap2 events, disables build id cache (implies --no-buildid).
+Legacy record build-id in map events option which is now the
+default. Behaves indentically to --no-buildid. Disable with
+--no-buildid-mmap.
 
 --aio[=n]::
 Use <n> control blocks in asynchronous (Posix AIO) trace writing mode (default: 1, max: 4).
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 53971b9de3ba..a59c4e15575c 100644
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
+			"Record build-id in mmap events and skip build-id processing."),
 	OPT_BOOLEAN(0, "timestamp-filename", &record.timestamp_filename,
 		    "append timestamp to output filename"),
 	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
@@ -4108,19 +4113,24 @@ int cmd_record(int argc, const char **argv)
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
+		pr_warning("Missing support for build id in kernel mmap events.\n"
+			   "Disable this warning with --no-buildid-mmap\n");
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


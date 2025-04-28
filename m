Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F429214A75
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876071; cv=none; b=tf2ge6otfurnmzYJo5Y2VphCgV7ZmyTw0po/lcx1A/0VlLHUgnF6JpteKMEp+rMC7GQ0joWZaxzzb+2KI0NOCgnl4TxGmHrI5oHxK3EiLtCQFoRuZpBEXjUIGYj4arEPhyxqJDSNvzX8RJpTaOo92R/bVQxFCn4KHOzUZr/X9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876071; c=relaxed/simple;
	bh=PScFL3QKHD83Kd+8sQnLhjHRKeKqkKT+m+cpgcoH03w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Nl0piOSLlEIjbu2emhgFFdlkMVVUL8J4YZCXz5ajgl/6LdhP+NNNdZrlcwtXFku/YtfUaG3iefjO5gtZXf0i5Ijkl/xA2fTI0gxvNa7M3pz04Tgx8cpy8E3XhoIaqubOzAyrg4DYVlXZZ8Az3CFc7z7xlSSFNjLvdmvFE1QAfU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ph7B7qQj; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ph7B7qQj"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7375e2642b4so3720426b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 14:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745876069; x=1746480869; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSs+BEdvbnIfY2dq99UXmMP4Buukql0Gb5bTAHvwkAg=;
        b=ph7B7qQjAbfUgFsmG3luIKpNwWX2iH18m3Ed060jtsRX79wbQP2yqEG8aYXm5gqZxv
         aiFRInz3GNHnPleU1IQfkpAjGZsnvsrOXMBzxf7xt3PofEHJFU4hiWr7Jfa3kL5ptRHv
         NwdEjJxiRhgMvyM3swknIffDPcVZTiJF2N6aTqu9WimVepqW9F3xIT9ELF4HB7sEE677
         1UebDnwlUfdBj2X1V39FpIf/57KBf8k3KLD0LawTHcVnME1YA7xpQlB2+5Cq1a5B5VPC
         73GpDNe/Yrad7+2BNqqP2+5Aag3lR/MNFTIRk3pIEiH3Gts4fPg5ML/GR6BjEoMV5IHY
         qmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745876069; x=1746480869;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSs+BEdvbnIfY2dq99UXmMP4Buukql0Gb5bTAHvwkAg=;
        b=LE3rvDhqXoN2xbxwmUl2ldzIttEMUfFVHcvjnSRYzegOi7QeE8mInos/62FsuHJUvs
         hESCVIQRW1uE3bF8wc10aUyGiy0+Qd2xKAv+W8iDjE35hgp6xC6JSfMz6qqhaa+hCLRy
         fHnrTwV2hSLCc91GjYOJ29RAR+Eim6FY1SgyINgVQQocmFfgMlkmZvH4GkiNEvfiGwnn
         RPjFdREAILa1DAeDhTy5aN5N1Sk1Phl6XgavqZ3JhhqyCSS7otpOfTJynrFnW3cUP389
         fwTCsE4UGNhhq0iaKcZluQcdrWDesReICDRfDii3A726/Bj48q/TXn8jSdEa3KnfvE2i
         MhFA==
X-Forwarded-Encrypted: i=1; AJvYcCWclcVncsxEhAZQR8MCAwnYrs5WnVxxhqm90stAN864ZA2c81/3U4wHM66DWINs048i0dn4uz+ZC1b4qljH9FlY@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0E7/umAgI14iS9medqH+B3PBB7WqsLGCONyIv/1r0xAX+kUm
	lxPOA/rfor8KT/OXnr6HF3Z1ryYoOJME8xB08zvGL69nIdhJDkdbeJEb1c/BTV6AhNuTCe92Yqe
	xGRJOcg==
X-Google-Smtp-Source: AGHT+IFcsBuxLiRKFxo6cxliw7p+n3n5l2JnUxq7Z0GFhsWt1MiIhCDgVcaUM/hovjHWg7X6AItekzXO1Bba
X-Received: from pfoc2.prod.google.com ([2002:aa7:8802:0:b0:73c:26bd:133c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9282:b0:736:5753:12f7
 with SMTP id d2e1a72fcca58-74028f9382amr954698b3a.3.1745876069395; Mon, 28
 Apr 2025 14:34:29 -0700 (PDT)
Date: Mon, 28 Apr 2025 14:34:08 -0700
In-Reply-To: <20250428213409.1417584-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250428213409.1417584-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250428213409.1417584-10-irogers@google.com>
Subject: [PATCH v3 9/9] perf record: Make --buildid-mmap the default
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, James Clark <james.clark@linaro.org>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
index ba20bf7c011d..7b64013ba8c0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -169,6 +169,7 @@ struct record {
 	bool			no_buildid_cache_set;
 	bool			buildid_all;
 	bool			buildid_mmap;
+	bool			buildid_mmap_set;
 	bool			timestamp_filename;
 	bool			timestamp_boundary;
 	bool			off_cpu;
@@ -1795,6 +1796,7 @@ record__finish_output(struct record *rec)
 			data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
 	}
 
+	/* Buildid scanning disabled or build ID in kernel and synthesized map events. */
 	if (!rec->no_buildid) {
 		process_buildids(rec);
 
@@ -2966,6 +2968,8 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 			rec->no_buildid = true;
 		else if (!strcmp(value, "mmap"))
 			rec->buildid_mmap = true;
+		else if (!strcmp(value, "no-mmap"))
+			rec->buildid_mmap = false;
 		else
 			return -1;
 		return 0;
@@ -3349,6 +3353,7 @@ static struct record record = {
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
 	},
+	.buildid_mmap = true,
 };
 
 const char record_callchain_help[] = CALLCHAIN_RECORD_HELP
@@ -3514,8 +3519,8 @@ static struct option __record_options[] = {
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
@@ -4042,19 +4047,23 @@ int cmd_record(int argc, const char **argv)
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
2.49.0.901.g37484f566f-goog


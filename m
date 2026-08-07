Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CFA3B27F7
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087110; cv=none; b=Ztzzs52wa0z26H77JWlGjf3k6vuCeWE6abRrBfLMGxuLQoXaWtA5PvA+3zKuN/3lRTX2DfNu11oDhtkKIYDDY3G3jfK4vAF9b9N0Q2hrQQCDeI7GbB44iRGL3ZMwpnDvFjprcBFkBmNbDopFhPoOkoqPVZLZ+6bmvYw9xASCA7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087110; c=relaxed/simple;
	bh=3eeRY5Aa9pvngR2Af34iEV+b3xWsYHturOXlMa/4JjA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nV5Pgeoi60DQX5BYa/EWYR2ZSdUde5gxHBG9hnWAbLT4NCYE/Vpb1NBgT2sKRyffHDWn2RWy8skzM6KSNquNwM8JmDyZHUcMduPd1QSDgvsF37JQD+ED7666znNHybEaoG0aK0mp+8/IZPsgmTBcvkCSHDBIguqK9m09LM5Oasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gGuSy8/2; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gGuSy8/2"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c860544c077so6389399a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786087108; x=1786691908; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mKhluK2oW7axNaXGt2f+mOTb9EIBwlM5B6rGh/lUQwU=;
        b=gGuSy8/2xrw/REvmTk/DlyPpWB8HjLYsyE8gpXWYGq89lJblmMZhjO3fK5XDGhhuTf
         6PgddiGiz5UeEOBNHgXGl7aGp4yVc7gCEeR6P4A0sbxe06eB31CXT9lxdfRZCU66hV0A
         pLUhw3DfNgaYaNbCVAB7BaTjgdFgzfNo+Mc1CZme8wWfzuHbK+Jw4NKi5jz+SMB/I0aq
         GFf/uhQI5vtF/wF2f/a4Uo6oD48zQLaBf8nD5mcWscZc/5xL6nmLqLBjc10/3JJbwZLY
         JgNx3yfCagdrUVbQLgbrO3F9G7NpbPqFkXVCLAehlOkksgIvQShWj63tqz/jVUD2swyU
         CKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786087108; x=1786691908;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mKhluK2oW7axNaXGt2f+mOTb9EIBwlM5B6rGh/lUQwU=;
        b=qAIwa+l/uRdUhnxCteUnvBw29jAD1Lzep5l5Cqj5EWg1RJrZSQ8POLw2CCOE0bwIyC
         UUeB/UIKejUqqDwn39flGjs2DJpOczl5iWHILF+dzJeeiFdHrd9hXPc9nAMhGadjYSLH
         H4tLthp8zwjrAnE0yecbkvoDAVr2Hejc3Cqo8ekSKLnvDcmiuSoIKfcYy3WKulJnTmk9
         vU7wG7yfohASrUy4sFAHo9xCRcjqinja96GtUifvYWk4Z7X1awgCWBIyIWqjL7UK4yFo
         zEIhBC0XPh7QIm2Dxe3+CyewZglYTQZSQeP2+GiOxhIYBYw8BSVjyPPNrgg3pqUlS7jT
         0t5Q==
X-Forwarded-Encrypted: i=1; AHgh+RqRx40RFfHipVb1cVKD9has/Ktg/Hi9ZcjyLI6Y9vCc0LL+96PJHQxi9wc8P0IH7/XR6h9djNJHNwxP44+GKOjE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/A6/gB8WtwhjCezpqNsxOqA2Ez/GRclmSTHYAfcxL2Pp4tPsr
	ojyBNPDLybqfbwDuPcyFwIk4topTq5ATVruHLFua0I8D5fkYYRHC00g4avHaU8yjwy0b+RpNEKd
	Wvxuo4NIF5A==
X-Received: from dlbsi7.prod.google.com ([2002:a05:7022:b887:b0:13d:d48:df85])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cd95:b0:3c3:89ce:b5bc
 with SMTP id adf61e73a8af0-3cbc01c89d2mr2588400637.15.1786087107367; Fri, 07
 Aug 2026 00:18:27 -0700 (PDT)
Date: Fri,  7 Aug 2026 00:18:11 -0700
In-Reply-To: <20260807071818.718751-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807071818.718751-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807071818.718751-2-irogers@google.com>
Subject: [RFC PATCH v1 1/8] perf event: Factor build_id out into its own
 top-level struct
From: Ian Rogers <irogers@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Eric Biggers <ebiggers@kernel.org>, Zecheng Li <zli94@ncsu.edu>, 
	Gabriel Marin <gmx@google.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Derek Foreman <derek.foreman@collabora.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Aaron Tomlin <atomlin@atomlin.com>, tanze <tanze@kylinos.cn>, 
	Rui Qi <qirui.001@bytedance.com>, Howard Chu <howardchu95@gmail.com>, 
	Chuck Lever <cel@kernel.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Future changes will use build_id in more contexts. For consistency make
the struct its own type and update usage to be of this type.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/uapi/linux/perf_event.h | 19 +++++++++----
 tools/lib/perf/include/perf/event.h   | 18 +++++++-----
 tools/perf/builtin-inject.c           |  3 +-
 tools/perf/util/event.c               |  4 +--
 tools/perf/util/machine.c             |  3 +-
 tools/perf/util/python.c              |  8 +++---
 tools/perf/util/synthetic-events.c    | 40 +++++++++++++++------------
 7 files changed, 57 insertions(+), 38 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index fd10aa8d697f..2479a38883d0 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1058,6 +1058,18 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_SAMPLE			= 9,
 
+	/*
+	 * Build IDs may be present in a number of events. They have a
+	 * consistent encoding of:
+	 *
+	 * struct build_id {
+	 *	u8		size;
+	 *	u8		__reserved_1;
+	 *	u16		__reserved_2;
+	 *	u8		data[20];
+	 * };
+	 */
+
 	/*
 	 * The MMAP2 records are an augmented version of MMAP, they add
 	 * maj, min, ino numbers to be used to uniquely identify each mapping
@@ -1076,12 +1088,7 @@ enum perf_event_type {
 	 *			u64		ino;
 	 *			u64		ino_generation;
 	 *		};
-	 *		struct {
-	 *			u8		build_id_size;
-	 *			u8		__reserved_1;
-	 *			u16		__reserved_2;
-	 *			u8		build_id[20];
-	 *		};
+	 *		struct build_id		build_id;
 	 *	};
 	 *	u32				prot, flags;
 	 *	char				filename[];
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index fdced574c889..173eab43c148 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -26,6 +26,15 @@ struct perf_record_mmap {
 	char			 filename[PATH_MAX];
 };
 
+#define PERF_BUILD_ID_SIZE 20
+
+struct perf_build_id {
+	__u8	 size;
+	__u8	 __reserved_1;
+	__u16	 __reserved_2;
+	__u8	 data[PERF_BUILD_ID_SIZE];
+};
+
 struct perf_record_mmap2 {
 	struct perf_event_header header;
 	__u32			 pid, tid;
@@ -39,12 +48,7 @@ struct perf_record_mmap2 {
 			__u64	 ino;
 			__u64	 ino_generation;
 		};
-		struct {
-			__u8	 build_id_size;
-			__u8	 __reserved_1;
-			__u16	 __reserved_2;
-			__u8	 build_id[20];
-		};
+		struct perf_build_id build_id;
 	};
 	__u32			 prot;
 	__u32			 flags;
@@ -321,7 +325,7 @@ struct perf_record_header_build_id {
 	union {
 		__u8		 build_id[24];
 		struct {
-			__u8	 data[20];
+			__u8	 data[PERF_BUILD_ID_SIZE];
 			__u8	 size;
 			__u8	 reserved1__;
 			__u16	 reserved2__;
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 70bbfad5653e..8559c0eab5f1 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -811,7 +811,8 @@ static int perf_event__repipe_mmap2(const struct perf_tool *tool,
 	struct dso_id id = dso_id_empty;
 
 	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
-		build_id__init(&id.build_id, event->mmap2.build_id, event->mmap2.build_id_size);
+		build_id__init(&id.build_id, event->mmap2.build_id.data,
+			       event->mmap2.build_id.size);
 	} else {
 		id.maj = event->mmap2.maj;
 		id.min = event->mmap2.min;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index ea75816d126a..c69ae57ce679 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -335,8 +335,8 @@ size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp)
 		char sbuild_id[SBUILD_ID_SIZE];
 		struct build_id bid;
 
-		build_id__init(&bid, event->mmap2.build_id,
-			       event->mmap2.build_id_size);
+		build_id__init(&bid, event->mmap2.build_id.data,
+			       event->mmap2.build_id.size);
 		build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 
 		return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f86b3b7df742..21d54ebc866b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1797,7 +1797,8 @@ int machine__process_mmap2_event(struct machine *machine,
 		perf_event__fprintf_mmap2(event, stdout);
 
 	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
-		build_id__init(&dso_id.build_id, event->mmap2.build_id, event->mmap2.build_id_size);
+		build_id__init(&dso_id.build_id, event->mmap2.build_id.data,
+			       event->mmap2.build_id.size);
 	} else {
 		dso_id.maj = event->mmap2.maj;
 		dso_id.min = event->mmap2.min;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index af85c0771c44..d35190052d97 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -233,12 +233,12 @@ static PyObject *pyrf_mmap2_event__get_build_id(PyObject *self, void *closure __
 	if (!(pevent->event.header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID))
 		Py_RETURN_NONE;
 
-	int size = pevent->event.mmap2.build_id_size;
+	size_t size = pevent->event.mmap2.build_id.size;
 
-	if (size > 20)
-		size = 20;
+	if (size > sizeof(pevent->event.mmap2.build_id.data))
+		size = sizeof(pevent->event.mmap2.build_id.data);
 
-	return PyBytes_FromStringAndSize((const char *)pevent->event.mmap2.build_id, size);
+	return PyBytes_FromStringAndSize((const char *)pevent->event.mmap2.build_id.data, size);
 }
 
 static PyGetSetDef pyrf_mmap2_event__getset[] = {
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 75a32ae8ef62..f7dedfb6bab8 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -452,7 +452,7 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 	}
 
 	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
-		build_id__init(&dso_id.build_id, event->build_id, event->build_id_size);
+		build_id__init(&dso_id.build_id, event->build_id.data, event->build_id.size);
 	} else {
 		dso_id.maj = event->maj;
 		dso_id.min = event->min;
@@ -478,16 +478,20 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 	nsinfo__put(nsi);
 
 out:
+	event->build_id.__reserved_1 = 0;
+	event->build_id.__reserved_2 = 0;
 	if (rc == 0) {
-		memcpy(event->build_id, bid.data, sizeof(bid.data));
-		event->build_id_size = (u8) bid.size;
+		memcpy(event->build_id.data, bid.data, sizeof(bid.data));
+		event->build_id.size = (u8) bid.size;
 		event->header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
-		event->__reserved_1 = 0;
-		event->__reserved_2 = 0;
 
 		if (dso && !dso__has_build_id(dso))
 			dso__set_build_id(dso, &bid);
 	} else {
+		memset(&event->build_id, 0, sizeof(event->build_id));
+		event->build_id.size = 0;
+		event->header.misc &= ~PERF_RECORD_MISC_MMAP_BUILD_ID;
+
 		if (event->filename[0] == '/') {
 			pr_debug2("Failed to read build ID for %s\n",
 				  event->filename);
@@ -611,8 +615,10 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
 		event->mmap2.prot = prot;
 		event->mmap2.flags = flags;
 
-		if (!symbol_conf.no_buildid_mmap2)
-			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
+		if (!symbol_conf.no_buildid_mmap2) {
+			perf_record_mmap2__read_build_id(&event->mmap2, machine,
+							 /*is_kernel=*/false);
+		}
 
 		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
 			rc = -1;
@@ -807,12 +813,12 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
 
 		/* Clear stale build ID and entire union from previous module iteration */
 		event->mmap2.header.misc &= ~PERF_RECORD_MISC_MMAP_BUILD_ID;
-		memset(event->mmap2.build_id, 0, sizeof(event->mmap2.build_id));
-		event->mmap2.build_id_size = 0;
-		event->mmap2.__reserved_1 = 0;
-		event->mmap2.__reserved_2 = 0;
+		memset(event->mmap2.build_id.data, 0, sizeof(event->mmap2.build_id.data));
+		event->mmap2.build_id.size = 0;
+		event->mmap2.build_id.__reserved_1 = 0;
+		event->mmap2.build_id.__reserved_2 = 0;
 
-		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
+		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, /*is_kernel=*/false);
 	} else {
 		const char *long_name = dso__long_name(dso);
 
@@ -1293,7 +1299,7 @@ static int __perf_event__synthesize_kernel_mmap(const struct perf_tool *tool,
 		event->mmap2.len   = map__end(map) - event->mmap.start;
 		event->mmap2.pid   = machine->pid;
 
-		perf_record_mmap2__read_build_id(&event->mmap2, machine, true);
+		perf_record_mmap2__read_build_id(&event->mmap2, machine, /*is_kernel=*/true);
 	} else {
 		size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
 				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
@@ -2486,10 +2492,10 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 	ev.mmap2.len = len;
 	ev.mmap2.pgoff = pgoff;
 
-	ev.mmap2.build_id_size = bid->size;
-	if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
-		ev.mmap2.build_id_size = sizeof(ev.mmap2.build_id);
-	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
+	ev.mmap2.build_id.size = bid->size;
+	if (ev.mmap2.build_id.size > sizeof(ev.mmap2.build_id.data))
+		ev.build_id.size = sizeof(ev.mmap2.build_id.data);
+	memcpy(ev.mmap2.build_id.data, bid->data, ev.mmap2.build_id.size);
 
 	ev.mmap2.prot = prot;
 	ev.mmap2.flags = flags;
-- 
2.55.0.679.g6767b8d81c-goog


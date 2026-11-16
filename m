Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815129;
	b=TCpIsAFWuqEnlXPvCKnxuaGO2/DKxxh0oRrjkKv5umXC8zMUSz6JjQOad5i7Ee1JlL/w
	 zBijmuunRsWA6LdjHGBcMJ5qzwc/oEU6tEvFIxHvy5uTSiLY/EON1c8oqAyGQ3NY5KP76
	 xLciHcSDp+et8XaLtdc1Y2qjbtmHzmGAg9QVedxYoNP2QSPQiIEzeVqLEGHgurMdKHvpW
	 ac4r0GvZo8TXc1/PkmOVZgPYtB2WatJbsr43JaKBbA2yEBcnMnU05yHjSUiPyRYKtOkaB
	 w3mIcuG3n5yt8dMJCxyna03/d8THw1pK9FSVRbOEt/WrDmC+Kp/j4vUr1NSdmqV43qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=c7hQtHwQFKlv/0gfya55v+DdzXt6nIzR/TMCTaOjEKM=;
	b=P0pk/yK4MjXz9a5x2f1axeQ0J+jApXC1IF5doPiEyKKkoxQUJ7+ncudybNgBrH3G7dw+
	 FihfKPkUdPM2PAIPooqLfvAuzHQIixlcBelUdU+glRsv9TpSMhGDkxKp864VS+OX1NBpB
	 ZCM/2HWp2P+ur+TZTwnxnWGrFzfJzanYrtfpL4ksY3N++ygHeKq8nTkYn2ZIHGV97J0gE
	 UfoWs8GuelpOY8GJ/N3taXlQ6drvdDrup0x8YZTgUL4GRcTo5CmK0WkeBtRBuq+AU/MUc
	 +TGmlGImcgRVRgjpZvWW/QZdLsC+EIPgFJcOz3rLRQ/HX/SgZjwUYn16CDorrjDK70A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hhFGh2Eu;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7ED606A8A1
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F7ED606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hhFGh2Eu
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso4012886eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815127; x=1795419927; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7hQtHwQFKlv/0gfya55v+DdzXt6nIzR/TMCTaOjEKM=;
        b=hhFGh2EuzQkFCrF8mS+4X6Q3kwPhAuV2zdKGBIbCb+e/AR+ay5O3PwfPdKFZjwqjD2
         bsTUlW6zSQIJdaN4G9ErmYvYGjqlL+3JOfrsI+13zbjDftDn+uGu/HQDrJnCAAgf01E1
         2sclThx4s8XsxvUuzP7FC5kR8hlSW2y4f4MDa7TSJKyLEu6HmiWWLicOxiifgqoOe2kh
         ZbcLHP5lgsU2NPIoUMt20Wf1JaW9WTXix/AEhmwLerREtMaX3AYZ3+1yD8q+2qzkHH/g
         DuXC8vwVASwMJaGfyUeXsFIvq/y9b/Ei6WNqf3H66aqN9ntPSmMPjrXEkrjiR9BrZOr3
         co/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815127; x=1795419927;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7hQtHwQFKlv/0gfya55v+DdzXt6nIzR/TMCTaOjEKM=;
        b=i6tl/yhCHFBMkatrAHV9ed/lmf2qLQsopihjrFqAL/v3CxRhmN6W3bAD6NUXyequ3H
         afltN9QbaKNWtr+sBzU+WhmlWkVn3zlcjlJc2Ik/lYUSAeDAILiQgxE6W+cVwinnhQLp
         Y9Z82MOT6qkUUoBvu8GQSAXjxvn6qEzflB/94J2YS+tAL6Gu90nUFwQFKwnmkHE5JJIP
         oeiO1uUySD1NYmrWaUXP4BZTr4JIrH86zme9MlzupzvJ7CfCu9ZKJ4UEuq5SXUU3rZnd
         /IpcBVUtzR8mqnsl2eIFrech8DDOh3MRcK0phLjCmdgnFrst0oAD/48kxASnJlyb8eOW
         HWpw==
X-Forwarded-Encrypted: i=1; AL+hErE+9P3OZsx8MNcTkrTP8GGWp8Oqxi1S2JouDK3QKNJvFuLaNWhya32O0/BgwPh+TYoHUWsCvQO6Lrn6JEx2TnM8@vger.kernel.org
X-Gm-Message-State: APuU4Z9QSyvxvKoQuzkly5JsK8ZCKI0psiPxQl+Yl28NuWjiCIYFt24U
	Nwg5+LShhR/p+krqk7I+X0WAO6iYDaH4qJaj4o5VF/0nMUExC2bhwz/1lNaN2CQc6OMUCE+xEGV
	OIOzMdIAfJw==
X-Received: from dybtv9.prod.google.com ([2002:a05:7300:f489:b0:36d:8068:9180])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:87d7:20b0:35f:8c5d:5928
 with SMTP id 5a478bee46e88-37967125e78mr8805064eec.30.1794815127027; Sun, 15
 Nov 2026 23:45:27 -0800 (PST)
Date: Sun, 15 Nov 2026 23:44:05 -0800
In-Reply-To: <20261116074414.3174737-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116074414.3174737-11-irogers@google.com>
Subject: [PATCH v3 10/19] tools headers UAPI: Sync linux/perf_event.h for
 struct perf_build_id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Synchronize tools/include/uapi/linux/perf_event.h, define struct
perf_build_id in tools/lib/perf/include/perf/event.h (keeping the
existing anonymous build_id_size/build_id fields in struct
perf_record_mmap2 for source compatibility), and update perf tools to
use struct perf_build_id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/uapi/linux/perf_event.h | 13 ++++++++++
 tools/lib/perf/include/perf/event.h   | 14 +++++++++--
 tools/perf/builtin-inject.c           |  3 ++-
 tools/perf/util/event.c               |  4 +--
 tools/perf/util/machine.c             |  3 ++-
 tools/perf/util/python.c              |  8 +++---
 tools/perf/util/synthetic-events.c    | 36 ++++++++++++++-------------
 7 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index c49fc76292f7..deb7c42d109b 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1099,6 +1099,18 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_SAMPLE			= 9,
 
+	/*
+	 * Build IDs may be present in a number of events. They have a
+	 * consistent encoding of:
+	 *
+	 * struct perf_build_id {
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
@@ -1123,6 +1135,7 @@ enum perf_event_type {
 	 *			u16		__reserved_2;
 	 *			u8		build_id[20];
 	 *		};
+	 *		struct perf_build_id	bid;
 	 *	};
 	 *	u32				prot, flags;
 	 *	char				filename[];
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index fdced574c889..867dd55f0969 100644
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
@@ -43,8 +52,9 @@ struct perf_record_mmap2 {
 			__u8	 build_id_size;
 			__u8	 __reserved_1;
 			__u16	 __reserved_2;
-			__u8	 build_id[20];
+			__u8	 build_id[PERF_BUILD_ID_SIZE];
 		};
+		struct perf_build_id bid;
 	};
 	__u32			 prot;
 	__u32			 flags;
@@ -321,7 +331,7 @@ struct perf_record_header_build_id {
 	union {
 		__u8		 build_id[24];
 		struct {
-			__u8	 data[20];
+			__u8	 data[PERF_BUILD_ID_SIZE];
 			__u8	 size;
 			__u8	 reserved1__;
 			__u16	 reserved2__;
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index b887a4398f96..a278c360b058 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -811,7 +811,8 @@ static int perf_event__repipe_mmap2(const struct perf_tool *tool,
 	struct dso_id id = dso_id_empty;
 
 	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
-		build_id__init(&id.build_id, event->mmap2.build_id, event->mmap2.build_id_size);
+		build_id__init(&id.build_id, event->mmap2.bid.data,
+			       event->mmap2.bid.size);
 	} else {
 		id.maj = event->mmap2.maj;
 		id.min = event->mmap2.min;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 2f80e364659f..cefb32833da8 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -335,8 +335,8 @@ size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp)
 		char sbuild_id[SBUILD_ID_SIZE];
 		struct build_id bid;
 
-		build_id__init(&bid, event->mmap2.build_id,
-			       event->mmap2.build_id_size);
+		build_id__init(&bid, event->mmap2.bid.data,
+			       event->mmap2.bid.size);
 		build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 
 		return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5b4550e97172..c7f5ef32d5bd 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1828,7 +1828,8 @@ int machine__process_mmap2_event(struct machine *machine,
 		perf_event__fprintf_mmap2(event, stdout);
 
 	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
-		build_id__init(&dso_id.build_id, event->mmap2.build_id, event->mmap2.build_id_size);
+		build_id__init(&dso_id.build_id, event->mmap2.bid.data,
+			       event->mmap2.bid.size);
 	} else {
 		dso_id.maj = event->mmap2.maj;
 		dso_id.min = event->mmap2.min;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 902157c472b3..1efbe5bb26b1 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -302,12 +302,12 @@ static PyObject *pyrf_mmap2_event__get_build_id(PyObject *self, void *closure __
 	if (!(pevent->event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID))
 		Py_RETURN_NONE;
 
-	int size = pevent->event->mmap2.build_id_size;
+	size_t size = pevent->event->mmap2.bid.size;
 
-	if (size > 20)
-		size = 20;
+	if (size > sizeof(pevent->event->mmap2.bid.data))
+		size = sizeof(pevent->event->mmap2.bid.data);
 
-	return PyBytes_FromStringAndSize((const char *)pevent->event->mmap2.build_id, size);
+	return PyBytes_FromStringAndSize((const char *)pevent->event->mmap2.bid.data, size);
 }
 
 static PyGetSetDef pyrf_mmap2_event__getset[] = {
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3c8d29f27fd9..57d6efe9e5f5 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -452,7 +452,7 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 	}
 
 	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
-		build_id__init(&dso_id.build_id, event->build_id, event->build_id_size);
+		build_id__init(&dso_id.build_id, event->bid.data, event->bid.size);
 	} else {
 		dso_id.maj = event->maj;
 		dso_id.min = event->min;
@@ -479,11 +479,11 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 
 out:
 	if (rc == 0) {
-		memcpy(event->build_id, bid.data, sizeof(bid.data));
-		event->build_id_size = (u8) bid.size;
+		memcpy(event->bid.data, bid.data, sizeof(bid.data));
+		event->bid.size = (u8) bid.size;
 		event->header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
-		event->__reserved_1 = 0;
-		event->__reserved_2 = 0;
+		event->bid.__reserved_1 = 0;
+		event->bid.__reserved_2 = 0;
 
 		if (dso && !dso__has_build_id(dso))
 			dso__set_build_id(dso, &bid);
@@ -611,8 +611,10 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
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
@@ -807,12 +809,12 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
 
 		/* Clear stale build ID and entire union from previous module iteration */
 		event->mmap2.header.misc &= ~PERF_RECORD_MISC_MMAP_BUILD_ID;
-		memset(event->mmap2.build_id, 0, sizeof(event->mmap2.build_id));
-		event->mmap2.build_id_size = 0;
-		event->mmap2.__reserved_1 = 0;
-		event->mmap2.__reserved_2 = 0;
+		memset(event->mmap2.bid.data, 0, sizeof(event->mmap2.bid.data));
+		event->mmap2.bid.size = 0;
+		event->mmap2.bid.__reserved_1 = 0;
+		event->mmap2.bid.__reserved_2 = 0;
 
-		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
+		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, /*is_kernel=*/false);
 	} else {
 		const char *long_name = dso__long_name(dso);
 
@@ -1299,7 +1301,7 @@ static int __perf_event__synthesize_kernel_mmap(const struct perf_tool *tool,
 		event->mmap2.len   = map__end(map) - event->mmap.start;
 		event->mmap2.pid   = machine->pid;
 
-		perf_record_mmap2__read_build_id(&event->mmap2, machine, true);
+		perf_record_mmap2__read_build_id(&event->mmap2, machine, /*is_kernel=*/true);
 	} else {
 		size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
 				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
@@ -2530,10 +2532,10 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 	ev.mmap2.len = len;
 	ev.mmap2.pgoff = pgoff;
 
-	ev.mmap2.build_id_size = bid->size;
-	if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
-		ev.mmap2.build_id_size = sizeof(ev.mmap2.build_id);
-	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
+	ev.mmap2.bid.size = bid->size;
+	if (ev.mmap2.bid.size > sizeof(ev.mmap2.bid.data))
+		ev.mmap2.bid.size = sizeof(ev.mmap2.bid.data);
+	memcpy(ev.mmap2.bid.data, bid->data, ev.mmap2.bid.size);
 
 	ev.mmap2.prot = prot;
 	ev.mmap2.flags = flags;
-- 
2.56.1.703.gf848ed807c-goog


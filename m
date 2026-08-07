Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64DB3C1983
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087121; cv=none; b=UzRwEuFh7luFX/7JIuWJ4WdiL8RGI+ePc/OdkIQMGco66YxcU4hnXsleYw1eKaN6sfd2vjxFw8XYx8KigfZxcesMn87BYPo7HnCoTzs7zWm0MVhvSE0hoZaTH+GIQZq0OKYJLyQkWyEr9paAL/nTJKziu8RcNlPqAiyIWGpouLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087121; c=relaxed/simple;
	bh=S9QT8b0kd2xRVLf3lLP5oiZ/aD5o4IvDCLPYvHHsR7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cdglo4rTrFiaPpI1MUOrbVWCmO9bde0DmOQgDbOhd78ujMLxkjlrS3rEY4k77y/hK0U9rcbQMZcCwAnugLvwS9R2hNJrJT2GlFnthT+sOaERHJ28Kyz1ADyCAZFjHVC2tVGDxvWHt/yncwdJv+uWrLY1uap10BHr/zaRdDWsM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNF0Ynmh; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNF0Ynmh"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d001671a54so57532055ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 00:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786087118; x=1786691918; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MgsJriLIU9dRPdYwuhTOgbzKSY3swUpCCJFzn9PAz+E=;
        b=rNF0YnmhP0fx0ELiTjufJhyMvioSI08C6gBIFsGubuOP6J7svkX9E2LALnPr9PyuDv
         htGiq2j+TeC8H0O23I1CfYEEdAyzyy7L/vmUK4PpXy14QtaH46htOHBqJIb8HlRuRN64
         TueYWHIi0T7C6LZteq/iMLaid9UOpkHbvv1H1qdpGA/mjhx+K5SwqNdMWOhX6GTM+uGg
         tYqJ257IEVqRAIq5rBIg2LaphaJ3si/AV5aC8oseR34KqPOzNpQBsvi2YynJornR5L4h
         DDU/U8CthYBth2dI6yq2YmC5AQANzmIFKG6pF+pyHZ9uWewUpIac+QX1axoi/12jaM4t
         lWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786087118; x=1786691918;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MgsJriLIU9dRPdYwuhTOgbzKSY3swUpCCJFzn9PAz+E=;
        b=So7pb9bNOzkrkzxZPCGcyqDU/HoNavlm7wb4nfcqZeSdzITldSXjdq1kVXhHS9mfuS
         7LXEFSywuM52oALa+MjJiOmYSV0TTafKZrqYzc3ZWVXe1O90h9UGM+5w613BNVkrx1F9
         OsaoRBqDtP2Z/50AKCJdjgP1AT44ABsfHRBaCKGLVOgBXwrt/M90eKcfe+6Hwvukbs2W
         IdT64qSQdn68qk8KT5BdxNP1CHrdKeKZCCxuZaAIjeHpZjZqUTx0xqkLCgvZN2hix3G3
         xAfIcnvDPkjccTUDYlYdEfKWdSrIrFyqEwbZualey5IchXtum9Ys1IDMPzNiNqB+aHsw
         2HoQ==
X-Forwarded-Encrypted: i=1; AHgh+RrulOEK4mx6MNnx1Xhys+qovfh3Gw+BhtySDDZ3dGJfsznI+rKv/d2cG6ne0sJmjkv7URTIrS1CPX5Hf4RS2UnG@vger.kernel.org
X-Gm-Message-State: AOJu0YySd/rys115mhSdtCNlp/C8UEs5IlAyB1jKHPoVAUZjexVWz/ds
	9vIl84x+hBw9QSa1zjXrHzq0gIj5qn1FkcsB4GGzMZk76UqeZdUnP3Yn2Egl1H+64bWvfY7749b
	CWVI+Yf1UGA==
X-Received: from dybmx3.prod.google.com ([2002:a05:7300:d403:b0:315:a379:c9e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:914b:b0:3c3:bbe6:95b1
 with SMTP id adf61e73a8af0-3cb85eef9d6mr21031304637.24.1786087117513; Fri, 07
 Aug 2026 00:18:37 -0700 (PDT)
Date: Fri,  7 Aug 2026 00:18:16 -0700
In-Reply-To: <20260807071818.718751-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807071818.718751-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807071818.718751-7-irogers@google.com>
Subject: [RFC PATCH v1 6/8] perf inject: Extend perf inject to support
 bid_offset conversion
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

This adds the --sample-buildids option to perf inject, allowing it to
drop MMAP events and rewrite samples to use build IDs and offsets
instead of virtual addresses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c         |  14 +-
 tools/perf/util/Build               |   1 +
 tools/perf/util/inject_bid_offset.c | 504 ++++++++++++++++++++++++++++
 tools/perf/util/inject_bid_offset.h |  21 ++
 4 files changed, 539 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/inject_bid_offset.c
 create mode 100644 tools/perf/util/inject_bid_offset.h

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6aa9e3eea438..8f8d5267a37e 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -9,6 +9,7 @@
 #include "builtin.h"
 
 #include "util/aslr.h"
+#include "util/inject_bid_offset.h"
 #include "util/color.h"
 #include "util/dso.h"
 #include "util/vdso.h"
@@ -112,6 +113,7 @@ enum build_id_rewrite_style {
 	BID_RWS__INJECT_HEADER_ALL,
 	BID_RWS__MMAP2_BUILDID_ALL,
 	BID_RWS__MMAP2_BUILDID_LAZY,
+	BID_RWS__SAMPLE_BUILDID,
 };
 
 struct perf_inject {
@@ -371,7 +373,7 @@ static s64 perf_event__repipe_auxtrace(const struct perf_tool *tool,
 	return event->auxtrace.size;
 }
 
-static int perf_event__repipe(const struct perf_tool *tool,
+int perf_event__repipe(const struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample __maybe_unused,
 			      struct machine *machine __maybe_unused)
@@ -2687,6 +2689,7 @@ int cmd_inject(int argc, const char **argv)
 	bool build_id_all = false;
 	bool mmap2_build_ids = false;
 	bool mmap2_build_id_all = false;
+	bool build_id_sample = false;
 
 	struct option options[] = {
 		OPT_BOOLEAN('b', "build-ids", &build_ids,
@@ -2695,8 +2698,11 @@ int cmd_inject(int argc, const char **argv)
 			    "Inject build-ids of all DSOs into the output stream"),
 		OPT_BOOLEAN('B', "mmap2-buildids", &mmap2_build_ids,
 			    "Drop unused mmap events, make others mmap2 with build IDs"),
+
 		OPT_BOOLEAN(0, "mmap2-buildid-all", &mmap2_build_id_all,
 			    "Rewrite all mmap events as mmap2 events with build IDs"),
+		OPT_BOOLEAN('S', "sample-buildids", &build_id_sample,
+			    "Drop all mmap events and rewrite samples to use build ID + offset"),
 		OPT_STRING(0, "known-build-ids", &known_build_ids,
 			   "buildid path [,buildid path...]",
 			   "build-ids to use for given paths"),
@@ -2815,8 +2821,11 @@ int cmd_inject(int argc, const char **argv)
 		inject.build_id_style = BID_RWS__MMAP2_BUILDID_ALL;
 	if (build_ids)
 		inject.build_id_style = BID_RWS__INJECT_HEADER_LAZY;
+
 	if (build_id_all)
 		inject.build_id_style = BID_RWS__INJECT_HEADER_ALL;
+	if (build_id_sample)
+		inject.build_id_style = BID_RWS__SAMPLE_BUILDID;
 
 	data.path = inject.input_name;
 
@@ -2880,8 +2889,11 @@ int cmd_inject(int argc, const char **argv)
 
 	if (IS_ERR(inject.session)) {
 		ret = PTR_ERR(inject.session);
+
 		if (inject.aslr)
 			aslr_tool__delete(tool);
+		if (inject.build_id_style == BID_RWS__SAMPLE_BUILDID)
+			inject_bid_offset_tool__delete(tool);
 		goto out_close_output;
 	}
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 330311cac550..cefbf2ef3fac 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -7,6 +7,7 @@ perf-util-y += addr2line.o
 perf-util-y += addr_location.o
 perf-util-y += annotate.o
 perf-util-y += aslr.o
+perf-util-y += inject_bid_offset.o
 perf-util-y += blake2s.o
 perf-util-y += block-info.o
 perf-util-y += block-range.o
diff --git a/tools/perf/util/inject_bid_offset.c b/tools/perf/util/inject_bid_offset.c
new file mode 100644
index 000000000000..f7b5fb05fac7
--- /dev/null
+++ b/tools/perf/util/inject_bid_offset.c
@@ -0,0 +1,504 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "inject_bid_offset.h"
+
+#include <stdlib.h>
+
+#include <linux/compiler.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+
+#include "addr_location.h"
+#include "debug.h"
+#include "dso.h"
+#include "event.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "machine.h"
+#include "map.h"
+#include "session.h"
+#include "synthetic-events.h"
+#include "thread.h"
+#include "tool.h"
+
+struct inject_bid_offset_tool {
+	struct delegate_tool tool;
+	char event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+};
+
+int perf_event__rewrite_attr_for_build_id_offset(struct perf_event_attr *attr)
+{
+	if (attr->sample_type & (PERF_SAMPLE_BUILD_ID_OFFSET |
+				 PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)) {
+		/*
+		 * Expect to add build ID information from virtual address, if
+		 * it is already present then things would be confused so fail.
+		 */
+		return -1;
+	}
+	if (attr->sample_type & PERF_SAMPLE_IP) {
+		attr->sample_type &= ~PERF_SAMPLE_IP;
+		attr->sample_type |= PERF_SAMPLE_BUILD_ID_OFFSET;
+	}
+	if (attr->sample_type & PERF_SAMPLE_CALLCHAIN) {
+		attr->sample_type &= ~PERF_SAMPLE_CALLCHAIN;
+		attr->sample_type |= PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET;
+	}
+	return 0;
+}
+
+int perf_event__rewrite_attr_for_sample_ip(struct perf_event_attr *attr)
+{
+	if (attr->sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CALLCHAIN)) {
+		/*
+		 * Expect to remove build ID information for virtual address, if
+		 * it is already present then things would be confused so fail.
+		 */
+		return -1;
+	}
+	if (attr->sample_type & PERF_SAMPLE_BUILD_ID_OFFSET) {
+		attr->sample_type &= ~PERF_SAMPLE_BUILD_ID_OFFSET;
+		attr->sample_type |= PERF_SAMPLE_IP;
+	}
+	if (attr->sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		attr->sample_type &= ~PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET;
+		attr->sample_type |= PERF_SAMPLE_CALLCHAIN;
+	}
+	return 0;
+}
+
+static void perf_event__inject_sample_buildid_array(struct thread *thread,
+						    u64 ip, u8 cpumode,
+						    __u64 *array)
+{
+	struct perf_build_id bid = { .size = 0 };
+	u64 offset = ip;
+	struct addr_location al;
+	struct dso *dso;
+	const struct build_id *dso_bid;
+
+	struct perf_sample ps = { .ip = ip, .cpumode = cpumode };
+
+	addr_location__init(&al);
+
+	if (!thread)
+		goto write_bid;
+
+	if (!thread__find_map(thread, &ps, &al))
+		goto write_bid;
+
+	dso = al.map ? dso__get(map__dso(al.map)) : NULL;
+	if (!dso)
+		goto write_bid;
+	dso_bid = dso__bid(dso);
+	if (!dso_bid) {
+		dso__put(dso);
+		goto write_bid;
+	}
+
+	bid.size = dso_bid->size;
+	if (bid.size > sizeof(bid.data))
+		bid.size = sizeof(bid.data);
+	memcpy(bid.data, &dso_bid->data, bid.size);
+	offset = map__dso_map_ip(al.map, offset);
+	dso__put(dso);
+
+write_bid:
+	compiletime_assert(sizeof(struct perf_build_id) == 3 * sizeof(u64),
+			   "Unexpected perf_build_id size");
+	memcpy(&array[0], &bid, 3 * sizeof(u64));
+	array[3] = offset;
+	addr_location__exit(&al);
+}
+
+static void mark_dso_hit(const struct perf_tool *tool,
+			 struct perf_sample *sample, struct machine *machine,
+			 struct thread *thread, u64 ip, u8 cpumode)
+{
+	struct addr_location al;
+	struct dso *dso;
+
+	struct perf_sample ps = { .ip = ip, .cpumode = cpumode };
+
+	addr_location__init(&al);
+
+	if (thread__find_map(thread, &ps, &al)) {
+		dso = al.map ? dso__get(map__dso(al.map)) : NULL;
+		if (dso) {
+			if (!dso__hit(dso)) {
+				const struct build_id *bid = dso__bid(dso);
+
+				dso__set_hit(dso);
+				if (bid) {
+					perf_event__synthesize_build_id(
+						tool, sample, machine,
+						perf_event__repipe,
+						dso__kernel(dso) ?
+							PERF_RECORD_MISC_KERNEL :
+							PERF_RECORD_MISC_USER,
+						bid, dso->long_name);
+				}
+			}
+			dso__put(dso);
+		}
+	}
+	addr_location__exit(&al);
+}
+
+static int inject_bid_offset_tool__sample(const struct perf_tool *tool,
+					  union perf_event *event,
+					  struct perf_sample *sample,
+					  struct machine *machine)
+{
+	struct delegate_tool *dt =
+		container_of(tool, struct delegate_tool, tool);
+	struct inject_bid_offset_tool *ibo =
+		container_of(dt, struct inject_bid_offset_tool, tool);
+	union perf_event *ev;
+	struct evsel *evsel = sample->evsel;
+	__u64 i = 0, j = 0;
+	__u64 *in_array, *out_array;
+	__u64 sample_type = evsel->core.attr.sample_type;
+	const __u64 max_i = event->header.size / sizeof(__u64);
+	struct thread *thread;
+	u16 max_size = event->header.size;
+
+	if ((sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CALLCHAIN)) == 0)
+		return ibo->tool.delegate->sample(ibo->tool.delegate, event,
+						  sample, machine);
+
+	if (symbol_conf.guest_code && !machine__is_host(machine))
+		thread = machine__findnew_guest_code(machine, sample->pid);
+	else
+		thread = machine__findnew_thread(machine, sample->pid,
+						 sample->tid);
+
+	if (sample_type & PERF_SAMPLE_IP)
+		max_size += sizeof(struct perf_build_id) + sizeof(u64) -
+			    sizeof(u64);
+
+	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+		max_size +=
+			sample->callchain->nr * (sizeof(struct perf_build_id) +
+						 sizeof(u64) - sizeof(u64));
+	}
+
+	if (max_size > PERF_SAMPLE_MAX_SIZE) {
+		pr_debug("Insufficient space to copy event\n");
+		thread__put(thread);
+		return -E2BIG;
+	}
+
+	ev = (union perf_event *)ibo->event_copy;
+	ev->sample.header =
+		(struct perf_event_header){ .type = event->header.type,
+					    .misc = event->header.misc,
+					    .size = max_size };
+
+	in_array = &event->sample.array[0];
+	out_array = &ev->sample.array[0];
+
+	if (sample_type & PERF_SAMPLE_IDENTIFIER) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_IP) {
+		i++;
+		if (evsel && thread)
+			mark_dso_hit(ibo->tool.delegate, sample, machine,
+				     thread, sample->ip, sample->cpumode);
+	}
+	if (sample_type & PERF_SAMPLE_TID) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_TIME) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_ADDR) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_ID) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_STREAM_ID) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_CPU) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_PERIOD) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_READ) {
+		if ((evsel->core.attr.read_format & PERF_FORMAT_GROUP) == 0) {
+			if (i > max_i)
+				goto err;
+			out_array[j++] = in_array[i++];
+			if (evsel->core.attr.read_format &
+			    PERF_FORMAT_TOTAL_TIME_ENABLED)
+				if (i > max_i)
+					goto err;
+			out_array[j++] = in_array[i++];
+			if (evsel->core.attr.read_format &
+			    PERF_FORMAT_TOTAL_TIME_RUNNING)
+				if (i > max_i)
+					goto err;
+			out_array[j++] = in_array[i++];
+			if (evsel->core.attr.read_format & PERF_FORMAT_ID)
+				if (i > max_i)
+					goto err;
+			out_array[j++] = in_array[i++];
+			if (evsel->core.attr.read_format & PERF_FORMAT_LOST)
+				if (i > max_i)
+					goto err;
+			out_array[j++] = in_array[i++];
+		} else {
+			u64 nr;
+
+			if (i > max_i)
+				goto err;
+			nr = out_array[j++] = in_array[i++];
+			if (evsel->core.attr.read_format &
+			    PERF_FORMAT_TOTAL_TIME_ENABLED)
+				if (i > max_i)
+					goto err;
+			out_array[j++] = in_array[i++];
+			if (evsel->core.attr.read_format &
+			    PERF_FORMAT_TOTAL_TIME_RUNNING)
+				if (i > max_i)
+					goto err;
+			out_array[j++] = in_array[i++];
+			for (u64 cntr = 0; cntr < nr; cntr++) {
+				if (i > max_i)
+					goto err;
+				out_array[j++] = in_array[i++];
+				if (evsel->core.attr.read_format &
+				    PERF_FORMAT_ID)
+					if (i > max_i)
+						goto err;
+				out_array[j++] = in_array[i++];
+				if (evsel->core.attr.read_format &
+				    PERF_FORMAT_LOST)
+					if (i > max_i)
+						goto err;
+				out_array[j++] = in_array[i++];
+			}
+		}
+	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+		i++;
+		if (evsel && thread) {
+			for (u64 x = 0; x < sample->callchain->nr; x++)
+				mark_dso_hit(ibo->tool.delegate, sample,
+					     machine, thread,
+					     sample->callchain->ips[x],
+					     sample->cpumode);
+		}
+		i += sample->callchain->nr;
+	}
+	if (sample_type & PERF_SAMPLE_RAW) {
+		size_t bytes = sizeof(u32) + sample->raw_size;
+
+		if ((i + (bytes / sizeof(u64))) > max_i)
+			goto err;
+		memcpy(&out_array[j], &in_array[i], bytes);
+		i += bytes / sizeof(u64);
+		j += bytes / sizeof(u64);
+	}
+	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+		if (sample_type & PERF_SAMPLE_BRANCH_HW_INDEX) {
+			if (i > max_i)
+				goto err;
+			out_array[j++] = in_array[i++];
+		}
+		if (i + (sample->branch_stack->nr * 3) > max_i)
+			goto err;
+		memcpy(&out_array[j], &in_array[i],
+		       sample->branch_stack->nr * 3 * sizeof(u64));
+		i += sample->branch_stack->nr * 3;
+		j += sample->branch_stack->nr * 3;
+		if (sample_type & PERF_SAMPLE_BRANCH_COUNTERS) {
+			if (i + sample->branch_stack->nr > max_i)
+				goto err;
+			memcpy(&out_array[j], &in_array[i],
+			       sample->branch_stack->nr * sizeof(u64));
+			i += sample->branch_stack->nr;
+			j += sample->branch_stack->nr;
+		}
+	}
+	if (sample_type & PERF_SAMPLE_REGS_USER) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+		if (sample->user_regs->abi != PERF_SAMPLE_REGS_ABI_NONE) {
+			u64 nr = hweight64(evsel->core.attr.sample_regs_user);
+
+			if (i + nr > max_i)
+				goto err;
+			memcpy(&out_array[j], &in_array[i], nr * sizeof(u64));
+			i += nr;
+			j += nr;
+		}
+	}
+	if (sample_type & PERF_SAMPLE_STACK_USER) {
+		u64 size;
+
+		if (i > max_i)
+			goto err;
+		size = out_array[j++] = in_array[i++];
+		if (size > 0) {
+			memcpy(&out_array[j], &in_array[i], size);
+			i += size / sizeof(u64);
+			j += size / sizeof(u64);
+			if (i > max_i)
+				goto err;
+			out_array[j++] = in_array[i++];
+		}
+	}
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_DATA_SRC) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_TRANSACTION) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+		if (sample->intr_regs->abi != PERF_SAMPLE_REGS_ABI_NONE) {
+			u64 nr = hweight64(evsel->core.attr.sample_regs_intr);
+
+			if (i + nr > max_i)
+				goto err;
+			memcpy(&out_array[j], &in_array[i], nr * sizeof(u64));
+			i += nr;
+			j += nr;
+		}
+	}
+	if (sample_type & PERF_SAMPLE_PHYS_ADDR) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_CGROUP) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE) {
+		if (i > max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_AUX) {
+		u64 size;
+
+		if (i > max_i)
+			goto err;
+		size = out_array[j++] = in_array[i++];
+		if (i + (size / sizeof(u64)) > max_i)
+			goto err;
+		memcpy(&out_array[j], &in_array[i], size);
+		i += size / sizeof(u64);
+		j += size / sizeof(u64);
+	}
+
+	if (sample_type & PERF_SAMPLE_IP) {
+		perf_event__inject_sample_buildid_array(
+			thread, sample->ip, sample->cpumode, &out_array[j]);
+		j += 4;
+	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+		out_array[j++] = sample->callchain->nr;
+		for (u64 x = 0; x < sample->callchain->nr; x++) {
+			perf_event__inject_sample_buildid_array(
+				thread, sample->callchain->ips[x],
+				sample->cpumode, &out_array[j]);
+			j += 4;
+		}
+	}
+
+	thread__put(thread);
+
+	return ibo->tool.delegate->sample(ibo->tool.delegate, ev, sample,
+					  machine);
+
+err:
+	thread__put(thread);
+	return -EFAULT;
+}
+
+static int
+inject_bid_offset_tool__mmap(const struct perf_tool *tool __maybe_unused,
+			     union perf_event *event,
+			     struct perf_sample *sample,
+			     struct machine *machine)
+{
+	perf_event__process_mmap(tool, event, sample, machine);
+	return 0; // Drop mmap events from output stream
+}
+static int
+inject_bid_offset_tool__mmap2(const struct perf_tool *tool __maybe_unused,
+			      union perf_event *event,
+			      struct perf_sample *sample,
+			      struct machine *machine)
+{
+	perf_event__process_mmap2(tool, event, sample, machine);
+	return 0; // Drop mmap2 events from output stream
+}
+
+struct perf_tool *inject_bid_offset_tool__new(struct perf_tool *delegate)
+{
+	struct inject_bid_offset_tool *ibo = zalloc(sizeof(*ibo));
+
+	if (!ibo)
+		return NULL;
+
+	delegate_tool__init(&ibo->tool, delegate);
+	ibo->tool.tool.sample = inject_bid_offset_tool__sample;
+	ibo->tool.tool.mmap = inject_bid_offset_tool__mmap;
+	ibo->tool.tool.mmap2 = inject_bid_offset_tool__mmap2;
+
+	return &ibo->tool.tool;
+}
+
+void inject_bid_offset_tool__delete(struct perf_tool *tool)
+{
+	struct delegate_tool *dt;
+
+	if (!tool)
+		return;
+	dt = container_of(tool, struct delegate_tool, tool);
+	free(container_of(dt, struct inject_bid_offset_tool, tool));
+}
diff --git a/tools/perf/util/inject_bid_offset.h b/tools/perf/util/inject_bid_offset.h
new file mode 100644
index 000000000000..e4cfea255f6b
--- /dev/null
+++ b/tools/perf/util/inject_bid_offset.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_INJECT_BID_OFFSET_H
+#define __PERF_INJECT_BID_OFFSET_H
+
+#include <linux/perf_event.h>
+
+struct perf_tool;
+struct evlist;
+
+int perf_event__rewrite_attr_for_build_id_offset(struct perf_event_attr *attr);
+int perf_event__rewrite_attr_for_sample_ip(struct perf_event_attr *attr);
+union perf_event;
+struct perf_sample;
+struct machine;
+
+int perf_event__repipe(const struct perf_tool *tool, union perf_event *event,
+			struct perf_sample *sample, struct machine *machine);
+struct perf_tool *inject_bid_offset_tool__new(struct perf_tool *delegate);
+void inject_bid_offset_tool__delete(struct perf_tool *tool);
+
+#endif /* __PERF_INJECT_BID_OFFSET_H */
-- 
2.55.0.679.g6767b8d81c-goog


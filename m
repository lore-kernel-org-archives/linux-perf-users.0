Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468C2F60B2
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962781; cv=none; b=NZ3lBgak2B+pe4m+Fa1ZEdcT0OWFYbqKz3NaU3IrqT9RICX8lpZRRH9GS1x/X94JGlK0ZEGjxtQX4nfYeVJA6LIEYTzd6qdDhifkTwWNWyIYl5IOCxOpD7AqlmxzuH5RA5ZzwoU/+XaXm6ToF2OuFv+xMnhArAn1cYo5NLxsbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962781; c=relaxed/simple;
	bh=QjJKfN7nTQJmA0IVVmefsuFfTOy5a2/UFPf8mngU+pg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D8pRW0ikRfgtVt8mzkhdOp6WHVPm9kHX7IGibE9AqW1TSbobRPsw66U0RHmtUcrFvAwz0yKrPNOUNxqTOONxe0KfT8EtX1XLxnYrLdtnFu6eVOm/L/ec1gmV53n3D1vfqTGZ+3qmCqup/fhqDda6+tgprxTCRed0x7SiiIsVo6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CrtoaPex; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrtoaPex"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-34ef5fd7934so2337094eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790962766; x=1791567566; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RNwYhP3lAcHxRgenr2SVK7uGn18vHCy4H8g6QDj2Ksk=;
        b=CrtoaPexKzpHIsYdZU+z3NGUIVQKyuR3dj0SfOfaJpXoUJFqSIjmkMtzEuJt4M1vvk
         gIYa/aZijBsV0TVXC8TyPFuC04GzeGcbd8U9/CmoyQKNNgL1fZdbcwIepcJJHYBUlRJL
         B4TggFV9xhogYDj3I6KhyS2Q5pyohfSdUYzxo1fZ2qKvVMa+ZQt7vSrX154NNt1LC+hh
         dSV0ww4Us+6lO2UOC/DX9wUSs2pChMtwbG4UHlKwHKb7bDZ0+jn2759C3XjN1jxjR9td
         UUiyzLItXcsni4l0XZfcJ1GudE350Ex0CDAuG5ClqKyRe32cSPC60mCWXhHcIv4tahng
         2IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790962766; x=1791567566;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNwYhP3lAcHxRgenr2SVK7uGn18vHCy4H8g6QDj2Ksk=;
        b=Nv5ybSyvhhMSXOLWAbwBc+2BR0jdDPHrOjh+GmieJH6dk/1NcIjwau0jKdrVsdzY+F
         /i/IMiKSbaOs+0Okwe02F4FbzxITuGhI+1gnw1jwv+AFWRXv5glgopmKvqSGknJTBLwz
         kjJy/Uy+2BiWvOSRsrAuDuPFETVpOmx+6UrRYHp0KO9kE5Ihy/mGRHsFgEwGnEdpE4Tl
         kD4dWlEdTHAcsPAZiIKd/hmWgWMizN+ROiz/1OJz8krLw7HzHTFYOxXNycwcgnIPExqO
         +GW7pzFgbGcB/aYh+n9nmFC5f8U5Skxk+IfsSnsMwMmwbZBYkb3PSYsCZri+diAZEyba
         VSFg==
X-Forwarded-Encrypted: i=1; AKwUvByyeKQvYIpP+ZAl0we1vyC3rkIzPULOm7rPnpYfCrVsUg+yBaEwNjl8akPjMLTSOuCJuCjOssdHXzxySY8yzpgu@vger.kernel.org
X-Gm-Message-State: AFq9FYJ37DBDLpmeAOuJnZj172PpHZPcIwhtx6rkI2DOcklBYDzAD0qo
	D9p04S3BUtnUfwr/rJ7jaEjqDWVT/WyHy4mobrGPkPsmJAYQNluRvhQnkh5L5dHxHiUHBusAidp
	KZjGIqbRqMg==
X-Received: from dycoz6.prod.google.com ([2002:a05:7301:fc86:b0:341:7ee9:6f78])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1884:b0:33c:1f44:81dc
 with SMTP id 5a478bee46e88-34f15066984mr3541772eec.6.1790962764907; Fri, 02
 Oct 2026 10:39:24 -0700 (PDT)
Date: Fri,  2 Oct 2026 10:38:39 -0700
In-Reply-To: <20261002173848.3228217-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com> <20261002173848.3228217-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002173848.3228217-7-irogers@google.com>
Subject: [PATCH v2 6/8] perf inject: Extend perf inject to support bid_offset conversion
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Cc: ak@linux.intel.com, alexander.shishkin@linux.intel.com, 
	atrajeev@linux.ibm.com, dvyukov@google.com, fzczx123@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, kjain@linux.ibm.com, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, lihuafei1@huawei.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, m.liska@foxlink.cz, mark.rutland@arm.com, 
	martin.liska@hey.com, mpetlan@redhat.com, quic_zhonhan@quicinc.com, 
	scclevenger@os.amperecomputing.com, sesse@google.com, 
	stephen.s.brennan@oracle.com, thomas.falcon@intel.com, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"

This adds the --sample-buildids option to perf inject, allowing it to
drop MMAP events and rewrite samples to use build IDs and offsets
instead of virtual addresses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c         |  70 ++-
 tools/perf/util/Build               |   1 +
 tools/perf/util/inject_bid_offset.c | 680 ++++++++++++++++++++++++++++
 tools/perf/util/inject_bid_offset.h |  15 +
 4 files changed, 759 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/util/inject_bid_offset.c
 create mode 100644 tools/perf/util/inject_bid_offset.h

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 42ed367d729f..bdca4a62ad39 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -9,6 +9,7 @@
 #include "builtin.h"
 
 #include "util/aslr.h"
+#include "util/inject_bid_offset.h"
 #include "util/color.h"
 #include "util/dso.h"
 #include "util/vdso.h"
@@ -46,6 +47,7 @@
 #include <errno.h>
 #include <signal.h>
 #include <inttypes.h>
+#include <stdlib.h>
 
 struct guest_event {
 	struct perf_sample		sample;
@@ -112,6 +114,7 @@ enum build_id_rewrite_style {
 	BID_RWS__INJECT_HEADER_ALL,
 	BID_RWS__MMAP2_BUILDID_ALL,
 	BID_RWS__MMAP2_BUILDID_LAZY,
+	BID_RWS__SAMPLE_BUILDID,
 };
 
 struct perf_inject {
@@ -243,12 +246,18 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 	if (ret)
 		return ret;
 
-	if (inject->aslr) {
+	if (inject->aslr || inject->build_id_style == BID_RWS__SAMPLE_BUILDID) {
 		aslr_event = malloc(event->header.size);
 		if (!aslr_event)
 			return -ENOMEM;
 		memcpy(aslr_event, event, event->header.size);
-		aslr_tool__strip_attr_event(aslr_event, *pevlist);
+		if (inject->aslr)
+			aslr_tool__strip_attr_event(aslr_event, *pevlist);
+		if (inject->build_id_style == BID_RWS__SAMPLE_BUILDID) {
+			ret = perf_event__rewrite_attr_for_build_id_offset(&aslr_event->attr.attr);
+			if (ret)
+				goto out;
+		}
 		event = aslr_event;
 	}
 
@@ -2571,7 +2580,8 @@ static int __cmd_inject(struct perf_inject *inject)
 		};
 
 		if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
-		    inject->build_id_style == BID_RWS__INJECT_HEADER_ALL)
+		    inject->build_id_style == BID_RWS__INJECT_HEADER_ALL ||
+		    inject->build_id_style == BID_RWS__SAMPLE_BUILDID)
 			perf_header__set_feat(&session->header, HEADER_BUILD_ID);
 		/*
 		 * Keep all buildids when there is unprocessed AUX data because
@@ -2626,6 +2636,17 @@ static int __cmd_inject(struct perf_inject *inject)
 
 		if (inject->aslr)
 			aslr_tool__strip_evlist(inject->session->tool, session->evlist);
+		if (inject->build_id_style == BID_RWS__SAMPLE_BUILDID) {
+			struct evsel *evsel;
+
+			evlist__for_each_entry(session->evlist, evsel) {
+				struct perf_event_attr *attr = &evsel->core.attr;
+
+				ret = perf_event__rewrite_attr_for_build_id_offset(attr);
+				if (ret)
+					return ret;
+			}
+		}
 
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
@@ -2684,6 +2705,7 @@ int cmd_inject(int argc, const char **argv)
 	bool build_id_all = false;
 	bool mmap2_build_ids = false;
 	bool mmap2_build_id_all = false;
+	bool build_id_sample = false;
 
 	struct option options[] = {
 		OPT_BOOLEAN('b', "build-ids", &build_ids,
@@ -2692,8 +2714,11 @@ int cmd_inject(int argc, const char **argv)
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
@@ -2766,8 +2791,8 @@ int cmd_inject(int argc, const char **argv)
 	if (argc)
 		usage_with_options(inject_usage, options);
 
-	if (inject.aslr && inject.convert_callchain) {
-		pr_err("Error: --aslr and --convert-callchain are mutually exclusive features.\n");
+	if ((inject.aslr + inject.convert_callchain + build_id_sample) > 1) {
+		pr_err("Error: --aslr, --convert-callchain and --sample-buildids are mutually exclusive features.\n");
 		return -EINVAL;
 	}
 
@@ -2812,14 +2837,18 @@ int cmd_inject(int argc, const char **argv)
 		inject.build_id_style = BID_RWS__MMAP2_BUILDID_ALL;
 	if (build_ids)
 		inject.build_id_style = BID_RWS__INJECT_HEADER_LAZY;
+
 	if (build_id_all)
 		inject.build_id_style = BID_RWS__INJECT_HEADER_ALL;
+	if (build_id_sample)
+		inject.build_id_style = BID_RWS__SAMPLE_BUILDID;
 
 	data.path = inject.input_name;
 
 	ordered_events = inject.jit_mode || inject.sched_stat ||
 		inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
-		inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY;
+		inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY ||
+		inject.build_id_style == BID_RWS__SAMPLE_BUILDID;
 	perf_tool__init(&inject.tool, ordered_events);
 	inject.tool.sample		= perf_event__repipe_sample;
 	inject.tool.read		= perf_event__repipe_sample;
@@ -2870,6 +2899,12 @@ int cmd_inject(int argc, const char **argv)
 			ret = -ENOMEM;
 			goto out_close_output;
 		}
+	} else if (inject.build_id_style == BID_RWS__SAMPLE_BUILDID) {
+		tool = inject_bid_offset_tool__new(&inject.tool);
+		if (!tool) {
+			ret = -ENOMEM;
+			goto out_close_output;
+		}
 	}
 	inject.session = __perf_session__new(&data, tool,
 					     /*trace_event_repipe=*/inject.output.is_pipe,
@@ -2877,8 +2912,11 @@ int cmd_inject(int argc, const char **argv)
 
 	if (IS_ERR(inject.session)) {
 		ret = PTR_ERR(inject.session);
+
 		if (inject.aslr)
 			aslr_tool__delete(tool);
+		if (inject.build_id_style == BID_RWS__SAMPLE_BUILDID)
+			inject_bid_offset_tool__delete(tool);
 		goto out_close_output;
 	}
 
@@ -2918,8 +2956,19 @@ int cmd_inject(int argc, const char **argv)
 		 * the input.
 		 */
 		if (!data.is_pipe) {
+			struct evsel *evsel;
+
 			if (inject.aslr)
 				aslr_tool__strip_evlist(tool, inject.session->evlist);
+			if (inject.build_id_style == BID_RWS__SAMPLE_BUILDID) {
+				evlist__for_each_entry(inject.session->evlist, evsel) {
+					struct perf_event_attr *attr = &evsel->core.attr;
+
+					ret = perf_event__rewrite_attr_for_build_id_offset(attr);
+					if (ret)
+						goto out_delete;
+				}
+			}
 
 			ret = perf_event__synthesize_for_pipe(&inject.tool,
 							      inject.session,
@@ -2928,6 +2977,10 @@ int cmd_inject(int argc, const char **argv)
 
 			if (inject.aslr)
 				aslr_tool__restore_evlist(tool, inject.session->evlist);
+			if (inject.build_id_style == BID_RWS__SAMPLE_BUILDID) {
+				evlist__for_each_entry(inject.session->evlist, evsel)
+					perf_event__rewrite_attr_for_sample_ip(&evsel->core.attr);
+			}
 
 			if (ret < 0)
 				goto out_delete;
@@ -2935,7 +2988,8 @@ int cmd_inject(int argc, const char **argv)
 	}
 
 	if (inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
-	    inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
+	    inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY ||
+	    inject.build_id_style == BID_RWS__SAMPLE_BUILDID) {
 		/*
 		 * to make sure the mmap records are ordered correctly
 		 * and so that the correct especially due to jitted code
@@ -3002,6 +3056,8 @@ int cmd_inject(int argc, const char **argv)
 	perf_session__delete(inject.session);
 	if (inject.aslr)
 		aslr_tool__delete(tool);
+	if (inject.build_id_style == BID_RWS__SAMPLE_BUILDID)
+		inject_bid_offset_tool__delete(tool);
 out_close_output:
 	if (!inject.in_place_update)
 		perf_data__close(&inject.output);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 512f2ca0cd1a..70732c79d6ac 100644
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
index 000000000000..25e8f21a2d5a
--- /dev/null
+++ b/tools/perf/util/inject_bid_offset.c
@@ -0,0 +1,680 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "inject_bid_offset.h"
+
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <linux/compiler.h>
+#include <linux/kernel.h>
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
+	if (!dso_bid || dso_bid->size == 0 ||
+	    map__mapping_type(al.map) != MAPPING_TYPE__DSO) {
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
+static int inject_bid_offset_tool__process_build_id(const struct perf_tool *tool,
+						    union perf_event *event,
+						    struct perf_sample *sample __maybe_unused,
+						    struct machine *machine __maybe_unused)
+{
+	return tool->build_id(tool, NULL, event);
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
+				if (bid && bid->size > 0) {
+					perf_event__synthesize_build_id(
+						tool, sample, machine,
+						inject_bid_offset_tool__process_build_id,
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
+	struct perf_sample new_sample;
+	struct evsel *evsel = sample->evsel;
+	__u64 i = 0, j = 0;
+	__u64 *in_array, *out_array;
+	__u64 sample_type = evsel->core.attr.sample_type;
+	const __u64 max_i = (event->header.size - sizeof(event->header)) / sizeof(__u64);
+	struct thread *thread;
+	size_t max_size = event->header.size;
+	int orig_sample_size, ret;
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
+	if (max_size >= PERF_SAMPLE_MAX_SIZE) {
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
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_IP) {
+		if (i >= max_i)
+			goto err;
+		i++;
+		if (evsel && thread)
+			mark_dso_hit(ibo->tool.delegate, sample, machine,
+				     thread, sample->ip, sample->cpumode);
+	}
+	if (sample_type & PERF_SAMPLE_TID) {
+		union {
+			u64 val64;
+			u32 val32[2];
+		} u;
+
+		if (i >= max_i)
+			goto err;
+		u.val32[0] = sample->pid;
+		u.val32[1] = sample->tid;
+		out_array[j++] = u.val64;
+		i++;
+	}
+	if (sample_type & PERF_SAMPLE_TIME) {
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_ADDR) {
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_ID) {
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_STREAM_ID) {
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_CPU) {
+		union {
+			u64 val64;
+			u32 val32[2];
+		} u;
+
+		if (i >= max_i)
+			goto err;
+		u.val32[0] = sample->cpu;
+		u.val32[1] = 0;
+		out_array[j++] = u.val64;
+		i++;
+	}
+	if (sample_type & PERF_SAMPLE_PERIOD) {
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_READ) {
+		if ((evsel->core.attr.read_format & PERF_FORMAT_GROUP) == 0) {
+			if (i >= max_i)
+				goto err;
+			out_array[j++] = in_array[i++];
+			if (evsel->core.attr.read_format &
+			    PERF_FORMAT_TOTAL_TIME_ENABLED) {
+				if (i >= max_i)
+					goto err;
+				out_array[j++] = in_array[i++];
+			}
+			if (evsel->core.attr.read_format &
+			    PERF_FORMAT_TOTAL_TIME_RUNNING) {
+				if (i >= max_i)
+					goto err;
+				out_array[j++] = in_array[i++];
+			}
+			if (evsel->core.attr.read_format & PERF_FORMAT_ID) {
+				if (i >= max_i)
+					goto err;
+				out_array[j++] = in_array[i++];
+			}
+			if (evsel->core.attr.read_format & PERF_FORMAT_LOST) {
+				if (i >= max_i)
+					goto err;
+				out_array[j++] = in_array[i++];
+			}
+		} else {
+			u64 nr;
+
+			if (i >= max_i)
+				goto err;
+			nr = out_array[j++] = in_array[i++];
+			if (evsel->core.attr.read_format &
+			    PERF_FORMAT_TOTAL_TIME_ENABLED) {
+				if (i >= max_i)
+					goto err;
+				out_array[j++] = in_array[i++];
+			}
+			if (evsel->core.attr.read_format &
+			    PERF_FORMAT_TOTAL_TIME_RUNNING) {
+				if (i >= max_i)
+					goto err;
+				out_array[j++] = in_array[i++];
+			}
+			for (u64 cntr = 0; cntr < nr; cntr++) {
+				if (i >= max_i)
+					goto err;
+				out_array[j++] = in_array[i++];
+				if (evsel->core.attr.read_format &
+				    PERF_FORMAT_ID) {
+					if (i >= max_i)
+						goto err;
+					out_array[j++] = in_array[i++];
+				}
+				if (evsel->core.attr.read_format &
+				    PERF_FORMAT_LOST) {
+					if (i >= max_i)
+						goto err;
+					out_array[j++] = in_array[i++];
+				}
+			}
+		}
+	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+		if (i >= max_i || sample->callchain->nr > max_i - (i + 1))
+			goto err;
+		i++;
+		if (evsel && thread) {
+			u8 cpumode = sample->cpumode;
+
+			for (u64 x = 0; x < sample->callchain->nr; x++) {
+				u64 ip = sample->callchain->ips[x];
+
+				if (ip >= PERF_CONTEXT_MAX) {
+					switch (ip) {
+					case PERF_CONTEXT_HV:
+						cpumode = PERF_RECORD_MISC_HYPERVISOR;
+						break;
+					case PERF_CONTEXT_KERNEL:
+						cpumode = PERF_RECORD_MISC_KERNEL;
+						break;
+					case PERF_CONTEXT_USER:
+						cpumode = PERF_RECORD_MISC_USER;
+						break;
+					case PERF_CONTEXT_GUEST:
+					case PERF_CONTEXT_GUEST_KERNEL:
+						cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
+						break;
+					case PERF_CONTEXT_GUEST_USER:
+						cpumode = PERF_RECORD_MISC_GUEST_USER;
+						break;
+					case PERF_CONTEXT_USER_DEFERRED:
+						cpumode = PERF_RECORD_MISC_USER;
+						x++;
+						break;
+					default:
+						break;
+					}
+					continue;
+				}
+				mark_dso_hit(ibo->tool.delegate, sample,
+					     machine, thread, ip, cpumode);
+			}
+		}
+		i += sample->callchain->nr;
+	}
+	if (sample_type & PERF_SAMPLE_RAW) {
+		size_t bytes = sizeof(u32) + sample->raw_size;
+		u64 words = DIV_ROUND_UP(bytes, sizeof(u64));
+		u32 *out_raw = (u32 *)&out_array[j];
+
+		if (i > max_i || words > max_i - i)
+			goto err;
+		out_array[j + words - 1] = 0;
+		*out_raw = sample->raw_size;
+		memcpy(out_raw + 1, sample->raw_data, sample->raw_size);
+		i += words;
+		j += words;
+	}
+	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+		u64 nr = sample->branch_stack->nr;
+
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+		if (evsel__has_branch_hw_idx(evsel)) {
+			if (i >= max_i)
+				goto err;
+			out_array[j++] = in_array[i++];
+		}
+		if (i > max_i || (nr * 3) > max_i - i)
+			goto err;
+		memcpy(&out_array[j], &in_array[i],
+		       nr * 3 * sizeof(u64));
+		i += nr * 3;
+		j += nr * 3;
+		if (sample->branch_stack_cntr) {
+			if (i > max_i || nr > max_i - i)
+				goto err;
+			memcpy(&out_array[j], &in_array[i],
+			       nr * sizeof(u64));
+			i += nr;
+			j += nr;
+		}
+	}
+	if (sample_type & PERF_SAMPLE_REGS_USER) {
+		u64 abi;
+
+		if (i >= max_i)
+			goto err;
+		abi = out_array[j++] = in_array[i++];
+		if (abi != PERF_SAMPLE_REGS_ABI_NONE) {
+			u64 nr = hweight64(evsel->core.attr.sample_regs_user);
+
+			if (i > max_i || nr > max_i - i)
+				goto err;
+			memcpy(&out_array[j], &in_array[i], nr * sizeof(u64));
+			i += nr;
+			j += nr;
+			if (abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				u64 nr_vectors, vector_qwords, nr_pred, pred_qwords, simd_nr;
+
+				if (i > max_i || 4 > max_i - i)
+					goto err;
+				nr_vectors = out_array[j++] = in_array[i++];
+				vector_qwords = out_array[j++] = in_array[i++];
+				nr_pred = out_array[j++] = in_array[i++];
+				pred_qwords = out_array[j++] = in_array[i++];
+				simd_nr = nr_vectors * vector_qwords + nr_pred * pred_qwords;
+				if (i > max_i || simd_nr > max_i - i)
+					goto err;
+				memcpy(&out_array[j], &in_array[i], simd_nr * sizeof(u64));
+				i += simd_nr;
+				j += simd_nr;
+			}
+		}
+	}
+	if (sample_type & PERF_SAMPLE_STACK_USER) {
+		u64 size;
+
+		if (i >= max_i)
+			goto err;
+		size = out_array[j++] = in_array[i++];
+		if (size > 0) {
+			u64 words = DIV_ROUND_UP(size, sizeof(u64));
+
+			if (i > max_i || words > max_i - i)
+				goto err;
+			memcpy(&out_array[j], &in_array[i], words * sizeof(u64));
+			i += words;
+			j += words;
+			if (i >= max_i)
+				goto err;
+			out_array[j++] = in_array[i++];
+		}
+	}
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_DATA_SRC) {
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_TRANSACTION) {
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		u64 abi;
+
+		if (i >= max_i)
+			goto err;
+		abi = out_array[j++] = in_array[i++];
+		if (abi != PERF_SAMPLE_REGS_ABI_NONE) {
+			u64 nr = hweight64(evsel->core.attr.sample_regs_intr);
+
+			if (i > max_i || nr > max_i - i)
+				goto err;
+			memcpy(&out_array[j], &in_array[i], nr * sizeof(u64));
+			i += nr;
+			j += nr;
+			if (abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				u64 nr_vectors, vector_qwords, nr_pred, pred_qwords, simd_nr;
+
+				if (i > max_i || 4 > max_i - i)
+					goto err;
+				nr_vectors = out_array[j++] = in_array[i++];
+				vector_qwords = out_array[j++] = in_array[i++];
+				nr_pred = out_array[j++] = in_array[i++];
+				pred_qwords = out_array[j++] = in_array[i++];
+				simd_nr = nr_vectors * vector_qwords + nr_pred * pred_qwords;
+				if (i > max_i || simd_nr > max_i - i)
+					goto err;
+				memcpy(&out_array[j], &in_array[i], simd_nr * sizeof(u64));
+				i += simd_nr;
+				j += simd_nr;
+			}
+		}
+	}
+	if (sample_type & PERF_SAMPLE_PHYS_ADDR) {
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_CGROUP) {
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE) {
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE) {
+		if (i >= max_i)
+			goto err;
+		out_array[j++] = in_array[i++];
+	}
+	if (sample_type & PERF_SAMPLE_AUX) {
+		u64 size, words;
+
+		if (i >= max_i)
+			goto err;
+		size = out_array[j++] = in_array[i++];
+		words = DIV_ROUND_UP(size, sizeof(u64));
+		if (i > max_i || words > max_i - i)
+			goto err;
+		memcpy(&out_array[j], &in_array[i], words * sizeof(u64));
+		i += words;
+		j += words;
+	}
+
+	if (sample_type & PERF_SAMPLE_IP) {
+		perf_event__inject_sample_buildid_array(
+			thread, sample->ip, sample->cpumode, &out_array[j]);
+		j += 4;
+	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+		u8 cpumode = sample->cpumode;
+
+		out_array[j++] = sample->callchain->nr;
+		for (u64 x = 0; x < sample->callchain->nr; x++) {
+			u64 ip = sample->callchain->ips[x];
+
+			if (ip >= PERF_CONTEXT_MAX) {
+				switch (ip) {
+				case PERF_CONTEXT_HV:
+					cpumode = PERF_RECORD_MISC_HYPERVISOR;
+					break;
+				case PERF_CONTEXT_KERNEL:
+					cpumode = PERF_RECORD_MISC_KERNEL;
+					break;
+				case PERF_CONTEXT_USER:
+					cpumode = PERF_RECORD_MISC_USER;
+					break;
+				case PERF_CONTEXT_GUEST:
+				case PERF_CONTEXT_GUEST_KERNEL:
+					cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
+					break;
+				case PERF_CONTEXT_GUEST_USER:
+					cpumode = PERF_RECORD_MISC_GUEST_USER;
+					break;
+				case PERF_CONTEXT_USER_DEFERRED:
+					cpumode = PERF_RECORD_MISC_USER;
+					memset(&out_array[j], 0, 3 * sizeof(u64));
+					out_array[j + 3] = ip;
+					j += 4;
+					if (x + 1 < sample->callchain->nr) {
+						x++;
+						memset(&out_array[j], 0, 3 * sizeof(u64));
+						out_array[j + 3] = sample->callchain->ips[x];
+						j += 4;
+					}
+					continue;
+				default:
+					break;
+				}
+				memset(&out_array[j], 0, 3 * sizeof(u64));
+				out_array[j + 3] = ip;
+			} else {
+				perf_event__inject_sample_buildid_array(
+					thread, ip, cpumode, &out_array[j]);
+			}
+			j += 4;
+		}
+	}
+
+	max_size = sizeof(event->header) + j * sizeof(__u64);
+	if (max_size >= PERF_SAMPLE_MAX_SIZE)
+		goto err;
+	ev->sample.header.size = max_size;
+
+	orig_sample_size = evsel->sample_size;
+	if (perf_event__rewrite_attr_for_build_id_offset(&evsel->core.attr))
+		goto err;
+	evsel->sample_size = __evsel__sample_size(evsel->core.attr.sample_type);
+	perf_sample__init(&new_sample, /*all=*/true);
+	ret = __evsel__parse_sample(evsel, ev, &new_sample, /*needs_swap=*/false);
+	if (!ret) {
+		new_sample.evsel = evsel;
+		ret = ibo->tool.delegate->sample(ibo->tool.delegate, ev,
+						 &new_sample, machine);
+	}
+	perf_sample__exit(&new_sample);
+	evsel->core.attr.sample_type = sample_type;
+	evsel->sample_size = orig_sample_size;
+	thread__put(thread);
+	return ret;
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
index 000000000000..4ed2b3c0d85f
--- /dev/null
+++ b/tools/perf/util/inject_bid_offset.h
@@ -0,0 +1,15 @@
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
+struct perf_tool *inject_bid_offset_tool__new(struct perf_tool *delegate);
+void inject_bid_offset_tool__delete(struct perf_tool *tool);
+
+#endif /* __PERF_INJECT_BID_OFFSET_H */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


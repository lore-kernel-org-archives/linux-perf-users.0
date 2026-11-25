Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567916;
	b=wVKdCg7G+3xTppA76rJ/2NxlUsJeqNW9SltbWo9TmwfOcIWamOFsa8f0nv8o59YOiP+j
	 eObeFwCTY6XpKO8hHT4s2Cmb9kMWgnlHHOrSG1rdTAi5dFNTxJ1MLmCBzRZZJ33CbreEH
	 Ia68/osHkpbo+7H/mrR1yEEKP8ZtuH7JAVABzI9qnERBPI7KE1itANlIgLQ/iV6ek/jsJ
	 lXtR2W0KEMV2+9UFNrsze1YKoCwzzdD6uSItSr2hovte4XRNQn2c7lqAMmgYFTWrZAQqY
	 E0Ak/SeVt7Ah1JvG4LnsN+Jt3/LFZ0RmKYFkbBTpGi9YKHu1TALvye9buvvIGwmvnAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ROiDwz78HHtW8hVHJ3f7WOc2lR/toF8Ngi05raXGPPQ=;
	b=GNWExeEoPs1r5lfN05p9zuH2UyyPBLInGQh/HKYOWir0wGlTsPLpRCEvFe5H3VmSaS1e
	 2N8a6GJrL8BNeUZUqeckctYJd+ACFxmgNHIFVpLdTY5ubG/jkm2QltYDfLPcs6Fxx47f/
	 PQcWCuQZM/w1YS2WtOBtXVXL25pPaZ189308+5WwoWIWMxC72EMmiSIELOvIs31nqKMmr
	 5IAxIhAr0QWNibJBH4Oi9NgE28rT3PwKDIO+zR8JKbzZMBvqpNaGmPJl9jMv4o79075lF
	 mSpOXhIM10hfdAYepuC/B9sBXci8sjd6IBNPojmhn9ocHULdWwzrn+bnxzZSiZskoZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="b6LV+/Yz";
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA08606A69C
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 00:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FA08606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b6LV+/Yz
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b25d977b91so5531241c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 16:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567915; x=1796172715; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROiDwz78HHtW8hVHJ3f7WOc2lR/toF8Ngi05raXGPPQ=;
        b=b6LV+/YzO24iM01u3M4e/v+JPjkdgdexswTNjijmOmLIIW1akQXMhPIXr48bSXErje
         Pkb5YPXz4q+mRMyOjDUezUOSjSkH6R+1xGhaALxYaLCIwRiDv3xyWjLWsxiz+i0EfUD1
         yjQiNfyQ0hshR68SnsL8HOESVEscvMgsVrCuSG7p64Ey31a3EeE09UPnS02ZMcnQhbSr
         mYErCyNCVOFJWJDQWMTzwlijp3UgrHMpWkIvJYygp567awmgOyzuwx/61g+jWIJSxxCR
         FMeHYWRqbARCVxDItxf8OXUAC246HMWgeuQVTXayqcXNkWnedX5+u7QFVykLSvdvZDbC
         eEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567915; x=1796172715;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROiDwz78HHtW8hVHJ3f7WOc2lR/toF8Ngi05raXGPPQ=;
        b=bDT4+rU0MTn2sQbxOYPrcm3t0c8cqHuCdPLMxcV9OkIpciBttFiL+ojVkrP2RxcMef
         ptrJSTXXC2SqQIrlzPWm95ItWZUfvSi0+yNvO2dgLaRd034+L8gi1hs7Vw7IeqEKK/eu
         HQ5Og8OIs/H4vNvmX3Mj+nv4zXspuSurtogyFUOibFI/0eqAzuIfMWqUD80usHnMCgud
         VW3aKjZHY2fjT0PTZZcwd5tswhhyoM/JcczMbuxYIwOMiNyUkw/P4rHyZvzLGYGX/AIJ
         HqMlAVfBaYTKUGdilhv23/MAZA2zRBjHTTI9UbQHABd5LbIUUqPhfg2EbvCnzu6cdy4S
         EYaA==
X-Forwarded-Encrypted: i=1; AL+hErGRHENUhFz1Y1jQbUkoiNy+J2RKIkhAHslMeqd8pH+LrEKveCl8g1irMgwkLJlZDBjPnkqFgE7VVZyof47rml7x@vger.kernel.org
X-Gm-Message-State: APuU4Z9H91FQDeSKrveTzW8sf4krEQ0IoWElwt+lDcStKQcHwbBFkwBl
	3IC71zPOTXOhiOXFlKHGJgfGp3Y634xzXXeRLaYvwquX48ZNLrH7bTQ/9RXnNNNr9lrykEoJrO8
	MM/vvRPkHNg==
X-Received: from dlgx13-n2.prod.google.com ([2002:a05:701a:cccd:20b0:1b5:26be:e863])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:5e09:b0:1a0:b8f5:872d
 with SMTP id a92af1059eb24-1b5567c13a5mr15404974c88.4.1795567913842; Tue, 24
 Nov 2026 16:51:53 -0800 (PST)
Date: Tue, 24 Nov 2026 16:51:05 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-17-irogers@google.com>
Subject: [PATCH v4 16/19] perf inject: Add --sample-buildids to convert
 samples to build ID + offset
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the --sample-buildids (-S) option to perf inject, allowing it to
drop user-space MMAP events and rewrite PERF_SAMPLE_IP,
PERF_SAMPLE_CALLCHAIN, and PERF_RECORD_CALLCHAIN_DEFERRED records to use
build IDs and file offsets instead of virtual addresses.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-inject.txt |   8 +
 tools/perf/builtin-inject.c              |  71 +-
 tools/perf/util/Build                    |   1 +
 tools/perf/util/inject_bid_offset.c      | 882 +++++++++++++++++++++++
 tools/perf/util/inject_bid_offset.h      |  15 +
 5 files changed, 970 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/util/inject_bid_offset.c
 create mode 100644 tools/perf/util/inject_bid_offset.h

diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
index 95dfdf39666e..297247b643d8 100644
--- a/tools/perf/Documentation/perf-inject.txt
+++ b/tools/perf/Documentation/perf-inject.txt
@@ -32,6 +32,14 @@ OPTIONS
 	Inject build-ids of all DSOs into the output stream regardless of hits
 	and skip SAMPLE processing.
 
+-S::
+--sample-buildids::
+	Drop user-space MMAP and MMAP2 events, inject build-id records for DSOs
+	hit by samples, and rewrite PERF_SAMPLE_IP, PERF_SAMPLE_CALLCHAIN, and
+	PERF_RECORD_CALLCHAIN_DEFERRED records to use build IDs and DSO file
+	offsets instead of virtual addresses. Mutually exclusive with --aslr
+	and --convert-callchain.
+
 --known-build-ids=::
 	Override build-ids to inject using these comma-separated pairs of
 	build-id and path. Understands file://filename to read these pairs
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f59f3005899c..2309074b2f65 100644
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
 
@@ -2565,7 +2574,8 @@ static int __cmd_inject(struct perf_inject *inject)
 		};
 
 		if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
-		    inject->build_id_style == BID_RWS__INJECT_HEADER_ALL)
+		    inject->build_id_style == BID_RWS__INJECT_HEADER_ALL ||
+		    inject->build_id_style == BID_RWS__SAMPLE_BUILDID)
 			perf_header__set_feat(&session->header, HEADER_BUILD_ID);
 		/*
 		 * Keep all buildids when there is unprocessed AUX data because
@@ -2620,6 +2630,17 @@ static int __cmd_inject(struct perf_inject *inject)
 
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
@@ -2678,6 +2699,7 @@ int cmd_inject(int argc, const char **argv)
 	bool build_id_all = false;
 	bool mmap2_build_ids = false;
 	bool mmap2_build_id_all = false;
+	bool build_id_sample = false;
 
 	struct option options[] = {
 		OPT_BOOLEAN('b', "build-ids", &build_ids,
@@ -2686,8 +2708,11 @@ int cmd_inject(int argc, const char **argv)
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
@@ -2760,8 +2785,8 @@ int cmd_inject(int argc, const char **argv)
 	if (argc)
 		usage_with_options(inject_usage, options);
 
-	if (inject.aslr && inject.convert_callchain) {
-		pr_err("Error: --aslr and --convert-callchain are mutually exclusive features.\n");
+	if ((inject.aslr + inject.convert_callchain + build_id_sample) > 1) {
+		pr_err("Error: --aslr, --convert-callchain and --sample-buildids are mutually exclusive features.\n");
 		return -EINVAL;
 	}
 
@@ -2806,8 +2831,11 @@ int cmd_inject(int argc, const char **argv)
 		inject.build_id_style = BID_RWS__MMAP2_BUILDID_ALL;
 	if (build_ids)
 		inject.build_id_style = BID_RWS__INJECT_HEADER_LAZY;
+
 	if (build_id_all)
 		inject.build_id_style = BID_RWS__INJECT_HEADER_ALL;
+	if (build_id_sample)
+		inject.build_id_style = BID_RWS__SAMPLE_BUILDID;
 
 	data.path = inject.input_name;
 
@@ -2817,7 +2845,8 @@ int cmd_inject(int argc, const char **argv)
 		inject.guest_session.perf_data_file ||
 		inject.convert_callchain ||
 		inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
-		inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY;
+		inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY ||
+		inject.build_id_style == BID_RWS__SAMPLE_BUILDID;
 	perf_tool__init(&inject.tool, ordered_events);
 	inject.tool.sample		= perf_event__repipe_sample;
 	inject.tool.read		= perf_event__repipe_sample;
@@ -2839,6 +2868,7 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.ksymbol		= perf_event__repipe;
 	inject.tool.bpf			= perf_event__repipe;
 	inject.tool.text_poke		= perf_event__repipe;
+	inject.tool.callchain_deferred	= perf_event__repipe;
 	inject.tool.attr		= perf_event__repipe_attr;
 	inject.tool.event_update	= perf_event__repipe_event_update;
 	inject.tool.tracing_data	= perf_event__repipe_op2_synth;
@@ -2868,7 +2898,8 @@ int cmd_inject(int argc, const char **argv)
 	    inject.guest_session.perf_data_file ||
 	    inject.convert_callchain ||
 	    inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
-	    inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
+	    inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY ||
+	    inject.build_id_style == BID_RWS__SAMPLE_BUILDID) {
 		/*
 		 * to make sure the mmap records are ordered correctly
 		 * and so that the correct especially due to jitted code
@@ -2883,6 +2914,12 @@ int cmd_inject(int argc, const char **argv)
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
@@ -2890,8 +2927,11 @@ int cmd_inject(int argc, const char **argv)
 
 	if (IS_ERR(inject.session)) {
 		ret = PTR_ERR(inject.session);
+
 		if (inject.aslr)
 			aslr_tool__delete(tool);
+		if (inject.build_id_style == BID_RWS__SAMPLE_BUILDID)
+			inject_bid_offset_tool__delete(tool);
 		goto out_close_output;
 	}
 
@@ -2931,8 +2971,19 @@ int cmd_inject(int argc, const char **argv)
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
@@ -2941,6 +2992,10 @@ int cmd_inject(int argc, const char **argv)
 
 			if (inject.aslr)
 				aslr_tool__restore_evlist(tool, inject.session->evlist);
+			if (inject.build_id_style == BID_RWS__SAMPLE_BUILDID) {
+				evlist__for_each_entry(inject.session->evlist, evsel)
+					perf_event__rewrite_attr_for_sample_ip(&evsel->core.attr);
+			}
 
 			if (ret < 0)
 				goto out_delete;
@@ -3004,6 +3059,8 @@ int cmd_inject(int argc, const char **argv)
 	perf_session__delete(inject.session);
 	if (inject.aslr)
 		aslr_tool__delete(tool);
+	if (inject.build_id_style == BID_RWS__SAMPLE_BUILDID)
+		inject_bid_offset_tool__delete(tool);
 out_close_output:
 	if (!inject.in_place_update)
 		perf_data__close(&inject.output);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2ab63bbe4a05..7eed58ba4568 100644
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
index 000000000000..c6f80f2a9532
--- /dev/null
+++ b/tools/perf/util/inject_bid_offset.c
@@ -0,0 +1,882 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "inject_bid_offset.h"
+
+#include <errno.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/overflow.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+
+#include "addr_location.h"
+#include "debug.h"
+#include "dso.h"
+#include "event.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "hashmap.h"
+#include "header.h"
+#include "machine.h"
+#include "map.h"
+#include "namespaces.h"
+#include "sample.h"
+#include "session.h"
+#include "symbol.h"
+#include "synthetic-events.h"
+#include "thread.h"
+#include "tool.h"
+#include "vdso.h"
+
+static size_t dso_ptr_hash(long key, void *ctx __maybe_unused)
+{
+	return (size_t)key;
+}
+
+static bool dso_ptr_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
+struct inject_bid_offset_tool {
+	struct delegate_tool tool;
+	struct hashmap synthesized_dsos;
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
+static int dso__read_build_id(struct dso *dso)
+{
+	struct nscookie nsc;
+	struct build_id bid = { .size = 0, };
+
+	if (dso__has_build_id(dso))
+		return 0;
+
+	mutex_lock(dso__lock(dso));
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
+		dso__set_build_id(dso, &bid);
+	else if (dso__nsinfo(dso)) {
+		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
+
+		if (new_name && filename__read_build_id(new_name, &bid) > 0)
+			dso__set_build_id(dso, &bid);
+		free(new_name);
+	}
+	nsinfo__mountns_exit(&nsc);
+	mutex_unlock(dso__lock(dso));
+
+	return dso__has_build_id(dso) ? 0 : -1;
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
+	if (!thread ||
+	    (cpumode != PERF_RECORD_MISC_USER &&
+	     cpumode != PERF_RECORD_MISC_GUEST_USER))
+		goto write_bid;
+
+	if (!thread__find_map(thread, &ps, &al))
+		goto write_bid;
+
+	dso = al.map ? dso__get(map__dso(al.map)) : NULL;
+	if (!dso)
+		goto write_bid;
+	if (!dso__has_build_id(dso))
+		dso__read_build_id(dso);
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
+static size_t perf_event__inject_callchain_buildid_array(struct thread *thread,
+							 const struct ip_callchain *callchain,
+							 __u64 *out_array,
+							 size_t max_words,
+							 int *errp)
+{
+	u32 nr_offsets = callchain->nr;
+	u32 nr_build_ids = 0;
+	u32 build_ids_bytes = 0, aligned_bids_len;
+	size_t total_words;
+	u8 cpumode = PERF_RECORD_MISC_USER;
+	u8 build_ids[254 * 21];
+	u32 bid_offsets[254];
+	u64 *offsets;
+	union {
+		u64 val64;
+		u32 val32[2];
+	} u;
+
+	offsets = calloc(nr_offsets, sizeof(u64));
+	if (!offsets && nr_offsets > 0) {
+		*errp = -ENOMEM;
+		return 0;
+	}
+
+	for (u32 x = 0; x < nr_offsets; x++) {
+		u64 ip = callchain->ips[x];
+		__u64 entry_words[4];
+		struct perf_build_id *bid = (struct perf_build_id *)&entry_words[0];
+		u64 offset;
+		u8 bid_idx = 0;
+
+		if (ip >= PERF_CONTEXT_MAX) {
+			switch (ip) {
+			case PERF_CONTEXT_HV:
+				cpumode = PERF_RECORD_MISC_HYPERVISOR;
+				break;
+			case PERF_CONTEXT_KERNEL:
+				cpumode = PERF_RECORD_MISC_KERNEL;
+				break;
+			case PERF_CONTEXT_USER:
+				cpumode = PERF_RECORD_MISC_USER;
+				break;
+			case PERF_CONTEXT_GUEST:
+			case PERF_CONTEXT_GUEST_KERNEL:
+				cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
+				break;
+			case PERF_CONTEXT_GUEST_USER:
+				cpumode = PERF_RECORD_MISC_GUEST_USER;
+				break;
+			case PERF_CONTEXT_USER_DEFERRED:
+				cpumode = PERF_RECORD_MISC_USER;
+				offsets[x] = ip;
+				if (x + 1 < nr_offsets) {
+					x++;
+					offsets[x] = callchain->ips[x];
+				}
+				continue;
+			default:
+				break;
+			}
+			offsets[x] = ip;
+			continue;
+		}
+
+		perf_event__inject_sample_buildid_array(thread, ip, cpumode, entry_words);
+		offset = entry_words[3];
+		if (bid->size > 0 && bid->size <= 20 && (offset >> 56) == 0) {
+			for (u32 j = 0; j < nr_build_ids; j++) {
+				u32 pos = bid_offsets[j];
+
+				if (build_ids[pos] == bid->size &&
+				    !memcmp(&build_ids[pos + 1], bid->data, bid->size)) {
+					bid_idx = j + 1;
+					break;
+				}
+			}
+			if (!bid_idx && nr_build_ids < 254) {
+				bid_offsets[nr_build_ids] = build_ids_bytes;
+				build_ids[build_ids_bytes++] = bid->size;
+				memcpy(&build_ids[build_ids_bytes], bid->data, bid->size);
+				build_ids_bytes += bid->size;
+				nr_build_ids++;
+				bid_idx = nr_build_ids;
+			}
+		}
+		if (bid_idx)
+			offsets[x] = (offset & ((1ULL << 56) - 1)) | ((u64)bid_idx << 56);
+		else if (cpumode == PERF_RECORD_MISC_USER ||
+			 cpumode == PERF_RECORD_MISC_GUEST_USER)
+			offsets[x] = ip & ((1ULL << 56) - 1);
+		else
+			offsets[x] = ip;
+	}
+
+	aligned_bids_len = ALIGN(build_ids_bytes, sizeof(u64));
+	total_words = 1 + aligned_bids_len / sizeof(u64) + nr_offsets;
+	if (total_words > max_words) {
+		free(offsets);
+		*errp = -E2BIG;
+		return 0;
+	}
+	u.val32[0] = nr_build_ids;
+	u.val32[1] = nr_offsets;
+	out_array[0] = u.val64;
+	if (aligned_bids_len > 0) {
+		memset(&out_array[1], 0, aligned_bids_len);
+		memcpy(&out_array[1], build_ids, build_ids_bytes);
+	}
+	if (nr_offsets > 0) {
+		memcpy(&out_array[1 + aligned_bids_len / sizeof(u64)],
+		       offsets, nr_offsets * sizeof(u64));
+	}
+	free(offsets);
+	return total_words;
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
+static bool dso__is_in_kernel_space(struct dso *dso)
+{
+	if (dso__is_vdso(dso))
+		return false;
+
+	return dso__is_kcore(dso) ||
+	       dso__kernel(dso) ||
+	       is_kernel_module(dso__long_name(dso), PERF_RECORD_MISC_CPUMODE_UNKNOWN);
+}
+
+static void mark_dso_hit(struct inject_bid_offset_tool *ibo,
+			 struct perf_sample *sample, struct machine *machine,
+			 struct thread *thread, u64 ip, u8 cpumode)
+{
+	struct perf_sample ps = { .ip = ip, .cpumode = cpumode };
+	const struct perf_tool *tool = ibo->tool.delegate;
+	const struct build_id *bid;
+	struct addr_location al;
+	struct dso *dso;
+
+	addr_location__init(&al);
+	if (!thread__find_map(thread, &ps, &al))
+		goto out;
+
+	dso = al.map ? dso__get(map__dso(al.map)) : NULL;
+	if (!dso)
+		goto out;
+
+	if (!hashmap__find(&ibo->synthesized_dsos, RC_CHK_ACCESS(dso), NULL)) {
+		struct dso *saved_dso = dso__get(dso);
+
+		if (hashmap__add(&ibo->synthesized_dsos, RC_CHK_ACCESS(dso),
+				 saved_dso))
+			dso__put(saved_dso);
+		dso__set_hit(dso);
+		if (!dso__has_build_id(dso))
+			dso__read_build_id(dso);
+		bid = dso__bid(dso);
+		if (bid && bid->size > 0) {
+			bool in_kernel = dso__is_in_kernel_space(dso);
+			const char *name;
+			__u16 misc;
+
+			if (dso__is_vdso(dso))
+				name = dso__short_name(dso);
+			else if (dso__is_kcore(dso))
+				name = machine->mmap_name;
+			else
+				name = dso__long_name(dso);
+
+			if (machine__is_host(machine)) {
+				misc = in_kernel ? PERF_RECORD_MISC_KERNEL
+						 : PERF_RECORD_MISC_USER;
+			} else {
+				misc = in_kernel ? PERF_RECORD_MISC_GUEST_KERNEL
+						 : PERF_RECORD_MISC_GUEST_USER;
+			}
+			perf_event__synthesize_build_id(tool, sample, machine,
+				inject_bid_offset_tool__process_build_id,
+				misc, bid, name);
+		}
+	}
+	dso__put(dso);
+out:
+	addr_location__exit(&al);
+}
+
+static bool read_u64(const u8 **inp, const u8 *in_end, u64 *val)
+{
+	if ((size_t)(in_end - *inp) < sizeof(u64))
+		return false;
+	memcpy(val, *inp, sizeof(u64));
+	*inp += sizeof(u64);
+	return true;
+}
+
+static bool copy_bytes(const u8 **inp, const u8 *in_end,
+		       u8 **outp, const u8 *out_end, size_t len)
+{
+	if ((size_t)(in_end - *inp) < len || (size_t)(out_end - *outp) < len)
+		return false;
+	if (len)
+		memcpy(*outp, *inp, len);
+	*inp += len;
+	*outp += len;
+	return true;
+}
+
+static bool copy_sample_regs(const u8 **inp, const u8 *in_end,
+			     u8 **outp, const u8 *out_end, u64 reg_mask)
+{
+	u64 abi;
+
+	if ((size_t)(in_end - *inp) < sizeof(u64))
+		return false;
+	memcpy(&abi, *inp, sizeof(u64));
+	if (!copy_bytes(inp, in_end, outp, out_end, sizeof(u64)))
+		return false;
+	if (abi == PERF_SAMPLE_REGS_ABI_NONE)
+		return true;
+
+	if (!copy_bytes(inp, in_end, outp, out_end,
+			hweight64(reg_mask) * sizeof(u64)))
+		return false;
+
+	if (abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+		u64 hdr[4], vec_qwords, pred_qwords, simd_qwords;
+
+		if ((size_t)(in_end - *inp) < sizeof(hdr))
+			return false;
+		memcpy(hdr, *inp, sizeof(hdr));
+		if (!copy_bytes(inp, in_end, outp, out_end, sizeof(hdr)))
+			return false;
+		if (check_mul_overflow(hdr[0], hdr[1], &vec_qwords) ||
+		    check_mul_overflow(hdr[2], hdr[3], &pred_qwords) ||
+		    check_add_overflow(vec_qwords, pred_qwords, &simd_qwords) ||
+		    simd_qwords > (size_t)(in_end - *inp) / sizeof(u64) ||
+		    !copy_bytes(inp, in_end, outp, out_end,
+				(size_t)simd_qwords * sizeof(u64)))
+			return false;
+	}
+	return true;
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
+	const struct ip_callchain *raw_callchain = NULL;
+	struct evsel *evsel = sample->evsel;
+	__u64 sample_type = evsel->core.attr.sample_type;
+	const u8 *in, *in_end, *out_end;
+	struct perf_sample new_sample;
+	union perf_event *ev;
+	struct thread *thread;
+	u64 raw_ip = 0;
+	u8 *out;
+	int orig_sample_size, ret = -EFAULT;
+
+	if ((sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CALLCHAIN)) == 0)
+		return ibo->tool.delegate->sample(ibo->tool.delegate, event,
+						  sample, machine);
+
+	if (event->header.size < sizeof(event->header))
+		return -EFAULT;
+
+	if (symbol_conf.guest_code && !machine__is_host(machine))
+		thread = machine__findnew_guest_code(machine, sample->pid);
+	else
+		thread = machine__findnew_thread(machine, sample->pid,
+						 sample->tid);
+
+	ev = (union perf_event *)ibo->event_copy;
+	ev->sample.header = event->header;
+
+	in = (const u8 *)event->sample.array;
+	in_end = (const u8 *)event + event->header.size;
+	out = (u8 *)ev->sample.array;
+	out_end = (const u8 *)ev + PERF_SAMPLE_MAX_SIZE - sizeof(u64);
+
+	if (sample_type & PERF_SAMPLE_IDENTIFIER) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_IP) {
+		if (!read_u64(&in, in_end, &raw_ip))
+			goto out_put;
+		if (thread)
+			mark_dso_hit(ibo, sample, machine, thread, raw_ip,
+				     sample->cpumode);
+	}
+	if (sample_type & PERF_SAMPLE_TID) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_TIME) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_ADDR) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_ID) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_STREAM_ID) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_CPU) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_PERIOD) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_READ) {
+		u64 read_format = evsel->core.attr.read_format;
+		u64 first_word;
+
+		if ((size_t)(in_end - in) < sizeof(u64))
+			goto out_put;
+		memcpy(&first_word, in, sizeof(u64));
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+		if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
+			if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+				goto out_put;
+		}
+		if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING) {
+			if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+				goto out_put;
+		}
+		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
+		if (read_format & PERF_FORMAT_GROUP) {
+			size_t val_sz = sample_read_value_size(read_format);
+
+			if (first_word > (size_t)(in_end - in) / val_sz ||
+			    !copy_bytes(&in, in_end, &out, out_end,
+					(size_t)first_word * val_sz))
+				goto out_put;
+		} else {
+			if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+				goto out_put;
+			if (read_format & PERF_FORMAT_LOST) {
+				if (!copy_bytes(&in, in_end, &out, out_end,
+						sizeof(u64)))
+					goto out_put;
+			}
+		}
+	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+		u64 callchain_nr;
+
+		if (!IS_ALIGNED((uintptr_t)in, sizeof(u64)) ||
+		    (size_t)(in_end - in) < sizeof(u64))
+			goto out_put;
+		raw_callchain = (const struct ip_callchain *)in;
+		callchain_nr = raw_callchain->nr;
+		in += sizeof(u64);
+		if (callchain_nr > (size_t)(in_end - in) / sizeof(u64))
+			goto out_put;
+		if (thread) {
+			u8 cpumode = PERF_RECORD_MISC_USER;
+
+			for (u64 x = 0; x < callchain_nr; x++) {
+				u64 ip = raw_callchain->ips[x];
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
+				mark_dso_hit(ibo, sample, machine, thread, ip,
+					     cpumode);
+			}
+		}
+		in += (size_t)callchain_nr * sizeof(u64);
+	}
+	if (sample_type & PERF_SAMPLE_RAW) {
+		u32 raw_size;
+
+		if ((size_t)(in_end - in) < sizeof(u32))
+			goto out_put;
+		memcpy(&raw_size, in, sizeof(u32));
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u32)) ||
+		    raw_size > (size_t)(in_end - in) ||
+		    !copy_bytes(&in, in_end, &out, out_end, raw_size))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+		u64 nr;
+
+		if ((size_t)(in_end - in) < sizeof(u64))
+			goto out_put;
+		memcpy(&nr, in, sizeof(u64));
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+		if (evsel__has_branch_hw_idx(evsel)) {
+			if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+				goto out_put;
+		}
+		if (nr > (size_t)(in_end - in) / sizeof(struct branch_entry) ||
+		    !copy_bytes(&in, in_end, &out, out_end,
+				(size_t)nr * sizeof(struct branch_entry)))
+			goto out_put;
+		if (sample->branch_stack_cntr) {
+			if (nr > (size_t)(in_end - in) / sizeof(u64) ||
+			    !copy_bytes(&in, in_end, &out, out_end,
+					(size_t)nr * sizeof(u64)))
+				goto out_put;
+		}
+	}
+	if (sample_type & PERF_SAMPLE_REGS_USER) {
+		if (!copy_sample_regs(&in, in_end, &out, out_end,
+				      evsel->core.attr.sample_regs_user))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_STACK_USER) {
+		u64 sz;
+
+		if ((size_t)(in_end - in) < sizeof(u64))
+			goto out_put;
+		memcpy(&sz, in, sizeof(u64));
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+		if (sz > 0) {
+			if (sz > (size_t)(in_end - in) ||
+			    !copy_bytes(&in, in_end, &out, out_end, (size_t)sz) ||
+			    !copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+				goto out_put;
+		}
+	}
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_DATA_SRC) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_TRANSACTION) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		if (!copy_sample_regs(&in, in_end, &out, out_end,
+				      evsel->core.attr.sample_regs_intr))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_PHYS_ADDR) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_CGROUP) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE) {
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)))
+			goto out_put;
+	}
+	if (!IS_ALIGNED((uintptr_t)out, sizeof(u64)))
+		goto out_put;
+
+	if (sample_type & PERF_SAMPLE_IP) {
+		if ((size_t)(out_end - out) < 4 * sizeof(u64)) {
+			ret = -E2BIG;
+			goto out_put;
+		}
+		perf_event__inject_sample_buildid_array(thread, raw_ip,
+							sample->cpumode,
+							(__u64 *)out);
+		out += 4 * sizeof(u64);
+	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
+		size_t cc_words = perf_event__inject_callchain_buildid_array(
+			thread, raw_callchain, (__u64 *)out,
+			(size_t)(out_end - out) / sizeof(u64), &ret);
+
+		if (!cc_words)
+			goto out_put;
+		out += cc_words * sizeof(u64);
+	}
+
+	if (sample_type & PERF_SAMPLE_AUX) {
+		u64 sz;
+
+		if ((size_t)(in_end - in) < sizeof(u64))
+			goto out_put;
+		memcpy(&sz, in, sizeof(u64));
+		if (!copy_bytes(&in, in_end, &out, out_end, sizeof(u64)) ||
+		    sz > (size_t)(in_end - in) ||
+		    !copy_bytes(&in, in_end, &out, out_end, (size_t)sz))
+			goto out_put;
+	}
+
+	ev->sample.header.size = (u16)(out - (u8 *)ev);
+
+	orig_sample_size = evsel->sample_size;
+	if (perf_event__rewrite_attr_for_build_id_offset(&evsel->core.attr)) {
+		ret = -EFAULT;
+		goto out_put;
+	}
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
+out_put:
+	thread__put(thread);
+	return ret;
+}
+
+static int
+inject_bid_offset_tool__callchain_deferred(const struct perf_tool *tool,
+					   union perf_event *event,
+					   struct perf_sample *sample,
+					   struct machine *machine)
+{
+	struct delegate_tool *dt =
+		container_of(tool, struct delegate_tool, tool);
+	struct inject_bid_offset_tool *ibo =
+		container_of(dt, struct inject_bid_offset_tool, tool);
+	size_t hdr_size = offsetof(struct perf_record_callchain_deferred,
+				   nr_build_ids);
+	size_t max_size = PERF_SAMPLE_MAX_SIZE - sizeof(u64);
+	size_t orig_payload_size, id_size, new_size, max_words;
+	union perf_event *ev;
+	struct thread *thread;
+	u64 nr;
+	int ret = 0;
+
+	if ((event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) ||
+	    !sample->callchain) {
+		return dt->delegate->callchain_deferred(dt->delegate, event,
+							sample, machine);
+	}
+
+	nr = sample->callchain->nr;
+	orig_payload_size = sizeof(event->callchain_deferred) + nr * sizeof(u64);
+	if (event->header.size < orig_payload_size)
+		return -EFAULT;
+	id_size = event->header.size - orig_payload_size;
+	if (hdr_size + id_size > max_size)
+		return -E2BIG;
+	max_words = (max_size - hdr_size - id_size) / sizeof(u64);
+
+	if (symbol_conf.guest_code && !machine__is_host(machine))
+		thread = machine__findnew_guest_code(machine, sample->pid);
+	else
+		thread = machine__findnew_thread(machine, sample->pid,
+						 sample->tid);
+
+	for (u64 x = 0; x < nr; x++) {
+		u64 ip = sample->callchain->ips[x];
+
+		if (thread)
+			mark_dso_hit(ibo, sample, machine, thread, ip,
+				     PERF_RECORD_MISC_USER);
+	}
+
+	ev = (union perf_event *)ibo->event_copy;
+	new_size = perf_event__inject_callchain_buildid_array(
+		thread, sample->callchain,
+		(__u64 *)&ev->callchain_deferred.nr_build_ids,
+		max_words, &ret);
+	if (!new_size) {
+		thread__put(thread);
+		return ret;
+	}
+	new_size = hdr_size + new_size * sizeof(__u64);
+	if (id_size) {
+		memcpy((void *)ev + new_size,
+		       &event->callchain_deferred.ips[nr], id_size);
+		new_size += id_size;
+	}
+	ev->callchain_deferred.header = event->header;
+	ev->callchain_deferred.header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
+	ev->callchain_deferred.header.size = new_size;
+	ev->callchain_deferred.cookie = event->callchain_deferred.cookie;
+
+	ret = dt->delegate->callchain_deferred(dt->delegate, ev, sample, machine);
+	thread__put(thread);
+	return ret;
+}
+
+static int
+inject_bid_offset_tool__build_id(const struct perf_tool *tool,
+				 struct perf_session *session,
+				 union perf_event *event)
+{
+	struct delegate_tool *dt =
+		container_of(tool, struct delegate_tool, tool);
+
+	if (session)
+		perf_event__process_build_id(tool, session, event);
+	return dt->delegate->build_id(dt->delegate, session, event);
+}
+
+static int
+inject_bid_offset_tool__mmap(const struct perf_tool *tool,
+			     union perf_event *event,
+			     struct perf_sample *sample,
+			     struct machine *machine)
+{
+	struct delegate_tool *dt =
+		container_of(tool, struct delegate_tool, tool);
+	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+
+	if (cpumode == PERF_RECORD_MISC_KERNEL ||
+	    cpumode == PERF_RECORD_MISC_GUEST_KERNEL)
+		return dt->delegate->mmap(dt->delegate, event, sample, machine);
+
+	perf_event__process_mmap(tool, event, sample, machine);
+	return 0; // Drop user mmap events from output stream
+}
+static int
+inject_bid_offset_tool__mmap2(const struct perf_tool *tool,
+			      union perf_event *event,
+			      struct perf_sample *sample,
+			      struct machine *machine)
+{
+	struct delegate_tool *dt =
+		container_of(tool, struct delegate_tool, tool);
+	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+
+	if (cpumode == PERF_RECORD_MISC_KERNEL ||
+	    cpumode == PERF_RECORD_MISC_GUEST_KERNEL)
+		return dt->delegate->mmap2(dt->delegate, event, sample, machine);
+
+	perf_event__process_mmap2(tool, event, sample, machine);
+	return 0; // Drop user mmap2 events from output stream
+}
+
+struct perf_tool *inject_bid_offset_tool__new(struct perf_tool *delegate)
+{
+	struct inject_bid_offset_tool *ibo = zalloc(sizeof(*ibo));
+
+	if (!ibo)
+		return NULL;
+
+	hashmap__init(&ibo->synthesized_dsos, dso_ptr_hash, dso_ptr_equal, NULL);
+	delegate_tool__init(&ibo->tool, delegate);
+	ibo->tool.tool.sample = inject_bid_offset_tool__sample;
+	ibo->tool.tool.callchain_deferred = inject_bid_offset_tool__callchain_deferred;
+	ibo->tool.tool.build_id = inject_bid_offset_tool__build_id;
+	ibo->tool.tool.mmap = inject_bid_offset_tool__mmap;
+	ibo->tool.tool.mmap2 = inject_bid_offset_tool__mmap2;
+
+	return &ibo->tool.tool;
+}
+
+void inject_bid_offset_tool__delete(struct perf_tool *tool)
+{
+	struct inject_bid_offset_tool *ibo;
+	struct hashmap_entry *entry;
+	struct delegate_tool *dt;
+	size_t bkt;
+
+	if (!tool)
+		return;
+	dt = container_of(tool, struct delegate_tool, tool);
+	ibo = container_of(dt, struct inject_bid_offset_tool, tool);
+	hashmap__for_each_entry((&ibo->synthesized_dsos), entry, bkt) {
+		struct dso *dso = (struct dso *)entry->pvalue;
+
+		dso__put(dso);
+	}
+	hashmap__clear(&ibo->synthesized_dsos);
+	free(ibo);
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
2.56.1.831.g720f3f5937-goog


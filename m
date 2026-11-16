Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815130;
	b=rBdntwiA2obNutqWiaKZBIPIK3k7/da8heAkwm3n5hzTw0zXcGl32q1FvaYE8Wtv0sOO
	 ot35ANkI+jGdNFCH1FyGfhdns8QlJDRPYZC7Akr8QRCsRqgKb9ZumP6cSdP4lY4Q7HbuW
	 3GZQ4U/cMIf6DZrCASQHbSJGloAe2GR2aSxH71mPG7XpCtePWMKkNS/xGE5ndMErCLbkr
	 ltqvTWIGrnevYDhL/xp6y2YujUbjVq/P4qK6vcCaA/HVdJP1s88hE/78y+0X2ViKkzIcw
	 kdsLCPFeBTYfrFRjkjJrDzbqdAoRzj+DQQ6Hvx+VOihpnzArkePu96H74GiqXq1YGxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7m0r3AW8e4X3U39eYnf6yRoiL3e0C7dD5id27S0yc7M=;
	b=eQAn9s4/f6vLv3b4WYAdrOU9vHQM+2gfMfxtamizc+VKdvnMiZJKsUlAMLonc3+j6WKt
	 fHD7p/pUoW+UYVpKDdRVG/922C/tkdxQ1P6/fpAu3gDjhJSg3SRPEIGJFz/1ARr6fI1Wn
	 xu8ulsUjnokkdCq0Y4kzz9Gn2RnevuzOB6RAKp2cQSxHyISmMA2f1dTONJiiJdr6Bq0X3
	 fwr9VYzgFxaHoC52S1KVbjXo5/nWg6mHQA5Vyc1WSSFvutN/zb5ita60R+lW1e2hVs9dB
	 pJzD03A8hcdxQIZKtL1LY0HZGOJ821r581v+ptZUaB3/Oab6/mQNfCWusgdNj36Q44w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OVDsemk0;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C16606A88F
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79C16606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OVDsemk0
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14373747468so805296c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815130; x=1795419930; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7m0r3AW8e4X3U39eYnf6yRoiL3e0C7dD5id27S0yc7M=;
        b=OVDsemk0fGdBdYG1VTg9ItudnrGzjXK8lqIgW8afKevatigkxUcriIdTW1ma2oL6r4
         wJJ5CCV0brdfzDdneW3m6v0xsJwFxT3xP0Jm3jwGtDmgipdawrbV49TGFeoFcTlcgZ24
         beoslciH9SN7daLrT820vk2Ws5Ne1kJmzo1/aegaBtaVsFCdGHCLBAkmve+tp+zcUl82
         3LER/GubIkOCUdxK8eRgHRxBzrf6zD8+YaOTVz767IPV2oAklVPyCrWOCZGfTXEtOBv4
         BYhA+4BCxqpD0rEj/J/H2+vYf2SUEG9RAwxIav2jMMqIieHZQ+kLaIM4ybvcBwa9XA5E
         lCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815130; x=1795419930;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7m0r3AW8e4X3U39eYnf6yRoiL3e0C7dD5id27S0yc7M=;
        b=uCbEeb4EU/TINkGdbfaP+8v/vgVJJrUBag93/o4hoDEJJ0xMNN+TB4eFQk42/xsNlU
         Vfwb3C35FNLPhshuh9hgyE0KjguqqOGYf8Uw+q2uZqVHPxyADk75mhzMptKYJ60JVnix
         PPurK1UG9R2neB3Jm/+NcfhqjD8zyepLRmLc6dZDEd2Od9FkL1QWXxGXBbRRGXOsn9ke
         wQi56RHkywUskk5CkO4UJk496iWAdmUYlGKyOpcDOECZTXoNoZPtWgtOfo2q8mfSaThD
         lAg3GobGK/plgJrVyfvPqj/UWpC0RGFgTRhytfPeoP7EsSwZX3d/ftVDtWYPVk8aphZE
         jfWg==
X-Forwarded-Encrypted: i=1; AL+hErG6rGu/QvmLmGfQF33M3vDhFkynXYPzhMxIrehAGoUDDrFkMdBrhLOOpr0s3wuc2CoZBl3WM8Pah1CT8t9Absvg@vger.kernel.org
X-Gm-Message-State: APuU4Z8YvZA0PQ7GWaKBmKK8W3yJ8phPygQvq9D/IZ925vN/B0cADdHn
	VYWPhwIMVg5yt1Qaj+n4MikZcria/EAmZrkPGGl9sMrfQ57yj7Zzk3ozYoQ+zrEFN+CB1jYd6Ti
	pL+xJG1JIUg==
X-Received: from dlbsj1.prod.google.com ([2002:a05:7022:f901:b0:1a7:17d1:fc4a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2594:b0:1b4:caae:3324
 with SMTP id a92af1059eb24-1b5030ad1d8mr11281759c88.21.1794815128932; Sun, 15
 Nov 2026 23:45:28 -0800 (PST)
Date: Sun, 15 Nov 2026 23:44:06 -0800
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
Message-ID: <20261116074414.3174737-12-irogers@google.com>
Subject: [PATCH v3 11/19] tools headers UAPI: Sync linux/perf_event.h for BUILD_ID_OFFSET
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

Synchronize tools/include/uapi/linux/perf_event.h with the kernel UAPI
header for PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET, and add struct
perf_sample_build_id_offset and the struct perf_record_callchain_deferred
build ID union fields to tools/lib/perf/include/perf/event.h.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/uapi/linux/perf_event.h | 59 ++++++++++++++++++++++++---
 tools/lib/perf/include/perf/event.h   | 29 ++++++++++++-
 2 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index deb7c42d109b..775420ed9aee 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -165,8 +165,10 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
 	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
+	PERF_SAMPLE_BUILD_ID_OFFSET		= 1U << 25,
+	PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET	= 1U << 26,
 
-	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 27,		/* non-ABI */
 };
 
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
@@ -840,7 +842,8 @@ struct perf_event_mmap_page {
  *
  *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
  *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
- *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
+ *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 and
+ *                                         PERF_RECORD_CALLCHAIN_DEFERRED events
  *
  *
  * PERF_RECORD_MISC_EXACT_IP:
@@ -852,7 +855,7 @@ struct perf_event_mmap_page {
  *   Indicates that thread was preempted in TASK_RUNNING state.
  *
  * PERF_RECORD_MISC_MMAP_BUILD_ID:
- *   Indicates that mmap2 event carries build ID data.
+ *   Indicates that mmap2 or deferred callchain event carries build ID data.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
 #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
@@ -1095,6 +1098,38 @@ enum perf_event_type {
 	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
 	 *	{ u64			size;
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ union {
+	 *		struct {
+	 *			struct perf_build_id	bid;
+	 *			u64			offset;
+	 *		};
+	 *		struct {
+	 *			u64			zero;
+	 *			u64			context;
+	 *			u64			cookie;
+	 *			u64			ip;
+	 *		}; && attr.defer_callchain
+	 *	  }; } && PERF_SAMPLE_BUILD_ID_OFFSET
+	 *	{ u32			nr_build_ids;
+	 *	  u32			nr_offsets;
+	 *	  struct {
+	 *		u8		size;
+	 *		u8		data[size];
+	 *	  }[nr_build_ids];
+	 *	  u8			pad[];
+	 *	  u64			offsets[nr_offsets];
+	 *	  #
+	 *	  # Entries in offsets[] include PERF_CONTEXT_* markers (which
+	 *	  # have top 8 bits 0xff). Kernel/hypervisor entries (after
+	 *	  # PERF_CONTEXT_KERNEL, PERF_CONTEXT_HV, PERF_CONTEXT_GUEST,
+	 *	  # or PERF_CONTEXT_GUEST_KERNEL) and the cookie word following
+	 *	  # PERF_CONTEXT_USER_DEFERRED are raw 64-bit values. User
+	 *	  # entries (after PERF_CONTEXT_USER or PERF_CONTEXT_GUEST_USER,
+	 *	  # or in PERF_RECORD_CALLCHAIN_DEFERRED) use the top 8 bits to
+	 *	  # encode a 1-based index (1..254) into the build_ids table and
+	 *	  # the lower 56 bits for the DSO file offset, or 0x00 for an
+	 *	  # unresolved user virtual address.
+	 *	} && PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
@@ -1306,8 +1341,22 @@ enum perf_event_type {
 	 * struct {
 	 *	struct perf_event_header	header;
 	 *	u64				cookie;
-	 *	u64				nr;
-	 *	u64				ips[nr];
+	 *	union {
+	 *		struct {
+	 *			u64		nr;
+	 *			u64		ips[nr];
+	 *		};
+	 *		struct {
+	 *			u32		nr_build_ids;
+	 *			u32		nr_offsets;
+	 *			struct {
+	 *				u8	size;
+	 *				u8	data[size];
+	 *			}[nr_build_ids];
+	 *			u8		pad[];
+	 *			u64		offsets[nr_offsets];
+	 *		}; && (header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
+	 *	};
 	 *	struct sample_id		sample_id;
 	 * };
 	 */
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 867dd55f0969..216f42f7485b 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -3,6 +3,7 @@
 #define __LIBPERF_EVENT_H
 
 #include <linux/perf_event.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/limits.h>
 #include <linux/bpf.h>
@@ -168,6 +169,21 @@ struct perf_record_switch {
 	__u32			 next_prev_tid;
 };
 
+struct perf_sample_build_id_offset {
+	union {
+		struct perf_build_id	bid;
+		struct {
+			__u64		zero;
+			__u64		context;
+			__u64		cookie;
+		};
+	};
+	union {
+		__u64			offset;
+		__u64			ip;
+	};
+};
+
 struct perf_record_callchain_deferred {
 	struct perf_event_header header;
 	/*
@@ -176,8 +192,17 @@ struct perf_record_callchain_deferred {
 	 * the PERF_CONTEXT_USER_DEFERRED entry.
 	 */
 	__u64			 cookie;
-	__u64			 nr;
-	__u64			 ips[];
+	union {
+		struct {
+			__u64	 nr;
+			__u64	 ips[];
+		};
+		struct {
+			__u32	 nr_build_ids;
+			__u32	 nr_offsets;
+			__u8	 build_ids[];
+		};
+	};
 };
 
 struct perf_record_header_attr {
-- 
2.56.1.703.gf848ed807c-goog


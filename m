Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567905;
	b=5msWW1YohYZU5/qv8612yXCtft6PVe9SH+ynAz5kcA5nCp6acu8AmWQyFqXxgXADnL+u
	 o++GMhH/py0zs+GSdBBwnhHgY15TUtjEth4uVbiHA544Foy0sXSWbAMq7BLSSe8GOnRNq
	 O7NkzamGE7uCgjVqB9QS9fpFTjBVAEDeNA3Unq7J3zynTtaKWCOoiauG5xL8CJGsGu7PI
	 ihDV31Yqsm1WaxKU0F5B2qpsEwh7wdLrQJPQjsyO8Z9HW9+wkS+z7ko/tRo0S+xhAocxf
	 ufKETX25Xh01c7ilU80GXXXguFbmol48eekdWjUGT/Ge62Qsynll6XztRxxF1J4dQyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=zlhGZaJlp2XtgBlK5olGGCsF2dB20UKYO0i1UX+U1qc=;
	b=tToY3MeHGMs/zMlcVCqJIla/dsFe67pg7EjZem0SrLdL3Ya0t3n2eQr64jjiiaXhvRwD
	 hoYpoCpbjFsnMdjbVIEGKxc1fTEGufJ8aIQzOScclP2mxNQZ9BAK+W8v1LeC0WqqF2cE3
	 4xv3UTlKIQ0W3pWGGq56xCmEfdKLHBxhz0zMUG8+BDC5GWqwiZ3wvTA9STCg645qikMaI
	 9OnJ0fiqwlON62Bn8vvp/pKQ49lMohqdtf9DSNOpzoseKVKyq2TXnO39pJmgYOkJLSYBK
	 93tL2cyrUZPSL7rSbq65l4Pob59kFcMeuG5Xpds1gdrHoiddtzsbpW/F1pzEefR2SVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Lb77kiay;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF3606A696
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 00:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8AF3606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Lb77kiay
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4dab94dc3e7so11276159b6e.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 16:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567904; x=1796172704; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlhGZaJlp2XtgBlK5olGGCsF2dB20UKYO0i1UX+U1qc=;
        b=Lb77kiayu2zK8cbey7LZHlFSiMs2QpVP8Qh7G7/T9gFD0RG5LWOzFnOHdbVSk1JOj7
         hyLh+PzBXkbt4H15HLeCiEwWFROqh6v/KgWiizAi6lD9dWv4WNbnf43+aGT3X0jALohG
         jeBDnbsPjE/lh73R+prh/HLP3F574+40zT1GZp730wsscLpDBI7Huf+LrQei4eg+VI+T
         RPyOhkCrlj5w2v2EAEVJTQlkTf2ho1dMPzH7AzpEC8z6tRQeB6PTi7gZ0w5SMbKditWY
         kv4aovKpVcwUGG78wEnEoZpqxCPEAH473po97aj8NqdCbpc2+YavaaC6ahzEX5PfpLYd
         i0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567904; x=1796172704;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zlhGZaJlp2XtgBlK5olGGCsF2dB20UKYO0i1UX+U1qc=;
        b=lPtE0YpLi9xihCeS6gIpDX3dE1h9ZN0GZX0dKh7ogkG3Er1dV9SiWP0+zG/3h8rS89
         PZphkG4cCDwV2evaUB7gqzT0M+VpUOhRpc3S3pqB7q6laImw29H6vUDDrDL79Q+hzXCe
         poJFih0irC2gr4j3CsUoL66TcezCJCeCneUZ7jHM89h77t0rOzOsL9wOGfdNIpsDO6Y7
         8JE92Px6qLVsIoeQCzMaLBXu3+OgmxfKnsq6SAOmgGQFh9dBdgpMHoxsRhhW1LecssCd
         PV6nIuJxb2BKBT2iZrXVYlMw+bD+tMZmZhc6Ufm9UMwTCZ2Nhiy1OY7rSEOrd3Y913TG
         mL+A==
X-Forwarded-Encrypted: i=1; AL+hErGfgp2g9mpiPV4LgH4mzopTUT4z6l1jS2cJO9AjRTO45y6m+uRjTNq1zxgypGSv4oYDHWNmLH/i1dwebWzz+nIU@vger.kernel.org
X-Gm-Message-State: APuU4Z/o8HQQGW3mSW/4w37i/NVUPTt/a6jdWPNSlFfJpj2AWhze8jU8
	pk8v5TNBEyaD8zZ3NmabL7Y/Q6V1cUTi3aBd8Z26Aa2IS6i0GR99EVMv2Rgks4fDqttZs07wwr5
	zGlXvWiY1GQ==
X-Received: from oix3-n1.prod.google.com ([2002:a05:6808:a543:10b0:56d:7b0c:945f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:2222:b0:4b9:e88f:89dd
 with SMTP id 5614622812f47-57a0bb6ee43mr19192091b6e.43.1795567903552; Tue, 24
 Nov 2026 16:51:43 -0800 (PST)
Date: Tue, 24 Nov 2026 16:51:00 -0800
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
Message-ID: <20261125005108.1020003-12-irogers@google.com>
Subject: [PATCH v4 11/19] tools headers UAPI: Sync linux/perf_event.h for BUILD_ID_OFFSET
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

Synchronize tools/include/uapi/linux/perf_event.h with the kernel UAPI
header for PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET, and add struct
perf_sample_build_id_offset and the struct perf_record_callchain_deferred
build ID union fields to tools/lib/perf/include/perf/event.h.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/uapi/linux/perf_event.h | 77 +++++++++++++++++++++++++--
 tools/lib/perf/include/perf/event.h   | 29 +++++++++-
 2 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index deb7c42d109b..a87cfcd0f19e 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -165,11 +165,15 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
 	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
+	PERF_SAMPLE_BUILD_ID_OFFSET		= 1U << 25,
+	PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET	= 1U << 26,
 
-	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 27,		/* non-ABI */
 };
 
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
+#define PERF_SAMPLE_CALLCHAIN_TYPE \
+	(PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)
 
 /*
  * Values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set.
@@ -840,7 +844,8 @@ struct perf_event_mmap_page {
  *
  *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
  *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
- *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
+ *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 and
+ *                                         PERF_RECORD_CALLCHAIN_DEFERRED events
  *
  *
  * PERF_RECORD_MISC_EXACT_IP:
@@ -852,7 +857,7 @@ struct perf_event_mmap_page {
  *   Indicates that thread was preempted in TASK_RUNNING state.
  *
  * PERF_RECORD_MISC_MMAP_BUILD_ID:
- *   Indicates that mmap2 event carries build ID data.
+ *   Indicates that mmap2 or deferred callchain event carries build ID data.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
 #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
@@ -1093,6 +1098,54 @@ enum perf_event_type {
 	 *	{ u64			cgroup;} && PERF_SAMPLE_CGROUP
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
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
+	 *	  };
+	 *	  #
+	 *	  # For resolved user IPs, bid holds the build ID (1 <= bid.size <= 20)
+	 *	  # and offset holds the DSO file offset. For non-user IPs (e.g. kernel
+	 *	  # or hypervisor) or unresolved user IPs, bid is zeroed (bid.size == 0)
+	 *	  # and offset holds the raw instruction pointer / virtual address. When
+	 *	  # attr.defer_callchain defers a user IP, zero == 0 (bid.size == 0),
+	 *	  # context == PERF_CONTEXT_USER_DEFERRED, cookie identifies the
+	 *	  # deferred PERF_RECORD_CALLCHAIN_DEFERRED event, and ip holds the raw
+	 *	  # user virtual address.
+	 *	} && PERF_SAMPLE_BUILD_ID_OFFSET
+	 *	{ u32			nr_build_ids;
+	 *	  u32			nr_offsets;
+	 *	  struct {
+	 *		u8		size;
+	 *		u8		data[size];
+	 *	  }[nr_build_ids];
+	 *	  u8			pad[];
+	 *	  u64			offsets[nr_offsets];
+	 *	  #
+	 *	  # Each build_ids[] table entry has 1 <= size <= 20 (matching
+	 *	  # struct perf_build_id::data, e.g. 8, 16, or 20 bytes; the kernel
+	 *	  # currently zero-pads resolved build IDs to 20 bytes via
+	 *	  # bpf_stack_build_id, while user-space tools such as perf inject
+	 *	  # may emit the exact unpadded length).
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
 	 *	{ u64			size;
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 * };
@@ -1306,8 +1359,22 @@ enum perf_event_type {
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
2.56.1.831.g720f3f5937-goog


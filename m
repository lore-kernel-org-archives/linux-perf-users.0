Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567888;
	b=4DlzosH5YTTDxglOov3Fudx4fKev4z+nBz4WgS6D/vD8nOPlA5TPasM9r7jh1ZSFf4s0
	 TUTLAR9JOlnsVjTyVcwrLqmpfissFGC4iC9uX848SML8rvUeZs2u5EHDM/RsIvcYd2+M6
	 CpB3w8MKpnhw/+vo43KxocH0MItz5gEvOq6SEJH3VjIwXNowHO8rSPzHP0qpoJTAYqZrS
	 jna6PFzyA741mrHi+dhf5zwHx4a0NH2A3i4vBEWnJrdyHeayAFfrFhSYXKTmaHXDSNU14
	 N4B0cvgmCZOjFjskRSLSukFu7FQqW5zv94s6wPIZFpUW4rNlTFJyYeMQgXAB3XsxlKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=2KGzqX+aofV7aIXs6hHlbKE15ZTZmDrFthR3dTiZCwU=;
	b=5cT/p+i+lMaRRSKw3T/J2NtIqMJtYrXiV97ywgiy/QB12u+T12EyioYBP8ldP0DhEy2J
	 UOWDkH6nmHCeDsfSJ8SEoadpDnYWVioBN7LQT03a5Xmcle2pzesDMKLeHJ8Iowuwi6i3u
	 jFtYp5eej1qvsqF+kkC3tP3GuARh5ZRP41yhZHLOWtGcKaJ3aDf/BdCy58iK1ID9vorFn
	 3wwgc4q0PHxhyf09sOZ+tG2qQK0qP0Z87VHLX1ipOtp92EnQEeSAKSfMPSbugjRhsHyWj
	 3or3Iqp4QwqoDcoRYJnRdNdIfmce/8NlVE6dUvueon5KAN3AxsBEZu96Dw0Bkq+Lobg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XEWJ+3U1;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9458F606A33A
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 00:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9458F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XEWJ+3U1
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386a65fca25so4002068eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 16:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567887; x=1796172687; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2KGzqX+aofV7aIXs6hHlbKE15ZTZmDrFthR3dTiZCwU=;
        b=XEWJ+3U1W4PRQrFooGhRA8sfF4w2ZpRnE3O16wxYUQD2wMOZ3yt+BvN+KrJkE/naWU
         x1uBQz5YdBywfW6s1UlPYSp3QrId8Tn20w2EpZUKnbc7F35eA8VSGctpMSozwki3+1M6
         eLmnlt4Gwoa0eVLRvM1AngqCPI6aNyA4TaK9P5Beq9Ost6RXIpCBmb7QU+ERv6PYFDgL
         Oozj4fbaO9rtxcEzCJwaQsuQjLeK4FqQSCDZtFmottaVprwImXwLfwF7VkhOIhmH8Udh
         Ta8XD5hx+tBtM8wPiiIdaASr7MflipWijIKc/uiTB7AsHFnsx+RkvgnUwUdYJnD8iQDH
         AEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567887; x=1796172687;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2KGzqX+aofV7aIXs6hHlbKE15ZTZmDrFthR3dTiZCwU=;
        b=NhLZZuxU7IgGzOPd1uqctmBkgwCIdbue3NQ61J5rr3P/QDd1vyowzdlwj/VTwmiYkk
         F5HPKg+o4M/Lq0AVjee4DxMxtkIEzuyydYckOeyn39lIKUNs7rfV2liab6jkkNDSzlpf
         I63G3kRvPwuNI/JxVCSJ5QDb7hxvOXG67dajZZpx+OPVLsx60ZVqfEArj5uzSrnmIIBl
         BgHhAWW6EUdssORxMSTPMHCX14EQ3rSY896HZiPyx+JJvX1eWlheJ6mQ2qjqxqvENxyN
         e3+9hTx0XeZORLNSQyb3JmDJuojzUWEFXfS3QzCHHXt3Tbs8M5GHcLzHiFusOuZobq5S
         1mEQ==
X-Forwarded-Encrypted: i=1; AL+hErE212UvybIXLsGZUHEdScnPn2o8j0OYA85aQHxrkwHhdggoOjP+3IIrEO016pbSMBsN64e6f4UoJyhqcFB2qG17@vger.kernel.org
X-Gm-Message-State: APuU4Z9M9OxS/Mw1nJSdwhhAB7NMTzf/zoGeeogfU5mhJm1vDan045gu
	2n70XN90QtfyNzXiA2b/roY5kPf6app4X6xY3y9V4dtOxaXCF2QuFdTpNQ1+BhD7Y/mT6eQ6Rju
	oSNaA8VrMZA==
X-Received: from dyib9.prod.google.com ([2002:a05:7300:79c9:b0:386:b9bf:ecab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:dd83:b0:386:5adb:ac29
 with SMTP id 5a478bee46e88-3865adbb03fmr13706950eec.7.1795567886404; Tue, 24
 Nov 2026 16:51:26 -0800 (PST)
Date: Tue, 24 Nov 2026 16:50:52 -0800
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
Message-ID: <20261125005108.1020003-4-irogers@google.com>
Subject: [PATCH v4 03/19] perf/uapi: Add BUILD_ID_OFFSET sample types to UAPI
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

Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET in enum perf_event_sample_format.

For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET (and
PERF_RECORD_CALLCHAIN_DEFERRED when PERF_RECORD_MISC_MMAP_BUILD_ID is
set), encode a deduplicated table of variable-length build IDs
(u32 nr_build_ids, u32 nr_offsets, followed by packed { u8 size;
u8 data[size]; } entries padded to 8-byte alignment) and an array of
64-bit offsets whose top 8 bits encode the 1-based build ID index (or
0x00 for unresolved user addresses and 0xff for kernel/context entries).
In common cases where multiple callchain frames belong to the same
binary, each unique build ID is encoded only once.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/uapi/linux/perf_event.h | 77 ++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index deb7c42d109b..a87cfcd0f19e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
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
-- 
2.56.1.831.g720f3f5937-goog


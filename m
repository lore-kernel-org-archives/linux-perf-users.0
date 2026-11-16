Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815115;
	b=tkx0b72SoDcU4u45jBDyT8vEfk6q94pAcd3RkdVNnW7hH6zGbys57x576EHI9AgYQcP2
	 Y8yCzZsj5DAHZ1PBs2msS9uqqmh/hRKBygNLA7FxfSxAt/aDL+uG5e+bW8yJ7Gjybn80P
	 eQNCyeObs+ZXFKFfzRxRDa8PyumwjFvoCzDaEtEMZUdJHcKlyQcRRx1EQUmdHAV10f5wn
	 NAmMxK9DI3TcGurt0PE753VP/zTVTBXTim7nAplX6Eg2B9WstjnIxfn6R0BYxMhsyt1k0
	 SHNrpoUcC72653oob4gHY8PcnnJIyJao2PAULoDf7EK4G0tZP+Uo7Mn13LbPCAYEGzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=AGt0uBqNqrRBqkScWR/mb8l6aDImYIyfnkOYjdl57zg=;
	b=VgGnX6OiHd2LCOpXWgMFwFjPGWVgV7qW5hx/qXSkQsdIKD7Xx8bgmXRgmzbJRQ+kn1AT
	 638lhEV7s/UISkTmuSgDY2dtd+N8W0z0vZ+gRn2xYwM/H+dOJX+mf34RDAf7lnFMIAhPi
	 H7fxFMZRP13AvuVs6I4d2bE74QU/Efm7mPIVt/ZXNS88ZJ3+bKPw847/TM/04j66BYqLy
	 sqvtWLRJruId+Nud2ZUdvHUToepBqpkvBfIY8kufscw3xQV7ELhus2ap6zcFOQ2Dck5H/
	 dz8muw6AZ6Nj+OcOyDb7tMozsKJ89A38T0kCFJSqx5Tb53q0GbDmT4Jc2VygG3TPT0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m5pm5Vg4;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1276606A337
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1276606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m5pm5Vg4
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36de26cb4b3so3915943eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815114; x=1795419914; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AGt0uBqNqrRBqkScWR/mb8l6aDImYIyfnkOYjdl57zg=;
        b=m5pm5Vg4t7Wg1bRT8UDv5ZOx2rye/UtjlR3e//Hx34+afV8SD0Ddpa39FJ7+s6wub6
         Xbk5z2wwYLXYbvkCaa8yibefV5Vvmx6ix9/qo6NuDfqLz0uBn6lZ0sCj+tCGvG6Qu2cz
         1TzO8uRIVHc9VlKMWLEWvtnMk9vPhwXpK93y6m06dhao9LBaacuqkjgibcevN4Ozw7lM
         xmAxurgddF4wP25JzjxY+T2G4vLQvRcX96nVn8MfRuU5zvP9btLJh1ZR9UyeEmfuU7t2
         D2kVogDolxnMJFIeH4povwmHuAMqf5liR7N5DLY9JRxoV01fWdt+5WES1DCwgjp7l3xm
         NfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815114; x=1795419914;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AGt0uBqNqrRBqkScWR/mb8l6aDImYIyfnkOYjdl57zg=;
        b=WRzQtJ4Oh3Q3SdFEyJJdpNILrl5bQFuIVT7SFEghgyI2lcDC5E0+SSQ3sOIiKW/sW/
         K+Emd/MMoMfNKCMyUaplxlP0q6c4KHmcc1bzoPbq59RAD3wUt0lcoFbkw7je0t6RxCq6
         +S13elKv72aPymTPpyQV8RcIao2isoUC3LG45/gGUOqQ+bskN18Y1rYaR4EdSA/i5lZe
         B6ieBL0dkatw0p6GjyuMnmWIzDsECQOnCs5N/BLP/xQ9k9DtA2liob55IzAPA+Sr4y+P
         h4irlEpQ7oHU5TmdgplXlGKvys8SVHIz5hKU0jOw5GC7MJzyah2zGZ+5k1YVAc9uzxan
         ADJg==
X-Forwarded-Encrypted: i=1; AL+hErE4Wwpe0fel1VdB0tuYRO6STsuFSarv23I/Rr2ZYMskcNqIJyXzjSYowBXvB0T3PW6VLGlAPVcymva5WunEHjP3@vger.kernel.org
X-Gm-Message-State: APuU4Z9dA49FJHpPy/7gU6c6o63siAVWz/OWKvoqCo35MxrUT2UgWhdL
	yxF6kRbobskyzDmiyLBolqXtrbKX7+VrK0SxaiFCvZdNRn8ULvTd20h6O1i1B+ok1k7BVCoTgNS
	X06sHs7L8fg==
X-Received: from dybme13.prod.google.com ([2002:a05:7301:188d:b0:37b:f69b:a36b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:90b:b0:34d:755b:d60b
 with SMTP id 5a478bee46e88-37968b8a031mr8712195eec.34.1794815113280; Sun, 15
 Nov 2026 23:45:13 -0800 (PST)
Date: Sun, 15 Nov 2026 23:43:58 -0800
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
Message-ID: <20261116074414.3174737-4-irogers@google.com>
Subject: [PATCH v3 03/19] perf/uapi: Add BUILD_ID_OFFSET sample types to UAPI
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
 include/uapi/linux/perf_event.h | 59 ++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index deb7c42d109b..775420ed9aee 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
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
-- 
2.56.1.703.gf848ed807c-goog


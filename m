Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D4A4B44A0
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962754; cv=none; b=KK+67SMvDk9y+9yjGFQfJmEJNJWORME0fP70DPqWIDXEqglmk/hc9rDOYM7VFl/do6WCo/bj29pTS1/rIExzzvNeQOPG3bcf09666/241SSOLuqd8F/4uKl3Tw7v8CE8VzAf9VA87UH6UON7Wc4ERqCVoDeyir71AQhhy/6G3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962754; c=relaxed/simple;
	bh=SvmASm/ZE0sfMHKWJQJCZeyGgk5hCZFeIVaWk04hEmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iv0qN7WF0Rk0JTlIfPWQslyDHkmT4VqSPx7oA3+W4EJOLThXUQxeHvoZ++y2i072awpTk58xl/KrmDhU/DtqsZ3nFdCPdAtWkYgR96Lq/2W7cBioZQnxNHBlAZ7rmuxRo271Q+o6O0UGRP2XY47N0loOn1dVDAZEI7+kmjD14PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tu0JapWU; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tu0JapWU"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-151ba226e1bso164757c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790962744; x=1791567544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=drdpwK9YpIc0sSkvF1r81dcKTiroyBrA2bPg2mMnTow=;
        b=tu0JapWUxWqyNpQbCPDZuJhoSJ0/8yh8a2+fjDyqrhKCRUlcJGvioPLD/FCg+8SIMw
         QrKsYdi/16EJ6btW7aUXqeGoIiY3qC69jvZVgnimRCuumINsP/9gTK87T0qGMQz6bMRH
         r+xLQDrAZgwNNNlFjl/CpnCYfylk5s3akvTxIXokRvczkRliqAgokvPown53lpqubBga
         RivaymHqJ0euWblu8uSIaTAUQAfw9B3cxcuBn9uRb9VWufUfPDyhFCrEgK1SlORsUwO1
         wo7MKLXBZdxM3A4jPJ4KjUU+qgY3+h169fh42g9blISPCjuVfcSKanMUTrnEPIqBx7u+
         jPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790962744; x=1791567544;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drdpwK9YpIc0sSkvF1r81dcKTiroyBrA2bPg2mMnTow=;
        b=TgKDa2Hi4VLVglsU8RmCXgbwbOSTi+Lr9lQtnf93bnSGPPrd3SeA4dK/Sv5wwylYcg
         HSnVwgoqnSN3As4INFA3jAOt/o4HUraiB4qqLB/DzzKLyJjgS327G2HdTeNV+V4ekBrh
         VlBe8W0oI2zZs+1e4UCbzzw1vzJGjvmLYT8kqhhfV12b5TA9AzAe9NKF0CgLcCHfnr3s
         90h/dHdaQX4U1mHCeNlEV27DxnI7x7KCoFkdGdOet5X+O7061TBGpB7II+XFU+qJWUWb
         ubAi7sURS8HIZeRILmGo/sXFjRI5s6mMO7Ctqm19xAcyqgSeT0GN7G11jMIKTmvonj+G
         3UcA==
X-Forwarded-Encrypted: i=1; AKwUvBz6ooTNWaaDPNRSztCVhbw5zAo9zqDkPFI6tZgyxoLmjLMeWo4mW95Z0waX7d1ntPsis+QtliiqB1xDzp6Vsr+M@vger.kernel.org
X-Gm-Message-State: AFuF++kUFW55DNbXSue7RJcxI0jPtnZF1iUppqUJrDZkaYXfzFdNQXsI
	wMExWy0ry8KX1TU6d5ytXIL1VGdV9nUrRpELwxWSUB6wWc1RZCgucVyn57jK+LM/eiiEYKlijDQ
	SQD16b1w7qw==
X-Received: from dlk29.prod.google.com ([2002:a05:7022:11d:b0:14d:e2bc:f747])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:902:b0:143:3d94:501c
 with SMTP id a92af1059eb24-14f5d2b268fmr3733105c88.38.1790962743833; Fri, 02
 Oct 2026 10:39:03 -0700 (PDT)
Date: Fri,  2 Oct 2026 10:38:35 -0700
In-Reply-To: <20261002173848.3228217-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com> <20261002173848.3228217-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002173848.3228217-3-irogers@google.com>
Subject: [PATCH v2 2/8] perf/core: Add BUILD_ID_OFFSET to UAPI
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
Content-Transfer-Encoding: quoted-printable

Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/uapi/linux/perf_event.h       | 34 +++++++++++++++++++++++----
 tools/include/uapi/linux/perf_event.h | 34 +++++++++++++++++++++++----
 tools/lib/perf/include/perf/event.h   | 33 +++++++++++++++++++++++++-
 tools/perf/util/session.c             | 34 ++++++++++++++++++++++++++-
 4 files changed, 125 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_even=
t.h
index 035b4b416ce3..4157aa8a243a 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -165,8 +165,10 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_DATA_PAGE_SIZE		=3D 1U << 22,
 	PERF_SAMPLE_CODE_PAGE_SIZE		=3D 1U << 23,
 	PERF_SAMPLE_WEIGHT_STRUCT		=3D 1U << 24,
+	PERF_SAMPLE_BUILD_ID_OFFSET		=3D 1U << 25,
+	PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET	=3D 1U << 26,
=20
-	PERF_SAMPLE_MAX =3D 1U << 25,		/* non-ABI */
+	PERF_SAMPLE_MAX =3D 1U << 27,		/* non-ABI */
 };
=20
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_S=
TRUCT)
@@ -815,7 +817,8 @@ struct perf_event_mmap_page {
  *
  *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise e=
vents
  *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
- *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
+ *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 and
+ *                                         PERF_RECORD_CALLCHAIN_DEFERRED =
events
  *
  *
  * PERF_RECORD_MISC_EXACT_IP:
@@ -827,7 +830,7 @@ struct perf_event_mmap_page {
  *   Indicates that thread was preempted in TASK_RUNNING state.
  *
  * PERF_RECORD_MISC_MMAP_BUILD_ID:
- *   Indicates that mmap2 event carries build ID data.
+ *   Indicates that mmap2 or deferred callchain event carries build ID dat=
a.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
 #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
@@ -1054,6 +1057,23 @@ enum perf_event_type {
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
+	 *	{ u64			nr;
+	 *	  struct {
+	 *		struct perf_build_id	bid;
+	 *		u64			offset;
+	 *	  }[nr]; } && PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			=3D 9,
@@ -1260,7 +1280,13 @@ enum perf_event_type {
 	 *	struct perf_event_header	header;
 	 *	u64				cookie;
 	 *	u64				nr;
-	 *	u64				ips[nr];
+	 *	union {
+	 *		u64			ips[nr];
+	 *		struct {
+	 *			struct perf_build_id bid;
+	 *			u64		offset;
+	 *		}[nr]; && (header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
+	 *	};
 	 *	struct sample_id		sample_id;
 	 * };
 	 */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/lin=
ux/perf_event.h
index 63f8866479a3..56b0cd504a3d 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -165,8 +165,10 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_DATA_PAGE_SIZE		=3D 1U << 22,
 	PERF_SAMPLE_CODE_PAGE_SIZE		=3D 1U << 23,
 	PERF_SAMPLE_WEIGHT_STRUCT		=3D 1U << 24,
+	PERF_SAMPLE_BUILD_ID_OFFSET		=3D 1U << 25,
+	PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET	=3D 1U << 26,
=20
-	PERF_SAMPLE_MAX =3D 1U << 25,		/* non-ABI */
+	PERF_SAMPLE_MAX =3D 1U << 27,		/* non-ABI */
 };
=20
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_S=
TRUCT)
@@ -840,7 +842,8 @@ struct perf_event_mmap_page {
  *
  *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise e=
vents
  *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
- *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
+ *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 and
+ *                                         PERF_RECORD_CALLCHAIN_DEFERRED =
events
  *
  *
  * PERF_RECORD_MISC_EXACT_IP:
@@ -852,7 +855,7 @@ struct perf_event_mmap_page {
  *   Indicates that thread was preempted in TASK_RUNNING state.
  *
  * PERF_RECORD_MISC_MMAP_BUILD_ID:
- *   Indicates that mmap2 event carries build ID data.
+ *   Indicates that mmap2 or deferred callchain event carries build ID dat=
a.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
 #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
@@ -1095,6 +1098,23 @@ enum perf_event_type {
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
+	 *	{ u64			nr;
+	 *	  struct {
+	 *		struct perf_build_id	bid;
+	 *		u64			offset;
+	 *	  }[nr]; } && PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			=3D 9,
@@ -1301,7 +1321,13 @@ enum perf_event_type {
 	 *	struct perf_event_header	header;
 	 *	u64				cookie;
 	 *	u64				nr;
-	 *	u64				ips[nr];
+	 *	union {
+	 *		u64			ips[nr];
+	 *		struct {
+	 *			struct perf_build_id bid;
+	 *			u64		offset;
+	 *		}[nr]; && (header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
+	 *	};
 	 *	struct sample_id		sample_id;
 	 * };
 	 */
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/p=
erf/event.h
index 173eab43c148..3d35a82cccb0 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -3,11 +3,24 @@
 #define __LIBPERF_EVENT_H
=20
 #include <linux/perf_event.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/limits.h>
 #include <linux/bpf.h>
 #include <sys/types.h> /* pid_t */
=20
+#ifndef __DECLARE_FLEX_ARRAY
+#ifdef __cplusplus
+#define __DECLARE_FLEX_ARRAY(T, member)	T member[0]
+#else
+#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
+	struct { \
+		struct { } __empty_ ## NAME; \
+		TYPE NAME[]; \
+	}
+#endif
+#endif
+
 /*
  * Verify the full field fits within the event, not just its start offset.
  * Only valid for fixed-size scalar fields =E2=80=94 for trailing arrays l=
ike
@@ -162,6 +175,21 @@ struct perf_record_switch {
 	__u32			 next_prev_tid;
 };
=20
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
@@ -171,7 +199,10 @@ struct perf_record_callchain_deferred {
 	 */
 	__u64			 cookie;
 	__u64			 nr;
-	__u64			 ips[];
+	union {
+		__DECLARE_FLEX_ARRAY(__u64, ips);
+		__DECLARE_FLEX_ARRAY(struct perf_sample_build_id_offset, bids);
+	};
 };
=20
 struct perf_record_header_attr {
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7fea9e72726c..5e113070b3c6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1186,6 +1186,38 @@ static int perf_event__header_feature_swap(union per=
f_event *event,
 	return 0;
 }
=20
+static int perf_event__callchain_deferred_swap(union perf_event *event,
+					       bool sample_id_all)
+{
+	u64 nr, max_nr;
+
+	if (!(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID))
+		return perf_event__all64_swap(event, sample_id_all);
+
+	if (event->header.size < sizeof(event->callchain_deferred))
+		return -1;
+
+	event->callchain_deferred.cookie =3D bswap_64(event->callchain_deferred.c=
ookie);
+	event->callchain_deferred.nr =3D bswap_64(event->callchain_deferred.nr);
+
+	nr =3D event->callchain_deferred.nr;
+	max_nr =3D (event->header.size - sizeof(event->callchain_deferred)) /
+		 sizeof(event->callchain_deferred.bids[0]);
+	if (nr > max_nr)
+		return -1;
+
+	for (u64 i =3D 0; i < nr; i++) {
+		struct perf_sample_build_id_offset *bid =3D
+			&event->callchain_deferred.bids[i];
+
+		bid->offset =3D bswap_64(bid->offset);
+	}
+
+	if (sample_id_all)
+		swap_sample_id_all(event, &event->callchain_deferred.bids[nr]);
+	return 0;
+}
+
 typedef int (*perf_event__swap_op)(union perf_event *event,
 				   bool sample_id_all);
=20
@@ -1211,7 +1243,7 @@ static perf_event__swap_op perf_event__swap_ops[] =3D=
 {
 	[PERF_RECORD_BPF_EVENT]		  =3D perf_event__bpf_event_swap,
 	[PERF_RECORD_TEXT_POKE]		  =3D perf_event__text_poke_swap,
 	[PERF_RECORD_AUX_OUTPUT_HW_ID]	  =3D perf_event__all64_swap,
-	[PERF_RECORD_CALLCHAIN_DEFERRED]  =3D perf_event__all64_swap,
+	[PERF_RECORD_CALLCHAIN_DEFERRED]  =3D perf_event__callchain_deferred_swap=
,
 	[PERF_RECORD_HEADER_ATTR]	  =3D perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  =3D perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] =3D perf_event__tracing_data_swap,
--=20
2.56.0.rc1.315.gc6ed9934b7-goog


Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B693A8D0
	for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 04:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833209; cv=none; b=S6jg6RJ0mIsOMcPHLqG4FRa5Ldu8sbZulZvgOkKnmaFatwlT/mnrH5eYOrbbnyFNTWZfLPJSG32FynphUrrMFal9GUNey2dO2Xa0/hxCJJ8IiWOBukWJDf0IQ+LYjBvDoOPCUpQ23vUozgP9l9F525iegoLjPaDzG91aQIpvUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833209; c=relaxed/simple;
	bh=Nv+3HueaFBpq0ManiQPb2nzrakeW2xnnHkQ4j1i1l+g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pUXCDf3jW1H1J7QBGFqEHpNsTERFknlL0nM4IWaShP4JMkkFIo+KNH5DzdRr1Av+rSSwxOOzct8pEL9gY5bDXIOaiuzw777vea4uMatjb23erNiKtVC9I75Fjs5x9Mwgff8jBWVHs4GrY5sGop3FK2QC9cX0GU4Hoe/pRt9Yfzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQVeyQJ7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQVeyQJ7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be26af113so127790367b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 21:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715833206; x=1716438006; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHUNwY+jZJ4I56wa5Ovfy+1yS4DVUHS8CDe2LVh2L3Q=;
        b=BQVeyQJ7XKXZrZXLL7X8iztvqNbOOpz254i+azpr1V5mrM40Y2f2U/wm/maoYh/TW5
         ZGhciTehLCYUjfRIKf/BjUJVW1WFZMa0ovNSzfqpH+51P2f+pnxKBxKAB1R0U79oZOid
         kPHQXY/sSKBkmjSIfCvyvZR0pZsMYReDkVbMilXAqltt6+mu4NeDlPosPFjHl+BUajVU
         X7r1qmeupYBAk13WSzSlFwrnK/pJYZT2rF5GBVZ5W2h4Nd0OXG+PsvjjZ31X7cLFT9fc
         C0VesNyDt77q7lwhgmtEGdZlm8ht5NXej0aLEc8NUWfGAI6oBLOMbW2L9Qh+s2MEodCO
         9N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715833206; x=1716438006;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHUNwY+jZJ4I56wa5Ovfy+1yS4DVUHS8CDe2LVh2L3Q=;
        b=rgHaJfyxLa8VmM8FgBAvsyRYRw4YMq9JHzqTbZdVewozdgyCGlYOpD9oyEyZ0jE+KG
         QyRtTCUHsmsoiVpIgZ1gufBy+OtOiXA9j9c9XbXd2RRnIM5bDvG7kFzyBu5wYyelwzS9
         g2vrHbY0NJkv/TWRzW196+j4hfavQYu3QIohgXUp4Jy6ktlLrm2LAs9sOrti1mBhzlQn
         3QXD8TPhzaj6WSKXUApODVeoo4A+AkUhDpeisFWDwPjPfwmSaq1L9o8RNUmJjWPxB0Zf
         mnlPX2fXs2GcPDeP23AnOPI6CfOOrh2iGUXPcyUh4YqlgdWDOM/NPocdpM/6aaNwSWui
         vaCA==
X-Forwarded-Encrypted: i=1; AJvYcCVKVIP+smDWVQZqQFnfh5/k2LB2NBMCTwV0bsZEOkb84F2zvPD6YMRlRTWlIvu/s4m9kyfxVmIiPss/LNXJjflFWvSoLbkYdluehSvSz0BDeA==
X-Gm-Message-State: AOJu0YxWlYF4sexnOY6/8dgqDVRsM3vMQwMhUzIehX9ujE3eXJqlt54Q
	TKl1/RDUCFZk29SgH8Oxz+ClEzYTNSqiNNZyinv+2fbwHBUUgrVjW+iw1Mo85DuW/xdl79WwaJY
	Bzv39IQ==
X-Google-Smtp-Source: AGHT+IEmsYfZ191hEn2qs6aItqv20l4B4aEnLGlOMnKMlr+RTXfnPSmdUNe5GTDQqUISBptTpjDFi2GkkTA9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bac3:cca1:c362:572])
 (user=irogers job=sendgmr) by 2002:a05:690c:3601:b0:61b:e6fb:9e08 with SMTP
 id 00721157ae682-622b01333cbmr41173597b3.8.1715833206211; Wed, 15 May 2024
 21:20:06 -0700 (PDT)
Date: Wed, 15 May 2024 21:19:47 -0700
In-Reply-To: <20240516041948.3546553-1-irogers@google.com>
Message-Id: <20240516041948.3546553-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 2/3] perf bpf filter: Add uid and gid terms
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow the BPF filter to use the uid and gid terms determined by the
bpf_get_current_uid_gid BPF helper. For example, the following will
record the cpu-clock event system wide discarding samples that don't
belong to the current user.

$ perf record -e cpu-clock --filter "uid == $(id -u)" -a sleep 0.1

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt     | 2 +-
 tools/perf/util/bpf-filter.c                 | 4 ++++
 tools/perf/util/bpf-filter.l                 | 2 ++
 tools/perf/util/bpf_skel/sample-filter.h     | 3 +++
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 4 ++++
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6015fdd08fb6..059bc40c5ee1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -200,7 +200,7 @@ OPTIONS
 	  ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
 	  code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
 	  p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
-	  mem_dtlb, mem_blk, mem_hops
+	  mem_dtlb, mem_blk, mem_hops, uid, gid
 
 	The <operator> can be one of:
 	  ==, !=, >, >=, <, <=, &
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 7e8d179f03dc..c5d6c192d33a 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -80,6 +80,10 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 		CHECK_TERM(DATA_PAGE_SIZE);
 		CHECK_TERM(WEIGHT_STRUCT);
 		CHECK_TERM(DATA_SRC);
+	case PBF_TERM_UID:
+	case PBF_TERM_GID:
+		/* Not dependent on the sample_type as computed from a BPF helper. */
+		return 0;
 	case PBF_TERM_NONE:
 	default:
 		break;
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index 62c959813466..2a7c839f3fae 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -95,6 +95,8 @@ mem_lock	{ return sample_part(PBF_TERM_DATA_SRC, 5); }
 mem_dtlb	{ return sample_part(PBF_TERM_DATA_SRC, 6); }
 mem_blk		{ return sample_part(PBF_TERM_DATA_SRC, 7); }
 mem_hops	{ return sample_part(PBF_TERM_DATA_SRC, 8); }
+uid		{ return sample(PBF_TERM_UID); }
+gid		{ return sample(PBF_TERM_GID); }
 
 "=="		{ return operator(PBF_OP_EQ); }
 "!="		{ return operator(PBF_OP_NEQ); }
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index 161d5ff49cb6..3e64ccacc5e5 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -34,6 +34,9 @@ enum perf_bpf_filter_term {
 	PBF_TERM_DATA_PAGE_SIZE,
 	PBF_TERM_WEIGHT_STRUCT,
 	PBF_TERM_DATA_SRC,
+	/* Terms computed from BPF helpers. */
+	PBF_TERM_UID,
+	PBF_TERM_GID,
 };
 
 /* BPF map entry for filtering */
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 8666c85e9333..da4b5eb7cce3 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -146,6 +146,10 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		}
 		/* return the whole word */
 		return kctx->data->data_src.val;
+	case PBF_TERM_UID:
+		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
+	case PBF_TERM_GID:
+		return bpf_get_current_uid_gid() >> 32;
 	default:
 		break;
 	}
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


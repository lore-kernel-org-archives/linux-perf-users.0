Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C19815D5CE
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Nov 2024 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730532183; cv=none; b=tNKNSwPIDWgnf7dpIQSHjye1/0rvNK7UAVTRMgxofLnncYPss0iLln8yGB6pr0bEUnCPe4/fPEHkfovG4MT2na+veja6lyGE1Pd9j6oUhtCGfR13hesYRjILGrKXNU2YRk+haLgmnrIdc8qBk7RcGj4g5fV7IyzS5zFFBaN8icQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730532183; c=relaxed/simple;
	bh=fw5FTiisDk5cyhf8wcogBBpQyMSz0nXrYiG3JWj7IaI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=d+qDBXppD7VcmdhXYkzyAS9UP/FRG0UMFvHpJadQStLumBKJUCqvPaBo8HsnYYzDRiazGXr7X8WjSzUWPYnF00nt5+kiWXW42uK7+Yu3PmRz4F0Rwv9up+1oN2l5gZ+lOeuWc385KLWn9G3gse5NheFHjX8pULWKif1bfkyNaaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgsGsarm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgsGsarm"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3c638cc27so55074247b3.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2024 00:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730532180; x=1731136980; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCWMpv5edYfDnb5d8WWLsWf6rYHjMo4DKAX+NrFH0Vo=;
        b=dgsGsarmKDzu7DXWHMzXJLOcgAd2lEwkB203GQClZ0LFZ8RaOBcbd3d3QP8m10bUrj
         bir8tGfLhOkVxea3uIyFG+pZqEG6HXHxmlWaloCGlMvrM9MxQsnvj0IBinNVtu73M+nJ
         BYxQCvhNMEYYuNd1ipvU1bhNk7uGJ5NzF1iprTTogzzWqtxBDvVgxYfHCUwXNCOyeAYW
         knFXNcxivntY5vNJAItBjiN1BIn7Ha4A9sX1fYNjv3X6SvFNSeXHQLwkeuPqaZwiGg0h
         n6DJ2j1EdWAWTUC97MYj62dd3OOls+mXQwErNnylEoX2a3ACVLDfbelw/b/PePTObigh
         ZZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730532180; x=1731136980;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCWMpv5edYfDnb5d8WWLsWf6rYHjMo4DKAX+NrFH0Vo=;
        b=pCUwx55kMItZPJbEOKraHJ36htJXNt4zoqSUqyYarRl2o82ezLNdeEsCIArmKgF2qx
         fb9YnFCWga0MXdVTgJep8totQla88GYL51MK20x8kGYIEZxq4AWm5RJkiQmHLpGF7u1B
         NDzk+ixKGPnj/f3/1tcsZNwl/FmEybXOVkThm4c+LYHpTXOeXaOjfni4v2RSLqeKiikk
         TCy18S9vOlPGhn8wCpM+A+sMg5t8MPeyvHCsfdg+a6FuQUcOBrtCPJYGBCjDkVEAhpPc
         A7L+R+l/ghoNSw/r8zbCgT/iYRY/ATQhPxrua/4pF4Am3xfXj+SVyViI8KyqDao16XvU
         omyg==
X-Forwarded-Encrypted: i=1; AJvYcCWkx4YDMQ2Lm0zjw361ue6kWX7s35umeUiOi28wrTzuTYV/BR6rHtMt2TVT0SlaXO2P46V0SIfHlcAG5KGdxSkW@vger.kernel.org
X-Gm-Message-State: AOJu0YxON5TvtGvU86i2YwAWCYU954xWIaOT86G8gLpnEyC6R4vD2uzX
	WRV7SIryIeLalOpJNNYdPRZovCFl2O+FQKGKMY7NKAlbZh4aSEKUReLz65E5EVPDGCmKuGnnyTL
	hL3BKxA==
X-Google-Smtp-Source: AGHT+IEzi3DGfz7/5kRORgI6khZ3NHLrnzaiy8a0u5K5pcyrqyHMFp5qHzaOdTuo9Jm4U9biA1B/intLMJ0F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a05:690c:6913:b0:6e3:1627:e866 with SMTP
 id 00721157ae682-6e9d8b8da3fmr8982797b3.3.1730532180225; Sat, 02 Nov 2024
 00:23:00 -0700 (PDT)
Date: Sat,  2 Nov 2024 00:22:45 -0700
In-Reply-To: <20241102072248.12836-1-irogers@google.com>
Message-Id: <20241102072248.12836-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102072248.12836-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 3/6] perf trace-event: Always build trace-event-info.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

trace-event-info.c has no libtraceevent depdendencies, always build it
and use it in builtin-record and perf_event_attr printing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c               | 2 --
 tools/perf/util/Build                     | 2 +-
 tools/perf/util/perf_event_attr_fprintf.c | 4 ----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f83252472921..0b637cea4850 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1748,10 +1748,8 @@ static void record__init_features(struct record *rec)
 	if (rec->no_buildid)
 		perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
 
-#ifdef HAVE_LIBTRACEEVENT
 	if (!have_tracepoints(&rec->evlist->core.entries))
 		perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
-#endif
 
 	if (!rec->opts.branch_stack)
 		perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 1eedead5f2f2..609c69995c51 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -85,7 +85,7 @@ perf-util-y += pmu-flex.o
 perf-util-y += pmu-bison.o
 perf-util-y += tool_pmu.o
 perf-util-y += svghelper.o
-perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
+perf-util-y += trace-event-info.o
 perf-util-y += trace-event-scripting.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-parse.o
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 59fbbba79697..a73c74b99a3b 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -212,7 +212,6 @@ static void __p_config_hw_cache_id(char *buf, size_t size, u64 value)
 	}
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
 {
 	char *str = tracepoint_id_to_name(value);
@@ -220,7 +219,6 @@ static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
 	print_id_hex(str);
 	free(str);
 }
-#endif
 
 static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type, u64 value)
 {
@@ -238,9 +236,7 @@ static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type
 	case PERF_TYPE_HW_CACHE:
 		return __p_config_hw_cache_id(buf, size, value);
 	case PERF_TYPE_TRACEPOINT:
-#ifdef HAVE_LIBTRACEEVENT
 		return __p_config_tracepoint_id(buf, size, value);
-#endif
 	case PERF_TYPE_RAW:
 	case PERF_TYPE_BREAKPOINT:
 	default:
-- 
2.47.0.199.ga7371fff76-goog


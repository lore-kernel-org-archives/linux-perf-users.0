Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39571AB50C
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Nov 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730566458; cv=none; b=YmMyE+RldHiGyPPW6PV250jSMf5SA5hgBlGRsdYE6kNkD1jYT+hSJW9eoyJlED6L0rJ6Z1el+JAgXdlWy3zwKOXZAw1JkLVThh3LZjRilpYlWqBN6RWUGWC/d0lOZOPN1494D1+kpGb3kfvXjQeIUYD+e31lHNZxneJEnWJXWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730566458; c=relaxed/simple;
	bh=fw5FTiisDk5cyhf8wcogBBpQyMSz0nXrYiG3JWj7IaI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AqHVOjpX7rvhhwZt3/ZwpzJqeexEQTLd85wXnSvAX9RYMXqylGDz6dnexaiWernYNjAuhsWeYCW7bm/PisXmqoPMTIb44+LAOeXMaEDKrZkgH8JlKugKa3GCRhzIatlwSszfoTPMQ0yYSiC+dsI7OaGrBxk/jn1Qe39ImmLgCiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1cwEUS2G; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1cwEUS2G"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2904d0cad0so5778006276.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2024 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730566456; x=1731171256; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCWMpv5edYfDnb5d8WWLsWf6rYHjMo4DKAX+NrFH0Vo=;
        b=1cwEUS2GEzHZKiW8qYgz1z9euCjKdWnqYfCvLlKIyysVXM3XNcxgRb52457XZgpavQ
         XvGBhC4cwHoBMwZbwukUhJnfTSzBvdOIxbHKjL/h+MRhbNkjmMtUmlnKxWSKavPmDpn4
         3pNNglaZey7JntHhpE1OTB+VoEMYnPRkITubP7uwqDOFIvrvGp+9zhunAPFZUYKUbpks
         D7DJ7/3Gn5J0hdi/RI7DRv7K5m9BFktlYHCzzVdbjGe6CKd2C4WUj/EVvVvwkgvSLEVc
         7ZynAWtALQJZ03lVf+USpNM62f72wvNCo0eG6Y/BKDJ2emkqE/2TJvGkALJRJNSteXga
         DjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730566456; x=1731171256;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCWMpv5edYfDnb5d8WWLsWf6rYHjMo4DKAX+NrFH0Vo=;
        b=PrxWbJ7koeiVU8D6tN47Eo675BAZ7u78+ND74yYtGOM/irkQ/mPLHnD0tXp1nRNNHv
         btFRs2IJH63VikZByZh3L99uZm4T3gePu8cv9x/8DIohPSpneq1LGtZ88kEWahcAP/UJ
         zCpmLTEh+KsS+7gnEby+0tm3p0xGjhwQrC0+03alwmOm+YRKwiXLv7fVcYFvDeA35SYs
         0k0YUrY+rG8ZqLhH/zgLUXzY1pIgFDm0zb18W5+KN0u9kVZNHcTG23qslp053W2/rqW5
         TtNJjD9rebrpEhjA4HmmoYFTx4gEUXdjHeX4pmDUJ5ZLbFJyhWG74q+B4Ks5KicPXiS7
         NnCg==
X-Forwarded-Encrypted: i=1; AJvYcCU8OmQTOHrQVn9zzOdPBzmljzWZUnMRUfkhMmijop0FVjkTy0AdlnkM5wwPYEwHJoXuMG+QQrCpSbEyaxSuFa8G@vger.kernel.org
X-Gm-Message-State: AOJu0YxNKHAfGJAhz4Lz+v7mkY/oCM2jxCAnjxiajMaV54dcpekrYyMk
	3ZZaTlzlPA1g5LPzw689xkjlbs5OvlSgXCJpbdpNxz4GuetUvoWjvv0SwwhSBuM2jElnarPqQtf
	uoZf8fw==
X-Google-Smtp-Source: AGHT+IEKC7dcHOrelEdoxz5nY0GcsHeDEIN7ZEVCnbp2eYlUfdgzM/utYNQ2dIQoUX2Y+C0PU6dj7B/bQ8X2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a25:838d:0:b0:e30:cac7:5b70 with SMTP id
 3f1490d57ef6-e3303408237mr5157276.11.1730566455922; Sat, 02 Nov 2024 09:54:15
 -0700 (PDT)
Date: Sat,  2 Nov 2024 09:53:57 -0700
In-Reply-To: <20241102165400.75785-1-irogers@google.com>
Message-Id: <20241102165400.75785-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102165400.75785-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 3/6] perf trace-event: Always build trace-event-info.c
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


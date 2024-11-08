Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BE21AA1DF
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091681; cv=none; b=uKGxJUiQUoTafPzjbBZzAnFqB/srevnxVnvCSaG1T5W2ryXkoq1JNEAqLntiYhCPYmYniAwqWXtW1KMgWx74KvQTg/jwAervGl8TjyL/x7dPOIqTewpMahDfQqpJQVq5Onxgf2P4O/ur9lPvAlLYqr/9Kl8v0AtZYbl+8whH3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091681; c=relaxed/simple;
	bh=zJbDeXbNdPoRBGyGBBECIqArwWiKJU3G1l8a5LilCS4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=beDuwySgVuZFRffZhkdTzlEpkM02xHCM+G7/eZ5AsUGsd8c59Gukrx5SfLl96/twYJgcXDZOkU125NkmniTrtZhD51o0VaPoTrfec2/9RB9NLLe9S+OGSwY4spLKZI/Kfh7T7+U8F36iGSsSGvmCHSs+RbVZ0iiRp9vTzpb1xqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dGfPNsS6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGfPNsS6"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2971589916so3997093276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 10:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731091679; x=1731696479; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2kVFB+40RZnsaL/T0qEJlgCASFyLZGTMmhekp/4F3Qw=;
        b=dGfPNsS6iGlkrTia9mmgyyMLsAsy4/FRG2TNA9O5bHdbtgtxNaM+nDG6iaa0mkpjM+
         40VlcQZurNI+nryHVj0s0ZRoq3SXJPt/6OGExkp681CZJ/YuhUesD+1Y982s1PVS1p/N
         IHnl7lKe8hWNHqFOuG8P7u4R2+2KEYBwYAUfu264xK30CAIAqSBA8qvMzLjVpQRi5Koy
         bq38/po9MRP4ntMvRfJ6EVWicIbo9EHC/ax6T1oWLuFh1rLJKqFN8SXc1GNpJlA00mkc
         UEEOgJWfVxLETWJ7SZ8aqVHI1JEifMarOUz8FxkgvbsnBBpqAMQOA/D8n1zSpq/NB3kq
         wiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091679; x=1731696479;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kVFB+40RZnsaL/T0qEJlgCASFyLZGTMmhekp/4F3Qw=;
        b=FIg/+rqVINwp+4vBKeBnuVRRUDkaa+ruN5QhKlmJTWxi89OeL2ow6xy95R30W5dSxZ
         +fy53EwO3FUbTYcSTamxBsXXlbVTB41BfxOnIecF/5eJLrayk2sATczPOKtQgOlF5pFC
         l3w+EQx6V9pU24WwTW36gWG2kIE0ncKbqhYIxenB7oK0BGwAwDd7hS0MgiRXo6nkd1Tv
         F4eBXcR8s/Z3CHs5gPrj/9TyQuDyIvRAoJimJzTuRU29ro9Pmyp1BtdV9+Qy3nkX8mr4
         0KKMqth7b+5ZqX1bmn709ENWBFBaZxnzeMcIiIXZMBzsTmQnSjxlIO2Ba15kN1LgJ8tT
         IXYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTrLq5k4P+4BZtvLwE5HwjHoFCUTMHdLu8l/OIjcEJvrtTKEKwiOt6deFrXKelYjWUX7JagdrwrK5i5Xde4UMG@vger.kernel.org
X-Gm-Message-State: AOJu0YxP5T4H1sfC78fCT4KkVCsPbWbbfzelnagu2Ow1Q0+vx6HfimZP
	N0Xxun683YlS8V/BwTjdTxrN4RIUxYqtKLNRZ8Or4huZOAmXgubKM40rZulpFaQnYtRRvgTCzkw
	X2+ke3g==
X-Google-Smtp-Source: AGHT+IFqdBwud7OOCiL30I7xSw+TFazRJGlyNedcf34zMGfEnAXXKZnLcvMzt3bK0UHlmTlKre0Sq7d7VUv7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:3357:0:b0:e2e:330b:faab with SMTP id
 3f1490d57ef6-e337f77f022mr3761276.0.1731091678809; Fri, 08 Nov 2024 10:47:58
 -0800 (PST)
Date: Fri,  8 Nov 2024 10:47:47 -0800
In-Reply-To: <20241108184751.359237-1-irogers@google.com>
Message-Id: <20241108184751.359237-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108184751.359237-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 2/6] perf trace-event: Constify print arguments
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

Capture that these functions don't mutate their input.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/trace-event-parse.c | 2 +-
 tools/perf/util/trace-event.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index d97830cdbd7e..9f218ba787d8 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -99,7 +99,7 @@ unsigned long long read_size(struct tep_event *event, void *ptr, int size)
 	return tep_read_number(event->tep, ptr, size);
 }
 
-void event_format__fprintf(struct tep_event *event,
+void event_format__fprintf(const struct tep_event *event,
 			   int cpu, void *data, int size, FILE *fp)
 {
 	struct tep_record record;
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 0e5133f1b910..4292977e1cbf 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -39,7 +39,7 @@ trace_event__tp_format(const char *sys, const char *name);
 
 struct tep_event *trace_event__tp_format_id(int id);
 
-void event_format__fprintf(struct tep_event *event,
+void event_format__fprintf(const struct tep_event *event,
 			   int cpu, void *data, int size, FILE *fp);
 
 int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned long size);
-- 
2.47.0.277.g8800431eea-goog


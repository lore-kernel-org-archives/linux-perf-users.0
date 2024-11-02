Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12550158A1F
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Nov 2024 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730532180; cv=none; b=M3Yf22EUvPgvt0ZRUDnbjMziujudSHa9yYzsyW0ETEBd+4VT4pAFDvoV6m9FnN5F+SzpJ0ecMPellq+3hRnQ0YJxW++wczigN5duKnKVhZlZ8kzx+lzTEm6IJ4piIJaKhcWMP6mDmmxSsIeksGbiwuhsR+9eToieVF2zU24OL60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730532180; c=relaxed/simple;
	bh=jqtfqcDozTYMQzjOGe7gtUqSxh4PDuu/Rn5JE1kCsYM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=t75tSc9JSF1bvnVtLNg11XTZOMHDlyd1MC0gBXtyHLGHV/ckNfYC9w7aVatdgdQFdh2L0Rla57XiUXYO/dT6i+ypmIogc7NCTtoD+KKzFKOyZyPnlKiqpkF6spb30+uMgfbgIycYzmqe/074WSJH0oF0Up0LgS1zyo+g8AbUnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UAHPCXOV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAHPCXOV"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso4837756276.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2024 00:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730532178; x=1731136978; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmeR/ooJwGRf7dfAO7pFQRGOg67G8nX2zbSdm6KkuuA=;
        b=UAHPCXOVQXv2u6VmhYmd3iNDa6dFJJlTgYtGmYg5laZ/470imMKuCMst7YvCKSyVBY
         TlKA1Ng61B40ZehgggGZhxCfvY3qsPJz8/Z/tKKx+FRg+qVlR41ejTgmHE8gY5/xUHo6
         9wSQtgCOM22ELHsE8FUAA/OYEyRfIFsQfYnyphkS5Uk4/LW/OP5anvFbpBjtpoD5etCQ
         cZedC9i9A1XgZlup1df4ilJSdB64bdYau+2pB0YqZYpxmGeyOkSqYDf9ax9tHcrtVYkb
         mFRRRN4061TSnOe2DzI2Rl2uQNmRk3ySxO1CWy+idRVNICwweN43MUr/sHSmHlwqWJNw
         1C6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730532178; x=1731136978;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmeR/ooJwGRf7dfAO7pFQRGOg67G8nX2zbSdm6KkuuA=;
        b=uQPibpwwXFiNWMMX9308KXpcroZzZjbXA6xDkWqpqHQ2F12CwXPkSEV/e/55eHazIl
         iazDBAwsizkSVJUc/oMfPbNiW1D3QW7pIjQKOilZC5E+9Rm8zguLUXnLiAE4TjoYCRiN
         uiljyRHlYRASA+nikE3UlR7UlNV1QHOmOsivS6lyg6R/XRHIih4nD42br//Z1x4WQDss
         /L4sbqNgtEs6ErURLOW77gogEnSjF6OocxRPtlETpjHo0I4rTSRK3agtFuOsfxg8nfFp
         Zkt8ZcHCD1WFzZTsjxhXUQQU3UFI7vd/pZvjjnNHn9qpyqpNS06mxHTS2cRFrnpEUDTs
         LYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3toFl+3HypGFsOqG9kd96HOSxAuf43tIWPP+/scMI6mlUmqSBQO7se4OkpZhFjIfiML/tkusHaTAmUvgx+ndV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjh6ySTm/KYEYyEw2AuEvsFyL8+vX3V8JoI02+d/2fysg13xNk
	/Wcj2ELc4qPlqzHwhP4xFflx0vnQiW3oa2Kzo9eHnJrPQCTdFoWQensa/1NIGRExYNWuFmfcS64
	FWjug/Q==
X-Google-Smtp-Source: AGHT+IGqNYDJGcJcBslQGiLIgr1hpmee2pkGHEX7lgSwjZdA4gYXA5a6NRHoGJ8pve8HiBofxVjagJwDuvaT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a25:26d1:0:b0:e2b:d0e9:130f with SMTP id
 3f1490d57ef6-e30cf2e9c2bmr9944276.0.1730532177579; Sat, 02 Nov 2024 00:22:57
 -0700 (PDT)
Date: Sat,  2 Nov 2024 00:22:44 -0700
In-Reply-To: <20241102072248.12836-1-irogers@google.com>
Message-Id: <20241102072248.12836-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102072248.12836-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 2/6] perf trace-event: Constify print arguments
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
 tools/perf/util/trace-event-parse.c | 4 ++--
 tools/perf/util/trace-event.h       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index f0332bd3a501..6f11ca5513e3 100644
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
@@ -116,7 +116,7 @@ void event_format__fprintf(struct tep_event *event,
 	trace_seq_destroy(&s);
 }
 
-void event_format__print(struct tep_event *event,
+void event_format__print(const struct tep_event *event,
 			 int cpu, void *data, int size)
 {
 	return event_format__fprintf(event, cpu, data, size, stdout);
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index bbf8b26bc8da..084068fb36a1 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -39,10 +39,10 @@ trace_event__tp_format(const char *sys, const char *name);
 
 struct tep_event *trace_event__tp_format_id(int id);
 
-void event_format__fprintf(struct tep_event *event,
+void event_format__fprintf(const struct tep_event *event,
 			   int cpu, void *data, int size, FILE *fp);
 
-void event_format__print(struct tep_event *event,
+void event_format__print(const struct tep_event *event,
 			 int cpu, void *data, int size);
 
 int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned long size);
-- 
2.47.0.199.ga7371fff76-goog


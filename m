Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A91AAE02
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Nov 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730566456; cv=none; b=mgLoqfe0W0TBgmMNN9toSXMoTSCD8pbsP8okmfkxAPCm126xCwh3A9W/MbhLzzvLpF7oo8e+m6HP4RitP9M4YLq4BukgZaYaNS3jWFMC7PPnG3y5+Dhdz1ZOZk7v6X33o/5QNU1xwCslz6o2zw+Ot1L7KYIfsX88Np/NmH6+DcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730566456; c=relaxed/simple;
	bh=jqtfqcDozTYMQzjOGe7gtUqSxh4PDuu/Rn5JE1kCsYM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mZCUQBbNLeCzq+2iKT6h2+3/lkGbeeJT8pnmdSVd4jyWTrnY5IQHnTDSCWiDYHTeLLN0VNBhlTcjWAREIluUijyE+9ov4sEAC/vzIqhqbUBvD6QvcNqnIcEklXXViF3Ot0xKV/d7AeAKz89W6g9plr3GxPDOqYMpsrN0FH08XwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QXglA3+L; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QXglA3+L"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e376aa4586so61300507b3.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2024 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730566454; x=1731171254; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmeR/ooJwGRf7dfAO7pFQRGOg67G8nX2zbSdm6KkuuA=;
        b=QXglA3+LQdT8Q5Kjr7m/cxW9naHt8SY2dhi4+CxBJSiTtxa7OIWppFNN+xI0QubqC4
         oLio/rDTRDaReCw/2ODvlvclJENjFvJHuHvC8xZpfzzTCsf5we5I2oNhG9W0KEUcO2DN
         dbFus9nFrZJKymzLvMzontD7vb/qKmQi4KAgmKPBYKkpv9+ow36JUCgMK7Y5PESfKfQT
         eAkbLUAjwvSF+F2zQ6VGmawptyMCi1eGB+Zx93Gk6UL67DSvAizWgavyMAOX0KZIxfa4
         vQyRySBKDYosFgoDjY+98IIYD8fFVDbEfqkGQCoGWgcOrh2t8s7ZtAfWkqUozI3j4JOK
         J0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730566454; x=1731171254;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmeR/ooJwGRf7dfAO7pFQRGOg67G8nX2zbSdm6KkuuA=;
        b=GhDR6zzbr2Dvpmw4JQOTMoBgUiof3eNraWrSO4AiRUsLcFHHVEGZ9pybu0hAPKk9tC
         QQf9g3deq3LLEGLXvUVQpsC6MaSovko5UumfJhDgTDnfL2ufQMzDUc+ZBwMoPCmP6Dov
         DNNGUBrkTUJpQX346shDl8+hIXGJnj0PLbipYAQBBxX4XAjU3sesi2vo4XD7kr1t7YsQ
         cH6UpqAXAbrPZ9rAsmkP1nx17KZc2Ho3dWuGpKjJhAtiuvZzPYfgAVRVm9CZJwfmKZCt
         9s6CSK8p18NLpktAFqmofREP+Z4KEHfK6/W2miWmD8CNOBhdyb2WwajaCYOqEzUnK7cz
         5m6A==
X-Forwarded-Encrypted: i=1; AJvYcCVThLC3x7t7QTWxYkM0SnRAhNPW7Fcj83bD2Sl8YQr/E5YTA1vybs42WJMw2YnJDUA8inQw6Bq2E5U0NK41HMlL@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWuhiM0pz8gN7m1RFR9GIYefKklB3jIEc5Uo3l/yjQ0qEnzJp
	rXcDnovw1qKGaZx1j2YXeIa77o63G1R8FaSup5UjLunSuCdq55KoDGZI2VMYW2JvuAti7uYi2rD
	7DLXISA==
X-Google-Smtp-Source: AGHT+IFq/57/M1dR4TI5sTZFRkJ+7pfYTpS18HTUCeIYozNVMDf4uGtf39Rs8KrRHBzucavqtbOBsbu5v5wx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a05:690c:45c5:b0:6e3:b93:3ae2 with SMTP id
 00721157ae682-6ea3b88e882mr2411427b3.1.1730566453754; Sat, 02 Nov 2024
 09:54:13 -0700 (PDT)
Date: Sat,  2 Nov 2024 09:53:56 -0700
In-Reply-To: <20241102165400.75785-1-irogers@google.com>
Message-Id: <20241102165400.75785-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102165400.75785-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 2/6] perf trace-event: Constify print arguments
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


Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6D2161EA
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842026; cv=none; b=B6A4KVNYAK/mQekQTSeUd3pTMJuUB+HD5S9ukrhQvqznH3Rgf3dMfPhbM/3EFPZ8ctQFmZ3S9IZNoo2sN5n34/HVU4ZY6++BbX8HWi35Aw4JJlB4Jp01dzoOwd1wZw3mQnJto9lZgJgJSSgfFs1jvejcZb4a6gN/WewdFYMxJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842026; c=relaxed/simple;
	bh=jqtfqcDozTYMQzjOGe7gtUqSxh4PDuu/Rn5JE1kCsYM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WdrG/gnNkwMHuRc3s5RIsmjLetJ7vJ07OI7iH3/qi70da0oMhJI+Ngemy+WSbu/MT1Q/Tr2idpAf8xbARiT/z9z01Lvr4wMSaa1h7ah8PmlE/NiNVlyvL85UfcTVg0/fle064096XxacD0QSHbhwca3S1LKGvGuSGKxwQ1AYmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4kx+TGc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4kx+TGc"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea86f1df79so69271197b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 13:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730842024; x=1731446824; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmeR/ooJwGRf7dfAO7pFQRGOg67G8nX2zbSdm6KkuuA=;
        b=A4kx+TGcsaI8q4DMua4oVZ1QbZYlqjaHViLDCiXntx07NShMSO6A80fyD6yBxgiqiu
         yA8vTuveODpme9alhCvMbyhkLrYShTDc0td9a6RTMCooDW73t4uPBJKOfi05YpQQrjAi
         ZCBI0kM9LLNWBLlRC4rOEgqDa0GM1jeUPftweeAW9ECjy3CizO1ZgPPMLZxwm/LfAMmO
         WQyy3a24zrx1MsfWaf1tAbz5H2u5zCTWtgxv7vAhjAmbtXmJOpzI24QYqBf5w13w/3sF
         ihJwwYMj30jgxNmgVZ8/M1ngXKoS/qmZrnch9imVl1VaJV4q+ggpHBR8ag5gehYk3C+0
         e9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842024; x=1731446824;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmeR/ooJwGRf7dfAO7pFQRGOg67G8nX2zbSdm6KkuuA=;
        b=F6E/EuzHPGKWTIMYiohIqirl6it5oHHVueK+LgkczoXDfCj2ab2TZGlvR7G6uRKA69
         isrNdg9ffyO/JjzGbNET9MJGpy8JTOLmWvpP21WPEJbZoZdpOQCeFcFoQdFOEIhiaHKA
         K0DOE4AEyhZsta4xK/b6FHJRliRkBXgQrGyVjp63dIouyJh71HvL2B6E22VXhkkpmXCD
         Lr1T9IIP+s9N0jRs/GBY7c9hZsWWDZMW0unr/xyBT6Mf7O0GTtpDaj7gu2MbA7AnpRJE
         k/O7q8LNd/inNXh9UlpR+or8FX9lT0ghMH4HyoaUOhH2u66/cTduEPf+WhMFrHYoseNM
         g2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuMlaHjDH7s20Treo48JMkilYV1cMLwR3Hu5un2FtCUshepyQfjcgXu7x7s3NHuNBR75sbi3r6bt6zB9yYi5aQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw20cCsepZEO8lhUhyfynUsvB0mrE5RaifoBDn5sGfns2ww7u4a
	pypKcoklcXbeqSUkMQt3UFm4CfEpo9R/K5aZAuEtWZ523+pFAj316XZbQ4Cqia610mJuLykK6/L
	1NojWrA==
X-Google-Smtp-Source: AGHT+IEROMSZbX3H3SqE2W1/i5uYPxQiYSylSWGjEsgYWi04FdojKOXP5FLW4BaITLNn/wZr0DKGH+cV4qpf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ff9e:ab12:75ac:c1a0])
 (user=irogers job=sendgmr) by 2002:a05:690c:23c8:b0:6e6:38:8567 with SMTP id
 00721157ae682-6e9d8b296demr2527807b3.8.1730842023763; Tue, 05 Nov 2024
 13:27:03 -0800 (PST)
Date: Tue,  5 Nov 2024 13:26:48 -0800
In-Reply-To: <20241105212652.401943-1-irogers@google.com>
Message-Id: <20241105212652.401943-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105212652.401943-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v3 2/6] perf trace-event: Constify print arguments
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


Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FD71EB9F1
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970472; cv=none; b=cpTXejLHvDclbpQg+zxjKDdzl9W7fxGYBOdRq2uGl7daxPutyYZTyvEbtY6Oj/ckMP3t9WWllCVVcx9Ei0Whk7hM+CsioHXrIJ0s+ykd8A5Zng7jgGOM75eHfaP9Hq4j/5ifRD4B/HogU7IFA8Izsu1exzrtFjhwAXIAbcQIYfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970472; c=relaxed/simple;
	bh=vA5wDZ8FL6MLUmxSvynTx1BhyBJedSIPLTdOMqvm9LU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jbIugOkLBrAoA95TWbDOtO4sgMSCT7nZ6KxJrt5H8P5X5833X7o9ZoCMWzc2VP3xgGF4VvcvyD0vbrAtkiXgXje157dilIoaJLUMSrKnYIz/5k1SUn2TVu5wmWbRFdRxGoZBWSefzAgIQ8giPn1zRD3AToAO/ypb+mT4Z1RMgh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Myh8Isev; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Myh8Isev"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e381f195051so533779276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 14:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731970470; x=1732575270; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55WiVKsndQFaxxZ4QGA42VCMnpZnpnS70BqjVyyPtNw=;
        b=Myh8IsevvdAU5pnEEY32Bi17LrAQApSh+W/j03qsmboTu2rVyd1f8RyuZFY2Hwz0+0
         tUVW5d8HIv2CsdRuXcnKdteiplgCmHnqxs/jl28dF23qen0gdhwvcDTGaAuJHVanaWwM
         JQnvVkJIoDF9dhSbiUXu0xX/p8JurNnt+GIDcWEvcMY06w+VIn9kGV5BsPTqGTNN5VgW
         o4mt9a1favgmtEI7bfiSwTLcLVjdyQAO5tpn4f0z18yx6zigow67hTGv8PHLL8p1h/2f
         /kvE69rsFNF3V7F0mne0HWkvvabN3YRouO35gwvYefUBw9WwxsU0oi1PI1ZnKCl7bjBS
         y+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970470; x=1732575270;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55WiVKsndQFaxxZ4QGA42VCMnpZnpnS70BqjVyyPtNw=;
        b=M9intjwLO+LPhPUMb6+lERiAm2snXGKTmsGObg+WNWMbHlp+P8Lf49aKwkEGzXJruL
         UuQEZ3LgIIjujfrAsyLXZdenKxrCEUF1Bi67ixEb5I5oKTsbNpM/FuA7ENELXQykfRQC
         CVmG/9o2/13uQjjRMQqgakROj7vDvnFtokaqQfTpQtGQsq23Mnm7DYoYF49+YAC/UBnE
         N9GhxjwG1EmRM5kCTKRlgoko0ycGdZf/q8vnZyz0INkwZgNC1XZaXYt1c9LFDuOQxF8q
         RDQ6UpWUe+Yo2c399zFP1b0G9rXcXD5JAGJJvj8qCEawt+gsz4Zyxtw0n/VsJsDNtu54
         Ed3A==
X-Forwarded-Encrypted: i=1; AJvYcCW3kAX3iIcqnT5rXOA9A8FBoogNv48rhiy3Nyf7XlW1LichdcqetN9QqQE083GnH3dL16c4dEhHcwmyJW5J+gLd@vger.kernel.org
X-Gm-Message-State: AOJu0YxqdoabgR7ooKNjJMDWO1fbay29YvtWUApw4U2ebOegw3m3QQ9g
	nqhQRmPYVjh5L+FI19jYsze3VQ6/C2tjvFPJ+7fI/x3Et0keSBYWmKGvtkLX9JpUlpQbtBcqaTy
	A2nah8Q==
X-Google-Smtp-Source: AGHT+IEnzfOOnKnsl2wElo/yWtr4ZvRaQdLFyQfunTe1jiNtXAdPQKfXDrXow9PDuQmLSZJD3ZO4Ga/aIc2+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a25:df87:0:b0:e38:7793:62b4 with SMTP id
 3f1490d57ef6-e38779367b8mr151863276.10.1731970470161; Mon, 18 Nov 2024
 14:54:30 -0800 (PST)
Date: Mon, 18 Nov 2024 14:53:41 -0800
In-Reply-To: <20241118225345.889810-1-irogers@google.com>
Message-Id: <20241118225345.889810-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118225345.889810-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v5 3/7] perf trace-event: Constify print arguments
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
index 41d53e1b43e7..9c015fc2bcfb 100644
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
index 79b939f947dd..2543bf969fdd 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -39,7 +39,7 @@ trace_event__tp_format(const char *sys, const char *name);
 
 struct tep_event *trace_event__tp_format_id(int id);
 
-void event_format__fprintf(struct tep_event *event,
+void event_format__fprintf(const struct tep_event *event,
 			   int cpu, void *data, int size, FILE *fp);
 
 int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned long size);
-- 
2.47.0.338.g60cca15819-goog


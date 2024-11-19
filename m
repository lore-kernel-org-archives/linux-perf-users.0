Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C297155C83
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979099; cv=none; b=YCStLPKpJVNX5HAhTn1df/qm8H6zY4552AZP+OGTxyAIQ0MP4qe4YkYjgijyL4bced3EcuPU/bCIDYpoJBJQjj+HcIfXWCFghephB/s3ZGipNz+Zvn3fZqyBCaPbG2KTINiSQR9pN65Ms2RqRpDFyKUQA76PVAXxf9Z8ZXvSFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979099; c=relaxed/simple;
	bh=xvU4oEkRZu7oYlW7Ww69Sq84Htql0bu+vZScAWVdL6I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GjIZEurX7Yl+dhrgZDLiAsGc0H4x2vicj+OmuQxMVy/Oo2CE75ineQXZP3WWY7wpp52oEmih5VFEpFzd/pthencbkCV2DxY/EqpYdgr0523/9GjaGjOq4rJicpPNvRzqcWrqRKAgEQhhDygaoA4hB0SmuQkQx3LsRIen3GKUw24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xy1RZK0D; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xy1RZK0D"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e384d715e96so3226032276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979096; x=1732583896; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5CKH6QHuu2NcbrgRcRCJGUOGGvnBJyqKU+TkUSirYM=;
        b=xy1RZK0DMnXTMVF8kJYFxp5qvEGK6B+vZ4/JH7ZArhauqd8jU9RgLhzjz0dj0P84aj
         R7mTH5Otb8qDQdvmJQF/+u78NWhb7OIm3RsBsjSB/lIVY0Msu4vZpQVXpQgTm3tkx/RZ
         C4zKVzP0spZFPcPTYD3LTBmA6Y+8XOrPMwSMLqy4sPSwtxW7O5+xli8iaQxHRCONsK4h
         SypGA766fTD1hyygENE+wSxnvVuaahIFUTSpjqWCok0rXW4KFhOoCi32QFNsYepQ68eJ
         bHo/T6NW0lHE13rm6FNbxYQc6RprysfIyiY0lSg9XoFbs96wq1NoxZmAEZEVQ1Sp44Dy
         hD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979096; x=1732583896;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5CKH6QHuu2NcbrgRcRCJGUOGGvnBJyqKU+TkUSirYM=;
        b=oGK5teaopXp9NGUybIkyrIgVU89nbrKywJ6j1cZU/3gWCPFvCrEgC2z1hXP2c4gbJ6
         30bhowYcQyJdlGjYTg+1ebUMn60b0kB/2pNvh809kknBjy78QwXTyaDTfzTgEyjaoDAn
         9FsFEHZIMzTg4BuSmot7ittA3FL+2idPhLriyyXU/NZUPN5lJNmdlmtH2gu8SPXTiH9m
         iFuQ1khoy4kkDfM0OPtyh7eng0n1vzcRYSvwT2iQ7GG6gt0nTVIhDfgYzayQBisFM6vd
         P5NjJ8Q8S7+ZTFeVpXUR31qBUcaVcg0csYAe5vRuuimDULGv6pBWscfvhsLpvMLwV3po
         aOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvSINoQpvqQPInb3s904CthqBOw2iiLEpgyqJidDHVK3/9yOjBB7LcOgJRyo7OOl1ghMxB+lBuskGPLbtfj6e8@vger.kernel.org
X-Gm-Message-State: AOJu0YxHvqFx+9phWeLQki9+AiVnhz82nFXBQB4k8Kps2jCAcDApst8Q
	VqXTmeDFG9Pm4WTeArAJRg1475wNW4suN0nnF7YkkRIATHNjbw51pCSEwSQQBzfSiJHqSJqJG7k
	nnWBxKg==
X-Google-Smtp-Source: AGHT+IHfTA/+jlwQTYlf7NK8NSpShGCqN6NFIWxAxS33V7PS6uUzm2/q1MYOcgMQJqFrx6yl4FJ4vqULXI3g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a25:b19d:0:b0:e30:d61e:b110 with SMTP id
 3f1490d57ef6-e382638437cmr197260276.5.1731979096311; Mon, 18 Nov 2024
 17:18:16 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:39 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 17/22] perf kwork: Make perf_kwork_add_work a callback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf_kwork_add_work is declared in builtin-kwork, whereas much kwork
code is in util. To avoid needing to stub perf_kwork_add_work in
python.c, add a callback to struct perf_kwork and initialize it in
builtin-kwork to perf_kwork_add_work - this is the only struct
perf_kwork. This removes the need for the stub in python.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kwork.c      |  3 ++-
 tools/perf/util/bpf_kwork.c     |  2 +-
 tools/perf/util/bpf_kwork_top.c |  2 +-
 tools/perf/util/kwork.h         |  6 ++++--
 tools/perf/util/python.c        | 12 ------------
 5 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 8234410cba4c..43239850256b 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1846,7 +1846,7 @@ static void process_skipped_events(struct perf_kwork *kwork,
 	}
 }
 
-struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork,
+static struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork,
 				       struct kwork_class *class,
 				       struct kwork_work *key)
 {
@@ -2344,6 +2344,7 @@ int cmd_kwork(int argc, const char **argv)
 		.all_runtime         = 0,
 		.all_count           = 0,
 		.nr_skipped_events   = { 0 },
+		.add_work            = perf_kwork_add_work,
 	};
 	static const char default_report_sort_order[] = "runtime, max, count";
 	static const char default_latency_sort_order[] = "avg, max, count";
diff --git a/tools/perf/util/bpf_kwork.c b/tools/perf/util/bpf_kwork.c
index 6c7126b7670d..5cff755c71fa 100644
--- a/tools/perf/util/bpf_kwork.c
+++ b/tools/perf/util/bpf_kwork.c
@@ -285,7 +285,7 @@ static int add_work(struct perf_kwork *kwork,
 	    (bpf_trace->get_work_name(key, &tmp.name)))
 		return -1;
 
-	work = perf_kwork_add_work(kwork, tmp.class, &tmp);
+	work = kwork->add_work(kwork, tmp.class, &tmp);
 	if (work == NULL)
 		return -1;
 
diff --git a/tools/perf/util/bpf_kwork_top.c b/tools/perf/util/bpf_kwork_top.c
index 7261cad43468..b6f187dd9136 100644
--- a/tools/perf/util/bpf_kwork_top.c
+++ b/tools/perf/util/bpf_kwork_top.c
@@ -255,7 +255,7 @@ static int add_work(struct perf_kwork *kwork, struct work_key *key,
 	bpf_trace = kwork_class_bpf_supported_list[type];
 	tmp.class = bpf_trace->class;
 
-	work = perf_kwork_add_work(kwork, tmp.class, &tmp);
+	work = kwork->add_work(kwork, tmp.class, &tmp);
 	if (!work)
 		return -1;
 
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index 76fe2a821bcf..29352ca1d497 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -251,12 +251,14 @@ struct perf_kwork {
 	 * perf kwork top data
 	 */
 	struct kwork_top_stat top_stat;
-};
 
-struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork,
+	/* Add work callback. */
+	struct kwork_work *(*add_work)(struct perf_kwork *kwork,
 				       struct kwork_class *class,
 				       struct kwork_work *key);
 
+};
+
 #ifdef HAVE_BPF_SKEL
 
 int perf_kwork__trace_prepare_bpf(struct perf_kwork *kwork);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 5e6db4b143a1..3e32a502a41c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/kwork.h"
 #include "util/sample.h"
 #include <internal/lib.h>
 
@@ -1297,14 +1296,3 @@ PyMODINIT_FUNC PyInit_perf(void)
 		PyErr_SetString(PyExc_ImportError, "perf: Init failed!");
 	return module;
 }
-
-
-/* The following are stubs to avoid dragging in builtin-* objects. */
-/* TODO: move the code out of the builtin-* file into util. */
-
-struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
-				       struct kwork_class *class __maybe_unused,
-				       struct kwork_work *key  __maybe_unused)
-{
-	return NULL;
-}
-- 
2.47.0.338.g60cca15819-goog


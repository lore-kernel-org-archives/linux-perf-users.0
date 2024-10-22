Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B301C8FB2
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618285; cv=none; b=Qh/P4selEI/mx8fdJhnLjwe58w8teVV/1WmXRjWQahh4UV7/efc5K/Q4XD4p71pJdKe/0Dt/3Gn7xJULjyZvG0vGJ+B/p8MHrbj8zsEmKzrP8cgCU/SrZbikrv44oPMh0DjEnIkgXhD3jSncsQx8dT3dAQc0l78nTDkurShhat0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618285; c=relaxed/simple;
	bh=lW07OjyjtiP7BSeHvWrJwzhwe6xJuxZ4Ci6QSD1wU8E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JZed3b7IKEEtMTgNtie8IGnXAg1UNhmS07+KWIRszBAmPLChXgHX6ggYvPC8xo5mbJw8QRM36AY1llbba+ElZs6RmosjaP43U7Iva9MwQ+OpJk1ntWcYSYiRBr3Wi18Mvp7MliDIMcNHAA36KxmtNGCsA3hF0484B8meFySrxs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gNiUk3xM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNiUk3xM"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so9515706276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618282; x=1730223082; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8Sn8jdbA+NjEGCeG6Gm1wYYNvd28v2iQntXlq3XUm8=;
        b=gNiUk3xMhmyGl/0MUuffKd9G0n4ZpHByYjGyedlmNCRYpxxVsp+BHusFqgYei3brhA
         +lxzkiOXfWClRrZ0oBFGbSb6HAkm01JIFVrM3IOqtEunVotlmnFFZv+rvrhzY4nDetWM
         mDsLI7g0a7A0jr/LNOFHez5cW4+3IJ8EqL8mp2d2sk9c1Vm7OuRPORx/8ZEGnBr1kWPe
         /cedoV6foI/HEVYBuavh+YWRXTjB4Fo7KjZGRO6P+7ZI/ZmL1V0soS2f+fzuljnE2p6A
         KgS15U0KWa2ySSgQ2dByBzxpB8adRm05qvdgahlyQL5NhMT2nJRXk2CPo/guvGN0d91R
         Jetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618282; x=1730223082;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8Sn8jdbA+NjEGCeG6Gm1wYYNvd28v2iQntXlq3XUm8=;
        b=K87rB0menrwtubCBsAL3M3BqRDXMGx/N5qj+VoYbZ9YrBOGiTZV5z5eXDUekK5/1+X
         XSfcK5ynTAVSY+HCYRWS6zw7fFk9IQx5uP+0HiQUv+/TUtmsrOKgpQuBqXzzG+hiXVuB
         buDJoVga/tiB42C2j0TmAj+iB5GfyeaN3lMLv3otfCHL5yxDWV5/KuP8hkWPYHRq8d5r
         4xyLNO8lLZB+Ooj5Ag6YfOU+azJj+ku3DYrhMp0s+NfLDCeuDkpZSshBzTvfA3dyd+rU
         bCMJ45/0/JioZUnR22Pek1fnjU/r0Xk9Ypsb9niA3dR6Gzkh/tBa+08X9ksEQnKmoQnw
         Z+cA==
X-Forwarded-Encrypted: i=1; AJvYcCX1PF3I2KckSy1tSQ+8GaOyoMPNiPMB5LH1LwtRHnG+hd4cXSkcKaGuFsip6Q682gqGEWUay6GRa96kF236LnqR@vger.kernel.org
X-Gm-Message-State: AOJu0YwDhfZslu21NsY0siXeNSpqy10ql347XIRwZsjyIdNeE2QDFvkv
	pozEVPIWXXlm777skldpMlOUimevhRjaYbLn6h9+gjprfdz/uD0Ez91pWmRSCwTaDQdqRhwo5hB
	9QCRlhA==
X-Google-Smtp-Source: AGHT+IH9/EN5Q/+v0NKTCOkVpwJedIXeesZVaCnYSA/yidNa2oMOS06NMBkkfS9kppFI17/jXw7kZB9ilOvg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a25:9c82:0:b0:e28:fe07:9cc1 with SMTP id
 3f1490d57ef6-e2bb11dfda8mr36214276.3.1729618282343; Tue, 22 Oct 2024 10:31:22
 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:12 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 14/16] perf kwork: Make perf_kwork_add_work a callback
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
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
index c1daf82c9b92..fabfcb74800b 100644
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
index c52da509ae58..6e2ff0076daa 100644
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
2.47.0.163.g1226f6d8fa-goog


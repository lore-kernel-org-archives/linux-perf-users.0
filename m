Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57525E479
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493651; cv=none; b=JCao6Y/GRiny4mNiStXt5nlg/xIcDX9oURnw//TLv5kSzAT4ROMT0KM58yK16u7/9ErYuoO8lVkt1pxa+vMapeSHo43DK1FjLf2FNkDyUzif6IW5ISKXGbHAjWq7TkYv+nGtuo8uMWoOIpbcXZaeDhBGV7+hivXyVpPFXS8At9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493651; c=relaxed/simple;
	bh=ITCVHe+DZaUEl150e02sgRTFkhGt7andQJs7OHtEtwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hQwPWjyePEAI9NCIw2YsmPOhWSjO9BnKBdOiJ07TJfNsLQ09EUHVFA4lBZfNdrPy1TFXy//N4JrwoMxNvTgSEFrN431lcIXY5hVRTMbjFu8JZozigWA80QBWb+JxQmDuHHxtX1fBaEYDGmArLnT1FRBgRaeqeJQAv8SpHljAEiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/ZWlLyR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/ZWlLyR"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23443196f00so7729615ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 21:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493649; x=1749098449; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aoixhGOv9OF6VrQYlQQ3Ye/bVfiGpPjQeS0mXQLBUMg=;
        b=D/ZWlLyRNBS2geVfXNOp5rSzPTJq0+nfs28tWawoE1YWiA7YZD7e9rmq392hJBd3Ns
         6vKzG3qafRW6DC7o7QP+4L4x3TX1Ll6iETAURSJx36/ls8UTVGhR0IJiasfLMXJ03UBS
         MwtCrj3+NQ1s6ZpVdcu7EGPgaNCOvmodoxURyQ/fA6Y6eDqNshorsm9RLJGYTZvaSwGo
         d0v9KPC9/x875SBr8GOFM8HNOBoKmvCW6IpoM0/QuZQAB7puId381fSwljdqOs0BIghN
         IKi2Zja0853x0h5Zm8a2RWYNzltiS4IenYBlIhxT256s0EnySRS4BuQeNUSAhF5aR06T
         K65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493649; x=1749098449;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoixhGOv9OF6VrQYlQQ3Ye/bVfiGpPjQeS0mXQLBUMg=;
        b=ZE7wi6kOO57ZCdgOd2GycirQkOlar7jTwqI3R7dveEwsrXsaECr3Wq2oXZx/6g9cBS
         RFPk8l/OVoNzUFwtXhio+hGFc2jKVvKmyp9CL9bcnS+fKV69UFCBp9nnZvJRhSzwKjSd
         stDiWw6D1oo3ShxJVyWHYscdteMMBKqxiAWNN8ReC9KzvDDJ41rXZs5I6Q9KkDpIJu1C
         hvnOEyp3yDyZ9NAMXI+LwX+LzuEse1IpqoybhppWlFDSp//kRXc2fdyQxPSp+x+rCHe8
         4e3TGj2aWtPuPue2n3YS0JsJ5shlzSgCPwtt8wR0XtxeQHXJ+uiRJGlLG9tI3DRMuOm1
         8Q9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWNZvyQKqUBBQl9Me4KGUinfRw8YxcPP0Vm5pmI3NQX9hvmu6wTaXKOX9nHh5IubR+Zz4trMZl4ndTA8P2+0cF@vger.kernel.org
X-Gm-Message-State: AOJu0YyNnEQoyeyYitwbmQXAtU4Szbe1fSsbcMTLUqOY7xErFABJ/mV0
	9xPwmrgMQFUzRGaqc4A55VX1hPFnGdCGOJq0lx8owLTIIUsgZOGD/xvo1eTaBuZYPxOxYf2bune
	fOj+/UQhAzQ==
X-Google-Smtp-Source: AGHT+IFezOAK1i5u0sK5P2v341T5yA5TGxCciTZYzCEh2vrLBwrPJa3lXiFC9JI3IMcHGhsvojvyrE8csfyX
X-Received: from plll21.prod.google.com ([2002:a17:902:d055:b0:234:949d:4a5c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2283:b0:234:9092:9dda
 with SMTP id d9443c01a7336-23490929e16mr191800245ad.24.1748493648817; Wed, 28
 May 2025 21:40:48 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:57 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-22-irogers@google.com>
Subject: [PATCH v4 21/24] perf env: Remove global perf_env
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The global perf_env was used for the host, but if a perf_env wasn't
easy to come by it was used in a lot of places where potentially
recorded and host data could be confused. Remove the global variable
as now the majority of accesses retrieve the perf_env for the host
from the session.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf.c           | 3 ---
 tools/perf/util/bpf-event.c | 2 +-
 tools/perf/util/env.c       | 2 --
 tools/perf/util/env.h       | 2 --
 tools/perf/util/evsel.c     | 2 +-
 tools/perf/util/session.c   | 3 ++-
 6 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index f0617cc41f5f..88c60ecf3395 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -346,12 +346,9 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		use_pager = 1;
 	commit_pager_choice();
 
-	perf_env__init(&perf_env);
-	perf_env__set_cmdline(&perf_env, argc, argv);
 	status = p->fn(argc, argv);
 	perf_config__exit();
 	exit_browser(status);
-	perf_env__exit(&perf_env);
 
 	if (status)
 		return status & 0xff;
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index c67e3ec938d0..f27890d5cfbb 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -184,7 +184,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 	 * for perf-record and perf-report use header.env;
 	 * otherwise, use global perf_env.
 	 */
-	env = session->data ? perf_session__env(session) : &perf_env;
+	env = perf_session__env(session);
 
 	arrays = 1UL << PERF_BPIL_JITED_KSYMS;
 	arrays |= 1UL << PERF_BPIL_JITED_FUNC_LENS;
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index b363c933e782..02cf7670a52b 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -17,8 +17,6 @@
 #include "strbuf.h"
 #include "trace/beauty/beauty.h"
 
-struct perf_env perf_env;
-
 #ifdef HAVE_LIBBPF_SUPPORT
 #include "bpf-event.h"
 #include "bpf-utils.h"
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d90e343cf1fa..9c6eaaf68c3e 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -150,8 +150,6 @@ enum perf_compress_type {
 struct bpf_prog_info_node;
 struct btf_node;
 
-extern struct perf_env perf_env;
-
 void perf_env__exit(struct perf_env *env);
 
 int perf_env__kernel_is_64_bit(struct perf_env *env);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 24c93ea5ba0a..988fe5c4137a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3849,7 +3849,7 @@ struct perf_env *evsel__env(struct evsel *evsel)
 {
 	struct perf_session *session = evsel__session(evsel);
 
-	return session ? perf_session__env(session) : &perf_env;
+	return session ? perf_session__env(session) : NULL;
 }
 
 static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 9b477cc73c85..0fa17414432f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -192,7 +192,8 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 				symbol_conf.kallsyms_name = perf_data__kallsyms_name(data);
 		}
 	} else  {
-		session->machines.host.env = host_env ?: &perf_env;
+		assert(host_env != NULL);
+		session->machines.host.env = host_env;
 	}
 	if (session->evlist)
 		session->evlist->session = session;
-- 
2.49.0.1204.g71687c7c1d-goog


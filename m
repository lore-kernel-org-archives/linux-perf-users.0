Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD720E011
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328150; cv=none; b=ESPY68xyQHsql5Todoy5MXZngoKXbP7Q86jF94hKEzZwB0Y4ybYpN+r17ehGQaNUtO3n5w4DYzdBJgU7WoKIcbA5iSB5BoX0wzurs1NNmq7uDj/Q5ZDSm3TkriVTKkVgiNmpXCiQWS7iyGqujJjsAPVqiz1fK4RToVeBXos4hRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328150; c=relaxed/simple;
	bh=g1pTIiVCfL0YGf+X/ae4Tzq0BX6X5BVc25oBmqj1Uck=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aQafj7uDPQmRGRrWw+b2nNFVtoPGEDVIbtYVDMZFyr10fIudhtiuKCwyIvHzbncdujXmqjgGlZrgAylT5e4z5v7AjPwiy34kk3avWZnOmx5BNZik9Dv7YQbreQ2g3/uoIgVyUEwxJSTAa9kPTuapC8mK+EuTTB71I/rPugoz14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VeBmrI++; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VeBmrI++"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-740774348f6so2585472b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 May 2025 23:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748328148; x=1748932948; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qa+bZ6NfDiwN6emHRNVhAg+nUxfKRoBgxQCLCaEZspk=;
        b=VeBmrI++xktFGYullQdyBFyxZwOhDU+YoUGEDAJoA28CLjhG47p8oG2CNg+jtCyYb+
         AGBHFVKxgnT5VYACCE2mKqokpkiHreqCgSz61B2iiacd9eGIqtYBoGc+r6yrIFWrRjXH
         EslH6T2nUnbpG84TWcdOuNkNMx358PuDtwHI1Fw2BCAPALdfjXOWnf6T8Cgb4SSFT9sk
         7ejmgYMry8n3aQtla3tHnfvNsf410zfwjcR0Lz3hsDY+hzcV2ZxOSwom5sX4PYp3wcDH
         fpNJlSIxbI/M7q+yLXiI7jTy5nC/URCdGghwBTiKkw8yVimzEvyYuJGGnTUMfX8uvz9G
         WZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748328148; x=1748932948;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qa+bZ6NfDiwN6emHRNVhAg+nUxfKRoBgxQCLCaEZspk=;
        b=jaZYFn+KzJrZb0Y0LqCrCqTKqAASI13IGkARxDmYgkZelOsA5NWat37ybo2oGO/hJL
         JV1kYMnFH8JoR1mUv+BYsMShQHhDcrs+jVPR9oo0bGYHpPfY8uNSagU6HAcBba35Kk8M
         xAZtYOm3MIT1Wo+euH7o5iPh2VilgGmZCcc3ICCa0CIThaGoGBw18zHr482b0vQtATFI
         bsMqm5up1l1je4lo2GmRChG28lv4erxcZwOLSAdxeS0Qcu9vjTUjBfQO3QvNGAXFWEyA
         Ivwm6OXpBonGQPtXchAKWLP16LUF9opDwtcNj5suWUel7jnaxa9VfWuBz7yvGYTQnkKW
         YzTg==
X-Forwarded-Encrypted: i=1; AJvYcCVr9o9lfT3bRetZLaTvNJssWWUJcbY1+34lspIcwxpSGX5tRBsUjcTwbCPVitB3Ej9GHx2+cMc7GOQH2L7NU7gd@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3lhPEp5iqStS4Ty6yk4KHvH1EbB7k1eVrXf8334Swa1A666l
	UZ7fNvUCg2jwOtNC/E0pHdX+LRHB0mO9kDsA64ibsfFe85AoVu02qPZypOZ42uoLQgH5Ss66Ckt
	BtZqlpfrKTw==
X-Google-Smtp-Source: AGHT+IFaY7Epe7TFUjEZoxVGrbJT8LG2DopMwMAi0GAGc08duoLIMdGL5EAMIRWUbJCsETCGf/3a/aibp3BX
X-Received: from pfjd1.prod.google.com ([2002:a05:6a00:2441:b0:730:743a:f2b0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ace:b0:740:6f69:8d94
 with SMTP id d2e1a72fcca58-745fdac936dmr18806567b3a.0.1748328147867; Mon, 26
 May 2025 23:42:27 -0700 (PDT)
Date: Mon, 26 May 2025 23:41:53 -0700
In-Reply-To: <20250527064153.149939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527064153.149939-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250527064153.149939-12-irogers@google.com>
Subject: [PATCH v1 11/11] perf env: Remove global perf_env
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
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
 tools/perf/util/session.c   | 2 +-
 6 files changed, 3 insertions(+), 10 deletions(-)

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
index 9b477cc73c85..94564b0f2b49 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -192,7 +192,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 				symbol_conf.kallsyms_name = perf_data__kallsyms_name(data);
 		}
 	} else  {
-		session->machines.host.env = host_env ?: &perf_env;
+		session->machines.host.env = host_env;
 	}
 	if (session->evlist)
 		session->evlist->session = session;
-- 
2.49.0.1151.ga128411c76-goog


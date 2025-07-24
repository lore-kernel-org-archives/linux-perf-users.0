Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F892ECD3E
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374815; cv=none; b=ufUpTc6bnDK7cEdo756RSQ0YDuTLAGDDtD+dIP+vUJMporGuAcBU6pUi1T3X6bNe2Wv5pNrcTNJ+j7Bdn3779tDcl91JwmIn4OSiZhhBXLKTkaLk4QvQ1t7zJH+to7tTBAUJwLTfyCcprnG0qcDRvi1uER0l8zmbNvX+4WO6pyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374815; c=relaxed/simple;
	bh=P8WhQ3O+yjKiV4VpOj5b0RW/o37hKGc8Nx443C7ljNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eX97nLLjKNjMt2Xm42N6jF8wJtKLDGMhN4mTpw9OsGz3wigyJFJCtgA0XqbLh7x+ObXD4qpBaC4ozBao8KbAV8S0oOOPAahiR9vnsQew24OCNw4hhSVmoJ4+nS374hogHgikPIh+prIo+guPWy3OCUGWn8nS7O2nL01w9V6pS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdvw0fi9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdvw0fi9"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e8d90697a77so1656788276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 09:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374813; x=1753979613; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qZk4Btue5jwbOWFWxrzEldf12I1UnrvpVVyWUncOwg=;
        b=gdvw0fi9PlTA9PRT+DTKjyr24jasR0/rExH2FVTt4sdO6jBTwWrrInoEMTuuAj7F+y
         RaVNF0KcGCbXHEct/iBJR6rbAMwHnLHt7pv9unnm34ag50eNfowyXY1mMzEnaSFNjHJN
         PFfYsxhgop+LY4MXWplpxEzlX0j5JHk1Qjcqk3AyCCcrd37N7ZZFGXZCd7kveRvU1aRa
         g1jXeQJgY06uuw3sYYT+PGHkIO988YAtmU/p+olFiknw5ZJLzBK8BL0zRPZjZmtGz/er
         4zYFIrHQ2/FpS1gFYe0BusphD6mlqx3AXMsqLBzR6Uael9f6+viCRxeKzwjXxPSogbZF
         Dijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374813; x=1753979613;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qZk4Btue5jwbOWFWxrzEldf12I1UnrvpVVyWUncOwg=;
        b=sQ9pLx+E4Cv841nBe/QEEj4JqgVIciXFm0biTmlgf7zd6ZgsEo0w41xsH+zbZJm5ke
         npFtRNGY/9l+y9L8GK/CtKGK7QwDgxab/xHTYgrmvADIdoH01Ycy3dU8kOOn923KiiYl
         XsMbAlnl+mAbjoKK1xOGh/j5XrLnQbH4wmxH6gxZdYw1Dc2XYxFOUAjKD2RtDZBWAezG
         eiDjKz4buJJy32WZKZp9xOZ6cefW4TrdTT1nOLHDNiD1t6YnNo7f5G41g5SP+f150lSb
         gIbQRxQw4QCNqyIGhMAwPrhQAaJnCxKg/4wuG2bAQg0GcvIVpHmAiv8CbUCHzoO5nzqr
         HyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuSzjAejlXEExun6yKbrF0sE7uKT6YaRIHzb44Wvj6gwdUe/iWb1tkFdf8kVHMiEaMPvUz+EeCkzRPtPM62Xjv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw17ctDGICra65MuGCWmIsE0Zt+YzEqFERWbUkthTQwYSul+1bE
	S48g27atwGE2UhbH3Po3ZjKDfeLdOLG7YURBTKMj0+bMwLc9fPqZ5NZPhXdvVr2P68kn5FQvMBI
	+QxjHKONGjQ==
X-Google-Smtp-Source: AGHT+IEOt27lqK3sp4i1efGbvgf9wXr51wugMgagIhfqxoYnxdWIBiRk+bLSIT092Fv9Vx+LotI4jjMMtsKp
X-Received: from ybo28.prod.google.com ([2002:a05:6902:541c:b0:e8d:debf:6293])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a25:bf85:0:b0:e8d:8e06:b567
 with SMTP id 3f1490d57ef6-e8dc5ab82eemr6898300276.40.1753374813007; Thu, 24
 Jul 2025 09:33:33 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:47 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-8-irogers@google.com>
Subject: [PATCH v6 07/22] perf jitdump: Directly mark the jitdump DSO
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
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Matt Fleming <matt@readmodwrite.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The DSO being generated was being accessed through a thread's maps,
this is unnecessary as the dso can just be directly found. This avoids
problems with passing a NULL evsel which may be inspected to determine
properties of a callchain when using the buildid DSO marking code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/jitdump.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 624964f01b5f..b062b1f234b6 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -14,9 +14,9 @@
 #include <sys/mman.h>
 #include <linux/stringify.h>
 
-#include "build-id.h"
 #include "event.h"
 #include "debug.h"
+#include "dso.h"
 #include "evlist.h"
 #include "namespaces.h"
 #include "symbol.h"
@@ -531,9 +531,22 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 	/*
 	 * mark dso as use to generate buildid in the header
 	 */
-	if (!ret)
-		build_id__mark_dso_hit(tool, event, &sample, NULL, jd->machine);
-
+	if (!ret) {
+		struct dso_id dso_id = {
+			{
+				.maj = event->mmap2.maj,
+				.min = event->mmap2.min,
+				.ino = event->mmap2.ino,
+				.ino_generation = event->mmap2.ino_generation,
+			},
+			.mmap2_valid = true,
+			.mmap2_ino_generation_valid = true,
+		};
+		struct dso *dso = machine__findnew_dso_id(jd->machine, filename, &dso_id);
+
+		if (dso)
+			dso__set_hit(dso);
+	}
 out:
 	perf_sample__exit(&sample);
 	free(event);
-- 
2.50.0.727.gbf7dc18ff4-goog


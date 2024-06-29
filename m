Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6527E0E8
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636890; cv=none; b=LPBlesuuU7fUIw4tLXLMRJEMT3uFBPpSTj5hIqh+u6dnm86mv0hIJgrw1UzvrxA+rqcnm1GFxAPgY5rOocmhEB0b/VOVTjCou1R9bcDDwcIgfsziGIOTbk+whvgGzB2+kNzU4AkFYdbKb0efPO0uvynIlKv0nXe3BGSFXOeSM7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636890; c=relaxed/simple;
	bh=dOQwYv3BZA6mYJCibVSPV46DzsPrealaMqGBbxPyb4I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Yq/bYHcB93MsaA1hQWhlMiYLn1wLwi6argAaoM7IoJlqumKe3i2AYFYPn3oMxr+2CsG9F5ENeLGlHDfIuN+BhL9KJ1r8fWd8KqLjCHmpy1jEveZOH8ltEmaNAN7bqRcPE7z7qGA9Skl8OGwQ2D141Q+n3HQrDyGoeokLmW/qeb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O11FIlvK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O11FIlvK"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dff1bcbc104so1978456276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636888; x=1720241688; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FW0UxSAdQlawsPFFt7Tz92UReMCnYyyYMlomigdWz2g=;
        b=O11FIlvKyuHDJeOgM8hpYwwGgKftxCQ2RKxUtec1EKQUBuOxPLVsif4+zHHChebclk
         ipk87LKRn8HPA091AOOYKO1L3OPbdQyFX1EhgEwggzeinhTY0b3t5Gl6cmywGySDtsCG
         QzL2AT9PnrkvbyyqBiycrl1PmRD02XlDdD/6sLfmhrEFNaafdIAnj24wOqC5msHQlwS3
         f3Oj7/Zr7F0Al7hhm7YSWP0COqu0TQVU9WeX4JyMYFGl9NN2J9RvBialFukreDcbcviZ
         Zskh26VU8JLMTbrSzKt/Di8vcyZ7NhgMy2tz+eIc4H7G3zEpAnTJiqVbTjD7bPnhPbci
         ckMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636888; x=1720241688;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW0UxSAdQlawsPFFt7Tz92UReMCnYyyYMlomigdWz2g=;
        b=Xk6q66eq6nv+XnSGnuFFqGlfRGVSCFLxnDZ0bVFpwCtVDdKLEyIhaC41F8t4IvWLnU
         n+4zwBeFNhta4QERgIyGmStF46oJvBB8wgzfz7SWMUpauC4uvLpVxLa7N82HQTh/LAqd
         c9I1oZF6fPu6naQA3Y23wBVeJ8zl0ZR0X/XDD8EUpTqHOmLjp0QTx4/t9Mf8uKmf2wdg
         RWWe8t75i7WRxPt5idLtbN/1TDddf+cQsU+1D4rOJOD+IG9ROiu66xgVuI+tRyfMOHq9
         FmsXJCPuGtz0yOyXrSGBtsnldtw+vOtri1Jk2GllmSNVgDcHDn6J1eQp1HDuqlzGhbJA
         FyBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXywFSqleLpqhk9Ua3n2SSnCnbSTrPOgxvn2EgbL6Gn0pKszaw3eq4GpDoNLNn11wc0F7SkiGttj0SZa9+K3OTTnE5jqOZ+MVnpvsHQp4oX6Q==
X-Gm-Message-State: AOJu0YwbpBtACN1hFN7Rwnx5z+TYu5yW9TOYcLqNppO7P66DMiAD4w3X
	Vwv/POt/3guieTFLgIj+fVJSglFGc4E5v9fZ8DkAdhTeqaF4a73l7yTT3B0HfWvPM34gLG9mFi1
	Ik250AA==
X-Google-Smtp-Source: AGHT+IEWALptJNVip01y1rVwK0rhc28W4Rx/uGav2zwXL5e2P7GlQvYhrejiAYPPfwiLQM6W3tkvBTbmc7YC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:1241:b0:e02:b48a:cb78 with SMTP
 id 3f1490d57ef6-e036ec5a9fcmr390276.12.1719636888387; Fri, 28 Jun 2024
 21:54:48 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:40 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 18/28] perf annotate: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 42 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index c0685d2c8de1..598ab854b9f3 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -686,28 +686,7 @@ static const char * const annotate_usage[] = {
 
 int cmd_annotate(int argc, const char **argv)
 {
-	struct perf_annotate annotate = {
-		.tool = {
-			.sample	= process_sample_event,
-			.mmap	= perf_event__process_mmap,
-			.mmap2	= perf_event__process_mmap2,
-			.comm	= perf_event__process_comm,
-			.exit	= perf_event__process_exit,
-			.fork	= perf_event__process_fork,
-			.namespaces = perf_event__process_namespaces,
-			.attr	= perf_event__process_attr,
-			.build_id = perf_event__process_build_id,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data   = perf_event__process_tracing_data,
-#endif
-			.id_index	= perf_event__process_id_index,
-			.auxtrace_info	= perf_event__process_auxtrace_info,
-			.auxtrace	= perf_event__process_auxtrace,
-			.feature	= process_feature_event,
-			.ordered_events = true,
-			.ordering_requires_timestamps = true,
-		},
-	};
+	struct perf_annotate annotate = {};
 	struct perf_data data = {
 		.mode  = PERF_DATA_MODE_READ,
 	};
@@ -864,6 +843,25 @@ int cmd_annotate(int argc, const char **argv)
 
 	data.path = input_name;
 
+	perf_tool__init(&annotate.tool, /*ordered_events=*/true);
+	annotate.tool.sample	= process_sample_event;
+	annotate.tool.mmap	= perf_event__process_mmap;
+	annotate.tool.mmap2	= perf_event__process_mmap2;
+	annotate.tool.comm	= perf_event__process_comm;
+	annotate.tool.exit	= perf_event__process_exit;
+	annotate.tool.fork	= perf_event__process_fork;
+	annotate.tool.namespaces = perf_event__process_namespaces;
+	annotate.tool.attr	= perf_event__process_attr;
+	annotate.tool.build_id = perf_event__process_build_id;
+#ifdef HAVE_LIBTRACEEVENT
+	annotate.tool.tracing_data   = perf_event__process_tracing_data;
+#endif
+	annotate.tool.id_index	= perf_event__process_id_index;
+	annotate.tool.auxtrace_info	= perf_event__process_auxtrace_info;
+	annotate.tool.auxtrace	= perf_event__process_auxtrace;
+	annotate.tool.feature	= process_feature_event;
+	annotate.tool.ordering_requires_timestamps = true;
+
 	annotate.session = perf_session__new(&data, &annotate.tool);
 	if (IS_ERR(annotate.session))
 		return PTR_ERR(annotate.session);
-- 
2.45.2.803.g4e1b14247a-goog


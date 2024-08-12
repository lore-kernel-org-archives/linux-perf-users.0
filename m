Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D919B3C8
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495686; cv=none; b=E1mu9UVF9kQdpwlpice6ElLF0KFVbbkvNVhaCYXbg6uW2zVmxf7TFyHF0TCeupLmyi2KK+4oYCv3Yj6Gr51Yo6xDG3dFkl4JcS6qWPKMxTzcdGlqi44PThwfTQHaSo6C2SA6ooo5HSqMsAW+YHlmDDlFlt9ip+f9QI9dioJw8V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495686; c=relaxed/simple;
	bh=b54MC+ntQ/UsxIu0AteN/AwjjxsXrg4DU7gP4POno/c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eIOEtKYYPuAjNnrUoW7SoYkY3mFIBWCFO0cS3mi+tPOZr6SAbuQZ8Akh0BC1eIW/FLOrJuowqZDXGZMqhUOfC/ipjeSJudPBk/f4rNIF0nrCcORuOiCYfcUNkq14mWzSzezEfoI7aMxvu1n4dczsOIiIKaGB2zlz5HLqFfAssBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aaTbbxWD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aaTbbxWD"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0353b731b8so8092696276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495684; x=1724100484; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4IuJMX0YASP6mDRB5sblKvDCNi7GxHX4wO+9+ISAHw=;
        b=aaTbbxWDNUPwfmRc3+K3S0GPFXBjf/FO2F9OnRlalN5CVfpugAsQbTDEg+0A09jDBv
         8ZBkPH9ZeWEPZPSv+Fy0AVz66tCrQeUXglLJwvDos27Y7e31zSulMFvL0azz35PCCbxL
         VdUKiToujYqLelDFJzzxAeGwT4wNY5AR7+0yoIrRtcanM0w9dhMxi2T/b97ZUuTAmA5q
         8NRZ8QQuCq/zea21Xnt+hE/lu5GLs3VEKY7Pw2+VEmwlCvRPOaLYEwVZNB1OUt/J7o7w
         7sFoNnQcMZO/EWn8B6qM2LJE+/aowrZOGbQ6tja12WfgmKYIv+Gchw8zAgJtVmeHTmbT
         O/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495684; x=1724100484;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4IuJMX0YASP6mDRB5sblKvDCNi7GxHX4wO+9+ISAHw=;
        b=TsIinydxCaA2HwxHm6Ni7VJr8+en9bXUwp/KUAGc8fHNhVQBQ9rL3RrPA0UcaXEXWy
         n/WQZOe7qDfsPOhQdXF03Vl5PVgJojMGFLOq8wkHT+hNwLp3iGLcMH06wFRFdBnk/7DZ
         WerClC15oVs3ih//+QirvCykmWmY3w2S6U0+OKR6eQEgGuWqmjYTmMBbDqRu6hi72tQX
         CvOeqYJ2Uuj0v/UYHGKBNlEEEGEMcWSnjncJOQrzdiP9I6TUepZx+NJnElNC+x+9/Usx
         stc7W708Mljf1c6PCwSz2XuohOcTAJRFAX15Brgmzs1ENv+25kV0IbXxSk5uGWOhv63R
         vgLw==
X-Forwarded-Encrypted: i=1; AJvYcCVs3McygqGcDeM5hIHeRuwVUApBnyyetU0D1r2IDPO4AYW7aqrVu6V1D1rjeLQDf+GGFVWGT8Oi6DOiB1CvVT6JjEzY6tclsf/JjmmC04JWMQ==
X-Gm-Message-State: AOJu0YxbaxQTCyHkcw4ytyf93588VrJSz6gqGC11uo3wTZs1kJHTijMq
	DKSWHH1pDsauGAslVqiYCpbjguwkbIMLaZmXC0PZ0W8lm3+uiQ+hfhvAWY4RfY+6BzKzSEe6RZY
	bk2t8jw==
X-Google-Smtp-Source: AGHT+IENcikM/2xpbAI0+iXGHI86bo1OAG2rCZ1wxfc4b5c0Ca8mqN3x5IE3uLmAUHqZLRaOz95pxfCbyXVD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:cec7:0:b0:e11:44fb:af26 with SMTP id
 3f1490d57ef6-e1144fbbcb1mr64276.2.1723495683936; Mon, 12 Aug 2024 13:48:03
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:09 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 17/27] perf annotate: Use perf_tool__init
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
index cc65e6f8f4da..d6f6ba5a569d 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -696,28 +696,7 @@ static const char * const annotate_usage[] = {
 
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
@@ -876,6 +855,25 @@ int cmd_annotate(int argc, const char **argv)
 
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
2.46.0.76.ge559c4bf1a-goog


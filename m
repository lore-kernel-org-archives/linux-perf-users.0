Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2F212FBC
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876063; cv=none; b=t2aJ6cklbRlI9RSfdGkbcPA/jrbSWPllWwErRXlVCl6GAHCyZb6EfShAC/RI5aJKLcDu4wYMbMzDoGQ283fp2avkm7fd13ddxtLEWO9OWW0zJAGSe5pCymFr+UAxYQM/ak2OQuroe9kYDbq4RuCKYnN8CNL7MFMl6lrXINLXNgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876063; c=relaxed/simple;
	bh=HTKDxSb83GljAcKwgB1tWyhvT8jeauFTb7sWIZG+NHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pEmU7LbfluIF2uI3+MCa4z2keyoD1aG2O2oRCT4BHWxQ+m0UC4X2EmGkpAGcll9+oF3LE/imvEjwHW70h/ID3Wz4riB9w39l7QvHPubfndyby3CScJjFl/J7Kt93RahgBhGxYyEZP9PhfoYE84a0g+RdWoG7AHuUvILGwPQ52cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yu00/8Wk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yu00/8Wk"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-309f9502cafso5322668a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 14:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745876061; x=1746480861; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NruyO827J8Aq2CmIQSrBjSup56z+26r+Jphuwb//5zM=;
        b=yu00/8WkEO4Vj92UIDPo6XmZ0pONQmBSPCMLvcdk8p3vEJi6u+UXQs35GduDSHpRh1
         jfHRmQufy8QjC3bUkVxtFU+KeUklbn7TA1kOinbMLT+PWu3B/6D2pTI5PwQhOOilNIhD
         f4MPZYh6IZjem0eJmVKHkieGeUy6+n2qGNAaCu2I48O38YUb+CQaYiAyJyZ+zU9l4LoC
         i0WDfYVqKUlJKVLbud3YuaPcEfag3wppGB4s8IcB6wo1efRLGVlp6KfPQquZMPZ4bVy+
         sI+N0wZmiK1R2PNWO+1/KUiS1VfA6n3xa3m3RSa4MO1OZltOm0HSygYUEMszkwQdRtWH
         McRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745876061; x=1746480861;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NruyO827J8Aq2CmIQSrBjSup56z+26r+Jphuwb//5zM=;
        b=ZQguluc3F2bgyf23P2xD6ms0dJovohxryv4ZIEGXWee28cJDtgvgeWDpLJ8D8AdqrZ
         9ksTTlDDQspFmf1VfH0TqK3SqJgkpdS6jY53yXGUw24/QTs9Y/xofVY4sSXVOUqiZgHc
         uojPuAB00HBCCDLsDQAtu00bGpon0XMRVYNWwQ+Wr2jxA++ROH7rMby8UftzZXUOXqsl
         cOhfmNFt8knUyuAwx1iaM9ZcoxuNiMJHhOj/CX1mZ0eoTFluWyUrqI5Or0f/A44PS+4k
         JriMcM7Yi/11EPqnpCzuVXcVDhW5Q071umXx3oLKqST9SNf0xub1gXHmI9+Va2MPK8nV
         EZJw==
X-Forwarded-Encrypted: i=1; AJvYcCUT1+e5Ra02Iy5X/NA9X1AfBwinncN9/CE+lcpLyKgL4antVqEDwGutFnlaz6iQeFCjmbwHSphBAlGEj8Tb9Erw@vger.kernel.org
X-Gm-Message-State: AOJu0YymAM7bozfC3PyH7Wxs6hZMruhA35epfdco3GB2mle3LElkL9DY
	JvASk24jGX3uIgARN1X4Ym8iTQXQtagnHWNPfzY6hawCbtO4bVpksl+jZUqj2WCcCJWo5Tf+wJP
	TFpJbjQ==
X-Google-Smtp-Source: AGHT+IFr1DUcLf4fJFO8qlUiM8teqy5JWXpOKomw5UGogwqkVc1K1AS6v5CJ/1Z+7wZHpieRsK/3Zo3kT+oD
X-Received: from pjm7.prod.google.com ([2002:a17:90b:2fc7:b0:2fa:a101:743])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5185:b0:2ff:6fc3:79c3
 with SMTP id 98e67ed59e1d1-30a21552a93mr2262278a91.9.1745876061588; Mon, 28
 Apr 2025 14:34:21 -0700 (PDT)
Date: Mon, 28 Apr 2025 14:34:04 -0700
In-Reply-To: <20250428213409.1417584-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250428213409.1417584-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250428213409.1417584-6-irogers@google.com>
Subject: [PATCH v3 5/9] perf build-id: Mark DSO in sample callchains
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, James Clark <james.clark@linaro.org>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously only the sample IP's map DSO would be marked hit for the
purposes of populating the build ID cache. Walk the call chain to mark
all IPs and DSOs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index aa35dceace90..3386fa8e1e7e 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -42,10 +42,20 @@
 
 static bool no_buildid_cache;
 
+static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data __maybe_unused)
+{
+	struct map *map = node->ms.map;
+
+	if (map)
+		dso__set_hit(map__dso(map));
+
+	return 0;
+}
+
 int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 			   union perf_event *event,
 			   struct perf_sample *sample,
-			   struct evsel *evsel __maybe_unused,
+			   struct evsel *evsel,
 			   struct machine *machine)
 {
 	struct addr_location al;
@@ -63,6 +73,11 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 		dso__set_hit(map__dso(al.map));
 
 	addr_location__exit(&al);
+
+	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
+					/*symbols=*/false, mark_dso_hit_callback, /*data=*/NULL);
+
+
 	thread__put(thread);
 	return 0;
 }
-- 
2.49.0.901.g37484f566f-goog


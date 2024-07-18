Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EC976C76
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264485; cv=none; b=HqnDAd9IwHkWxcKuV7OKuCmbJGSl8WDQPmOGwU1ShppWZ185I11tsr69qIffGbg/GPM4DSmvkUneS/fBuKdmh6iWpffrUeDD0aFMn/gF1Uw952+nLaTRcn3HSLY9P4ADtziTqpzp+CYzTIoE1Gm43GIdcCbDc659UHUpIn1oC2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264485; c=relaxed/simple;
	bh=36EenPax6vCtCaEhr/ZKn10gCViJORPj3sVD/7Dl8M4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oU4SbgB5mdd8A6nRi6qxfbVj8RBJ28NIYxgpvhZDw2FWKE3jRzCE/vRTqY/DIaSsz9mOD/T/zjiFrP2TO+ySG/airI2KNk/aelXwFGRxhEdUnR2Pnj9gabdWK3A1av9+Pzf2OjbcNOrJM4RFixbxxRhT2BVpYyrhSgVFTSA7gCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=owFrbotK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="owFrbotK"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0335450936so713268276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264476; x=1721869276; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4D79+IUkfPytCkqQCFYniN8I4X54SHHR0HOTbDEr6c=;
        b=owFrbotKuYZVS5q/z8RG5Cl79oaZKJl8N8uPnnk8UewP6fm0bVGerf/+/VS/otKrKS
         X0UqmX2GRi8FfRU8REMplH3AOcGUmx8Gt97PCEHAUS1Qeh4tED/aXV8XJn2o/XQKvxLn
         +8kAVkwqdt2LkjhuP12XQ88IvaQjSRDJrOXGvbOCanajQAtBp2Dr5bMcUdikQ1/iGyHc
         kQHhCLd5HGbsvAyOTe2HbW6eauAQb6COJ8Jo+n8qvqB+arJHVH8p4/3oLX+v5okJoYBp
         dCdEnUwFkareV6LEYEPWZUEZ5AYN/JGO20aHd1+YthVsW4ai355S4txqsW4EKYuEpqpJ
         7/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264476; x=1721869276;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4D79+IUkfPytCkqQCFYniN8I4X54SHHR0HOTbDEr6c=;
        b=guDdep0M+cPbeMjT1gcB3sO5gvMfQMy6a360yz7FyZd/keucCv+B1zPR038ZD6OGxn
         Qmy1CrQCET+LFz/2PjZBjB8msHIZpJNb9I3WTo92FExdCZJ48OcAD5ElSwzKMs5VTQWI
         vB3ybBwzAbpURFaCwkQh2VTFj+4tN1n2u9qSMrobQm8k2C/Wcu05dVV/IpcIuuLmXe19
         pTInMLDsz0T04HglmMev41y9kxi2dihYZRqEnE//ZFZrjRstLp6/vwC0o6mzJx4IKGL5
         jfSuifbJO3nad3fpkp08D+qV0BIgBuAEQW5TST30zhowL/GeXBPM76GB0PMTIhf4QWW5
         G1ag==
X-Forwarded-Encrypted: i=1; AJvYcCWZcW/NZJgA/Ve+8Y+9ZmmZQmNAERDDYKE3mVfzGYNSwSUnEWmyuJB3nSfK2YUIZrbdhsMNNsEEi9ffjfDPd2TSWLwqh5rZ2638UGhX49psvw==
X-Gm-Message-State: AOJu0YzuRhf0chgCUevzKI2RrEdTMj+52LM0Af+KDv/Ux+6oSmqnhT1m
	mTDB9XvZWcSReb4vuDrjJ3TFB8FAI1hAE+7wi4ywKTA9lylK4t07i2th7pkGyHBViF8ZG0G73XB
	lbpqy5g==
X-Google-Smtp-Source: AGHT+IFdcXueyp+PMAvktitAsznwCgBObp3v+ssLmbsVDVTn4IUrAVOTsIsjGyiwtSBsWfywOqLvQluTAWWt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b8e:b0:e03:62f0:a297 with SMTP
 id 3f1490d57ef6-e05fea28f01mr2107276.2.1721264476138; Wed, 17 Jul 2024
 18:01:16 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:13 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 17/27] perf annotate: Use perf_tool__init
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.45.2.1089.g2a221341d9-goog


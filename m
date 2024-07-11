Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB3176AC0
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720854; cv=none; b=BEWazLIpIDzgtFTSOg+4YjCm5h51GomGKk5CFj0vBNbqEa2iDJXlDnUTIalT1z3WCyr/6LARHD01xEmGyc4926L3gOB+yNuS7SAHaaOP3EkjTUnTAWQ6PfuVm85JfSTAbMqqxtwePxzHXpzPBjHGy5OdSKoQuWc2w7rfe21kzZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720854; c=relaxed/simple;
	bh=qWVb8s7IPdoN6VP7CoH6NHZGVGFRy7E/MCr32tMRu8Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fDgw9zYpoDCeFBmH7TC4XtWb+PMBZLU3bN+LZiuNtnWJrQdJ8qsZzfnOFS6kePuk8vF9MAyEzPIEiowgBta3C+u+mJ5Fg2j2W9JO9ZFOc/wl2suvUa08oPu1OYFc4tr3527uev7EKZmYQO1yey19Q15TTOSiyIvY+L1pI9BO3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NUQTZEMr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUQTZEMr"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa73db88dcso2101076276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720852; x=1721325652; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHHBS2O6oNY6SeiT+OH+p80VI/Bl4EiQ8pJoP1UpZWA=;
        b=NUQTZEMrpW+YMgk4aLsq9CDPcjHsFI/sJKcdCJN2OdHZl6cb/L+hV3fHCl5D2pr7Wy
         K1FMax47ygwQ/qD0slxaDULQbqT6gXn8BEvb8n9/ttYCU16pTlbaAzSEVX6xrazxho79
         yMBy0DQWI+ufEHDt73tT5Cb6Z9CnXt4bqF51pWYkuaRt/vdVAuKcxmAvbyCI0D+NnNMD
         pDZ1GwvbzpQ786kdqNqVYBCe+B+V+cdY6mADxQOaTuyd3wVx7m1PiS1k7MpyAItTFySF
         9pe7NALJo2QEhI+EceUFj3HyXHHMQ0gflfWjnB2YQ7hncieOhLvpCK+aIZZ5TaQseDPI
         kDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720852; x=1721325652;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHHBS2O6oNY6SeiT+OH+p80VI/Bl4EiQ8pJoP1UpZWA=;
        b=vKqIT5f2b3Sv2sPDL4J4PrHZLz8A3K/Qdd0Rp0sVJkPiMT3NlCDZYVspKl3rmPaCG5
         K15CmeM8577xaJCJgW+mA9MWjrBx7inCI60K87YJkhxRrWIWC0ILaLpN+cxTuKpvGN5i
         H17nXLztr2/xvqI8rlcktXq6im38B688qTJNYs4T4oE3NmKF6iL1XjS27AsqsXZvd/8N
         62ZMSfZugDb2kwq4fg0RDAx8ECjcZ8tHd/uvJrvrN9KTL8uC54ruhgGafdIS48iWiNoG
         d0AuiW/an6m7quxn92vP8J+F9gp2Z5KQzxWA6VEm37rlflTTN6rELFn+V5AeuHXkj7sT
         NUsw==
X-Forwarded-Encrypted: i=1; AJvYcCXeMhWCG+N0RNmn0v2t5hFepOPktiJIkYnpm4sh5o5Bqv/b2yrhGbET8aoaXe3BpSbcumYZa3PO15CubtP7mIzEGN/o2RQI72/N53XYOTgyvg==
X-Gm-Message-State: AOJu0YziRkbuhcHEJoHkjP0i2P2bzEFUPFJnbooFUCxTc/O4ew2CUR8s
	u9L/2Q/v6yRC6qJaX2uY5syBDQpFMUs3gOp86ETVEwef7/0D7bvky7io55x7zhZ8oNl7Q4izU21
	zi5W7wA==
X-Google-Smtp-Source: AGHT+IGqpkWSNHuIk6znTjQKp37a4qhNUCcyhSSKbaeHKidGnzOJPe4kpolhyZ0aaZjRKcwzNmoatuj2V+U4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:1507:b0:e03:5b06:6db2 with SMTP
 id 3f1490d57ef6-e041b0347b7mr21103276.3.1720720852509; Thu, 11 Jul 2024
 11:00:52 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:58 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 18/28] perf annotate: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog


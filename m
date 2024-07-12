Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE6517C230
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807970; cv=none; b=lxcDBjuvvt/DGiEtpb6qhhrISi0cqRs5884UEciQ3QCLbyXzocrMNkrYeqm1wsvRoudKFu3bImUpVsF2A/z6SwgtA2Wkgh6whnNv0XVe0MaqMB2uGJU17aY7LFTP8BSbw5jkNCrHiB/8nbcVEl3TDfuERhRDW2xOv+NHTl04soc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807970; c=relaxed/simple;
	bh=qWVb8s7IPdoN6VP7CoH6NHZGVGFRy7E/MCr32tMRu8Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LtJ+jtwVYvSlS4wdrNZ3uLLXUl9KHrRnP3umJCzZbX9yFCC//AQaswPzDpW5fytjHws87cqPwAfLYSqDNAPoeops1JEVy8S1M7aiXhc4PvaM57rHIw+aMbWO5JxZKFjuTedsplt7hnwvCjMigod1G8YXVmCCu+xlaEKqD+usuN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B1jLL5i/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1jLL5i/"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03a3aafc6eso3726319276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807968; x=1721412768; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHHBS2O6oNY6SeiT+OH+p80VI/Bl4EiQ8pJoP1UpZWA=;
        b=B1jLL5i/bdBz4SbBh54WN6iVVak/86rO1/1kDrhVuAL2LY55rATLzn/4580rLCFmsR
         zJGguloDIHTODVFCe4RYd6l5r5L4Wt/eSlKqYfYukBZ4sWCl8GJ4zlqT0crqUKaWH2jn
         srPtbDAiOYRxP60te2zhnDcLis0OtvlP481jwDNiu18VH0mkkzVQb5ba9okydC+dOf5U
         hhAsFeEMOIQc7hIREZ1dyd26/0FOSIAK6AXVelrtGCbE5FqtuaT1nF9wyIvVydizk+uJ
         Kaea8kO5eAryXmRyr3K29+mJlqJf0V3sjRldYhuyUzQ60ReugiLZUhu02G6WnIC14S1+
         96ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807968; x=1721412768;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHHBS2O6oNY6SeiT+OH+p80VI/Bl4EiQ8pJoP1UpZWA=;
        b=mI/F604X8JCI8zT+QeRTsZfr0b5mRhfkYsH4MjZ9di0ctwbsWRU/JB11iCOEN9XPac
         Nvtvpf4eRH6/wqlEOPqZSP7luroDrXTMDGKdStE0HsmMprVP0AaQlhdDGBrExDCWkRMz
         0Rsdq77MKFtDI1cF4lSAresK9faUZelaoEuKTi859JpTl7Z7G7Giq2VqUUjSmkZNblk/
         bYpkqKPlMXOyVkp4N/eDTNA3QDkZdImoHWHncFQgW2VOr3n1tRIulWZfBM6azLxxW9Ci
         AYZypzLJIGaXS8dnMAW8SMt4WPvRLlegl8sTGSzhZnEGzvRAjqReCz1ZZLTimggzbaWU
         /zpA==
X-Forwarded-Encrypted: i=1; AJvYcCX3IzST2uWfLd3HcC7q63QlFEjfBHGaLouvo72DHXmhSEBo06nDmbZBRBTbjUgDnY9qomXrvFJQcOd865b3xKUxH3EUx8TIYs5t3BM0tgYNSw==
X-Gm-Message-State: AOJu0Yxgk5AhG120ahsQg7Mvoicndo3b9vSpFJr1kdzeEhlVOuFFwCtS
	Wo2gkd+s2gG12SQxMEMLLKOhUTA4vZPHYmdWkH6tpne/TiGxSaKUvWNrr270kt0tYcXKguI509T
	APIzBkw==
X-Google-Smtp-Source: AGHT+IHi0RESPy1M1p6v6upGm6fDMbixV6F9q5HB/w4IM/nxGzbjXT13DQBQQev04cZgDR3Ow3mnnlitBBVY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1002:b0:de4:654f:9ad0 with SMTP
 id 3f1490d57ef6-e041b058ccbmr26284276.6.1720807967661; Fri, 12 Jul 2024
 11:12:47 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:58 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 17/27] perf annotate: Use perf_tool__init
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


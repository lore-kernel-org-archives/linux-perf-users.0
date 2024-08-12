Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5131C19B59F
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495688; cv=none; b=WfYa2VbrVMvvB2pqK1GsmMG8q0/30L0HvUddIfDQOHldJpv+assl7OSwtmFy9H4ZHcWDK6K5IY7tZImzRqDaI+T8zavmxxOctPyAkRHmPPCDoA6KPX8xk0mX9jcRF2vsUxUR09aTAm+AUaoMrIoI1Nz3qpFbEu7DvAI7L05btk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495688; c=relaxed/simple;
	bh=eQpDTuk3ZSz6r9lF7a8nKcTsMzqFFfSknou6gI+gPWA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uP5Ox68KlD6D2BtjhktFComN327HWscUrcd96sNFNjEiLmS7IKgWRnWn5b5RHQEjKJ3IqSF9rgM2jiYQ8e7K+a5h9+d0P5Vz9FsW3bYn7OTkScMwbCc9j7rRUIo9AA8pn8bpHM2SrcxyiLYRcYUK2s9o06sspRVMZHEatDPYcso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RMPbkid5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMPbkid5"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b6584bbdcso7638879276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495686; x=1724100486; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kpr+cu9QRMpy3TlpvKDVPMxM+YZp/esLhrg70XBtQYY=;
        b=RMPbkid5ljpkEwqSaacXUStG+AiWBo+OoHmEA0gFHtgYmtl+2Jjh6oyYoAIHKamHU9
         Z8SJ3dkrEp0vWHCCUD/ruEhzEb6FJe3SQVUBtcaM/hYMJSOEcpuSrjJ9SeidFV6rk/4e
         FcVFwFzEhKtpLLxDyRrc3flpCydTVUhnAm3o0f4FLcTJBJ/7psxdcoR0o9eeRQMbbU9S
         gsfsrxZ8Bj2pJG/BpjFNqUx+xNFW3+Sem+EyDa4XQ+I80Fw5W1nSy6GIBdVdeiAD3JRv
         cSO7dveMXCO7ltQkde4Tia1vcNW8RAY3Ae9sJcefWTR+Svp0yN2Yl5xA1dLo94kqKoX/
         JBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495686; x=1724100486;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kpr+cu9QRMpy3TlpvKDVPMxM+YZp/esLhrg70XBtQYY=;
        b=ckxTzqSppU3x3E/TqEQG706/YvQ86vIfbaLURL3DRzqlpsqCErjiQ1sgu4Pto07zCy
         /q0SvxCJEi1pfTwcJKG+AWatZ42o9sOOtqEQGRJJh+02nkm2cxjFaZS3S7hrdbB5WA0L
         4Jl+3Obcvx28IOI/01nMulsGtQ9CWACVzV/VArFBPWDFKelJTlcNmVrQqcloyukucdPq
         l1/YWAKES2mdaGiWOBhpmmGy96SBOJza1ki+zkNtd5OWax7H9rwp+w8uqnKG9DyU62zD
         Q0gs0PXFc9pSSKL+gi22UCser8KrK06z2asGVv29ITx9rKwIrrQoQJsbmxPQZLZ4toPZ
         618Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYocFDP9JLMXRnyS+7CqyfR0UhSXeo2U/3e9wLu/BJZ2lEslhkIQHed94XeZjd0rQp0ehGmvjVcqp4gKm3z5ZCtMhP4V8arSyGmfQW1Z5u/w==
X-Gm-Message-State: AOJu0YxFs65vN6X6qKWYaJFmrmk1LLaXZbWodahhY8CT1OxLLYRb3dZ2
	uDvrS0NOGY5UgIqBnyY0oXdQpzBLAj7CTW9AB0/Q52fbCAOLyKByqWT9sY6TqEM6FQJWrUUGjv9
	5e6brIQ==
X-Google-Smtp-Source: AGHT+IEbmaQbF7ylO1nyDJgivkzHHy3Dhc+dF+2T8SKBziKDX+/728BYpHWLDYabb5WwkODPfpNU22Bg1vcQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:abe9:0:b0:e03:5b06:6db2 with SMTP id
 3f1490d57ef6-e113cd4619fmr2763276.3.1723495686242; Mon, 12 Aug 2024 13:48:06
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:10 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 18/27] perf sched: Use perf_tool__init
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
 tools/perf/builtin-sched.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 2c60bd3a8149..34fe8e540c43 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3100,7 +3100,6 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	sched->tool.tracing_data = perf_event__process_tracing_data;
 	sched->tool.build_id	 = perf_event__process_build_id;
 
-	sched->tool.ordered_events = true;
 	sched->tool.ordering_requires_timestamps = true;
 
 	symbol_conf.use_callchain = sched->show_callchain;
@@ -3605,14 +3604,6 @@ int cmd_sched(int argc, const char **argv)
 {
 	static const char default_sort_order[] = "avg, max, switch, runtime";
 	struct perf_sched sched = {
-		.tool = {
-			.sample		 = perf_sched__process_tracepoint_sample,
-			.comm		 = perf_sched__process_comm,
-			.namespaces	 = perf_event__process_namespaces,
-			.lost		 = perf_event__process_lost,
-			.fork		 = perf_sched__process_fork_event,
-			.ordered_events = true,
-		},
 		.cmp_pid	      = LIST_HEAD_INIT(sched.cmp_pid),
 		.sort_list	      = LIST_HEAD_INIT(sched.sort_list),
 		.sort_order	      = default_sort_order,
@@ -3733,6 +3724,13 @@ int cmd_sched(int argc, const char **argv)
 	};
 	int ret;
 
+	perf_tool__init(&sched.tool, /*ordered_events=*/true);
+	sched.tool.sample	 = perf_sched__process_tracepoint_sample;
+	sched.tool.comm		 = perf_sched__process_comm;
+	sched.tool.namespaces	 = perf_event__process_namespaces;
+	sched.tool.lost		 = perf_event__process_lost;
+	sched.tool.fork		 = perf_sched__process_fork_event;
+
 	argc = parse_options_subcommand(argc, argv, sched_options, sched_subcommands,
 					sched_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 	if (!argc)
-- 
2.46.0.76.ge559c4bf1a-goog


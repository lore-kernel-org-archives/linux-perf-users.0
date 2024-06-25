Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6517D372
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336394; cv=none; b=opatLsBXjMpUHTqlQqIgwK5E0Ipg/EWzNg99fyievR9Cm0Gkqd0u+5wBG7ElM4G1/l56/zcvwbHyLetIpT/ZKTMkQJtD4WKRsRely4foO0q8AzuEEdkj589X7MrXCwS7fldq9P7VWf7mcCb4aaJCNKPzUZ4xR7TC6sBAOXZeQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336394; c=relaxed/simple;
	bh=xTDdcKAsM0Ri5uMJZogx0bCMWjSncnIkrWNhWgEEO0w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IDX18Org3k3Tc9n6DHjtMIMKcuRIiLWUSTUrRV9+7zu5f/zBRTBLknUaHZ435P8UUu75qMSneaElyf0G+d1RLd7zQyjV1EOah6gkJLZsmVY2CtIgbQVdtbfKvPs5rjuKfbDfrbChzk6ozZd4iSVRka6sK87E5wjDoWsYZ/WnyWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YmhMTzHj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YmhMTzHj"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-632588b1bdeso110174867b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336392; x=1719941192; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6guPMXmcdW65GtfPCYKyOHBofbB3BqlsDiMCqc1Wqps=;
        b=YmhMTzHjLw5zVWZw3diCPM1b2dlunOJGcuqopETli6VbX/BjEP4Pafz7AUF318/Kb4
         SHAIRXV+x76oa90ZRTQdb4ZCWf9p1zv62RayLEPZAepe2OFxkUrYR74hr/nP0Fnjd2fh
         H45aE48agPQ6noIz2HijaFxjrTU/cNpIFspDNkCvVk9teAfd9hcw4KFQG7MC5fvoRNNQ
         WKXaRjnvio0CEEXZ4KJQDEpm+urwsNwKp3xnOk+Ge2XXbqICwIkHlTrT+qmNAkEVarem
         0GqdTJ3Gs9rJv9iAuWv2tKVoBBCMNeg/TXEtjQvao8ZJjd9eRDbtPuoSRoxdP3ZSz290
         UauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336392; x=1719941192;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6guPMXmcdW65GtfPCYKyOHBofbB3BqlsDiMCqc1Wqps=;
        b=S2fG9ELUjytJHVrJglrzSaeqE66PHZP7Lg5PpCz86/m08SSYrj+U7iQy145/MTGfwr
         1IHDSPoZ6SMwYVvj/97E+HPST0ItzvZTYM2gTTJj/6RIRSH88SsN8SzT/AmfkPLXz2UM
         JetHzK1ORKYtBkX0wW0isHRxTc1xfgd0/4VySEq3Fkw15bapIJB8/cE3rbGrOmMt5PxC
         MAXVkePEAnV9GY4/qcKl2mzIaG6coDtKBqQdwE/f1jQjUEj+kEQZmwNqQet3LMlR/OJO
         bnBot2XDfLqrd9n0S+BAdlRvDXqoZD0xLSLnCWKWWRWfCC+UugAA8dgbTKXAwNgKOdjM
         sy9g==
X-Forwarded-Encrypted: i=1; AJvYcCXM5kSLbKMd3Atqj9VWfQ/QEZEp7UbXziR6EVjSXw6GCkJAp+97f+E/zqoKkY0cxNoE+qrYWfp0bHScXhPaBwSFhuDugo811qXyTQDiIyAHkQ==
X-Gm-Message-State: AOJu0YxiStX03+gSUtW9ufTU8ZaVlTshtsUZNdiOJ0lFr/wfLXC7s10y
	1dj9bIqhbpbNM2RvgLegzYHjfUoBm0Z3XfQslI9YrAjEN/qtKusI1U6ISa+uweslfTVA91na3TQ
	feTxEUw==
X-Google-Smtp-Source: AGHT+IFV8nFgbzCmqp5624khLyjgblB+C7PSMAG99rhpEHx97+eQXMZPvyVLcBZvUnoqdEaw5LZAWS/mgVDn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:fcf:b0:627:7563:95b1 with SMTP id
 00721157ae682-6429c6dcf91mr317197b3.5.1719336392078; Tue, 25 Jun 2024
 10:26:32 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:47 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 10/26] perf c2c: Use perf_tool__init
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 88c131d05186..cd2bd573bfc3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -385,24 +385,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	goto out;
 }
 
-static struct perf_c2c c2c = {
-	.tool = {
-		.sample		= process_sample_event,
-		.mmap		= perf_event__process_mmap,
-		.mmap2		= perf_event__process_mmap2,
-		.comm		= perf_event__process_comm,
-		.exit		= perf_event__process_exit,
-		.fork		= perf_event__process_fork,
-		.lost		= perf_event__process_lost,
-		.attr		= perf_event__process_attr,
-		.auxtrace_info  = perf_event__process_auxtrace_info,
-		.auxtrace       = perf_event__process_auxtrace,
-		.auxtrace_error = perf_event__process_auxtrace_error,
-		.ordered_events	= true,
-		.ordering_requires_timestamps = true,
-	},
-};
-
 static const char * const c2c_usage[] = {
 	"perf c2c {record|report}",
 	NULL
@@ -3070,6 +3052,19 @@ static int perf_c2c__report(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
+	perf_tool__init(&c2c.tool, /*ordered_events=*/true);
+	c2c.tool.sample		= process_sample_event;
+	c2c.tool.mmap		= perf_event__process_mmap;
+	c2c.tool.mmap2		= perf_event__process_mmap2;
+	c2c.tool.comm		= perf_event__process_comm;
+	c2c.tool.exit		= perf_event__process_exit;
+	c2c.tool.fork		= perf_event__process_fork;
+	c2c.tool.lost		= perf_event__process_lost;
+	c2c.tool.attr		= perf_event__process_attr;
+	c2c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	c2c.tool.auxtrace       = perf_event__process_auxtrace;
+	c2c.tool.auxtrace_error = perf_event__process_auxtrace_error;
+	c2c.tool.ordering_requires_timestamps = true;
 	session = perf_session__new(&data, &c2c.tool);
 	if (IS_ERR(session)) {
 		err = PTR_ERR(session);
-- 
2.45.2.741.gdbec12cfda-goog


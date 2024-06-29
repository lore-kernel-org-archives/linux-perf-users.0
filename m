Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA65481AD2
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636895; cv=none; b=E5zK2uLkjCrGBBipa6xUXWZ3qe/Ka8p8SILwDff2uVTv1ikOmQb9PV+r+olYX74rCFyiuxeG0U2zbGGAz/PPP7C88Mnrkh41H9KwWTAMmsIWd8zf2RvMUV1B6iQOosAaFDSIvkKJgeJ/jukhv5yLMNEya8I9CIDkOkC8pIzUAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636895; c=relaxed/simple;
	bh=0ztUIio41tQxeZ6pNheoy2WFvNhtkuCm/qyK94mmeeA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ckGhV+MynIWZ4XVYjvpwbXUDbHbGmWAnILyB1dL1PyB30AWc05PhnNNpoRpfvB7Oiw5W9Y/gpVfS6ZS+ZWsTObO0fywMSdP2ycHcyeAMLV0Fqq2uknaDsAqSqA4w2o//OqzEOPiJ1KQzdjhRFEz+idXB6BpHyUZ6fFbusmk2KYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aGAFvj9x; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aGAFvj9x"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6499b840395so27049967b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636893; x=1720241693; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfKlTlSCL2wXPfCkyXXt0BLFWNYsoBhoMOQYtSMfZQY=;
        b=aGAFvj9xgs92gI5LOX1W2jhq7wSBJOFkP4bmEI01aPtCqzAKlWS378QtfNfU6QlkzI
         6lXV2zrJHphYzH637m/CDTJigM2dwFRjsG+M5/TqzYeUehTyh00kbjnsgL67YKKyVQ5m
         IB+cMqzkfVH8vNAItYJkL31MZVQ9oOmG1BqQzXIH7p7h80sk3OnT3F6rBvx9Ekc6Y4bh
         id/kPJo46bE0ws9APmuNSfjfXyNEvnwwYoSzb0/4DpNOFnx6Ycy7RmhLhLxwz0Wwsd+E
         /OmWLWDG2y+mb12RDOFycNP/t4yJloa1NQSZJYcV+D5737DSu0gnajK1UahmPi8slbF2
         NZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636893; x=1720241693;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfKlTlSCL2wXPfCkyXXt0BLFWNYsoBhoMOQYtSMfZQY=;
        b=hjUcW05RW4ARNtQvu2jCSBr4tDDkfp8MKcTF05MZjHWwfRtqmc0cbYD7eRN/hH9B/j
         c1LNf41irbWNxu9AZlNi6Qwxag8jKUeHJrZFu4df0XUF9X2uelfX6KHiK/6RUgZuG7YF
         dqRfqaKD6IqCtXjq9hrnlfwKdN07PkHiZy+dEuna7Yr8L5siNyOKgQGyRpZNZZM8aKsZ
         k1M8bKK4T8iBTQWvQ52612sy5ysqpZfzmzKqiFm3JgRn7IGK6hjvubG/7w13S8q2i4Wg
         vzXHGOYwUDCIH/FiZd6rIqauvV6KZSsc5H3E7M28mbC2UPzaNMzwnMhlGcK9BICm63Y5
         nWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXndIWUrRsMw06xs+No2BanrVPwsrqIbU0Jq9YlQ8fVGHYdapGX78t72ZSL9WgFdlkZqLWd99gknzXRcZh7n9+K81e8uVB4KOqq0UCoti9cyA==
X-Gm-Message-State: AOJu0Yzv0q5TwauhOxFppGUzb3kF2+MkLDKiTMu7H+G9RJral0ENXUSo
	AvFu8yX1GFALg2UoKEuoeszURdBcMe7a8lSArYKSQtuT361IuqZb9jw29CShzdKH2w/af5SHxXx
	8QZ8iKA==
X-Google-Smtp-Source: AGHT+IE3hvUi65nhptsIwThb+FEiJVyGB6CGhV5lHcENJmfmi33GBQd2LxbemtNkGqQcGwOe83UOXGl8G96S
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a25:ae83:0:b0:e03:6445:8ca with SMTP id
 3f1490d57ef6-e0364450e73mr75710276.2.1719636892995; Fri, 28 Jun 2024 21:54:52
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:42 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 20/28] perf mem: Use perf_tool__init
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
 tools/perf/builtin-mem.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index c2038a32543c..c12ca0ec1237 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -285,7 +285,23 @@ static int report_raw_events(struct perf_mem *mem)
 		.force = mem->force,
 	};
 	int ret;
-	struct perf_session *session = perf_session__new(&data, &mem->tool);
+	struct perf_session *session;
+
+	perf_tool__init(&mem->tool, /*ordered_events=*/true);
+	mem->tool.sample		= process_sample_event;
+	mem->tool.mmap		= perf_event__process_mmap;
+	mem->tool.mmap2		= perf_event__process_mmap2;
+	mem->tool.comm		= perf_event__process_comm;
+	mem->tool.lost		= perf_event__process_lost;
+	mem->tool.fork		= perf_event__process_fork;
+	mem->tool.attr		= perf_event__process_attr;
+	mem->tool.build_id	= perf_event__process_build_id;
+	mem->tool.namespaces	= perf_event__process_namespaces;
+	mem->tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	mem->tool.auxtrace       = perf_event__process_auxtrace;
+	mem->tool.auxtrace_error = perf_event__process_auxtrace_error;
+
+	session = perf_session__new(&data, &mem->tool);
 
 	if (IS_ERR(session))
 		return PTR_ERR(session);
@@ -449,21 +465,6 @@ int cmd_mem(int argc, const char **argv)
 {
 	struct stat st;
 	struct perf_mem mem = {
-		.tool = {
-			.sample		= process_sample_event,
-			.mmap		= perf_event__process_mmap,
-			.mmap2		= perf_event__process_mmap2,
-			.comm		= perf_event__process_comm,
-			.lost		= perf_event__process_lost,
-			.fork		= perf_event__process_fork,
-			.attr		= perf_event__process_attr,
-			.build_id	= perf_event__process_build_id,
-			.namespaces	= perf_event__process_namespaces,
-			.auxtrace_info  = perf_event__process_auxtrace_info,
-			.auxtrace       = perf_event__process_auxtrace,
-			.auxtrace_error = perf_event__process_auxtrace_error,
-			.ordered_events	= true,
-		},
 		.input_name		 = "perf.data",
 		/*
 		 * default to both load an store sampling
-- 
2.45.2.803.g4e1b14247a-goog


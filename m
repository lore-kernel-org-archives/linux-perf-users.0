Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373116F8E3
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720837; cv=none; b=Fk8+H7P9JDsI0VrmJsFNjU/eo4cbwSpFha2vaT3HnvFq5Q0LRwvzbSYerxqg+tpYtTRQEujNyAZPtPl+CFH7egjCKatR8Jlu+dKbq59ZUIpdEBnpS9i7LUFe7hrE+pb87H1UsNGI6ZY+eUto+Ww3aAt1arZLiSiAzVzQD0NjQI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720837; c=relaxed/simple;
	bh=LWeT84SQaD/ZqxsdujULbunWNxfNaZERjhKf3ganreg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dkrGZFy6CpuIOwhdPX9twCexjB2tlae60rPx9xkGVLIXZc5xGQk3zYirXAwIFeYdP1byMymoC3DIs83A/6h1dy/yyRjWbCZFQeZ1uG4eV6N4TPs5Z+CVzLdBGxuKIvYtJWRxQ+X+/R2L+VWs/ux8N5z50m+75pJhaVnpUY/HweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vd2oRw2J; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vd2oRw2J"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64b70c4a269so18506027b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720835; x=1721325635; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jf/366lvU4AUPtbGBpn9zhF7c/C+EcohgCe44YuCQ7Y=;
        b=vd2oRw2JzLJmuRlDZ82IACc+5+br3h1F6RVS8jTUeTpNzqNvo3bGRRMnsLdli4NyOS
         El4oSnXGv903vTqDlE2t+oTRF7htei4u3Ggd56xE/7rB5Xj7LFKyrAwnJyt2OgeODUT/
         pdg1fVE3zNxV/sSKDuJH8yX8yN3CY9SiR7DiRns8Mz3AlPknLBCWc4L0O3fUlNK2Clw4
         LmRa/gpKWXAbYmx/Qn5Qy3qs4T7C790/tc22//2BZHPa2qGDuWGxgODihyC1y/Ph+4Oc
         e+ZoAncAxreIql8dkH6Y77NW3rvxErflYdFhAUu201jbT2okBffKvbNLS6MWjpfgEAUS
         fIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720835; x=1721325635;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jf/366lvU4AUPtbGBpn9zhF7c/C+EcohgCe44YuCQ7Y=;
        b=A61TBPtaMeo9GbcfN0kXQlm+HDSrhtigEfcCzY7tSpxqxFVKDnBlb7SN5SvtwoSPkt
         jd15IOTK/LCXiGt2DpcKhvdJ+Ido0QF8jw1EwzcIyfUwWLJi4I8zncD6Dh+YbKrLGuR3
         gqE1GGvPPXDHwSqkGJHevCAZs3nZltkEsqLng7/5pvKk1nhb29J9iqKshTW8ClCaIHFy
         Y7vBL9qIkTu0bNrsl8wegfCkdOHZd4H3LuFevcKAfReX8dRS3fXz8IrPlXtaPFpj7Id6
         JswoAGmvg8WvFoUTbk/m6hNs59C9l7llsda107aT/+fhJdnElAi0CrnSaeqyV0uobi4y
         t/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMtZvHfMjzeCzqH+IWLsi1fKtQ0bW+LUKcy7lOehc4YDFFu+yGeywyqr70UZ/aOwT7hTgBb/R74krmZoBAr6Y4nhBRIm7xBtMHbM/WSvEnzw==
X-Gm-Message-State: AOJu0Yzr5CHQlnY+bz+pUEMXOAa49stjHs1tf6yfkg6xBujIxlGAvnde
	UuNzFjpKdJlZbkNOQFUospkD9dpYfOyyhi4sQmJhpJkRCc9RijChK4ff3nambeI5RgQxvtasDIJ
	DhoRghA==
X-Google-Smtp-Source: AGHT+IHgRRHzENtJjdaIKJzPMb2H1HDZVK/Rf4u2rJiQyfph07pK93KyOLIPHnJjFuZcvCLU340y0vsp3u3Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:690c:3510:b0:64b:5dc3:e4fe with SMTP
 id 00721157ae682-658ee699c87mr1323597b3.1.1720720835320; Thu, 11 Jul 2024
 11:00:35 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:50 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 10/28] perf lock: Use perf_tool__init
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
 tools/perf/builtin-lock.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 6efa9d646637..2c216427e929 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1933,22 +1933,21 @@ static bool force;
 static int __cmd_report(bool display_info)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.namespaces	 = perf_event__process_namespaces,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
 		.force = force,
 	};
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.namespaces		 = perf_event__process_namespaces;
+	eops.tracing_data	 = perf_event__process_tracing_data;
 	session = perf_session__new(&data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
@@ -2069,15 +2068,7 @@ static int check_lock_contention_options(const struct option *options,
 static int __cmd_contention(int argc, const char **argv)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
@@ -2100,6 +2091,14 @@ static int __cmd_contention(int argc, const char **argv)
 
 	con.result = &lockhash_table[0];
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.tracing_data	 = perf_event__process_tracing_data;
+
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
-- 
2.45.2.993.g49e7a77208-goog


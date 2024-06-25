Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B017F4FA
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336417; cv=none; b=F45LtEfFT24FZ46Rc56fSXoePICnXH8YI/37QY+MbTk4kw3L4TbEuHW1kpA+iJcIM42frELZgQZXts0XXbefktV5vJvSndWE9QWxU822ncagiVIOozajhkwjhMAsYxkMvn+DKse5mPIlZodrJ7h+7lqMRuwcyvPsS9vkIbaPHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336417; c=relaxed/simple;
	bh=dyBAFLuB77d4FySD0MlGoqSmYtedpVSJiMTBSe2shXk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dQq+bdz3TJXgs74IVSVNdXnYL87Kk9P1FkoPY0bhP9We50hMl+X1dDbqh83jgK+VdBI+kARV0lSCbjDfczwDUo1UjrV+J/cVp8tOgAsO2uI1jTwFrhniz/QvQ2/iNmSEXupD4BlrFSmKSY6rci7Gwb3FzFzX0/fmfVkvI3bFiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZ6NdaeD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZ6NdaeD"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bf44b87d4so65863177b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336415; x=1719941215; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAjCLL/ftZfBFw5cOoLeSIWi0+JxdIhk3yYIclIyM/M=;
        b=lZ6NdaeDPaH3i9fsDf8R/0pzlbVVPannj2L28zXzvrJnWP8BsEsQ7B58pbxYxXnP2X
         MAxiOhNVaFmS1fgGhaqjCOLaJaCreZ0D0RzR9O4kXPz4W+cL7iAM/5ge2RK4+VeSubN+
         fzia+i2IWnr2Zz0QvN7hqepEFdgNkOHxbLRdWKRcxxn2JGxEdopyyCq6vJTuRgz7vLw7
         EoYC8mCZB2tX2iteocLx2mXzQnN30uzM9Eh1mNSWSB9tm9G+gnORcp1mNIkdIRrAXjsd
         VthFzd/eYJAmeksdvcHpA1Dz+Wb8BZZz39HRlff8O6KIdutM+lAEo7l2oWyA8bgCa4H/
         YLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336415; x=1719941215;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAjCLL/ftZfBFw5cOoLeSIWi0+JxdIhk3yYIclIyM/M=;
        b=BNzjxPm2zILjksGsWFfnPcdAgxJKC7pGhMZysVgweoy8Jn0OsEyk+s+0sfpGdDx7+m
         2j4+R6hzYWYIaN6jxPjlIOJK5M4Xc8BLY3oEgKbP/Igobjk/bjTdiNPFHq18EZ2f1uYl
         660/iZ522YDXBGwUvXFiIopofeq2G7HLlyzCfoofcafQNvP6b43jErdaWRlWcoQE1Ui9
         fRVoYt6Jbyp0a9gcKsScJNSKheuHJWnqEkfQW8NXTY8JzuOvhqrzsTlkadn5WSP4g/xD
         FjAf9yFE0l60MFKrswVzTEl8t171UcfPUoCFBj5n9DUL5CYzCaAFNFGNbSK14cXXuBON
         ZHKw==
X-Forwarded-Encrypted: i=1; AJvYcCXuOhk+c378WPOVPU33Het3ffYU0dQV/FhxM577RcLA8pYwt9Ws7UinrmpTYAFfBdA9V+v2NQNtpf81MqF+dju/365CSnehvTlG0x5QaPurFQ==
X-Gm-Message-State: AOJu0Yws9ToFiho1YjpM1gHQ6mkqAdNQ2rVJ0x+qOCF/sIU8D5ypZf5R
	+862LWbNE0tLlgOje/HsJSyLwGYHkLB7xkb6JT9d1tfJKKcv60bOIaYF9mM8+3jK09zicCmxzoz
	JyMhwKQ==
X-Google-Smtp-Source: AGHT+IHrK3RRi7tycrRZAYc2YvJzBlzr7KTEgMOmkpv40UHUsdr9SHfnbmoDqJX2YXdlS2m1S71lhIGMfr6U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a81:9208:0:b0:631:4588:4acc with SMTP id
 00721157ae682-64242491f26mr559437b3.0.1719336415369; Tue, 25 Jun 2024
 10:26:55 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:57 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 20/26] perf data convert json: Use perf_tool__init
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
 tools/perf/util/data-convert-json.c | 43 ++++++++++++++---------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 905ea9823f9d..20bfb0884e9e 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -316,39 +316,36 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 	struct perf_session *session;
 	int fd;
 	int ret = -1;
-
 	struct convert_json c = {
-		.tool = {
-			.sample         = process_sample_event,
-			.mmap           = perf_event__process_mmap,
-			.mmap2          = perf_event__process_mmap2,
-			.comm           = perf_event__process_comm,
-			.namespaces     = perf_event__process_namespaces,
-			.cgroup         = perf_event__process_cgroup,
-			.exit           = perf_event__process_exit,
-			.fork           = perf_event__process_fork,
-			.lost           = perf_event__process_lost,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data   = perf_event__process_tracing_data,
-#endif
-			.build_id       = perf_event__process_build_id,
-			.id_index       = perf_event__process_id_index,
-			.auxtrace_info  = perf_event__process_auxtrace_info,
-			.auxtrace       = perf_event__process_auxtrace,
-			.event_update   = perf_event__process_event_update,
-			.ordered_events = true,
-			.ordering_requires_timestamps = true,
-		},
 		.first = true,
 		.events_count = 0,
 	};
-
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 		.path = input_name,
 		.force = opts->force,
 	};
 
+	perf_tool__init(&c.tool, /*ordered_events=*/true);
+	c.tool.sample         = process_sample_event;
+	c.tool.mmap           = perf_event__process_mmap;
+	c.tool.mmap2          = perf_event__process_mmap2;
+	c.tool.comm           = perf_event__process_comm;
+	c.tool.namespaces     = perf_event__process_namespaces;
+	c.tool.cgroup         = perf_event__process_cgroup;
+	c.tool.exit           = perf_event__process_exit;
+	c.tool.fork           = perf_event__process_fork;
+	c.tool.lost           = perf_event__process_lost;
+#ifdef HAVE_LIBTRACEEVENT
+	c.tool.tracing_data   = perf_event__process_tracing_data;
+#endif
+	c.tool.build_id       = perf_event__process_build_id;
+	c.tool.id_index       = perf_event__process_id_index;
+	c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	c.tool.auxtrace       = perf_event__process_auxtrace;
+	c.tool.event_update   = perf_event__process_event_update;
+	c.tool.ordering_requires_timestamps = true;
+
 	if (opts->all) {
 		pr_err("--all is currently unsupported for JSON output.\n");
 		goto err;
-- 
2.45.2.741.gdbec12cfda-goog


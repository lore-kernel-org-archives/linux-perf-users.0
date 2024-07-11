Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F416E88E
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720866; cv=none; b=qYpQgV99qyWY3N+RRRVUAzJt8macswDNFRgnVib+ZFaCxjo72Ayiitlf5L/1WPk1KGZN3v06d8MWtYbBfmOfegW7bohgiv+gdCRfyyOvfLocxQPwpOWIwT5ngGgt5Vg5zTqtwvO2M0Tb+bJle3yOVBtH1Dcf3q+JMtlov53jlmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720866; c=relaxed/simple;
	bh=Zg5U84S1ofRY2jiFZPVeAVTNxheJYumCpecsmhgwjUo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NplxTUtrLTkujRQXLokcIKq5pi2+YNDNevS6Qb1FWpiLcUUCdO2LXVH59OXIBHPvabh4HdDK/bjnO3jo+DrEVLf89jUlbi9eM0geYzRZnpKTok8x9MGFDsDy2ef+aQysBc9UCxsE93dFM9Ej0jh/Nlz6+uljPlxsdA3dlloGITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AnmXHAdY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AnmXHAdY"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-651e54bb41bso17365427b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720864; x=1721325664; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqtdDMsD55pEoQfMNz6zeYZQAoeVSzSneBvTBBwc7VY=;
        b=AnmXHAdYP4uCFgtMdgvkHBu7QdTvAvOaSiREvWAy7huTrTo2KCMqcfYVGS28q8Gh+n
         5zXhm0D0inWyxWxdP+MDpSnZmDwObzClyU88yYzz7cNY4/XMTTsIictQGXz5XAUOhl1+
         iyrHXoBW/lw0L560KPLFYOXWJfK1DdTjyGpUViWbQJKYC7OhAbDtW0lBJzJAalM4d6ym
         myV2LYN4lCoOUjwW74P7JoszU5G3IWY3nk+wHGCSDz6Dt/5VefQwtuc4jZIgtsKeqRUE
         MegE2zUYA1XAfleyAXleaasbS0TdbDT0bUAoEWmEGj5iC3FGQEht/2ITPI4UQ1pdZL5l
         9dnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720864; x=1721325664;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqtdDMsD55pEoQfMNz6zeYZQAoeVSzSneBvTBBwc7VY=;
        b=A+Eh3TahKUJrPCfsAWh7MFQed4h5USjI/XaSbIQDJq2Y4mapzkznFAATjM6uTp7/zV
         81sBpLn5u/nOchmWAnaxgiXFNCYupc5fXNz0e11gioqQUDJqj7QYRMZCa8LdWqNS6K7e
         gv9dwOdzADaznA638SiD9Pz9GXT0ZyrbLr+FYz35tkTecq/qmnlxT2f7DpY80xHEvGVC
         ndKc5A/FHsD0uRcPmTeNAD7P1YVTxIfCgO6dkin4LOEUq3XFemnDY5Dkc9iXmuj4kCnI
         dGI+MZRrmwIO9dopTX4jNQFNcgqF3fVdcM2oqWF1b3wkov4pfiNYwaaupW1zjyChgVIZ
         81+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUw86ne1R6Ma5ATeBnygIHvIvUGXmDU1iFDB/QESTDbS5SzypvOrd9dNZWqIBiZ49vFq9UqMusqXbf0Kc9voYamuCJMX4bQvXgM4zkMmFWSww==
X-Gm-Message-State: AOJu0Yzwq4pJJ10x5+IWLQTGvXjL3JF0PwbD2cTrA4+XOqw03J5+nBkL
	aapzrhsxRt6gBhfiGmFcNzo3tUrL0gzbyGfTmYnlU9uPSJf9yrKi5ByFl0+ymV30LxTtvrzgSi5
	VDgUrsg==
X-Google-Smtp-Source: AGHT+IFm7iteUqTnpFU/9RIErlfRTtg3oqwxjOCKfDaCl4dOg8omYu/CwVrqY1dpL402Zc1R9QmK5RmuQget
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:690c:6b0c:b0:648:afcb:a7d0 with SMTP
 id 00721157ae682-658f06d9ecdmr530397b3.8.1720720863879; Thu, 11 Jul 2024
 11:01:03 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:00:03 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 23/28] perf data convert json: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog


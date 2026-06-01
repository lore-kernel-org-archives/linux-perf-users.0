Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45F89460
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272362; cv=none; b=qHS6NLlikHqxCEfNkI5aHOHvDtVi7SQHbRGomZ2pLE+J4uoYFwDgL6lfaGzB8stHm/d1js5trkpFn8Spdvrw8gaFXej9Zidwix5S++eW088yfHeFjTICHjyGvnV1RyeW2fArGR/KaW9ouXXVSRbaOosh0ZhIIDeVOzO8iJ+nuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272362; c=relaxed/simple;
	bh=ohrq1CNpVRmopsfWpSv9Hj5Bh5Yp5Tr8slz6plEjO0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PNRKsYFVNCGzsj9Vio0h9/O8V+3hkknQ66BOJZr7dhoum3Z15WADNoUm1xv6zW0vrVCwEZUCA6S0wfs1DckiAntNgCEtEC/MrZtYuEoDzTGzZcAfaxgzk06q9OejmhqwQ0LB+tOCdI1ysANrHuL7zpVpVD9pa5vG9C/vxKQ0x28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KmgdHtPe; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmgdHtPe"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304e7fbfaf5so972249eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 17:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780272360; x=1780877160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaY/4cr24NdSxoSftl6vfA+eIwzfPnX9jZSLTs4kqqE=;
        b=KmgdHtPeXmCR1P25bLhoTZ/YLU9/rk+P23bYuTWtm/HtQrMm/lfiOY6KXIdY1a5SWZ
         U85as7JiEOGrnGmqDEjrVc+xWt1P+CI2ETaK9r2bvBX+Ku+zcMDs7ZgVoaUDe6pjDOsD
         ZPFdhuzjyef3JzD/hDrXymEPrLtnVre36tpq2mk/QW/aPOkOtYMe03fwUdKZmsa0wCA1
         TXpR7Wb9ih1GZ4r9fUO41hWXOiK6khmfSFn5qSWOSwN1YK8FW35eKootujDWzJ2n60Cp
         /vdH41J/qFk7v9uDmQnZ4Bg6qUaMZWBZrvIM/o9DJa2wi0EVOZ8LiFBX4Csjr9CwjOXp
         CLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272360; x=1780877160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QaY/4cr24NdSxoSftl6vfA+eIwzfPnX9jZSLTs4kqqE=;
        b=Bj1n2paKV9xbAphdShPQQ0oHwWQCyxfAucajJEZQAKRzJRcTA5Vwqr4Qcy7WjhcPny
         9Cg0NF5MxNp4v4DVeSpTvZoEvpjVJyYVRbC2l7wDO5NocAvpJwlU2cBTUXqaic5BygKj
         RFSS/JAc2HvMFWYa4BlbgMQoth+SCEceMIxBp6n6FoYcCABPpQvcR3rQEI6MG2eRFsEV
         IGiWfzLFjiDSbXhqkAGINjEjop0XaJNk+hu2yU+aoSUEVC1wqAFIiHuebRDWuPR/hOkS
         qVyGc7WZc2wCu6YI2PPicFUIxZlWfHzN/PHtc055RJ7tJYAZEFIFnXHgC+QL2+Q1sOOQ
         3UdQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wMcTukOShV3aXhGEbYl+oh1+IaihpBl6MeklFzXkaMgBfmGoAebhpER30yRCrNqmo++nu3rybjt9cQumjrt/V@vger.kernel.org
X-Gm-Message-State: AOJu0Yympgs0T9PNiKG+/Y2C/pJItDQduCuLjXgLdc7FNt7OEtlItpwG
	p7Ti/DlihuOTwm209BtKqAWpyWQaMHw920M/nk1Bwqt8w8Kbu3G6/pXPPcFLbdADsIAH3v3ejgQ
	o2HkYZnQ/cw==
X-Received: from dycpp6.prod.google.com ([2002:a05:7301:dd86:b0:304:aa56:4ed3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1485:b0:304:de2b:446f
 with SMTP id 5a478bee46e88-304fa659030mr3616843eec.28.1780272359592; Sun, 31
 May 2026 17:05:59 -0700 (PDT)
Date: Sun, 31 May 2026 17:05:35 -0700
In-Reply-To: <20260601000548.1195604-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531082235.940833-1-irogers@google.com> <20260601000548.1195604-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601000548.1195604-3-irogers@google.com>
Subject: [PATCH 02/15] perf pmu-events: Add API to get metric table name and
 iterate tables
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add name field to struct pmu_metrics_table and populate it in
generated tables.
Add pmu_metrics_table__name() to retrieve the name.
Add pmu_metrics_table__for_each_table() to iterate over all known
metric tables.

This will be used to break apart slow metric tests per table.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 48 +++++++++++++++++++-
 tools/perf/pmu-events/jevents.py         | 58 +++++++++++++++++++++++-
 tools/perf/pmu-events/pmu-events.h       |  4 ++
 3 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index ad5ade37adb0..b90a75892f0f 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -5403,6 +5403,7 @@ struct pmu_events_table {
 
 /* Struct used to make the PMU metric table implementation opaque to callers. */
 struct pmu_metrics_table {
+	const char *name;
 	const struct pmu_table_entry *pmus;
 	uint32_t num_pmus;
 };
@@ -5435,6 +5436,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 		.num_pmus = ARRAY_SIZE(pmu_events__common),
 	},
 	.metric_table = {
+		.name = "common",
 		.pmus = pmu_metrics__common,
 		.num_pmus = ARRAY_SIZE(pmu_metrics__common),
 	},
@@ -5447,6 +5449,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 		.num_pmus = ARRAY_SIZE(pmu_events__test_soc_cpu),
 	},
 	.metric_table = {
+		.name = "test_soc_cpu",
 		.pmus = pmu_metrics__test_soc_cpu,
 		.num_pmus = ARRAY_SIZE(pmu_metrics__test_soc_cpu),
 	}
@@ -5455,7 +5458,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 	.arch = 0,
 	.cpuid = 0,
 	.event_table = { 0, 0 },
-	.metric_table = { 0, 0 },
+	.metric_table = { 0 },
 }
 };
 
@@ -5475,7 +5478,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 	},
 	{
 		.event_table = { 0, 0 },
-		.metric_table = { 0, 0 },
+		.metric_table = { 0 },
 	},
 };
 
@@ -5990,6 +5993,47 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data)
 }
 /* clang-format on */
 
+const char *pmu_metrics_table__name(const struct pmu_metrics_table *table)
+{
+	return table ? table->name : NULL;
+}
+
+int pmu_metrics_table__for_each_table(
+	int (*fn)(const struct pmu_metrics_table *table, void *data),
+	void *data)
+{
+	size_t i;
+	int ret;
+
+	for (i = 0; pmu_events_map[i].cpuid; i++) {
+		size_t j;
+		bool found = false;
+
+		if (!pmu_events_map[i].metric_table.pmus)
+			continue;
+		for (j = 0; j < i; j++) {
+			if (pmu_events_map[j].metric_table.pmus ==
+			    pmu_events_map[i].metric_table.pmus) {
+				found = true;
+				break;
+			}
+		}
+		if (found)
+			continue;
+		ret = fn(&pmu_events_map[i].metric_table, data);
+		if (ret)
+			return ret;
+	}
+	for (i = 0; pmu_sys_event_tables[i].name; i++) {
+		if (!pmu_sys_event_tables[i].metric_table.pmus)
+			continue;
+		ret = fn(&pmu_sys_event_tables[i].metric_table, data);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static const int metricgroups[][2] = {
 
 };
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 6f80f937f9f9..751387ec1ae8 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -712,6 +712,7 @@ struct pmu_events_table {
 
 /* Struct used to make the PMU metric table implementation opaque to callers. */
 struct pmu_metrics_table {
+\tconst char *name;
 \tconst struct pmu_table_entry *pmus;
 \tuint32_t num_pmus;
 };
@@ -747,6 +748,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 \t\t.num_pmus = ARRAY_SIZE(pmu_events__test_soc_cpu),
 \t},
 \t.metric_table = {
+\t\t.name = "test_soc_cpu",
 \t\t.pmus = pmu_metrics__test_soc_cpu,
 \t\t.num_pmus = ARRAY_SIZE(pmu_metrics__test_soc_cpu),
 \t}
@@ -761,6 +763,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 \t\t.num_pmus = ARRAY_SIZE(pmu_events__common),
 \t},
 \t.metric_table = {
+\t\t.name = "common",
 \t\t.pmus = pmu_metrics__common,
 \t\t.num_pmus = ARRAY_SIZE(pmu_metrics__common),
 \t},
@@ -781,8 +784,10 @@ static const struct pmu_events_map pmu_events_map[] = {
               event_size = '0'
             metric_tblname = file_name_to_table_name('pmu_metrics_', [], row[2].replace('/', '_'))
             if metric_tblname in _metric_tables:
+              metric_name = f'"{metric_tblname.replace("pmu_metrics__", "")}"'
               metric_size = f'ARRAY_SIZE({metric_tblname})'
             else:
+              metric_name = 'NULL'
               metric_tblname = 'NULL'
               metric_size = '0'
             if event_size == '0' and metric_size == '0':
@@ -796,6 +801,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 \t\t.num_pmus = {event_size}
 \t}},
 \t.metric_table = {{
+\t\t.name = {metric_name},
 \t\t.pmus = {metric_tblname},
 \t\t.num_pmus = {metric_size}
 \t}}
@@ -807,12 +813,57 @@ static const struct pmu_events_map pmu_events_map[] = {
 \t.arch = 0,
 \t.cpuid = 0,
 \t.event_table = { 0, 0 },
-\t.metric_table = { 0, 0 },
+\t.metric_table = { 0 },
 }
 };
 """)
 
 
+def print_metric_table_functions() -> None:
+  _args.output_file.write("""
+const char *pmu_metrics_table__name(const struct pmu_metrics_table *table)
+{
+\treturn table ? table->name : NULL;
+}
+
+int pmu_metrics_table__for_each_table(
+\tint (*fn)(const struct pmu_metrics_table *table, void *data),
+\tvoid *data)
+{
+\tsize_t i;
+\tint ret;
+
+\tfor (i = 0; pmu_events_map[i].cpuid; i++) {
+\t\tsize_t j;
+\t\tbool found = false;
+
+\t\tif (!pmu_events_map[i].metric_table.pmus)
+\t\t\tcontinue;
+\t\tfor (j = 0; j < i; j++) {
+\t\t\tif (pmu_events_map[j].metric_table.pmus ==
+\t\t\t    pmu_events_map[i].metric_table.pmus) {
+\t\t\t\tfound = true;
+\t\t\t\tbreak;
+\t\t\t}
+\t\t}
+\t\tif (found)
+\t\t\tcontinue;
+\t\tret = fn(&pmu_events_map[i].metric_table, data);
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\tfor (i = 0; pmu_sys_event_tables[i].name; i++) {
+\t\tif (!pmu_sys_event_tables[i].metric_table.pmus)
+\t\t\tcontinue;
+\t\tret = fn(&pmu_sys_event_tables[i].metric_table, data);
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\treturn 0;
+}
+""")
+
+
 def print_system_mapping_table() -> None:
   """C struct mapping table array for tables from /sys directories."""
   _args.output_file.write("""
@@ -835,6 +886,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
     if metric_tblname in _sys_metric_tables:
       _args.output_file.write(f"""
 \t\t.metric_table = {{
+\t\t\t.name = "{metric_tblname.replace('pmu_metrics__', '')}",
 \t\t\t.pmus = {metric_tblname},
 \t\t\t.num_pmus = ARRAY_SIZE({metric_tblname})
 \t\t}},""")
@@ -848,6 +900,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
       continue
     _args.output_file.write(f"""\t{{
 \t\t.metric_table = {{
+\t\t\t.name = "{tblname.replace('pmu_metrics__', '')}",
 \t\t\t.pmus = {tblname},
 \t\t\t.num_pmus = ARRAY_SIZE({tblname})
 \t\t}},
@@ -856,7 +909,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 """)
   _args.output_file.write("""\t{
 \t\t.event_table = { 0, 0 },
-\t\t.metric_table = { 0, 0 },
+\t\t.metric_table = { 0 },
 \t},
 };
 
@@ -1486,6 +1539,7 @@ struct pmu_table_entry {
   print_mapping_table(archs)
   print_system_mapping_table()
   _args.output_file.write('/* clang-format on */\n')
+  print_metric_table_functions()
   print_metricgroups()
   _args.output_file.close()
   if _args.output_string_file:
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index d3b24014c6ff..9cac617c9702 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -112,6 +112,10 @@ size_t pmu_events_table__num_events(const struct pmu_events_table *table,
 
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				     void *data);
+const char *pmu_metrics_table__name(const struct pmu_metrics_table *table);
+int pmu_metrics_table__for_each_table(
+	int (*fn)(const struct pmu_metrics_table *table, void *data),
+	void *data);
 /*
  * Search for a table and entry matching with pmu__name_wildcard_match or any
  * tables if pmu is NULL. Each matching metric has fn called on it. 0 implies to
-- 
2.54.0.823.g6e5bcc1fc9-goog


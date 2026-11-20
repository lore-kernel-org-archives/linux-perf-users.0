Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212941;
	b=c36L5t8yN4NPct2VPAtYIYW3+6ISx/Mk7bSc8aYqjmkIvNgHs+RsXnNuQXSdd8kJz912
	 xgPn1HDH0ih68s9s3RgTXZrzTrq84+SOuPENwEEHg8OWe032cQlTxrT1liSibCGPPkbIP
	 yUU9IoffdezjtC6vE0+0ZiHvw+FTzTrdIh4bvykAFknMKEhehwJ4/400i009cKXifYBuZ
	 PE7Zkr1EWNv7+rBlJTxaEcI8pcCFnrKKvXmYvFJiPY8ovo8XH9jPptPARHj6ZtT4KEE0V
	 N4ev7hvn2/4miuZ4asshZTJPo1LoULsrqRKELO136hwpxbvpRlRfAinhZFbWuUYsQcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=R1UF6Qvsf9rHsUsHz66iYR6vOcaKtGQgcscSxSyNv1o=;
	b=AsrYSJYVVFT1EOe1qemh2uBT5crLq9jw8gqBRTdcqX4jpikkRvpaUxp6bwAwjpgvgNP+
	 xZahVNaffDAxzdHTec/LTybv5FNsVXcLyuhiUnTq4XohBZp0IVNXvj2TqzUH9xcNa0sML
	 ud1ZIDNQcmWxoUNDhB0xcQ67tsnJKT7SgpFEIZjc5NK70lpyTFJ6uy5nYdoUuqPnjnQBn
	 PqleeNsbDvLRgULzxkCGIzbM+XP/Olnm9rdVkXhRQ0eNwdbzXJ+tY7Vn1e8qykMCuKRvC
	 7EZSzu3iqxkG1ZAZeRx81j166RoVFLE8g/AHtLfu9OIKCtlS9BGWEuh99zx5ubLkTUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M7AwjeUb;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC73606A6A0
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DC73606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M7AwjeUb
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2f04561ee04so7973475ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212932; x=1795817732; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R1UF6Qvsf9rHsUsHz66iYR6vOcaKtGQgcscSxSyNv1o=;
        b=M7AwjeUbXT0ZZXEyxdOUQV3zcIuz4+bw8cGD5kgioaKdEY4e/OnIj7iRKCgVpBqQIe
         hHQSW2NbVX8HY5UO1YleBPggfVPYCfMEpvr9918wU/DC2BJmsHslm9TxKrToNJN7TmW8
         iAfthZxkqBvWcGB1EUGxHQnS0q/1oXFWf1EDN0y9HleRrSYMF0CWa1PnwlXkI1rpQSzO
         g6gglNhtkN4QksU0ugtlIoGHGoWbtyoOj7+JfqThGBQbPIXsDCKGKcP2UphcuUj5KDAS
         6AQkGGo+8i80lmit1UaO+o68H1TESFEK9kTA2sggb05aDETRXHcmDb3FOkWuqu9VdzEV
         RgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212932; x=1795817732;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R1UF6Qvsf9rHsUsHz66iYR6vOcaKtGQgcscSxSyNv1o=;
        b=Lc33z7VmT4+v+E7PQdNRg9vc51lIsn/n12DOHMsR2NRiDO/YAwNzNrm0AcFJKZQHdi
         shW5xFIKnBb2Lt5LMNMrzLQwFsjD3acHiY2jaP6Xi8EZqAEcWlurJFs9Ipph17jRZYSk
         C8X5AON8e93jhF0+CBmyfgoAp5pAV6dlwVkC3Zkz5pvYSfe36RHGYZCLMdWWt0Dfm/RH
         V+H9g3LkQ9fHxaoTbALCdz4t+jvNaOhUdxwhIpglGC4cqdasg8HgVV1p3NREn8LRszKx
         1opJogCUqr9mS6uMADzQ0ykMdmfhQrxyy7RB+ih++ENJ3p4rIUwisdunG7WNP3dEnJgz
         3ABA==
X-Gm-Message-State: APuU4Z8nzlqUgRaperJcTavoaqRK2/U+VYvullgCNfhrSPC6sMNApDgE
	xKJ36Hb80PaCXRYtr33ECco/9zkvIfmC6cTWkC0pL2zkiBheBcyuCc7HOl9SgDJ/cU5KBvVgTv4
	jRv2Zo83ElA==
X-Received: from plhc2.prod.google.com ([2002:a17:903:2342:b0:2f0:3edd:f273])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c4:b0:2f0:422a:222d
 with SMTP id d9443c01a7336-2f0422a30dbmr40073615ad.22.1795212931273; Fri, 20
 Nov 2026 14:15:31 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:23 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-23-irogers@google.com>
Subject: [PATCH v3 22/30] perf pmu: Add perf_pmu__for_each_name_from_config()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf_pmu__name_from_config() returns the first event alias of a PMU
whose parsed config matches, ignoring the perf_event_attr type. So a
legacy hardware event alias can be returned for a raw config of the
same value, only one of possibly several names is found, and the names
of legacy events whose aliases were replaced by sysfs or json events of
the same name can't be found.

Add perf_pmu__for_each_name_from_config() that calls a callback for
each event name of a PMU whose encoding has a given type and config,
ignoring the extended PMU type of legacy encodings and, for core PMUs,
also searching the legacy hardware and cache event tables. Make
perf_pmu__name_from_config() return the first such name for the PMU's
type. Also fix pmu_config_term() leaking help_msg when err is NULL, as
called by perf_pmu__parse_terms_to_attr().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 106 +++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/pmu.h |   3 ++
 2 files changed, 102 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d319ef8ffbb8..b4541fbfc9c0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1617,6 +1617,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 		} else {
 			pr_debug("%s (%s)\n", unknown_term, help_msg);
 			free(unknown_term);
+			free(help_msg);
 		}
 		free(pmu_term);
 		return -EINVAL;
@@ -2821,25 +2822,116 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	free(pmu);
 }
 
-const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
+static bool pmu_config_equal(__u32 type, u64 a, u64 b)
+{
+	/* Ignore the extended PMU type in the upper bits of legacy encodings. */
+	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)
+		return (a & PERF_HW_EVENT_MASK) == (b & PERF_HW_EVENT_MASK);
+	return a == b;
+}
+
+struct legacy_name_args {
+	__u32 type;
+	u64 config;
+	int (*cb)(const char *name, void *data);
+	void *data;
+};
+
+static int pmu_legacy_name_cb(const struct pmu_event *pe,
+			      const struct pmu_events_table *table __maybe_unused,
+			      void *data)
+{
+	static const char hw_prefix[] = "legacy-hardware-config=";
+	static const char cache_prefix[] = "legacy-cache-config=";
+	struct legacy_name_args *args = data;
+	const char *prefix = args->type == PERF_TYPE_HARDWARE ? hw_prefix : cache_prefix;
+
+	if (!pe->name || !pe->event || !strstarts(pe->event, prefix))
+		return 0;
+	if (!pmu_config_equal(args->type, strtoull(pe->event + strlen(prefix), NULL, 0),
+			      args->config))
+		return 0;
+	return args->cb(pe->name, args->data);
+}
+
+/**
+ * perf_pmu__for_each_name_from_config - Call @cb for event names of an encoding.
+ * @pmu: The PMU whose event names are searched.
+ * @type: The perf_event_attr type of the encoding, such as the PMU's type or
+ *        PERF_TYPE_HARDWARE for a legacy hardware event.
+ * @config: The perf_event_attr config of the encoding.
+ * @cb: Called with each event name of @pmu with the encoding, a non-zero return
+ *      stops the iteration.
+ * @data: Passed to @cb.
+ *
+ * As event aliases from sysfs or json replace legacy event aliases of the same
+ * name, the names of legacy hardware and cache events of core PMUs are found
+ * from the legacy event tables. @cb may be called more than once for a name.
+ *
+ * Return: 0 or the first non-zero value returned by @cb.
+ */
+int perf_pmu__for_each_name_from_config(struct perf_pmu *pmu, __u32 type, u64 config,
+					int (*cb)(const char *name, void *data),
+					void *data)
 {
 	struct hashmap_entry *entry;
 	size_t bkt;
+	int ret;
 
 	if (!pmu)
-		return NULL;
+		return 0;
 
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
-		struct perf_event_attr attr = {.config = 0,};
-		int ret = perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr);
+		struct perf_event_attr attr = { .type = pmu->type, };
 
-		if (ret == 0 && config == attr.config)
-			return event->name;
+		if (perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr) ||
+		    attr.type != type || !pmu_config_equal(type, attr.config, config))
+			continue;
+		ret = cb(event->name, data);
+		if (ret)
+			return ret;
 	}
-	return NULL;
+	if (pmu->is_core && (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)) {
+		struct legacy_name_args args = {
+			.type = type,
+			.config = config,
+			.cb = cb,
+			.data = data,
+		};
+
+		return pmu_events_table__for_each_event(perf_pmu__default_core_events_table(),
+							/*pmu=*/NULL, pmu_legacy_name_cb, &args);
+	}
+	return 0;
+}
+
+static int first_name_cb(const char *name, void *data)
+{
+	const char **first = data;
+
+	*first = name;
+	return 1;
+}
+
+/**
+ * perf_pmu__name_from_config - The first event name of @pmu with @config.
+ * @pmu: The PMU whose event names are searched.
+ * @config: The perf_event_attr config of an event of @pmu's type.
+ *
+ * Return: An event name or NULL if none was found.
+ */
+const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
+{
+	const char *name = NULL;
+
+	if (!pmu)
+		return NULL;
+
+	perf_pmu__for_each_name_from_config(pmu, pmu->type, config, first_name_cb, &name);
+	return name;
 }
 
 bool perf_pmu__reads_only_on_cpu_idx0(const struct perf_event_attr *attr)
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 7605c3859337..ab7123964423 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -365,6 +365,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
 void perf_pmu__delete(struct perf_pmu *pmu);
 
+int perf_pmu__for_each_name_from_config(struct perf_pmu *pmu, __u32 type, u64 config,
+					int (*cb)(const char *name, void *data),
+					void *data);
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
 bool perf_pmu__is_fake(const struct perf_pmu *pmu);
 
-- 
2.56.1.750.gf70dc682cf-goog


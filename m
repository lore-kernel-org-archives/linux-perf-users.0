Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599678;
	b=qE5dNcxcLKN3apzA4Cq1hRH+C33LqQRh27y94vtSvjDM+IKj6bd8Ao8LlD5+sKb1ueMK
	 nEQeKQi/hI0ug0pUmUvof2GFdl25RjXf8Jtx/o8G19a7Du9sPGGMQibz8vVCITDwAX8Ky
	 N55AV+YckELFOdzFDcwT9L1lT6bTQzXYD73g9PKVzQ6UTGQYWgcJFJ8anLJY29Fs8gGp1
	 lve2o6hdb57yyWzVfeg/+4NunJgQku8xZ11lTOGqbECBJRUE3kkEhI2ADJzIUrdIsw2yQ
	 zaJlrw/jeoJtf388PDtzyiTvEVgkE4VnkZurnV8lVUTV8TKtFGBCWyXMEeeQINdD9jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=uPTlkM2M34BsUT9MIUEkDvonTF4briUNShvScJlkKZ4=;
	b=Zczm2CqH0648z81C9i2pabJM8rKD1saZ8xRD6g9TU8BJXFHrrm6RxcQSAq6FHWn8ZAM3
	 zsnDyqDP59XJNb5gs8ocb1OkPAvJVTNghFSOkoga5l+tofovhFrb50DtorkYNqX9npBW+
	 8MYkKUsGF+xUifyJHRx8sX1cNfGuQBHx7xEaHns/t2hW1zoB/cUK0kG21zAaYe6PUaJe+
	 CVirE5qnYMeHQ7fIkikTMxw10bqRLbwwpsbnpYXhsEoBINHfrIgViyv0z+FBEQ/8Hx+OQ
	 GSr/3rjLNGCuNb4ncUzpg+ZXRkyOxMERFVVL50RDNeNG73lNS/F6InKMEGh4hW4fI2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nHk69dhr;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CC60A2624
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E16CC60A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nHk69dhr
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-37549877380so1704576eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599677; x=1795204477; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uPTlkM2M34BsUT9MIUEkDvonTF4briUNShvScJlkKZ4=;
        b=nHk69dhremRAtpwxv0L7bWakP8cvO1v+lQCjMvvM+TnRaqeKWrIJc+NVieHvnJGw9M
         Gf3nWDltFMArL1Zzdx/fKaEzcitw/tkW+xcarbutB44biTOfpLEkSqmbawMAR9bRSNq6
         6stak2gB7W5PX+sL65OPS2khCqtBfAxDszBjWmr6FE+Q9ZXlBAIhUFaPdyAbDdLqerKy
         ci7ajsSnSTWe1OR1RII/HGIPeSdz9VLPulVEIoqrHo8DNIwx4w0CkxGxrmuGUp5GRU0X
         fK1CngKoC6fZk/lD2ID3LTEMya5m/+HhhVbz7FyeWZDbp6yZWYqhuAkySyFi2WTAQuJp
         aY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599677; x=1795204477;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uPTlkM2M34BsUT9MIUEkDvonTF4briUNShvScJlkKZ4=;
        b=pWBiSxkJM8QbI2nnQU+vssz1BSuPr3APJfPDbJatVrnkCTROxQW49iw0TbBbezh3Kv
         mf9k+54MYZh1JO4r3rrG2ja79Qwr6Fuh1czuFtUkrcPpfWlqv/WF57RU6Gh595zqdsC3
         iVfopRa4TOhBQirwJ3Xl5Y+nrwe1Nh7Za8AzOuQKEBOkv4d5nWuH5W0PIOnDpdS004Th
         ilFfKuN2I6it8d493D+2xhOo720MxQ31sP77CX2x6DbMtaWRjzEtxTrJilKvv/8LaQgi
         T5NZ+PAI15cEeBYZnnmLM7sMXCFpd4pSSiIuf+iBEu7rPZY+qc1RqkQyi3LOUOgkhU1b
         ad4Q==
X-Gm-Message-State: APuU4Z/aWSMzlPdOpPocA9nKiV+eYbGzDykR/g9BAQHK/PzCjdhYVWCn
	tTdMshm++KM9kppcpJcMQ5FwbMQVzFJPBQjtNdnyg/9/fPwo15fp2Jjiinz5+eswsjIF83Q684Q
	ktJmlh0eRNw==
X-Received: from dycuf5.prod.google.com ([2002:a05:7300:105:b0:351:1da6:c2e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cc9c:b0:371:5cb0:4929
 with SMTP id 5a478bee46e88-37967dd4c20mr3103906eec.25.1794599676646; Fri, 13
 Nov 2026 11:54:36 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:27 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-23-irogers@google.com>
Subject: [PATCH v2 22/30] perf pmu: Add perf_pmu__for_each_name_from_config()
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
type.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 105 +++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/pmu.h |   3 ++
 2 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d5384c074265..381189acfd4a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2812,25 +2812,116 @@ void perf_pmu__delete(struct perf_pmu *pmu)
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
2.56.1.703.gf848ed807c-goog


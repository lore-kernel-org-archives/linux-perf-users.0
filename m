Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749557;
	b=PepNZBbnMWgrd9T150aSJekc8gkSVnnj7ajxuHehKVeA5H77GgT5Axvj5gMKRZnweAYn
	 WMPVirMEqlbPjKG7oAAUCeIsx1HvmyoSca9jg2WhAihPaTswhYmgID9Bhvj+eLm6QuAMb
	 EqR6D73WaGBGy6V24iRxl+J5rszsP7voKzwq8VTNMgq69IXroYUsTb+FsDYpfwpF3OLSO
	 Myi0Lbs7lQY+9RVNf0uJOgcMTb9KPBkH/jIeBViGf/GD5/gw+JqkpDqd06IrM7/IuFB7N
	 55KLA1at2jj48BTDlX68Q0NfZpk39ZsfqZhswjbULgqqI+FY14fh8VHsJBr2dgkkMqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=OFuGN5P3Lx4JQ5sN0dyHzFMj7AP34MEOJtQAERKynfA=;
	b=GUzjmjWSx529lgN4WgmED5MSPqu0b6YupQmr2CRvIts22mxsnQ82xPLjzifpASi0q0vd
	 3ixvi637CJVFLYoOG3Ofkf6ARKr6agXCIt4wT3zmzCLBNxN/b3S/ZeOPRuReumCJtDEzO
	 M0zVShpTHjvVxOsJT62g3cKYsLlbQvA3lEscTlfGG4WWa1tlK8hvtDpsU2Zj+rbbbT/+j
	 0M+3ZBKm1JtutTDixxuZnQfAnVdtAGqyhHXPEm/e8vpm73K74j2+zx8MBEy/2V++9j+4e
	 Axx3GpimZAYbO+kHw1jTs/QGH1jVH7qGhLeMPqHtcy2pr4vBicZt9xHPPcN+i+NYTgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TafVSmK8;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B645606D837
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B645606D837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TafVSmK8
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b20a4b5f2bso240156c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749556; x=1794354356; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OFuGN5P3Lx4JQ5sN0dyHzFMj7AP34MEOJtQAERKynfA=;
        b=TafVSmK8MOshU5CzNFd4/YRTUmmsbrrIeXRzZdwyBj2L6ky14hSvQusYFEpJ+Us/70
         rb+43qrO4FPLddtVHwarf5elY5+CIOL+/REPrVX+1D3VqVVj918pTluoME8dD9ZXhqJU
         W6C28L2uLGMfxXz7Iu5A9aFs7WeI/VgZIPx95fxqauu5unUCDMAf1VmNWM6CoabYy4Rq
         guWgT97rQckozQeVidrI2GL/capY/MlawvPVPc5w05bwBO84TZl/jt3nI6UxdWccty64
         ZyuUsqjXAAkrF7xH9TYPOKdef9sj8ppP4HWa6Vo7rhuvvQdbCHfqoZVSePRR+dYfZAoL
         r4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749556; x=1794354356;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OFuGN5P3Lx4JQ5sN0dyHzFMj7AP34MEOJtQAERKynfA=;
        b=XPRetQxUyDmYZ0a2ccMYUFx98tG7DfDNAjMyBMcT+SYFRRE93jVdtuWZr4No/tvNvS
         /8l1W+u3JMQONMNz6OgDj+F232N2eQnwWadBoGMd+SAS6L9bWHui/o6lC+6FXNDuRhzW
         6fpRT293A4uNaNRjRby9U61gbvaJXf/m9qblLNCXSa2N/DMP0ktly6UegZygt1JHoiDQ
         m0wOPrU6jObV0L2LChBuz5arfPn6D3o/4/2MfM1ZoZdnC81SFn6iRAJAs54sxrYlw9BO
         3vRVu3WaYNJCrJEjl1h64Ktk/KXLJFaH0m+nLvyK6FShXylGILB2MgI+/cDQZw81TraI
         pWWA==
X-Gm-Message-State: APuU4Z/qYDeKimhW7YaNws+FQ2gGz60/Pk+96Z5btnsxew4eUX5SCmAL
	BUumIqesW3taWDJPuK/viVVTo2CU8tFNzl9xCfy+bLsO3vJwpLgWycDImf14qV3CvGkE9jmQvC/
	oPBShTpOJi9h25aYNPf0XSqD6Ue5BfANK+Mzr+NUERUnx1lrMi66InbQbj+BV0jY6kgdZIKgnuD
	FqyTRKm3sI78IyCS2yUqq/vEC4iY0sWYKz70EL41Ql21U56JbZxRAr0/U=
X-Received: from dlbvg21.prod.google.com ([2002:a05:7022:7f15:b0:1a7:76f5:9d46])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1101:b0:195:1a77:85cb
 with SMTP id a92af1059eb24-1ac57454ee8mr20378439c88.1.1793749555759; Tue, 03
 Nov 2026 15:45:55 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:34 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-19-irogers@google.com>
Subject: [PATCH v1 18/41] perf pmu: Add perf_pmu__for_each_name_from_config()
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
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
index ee52fd18c927..fecfe791bf8a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2840,25 +2840,116 @@ void perf_pmu__delete(struct perf_pmu *pmu)
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
index 06f922ce1f68..b556ec51fdeb 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -374,6 +374,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
 void perf_pmu__delete(struct perf_pmu *pmu);
 
+int perf_pmu__for_each_name_from_config(struct perf_pmu *pmu, __u32 type, u64 config,
+					int (*cb)(const char *name, void *data),
+					void *data);
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
 bool perf_pmu__is_fake(const struct perf_pmu *pmu);
 
-- 
2.56.0.385.gac671c819a-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213592;
	b=XFDaFJS5eoC/RSNi2Z1PDJYxQamr+fJGRTTTso6eewSgmOX0a7pZvvKpPlKvqVpH7xeK
	 aJocp6x7X9j6CTGMEesQI6iwXONBg+xGt6Fbqsw34nKLhP23qOvFV0Jxbj6H6Gq60b5Ew
	 61VKSqp50tBxVzrq/FdPVEGaGzhVQgW+JiKfHcogKaoXx1xgxrw760KSTlThdYY8wU6es
	 qIMU0bCWDiNoBB93C7q2QxHVc3D9H85KpcBbUT9sTplekF7qLUuzmRFZyPfDdqmfcAtVG
	 bLPbh7lddr9XpMaWKu7pnAtx34nqXiMHk/9RjXGWKtT4j9XdbLxaZVFKcyU+KWrygJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=GPF4x0oxyi0FzbmxY2Z7wtQBPD7a4tTfLQmJ4F4D3Rk=;
	b=CBrWEP+DUBeH00HAvQ37GuCNGs5og2gdYcWGBt/Hec00YyCbNjGdkevatxlN2537bJ+n
	 qrnzp6dVsrQR38yR4oVxWEIxLk0HDQEvFBNsrjxDwM28JBIbUvtnqJEr1eVbHzzuMgQue
	 iQx2KA8Fw6L8ATRt/eblwwYsnXHXcwZS+UAMM4NFTCftvmasGWJkC2vGgKi7ElG07Frsb
	 HN/OneHIjrT/mKChoqv1A43ldfr2ddA90H+RZX9Y1BeZfebgGspDdjq4NenqrwVyQ8a2j
	 BpVLoLhnBJ3vIhvNxHp0hm8fjyIS1WVfqCWVmmfkOtu72IQbLjJp5y+J2FxSLphGbKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Z8h/IfLj";
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC4606A69F
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94AC4606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Z8h/IfLj
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so3638409c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213590; x=1795818390; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GPF4x0oxyi0FzbmxY2Z7wtQBPD7a4tTfLQmJ4F4D3Rk=;
        b=Z8h/IfLjq0j6Zelu8ZSjSiwq2kNSjFqOpK5r+cpdHK5yRGQZcYBciehNgImNkAdsvv
         UMH9YsbaSLjhLRng/iXNjmp+Iv80YqIaJlWpniouKAEpoQrr7An1tKTde0Q89hnBvqNF
         y75tM5uCv03ZSpIsqw3bO9OjYgslDH9j7pZT7EupRGzNrUFQRZaenlM8kZj5aR6wdvIs
         gQK9DlOxab+rKSE5dR3ffuC4OpyYscMDbnVyFrt3QDfCu5fmbmx8CZ2Uo5QcnR6rFBZV
         DWXo8AdN20390HZ1tRG9fvmM6ECPnAg0aLR/o4e5bwKei7Pmri91JlAP78P+isNQI2Kl
         StWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213590; x=1795818390;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GPF4x0oxyi0FzbmxY2Z7wtQBPD7a4tTfLQmJ4F4D3Rk=;
        b=s2labwu4zllVtsN6f5Ri55tLxB3IadjSh1NRCZ49S04aWrUXIZ3NQSDBl1TzIuZTU4
         xerSKq4quY6EME/asPsWOBvSdS9bxN1QFgnc2UTO4e1rsYFvueRkImZYPyxCaqGP+Yqj
         L28CpeKgvX8egr80ZRe6LKj/vuZwGZHsimUuLfOHHNrmsAeHrYKlEyFO7Bx84RG92nGG
         Sr2tbpfpQ+JkgzjPmtrILFobcCcvl3g1ap+wIP6H1aBfmTG99n2TieDtbFdjP/impTdJ
         LdvJSSD4AtpJpuR9BBV0j/PzgFURpFH5hF8qJoiccM8Pv3KSB3Ec+EtqWm08dvEgfqom
         mcnw==
X-Gm-Message-State: APuU4Z83beih3ERn2+rPqZIhcLQgDJlqabBg1qkVXz6VCmcgu3Ri9zo/
	NdsVQ+6nFMz0hTqmgUaAnSL64tYQ1aqn5C1uybBL9v/873KUP38HfF0GX0QRcW0EmFL/diaA6kv
	YVa7v1czD9Q==
X-Received: from dlaj4.prod.google.com ([2002:a05:701b:2804:b0:1a1:3ce6:560b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:a8b:b0:1b3:af3a:e784
 with SMTP id a92af1059eb24-1b5568fe775mr4701267c88.32.1795213588718; Fri, 20
 Nov 2026 14:26:28 -0800 (PST)
Date: Fri, 20 Nov 2026 14:26:00 -0800
In-Reply-To: <20261120222615.2291168-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120222615.2291168-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120222615.2291168-2-irogers@google.com>
Subject: [PATCH v3 01/16] perf pmus: Expose duplicate uncore PMU scanning helpers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Export perf_pmus__scan_skip_duplicates() and add
perf_pmu__num_duplicates() to count numbered PMU instances sharing a
common prefix (such as uncore_imc_0..uncore_imc_7) so subcommands like
'perf sysinfo' can collapse duplicate uncore PMUs by default and report
their instance count.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 26 +++++++++++++++++++++++++-
 tools/perf/util/pmus.h | 21 +++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index c5ef22ef00dc..96c96211f577 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -508,7 +508,7 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmus *pmus,
 	return NULL;
 }
 
-static struct perf_pmu *
+struct perf_pmu *
 perf_pmus__scan_skip_duplicates(struct perf_pmus *pmus, struct perf_pmu *pmu)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
@@ -545,6 +545,30 @@ perf_pmus__scan_skip_duplicates(struct perf_pmus *pmus, struct perf_pmu *pmu)
 	return NULL;
 }
 
+size_t perf_pmu__num_duplicates(const struct perf_pmu *pmu)
+{
+	const struct list_head *head;
+	const struct perf_pmu *pos = pmu;
+	size_t base_len;
+	size_t count = 1;
+
+	/* Core PMUs are never duplicates, see perf_pmus__scan_skip_duplicates(). */
+	if (!pmu || !pmu->pmus || pmu->is_core)
+		return 1;
+
+	head = &pmu->pmus->other_pmus;
+	base_len = pmu_name_len_no_suffix(pmu->name ?: "");
+	list_for_each_entry_continue(pos, head, list) {
+		size_t pos_len = pmu_name_len_no_suffix(pos->name ?: "");
+
+		if (pos_len != base_len ||
+		    strncmp(pmu->name ?: "", pos->name ?: "", base_len))
+			break;
+		count++;
+	}
+	return count;
+}
+
 struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmus *pmus,
 					       struct perf_pmu *pmu, const char *compat)
 {
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 2b784cf648f3..44b5dc2fd36c 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -134,6 +134,26 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmus *pmus, struct perf_pmu *pmu);
  */
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmus *pmus, struct perf_pmu *pmu);
 
+/**
+ * perf_pmus__scan_skip_duplicates() - Iterate over PMUs in @pmus, skipping
+ *                                     numbered duplicate instances of
+ *                                     non-core PMUs.
+ * @pmus: The PMU collection to scan.
+ * @pmu: Previous PMU returned, or NULL to start from the first PMU.
+ *
+ * Return: Next distinct prefix struct perf_pmu, or NULL when done.
+ */
+struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmus *pmus, struct perf_pmu *pmu);
+
+/**
+ * perf_pmu__num_duplicates() - Count consecutive PMUs sharing @pmu's prefix.
+ * @pmu: Representative PMU returned by perf_pmus__scan_skip_duplicates().
+ *
+ * Return: Number of PMU instances (including @pmu) sharing its base name,
+ * always 1 for core PMUs.
+ */
+size_t perf_pmu__num_duplicates(const struct perf_pmu *pmu);
+
 /**
  * perf_pmus__scan_for_event() - Iterate over PMUs in @pmus that have @event.
  * @pmus: The PMU collection to scan.
@@ -260,6 +280,7 @@ struct perf_pmu *perf_pmus__add_test_hwmon_pmu(struct perf_pmus *pmus,
  * Return: Pointer to the fake struct perf_pmu.
  */
 struct perf_pmu *perf_pmus__fake_pmu(void);
+
 /**
  * perf_pmus__find_core_pmu() - Return the first core PMU in @pmus.
  * @pmus: The PMU collection to search.
-- 
2.56.1.750.gf70dc682cf-goog


Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F401860
	for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715646514; cv=none; b=ateeZvIe/QlYHyOrgrXGyrI1/p+hHrBmoXRlW94LdQrytlvApe3YrHHN81jquufJucAQgezXLLPDV69XStHOdonYoNmTXhZY0fLlSj4AKKVDmJKuUVgKJt5/Pw5ExSuAT2pjmgr8OPf7UIcyA0TEndrGjg1rKampt6bfw/8RgBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715646514; c=relaxed/simple;
	bh=2XAXI/NIOGGn+CKQib3Ud247MltyKS7rdmpk2qYDLXs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VE2wkQlnVro55ZFHGNyeNw/A6HHrz0yWw2Wc9B6OV1nbQTCKL45H5pLNnZ7d6+Pw/YcgngmvAaxCt8qlbhv9HRhPmMBgdArlgCDKp8DeWcnEgNPixT1IMFpr39hKN3rY0sR9wCntE8R8crtvGmI83JQ7hgxvTH1c84OFC9RZ4RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSLkVRcs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSLkVRcs"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be3f082b0so86695727b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 17:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715646511; x=1716251311; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x8lh3KbE0/fEXElvACYYQQAv22H8HgUlGcjaTiRjDdY=;
        b=FSLkVRcsinCMQ5+up/GgGAzp60L9GT0kktqdKgYg7ogvOBZ6qq2j+P1vFQp0CR+7sK
         9c12WDOxgC+pMBKgFmuSaI0KrRykidIkt2VUVWnAd2bX0RnZaegzf2PK/kqFCJT1H5b/
         gJTvGDAYVa5OrlJYspHof8hjzXvD3tBP6pDgGccqr38apyMGVmJAZYWsAXY04SKYVMcM
         BfRVEdJ214TLyCybed+/gOKGlohiEWK1nnrZsvZNUjZaSbz9QHISXWb1X8Wo9uzy1Dzs
         UIkph5XRd5qiDwH497okW5mjRyRit1iRzqaSsgT5QIYWYf1AsgPMYN+JKN8oZ6CoxtZS
         EHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715646511; x=1716251311;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8lh3KbE0/fEXElvACYYQQAv22H8HgUlGcjaTiRjDdY=;
        b=VOETm0TgnFaTOIET4xgOSCNqYpdVWuSiNf6kkA/GqYT5Nnng+iPeNJtrkoVXfkU0Tf
         u5hvZmqlbPCkVM47K4UrJDZ/7y8W06UwVM33cw+kmxHdeU4DScu85U2AVExSfEuBhBNM
         RLqDSg4R7xqrTQa5UtiB6ifVdoqHi6Qr4qp0nmusa1zCi79gl35/V8NlT7xK1nJqmFy3
         Qba/Sfu9gitKFunI40YczzhQrXYA913xsDEltQFfWiq24Bf6AW+DO2kGIZZcEIwZvfh7
         vNSsJk+FW4ZIV9n/Sae+Tzo5eyKQ63hEjuRD/IJbgGKfLpkIa3d7sFqGdiAF+dpWo2b4
         eU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpGtuM6E7825719otSWOt6rivFiHHJqqpdXPKbJ2JO3q6dookT1YpHoqWQTfgSjpTDsYtSi9JLdJ5XZTBdJKCtEx11b1IdfkQt11Y5q+Zshg==
X-Gm-Message-State: AOJu0YwxbPNKzcBFJgUiufPDLVXJw58buK6MFUhZnI1lpCz6rVAPDL4m
	nfQkXUZ/w3KZ4aF7FdySLPFAVj1eK62k38G/jUQsCcvTMjOPPnUlR6AsVEvRiYP5MLXvHMRQ2qJ
	uxUEUYw==
X-Google-Smtp-Source: AGHT+IFaIojszq5ATydBFCXcwuPqNlZ+m4KY7jTWj6GHtvpAP5G+VY4ApNYOxGTqwqMiJvyHfuDfww1xR+mv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6e66:3031:b400:2dc8])
 (user=irogers job=sendgmr) by 2002:a05:6902:1205:b0:de5:60b6:fb9 with SMTP id
 3f1490d57ef6-dee4f334d41mr1021375276.1.1715646510837; Mon, 13 May 2024
 17:28:30 -0700 (PDT)
Date: Mon, 13 May 2024 17:28:16 -0700
In-Reply-To: <20240514002817.2896240-1-irogers@google.com>
Message-Id: <20240514002817.2896240-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240514002817.2896240-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v5 1/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
From: Ian Rogers <irogers@google.com>
To: Tuan Phan <tuanphan@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The mrvl_ddr_pmu is uncore and has a hexadecimal address suffix while
the previous PMU sorting/merging code assumes uncore PMU names start
with uncore_ and have a decimal suffix. Because of the previous
assumption it isn't possible to wildcard the mrvl_ddr_pmu.

Modify pmu_name_len_no_suffix but also remove the suffix number out
argument, this is because we don't know if a suffix number of say 100
is in hexadecimal or decimal. As the only use of the suffix number is
in comparisons, it is safe there to compare the values as hexadecimal.

Only allow hexadecimal suffixes to be greater than length 2 (ie 3 or
more) so that S390's cpum_cf PMU doesn't lose its suffix.

Change the return type of pmu_name_len_no_suffix to size_t to
workaround GCC incorrectly determining the result could be negative.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  | 17 +++++------
 tools/perf/util/pmus.c | 67 ++++++++++++++++++++++++------------------
 tools/perf/util/pmus.h |  7 ++++-
 3 files changed, 53 insertions(+), 38 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 888ce9912275..f359354070fa 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1788,10 +1788,10 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 			  const struct perf_pmu_alias *alias, bool skip_duplicate_pmus)
 {
 	struct parse_events_term *term;
-	int pmu_name_len = skip_duplicate_pmus
-		? pmu_name_len_no_suffix(pmu->name, /*num=*/NULL)
-		: (int)strlen(pmu->name);
-	int used = snprintf(buf, len, "%.*s/%s", pmu_name_len, pmu->name, alias->name);
+	size_t pmu_name_len = skip_duplicate_pmus
+		? pmu_name_len_no_suffix(pmu->name)
+		: strlen(pmu->name);
+	int used = snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
 
 	list_for_each_entry(term, &alias->terms.terms, list) {
 		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
@@ -1828,13 +1828,12 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
-		size_t buf_used;
-		int pmu_name_len;
+		size_t buf_used, pmu_name_len;
 
 		info.pmu_name = event->pmu_name ?: pmu->name;
 		pmu_name_len = skip_duplicate_pmus
-			? pmu_name_len_no_suffix(info.pmu_name, /*num=*/NULL)
-			: (int)strlen(info.pmu_name);
+			? pmu_name_len_no_suffix(info.pmu_name)
+			: strlen(info.pmu_name);
 		info.alias = NULL;
 		if (event->desc) {
 			info.name = event->name;
@@ -1859,7 +1858,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 		info.encoding_desc = buf + buf_used;
 		parse_events_terms__to_strbuf(&event->terms, &sb);
 		buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
-				"%.*s/%s/", pmu_name_len, info.pmu_name, sb.buf) + 1;
+				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, sb.buf) + 1;
 		info.topic = event->topic;
 		info.str = sb.buf;
 		info.deprecated = event->deprecated;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b9b4c5eb5002..63b9cf9ccfa7 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -40,31 +40,52 @@ static bool read_sysfs_all_pmus;
 
 static void pmu_read_sysfs(bool core_only);
 
-int pmu_name_len_no_suffix(const char *str, unsigned long *num)
+size_t pmu_name_len_no_suffix(const char *str)
 {
 	int orig_len, len;
+	bool has_hex_digits = false;
 
 	orig_len = len = strlen(str);
 
-	/* Non-uncore PMUs have their full length, for example, i915. */
-	if (!strstarts(str, "uncore_"))
-		return len;
-
-	/*
-	 * Count trailing digits and '_', if '_{num}' suffix isn't present use
-	 * the full length.
-	 */
-	while (len > 0 && isdigit(str[len - 1]))
+	/* Count trailing digits. */
+	while (len > 0 && isxdigit(str[len - 1])) {
+		if (!isdigit(str[len - 1]))
+			has_hex_digits = true;
 		len--;
+	}
 
 	if (len > 0 && len != orig_len && str[len - 1] == '_') {
-		if (num)
-			*num = strtoul(&str[len], NULL, 10);
-		return len - 1;
+		/*
+		 * There is a '_{num}' suffix. For decimal suffixes any length
+		 * will do, for hexadecimal ensure more than 2 hex digits so
+		 * that S390's cpum_cf PMU doesn't match.
+		 */
+		if (!has_hex_digits || (orig_len - len) > 2)
+			return len - 1;
 	}
+	/* Use the full length. */
 	return orig_len;
 }
 
+int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
+{
+	unsigned long lhs_num = 0, rhs_num = 0;
+	size_t lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name);
+	size_t rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name);
+	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
+			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
+
+	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
+		return ret;
+
+	if (lhs_pmu_name_len + 1 < strlen(lhs_pmu_name))
+		lhs_num = strtoul(&lhs_pmu_name[lhs_pmu_name_len + 1], NULL, 16);
+	if (rhs_pmu_name_len + 1 < strlen(rhs_pmu_name))
+		rhs_num = strtoul(&rhs_pmu_name[rhs_pmu_name_len + 1], NULL, 16);
+
+	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
+}
+
 void perf_pmus__destroy(void)
 {
 	struct perf_pmu *pmu, *tmp;
@@ -167,20 +188,10 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 static int pmus_cmp(void *priv __maybe_unused,
 		    const struct list_head *lhs, const struct list_head *rhs)
 {
-	unsigned long lhs_num = 0, rhs_num = 0;
 	struct perf_pmu *lhs_pmu = container_of(lhs, struct perf_pmu, list);
 	struct perf_pmu *rhs_pmu = container_of(rhs, struct perf_pmu, list);
-	const char *lhs_pmu_name = lhs_pmu->name ?: "";
-	const char *rhs_pmu_name = rhs_pmu->name ?: "";
-	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name, &lhs_num);
-	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name, &rhs_num);
-	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
-			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
-
-	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
-		return ret;
 
-	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
+	return pmu_name_cmp(lhs_pmu->name ?: "", rhs_pmu->name ?: "");
 }
 
 /* Add all pmus in sysfs to pmu list: */
@@ -300,11 +311,11 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 		pmu_read_sysfs(/*core_only=*/false);
 		pmu = list_prepare_entry(pmu, &core_pmus, list);
 	} else
-		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", NULL);
+		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 	if (use_core_pmus) {
 		list_for_each_entry_continue(pmu, &core_pmus, list) {
-			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
+			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 			if (last_pmu_name_len == pmu_name_len &&
 			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
@@ -316,7 +327,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 		pmu = list_prepare_entry(pmu, &other_pmus, list);
 	}
 	list_for_each_entry_continue(pmu, &other_pmus, list) {
-		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
+		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 		if (last_pmu_name_len == pmu_name_len &&
 		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
@@ -566,7 +577,7 @@ void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, voi
 			.long_string = STRBUF_INIT,
 			.num_formats = 0,
 		};
-		int len = pmu_name_len_no_suffix(pmu->name, /*num=*/NULL);
+		int len = pmu_name_len_no_suffix(pmu->name);
 		const char *desc = "(see 'man perf-list' or 'man perf-record' on how to encode it)";
 
 		if (!pmu->is_core)
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 9d4ded80b8e9..bdbff02324bb 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -2,10 +2,15 @@
 #ifndef __PMUS_H
 #define __PMUS_H
 
+#include <stdbool.h>
+#include <stddef.h>
+
 struct perf_pmu;
 struct print_callbacks;
 
-int pmu_name_len_no_suffix(const char *str, unsigned long *num);
+size_t pmu_name_len_no_suffix(const char *str);
+/* Exposed for testing only. */
+int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
 
 void perf_pmus__destroy(void);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


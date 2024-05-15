Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000E42A81
	for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752882; cv=none; b=m8zUX5ErqlmSg5gtJOJXBjbKoVSozB+LdmZP0yuZeebkX8l/nz1HNqrultHLZtXSMdj5KF8qX39SCOFMDUHAIgPvt9uZR8ORCUc2++4aIGyv0xWbGO92KRw1NZ9Iaf5DZF2TWWAfXK+cz9+Rz5AVcmDsvGkFt7PRuZPdp9XEszI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752882; c=relaxed/simple;
	bh=mdAbZwia40YUgM/YG3gJYj7KVhAqiovVt5CXsLbGBkA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Lc9PFNpKPcS4/IM0jXinRz3IodAq6MIVjnEXa9ny59fT93apWEZBw1c1JRneh31zywZZlsqF4mbhZDFNBDf0vEfULIx8XM2OQviQFdi0eYl5EibT7DHFHwcbd05OhnaMkTLfUdTwmQ4acYGjVmt0ITYzv8NoJTBbpZ+nywJ+qnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+3I02+w; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+3I02+w"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bed763956so120102977b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 23:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715752880; x=1716357680; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RSFAVnYA+bmwN3ZaYvT5Qc1d7lQFs3CfsIrqrW0emKY=;
        b=T+3I02+we8cc4pKvmXNHB7WNLE3yer6Qc0VA186M6gxLLMbAqa0uI5rlHV1WY0ZZq5
         f1kLCIHYr6VxK5T7SwwMslc63hk33xghOLErIOXpWtXe+JCdItGXdWZMb1+6T4fY/mTL
         Ypyc0a7ybJTr5uTh29hy8Po/6LMe/9h1GJ5mRXjz044/9ny9y6tshmdpbxQiR7cwWqu+
         JQVy23JeXw0RdzPm408YItYZTka+RKgsP1uI0elUMAoT/yOkoI3v2dka64b2h2hiIxTw
         WOJMTgxpyD0lvRA6T1R8Qo0g07WSPZCcpoVzCJtEVH17mCg1Wh1LlVBnbvMen0vygaid
         3n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715752880; x=1716357680;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSFAVnYA+bmwN3ZaYvT5Qc1d7lQFs3CfsIrqrW0emKY=;
        b=hRDcj1BASEkvyxojaMjZFS379VJ1PTMrv48g/3stqjjgiSQOxK49oxKQz9km5Ho6TN
         wUStAyFtkAeYZD7OgtYYoRLw3SaG207O+BX++xPaWsAFVksuXghTbOWhrbFtPvtfGvpz
         +TE8UWjwTv3LQ53mjdLfjou2/NPITuDwo4sXV7AjNYvP5gBaHdRKX6uFx07kxoKaVjgp
         KgiyQ+0ZTLTVujBA7zZwJLism6dfQi3krZ2qpJaAswbOoU3PgVgbwBztEDVnhIMGQeKn
         RMenRMYb8SVAkY3evPaXGOuaQ9NeOLXiI4VKWu68uvM0l4dBzGb76JGeJJSoxW5W6ftN
         0H9g==
X-Forwarded-Encrypted: i=1; AJvYcCXCP2paAXqkHh1BPbweg2ULjCmuwCTGsMWUeUAtVSbukAnuUi10eVB1Dqq9bUTpcTtvXD5yQUp2DtEnsxAChv3rM4thNIsNKmmHa8XsdNJNdQ==
X-Gm-Message-State: AOJu0Yzocp8nEa46crmLkfl1nQOcCD7TDyTl6XKWG9w74J1WymIFUD1B
	Zg/RYa6U6CHZMayY1zyuUJR26KDM8WBuptDgnkm9SqUTTme2yhluQ8fxQkuhOslf5EFRFllEcH9
	5WIqfsA==
X-Google-Smtp-Source: AGHT+IGR44nRuzOXgB672uu60Tn0MEOIkOJRxSBxIV50k3vIl3dn0pKPSn8SHsILqKISrql+NRTSYIEtt0U1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bac3:cca1:c362:572])
 (user=irogers job=sendgmr) by 2002:a05:690c:380f:b0:61b:e678:2591 with SMTP
 id 00721157ae682-622aff9c02cmr41297157b3.4.1715752879941; Tue, 14 May 2024
 23:01:19 -0700 (PDT)
Date: Tue, 14 May 2024 23:01:13 -0700
In-Reply-To: <20240515060114.3268149-1-irogers@google.com>
Message-Id: <20240515060114.3268149-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515060114.3268149-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v6 1/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
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
Modify perf_pmu__match_ignoring_suffix so that hexadecimal suffixes
are ignored.

Only allow hexadecimal suffixes to be greater than length 2 (ie 3 or
more) so that S390's cpum_cf PMU doesn't lose its suffix.

Change the return type of pmu_name_len_no_suffix to size_t to
workaround GCC incorrectly determining the result could be negative.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  | 33 +++++++++++++--------
 tools/perf/util/pmus.c | 67 ++++++++++++++++++++++++------------------
 tools/perf/util/pmus.h |  7 ++++-
 3 files changed, 65 insertions(+), 42 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 888ce9912275..c94a91645b21 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -856,26 +856,34 @@ __weak const struct pmu_metrics_table *pmu_metrics_table__find(void)
  */
 static bool perf_pmu__match_ignoring_suffix(const char *pmu_name, const char *tok)
 {
-	const char *p;
+	const char *p, *suffix;
+	bool has_hex = false;
 
 	if (strncmp(pmu_name, tok, strlen(tok)))
 		return false;
 
-	p = pmu_name + strlen(tok);
+	suffix = p = pmu_name + strlen(tok);
 	if (*p == 0)
 		return true;
 
-	if (*p == '_')
+	if (*p == '_') {
 		++p;
+		++suffix;
+	}
 
 	/* Ensure we end in a number */
 	while (1) {
-		if (!isdigit(*p))
+		if (!isxdigit(*p))
 			return false;
+		if (!has_hex)
+			has_hex = !isdigit(*p);
 		if (*(++p) == 0)
 			break;
 	}
 
+	if (has_hex)
+		return (p - suffix) > 2;
+
 	return true;
 }
 
@@ -1788,10 +1796,10 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
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
@@ -1828,13 +1836,12 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
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
@@ -1859,7 +1866,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
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


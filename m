Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD34687
	for <linux-perf-users@vger.kernel.org>; Sun,  5 May 2024 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714878994; cv=none; b=pB3Rl7nScxdzLi6WO9ngPncgsvEwm38Xo877yX7YJTSdb9HQBTbeavt8ysgYOKKCL7WKodzczQ14/ObgFHbDyItR53lYooipGX8/e6fM/iC4+h8OnLpyq8lw8SYUoJzcEuXcfYevjINpXBq64fKGNvE2zM27ceIHtqgiGhY2vQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714878994; c=relaxed/simple;
	bh=5gTI/vLvfoRDkE1HNBi49R/WzRbm6XNb8vEM3hPtW9A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ciFOhrmLMjzxs1aKhfzcAE40tlUs/0pTgEC7ETL0XTv/js128Hr9NmSCJIyiiYx7k7rRbqKilWmMx32Aks+mTmEjd1dB2UxmURwbCbaHXanfZthBYgsc6zDiTk3251rbwAmTnhFxz+RN6njTAUMAL19PHuV5hWslFCOSVNfZF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L58Nzq2X; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L58Nzq2X"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bef0accddso25127507b3.0
        for <linux-perf-users@vger.kernel.org>; Sat, 04 May 2024 20:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714878991; x=1715483791; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9Pfav0quSIEBt1s01RsF3dX+AGp20N2u3wa4HFJbkI=;
        b=L58Nzq2XkJVQepA8rvY7e9iLe/RzJl79EMXqn0HtMsYSWqXpKrpzp/Vug722RbUcRz
         xcDoZnuBLqrcwF9JPzi/vVUIL9qY/xVNvpbNySrYvicfMzZkCli4OVZjVdaBrZ8zoUy+
         Iyx1fD69rPADFOR2edb00m/p1rpvFX2jHusWLFZYHs1lP+jfw6AUq77PDiEq8vkEUTu7
         KjSUXrhvMjKsCCtlAljSEBreRS47Wi45u7497mUPkngr+T8LlT60PQqG6BGaDv7PZj3o
         wTJzowCcJXC49RPaUzbPjAgOOwf0Ba11yXzLLO7u9XAmz4x9erVRe1NQFAAnVVeprWE/
         0/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714878991; x=1715483791;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9Pfav0quSIEBt1s01RsF3dX+AGp20N2u3wa4HFJbkI=;
        b=bgdqVbZoZcRlBUQuZmhz1jgLVwjpWZA8k6ea/gyrleSxkLra52QFGiGhZpNV7PgfNW
         82MtAwvdrY7zw9Uh4x0ke3duSsjNsWPFieRv7a88CvmIUdZxjV99d//uU1Ht1RWOwyZT
         WBTNSf+KjLzLDF26sbSFb+raLsZaL/FZbRlvvvGYfDgD/mnUTvKQ4rgr6Qv+iT5EZDTs
         N+/va0EhuTQXDIiuuZNHZpkFIocBjgny6edDNBLZhzDPhlnlPFKHEIeDPvx8LrDhpR8M
         2QLhDoMkhQCcWMm1Rg/ixNAa6J+t0vn3JsMBKMJG0mDGZtOx+wk7F4ZCRZVhsBmfBmp3
         wjGw==
X-Forwarded-Encrypted: i=1; AJvYcCW/6T1oFsFLQll7kA7rsab+A11Zb8A6w69RdauiBDVpoR3rD7UZ9cj91NP2172xX0cpNmPSp8SC6w5hDj/9y+xFaBamSW5c8/6gIoiWKM7OPg==
X-Gm-Message-State: AOJu0YwK31JYS/rSKERdyB1gpv0yEl2c6sfFKAVBKOXoQbJ0iedXwiao
	5yVK/dXzNwLpeEzushHTEuPcwqh4Qj3YwdSFlwTtZOj0aEIZI1JpGl99KkcseHijLyaRArQnrHD
	ixNjxVg==
X-Google-Smtp-Source: AGHT+IHL6ErOFm2phIaHoqIJrQBH+wqH5JjnNJbq3AhDW42lZTQAeFnc79quGqZKw72nV1iUKB+tniB2KVHF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:566d:1f52:f5f5:c8ec])
 (user=irogers job=sendgmr) by 2002:a25:ad9b:0:b0:de5:9f2c:c17c with SMTP id
 z27-20020a25ad9b000000b00de59f2cc17cmr2086132ybi.9.1714878990839; Sat, 04 May
 2024 20:16:30 -0700 (PDT)
Date: Sat,  4 May 2024 20:16:23 -0700
In-Reply-To: <20240505031624.299361-1-irogers@google.com>
Message-Id: <20240505031624.299361-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240505031624.299361-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v3 1/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
From: Ian Rogers <irogers@google.com>
To: Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
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
argument, this is because we don't know if a suffix number of say 10
is in hexadecimal or decimal. As the only use of the suffix number is
in comparisons, it is safe there to compare the values as hexadecimal.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  |  4 ++--
 tools/perf/util/pmus.c | 53 ++++++++++++++++++++++--------------------
 tools/perf/util/pmus.h |  7 +++++-
 3 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b3b072feef02..32e5a73273d7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1761,7 +1761,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 {
 	struct parse_events_term *term;
 	int pmu_name_len = skip_duplicate_pmus
-		? pmu_name_len_no_suffix(pmu->name, /*num=*/NULL)
+		? pmu_name_len_no_suffix(pmu->name)
 		: (int)strlen(pmu->name);
 	int used = snprintf(buf, len, "%.*s/%s", pmu_name_len, pmu->name, alias->name);
 
@@ -1805,7 +1805,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 
 		info.pmu_name = event->pmu_name ?: pmu->name;
 		pmu_name_len = skip_duplicate_pmus
-			? pmu_name_len_no_suffix(info.pmu_name, /*num=*/NULL)
+			? pmu_name_len_no_suffix(info.pmu_name)
 			: (int)strlen(info.pmu_name);
 		info.alias = NULL;
 		if (event->desc) {
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b9b4c5eb5002..28cfa7adbfd7 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -40,31 +40,44 @@ static bool read_sysfs_all_pmus;
 
 static void pmu_read_sysfs(bool core_only);
 
-int pmu_name_len_no_suffix(const char *str, unsigned long *num)
+int pmu_name_len_no_suffix(const char *str)
 {
 	int orig_len, len;
 
 	orig_len = len = strlen(str);
 
-	/* Non-uncore PMUs have their full length, for example, i915. */
-	if (!strstarts(str, "uncore_"))
-		return len;
-
 	/*
 	 * Count trailing digits and '_', if '_{num}' suffix isn't present use
 	 * the full length.
 	 */
-	while (len > 0 && isdigit(str[len - 1]))
+	while (len > 0 && isxdigit(str[len - 1]))
 		len--;
 
-	if (len > 0 && len != orig_len && str[len - 1] == '_') {
-		if (num)
-			*num = strtoul(&str[len], NULL, 10);
+	if (len > 0 && len != orig_len && str[len - 1] == '_')
 		return len - 1;
-	}
+
 	return orig_len;
 }
 
+int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
+{
+	unsigned long lhs_num = 0, rhs_num = 0;
+	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name);
+	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name);
+	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
+			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
+
+	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
+		return ret;
+
+	if (lhs_pmu_name_len + 1 < (int)strlen(lhs_pmu_name))
+		lhs_num = strtoul(&lhs_pmu_name[lhs_pmu_name_len + 1], NULL, 16);
+	if (rhs_pmu_name_len + 1 < (int)strlen(rhs_pmu_name))
+		rhs_num = strtoul(&rhs_pmu_name[rhs_pmu_name_len + 1], NULL, 16);
+
+	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
+}
+
 void perf_pmus__destroy(void)
 {
 	struct perf_pmu *pmu, *tmp;
@@ -167,20 +180,10 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
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
 
-	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
-		return ret;
-
-	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
+	return pmu_name_cmp(lhs_pmu->name ?: "", rhs_pmu->name ?: "");
 }
 
 /* Add all pmus in sysfs to pmu list: */
@@ -300,11 +303,11 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
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
@@ -316,7 +319,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 		pmu = list_prepare_entry(pmu, &other_pmus, list);
 	}
 	list_for_each_entry_continue(pmu, &other_pmus, list) {
-		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
+		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 		if (last_pmu_name_len == pmu_name_len &&
 		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
@@ -566,7 +569,7 @@ void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, voi
 			.long_string = STRBUF_INIT,
 			.num_formats = 0,
 		};
-		int len = pmu_name_len_no_suffix(pmu->name, /*num=*/NULL);
+		int len = pmu_name_len_no_suffix(pmu->name);
 		const char *desc = "(see 'man perf-list' or 'man perf-record' on how to encode it)";
 
 		if (!pmu->is_core)
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 9d4ded80b8e9..69d64fbd4259 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -2,10 +2,15 @@
 #ifndef __PMUS_H
 #define __PMUS_H
 
+#include <stdbool.h>
+#include <linux/list.h>
+
 struct perf_pmu;
 struct print_callbacks;
 
-int pmu_name_len_no_suffix(const char *str, unsigned long *num);
+int pmu_name_len_no_suffix(const char *str);
+/* Exposed for testing only. */
+int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
 
 void perf_pmus__destroy(void);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


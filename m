Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1252FF650
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 22:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234131; cv=none; b=VyA2fk+MYAtMKgdUt/hw970CUZHjI9SZ99JQ/gbG7gBJw/dVTURAH1fNMwty8NqPnoDBPX5wKjk6/nMNt3jaFG6Zly0NBDWVUdfwKXRL8z+Casgpwy4n0BPZBnLAJjjZWlHFBAbk0ICmKVCrLnUd0jD/sWC5V2r2v9y6zfEVvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234131; c=relaxed/simple;
	bh=bVc3kDgnMxi3LeNcvdebA35fa49RA/BlURQA67guNaM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uy5sEIl/7lmmzdRYIij7nZQYYXNkoFjy+E5rmliA+1t4eomU1PmolBB5xDOuemUkWsQjuf0dWf14FbMv0HkqI6hIyK51ky8iexOjFb2Jvt7+Cwld/7jKhHbCPnHIyF6V8sX6XCxAr9OLHSnF+Fl2oHj/2TaCrF/arwC1eHqL7kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iunOri8I; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iunOri8I"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2681642efd9so12937925ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 15:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758234130; x=1758838930; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qfPNJqadhLlZpiek/PBm8YyMz6t+BW/rS3q4ughwwA=;
        b=iunOri8IPXlkTcrNA/mR9aOpUEBov7zcFb5MuhHfZQ8Bkutf59HG8nnGqwc3C+qQx+
         fJNRSBmnw9iI8d2FMi5AS8vVZupfWAAw1b3IhrY6OlU1iagKaZpAOxVjNLmKu8u430US
         O7NG4IXrb+oftzQ7REGzT89t1B9FzXyCTX/p72yjLl7MiFXoimgzaGQ5bnuDaLQ0mhgo
         zSOvMlUhZdReCIO7KioP9bPZkQUx+b7EIO3TZRYUnMWoSJodLs/A5WL8LImFonSIuUKJ
         Mpc4vOuy8oJ/1nNdcW8+CU1fP8vOxWylUxJbvKiGpCQRDudyj4AB9Xfg+ISGSogDPBeq
         TGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234130; x=1758838930;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qfPNJqadhLlZpiek/PBm8YyMz6t+BW/rS3q4ughwwA=;
        b=B3cmLzTMpLYp9pFSWu1EDe8jgom9jOTIAUaBnkM5i6gilwep8Kr0vlDTrG7BnAIfou
         I3uiBTaiS+vLt5LJVVB+Gaq1u3/nscBx5vC3zveOm0ZnHHWXQDQICRbC1HINRMEKIioS
         aWdHo4AxjXLUzVbejtl0fGFqpTclDyV7+6XoHPbDfTS0wX9lmX41E6VEdC4hJVFB3qnK
         yFVMgMeHKqOOuwQxfN1TW47gFX0Dn/+2wNCzo0xAcC2M9AYOTdVR7PdQmjnu2bJpMfmy
         TiIl9YucZf9PuGeLZB4DvLRj1RQdqYs27IXVWqgvbOcOKj/jbx1Y3rBq6HGX5UcysbAU
         BOmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMbaCUWctzwDyNeUyXs7Y/2YkNdXA6W8b0oGGX/WZmdy3GUxSmsAtMLgv2cSJiDDlnqnYdtWCYvoD9RRuNuvNM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0LeN0j1i+9LML8jadDhHPJRazhP028ygaSIGXYYJMLDUO9wec
	ZxmU9PYBxBiW16BaeIal60VophXd71SDF9AWFj33usyu2IKXj79gQFH+6HWEctSOLRvnkWYsMwd
	Ir2eCdzttEg==
X-Google-Smtp-Source: AGHT+IHAb2iMgpayxv+HM2x01Rh9wJpNBeSAoQCuaNCvhxmKHijGOa+73Gu/v/DdBjyrrIF9u0m/JcRWON1Y
X-Received: from plho12.prod.google.com ([2002:a17:903:23cc:b0:263:a081:54b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c4:b0:269:aecc:a454
 with SMTP id d9443c01a7336-269ba3c5027mr16373625ad.11.1758234129653; Thu, 18
 Sep 2025 15:22:09 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:22:01 -0700
In-Reply-To: <20250918222202.1353854-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918222202.1353854-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918222202.1353854-3-irogers@google.com>
Subject: [PATCH v2 2/3] perf evsel: Fix uniquification when PMU given without suffix
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The PMU name is appearing twice in:
```
$ perf stat -e uncore_imc_free_running/data_total/ -A true

 Performance counter stats for 'system wide':

CPU0                 1.57 MiB  uncore_imc_free_running_0/uncore_imc_free_running,data_total/
CPU0                 1.58 MiB  uncore_imc_free_running_1/uncore_imc_free_running,data_total/
       0.000892376 seconds time elapsed
```

Use the pmu_name_len_no_suffix to avoid this problem.

Fixes: 7d45f402d311 ("perf evlist: Make uniquifying counter names consistent")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6a31f9699b49..6947072598b1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -4053,9 +4053,9 @@ bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_con
 
 void evsel__uniquify_counter(struct evsel *counter)
 {
-	const char *name, *pmu_name;
-	char *new_name, *config;
-	int ret;
+	const char *name, *pmu_name, *config;
+	char *new_name;
+	int len, ret;
 
 	/* No uniquification necessary. */
 	if (!counter->needs_uniquify)
@@ -4069,15 +4069,23 @@ void evsel__uniquify_counter(struct evsel *counter)
 	counter->uniquified_name = true;
 
 	name = evsel__name(counter);
+	config = strchr(name, '/');
 	pmu_name = counter->pmu->name;
-	/* Already prefixed by the PMU name. */
-	if (!strncmp(name, pmu_name, strlen(pmu_name)))
-		return;
 
-	config = strchr(name, '/');
-	if (config) {
-		int len = config - name;
+	/* Already prefixed by the PMU name? */
+	len = pmu_name_len_no_suffix(pmu_name);
+
+	if (!strncmp(name, pmu_name, len)) {
+		/*
+		 * If the PMU name is there, then there is no sense in not
+		 * having a slash. Do this for robustness.
+		 */
+		if (config == NULL)
+			config = name - 1;
 
+		ret = asprintf(&new_name, "%s/%s", pmu_name, config + 1);
+	} else if (config) {
+		len = config - name;
 		if (config[1] == '/') {
 			/* case: event// */
 			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 2);
@@ -4089,7 +4097,7 @@ void evsel__uniquify_counter(struct evsel *counter)
 		config = strchr(name, ':');
 		if (config) {
 			/* case: event:.. */
-			int len = config - name;
+			len = config - name;
 
 			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 1);
 		} else {
-- 
2.51.0.470.ga7dc726c21-goog


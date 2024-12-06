Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4F193416
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 04:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458998; cv=none; b=Ktyn+79L0tO57ZYZlOUbSbnBEEYm2Ty7Ajkwuly9sfmsF4kmAg4p2d7pHsGA8efyl7L1AFmBgvZkC2ROU/rMzHqWchKxfoRiJO2Iw/ccMXFtMPE5FJnjOPZxqZw8oJw9IEI/45MY8Xi8fv1zQfNN4FMiZCUUlctprq1yhO4BfmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458998; c=relaxed/simple;
	bh=Rwf4MxwSdxTaPh5ZCszoKXNLa79X2zBBI6OkcmNS7p0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OqHYN3yMxPKHJaPGOlWjkL8HLLzSmJkUVjdQ4V8ph41cZtWuAePEVZrA0l+TW6S397Rvpufpvi1uTXKx5EJrjrzsWMyzraFQCJFE/teMv4zCtpBaxFCzKQK+GVjPLQgzuCMI8xjEfEGKKnLkmfpIsRzW1NWuf7Y7AtvjZoBD4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ncfBHcGK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ncfBHcGK"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ef7c67eeb8so15016847b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Dec 2024 20:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733458996; x=1734063796; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgJJ5g2aHoKUUYUSCENiai8qRmAsLGGyUUtQm2tP8Hw=;
        b=ncfBHcGKYVCjyiKUtCFcVhkMLuyWThePrpnjnZrPjbXv08JJ1dZI8uZW2JUMR9hjxG
         Gy0IXO5/3pQsg+5NEVKDUCURa/66rzUZd3FO2SIQIeWUr8Ne3bV8OXSGn0VbUSQW77bx
         wnq9BRSIl/VaxeV9HFOzXn1M80M+5goY95JofgHVUUtpQC1A1EVvq8eQTdgVndSvrrC6
         dcvaCMmtnEZvxMKbCZoggF1/MewpElUwR4ZWlru3hXNOM9Twlij41r/3q/yHV2Ij4elc
         /Gx7YsOUenzEHBJKEQ7TGlk7hq0jWpmAggWHFGw6SKv/gWDckP3Bs00e336kyE1HUHBb
         1Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458996; x=1734063796;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgJJ5g2aHoKUUYUSCENiai8qRmAsLGGyUUtQm2tP8Hw=;
        b=O4xY5AQVesTrCgmGoJL1VA3SnpciDxwEN6ADDry4V4vRojbYRJUO+DxTKy+I/+mmPo
         fTmp7U3KtIEqlHYQNyMl5bdAathM9bIGK5u05LncLEwlRZRjOQ2s+BbYVrj2kGXiukNb
         MMszOrCVlMXkLaDhzkLQWhjmELgyF1SoNjK5NXYjxkgB4esemlOgKkh/gVJAQq9uWe7e
         VJVBldsHsLlhEU2ziNuCocTEflCcPapVPkKhKngULw0ECDmcM4Dj9BinWOSyBeH7yioY
         qz6dXf1MwcpgIQuY8+q7fnGrr9kJnf6TR5irxPbbV97ftnCjP2dDZ8s87KYYOVD5CWW/
         VH0w==
X-Forwarded-Encrypted: i=1; AJvYcCUassdvPOxZmRejPhAG9LTB7EBqlOi2WYvMNQ8EWRhnq0ejGNgsfLg0Omph2lJsz0SS58PdfVxWH3xGr2stPX8D@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXKSgpvy7E6IZ38TtSTeGsD83PgozCmzQXlOnCVx83vmZw+Jh
	R1wamsdyRR031/JZCQ3QRBJ3e7X6vzUz5Bn3kvw+U+xcdJ6C9Znk0eOEgu8KwIyOWZZToOISrxV
	vaNuZFQ==
X-Google-Smtp-Source: AGHT+IEGKy7oI8KriU61gktJff/RjJQfOZ1L6irXI6BNWBEsPPfFoz+Td9buKSXKNERBGKurnjEaVnc0Uc2S
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a05:690c:4c13:b0:6e3:8562:fbf with SMTP id
 00721157ae682-6efe3c6ae7fmr12677b3.3.1733458996171; Thu, 05 Dec 2024 20:23:16
 -0800 (PST)
Date: Thu,  5 Dec 2024 20:23:06 -0800
In-Reply-To: <20241206042306.1055913-1-irogers@google.com>
Message-Id: <20241206042306.1055913-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206042306.1055913-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 2/2] perf test hwmon_pmu: Fix event file location
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The temp directory is made and a known fake hwmon PMU created within
it. Prior to this fix the events were being incorrectly written to the
temp directory rather than the fake PMU directory. This didn't impact
the test as the directory fd matched the wrong location, but it
doesn't mirror what a hwmon PMU would actually look like.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/hwmon_pmu.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index f8bcee9660d5..d2b066a2b557 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -65,7 +65,7 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 		{ "temp2_label", "test hwmon event2\n", },
 		{ "temp2_input", "50000\n", },
 	};
-	int dirfd, file;
+	int hwmon_dirfd = -1, test_dirfd = -1, file;
 	struct perf_pmu *hwm = NULL;
 	ssize_t len;
 
@@ -76,19 +76,24 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 		dir[0] = '\0';
 		return NULL;
 	}
-	dirfd = open(dir, O_DIRECTORY);
-	if (dirfd < 0) {
+	test_dirfd = open(dir, O_PATH|O_DIRECTORY);
+	if (test_dirfd < 0) {
 		pr_err("Failed to open test directory \"%s\"\n", dir);
 		goto err_out;
 	}
 
 	/* Create the test hwmon directory and give it a name. */
-	if (mkdirat(dirfd, "hwmon1234", 0755) < 0) {
+	if (mkdirat(test_dirfd, "hwmon1234", 0755) < 0) {
 		pr_err("Failed to mkdir hwmon directory\n");
 		goto err_out;
 	}
-	file = openat(dirfd, "hwmon1234/name", O_WRONLY | O_CREAT, 0600);
-	if (!file) {
+	hwmon_dirfd = openat(test_dirfd, "hwmon1234", O_DIRECTORY);
+	if (hwmon_dirfd < 0) {
+		pr_err("Failed to open test hwmon directory \"%s/hwmon1234\"\n", dir);
+		goto err_out;
+	}
+	file = openat(hwmon_dirfd, "name", O_WRONLY | O_CREAT, 0600);
+	if (file < 0) {
 		pr_err("Failed to open for writing file \"name\"\n");
 		goto err_out;
 	}
@@ -104,8 +109,8 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 	for (size_t i = 0; i < ARRAY_SIZE(test_items); i++) {
 		const struct test_item *item = &test_items[i];
 
-		file = openat(dirfd, item->name, O_WRONLY | O_CREAT, 0600);
-		if (!file) {
+		file = openat(hwmon_dirfd, item->name, O_WRONLY | O_CREAT, 0600);
+		if (file < 0) {
 			pr_err("Failed to open for writing file \"%s\"\n", item->name);
 			goto err_out;
 		}
@@ -119,16 +124,18 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 	}
 
 	/* Make the PMU reading the files created above. */
-	hwm = perf_pmus__add_test_hwmon_pmu(dirfd, "hwmon1234", test_hwmon_name);
+	hwm = perf_pmus__add_test_hwmon_pmu(hwmon_dirfd, "hwmon1234", test_hwmon_name);
 	if (!hwm)
 		pr_err("Test hwmon creation failed\n");
 
 err_out:
 	if (!hwm) {
 		test_pmu_put(dir, hwm);
-		if (dirfd >= 0)
-			close(dirfd);
+		if (hwmon_dirfd >= 0)
+			close(hwmon_dirfd);
 	}
+	if (test_dirfd >= 0)
+		close(test_dirfd);
 	return hwm;
 }
 
-- 
2.47.0.338.g60cca15819-goog


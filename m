Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E147F4D
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256460; cv=none; b=aUmHG4vR6aEh+xElCHmhwZ6KOOT6K/ohq2nRCAUbFexn33HYt1mF6BMZgPvLBOfxnjxxHjCTDBf9wBE8UW3oPvj321P+Zgc6Ah0K7sQ235H5Ih1UQ/FroO0uYPBKVJKOZLzEcnrkzJ7iXX/Y35mV0Xug6qBQION6iaECEIfpLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256460; c=relaxed/simple;
	bh=wsjyhZb/PdOtvGe00zDU9jMHxWauNU8sJZPK/PLxFSE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=atxC0eqwTbYQ7ddBpFzszuAKy5cXKyKsQHBUXgOEBp8z8wirXX7dA6dhDQ/IiejwE3ZCLqFYMW/bF36Zjvfeobjp8p9NCoedninBwx7oHhkhGKFWLFg3eD2Q+mnqUpy4ZoTcgbFT3KGFtjRA8Ii51jfki/8vYLVODnyQjGumuqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mkZC3Wm/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkZC3Wm/"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02b7adfb95so469484276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721256458; x=1721861258; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VIiZO/q4iRQZ7Xs1eg6KNaj9S7BXW+wk4oVE8PU2qN4=;
        b=mkZC3Wm/ZEGrsFjtlijyHyGoj+jtUPcLrUOG8cTpDWViOO0+/F5nvYlP/kwg305B3d
         fZgWU14bYRbfy1PWNUgVa99mpEWjx8bs1TGBEJajt8w0ukeabq5crPWPVEqjFnBxZ+Jr
         duSPj7udoBCSi1dn9K/2vHFRO1H4t4ppRJMf4giU7fPb42Df+S7fUxLsjEOEdT58lkty
         vLi/EmOKswF3zWOBk41NNmfd3LloS6yHNSneEN3B02mPcaq389/0yfq9RQcl0XBhVOHF
         INv5WEUgWRS3TW+OVsCJirqSuMXjOi3N70rJH/JrpFQPFBTLuE32heIbPrPetQMfIORj
         Ponw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256458; x=1721861258;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIiZO/q4iRQZ7Xs1eg6KNaj9S7BXW+wk4oVE8PU2qN4=;
        b=w3oOpyTlYXIHpGOwCT4mUTDPxYTt+m9cwUueR8vQ8g2BA+t4X0NUuOhQnFuIWlISfp
         EUhpwOQGmlK8F2yUbIXxG+SuJ8I2Pq2toWO5ObD2xB4kHFgTZflunHgO+JIIMvhKVKD3
         5YhN3Z/SRW1vLtH6GfcMsHGQ3CZxngerXms1VZFeU/U5DTuftHyhXXFOI7j/j5hckRvP
         DQBkG4gx0bOWm6d8t76/bMH6t24b/EVkjeAXc4/hMCx0gKmozljqsMukR8zFrXLtXV0Q
         HyRZeejGeouk0ffKXiCCXJfs8LvCf56aWuuilVtthRSyIkTA6MrLl2wTstFGJ8QvqMSc
         Gs8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEXfzoom4lDgkKgFGPX10OCmMmYX6Vm9gKL7IN8XZwnxJSO88/cnilcY4zc+tPZet1G+I1nllf/oeulZF/j2J79BvxXinPniRpoB+Rcdwk1w==
X-Gm-Message-State: AOJu0Yyy3FgAkVPoLZJNPh99TPBScxz0BQ3DIru5DoxYRwRbZrtXd+JO
	txWuXUuIGR9QRNnvp8hZ30ABSWdeqKqcjDfk+fsnsqlIjU3lweSecXXf3SCbf6ZTSIJH4JHTr1e
	+7YbfgQ==
X-Google-Smtp-Source: AGHT+IFnGIUQ2lhFZ36vDL4qvcmKR2SRBmLdlfHXveMflrvn4LzP54FxAZZnQ/WKEs62+RfsoHjLnbI9BV34
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d86:b0:e03:6405:7428 with SMTP
 id 3f1490d57ef6-e05febedf75mr2558276.12.1721256458202; Wed, 17 Jul 2024
 15:47:38 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:47:27 -0700
In-Reply-To: <20240717224732.1465438-1-irogers@google.com>
Message-Id: <20240717224732.1465438-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717224732.1465438-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1 1/6] perf pmu: Merge boolean sysfs event option parsing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"

Merge perf_pmu__parse_per_pkg and perf_pmu__parse_snapshot that do the
same parsing except for the file suffix used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 47 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 986166bc7c78..5148b6639dd3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -367,8 +367,8 @@ static int perf_pmu__parse_unit(struct perf_pmu *pmu, struct perf_pmu_alias *ali
 	return -1;
 }
 
-static int
-perf_pmu__parse_per_pkg(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+static bool perf_pmu__parse_event_source_bool(const char *pmu_name, const char *event_name,
+					      const char *suffix)
 {
 	char path[PATH_MAX];
 	size_t len;
@@ -376,37 +376,36 @@ perf_pmu__parse_per_pkg(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 
 	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
 	if (!len)
-		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.per-pkg", pmu->name, alias->name);
+		return false;
+
+	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.%s", pmu_name, event_name, suffix);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
-		return -1;
+		return false;
 
-	close(fd);
+#ifndef NDEBUG
+	{
+		char buf[8];
 
-	alias->per_pkg = true;
-	return 0;
+		len = read(fd, buf, sizeof(buf));
+		assert(len == 1 || len == 2);
+		assert(buf[0] == '1');
+	}
+#endif
+
+	close(fd);
+	return true;
 }
 
-static int perf_pmu__parse_snapshot(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+static void perf_pmu__parse_per_pkg(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 {
-	char path[PATH_MAX];
-	size_t len;
-	int fd;
-
-	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
-	if (!len)
-		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.snapshot", pmu->name, alias->name);
-
-	fd = open(path, O_RDONLY);
-	if (fd == -1)
-		return -1;
+	alias->per_pkg = perf_pmu__parse_event_source_bool(pmu->name, alias->name, "per-pkg");
+}
 
-	alias->snapshot = true;
-	close(fd);
-	return 0;
+static void perf_pmu__parse_snapshot(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+{
+	alias->snapshot = perf_pmu__parse_event_source_bool(pmu->name, alias->name, "snapshot");
 }
 
 /* Delete an alias entry. */
-- 
2.45.2.1089.g2a221341d9-goog


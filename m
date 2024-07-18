Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB0C15BB
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262649; cv=none; b=OOjMVupbuJugcUlpGOGuTh8Bvu8O5NfO+0uoko9R92oGQj6uCd+dhAUmjDcCoKUPZfHPWpvieXDgPtOZIlao9imTfsgwz70lXepKZ1Bc6RiUIYPrIsxhkV1H8hmTxDH53aV2ZK6m10fT1ExPD7AIN6QQGYdruWDfJwnwrzAXMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262649; c=relaxed/simple;
	bh=wsjyhZb/PdOtvGe00zDU9jMHxWauNU8sJZPK/PLxFSE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=V70r0Z0+XsZ4MV/MYHBA+Tj1SdXs0gUYuzj8Bd+yaWR9rczIQzfJVYtB6gqpjFp8kAQ/8vVNwu0GVVJrug7erG5VIT5M1S2IXiqGPHFQ02nX2oB1JexSXe0/Ge9BlNty/kFMHWF7z51RNxfi/jeg5GdlduRcCZGFkJv9uzx+zK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHFb7VYu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHFb7VYu"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65fabcd336fso6889047b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 17:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721262643; x=1721867443; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VIiZO/q4iRQZ7Xs1eg6KNaj9S7BXW+wk4oVE8PU2qN4=;
        b=UHFb7VYut2l2O7epFhM3AsZumfNy6wZpNH5qK6kzlfiw2cUaqEdEjOGiKw4T7YKGpi
         cGaIckt0uGBP2NwabwXEtTm3ErGp6+jwi1c0+M9n2qFQWDf2QS0EvihJdQDYiIxIp7ui
         zn0VjJp+Ff6xrGWH+Xe6AJO9KukX/FjIMW91osmQeeKRuQfaTL6h3w7e5/chK0g+PJvH
         ICpYQKth7DebUggOIFH2bTh0s0O+bKeYCOPPqroAUKR2a+J1gwBF5HRaX6yu/hfva42E
         d2Br9hBJTV9gses6ehtBb9XDnHSLVBjAwQOUAQhAPiq+FoE3lZDwLd0Df5Py+I8G28r0
         HuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262643; x=1721867443;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIiZO/q4iRQZ7Xs1eg6KNaj9S7BXW+wk4oVE8PU2qN4=;
        b=sWQCW+HqtmoyG/X0uKyxt5sPNEMRV+ZZWoEVW8bjyhZ8rw3KkggEwMGWemFZLBPN+G
         RWhZ3LxrQx9wzAynAwAv4GPvlMI8LGsRhG2WN+kkucjRt1SQfH200WjbcyVkpLwmRTw3
         8mPqgJawze0dqjKHzFNYHFjGMrMNtlMYiKITl3hrFAWITKqbJU4cXy14MUSkl/Tialms
         yQbbLzCcydtCikmrhBXuFji4bWojKESwMVg5rECEk25M4tubRvMH+TOfWds5IWDLa8q4
         VaHXdtR5woUVZ7rAvQJqI03x2F8GQO+o2VAV+IwPGgedqa7qSHkjkDOJRrPQpdoxZN/F
         PT6w==
X-Forwarded-Encrypted: i=1; AJvYcCUSduLyozKGpWcsQri2FMrdsikN/Th+jICNKF3qA8o0wlW7XhOmwr53CcYviG/7OetqAfUvoZ42SaJVVjoQSwykgyiVL1kbcjqFACdZHC0H8Q==
X-Gm-Message-State: AOJu0YwPNSzb95be2pwkz/wwnLtfr7RyI1+WFbpieyPC/6h7UP1+Cx+s
	dsdYdh9/b6zATT3JrxaoScHftyz0WIAIYlq7Cg7dImgP0wR3nCMimMztVXgAuw6GJ2NArSlHznv
	qz4tTJw==
X-Google-Smtp-Source: AGHT+IFfCMOuGXsHSEr3d5WA2QSbUr56wtI1HaSDAsFZY391lNM3yJUpfl5fvsNEbjBjgupdMCKJtKHa3hdn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a81:c704:0:b0:62d:1142:83a5 with SMTP id
 00721157ae682-666044aeb61mr165797b3.8.1721262642639; Wed, 17 Jul 2024
 17:30:42 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:30:20 -0700
In-Reply-To: <20240718003025.1486232-1-irogers@google.com>
Message-Id: <20240718003025.1486232-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v2 1/6] perf pmu: Merge boolean sysfs event option parsing
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


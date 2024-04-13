Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7161B7F4
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Apr 2024 04:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712981298; cv=none; b=YfBH3gfkOrQQbB0g79kMnExkAxQFbGVYxpfhHTUQroX7zLZHUW6UueoKTnZbxkKgh6hnO8zfpAof2+gTs19Bs2uTu9W19TXK0bxNhmw5jBBM3x5R2bgDRoS61zYO4TrfJCkWprMSqUmP/ctcL4BRx2rvm9hpdaIWsO2BIzzjrOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712981298; c=relaxed/simple;
	bh=psg6T4xGQd7JrMIyC4K0Af0EDOUtPx/yuI+ni4g9NhA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=uSWaIWPPYTbOovNwrRJuqcb8pCQzv+ZM7QKbWF3f6AmPgLT0WtyiNQRgYl9rynPkN1W6ZRRxBHcTNMMVhjbQfFibTYUEN0mPcqPsLmZf6CGKy9V/w6c882h5v20oflNFM7py9UyLA2IBMXqmm3ZN+TgKe3l14a2HHbv0Dov2qLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnlUx/Vm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnlUx/Vm"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cc00203faso28621597b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Apr 2024 21:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712981295; x=1713586095; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1vfm6D8vbfikeYPBREDbfZMw+ntrB8izme+ZrPR5K4g=;
        b=jnlUx/Vm7xS7cK4wn4FmWlBvrQFc5piwalUmAgG1dqtNq0WTj4YpOjbOxndfw3wrPq
         vITcySn76KJoMfUkrQXbdtCEWJ8/OCADAjD+88bgkoekN3oEwOP96tJ/mJLWKq77590b
         qYq+7xPxHRsMB44GdMvPYiEXCelRuuLCXPbXEbhCdenJWZkELpfbNqvfJJy9LQWtuSnK
         E1RAgtBBNaF6RaQDiKFGHcQhNxcKFzKj3aQAFyTHVCaT+MWINNode5xt/+TYELo7QTbP
         P0EeLlBWVnyHGT5YKvkHcL+ApFjo4/dlV0qkFheDz8QCffDA8rqzhxJYLBgqnDQdEAJZ
         +onA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712981295; x=1713586095;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vfm6D8vbfikeYPBREDbfZMw+ntrB8izme+ZrPR5K4g=;
        b=fxKi/8NkPlDRxNulo+AxnqzNJoqkVhntUd9a1xqC3ATa4fJur15Uwj1JN23TRXJ+XR
         ilTeNZF7EHfZcDMIWMdoq/BeTBWcIjlBH9t8mj+scq6ZgFv9MABMN1uiu+MGAgEJYjvZ
         xn4m3vCs5quhlptTKIsmqyn5aMKqWmuVFAJpPQkySbKx6sMfB3xQdzEHaWHzamBJp4Wy
         +zScv1/9YzsKJMG0EkbA60+yYChnjkRZZUr2ZlN6cwbwaDAjfvAK3Nj99gV3Qtvhf033
         wECU3kMfyekjCxOnte1JYMLE8N7w08cvhCE+LxDecmBYXmVUcp248Pl9hL+cRw2MSg/U
         toBw==
X-Forwarded-Encrypted: i=1; AJvYcCWUEsXH25xGbbU5J7TdvWlhRPp+Kbgn7guqpG8Z0MiaDrLLk3BDvqDcm+bLn5UZpV/ClyX8hsBt7ApvU0Q3na+/l1BxMds+wN+PewcWmy8uBw==
X-Gm-Message-State: AOJu0Yy/ahLxG9I4dFSjY10iS2VMRxaKtYYTnumUOtnycZhi9CYcH06U
	1CsB05clOfMWDOMngL4uk8qUfZDeuYw8XJaEynQFOw2/JWnApXq+cF5vlaL5V8g5XDhH63sOlpI
	U4Fhoow==
X-Google-Smtp-Source: AGHT+IGc68h3ITmPYl/wBrgeY+RnGa0UfYbf173Yk6snhK1Y/ir4lgI2FATkpMn60saSN8j3ruRp60tnjfKQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bcbe:4239:4b57:df45])
 (user=irogers job=sendgmr) by 2002:a81:49c7:0:b0:615:4295:2871 with SMTP id
 w190-20020a8149c7000000b0061542952871mr1016283ywa.7.1712981295572; Fri, 12
 Apr 2024 21:08:15 -0700 (PDT)
Date: Fri, 12 Apr 2024 21:08:12 -0700
Message-Id: <20240413040812.4042051-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [RFC PATCH v1] perf pmu: Assume sysfs events are always lowercase
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Perf event names aren't case sensitive. For sysfs events the entire
directory of events is read then iterated comparing names in a case
insensitive way, most often to see if an event is present.

Consider:
$ perf stat -e inst_retired.any true

The event inst_retired.any may be present in any PMU, so every PMU's
sysfs events are loaded and then searched with strcasecmp to see if
any match. This event is only present on the cpu PMU as a json event
so a lot of events were loaded from sysfs unnecessarily just to prove
an event didn't exist there.

This change avoids loading all the events by assuming sysfs event
names are always lowercase. It then uses file exists and only loads
the events when the desired event is present.

For the example above, the number of openat calls measured by perf
trace on a tigerlake laptop goes from 325 down to 255. The reduction
will be larger for machines with many PMUs, particularly replicated
uncore PMUs.

Make pmu_aliases_parse early return when aliases are loaded, ensure
the function is called before all uses of the aliases list.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ab30f22eaf10..ce72c99e4f61 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -425,9 +425,16 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 {
 	struct perf_pmu_alias *alias;
 
-	if (load && !pmu->sysfs_aliases_loaded)
-		pmu_aliases_parse(pmu);
+	if (load && !pmu->sysfs_aliases_loaded) {
+		char event_file_name[FILENAME_MAX + 8];
 
+		scnprintf(event_file_name, sizeof(event_file_name), "events/%s", name);
+		for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
+			event_file_name[i] = tolower(event_file_name[i]);
+
+		if (perf_pmu__file_exists(pmu, event_file_name))
+			pmu_aliases_parse(pmu);
+	}
 	list_for_each_entry(alias, &pmu->aliases, list) {
 		if (!strcasecmp(alias->name, name))
 			return alias;
@@ -605,6 +612,9 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 	size_t len;
 	int fd, dir_fd;
 
+	if (pmu->sysfs_aliases_loaded)
+		return 0;
+
 	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
 	if (!len)
 		return 0;
@@ -1689,9 +1699,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
 	size_t nr;
 
-	if (!pmu->sysfs_aliases_loaded)
-		pmu_aliases_parse(pmu);
-
+	pmu_aliases_parse(pmu);
 	nr = pmu->sysfs_aliases;
 
 	if (pmu->cpu_aliases_added)
@@ -1750,6 +1758,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	struct strbuf sb;
 
 	strbuf_init(&sb, /*hint=*/ 0);
+	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		size_t buf_used;
@@ -2154,6 +2163,7 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	if (!pmu)
 		return NULL;
 
+	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		struct perf_event_attr attr = {.config = 0,};
-- 
2.44.0.683.g7961c838ac-goog


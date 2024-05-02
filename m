Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8DB1C65E1
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685726; cv=none; b=pNPZC0ESCjG4wbbg8sOaT0AV/RUuYx6jJgCWXTMac5v9gvNZ/UF/hpcDTCpmcT/gxjZTd4hyfDofXZFqRJ6eBXptqBV8+FQevwK+jjH7QLQheIY5fSIpb7HH971POGQ7llbjEz73g+AJY/+eAi4Me6E31rGHKa4KeYURLfihfuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685726; c=relaxed/simple;
	bh=Pei9FjfxNCt9/le6x5BPnnFpH/hEQXyCatDiI/W1Bzc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=WQ5kiz1ehbrSfzaExhjzr4MlW4TLTjixIFFtgwBeRuHL4bFn7bmN4vGFiO0+LG8OSEWnyRbXH9c1086EtKwbmJwgd9GmrdRrV19USG0P97UhTErxF8qmLYT4wRXNx5WjkDG3vwWoPqChb2uZLqNNS8Yr7YcJuy9c4T4Rw/s0m/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a7GV7zUd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7GV7zUd"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so19523264276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 02 May 2024 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714685724; x=1715290524; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SoTICCWwv6tX/HbgMsdPi7+zO/SiphKA5G7fH/pnoRM=;
        b=a7GV7zUdbysTXtPZUhGjyr2mndHosQOMsiQGmscNGvxZ1ea8pBf58mpzxK4f+Cz+Gx
         ChgTfnLqHyDDoeq1RHZiAWPhMvZ71VFa8I8k8iWIk8FZT9qfqFqDP829vr2aZvSuy88d
         MUhnD34hOFInA7JrlkUamK4wDjskEvChDTNx71mm0nF0nb3752jQzEmSMZ5k6+P6Hxxw
         YxuzNpLhGyj87ZpaZrAHzsbTE1vU7ubG6Lk9IdzGnAkDiSFAKvrwvKGpBAc2+N5P2skQ
         ghoEe05E8ChlMjuUZfrEHjVb+OreW4gL6bigZj1KEwUuwJicPd8umRHErFSKXe1mcDrk
         GkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685724; x=1715290524;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoTICCWwv6tX/HbgMsdPi7+zO/SiphKA5G7fH/pnoRM=;
        b=OmZQSFBeR3Twchxd6byQzEsVgug6VJX6i4R0XyFaFxmnxaofgzWicLJusYHBKIW/HK
         wbbhid8MHtwzgo9fyp69ML/Liwro6CIoAAE1i+dzLPQKoXyYLt12eSG+eyJgdnl3tF10
         BRg8bmWNV5ZTUeHwb1k5329U87j9RelmiXKPXjVxgIkUOUyDZxaMaW3tfyAV3yZouuHP
         2qWp2RMIv/F1+BHX/A/8Kd5JIdTB6LoAsp12mw2QNfGhOLacqX/YlKPmV+zDesJth7xn
         KNnYW1WpZXdNopkTNg9qpwsllNvTuPlv4WvJAdgOjnvj2/1SiOc2mBGG2Z+quyIPSXNb
         DVsg==
X-Forwarded-Encrypted: i=1; AJvYcCXNx6xqPtXgMb+uHF1egGy/R3ogCT5Y+2bQ/1PtjR0udHyM9ZMX9IBkinjtJhRGr5WZyc0v67q0PSUiveZP+MetIE5C+Wmlaxa0Cboyw0DJtA==
X-Gm-Message-State: AOJu0YwjMti7asRfdaVG3nQ9qXCu1rffP2CjD6nGaiKVxNj1tKTfQ3v2
	yBPjXRPO21X/7S6dQAJJ//mA3BKNhl21qvJesJUOaURz3Bf9ULc/IEXbJX2NHyAUfClgKqDPB3v
	/lFwZUw==
X-Google-Smtp-Source: AGHT+IFPDyIcGTsj+ZN2uF59ksuwxGJWvgfUhi/mm/njKwzy6Ue/D+z+knrRVjZ38wSxWjQwWJnDIX/IgZW3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:deba:378d:2d3a:2641])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:de4:7be7:1c2d with SMTP
 id w4-20020a056902100400b00de47be71c2dmr313438ybt.11.1714685723816; Thu, 02
 May 2024 14:35:23 -0700 (PDT)
Date: Thu,  2 May 2024 14:35:07 -0700
In-Reply-To: <20240502213507.2339733-1-irogers@google.com>
Message-Id: <20240502213507.2339733-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502213507.2339733-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v5 6/6] perf pmu: Assume sysfs events are always the same case
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
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
names are always either lower or uppercase. It uses file exists and
only loads the events when the desired event is present.

For the example above, the number of openat calls measured by perf
trace on a tigerlake laptop goes from 325 down to 255. The reduction
will be larger for machines with many PMUs, particularly replicated
uncore PMUs.

Ensure pmu_aliases_parse is called before all uses of the aliases
list, but remove some "pmu->sysfs_aliases_loaded" tests as they are
now part of the function.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7849be4bfea1..b3b072feef02 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -425,9 +425,30 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 {
 	struct perf_pmu_alias *alias;
 
-	if (load && !pmu->sysfs_aliases_loaded)
-		pmu_aliases_parse(pmu);
+	if (load && !pmu->sysfs_aliases_loaded) {
+		bool has_sysfs_event;
+		char event_file_name[FILENAME_MAX + 8];
 
+		/*
+		 * Test if alias/event 'name' exists in the PMU's sysfs/events
+		 * directory. If not skip parsing the sysfs aliases. Sysfs event
+		 * name must be all lower or all upper case.
+		 */
+		scnprintf(event_file_name, sizeof(event_file_name), "events/%s", name);
+		for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
+			event_file_name[i] = tolower(event_file_name[i]);
+
+		has_sysfs_event = perf_pmu__file_exists(pmu, event_file_name);
+		if (!has_sysfs_event) {
+			for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
+				event_file_name[i] = toupper(event_file_name[i]);
+
+			has_sysfs_event = perf_pmu__file_exists(pmu, event_file_name);
+		}
+		if (has_sysfs_event)
+			pmu_aliases_parse(pmu);
+
+	}
 	list_for_each_entry(alias, &pmu->aliases, list) {
 		if (!strcasecmp(alias->name, name))
 			return alias;
@@ -1717,9 +1738,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
 	size_t nr;
 
-	if (!pmu->sysfs_aliases_loaded)
-		pmu_aliases_parse(pmu);
-
+	pmu_aliases_parse(pmu);
 	nr = pmu->sysfs_aliases;
 
 	if (pmu->cpu_aliases_added)
@@ -1778,6 +1797,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	struct strbuf sb;
 
 	strbuf_init(&sb, /*hint=*/ 0);
+	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		size_t buf_used;
@@ -2193,6 +2213,7 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	if (!pmu)
 		return NULL;
 
+	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		struct perf_event_attr attr = {.config = 0,};
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


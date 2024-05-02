Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F11B966
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622502; cv=none; b=WyiGvtnxX2hmqaIlvM3IBFkYWK8yhAO0SAoIV3OsKXhDJK0c3jc4JFAitXIjvFCu4iqn8O/iNx0A0QFSyN556EdysBe6K75rE5eEkvGEe4ZeJi8ykwuU8p8eVR9q1xkdMFPX62SaHelAkv4bFsX5aTWFsMqUwNNYSc97NwK6Eiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622502; c=relaxed/simple;
	bh=D5OMauP5AuCov1guhgbdWScnCkzXcr/I299bo8RBj6k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=hXgFEvGvNeysYZpLDKlXUjGqD5jeLM7pC7E1gtCbJYxnVN83Tpxn/6oQ/qLnjb3OpLDwxTCHtxyTVY5ktkZ39hnGK07ag67yKLEooz1k2IZKSKqz3eHtC7Y4Ha8zY54hlm6+sc9jNZuDG1bFs8RJAmS+EC1Jze+GbQbNbFK+/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HdfEWEtL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdfEWEtL"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b028ae5easo144563417b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 01 May 2024 21:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714622500; x=1715227300; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zj5k9BmjFkiNlgtOsdr7K0ZIJlrTlzid/tiIdg6PkY0=;
        b=HdfEWEtLlPXV3FxXI7abed8OOsYp1973dsOjNct52Zz/LHUiwz4HfBvg1oMywk2hBM
         ya3nis1Oy6X9wkcPFzJ4yfFnvYo6ayAZpRJLf1nRlrjf+0bhWOSD7sR6RtDubrj2LzD0
         slIt5aDhRxZGjM4Pqa+W/aAHJYp0sBFyzbaMqQXpvFITNLqeibEVW/HATrYANePdFcbl
         UiGUFwJeARn+p6kK4Tp5JKWPCYNp8QmwE4WrjDG2YKQ1YdhWpuufRuk4G2YxmBRbJT1O
         +rEauZ19QuhTzXrF4y3hGNomxNDiCz6xZBPB14rBgW+VR3fL3zzhpUXBIP8fwVzRreCG
         eweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714622500; x=1715227300;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zj5k9BmjFkiNlgtOsdr7K0ZIJlrTlzid/tiIdg6PkY0=;
        b=H45cGAzf34QZsYLkbEQ6kRBODSjT8xvYA8ACu9WnawCHz7eZiSE+vpNHHJ/i97T78I
         ywKCOp3T6SIjTRIXL3DJtVMQcXBErXnYqD84G0iCH8aKY/kO6MaSAko2q5iyOVkdNkLI
         EavRdYralRyxDqjxPJ9BQi+i+7lUPCu1iAGQJm/xeatsDKT0DG2Hhvb1U6djYkwgCe0n
         kFzYZ7P2ttA1z5bhK87tcSShpz4CPL8iEMzbhz8FQyHSEc+Rb6SxkFhl50szLw4YYIk5
         KxVKZwlDqe3W/Z6G5dnbsbwm+qY2kxv1D9pvUmhPXchr2dnZxfBmMxx1lxeLjeoIL3f/
         zgYw==
X-Forwarded-Encrypted: i=1; AJvYcCUB/zAl+w7ZeUdC/PXHPxxQjwOiXgpOeri7iK1gP5VF/6BaSMdrx7fGN2eo7DtZF0KNU5ln6VV7yqSa6f0igpNzEGwuj0PvT+Bg7LuEFtoZ1w==
X-Gm-Message-State: AOJu0Yz+8iI/JRTT8K3hRJ6rExSf+icxb3PeHcPzhFmciQO0/fZabVIp
	urDV+rrwjIDnFHe2YporxhFt8awLU8wJ3GUp5KBaP3YXGsqykY+bkNpunJV/wd02u8oS2TiZkJU
	jk4Z3DA==
X-Google-Smtp-Source: AGHT+IGy993J8GFdln8sE7kiQrkDZ93nSMDEZ7PwjE7ki+RPa1Jf/e3JPjs+s3pUexiz3atQA+nO6NsljxC2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:53b9:bbda:1daa:17d3])
 (user=irogers job=sendgmr) by 2002:a81:5296:0:b0:61a:d355:168f with SMTP id
 g144-20020a815296000000b0061ad355168fmr210922ywb.5.1714622500327; Wed, 01 May
 2024 21:01:40 -0700 (PDT)
Date: Wed,  1 May 2024 21:01:10 -0700
In-Reply-To: <20240502040112.2111157-1-irogers@google.com>
Message-Id: <20240502040112.2111157-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502040112.2111157-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Subject: [PATCH v4 4/6] perf test pmu: Add an eagerly loaded event test
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

Allow events/aliases to be eagerly loaded for a PMU. Factor out the
pmu_aliases_parse to allow this. Parse a test event and check it
configures the attribute as expected. There is overlap with the
parse-events tests, but this test is done with a PMU created in a temp
directory and doesn't rely on PMUs in sysfs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  | 69 +++++++++++++++++++++++++------------
 2 files changed, 125 insertions(+), 21 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 424ebdb0f09d..6e18a4c447ce 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "evlist.h"
+#include "evsel.h"
 #include "parse-events.h"
 #include "pmu.h"
 #include "tests.h"
@@ -54,6 +56,9 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 		{ "krava22", "config2:8,18,48,58\n", },
 		{ "krava23", "config2:28-29,38\n", },
 	};
+	const char *test_event = "krava01=15,krava02=170,krava03=1,krava11=27,krava12=1,"
+		"krava13=2,krava21=119,krava22=11,krava23=2\n";
+
 	char name[PATH_MAX];
 	int dirfd, file;
 	struct perf_pmu *pmu = NULL;
@@ -116,6 +121,24 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 		close(file);
 	}
 
+	/* Create test event. */
+	if (mkdirat(dirfd, "perf-pmu-test/events", 0755) < 0) {
+		pr_err("Failed to mkdir PMU events directory\n");
+		goto err_out;
+	}
+	file = openat(dirfd, "perf-pmu-test/events/test-event", O_WRONLY | O_CREAT, 0600);
+	if (!file) {
+		pr_err("Failed to open for writing file \"type\"\n");
+		goto err_out;
+	}
+	len = strlen(test_event);
+	if (write(file, test_event, len) < len) {
+		close(file);
+		pr_err("Failed to write to 'test-event' file\n");
+		goto err_out;
+	}
+	close(file);
+
 	/* Make the PMU reading the files created above. */
 	pmu = perf_pmus__add_test_pmu(dirfd, "perf-pmu-test");
 	if (!pmu)
@@ -176,8 +199,62 @@ static int test__pmu_format(struct test_suite *test __maybe_unused, int subtest
 	return ret;
 }
 
+static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	char dir[PATH_MAX];
+	struct parse_events_error err;
+	struct evlist *evlist;
+	struct evsel *evsel;
+	struct perf_event_attr *attr;
+	int ret;
+	struct perf_pmu *pmu = test_pmu_get(dir, sizeof(dir));
+	const char *event = "perf-pmu-test/test-event/";
+
+
+	if (!pmu)
+		return TEST_FAIL;
+
+	evlist = evlist__new();
+	if (evlist == NULL) {
+		pr_err("Failed allocation");
+		goto err_out;
+	}
+	parse_events_error__init(&err);
+	ret = parse_events(evlist, event, &err);
+	if (ret) {
+		pr_debug("failed to parse event '%s', err %d\n", event, ret);
+		parse_events_error__print(&err, event);
+		ret = TEST_FAIL;
+		if (parse_events_error__contains(&err, "can't access trace events"))
+			ret = TEST_SKIP;
+		goto err_out;
+	}
+	evsel = evlist__first(evlist);
+	attr = &evsel->core.attr;
+	if (attr->config  != 0xc00000000002a823) {
+		pr_err("Unexpected config value %llx\n", attr->config);
+		goto err_out;
+	}
+	if (attr->config1 != 0x8000400000000145) {
+		pr_err("Unexpected config1 value %llx\n", attr->config1);
+		goto err_out;
+	}
+	if (attr->config2 != 0x0400000020041d07) {
+		pr_err("Unexpected config2 value %llx\n", attr->config2);
+		goto err_out;
+	}
+
+	ret = TEST_OK;
+err_out:
+	parse_events_error__exit(&err);
+	evlist__delete(evlist);
+	test_pmu_put(dir, pmu);
+	return ret;
+}
+
 static struct test_case tests__pmu[] = {
 	TEST_CASE("Parsing with PMU format directory", pmu_format),
+	TEST_CASE("Parsing with PMU event", pmu_events),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index fbbc535ed93f..7849be4bfea1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -597,33 +597,18 @@ static inline bool pmu_alias_info_file(const char *name)
  * Reading the pmu event aliases definition, which should be located at:
  * /sys/bus/event_source/devices/<dev>/events as sysfs group attributes.
  */
-static int pmu_aliases_parse(struct perf_pmu *pmu)
+static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 {
-	char path[PATH_MAX];
 	struct dirent *evt_ent;
 	DIR *event_dir;
-	size_t len;
-	int fd, dir_fd;
 
-	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
-	if (!len)
-		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/events", pmu->name);
-
-	dir_fd = open(path, O_DIRECTORY);
-	if (dir_fd == -1) {
-		pmu->sysfs_aliases_loaded = true;
-		return 0;
-	}
-
-	event_dir = fdopendir(dir_fd);
-	if (!event_dir){
-		close (dir_fd);
+	event_dir = fdopendir(events_dir_fd);
+	if (!event_dir)
 		return -EINVAL;
-	}
 
 	while ((evt_ent = readdir(event_dir))) {
 		char *name = evt_ent->d_name;
+		int fd;
 		FILE *file;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
@@ -635,7 +620,7 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 		if (pmu_alias_info_file(name))
 			continue;
 
-		fd = openat(dir_fd, name, O_RDONLY);
+		fd = openat(events_dir_fd, name, O_RDONLY);
 		if (fd == -1) {
 			pr_debug("Cannot open %s\n", name);
 			continue;
@@ -653,11 +638,50 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 	}
 
 	closedir(event_dir);
-	close (dir_fd);
 	pmu->sysfs_aliases_loaded = true;
 	return 0;
 }
 
+static int pmu_aliases_parse(struct perf_pmu *pmu)
+{
+	char path[PATH_MAX];
+	size_t len;
+	int events_dir_fd, ret;
+
+	if (pmu->sysfs_aliases_loaded)
+		return 0;
+
+	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	if (!len)
+		return 0;
+	scnprintf(path + len, sizeof(path) - len, "%s/events", pmu->name);
+
+	events_dir_fd = open(path, O_DIRECTORY);
+	if (events_dir_fd == -1) {
+		pmu->sysfs_aliases_loaded = true;
+		return 0;
+	}
+	ret = __pmu_aliases_parse(pmu, events_dir_fd);
+	close(events_dir_fd);
+	return ret;
+}
+
+static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
+{
+	char path[FILENAME_MAX + 7];
+	int ret, events_dir_fd;
+
+	scnprintf(path, sizeof(path), "%s/events", pmu->name);
+	events_dir_fd = openat(sysfs_fd, path, O_DIRECTORY, 0);
+	if (events_dir_fd == -1) {
+		pmu->sysfs_aliases_loaded = true;
+		return 0;
+	}
+	ret = __pmu_aliases_parse(pmu, events_dir_fd);
+	close(events_dir_fd);
+	return ret;
+}
+
 static int pmu_alias_terms(struct perf_pmu_alias *alias, int err_loc, struct list_head *terms)
 {
 	struct parse_events_term *term, *cloned;
@@ -1042,6 +1066,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 
 	perf_pmu__arch_init(pmu);
 
+	if (eager_load)
+		pmu_aliases_parse_eager(pmu, dirfd);
+
 	return pmu;
 err:
 	zfree(&pmu->name);
-- 
2.45.0.rc0.197.gbae5840b3b-goog


Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471A1F956
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Dec 2025 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765074231; cv=none; b=ibE/34eZKSaB9wfvFwO1VEfukh7ct7PYw3ZDEta057yhhXjq02yl0MsPaUOuxpa8U5IvHW55FjuLY4n5dMd2og25xSQhEY2c5tgH1mnNUYrFkjh8pn9zQoHSLK5YcFag4rZ8mM7PH9NA9lgkPyPAe1k+jVihioW2UmbAcLgrqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765074231; c=relaxed/simple;
	bh=6o9pGBnHlXFvBgZNvxTYG5hdLg8Lc8RAyepBuDI614g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=C+a1++4FIvpSwFK3qaUOXJv7fg1v3eo/cgQjYm5PDmtTUCYkScooGm+/GB6I2vhuNNANW2DiwDhm+Qv80dYE/q+sq71dl0ox4CyIHyG4+hH32caMLVEQtVwQ8dqUaYh/QvbCsxT2bnfjFahwOCPDfFv02BQa82KdoSOfDxMzqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2Wt9XXD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2Wt9XXD"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29809acd049so80266855ad.3
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Dec 2025 18:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765074229; x=1765679029; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e/BpikQAuzfkcicgmAn22YMgdzTScgVjWtNgIDkUOP4=;
        b=I2Wt9XXD9eEa2RweDC8mGba+H1y/tsz9toO3C8omkSMFTKXqeuDBa6NmpPKyIHfaiI
         VWAmLGSAUDX0uHFrDNOyv2WRq6FUI8sbtityNojTEwfGcDbB4OWZ9dcsjEYKvbkwOb23
         suy4fy8NJ4c16sDpTTY8vYxaicIkCKz4cDuPPGb4J0Er0wQOTZbGEbR5hcPIvADmwAMD
         RjSoQUi/H4uUlhJjifkm/XxbqPfZWH5xQq27Bxcg3SxWuBRZjTXTQAWyoHt8aBcAiIWr
         enARAKzylUS1DvUI8m3/ZszMCufNI8q/ry2eO7GgoMU4ayq+MdN2v0h0sZkMUZXX+kDW
         EAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765074229; x=1765679029;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/BpikQAuzfkcicgmAn22YMgdzTScgVjWtNgIDkUOP4=;
        b=QtxXDO+/Q1N1QYPtoCWbR0hUgY2dTGG3mXWOkNGIx8smrZkI9TQ/ttqPeOtJ+i3oK1
         jcGOwvcRotIBXUKfqkyUfHIWRSER6ypTlon3L1PXNxfjTS95uihlwDx3wVA702hR/pec
         18C4k1wL491zDjA0KGGypK7nt9Rma3EkBdlmpi0qHmw70LJGU1hPDIZ/WChBW7uSYV85
         T6LJ+j5Y0AQZs17HQTJtk+e8T2DjJvrjjdAOiNRol0MODZiZRgpTPexVNFywhLhytFip
         oYv9T+P0R78q/yvFCTRjQIP2aRUjmqQjmY38Uvf8nlXETH25rbauQExEALC+vgilece4
         1XuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb0BcxMKHPqB8U9o/GIcOI/CuS/T5oupd6+UQvM5Y6Lr6YIUqCC97L3SZLPb3CsO14RJbTwkxcQMBQZjR4Y6J8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3IbLgsvHgjFoIgT4DcZBTg73szEtpxQG8T3cKNsAuJYC54MY4
	PSWJXOzYXb+uw2JcSc6PoA8WNXUCyt5F9xNpemfYez5K9qENXKnG4sjRe0k/VCpZVBeJVg2RvYu
	lsZkjqoXRLA==
X-Google-Smtp-Source: AGHT+IEr+61enQIXyJ6lmMhSQMQenMiFghJUQnyrvrvjfSmsiJ4rnAvPxNH3vjvYqPAxjr6fms1GSZsQ8X1V
X-Received: from dlbbk31.prod.google.com ([2002:a05:7022:429f:b0:11d:cf4c:62ab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b85:b0:11b:a3a7:65be
 with SMTP id a92af1059eb24-11e0325ef2emr2716987c88.16.1765074228814; Sat, 06
 Dec 2025 18:23:48 -0800 (PST)
Date: Sat,  6 Dec 2025 18:23:45 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251207022345.909535-1-irogers@google.com>
Subject: [PATCH v1] perf symbol: Fix ENOENT case for filename__read_build_id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some callers of filename__read_build_id assume the error value must be
-1, fix by making them handle all < 0 values.

If is_regular_file fails in filename__read_build_id then it could be
the file is missing (ENOENT) and it would be wrong to return
-EWOULDBLOCK in that case. Fix the logic so -EWOULDBLOCK is only
reported if other errors with stat haven't occurred.

Fixes: 834ebb5678d7 ("perf tools: Don't read build-ids from non-regular files")
Signed-off-by: Ian Rogers <irogers@google.com>
---
Note, a shorter version of this patch appeared in a series
cleaning/refactoring the build id reading code:
https://lore.kernel.org/lkml/20251201205509.195451-11-irogers@google.com/
It is sent without the refactor for the sake of fixing the bug in an
earlier release.
---
 tools/perf/builtin-buildid-cache.c | 6 ++++--
 tools/perf/util/libbfd.c           | 4 +++-
 tools/perf/util/symbol-elf.c       | 4 +++-
 tools/perf/util/symbol-minimal.c   | 4 +++-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index c98104481c8a..539e779e3268 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -276,12 +276,14 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 {
 	char filename[PATH_MAX];
 	struct build_id bid = { .size = 0, };
+	int err;
 
 	if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
 		return true;
 
-	if (filename__read_build_id(filename, &bid) == -1) {
-		if (errno == ENOENT)
+	err = filename__read_build_id(filename, &bid);
+	if (err < 0) {
+		if (err == -ENOENT)
 			return false;
 
 		pr_warning("Problems with %s file, consider removing it from the cache\n",
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 0099b415decc..edf0829e9635 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -391,8 +391,10 @@ int libbfd__read_build_id(const char *filename, struct build_id *bid)
 
 	if (!filename)
 		return -EFAULT;
+
+	errno = 0;
 	if (!is_regular_file(filename))
-		return -EWOULDBLOCK;
+		return errno == 0 ? -EWOULDBLOCK : -errno;
 
 	fd = open(filename, O_RDONLY);
 	if (fd < 0)
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 957143fbf8a0..d1dcafa4b3b8 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -902,8 +902,10 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 
 	if (!filename)
 		return -EFAULT;
+
+	errno = 0;
 	if (!is_regular_file(filename))
-		return -EWOULDBLOCK;
+		return errno == 0 ? -EWOULDBLOCK : -errno;
 
 	err = kmod_path__parse(&m, filename);
 	if (err)
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index c6b17c14a2e9..8221dc9868f7 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -104,8 +104,10 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 
 	if (!filename)
 		return -EFAULT;
+
+	errno = 0;
 	if (!is_regular_file(filename))
-		return -EWOULDBLOCK;
+		return errno == 0 ? -EWOULDBLOCK : -errno;
 
 	fd = open(filename, O_RDONLY);
 	if (fd < 0)
-- 
2.52.0.223.gf5cc29aaa4-goog


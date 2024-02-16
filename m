Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12514A0B7
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Feb 2024 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127720; cv=none; b=NNfdnphTt9z2KQAPxvrl/qRQT1tKYMdhfMdiuR8X/7/IlV3iQl/CQ9o6nARBGbiodcqph0Y1XymqTAodf3/GGrZVUteAdBxbY54GHZXJdGB37WLyNnjKbxuGc1uZWZZIDMaWeB4JM0VFkAXfPbAh6GCf7Aaf/it6bzUwLEBIjvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127720; c=relaxed/simple;
	bh=mlDvuBmPP3TrmLBy1TVdW9K7nfBnqAONps2iWBo5bv4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=p0gLK2fbb1rq+2MKxFMutDcbECC+bmBC6G/0Iruu7t+qJocCxFpt/x5hQ6Mqb+c0ZJw0G8xjZeX85RVnDT1s5HDUKxGGeySd7mteCqR4plRcd7ihtl5cfS2WAG26NQJ0SntRzey0tulIFsTV7OabNYInQCT516P7+Wkl564oeAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ACuy2cBZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ACuy2cBZ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d9a541b720aso4323356276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Feb 2024 15:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708127717; x=1708732517; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5lEV9flhamU87tdGpQxKOQUuN3cEGzsZvh7EhlSuOZU=;
        b=ACuy2cBZWhiTW9+iKRzz655YFWBTVgzPe+DXgBwi1Ie6wzzjfJJikFzV9VyIzOa04C
         ThrU24fX5R6o2JIeR613xK/c57JHWCEEJCiS75QExDwZFMnvNvhfzT/yuu6vOwqigEkq
         h4kjYkhcANSFBveK1PTOYRX5hkzQPl20spH3AQTPNYZZVzJvgQqzM5QNaHjNdmp4yKOP
         exmPdVqYiV3REVqSmtA/6ndsN3yDkX+bonf3bVGSBIEt6/7dc7arnMjvjZXGuMPejJGo
         ItGGHEg4x+8NTbP7GG/p6FL7nkG9P8SWKxcLj2EcGoqw7qlfmgQEWqb51QnoM+1W0m3r
         ttmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708127717; x=1708732517;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lEV9flhamU87tdGpQxKOQUuN3cEGzsZvh7EhlSuOZU=;
        b=iTjd9IlwY5KwvQpFfSXKcF8UYwNFFLH6URyaXYbGJ5+dnCn00JBU4XP/jubJnHSKYw
         nsiX+C/lqDeyjKu4egicgm55wWkzKr+d5SUn5e3COpoBctCl9KQorrEt/U5lsm8gsQqu
         YMn5ZKGjrbYZe3rlZmxPfxIboulF53IMCY2wCx3WQvWGyhpiJ7C2OvP1kAAcQfbhXllM
         VHTYVCYlU5tNoYAWPiLkGf8rniryIiwio64Ql23p/uYdMEp/2vBNky/myAtxDp8h2Eej
         2iaJ6PjLDpUbGfR/uUl98MdrOvMvmIBU4F55F4ADnfd2uJgB6/1zM4c09utSSIY7OaRH
         Qppg==
X-Forwarded-Encrypted: i=1; AJvYcCWi6Su5vXydK1RcGvRjMbpIEZ8Pr3QgFmKCy7lDZsZrMIOGD5xM1xfpAyYQcLqrvHzR+zAsV5gKTlawhYw27MivgzpCrAKyzxJtdSxJO8ekQw==
X-Gm-Message-State: AOJu0YzGD9jd8nIWwyOB65JEPIds/fY2igGcKzF8+vlz4/j5GbxWfM7t
	ecK9LGSVBEWsh9zzmchNDsZa0dORy+bTmyjeCc0B/Jrrc5TqwBQskwk9htfYBYnjGteHYg4zNkR
	GUYuzQA==
X-Google-Smtp-Source: AGHT+IEUu7ZIc4xVQBBz95yM/6If+AfmIrGt97iohTygKIEoa3vU8cULrj/7pehsYjAaNFO5DYaZGw3d50RX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4b5c:352:4272:e34e])
 (user=irogers job=sendgmr) by 2002:a25:b20e:0:b0:dc6:ff54:249f with SMTP id
 i14-20020a25b20e000000b00dc6ff54249fmr1454658ybj.8.1708127717121; Fri, 16 Feb
 2024 15:55:17 -0800 (PST)
Date: Fri, 16 Feb 2024 15:51:56 -0800
In-Reply-To: <20240216235203.229256-1-irogers@google.com>
Message-Id: <20240216235203.229256-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240216235203.229256-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v5 2/8] perf list: Add scandirat compatibility function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

scandirat is used during the printing of tracepoint events but may be
missing from certain libcs. Add a compatibility implementation that
uses the symlink of an fd in /proc as a path for the reliably present
scandir.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print-events.c | 12 +++---------
 tools/perf/util/util.c         | 19 +++++++++++++++++++
 tools/perf/util/util.h         |  8 ++++++++
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 9e47712507cc..bf79dd366e2e 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -63,6 +63,8 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 {
 	char *events_path = get_tracing_file("events");
 	int events_fd = open(events_path, O_PATH);
+	struct dirent **sys_namelist = NULL;
+	int sys_items;
 
 	put_tracing_file(events_path);
 	if (events_fd < 0) {
@@ -70,10 +72,7 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 		return;
 	}
 
-#ifdef HAVE_SCANDIRAT_SUPPORT
-{
-	struct dirent **sys_namelist = NULL;
-	int sys_items = tracing_events__scandir_alphasort(&sys_namelist);
+	sys_items = tracing_events__scandir_alphasort(&sys_namelist);
 
 	for (int i = 0; i < sys_items; i++) {
 		struct dirent *sys_dirent = sys_namelist[i];
@@ -130,11 +129,6 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 	}
 
 	free(sys_namelist);
-}
-#else
-	printf("\nWARNING: Your libc doesn't have the scandirat function, please ask its maintainers to implement it.\n"
-	       "         As a rough fallback, please do 'ls %s' to see the available tracepoint events.\n", events_path);
-#endif
 	close(events_fd);
 }
 
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index c1fd9ba6d697..4f561e5e4162 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -552,3 +552,22 @@ int sched_getcpu(void)
 	return -1;
 }
 #endif
+
+#ifndef HAVE_SCANDIRAT_SUPPORT
+int scandirat(int dirfd, const char *dirp,
+	      struct dirent ***namelist,
+	      int (*filter)(const struct dirent *),
+	      int (*compar)(const struct dirent **, const struct dirent **))
+{
+	char path[PATH_MAX];
+	int err, fd = openat(dirfd, dirp, O_PATH);
+
+	if (fd < 0)
+		return fd;
+
+	snprintf(path, sizeof(path), "/proc/%d/fd/%d", getpid(), fd);
+	err = scandir(path, namelist, filter, compar);
+	close(fd);
+	return err;
+}
+#endif
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 7c8915d92dca..9966c21aaf04 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -6,6 +6,7 @@
 /* glibc 2.20 deprecates _BSD_SOURCE in favour of _DEFAULT_SOURCE */
 #define _DEFAULT_SOURCE 1
 
+#include <dirent.h>
 #include <fcntl.h>
 #include <stdbool.h>
 #include <stddef.h>
@@ -56,6 +57,13 @@ int perf_tip(char **strp, const char *dirpath);
 int sched_getcpu(void);
 #endif
 
+#ifndef HAVE_SCANDIRAT_SUPPORT
+int scandirat(int dirfd, const char *dirp,
+	      struct dirent ***namelist,
+	      int (*filter)(const struct dirent *),
+	      int (*compar)(const struct dirent **, const struct dirent **));
+#endif
+
 extern bool perf_singlethreaded;
 
 void perf_set_singlethreaded(void);
-- 
2.44.0.rc0.258.g7320e95886-goog


Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D9C10A24
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707886478; cv=none; b=Bd1c4UUg3LZJmDYpDWECBoP/UFsBh2UnaL5lnxJOdghYbQpXw+BQwxSykvETl3Xlzum8MWp8/SuddrHzVTJ0tKinac38Yi8ICdJKgvBpyDcVl5gF+IPE70IdaMShtwMI+dciUL+RTcf/G3AmG63b4y+Rbs2KoZjohyRQcNhUM7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707886478; c=relaxed/simple;
	bh=NhiwdSNsgGhanFThf3Y8+0MhiUWCknICtVTm6IyvRmw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TAaxskLtKMsEGgjIOXEIwKqsrSnWjPh/YbR8TP9B03LEGKsoIXQ+Ujg1Ly4wiRrhNqWa/XZYHZxSi2myjYg0cODWL3XTfm9abYYy9CAgRFnz0ovqT2Bae8GXu8mLY/NBYROBKxQN6CPNsONjKt/usKymneeJ7UaVI8nYZ0AWGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1xGd8ewx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1xGd8ewx"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60770007e52so36010657b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Feb 2024 20:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707886476; x=1708491276; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmSZNQ356QtM9WesWCMinXmK9k2yULQ13GYKx7NLJhc=;
        b=1xGd8ewx+6QMWMCOnsEdqMLKF2N81vwpOJk7nUzwCgdEYXsLrTJ+FvcIBrAaaK0lR8
         OdMY2SIRkPKDvbaN3kpV+gyiHeUQ3yRTZoz1mjG8gYUEJ17CBxBR9rVa0lrF7+uUqODs
         62fDERGEZcArpHvYVrZLkGPkirMca7cqqdND83MY4HlQSdnKDWM66nzIBG5gGTuH1Fbz
         zrQoakOgLq3ugaAcRwzYXOfXAkTkzM1IfveEWAJkjZUx/XMnXjS+xUXFVy/EZTRV5Mpm
         m4n2rf6GgWIWvxIc4gY8sGqF30Bw/bt+//CYY9KPgYhwRkj5wF/ddt9cikvbcpISDtvA
         xpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707886476; x=1708491276;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmSZNQ356QtM9WesWCMinXmK9k2yULQ13GYKx7NLJhc=;
        b=hJhan+dyIxoeKaFpR8KPJlBexMVTp7DXlP/055pGHmw/7Mu3+Gs4vy79dDLcCCyYRS
         sBjc7Gi/61Bauk0hqpY8JimgMQaW+kqj4ALG9Rhc0LU3Lys22/thbqMSGYYd8A3Nybqy
         d9CIqBlC+8U+F3fqnSprxscJRJ3SrbT8ft4L+R+v6Lu5WeBM6XehWy8Re61UO6+1+GPS
         Y8PzPlqA8FqtPkBDe095eebUgud4EZEmj31kKJOamQPWwVXlsto2fs8H2Tz5pxz+gTVb
         PjM88AYHoaMEmsUnLYNfABmOqhfZuxDzlBb6uSvtygfY2KGsQxBKhwR033jqIVU+QQil
         Mghw==
X-Forwarded-Encrypted: i=1; AJvYcCXwPKARDePtHXWotLu7OYVk1XvLqPEr9OG90wJPS9Py0/nbabtz4t12BChqgbY7KBqrzdfcRstsEgDL6vWDHjSEINrKpArWZm5PQ69fTSjD7w==
X-Gm-Message-State: AOJu0YyU13Xt1s2UKCK+PfTXgU9qsSmS/VRgjd+78vcsctu5YhOc1LLH
	wFV/OQPTVn5cl5iiupYrz8FZSM8goCg56eIINZdQq65O+nV0b7IrWcrscFbo9cRqQ8j2FJzNEAl
	xXNatfQ==
X-Google-Smtp-Source: AGHT+IEFuvHaqaekRipzgHS56dLK9shPHnKIKYxXCRw4dh0QDC9cp+ued3K17AtYGH6E73IBBe9HedDMpOlG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a0d:eb15:0:b0:602:b7ce:f382 with SMTP id
 u21-20020a0deb15000000b00602b7cef382mr240294ywe.7.1707886476058; Tue, 13 Feb
 2024 20:54:36 -0800 (PST)
Date: Tue, 13 Feb 2024 20:53:50 -0800
In-Reply-To: <20240214045356.748330-1-irogers@google.com>
Message-Id: <20240214045356.748330-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214045356.748330-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v4 2/8] perf list: Add scandirat compatibility function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
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
2.43.0.687.g38aa6559b0-goog


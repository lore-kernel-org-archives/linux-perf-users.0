Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8JEMtLN"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92668D63
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Dec 2023 15:50:42 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d0c4ba7081so48828437b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Dec 2023 15:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701474642; x=1702079442; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLMuugMS+2QSw9nEPVn5F8ycyfLnIiKmkZECZ6NVJPs=;
        b=F8JEMtLNcOAqtpVZJPdnhpNL2IHrqAvx5lYzB+J9OKhVni/fbrYCdvC6bLSkOlJ7uH
         qlCGRQHt8nY1BQQYLqhtR7pQfHyr/SPpgSyPiigafqtUBiMACTBcd12SqzRqHGElFkqx
         qQ49oZYyovGNyPqoTy/yexl6JcTOCdE/3CqebFtLE+9YYnu1ZEx/y0XN2iYqAqCuL8j6
         E+B+7GCYbDO1gI5Z2NU4wkD1I3GQoktgXpAvbgXjFJwIgYCcsYVz6qMFuYw/2KNSFyV0
         ReTQ9AShSpHnqE/ESHqc1qh0Mv0jD8c481qrLyIgoue61pEFJZ8uxIf7sTEVsH9sEk6A
         w5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474642; x=1702079442;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLMuugMS+2QSw9nEPVn5F8ycyfLnIiKmkZECZ6NVJPs=;
        b=OkGL8iqGqCfMjp14pszexAm9YhIFAOhzTVF0ut9d/xR+cZqRYOpSnehzTl3LDKWHJq
         uE6xqjdTy5j9g5bkLFC54XK8oCgx2AwuKuCTpT+JJ0fV7NIvhWEECQpUMQF/ks1PUwa/
         PsloL/eHjWZ5YMr9lqzv6yTixDFrsohFiE43Lr+tMvdbDZ7B4i6K71ttPuSyKzUpKgIr
         gJ8BgSj4Qjn6q9XUaSjOBl/iGBmNhJhZDNOHCduiapy3QDfvJp48v/XvGYUlRcJ15K7d
         cHLMCWH6Rrn/bKuOmEjQDdVZxjN26KSVtFqIyaMHYtWgnqvIJgsXqVXG8s/L+zqWiAQ8
         sqJw==
X-Gm-Message-State: AOJu0Yw8ar6BdUFwq1AYDZDG+ikan3k26q59uALT8DnPtH5egdHgbXNu
	Rut+OofF2eh3/lF7An3j9ALAo2qNoGfr
X-Google-Smtp-Source: AGHT+IHSKV/9LPaj9BTvOKMmF9QTWwBDBPJWjhyYWUeVCRViwcQF6/0CnJQ7mudoRnAwz3MkrWv9XN3DHyzE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:df3:224b:7b7f:efc5])
 (user=irogers job=sendgmr) by 2002:a05:690c:2d06:b0:5d4:1e95:1e8a with SMTP
 id eq6-20020a05690c2d0600b005d41e951e8amr114629ywb.4.1701474641878; Fri, 01
 Dec 2023 15:50:41 -0800 (PST)
Date: Fri,  1 Dec 2023 15:50:24 -0800
In-Reply-To: <20231201235031.475293-1-irogers@google.com>
Message-Id: <20231201235031.475293-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201235031.475293-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 2/9] perf list: Add scandirat compatibility function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
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
index b0fc48be623f..15ec55b07bfd 100644
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
2.43.0.rc2.451.g8631bc7472-goog


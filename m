Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB3158DDA
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018523; cv=none; b=qghw92gJagaXAZyyWsZcCCkQoBcy9sHwudtK4Zr/HYbQlig+ecT8jSVz4dTfgXOMtujLVq7MlChvtwNuEUwgoXac3jY8+2gR5gEEjaQfribHM+kBJUUyP5i+NiVaOrfKm117T+unYehBFv76kqWUDqJqhjm/3n/jNGCZ6TJ3xnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018523; c=relaxed/simple;
	bh=EnPZ72Jy6PLP4dTT506sUjost8vtZko8wVVrrNdjs5c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bCjKmZHWM3y1sBokLCo0/BevekS/yvjXHJy90W4LD0yFE572YK/qM2GKVaZ5Lg8fSyoPc1kV7MFV9PfImBy3581TKWkVexCvaRV13PhGVvdNtHnECFoK/VcZZ83iKG9s87bFJnmptFJULYF7Yeu2FCNvFJlpqqVFqjCfCcFIB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yfwWygja; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yfwWygja"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be5d44307so41152187b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 May 2024 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715018521; x=1715623321; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q472qqxF5ihtJmhy47OpIos2OiFBFiIxQhyS5d/9W5Q=;
        b=yfwWygjaPBRfQFbZeFwOPe6oKCgwDK5i7Pub+ibHpPsDhRhl+cGkB8jWUQKv6G9e6p
         UjsELKKU0ePMbXF0pjzuzqjOxsAUP/BBEYYH3S3myG3UXdxH32Kpx93mm96KvkkYKYWd
         g5QBdwuts/lwu+9P4g6Cqu8h7SGIgKvBXfKaiSXDFDHwzCM7qIpO4W7w/hxrELrwokGE
         hPKNnj5qElue5RbGTTUCyN7vrWcejAI4qd1oZ3ArbxWkRmu3IdwXzIfge0hzzgkx+et4
         7UGbS/6ZGMj0ZmT++g1T3/v9VT90Lk8bsI+E/dVz7DSsPtgHQ58kOCEOw5IwGUFvWP/e
         B03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018521; x=1715623321;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q472qqxF5ihtJmhy47OpIos2OiFBFiIxQhyS5d/9W5Q=;
        b=T2RPZjDp+6ody0/FXSs48QFHk7B/djNHRKluzkG1G0LH4wbTrYIF5Hrd5DvhfiUXuO
         HVivs73Qn6u5VNTOBJdQUahQi/DkamLt+JesWDzze4uTpXRvAtNiPZdNcmku+6LSuMKE
         tJpb/u1C/09oiPPGkr0SK7Nsmj8vr+vMv5vVeytn7o3qBeVpex9/A5vZIz3Q5u+F/Pn2
         JdaMZyt5iEi1HNeBpz3cH3JGpmkLqHcrYsji3L5kkbQhfMTOEtXOUN6u/vTlVL/ReXvM
         1oh2NGOD8OAVgrDyKFTPRU3OklDK+WMuRqy4i5ewrJVTwbqBh+p/K0vpZYVuxDYAEP6d
         e3IA==
X-Forwarded-Encrypted: i=1; AJvYcCV+p5472e6gR6Q3oCJJymeikeuPXDk00QffZ4aXGRscpSWzNwxQYAoxfclCf9Xq4fj37EMXOxi1OsrqXwCiIzTIHEOhCK/r62NOS42R/ZEkzw==
X-Gm-Message-State: AOJu0Ywabk87+PWGIuMIBuDvC6VYTDKIkVVJ57uD8/Z2G7Jd4605UWj2
	ZxItMbgsjKgh/mBjmddtA2QzmStt5XB6Kh2xzQ7/EKtTyh6uukSE+q1a/lwwqrCq8AgJ8e8DFoL
	OCjuFCg==
X-Google-Smtp-Source: AGHT+IEeO4AWB5B5D068fGnz9janYAk7jmAAzSDgkgTwNJ2PoWAwP8T6RPgewaZyqLob0DyUiRV+DTkEyaGC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91df:9b7f:c8d8:409a])
 (user=irogers job=sendgmr) by 2002:a25:b311:0:b0:dc6:44d4:bee0 with SMTP id
 l17-20020a25b311000000b00dc644d4bee0mr1359444ybj.7.1715018521035; Mon, 06 May
 2024 11:02:01 -0700 (PDT)
Date: Mon,  6 May 2024 11:01:04 -0700
In-Reply-To: <20240506180104.485674-1-irogers@google.com>
Message-Id: <20240506180104.485674-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506180104.485674-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v7 4/4] perf dso: Use container_of to avoid a pointer in dso_data
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Changbin Du <changbin.du@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The dso pointer in dso_data is necessary for reference count checking
to account for the dso_data forming a global list of open dso's with
references to the dso. The dso pointer also allows for the indirection
that reference count checking needs. Outside of reference count
checking the indirection isn't needed and container_of is more
efficient and saves space.

The reference count won't be increased by placing items onto the
global list, matching how things were before the reference count
checking change, but we assert the dso is in dsos holding it live (and
that the set of open dsos is a subset of all dsos for the
machine). Update the DSO data tests so that they use a dsos struct to
make the invariant true.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/dso-data.c | 60 ++++++++++++++++++-------------------
 tools/perf/util/dso.c       | 16 +++++++++-
 tools/perf/util/dso.h       |  2 ++
 3 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index fde4eca84b6f..5286ae8bd2d7 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -10,6 +10,7 @@
 #include <sys/resource.h>
 #include <api/fs/fs.h>
 #include "dso.h"
+#include "dsos.h"
 #include "machine.h"
 #include "symbol.h"
 #include "tests.h"
@@ -123,9 +124,10 @@ static int test__dso_data(struct test_suite *test __maybe_unused, int subtest __
 	TEST_ASSERT_VAL("No test file", file);
 
 	memset(&machine, 0, sizeof(machine));
+	dsos__init(&machine.dsos);
 
-	dso = dso__new((const char *)file);
-
+	dso = dso__new(file);
+	TEST_ASSERT_VAL("Failed to add dso", !dsos__add(&machine.dsos, dso));
 	TEST_ASSERT_VAL("Failed to access to dso",
 			dso__data_fd(dso, &machine) >= 0);
 
@@ -170,6 +172,7 @@ static int test__dso_data(struct test_suite *test __maybe_unused, int subtest __
 	}
 
 	dso__put(dso);
+	dsos__exit(&machine.dsos);
 	unlink(file);
 	return 0;
 }
@@ -199,41 +202,35 @@ static long open_files_cnt(void)
 	return nr - 1;
 }
 
-static struct dso **dsos;
-
-static int dsos__create(int cnt, int size)
+static int dsos__create(int cnt, int size, struct dsos *dsos)
 {
 	int i;
 
-	dsos = malloc(sizeof(*dsos) * cnt);
-	TEST_ASSERT_VAL("failed to alloc dsos array", dsos);
+	dsos__init(dsos);
 
 	for (i = 0; i < cnt; i++) {
-		char *file;
+		struct dso *dso;
+		char *file = test_file(size);
 
-		file = test_file(size);
 		TEST_ASSERT_VAL("failed to get dso file", file);
-
-		dsos[i] = dso__new(file);
-		TEST_ASSERT_VAL("failed to get dso", dsos[i]);
+		dso = dso__new(file);
+		TEST_ASSERT_VAL("failed to get dso", dso);
+		TEST_ASSERT_VAL("failed to add dso", !dsos__add(dsos, dso));
+		dso__put(dso);
 	}
 
 	return 0;
 }
 
-static void dsos__delete(int cnt)
+static void dsos__delete(struct dsos *dsos)
 {
-	int i;
-
-	for (i = 0; i < cnt; i++) {
-		struct dso *dso = dsos[i];
+	for (unsigned int i = 0; i < dsos->cnt; i++) {
+		struct dso *dso = dsos->dsos[i];
 
 		dso__data_close(dso);
 		unlink(dso__name(dso));
-		dso__put(dso);
 	}
-
-	free(dsos);
+	dsos__exit(dsos);
 }
 
 static int set_fd_limit(int n)
@@ -267,10 +264,10 @@ static int test__dso_data_cache(struct test_suite *test __maybe_unused, int subt
 	/* and this is now our dso open FDs limit */
 	dso_cnt = limit / 2;
 	TEST_ASSERT_VAL("failed to create dsos\n",
-		!dsos__create(dso_cnt, TEST_FILE_SIZE));
+			!dsos__create(dso_cnt, TEST_FILE_SIZE, &machine.dsos));
 
 	for (i = 0; i < (dso_cnt - 1); i++) {
-		struct dso *dso = dsos[i];
+		struct dso *dso = machine.dsos.dsos[i];
 
 		/*
 		 * Open dsos via dso__data_fd(), it opens the data
@@ -290,17 +287,17 @@ static int test__dso_data_cache(struct test_suite *test __maybe_unused, int subt
 	}
 
 	/* verify the first one is already open */
-	TEST_ASSERT_VAL("dsos[0] is not open", dso__data(dsos[0])->fd != -1);
+	TEST_ASSERT_VAL("dsos[0] is not open", dso__data(machine.dsos.dsos[0])->fd != -1);
 
 	/* open +1 dso to reach the allowed limit */
-	fd = dso__data_fd(dsos[i], &machine);
+	fd = dso__data_fd(machine.dsos.dsos[i], &machine);
 	TEST_ASSERT_VAL("failed to get fd", fd > 0);
 
 	/* should force the first one to be closed */
-	TEST_ASSERT_VAL("failed to close dsos[0]", dso__data(dsos[0])->fd == -1);
+	TEST_ASSERT_VAL("failed to close dsos[0]", dso__data(machine.dsos.dsos[0])->fd == -1);
 
 	/* cleanup everything */
-	dsos__delete(dso_cnt);
+	dsos__delete(&machine.dsos);
 
 	/* Make sure we did not leak any file descriptor. */
 	nr_end = open_files_cnt();
@@ -325,9 +322,9 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
 	long nr_end, nr = open_files_cnt(), lim = new_limit(3);
 	int fd, fd_extra;
 
-#define dso_0 (dsos[0])
-#define dso_1 (dsos[1])
-#define dso_2 (dsos[2])
+#define dso_0 (machine.dsos.dsos[0])
+#define dso_1 (machine.dsos.dsos[1])
+#define dso_2 (machine.dsos.dsos[2])
 
 	/* Rest the internal dso open counter limit. */
 	reset_fd_limit();
@@ -347,7 +344,8 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
 	TEST_ASSERT_VAL("failed to set file limit",
 			!set_fd_limit((lim)));
 
-	TEST_ASSERT_VAL("failed to create dsos\n", !dsos__create(3, TEST_FILE_SIZE));
+	TEST_ASSERT_VAL("failed to create dsos\n",
+			!dsos__create(3, TEST_FILE_SIZE, &machine.dsos));
 
 	/* open dso_0 */
 	fd = dso__data_fd(dso_0, &machine);
@@ -386,7 +384,7 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
 
 	/* cleanup everything */
 	close(fd_extra);
-	dsos__delete(3);
+	dsos__delete(&machine.dsos);
 
 	/* Make sure we did not leak any file descriptor. */
 	nr_end = open_files_cnt();
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 27db65e96e04..dde706b71da7 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -497,14 +497,20 @@ static pthread_mutex_t dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;
 static void dso__list_add(struct dso *dso)
 {
 	list_add_tail(&dso__data(dso)->open_entry, &dso__data_open);
+#ifdef REFCNT_CHECKING
 	dso__data(dso)->dso = dso__get(dso);
+#endif
+	/* Assume the dso is part of dsos, hence the optional reference count above. */
+	assert(dso__dsos(dso));
 	dso__data_open_cnt++;
 }
 
 static void dso__list_del(struct dso *dso)
 {
 	list_del_init(&dso__data(dso)->open_entry);
+#ifdef REFCNT_CHECKING
 	dso__put(dso__data(dso)->dso);
+#endif
 	WARN_ONCE(dso__data_open_cnt <= 0,
 		  "DSO data fd counter out of bounds.");
 	dso__data_open_cnt--;
@@ -654,9 +660,15 @@ static void close_dso(struct dso *dso)
 static void close_first_dso(void)
 {
 	struct dso_data *dso_data;
+	struct dso *dso;
 
 	dso_data = list_first_entry(&dso__data_open, struct dso_data, open_entry);
-	close_dso(dso_data->dso);
+#ifdef REFCNT_CHECKING
+	dso = dso_data->dso;
+#else
+	dso = container_of(dso_data, struct dso, data);
+#endif
+	close_dso(dso);
 }
 
 static rlim_t get_fd_limit(void)
@@ -1449,7 +1461,9 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
 		data->fd = -1;
 		data->status = DSO_DATA_STATUS_UNKNOWN;
 		INIT_LIST_HEAD(&data->open_entry);
+#ifdef REFCNT_CHECKING
 		data->dso = NULL; /* Set when on the open_entry list. */
+#endif
 	}
 	return res;
 }
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index f9689dd60de3..df2c98402af3 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -147,7 +147,9 @@ struct dso_cache {
 struct dso_data {
 	struct rb_root	 cache;
 	struct list_head open_entry;
+#ifdef REFCNT_CHECKING
 	struct dso	 *dso;
+#endif
 	int		 fd;
 	int		 status;
 	u32		 status_seen;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


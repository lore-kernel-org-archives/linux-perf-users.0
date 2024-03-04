Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D478B67
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Mar 2024 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577374; cv=none; b=iLF9btBwvr9ITIenfIha44Ket+qn33gvN5f0tG8Vw0YUQSEj4XNXqoqzSqVabvlXU+kQ628RNttkTBayCVToSRqdpxD1+gRir30ufGdprLwN1Y9YzXM3aVIeCrm3HQaXVR+nu0LW5LYIsYXalcDHbQ2D7hAna1oRhaaaR12AmR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577374; c=relaxed/simple;
	bh=ZNEyMbGlc7ADwH1owJZ+Sxw7yiz9S/X/DtJym0gLUzg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PAaKaM6ChllVyCukRifrr140Yzve+szBYTciTuYnLZMD0a/81UUu7vaZFmqtAqICr2uxRTRp98ZzJCD8kxyLrQALkNYvqwAad/H7wOi0HoSJfDgYSfae19FOAT3t5omUAT0DkgM6j3CKne8jNh0Oit16fJp5bfeXG9NXjSyXRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I0uEmnyk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0uEmnyk"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609a14c450cso25910847b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Mar 2024 10:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709577371; x=1710182171; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMCtmsHHWzj+nCB+qGi1aEI9xzFTq2saOyDsSSh7ncs=;
        b=I0uEmnyk6luF6a8i322vJT2wBpYARVaUDEdjUu/T2F1ttVB0iaGaCMOUaI/nohqcW1
         6iMibtRWpG9Uzf9bE1wFWiI2Qf8VQskv+4+dNFgnkhOQ/YKl8bSQ3f1zWH/PJDkvCzrQ
         w7g0DfbzyoQT8C1cieYvVRoiTkAZhOue4+4r9WlDwD62GYjTOYxBpto9J/FB8W8ug/f/
         uNJHHqLwjzVXAAHR3IU20mD5OfUTaZXg6wb8OMBTth7A8jxgzM6X8pWBSPtzx89MCbh7
         H6jUjZfvKWlLdZx9/qbAGxv1hITy2giBOPKPU+h6UyXFJdvH3IdBkyAR+/MoqpV2DK3Z
         6v6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577371; x=1710182171;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMCtmsHHWzj+nCB+qGi1aEI9xzFTq2saOyDsSSh7ncs=;
        b=Z9fYgL97F9VtWvGnCLRN2zewd897luX/vKDxN7utnIZ2UNGfRdFMs+oV5DEEPOlUgC
         tagXNqWZl9/12HPYo6bryIE0BCKtsTFvRPgEvHspgID63Gq7zB4sSr22L4ngvSxYlpv2
         6qnD9x5Sl7t4Vau6Vm5uSfeOelcfNAKnOiCVDJakamRPFiwBw8lcDR7bMPRj3CImu0XO
         7PJsN2KzyHpngNRbYoS5e930q1XL3GWcqS9aulOpGdmXVjVnZ9ekGLUO1yfpAce++I3a
         nxOa1xVqAmfBs8VoLVIWNOmC1hMwRWq4fzmATRFm89yFt/q8+cocUVdCY5VGz+sbnjap
         g49A==
X-Forwarded-Encrypted: i=1; AJvYcCUZQfwb1j0snvnKTNyhboYSOl3Y3W69z8m6kRSH2fLFrnvZ6o2bczFyj1jk9W0zut4BjavA6iUtSIW7py09tbPOn8Lz9aUPGHZX4h+DE6FOPw==
X-Gm-Message-State: AOJu0YwmT9X2KRvBuIuk0527yckywa2bw4uLHU3VEx8bdTLXBcyQ+RkL
	bgwxqSicSNCEzJyHLpNOWn8fdCZC573uqk0G2tSBkIjuFZ9zYwFonjhQ9xNpk0vUKmPTaJNopq/
	8oVoIFQ==
X-Google-Smtp-Source: AGHT+IHUzgIOoIbg9GsSzeWgrDeclg2POepnhIUtSBC4WvRZvgxFRwFbfHnGlsqOCcZQm/FN8iYsFbOwbx+8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:38b7:9cbf:f246:dafb])
 (user=irogers job=sendgmr) by 2002:a05:690c:ecc:b0:608:ecf3:ef8 with SMTP id
 cs12-20020a05690c0ecc00b00608ecf30ef8mr2241121ywb.0.1709577371460; Mon, 04
 Mar 2024 10:36:11 -0800 (PST)
Date: Mon,  4 Mar 2024 10:35:24 -0800
In-Reply-To: <20240304183525.3222581-1-irogers@google.com>
Message-Id: <20240304183525.3222581-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304183525.3222581-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 13/13] perf dso: Use container_of to avoid a pointer in dso_data
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linaro.org>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, German Gomez <german.gomez@arm.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
index ddf58f594df0..83de99e52141 100644
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
@@ -1448,7 +1460,9 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
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
index 3e27f93898f2..3311c1740840 100644
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
2.44.0.278.ge034bb2e1d-goog


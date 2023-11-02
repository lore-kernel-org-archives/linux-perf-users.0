Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96B2110F
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5l2MyO9"
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B64026BB
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 11:08:37 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6bd00edc63fso1347397b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698948469; x=1699553269; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/Jhn6xCbnHiyHqsQ6OV87Jm0NhFFz3VxLu59mRjmOo=;
        b=b5l2MyO9Q9cBOJ3Xr9mr6LuG1GVYBOrh2/cCX5jSn/M0SqYSQSegH5foZI80aesUUf
         kXtwXVcR5CT4x7YZyUazt5EKzVvEPeHTSaUswhDGd8n5sLak8p3Asuavsgrtsy7fWEPs
         ZKhdJv+/8jfeCcr4+0MYEVrq6E9lZ778d49/pxkw8D3y3KNMrcu8z/Ien0alkd+rwUO5
         BMTdovSAVNKd7aAu9xJsHlnr/TtQpzVDlBIpvTx8Jlmq+MIeXUmQNSmB+LlorEeaE3kT
         cMgBEBX7RdF5COM7juprQo5iTLLPTU9iNDRfP1qzx3HlptpWbq9xaZNKAs+4ZDx0unMi
         6tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948469; x=1699553269;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/Jhn6xCbnHiyHqsQ6OV87Jm0NhFFz3VxLu59mRjmOo=;
        b=dcnQ23bhqyaevk5e2h7TpgD3+Ve4O5XdZYjjMJLRjDGxJtWnyZdi9ZIdemE+BiJSQR
         yTjuV15Cmsktf6ugZqy0fHPM8auk8l+uF7MerOmCZ8bG+exB0bVb2ZmWpfOw+z4gebdS
         40b99XUlk3eeWhzgUaYZye4q5lRqVLHaIUgAdEaVZaHTab7tOdHHp5lVOqsTSChilOyU
         B9hWbobMqNTQ9xVG36VEZtm7piKcG2Qb0CugEyO3o69nzGYOnRqACeP1aeGq3G09dWXw
         RYe9psCK4Yx+0BgLceHiPv1w1kIk98PBKzQHcS2Ssmw+zvKfOE2cjZJoxN9RP54wEm2C
         UWaQ==
X-Gm-Message-State: AOJu0Yyr+9+nSuj2NKp6G0e2jwwR4SGDpQPqzkepJ5Gw8/GzgtpgFHOM
	/GZWLDR23nDw/670YS99QDssaSZ66c1G
X-Google-Smtp-Source: AGHT+IHKRimVvW9Gc5ppSWymmlZLia/1LH20efwMMAIlHREO1ygr7qpw4/HaUdfDqHhi5lGC4Iy4P1B5uVR1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:5046:0:b0:da0:433e:871d with SMTP id
 e67-20020a255046000000b00da0433e871dmr325587ybb.7.1698947995138; Thu, 02 Nov
 2023 10:59:55 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:57:34 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-53-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 52/53] perf dso: Use container_of to avoid a pointer in dso_data
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
 tools/perf/tests/dso-data.c | 56 +++++++++++++++++--------------------
 tools/perf/util/dso.c       | 16 ++++++++++-
 tools/perf/util/dso.h       |  2 ++
 3 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 625dbb2ffe8a..e5018d390763 100644
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
@@ -199,41 +202,31 @@ static long open_files_cnt(void)
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
+		char *file = test_file(size);
 
-		file = test_file(size);
 		TEST_ASSERT_VAL("failed to get dso file", file);
-
-		dsos[i] = dso__new(file);
-		TEST_ASSERT_VAL("failed to get dso", dsos[i]);
+		TEST_ASSERT_VAL("failed to get dso", !dsos__add(dsos, dso__new(file)));
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
@@ -267,10 +260,10 @@ static int test__dso_data_cache(struct test_suite *test __maybe_unused, int subt
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
@@ -290,17 +283,17 @@ static int test__dso_data_cache(struct test_suite *test __maybe_unused, int subt
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
@@ -325,9 +318,9 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
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
@@ -347,7 +340,8 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
 	TEST_ASSERT_VAL("failed to set file limit",
 			!set_fd_limit((lim)));
 
-	TEST_ASSERT_VAL("failed to create dsos\n", !dsos__create(3, TEST_FILE_SIZE));
+	TEST_ASSERT_VAL("failed to create dsos\n",
+			!dsos__create(3, TEST_FILE_SIZE, &machine.dsos));
 
 	/* open dso_0 */
 	fd = dso__data_fd(dso_0, &machine);
@@ -386,7 +380,7 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
 
 	/* cleanup everything */
 	close(fd_extra);
-	dsos__delete(3);
+	dsos__delete(&machine.dsos);
 
 	/* Make sure we did not leak any file descriptor. */
 	nr_end = open_files_cnt();
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 0fef597725c7..4f20dac89b77 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -496,14 +496,20 @@ static pthread_mutex_t dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;
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
@@ -653,9 +659,15 @@ static void close_dso(struct dso *dso)
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
@@ -1444,7 +1456,9 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
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
index fa311ffd2538..e02a4718f1f8 100644
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
2.42.0.869.gea05f2083d-goog


Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC182E975B
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791818; cv=none; b=EnBhcaIQ4OnZrRqt0nW+O9ifB9Ee0Jp1KRUQyxth1HlrPAKkAyPHhclNu/19DauPk6kl6S//nm0gflPt8lunZDG/uzxauwz0WmdenkuVhzdvv83SXdwMUvJrG7tgfxeOHdI7pH8Vw9Cw3AoiM6B+vb/t7KBxlz2J5aB2XhMwt1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791818; c=relaxed/simple;
	bh=ktXu6VcAdkGJ2v1xOhOgufhv3qxhgg3zbylT0vutCvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tBT6nvHPVpxo+k4TcFKukqtguYmX4j9c2McQnARWTegn223Fa/aublR61Jy3qF/j/LdAQFr82hcos0u8iKWNtoHxbmrDH4hvgQXbu66qtaYwnFbLK6KqWHFOR7B8evzM0jP7phIpPhmZWXN7G8vzpRP/m8dwoce4oWMKN8QC/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xKmvhRRa; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xKmvhRRa"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748fd21468cso451453b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750791816; x=1751396616; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afW80ZcEEJPE1ltr0EmfHWGXUQF1oWc8ptVOF2S/Uts=;
        b=xKmvhRRa66vrJMPgD8+9E/ld2Ij4Inbzc4+fHidIpoHpwaJS7k7AgorQvIsBSC2X6x
         PVADmIyQpHz8oAaPPF1keB3fF38j1c6b0gsKaMm5DS35TTHr8syuhzISGZnSQk90r2Js
         esh6bPYZK1krSzNizhYi7Z+IN9KpX1DERReG1oiYEUq5pmo+fLW5BusFf76q8LhDqyZX
         WilrGyumzDLExLzUKXp2Zv2cZ8RvOQ3z58ad5V6miAbEsKMLKrWxqdzlTLS29KC0Iah8
         lL5IHNnPBB9zgsz10zhf6Bwib47RfdhrEY2lJPurEp2+xT13wjuW5OMDlZN90XLV3qT5
         Z7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750791816; x=1751396616;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afW80ZcEEJPE1ltr0EmfHWGXUQF1oWc8ptVOF2S/Uts=;
        b=kChtg6UYJmXf/6MNdGxmzM5zUT8Y0K2gfms/dDxGub5aF2fqbIgP0wlIyuLQ5JVXeU
         NFAidqooUPiW6HhQwCVMUUs2OC3j2kg/ITogWX0Qng/HTJu5tR6L7qPQeMzVLz54OLyb
         prcPLEIUodHcl6/Zw6qjOeNu8k/2BJsTep1Az9cnqJ/2f8lNdZGBkrF6GtIVM3bEptVf
         IV79+krZtG31UZvl2NW/EU95H9wCLdrol38XSZayVG5NsDd0qo+MIAphI0JXQS9d55go
         z9fNT3cegi1xVp9o7TvRqphBrEvn9NM8iBFuMRQ4CDk9QB4c+KaUDCW0FbHmAvqctSqZ
         wntg==
X-Forwarded-Encrypted: i=1; AJvYcCXgYE3bgMteG8Tt3roKgDUZ8WjggItk9EF512WR9fS+UlpbJJ3dacNzuGG3i2W9rYGZRATX9FU/n/hsCdz6WjUd@vger.kernel.org
X-Gm-Message-State: AOJu0YypvV72aO6UqLHi6HD3guKlatkKB/f2t26/+m9t57yLg75v2sgx
	UTrboHdFvZGvhVaMb0eZWoUXCul+OXkfgu6Y/ICGJVhfHHiyUibPyG+F0uamPEUeOleCNZda+xc
	EftEZBkprlg==
X-Google-Smtp-Source: AGHT+IGO41J2m+KRVvAkZqtaf/fDEU02WT3KsOZvnS1GIfQ/BtppdtfGOoQgWLRf6EMpLFJFzoEGCm7POlSL
X-Received: from pfbha5.prod.google.com ([2002:a05:6a00:8505:b0:748:df52:fdc5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:391a:b0:737:9b:582a
 with SMTP id d2e1a72fcca58-74ad4546a08mr383375b3a.24.1750791816273; Tue, 24
 Jun 2025 12:03:36 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:03:23 -0700
In-Reply-To: <20250624190326.2038704-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624190326.2038704-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250624190326.2038704-4-irogers@google.com>
Subject: [PATCH v1 3/5] perf hwmon_pmu: Hold path rather than fd
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hold the path to the hwmon_pmu rather than the file descriptor. The
file descriptor is somewhat problematic in that it reflects the
directory state when opened, something that may vary in testing. Using
a path simplifies testing and to some extent cleanup as the hwmon_pmu
is owned by the pmus list and intentionally global and leaked when
perf terminates, the file descriptor being left open looks like a
leak.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/hwmon_pmu.c | 11 ++++++-----
 tools/perf/util/hwmon_pmu.c  | 38 ++++++++++++++++++++++++++----------
 tools/perf/util/hwmon_pmu.h  |  4 ++--
 tools/perf/util/pmus.c       |  2 +-
 tools/perf/util/pmus.h       |  2 +-
 5 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index 0837aca1cdfa..151f02701c8c 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -93,9 +93,10 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 		pr_err("Failed to mkdir hwmon directory\n");
 		goto err_out;
 	}
-	hwmon_dirfd = openat(test_dirfd, "hwmon1234", O_DIRECTORY);
+	strncat(dir, "/hwmon1234", sz - strlen(dir));
+	hwmon_dirfd = open(dir, O_PATH|O_DIRECTORY);
 	if (hwmon_dirfd < 0) {
-		pr_err("Failed to open test hwmon directory \"%s/hwmon1234\"\n", dir);
+		pr_err("Failed to open test hwmon directory \"%s\"\n", dir);
 		goto err_out;
 	}
 	file = openat(hwmon_dirfd, "name", O_WRONLY | O_CREAT, 0600);
@@ -130,18 +131,18 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 	}
 
 	/* Make the PMU reading the files created above. */
-	hwm = perf_pmus__add_test_hwmon_pmu(hwmon_dirfd, "hwmon1234", test_hwmon_name);
+	hwm = perf_pmus__add_test_hwmon_pmu(dir, "hwmon1234", test_hwmon_name);
 	if (!hwm)
 		pr_err("Test hwmon creation failed\n");
 
 err_out:
 	if (!hwm) {
 		test_pmu_put(dir, hwm);
-		if (hwmon_dirfd >= 0)
-			close(hwmon_dirfd);
 	}
 	if (test_dirfd >= 0)
 		close(test_dirfd);
+	if (hwmon_dirfd >= 0)
+		close(hwmon_dirfd);
 	return hwm;
 }
 
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index c25e7296f1c1..7edda010ba27 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -104,7 +104,7 @@ static const char *const hwmon_units[HWMON_TYPE_MAX] = {
 struct hwmon_pmu {
 	struct perf_pmu pmu;
 	struct hashmap events;
-	int hwmon_dir_fd;
+	char *hwmon_dir;
 };
 
 /**
@@ -245,7 +245,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 		return 0;
 
 	/* Use openat so that the directory contents are refreshed. */
-	io_dir__init(&dir, openat(pmu->hwmon_dir_fd, ".", O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	io_dir__init(&dir, open(pmu->hwmon_dir, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
 
 	if (dir.dirfd < 0)
 		return -ENOENT;
@@ -283,7 +283,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 		__set_bit(item, alarm ? value->alarm_items : value->items);
 		if (item == HWMON_ITEM_LABEL) {
 			char buf[128];
-			int fd = openat(pmu->hwmon_dir_fd, ent->d_name, O_RDONLY);
+			int fd = openat(dir.dirfd, ent->d_name, O_RDONLY);
 			ssize_t read_len;
 
 			if (fd < 0)
@@ -342,7 +342,8 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 	return err;
 }
 
-struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir, const char *sysfs_name, const char *name)
+struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, const char *hwmon_dir,
+				const char *sysfs_name, const char *name)
 {
 	char buf[32];
 	struct hwmon_pmu *hwm;
@@ -365,7 +366,11 @@ struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir, const cha
 		return NULL;
 	}
 
-	hwm->hwmon_dir_fd = hwmon_dir;
+	hwm->hwmon_dir = strdup(hwmon_dir);
+	if (!hwm->hwmon_dir) {
+		perf_pmu__delete(&hwm->pmu);
+		return NULL;
+	}
 	hwm->pmu.alias_name = strdup(sysfs_name);
 	if (!hwm->pmu.alias_name) {
 		perf_pmu__delete(&hwm->pmu);
@@ -399,7 +404,7 @@ void hwmon_pmu__exit(struct perf_pmu *pmu)
 		free(value);
 	}
 	hashmap__clear(&hwm->events);
-	close(hwm->hwmon_dir_fd);
+	zfree(&hwm->hwmon_dir);
 }
 
 static size_t hwmon_pmu__describe_items(struct hwmon_pmu *hwm, char *out_buf, size_t out_buf_len,
@@ -409,6 +414,10 @@ static size_t hwmon_pmu__describe_items(struct hwmon_pmu *hwm, char *out_buf, si
 	size_t bit;
 	char buf[64];
 	size_t len = 0;
+	int dir = open(hwm->hwmon_dir, O_CLOEXEC | O_DIRECTORY | O_RDONLY);
+
+	if (dir < 0)
+		return 0;
 
 	for_each_set_bit(bit, items, HWMON_ITEM__MAX) {
 		int fd;
@@ -421,7 +430,7 @@ static size_t hwmon_pmu__describe_items(struct hwmon_pmu *hwm, char *out_buf, si
 			key.num,
 			hwmon_item_strs[bit],
 			is_alarm ? "_alarm" : "");
-		fd = openat(hwm->hwmon_dir_fd, buf, O_RDONLY);
+		fd = openat(dir, buf, O_RDONLY);
 		if (fd > 0) {
 			ssize_t read_len = read(fd, buf, sizeof(buf));
 
@@ -443,6 +452,7 @@ static size_t hwmon_pmu__describe_items(struct hwmon_pmu *hwm, char *out_buf, si
 			close(fd);
 		}
 	}
+	close(dir);
 	return len;
 }
 
@@ -712,6 +722,7 @@ int perf_pmus__read_hwmon_pmus(struct list_head *pmus)
 		size_t line_len;
 		int hwmon_dir, name_fd;
 		struct io io;
+		char buf2[128];
 
 		if (class_hwmon_ent->d_type != DT_LNK)
 			continue;
@@ -730,12 +741,13 @@ int perf_pmus__read_hwmon_pmus(struct list_head *pmus)
 			close(hwmon_dir);
 			continue;
 		}
-		io__init(&io, name_fd, buf, sizeof(buf));
+		io__init(&io, name_fd, buf2, sizeof(buf2));
 		io__getline(&io, &line, &line_len);
 		if (line_len > 0 && line[line_len - 1] == '\n')
 			line[line_len - 1] = '\0';
-		hwmon_pmu__new(pmus, hwmon_dir, class_hwmon_ent->d_name, line);
+		hwmon_pmu__new(pmus, buf, class_hwmon_ent->d_name, line);
 		close(name_fd);
+		close(hwmon_dir);
 	}
 	free(line);
 	close(class_hwmon_dir.dirfd);
@@ -753,6 +765,10 @@ int evsel__hwmon_pmu_open(struct evsel *evsel,
 		.type_and_num = evsel->core.attr.config,
 	};
 	int idx = 0, thread = 0, nthreads, err = 0;
+	int dir = open(hwm->hwmon_dir, O_CLOEXEC | O_DIRECTORY | O_RDONLY);
+
+	if (dir < 0)
+		return -errno;
 
 	nthreads = perf_thread_map__nr(threads);
 	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
@@ -763,7 +779,7 @@ int evsel__hwmon_pmu_open(struct evsel *evsel,
 			snprintf(buf, sizeof(buf), "%s%d_input",
 				 hwmon_type_strs[key.type], key.num);
 
-			fd = openat(hwm->hwmon_dir_fd, buf, O_RDONLY);
+			fd = openat(dir, buf, O_RDONLY);
 			FD(evsel, idx, thread) = fd;
 			if (fd < 0) {
 				err = -errno;
@@ -771,6 +787,7 @@ int evsel__hwmon_pmu_open(struct evsel *evsel,
 			}
 		}
 	}
+	close(dir);
 	return 0;
 out_close:
 	if (err)
@@ -784,6 +801,7 @@ int evsel__hwmon_pmu_open(struct evsel *evsel,
 		}
 		thread = nthreads;
 	} while (--idx >= 0);
+	close(dir);
 	return err;
 }
 
diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
index b3329774d2b2..dc711b289ff5 100644
--- a/tools/perf/util/hwmon_pmu.h
+++ b/tools/perf/util/hwmon_pmu.h
@@ -135,14 +135,14 @@ bool parse_hwmon_filename(const char *filename,
  * hwmon_pmu__new() - Allocate and construct a hwmon PMU.
  *
  * @pmus: The list of PMUs to be added to.
- * @hwmon_dir: An O_DIRECTORY file descriptor for a hwmon directory.
+ * @hwmon_dir: The path to a hwmon directory.
  * @sysfs_name: Name of the hwmon sysfs directory like hwmon0.
  * @name: The contents of the "name" file in the hwmon directory.
  *
  * Exposed for testing. Regular construction should happen via
  * perf_pmus__read_hwmon_pmus.
  */
-struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir,
+struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, const char *hwmon_dir,
 				const char *sysfs_name, const char *name);
 void hwmon_pmu__exit(struct perf_pmu *pmu);
 
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3bbd26fec78a..eed8d8005cff 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -762,7 +762,7 @@ struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name)
 	return perf_pmu__lookup(&other_pmus, test_sysfs_dirfd, name, /*eager_load=*/true);
 }
 
-struct perf_pmu *perf_pmus__add_test_hwmon_pmu(int hwmon_dir,
+struct perf_pmu *perf_pmus__add_test_hwmon_pmu(const char *hwmon_dir,
 					       const char *sysfs_name,
 					       const char *name)
 {
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 8def20e615ad..d5140804a630 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -29,7 +29,7 @@ int perf_pmus__num_core_pmus(void);
 bool perf_pmus__supports_extended_type(void);
 
 struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name);
-struct perf_pmu *perf_pmus__add_test_hwmon_pmu(int hwmon_dir,
+struct perf_pmu *perf_pmus__add_test_hwmon_pmu(const char *hwmon_dir,
 					       const char *sysfs_name,
 					       const char *name);
 struct perf_pmu *perf_pmus__fake_pmu(void);
-- 
2.50.0.714.g196bf9f422-goog


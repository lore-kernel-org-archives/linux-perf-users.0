Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720F1D8A16
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970701; cv=none; b=aLwIHP5Flkgj9Tj+08v7+OfF5aGalXwYgla8CU0oqf3/hwVzJ5meR0r3G/3lHwWQVmO0jx20rP9uJuTrG47R5Muz+Q0KJ/YQzAQPdZwtlQBEKvHcptiLroUcZ+BqqQ6V40GvLe/CvC/xfScdpmS2HNtfISBXTcAi7sTJ6nsPVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970701; c=relaxed/simple;
	bh=ElWenOyfvaucerfCny5mEDKaWfo6X8s3yJAt0bwuZO0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oPlJ1GeI0Tczo/SmkWMs+PJPhxkyvJmcCOJh5BJbHJwc15SxKoKK8gwvsVU/W3bbGotLObPwIFk+LxSy3fUpH/1toC746NhhHVajrH05WhU4zdrO+y2qeTLI60LDTgPc8syyKzi29Br/AbYYftkneVtMmiozhvscSw96HCCjhu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BLiaoEYq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BLiaoEYq"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5b48736dcfso1749361276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 15:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738970698; x=1739575498; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5W/64OKdjEHEkY7BmxbGDOrXjI8zGvJwzbQ9pnE/HiI=;
        b=BLiaoEYqbS6vJ8bzVhDUsHQq5Y1g/9My7CyszTub7pcLEF50MqnAZYtUXGoXElK+gK
         fMdrM3bhkakCw631W9UHgmbgXR3CAk9MTnDb3bbx/+updGA/G8rKftAfMHCIFo220TZx
         TJWAX31bdjtg3eqhoVJxGE18LDuJc6lcBre5edGNh5Tjn7weJYFxCq7pKx8saWKkmemz
         E9djRK/YQ/yA4wcAqixW2BZJWsDhCKhFB9Q0Ao0A//dG0mi+RY93AGeS6eI/SJJ6mf8z
         d5Mr6ab3CqbFL8S+jLkxYII/7P+6svbNSbU1wsDZsoaTh98nvD1vkQ4BoNwQUWAWdMM7
         LAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738970698; x=1739575498;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5W/64OKdjEHEkY7BmxbGDOrXjI8zGvJwzbQ9pnE/HiI=;
        b=gXVlFmVHUCf0hdUZ5Sp4Sz+wJrMAS5t13Pqjv1bgE1SyjkNPmgrbad2I8SGp/ZmIMo
         xFqvgG3m7tKQ5tspgjSK12JvgJcrv/dWADaezWA7MsCXuMNEBj7CZ23ty0tFi8Wgt3xM
         jAYX4pmBf+64qt8QsFXbF4F8AFZYP143LwPYFGYj1nZZPB8BiLwTBvKMWx8DSbOZMHJE
         Wof+5D5qBdhUONQzK/BjtR3FzauxAo1cnBF5cW8p3hRTYgNE1Ush0EoSJukZ09+AlhLx
         mvqIZQ4mtQ7QuFmK7ya6qzv1hA8VwWvMl1iDkzNF0LVwR476Jt9gFuL2EfUzkXx/LvRB
         jBsg==
X-Forwarded-Encrypted: i=1; AJvYcCWRP+ZHjEVLTpoTZbv3qSy2Gn2QD+ljqsHH1+v+smBXvIrFU/tdp1s2I0kctQFpi57ttXljRTGeR+0m42+fxWwJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwnAvk+UM6CAgEGL8TsiE47Phg91nSo1LLaviyipR4mp6L9AwFC
	cdEZ+e5QkQiudYdKvUqn4w/3ejKZF4U4UPnn5lJdApmKGU+pIYYANA3wWoWd2K+TYhHNoCIWDoO
	ZI7tA7A==
X-Google-Smtp-Source: AGHT+IE6ysQvWeGLDwktkI386nBL83Kpeyvrn6R1QrqV1e8oodaSQ2vxtnD60YGacTEEgesF2jQk8jzy/LsC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:79e4:4a45:1e80:ace5])
 (user=irogers job=sendgmr) by 2002:a25:c1c2:0:b0:e57:3500:2294 with SMTP id
 3f1490d57ef6-e5b4618c4b0mr33944276.3.1738970698544; Fri, 07 Feb 2025 15:24:58
 -0800 (PST)
Date: Fri,  7 Feb 2025 15:24:42 -0800
In-Reply-To: <20250207232452.994822-1-irogers@google.com>
Message-Id: <20250207232452.994822-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207232452.994822-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v2 1/7] tools lib api: Add io_dir an allocation free readdir alternative
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sam James <sam@gentoo.org>, 
	Jesper Juhl <jesperjuhl76@gmail.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"

glibc's opendir allocates a minimum of 32kb, when called recursively
for a directory tree the memory consumption can add up - nearly 300kb
during perf start-up when processing modules. Add a stack allocated
variant of readdir sized a little more than 1kb.

As getdents64 may be missing from libc, add support using syscall.
Note, an earlier version of this patch had a feature test for
getdents64 but there were problems on certains distros where
getdents64 would be #define renamed to getdents breaking the code. The
syscall use was made uncondtional to work around this. There is
context in:
https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile |  2 +-
 tools/lib/api/io_dir.h | 93 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/api/io_dir.h

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 7f6396087b46..8665c799e0fa 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -95,7 +95,7 @@ install_lib: $(LIBFILE)
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
-HDRS := cpu.h debug.h io.h
+HDRS := cpu.h debug.h io.h io_dir.h
 FD_HDRS := fd/array.h
 FS_HDRS := fs/fs.h fs/tracing_path.h
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/api
diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
new file mode 100644
index 000000000000..c84738923c96
--- /dev/null
+++ b/tools/lib/api/io_dir.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/*
+ * Lightweight directory reading library.
+ */
+#ifndef __API_IO_DIR__
+#define __API_IO_DIR__
+
+#include <dirent.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+
+#if !defined(SYS_getdents64)
+#if defined(__x86_64__)
+#define SYS_getdents64 217
+#elif defined(__aarch64__)
+#define SYS_getdents64 61
+#endif
+#endif
+
+static inline ssize_t perf_getdents64(int fd, void *dirp, size_t count)
+{
+#ifdef MEMORY_SANITIZER
+	memset(dirp, 0, count);
+#endif
+	return syscall(SYS_getdents64, fd, dirp, count);
+}
+#endif
+
+struct io_dirent64 {
+	ino64_t        d_ino;    /* 64-bit inode number */
+	off64_t        d_off;    /* 64-bit offset to next structure */
+	unsigned short d_reclen; /* Size of this dirent */
+	unsigned char  d_type;   /* File type */
+	char           d_name[NAME_MAX + 1]; /* Filename (null-terminated) */
+};
+
+struct io_dir {
+	int dirfd;
+	ssize_t available_bytes;
+	struct io_dirent64 *next;
+	struct io_dirent64 buff[4];
+};
+
+static inline void io_dir__init(struct io_dir *iod, int dirfd)
+{
+	iod->dirfd = dirfd;
+	iod->available_bytes = 0;
+}
+
+static inline void io_dir__rewinddir(struct io_dir *iod)
+{
+	lseek(iod->dirfd, 0, SEEK_SET);
+	iod->available_bytes = 0;
+}
+
+static inline struct io_dirent64 *io_dir__readdir(struct io_dir *iod)
+{
+	struct io_dirent64 *entry;
+
+	if (iod->available_bytes <= 0) {
+		ssize_t rc = perf_getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
+
+		if (rc <= 0)
+			return NULL;
+		iod->available_bytes = rc;
+		iod->next = iod->buff;
+	}
+	entry = iod->next;
+	iod->next = (struct io_dirent64 *)((char *)entry + entry->d_reclen);
+	iod->available_bytes -= entry->d_reclen;
+	return entry;
+}
+
+static inline bool io_dir__is_dir(const struct io_dir *iod, struct io_dirent64 *dent)
+{
+	if (dent->d_type == DT_UNKNOWN) {
+		struct stat st;
+
+		if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=*/0))
+			return false;
+
+		if (S_ISDIR(st.st_mode)) {
+			dent->d_type = DT_DIR;
+			return true;
+		}
+	}
+	return dent->d_type == DT_DIR;
+}
+
+#endif
-- 
2.48.1.502.g6dc24dfdaf-goog


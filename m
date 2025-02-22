Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FDA1F8ADB
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Feb 2025 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740204628; cv=none; b=gY9OTgaQidCGzRFgVNvXo3a2rbJ5lcdCnsUIiSfSlTzHTLYlvu100P54z2aSI8BMy2tawRRHpEUzjDGahNiW0gkvxPMvVOGUyHiT5xRwSg/7Ali9tgKV6K9qYmBcxu3CMmU2Wc7iutSrA8KhVOF+wmj8o6Sd/i/hyWSEp1wU1xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740204628; c=relaxed/simple;
	bh=JlhCie1KVGPxky6hLFrhYmegSBkXKTMJ+o4py22ZdJY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=VAAtjZY/p6LHxO9tgDbLfe9o0Hc0voT1n4CLroPrDjo8ewndIaQyem82Z5ojKmBKAzIwXJZWI1VVvrZOzztEv31x6qrT9xnjvM/qTltRLQ2SqK1b/xXFL+7ZCZNZGGlY3SyO9IAL4ZScCUjnA79c+4flygX2x68eGp0/abrNJjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNAvZlvf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNAvZlvf"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5dca677776so3515552276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Feb 2025 22:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740204626; x=1740809426; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/7ZX9JhDgLMSQLTzuNEs8rLWBMeKnvwebReBgtVAUg=;
        b=eNAvZlvf97MojJ1yYbhbYlwMf1BPjiW0yy+gi32S/S/X+Pq9JfRZl4hNZHjTi1LTKt
         QkUgHYL7kgI2R+QBZr8vyHhsrkDM+o2qW3VKhWrgXUEKO4fcqfPDenXxWE7r5WmIpC+G
         5zubFSHjWJsvuCA+JYJuckKV2jXea6bY0srKnkWYqWVMEeetvJHQfalP4QVbHfcXUYV9
         tf9xPJaAJvcmUILSDQYEgGYhylyQQ6H8THwS+bM+7uRIAyWxFDSPPeA+v2ggtg0NNMD4
         Wyd6zPOrU2THp+EVAeAnzyBFxcAqhFj0g0YYR7SY8bRvGCxTkihOV+Kdkj5z8IguLalw
         csfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740204626; x=1740809426;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/7ZX9JhDgLMSQLTzuNEs8rLWBMeKnvwebReBgtVAUg=;
        b=V5ZQ/o2ZlmhnfdbaFuDnc1F/fDcJLXKpYVw882yIXu7Hjo6h7nRNExMUuduxNCvILz
         4VJfXxPxDWUSMjCfBYjpoh3KlnchB0vGsAFyvhJB0Tplxjchp7EwlpdxKZ9Fm84Whfhe
         ur5rZhZhGL+VOUxj/hWx/5lx/XoOv56RHHlMvVPpmuYYhAnkQJNA2eiEEnlnjq6pGOOA
         D0mO/NbJbxLNq/4yGs6ACE6oNeahNQRgQlmas8ou/FjADamNjbuxLHHCxcbISkC/dX9O
         VncdzqCRHPwMB0/LItdTj30JlEghvYbgvczxycG1VkW0OAlzkbuS53nhu0CrdkG/u1GH
         /vZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE8Z1bCzY51iVESqo+Om/a+kqJoSMI4oq3mhC3zNXYBGoyK3Zkjqlf1RPELtww31FujH+2MO3yHuiXu254wqCK@vger.kernel.org
X-Gm-Message-State: AOJu0YyH0IW5tY7SNC6eBGXMFVA73NwQcF+KIr9rKWgPyhXiotZKbsRi
	z8y/kG5QW4l7inlvqRxMH+nQUFs4jQ3a1INRHUQOTUm0Q+jpMuofXwUcJZOZI7F3C2FRhblNkN9
	Z2hd5UA==
X-Google-Smtp-Source: AGHT+IEYFAPRiX8fFmj1juQHrQSqiPZVIrB8A6o/q8ZsWipx0bDxLmVyKrA3nYPlyo25uJmD0bFLmIOqFEoH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5003:3a14:d4e7:121])
 (user=irogers job=sendgmr) by 2002:a25:83d0:0:b0:e48:2ea1:d9ea with SMTP id
 3f1490d57ef6-e5e8b073be9mr28959276.7.1740204625695; Fri, 21 Feb 2025 22:10:25
 -0800 (PST)
Date: Fri, 21 Feb 2025 22:10:06 -0800
In-Reply-To: <20250222061015.303622-1-irogers@google.com>
Message-Id: <20250222061015.303622-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250222061015.303622-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Subject: [PATCH v3 1/8] tools lib api: Add io_dir an allocation free readdir alternative
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sam James <sam@gentoo.org>, Jesper Juhl <jesperjuhl76@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

glibc's opendir allocates a minimum of 32kb, when called recursively
for a directory tree the memory consumption can add up - nearly 300kb
during perf start-up when processing modules. Add a stack allocated
variant of readdir sized a little more than 1kb.

As getdents64 may be missing from libc, add support using syscall. As
the system call number maybe missing, add #defines for those.

Note, an earlier version of this patch had a feature test for
getdents64 but there were problems on certains distros where
getdents64 would be #define renamed to getdents breaking the code. The
syscall use was made uncondtional to work around this. There is
context in:
https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile |   2 +-
 tools/lib/api/io_dir.h | 104 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)
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
index 000000000000..aab73393d2a2
--- /dev/null
+++ b/tools/lib/api/io_dir.h
@@ -0,0 +1,104 @@
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
+#if defined(__x86_64__) || defined(__arm__)
+  #define SYS_getdents64 217
+#elif defined(__i386__) || defined(__s390x__) || defined(__sh__)
+  #define SYS_getdents64 220
+#elif defined(__alpha__)
+  #define SYS_getdents64 377
+#elif defined(__mips__)
+  #define SYS_getdents64 308
+#elif defined(__powerpc64__) || defined(__powerpc__)
+  #define SYS_getdents64 202
+#elif defined(__sparc64__) || defined(__sparc__)
+  #define SYS_getdents64 154
+#elif defined(__xtensa__)
+  #define SYS_getdents64 60
+#else
+  #define SYS_getdents64 61
+#endif
+#endif /* !defined(SYS_getdents64) */
+
+static inline ssize_t perf_getdents64(int fd, void *dirp, size_t count)
+{
+#ifdef MEMORY_SANITIZER
+	memset(dirp, 0, count);
+#endif
+	return syscall(SYS_getdents64, fd, dirp, count);
+}
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
+#endif  /* __API_IO_DIR__ */
-- 
2.48.1.658.g4767266eb4-goog

